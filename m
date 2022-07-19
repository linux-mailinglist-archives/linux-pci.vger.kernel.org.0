Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82FE57A1B0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiGSOes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237889AbiGSOec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 10:34:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7692F9;
        Tue, 19 Jul 2022 07:25:57 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnLgK3PMxz67ydF;
        Tue, 19 Jul 2022 22:24:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 16:25:56 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:25:54 +0100
Date:   Tue, 19 Jul 2022 15:25:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 14/46] cxl/hdm: Enumerate allocated DPA
Message-ID: <20220719152553.00006660@Huawei.com>
In-Reply-To: <62ca418dea1ef_2da5bd2946b@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603880411.551046.9204694225111844300.stgit@dwillia2-xfh>
        <20220629154359.000021cc@Huawei.com>
        <62ca418dea1ef_2da5bd2946b@dwillia2-xfh.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

...

> > > +static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > > +			     resource_size_t base, resource_size_t len,
> > > +			     resource_size_t skip)
> > > +{
> > > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > > +	struct cxl_port *port = cxled_to_port(cxled);
> > > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > +	struct device *dev = &port->dev;
> > > +	struct resource *res;
> > > +
> > > +	lockdep_assert_held_write(&cxl_dpa_rwsem);
> > > +
> > > +	if (!len)
> > > +		return 0;
> > > +
> > > +	if (cxled->dpa_res) {
> > > +		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
> > > +			port->id, cxled->cxld.id, cxled->dpa_res);
> > > +		return -EBUSY;
> > > +	}
> > > +
> > > +	if (skip) {
> > > +		res = __request_region(&cxlds->dpa_res, base - skip, skip,
> > > +				       dev_name(dev), 0);  
> > 
> > 
> > Interface that uses a backwards definition of skip as what to skip before
> > the base parameter is a little odd can we rename base parameter to something
> > like 'current_top' then have base = current_top + skip?  current_top naming
> > not great though...  
> 
> How about just name it "skipped" instead of "skip"? As the parameter is
> how many bytes were skipped to allow a new allocation to start at base.

Works for me (guessing you long since went with this given how far behind I am!)

Thanks,

Jonathan
