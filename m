Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBDE4B55F8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 17:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiBNQVB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 11:21:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356308AbiBNQUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 11:20:49 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AED42EE7;
        Mon, 14 Feb 2022 08:20:41 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jy8Zq6z3gz67Xv4;
        Tue, 15 Feb 2022 00:20:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 14 Feb 2022 17:20:39 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Feb
 2022 16:20:38 +0000
Date:   Mon, 14 Feb 2022 16:20:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 08/14] cxl/region: HB port config verification
Message-ID: <20220214162037.0000104b@Huawei.com>
In-Reply-To: <20220128002707.391076-9-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
        <20220128002707.391076-9-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 27 Jan 2022 16:27:01 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Host bridge root port verification determines if the device ordering in
> an interleave set can be programmed through the host bridges and
> switches.
> 
> The algorithm implemented here is based on the CXL Type 3 Memory Device
> Software Guide, chapter 2.13.15. The current version of the guide does
> not yet support x3 interleave configurations, and so that's not
> supported here either.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>


> +static struct cxl_dport *get_rp(struct cxl_memdev *ep)
> +{
> +	struct cxl_port *port, *parent_port = port = ep->port;
> +	struct cxl_dport *dport;
> +
> +	while (!is_cxl_root(port)) {
> +		parent_port = to_cxl_port(port->dev.parent);
> +		if (parent_port->depth == 1)
> +			list_for_each_entry(dport, &parent_port->dports, list)
> +				if (dport->dport == port->uport->parent->parent)
> +					return dport;
> +		port = parent_port;
> +	}
> +
> +	BUG();

I know you mentioned you were reworking this patch set anyway, but
I thought I'd give some quick debugging related feedback.

When running against a single switch in qemu (patches out once
things are actually working), I hit this BUG()
printing dev_name for the port->uport->parent->parent gives
pci0000:0c but the matches are sort against
0000:0c:00.0 etc

So looks like one too many levels of parent in this case at least.

The other bug I haven't chased down yet is that if we happen
to have downstream ports of the switch with duplicate ids
(far too easy to do in QEMU as port_num is an optional
parameter for switch DS ports) it's detected and the probe fails
- but then it tries again and we get an infinite loop of new
ports being created and failing to probe...
I'll get back this one once I have it working with
a valid switch config.

Jonathan

> +	return NULL;
> +}
