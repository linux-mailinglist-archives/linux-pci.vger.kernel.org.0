Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF528551439
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiFTJYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 05:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiFTJYy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 05:24:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668412ABF;
        Mon, 20 Jun 2022 02:24:53 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRPNw22LKz688LD;
        Mon, 20 Jun 2022 17:24:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 11:24:51 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 10:24:51 +0100
Date:   Mon, 20 Jun 2022 10:24:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220620102449.000041d4@Huawei.com>
In-Reply-To: <20220617224019.GA1208614@bhelgaas>
References: <20220610202259.3544623-4-ira.weiny@intel.com>
        <20220617224019.GA1208614@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Bjorn,

Thanks for reviewing!  Up to Ira of course, but I agree with all your
comments - a few responses to questions follow.

> 
> > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > + *			     protocol
> > + * @doe_mb: DOE mailbox capability to query
> > + * @vid: Protocol Vendor ID
> > + * @type: Protocol type
> > + *
> > + * RETURNS: True if the DOE mailbox supports the protocol specified  
> 
> Is the typical use that the caller has a few specific protocols it
> cares about?  There's no case where a caller might want to enumerate
> them all?  I guess they're all in prots[], but that's supposed to be
> opaque to users.

Given each protocol needs specific handling in the driver, the only
usecase for a general enumeration would be debug I think.  Maybe
it makes sense to provide that info to userspace somewhere, but
definitely feels like something for a follow up discussion.

> 
> > + */
> > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > +{
> > +	int i;
> > +
> > +	/* The discovery protocol must always be supported */
> > +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> > +		return true;
> > +
> > +	for (i = 0; i < doe_mb->num_prots; i++)
> > +		if ((doe_mb->prots[i].vid == vid) &&
> > +		    (doe_mb->prots[i].type == type))
> > +			return true;
> > +
> > +	return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);  
> 
> > + * struct pci_doe_task - represents a single query/response
> > + *
> > + * @prot: DOE Protocol
> > + * @request_pl: The request payload
> > + * @request_pl_sz: Size of the request payload  
> 
> Size is in dwords, not bytes, I guess?

It's in bytes (IIRC) - we divide it by. It's a bit of a mess,
but there are parts of SPDM over CMA where messages are not
full number of dwords. My thinking was that we 'might' move
the padding into the generic code if this becomes something
multiple protocols need.  For now the RFC does the
padding at the CMA layer.

Let's avoid this being unclear in future by stating that it's
in bytes in the comment.

Jonathan

> 
> > + * @response_pl: The response payload
> > + * @response_pl_sz: Size of the response payload
> > + * @rv: Return value.  Length of received response or error
> > + * @complete: Called when task is complete
> > + * @private: Private data for the consumer
> > + */
> > +struct pci_doe_task {
> > +	struct pci_doe_protocol prot;
> > +	u32 *request_pl;
> > +	size_t request_pl_sz;
> > +	u32 *response_pl;
> > +	size_t response_pl_sz;
> > +	int rv;
> > +	void (*complete)(struct pci_doe_task *task);
> > +	void *private;
> > +};  

