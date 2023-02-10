Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D796469297D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 22:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjBJVra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 16:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjBJVr3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 16:47:29 -0500
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Feb 2023 13:47:28 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CB4A1D0;
        Fri, 10 Feb 2023 13:47:28 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 637B310333602;
        Fri, 10 Feb 2023 22:47:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 302EA1DF78; Fri, 10 Feb 2023 22:47:27 +0100 (CET)
Date:   Fri, 10 Feb 2023 22:47:27 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI/DOE: Relax restrictions on request and
 response size
Message-ID: <20230210214727.GB15326@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
 <4dba01ff87d630abdd5a09d52e954d3c212d2018.1674468099.git.lukas@wunner.de>
 <63cf37d8f30e3_5cca294fb@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cf37d8f30e3_5cca294fb@iweiny-mobl.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 05:43:53PM -0800, Ira Weiny wrote:
> Lukas Wunner wrote:
> > SPDM message sizes are not always a multiple of dwords.  To transport
> > them over DOE without using bounce buffers, allow sending requests and
> > receiving responses whose final dword is only partially populated.
[...]
> > +	/* Write last payload dword */
> > +	remainder = task->request_pl_sz % sizeof(u32);
> > +	if (remainder) {
> > +		val = 0;
> > +		memcpy(&val, &task->request_pl[i], remainder);
> 
> Are there any issues with endianess here?

Indeed there were.  I've fixed that in v3.


> >  	/* First 2 dwords have already been read */
> >  	length -= 2;
> > -	payload_length = min(length, task->response_pl_sz / sizeof(u32));
> > -	/* Read the rest of the response payload */
> > -	for (i = 0; i < payload_length; i++) {
> > -		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> > -				      &task->response_pl[i]);
> > +	received = task->response_pl_sz;
> > +	payload_length = DIV_ROUND_UP(task->response_pl_sz, sizeof(u32));
> > +	remainder = task->response_pl_sz % sizeof(u32);
> > +	if (!remainder)
> > +		remainder = sizeof(u32);
> > +
> > +	if (length < payload_length) {
> > +		received = length * sizeof(u32);
> > +		payload_length = length;
> > +		remainder = sizeof(u32);
> 
> It was a bit confusing why remainder was set to a dword here.  But I got
> that it is because length and payload_length are both in dwords.

Here in pci_doe_recv_resp(), "remainder" signifies the number of
data bytes in the last payload dword.

If the response received via DOE is shorter than the buffer it is
written into, then the last payload dword contains 4 data bytes.
(DOE transmits full dwords.)

I've added a code comment in v3 to hopefully avoid any confusion:
/* remainder signifies number of data bytes in last payload dword */

Thanks,

Lukas
