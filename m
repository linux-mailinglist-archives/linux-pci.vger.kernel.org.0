Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C906A5454
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 09:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjB1IYG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 03:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjB1IYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 03:24:05 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD5611648;
        Tue, 28 Feb 2023 00:24:03 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 56D3D2800F9AA;
        Tue, 28 Feb 2023 09:24:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 426F641007; Tue, 28 Feb 2023 09:24:00 +0100 (CET)
Date:   Tue, 28 Feb 2023 09:24:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 01/16] cxl/pci: Fix CDAT retrieval on big endian
Message-ID: <20230228082400.GA4168@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
 <ccfc3dcd-a52b-7649-fa8e-89a6ac7ebb3c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccfc3dcd-a52b-7649-fa8e-89a6ac7ebb3c@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 28, 2023 at 01:53:46PM +1100, Alexey Kardashevskiy wrote:
> On 11/2/23 07:25, Lukas Wunner wrote:
> > @@ -493,8 +493,8 @@ static void cxl_doe_task_complete(struct pci_doe_task *task)
> >   }
> >   struct cdat_doe_task {
> > -	u32 request_pl;
> > -	u32 response_pl[32];
> > +	__le32 request_pl;
> > +	__le32 response_pl[32];
> 
> This is ok as it is a binary format of DOE message (is it?)...

Yes, the DOE request and response is an opaque byte stream.

The above-quoted type changes are necessary to avoid sparse warnings
(as noted in the commit message).


> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -143,7 +143,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> >   					  length));
> >   	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
> >   		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> > -				       task->request_pl[i]);
> > +				       le32_to_cpu(task->request_pl[i]));
> 
> Does it really work on BE? My little brain explodes on all these convertions
> 
> char buf[] = { 1, 2, 3, 4 }
> u32 *request_pl = buf;
> 
> request_pl[0] will be 0x01020304.
> le32_to_cpu(request_pl[0]) will be 0x04030201
> And then pci_write_config_dword() will do another swap.
> 
> Did I miss something? (/me is gone bringing up a BE system).

Correct.


> > @@ -45,9 +49,9 @@ struct pci_doe_mb;
> >    */
> >   struct pci_doe_task {
> >   	struct pci_doe_protocol prot;
> > -	u32 *request_pl;
> > +	__le32 *request_pl;
> >   	size_t request_pl_sz;
> > -	u32 *response_pl;
> > +	__le32 *response_pl;
> 
> 
> This does not look right. Either:
> - pci_doe() should also take __le32* or
> - pci_doe() should do cpu_to_le32() for the request, and
> pci_doe_task_complete() - for the response.

Again, the type changes are necessary to avoid sparse warnings.

pci_doe() takes a void * because patch [15/16] eliminates the need
for the request and response size to be a multiple of dwords.
Passing __le32 * to pci_doe() would then no longer be correct.

Thanks,

Lukas
