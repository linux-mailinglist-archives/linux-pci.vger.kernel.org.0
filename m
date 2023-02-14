Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA7696580
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 14:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjBNN5G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 08:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjBNN5F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 08:57:05 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E1729148;
        Tue, 14 Feb 2023 05:56:28 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id ADA5A102E4DB9;
        Tue, 14 Feb 2023 14:51:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 701831FE09; Tue, 14 Feb 2023 14:51:10 +0100 (CET)
Date:   Tue, 14 Feb 2023 14:51:10 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 01/16] cxl/pci: Fix CDAT retrieval on big endian
Message-ID: <20230214135110.GB14338@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
 <20230214111504.000060b0@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214111504.000060b0@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 11:15:04AM +0000, Jonathan Cameron wrote:
> On Fri, 10 Feb 2023 21:25:01 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > The CDAT exposed in sysfs differs between little endian and big endian
> > arches:  On big endian, every 4 bytes are byte-swapped.
> > 
> > PCI Configuration Space is little endian (PCI r3.0 sec 6.1).  Accessors
> > such as pci_read_config_dword() implicitly swap bytes on big endian.
> > That way, the macros in include/uapi/linux/pci_regs.h work regardless of
> > the arch's endianness.  For an example of implicit byte-swapping, see
> > ppc4xx_pciex_read_config(), which calls in_le32(), which uses lwbrx
> > (Load Word Byte-Reverse Indexed).
> > 
> > DOE Read/Write Data Mailbox Registers are unlike other registers in
> > Configuration Space in that they contain or receive a 4 byte portion of
> > an opaque byte stream (a "Data Object" per PCIe r6.0 sec 7.9.24.5f).
> > They need to be copied to or from the request/response buffer verbatim.
> > So amend pci_doe_send_req() and pci_doe_recv_resp() to undo the implicit
> > byte-swapping.
> > 
> > The CXL_DOE_TABLE_ACCESS_* and PCI_DOE_DATA_OBJECT_DISC_* macros assume
> > implicit byte-swapping.  Byte-swap requests after constructing them with
> > those macros and byte-swap responses before parsing them.
> > 
> > Change the request and response type to __le32 to avoid sparse warnings.
> 
> In brief this patch set ensures that internal handling of the payloads
> is in le32 chunks by unwinding the implicit conversions in the pci config
> accessors for BE platforms.  Thus the data in the payloads is always
> in the same order.  Good start.  Hence the binary read back of CDAT is
> little endian (including all fields within it).

Correct.  On big endian this means writing request dwords and
reading response dwords involves 2 endianness conversions.

If the request is constructed with macros such as CXL_DOE_TABLE_ACCESS_*
and PCI_DOE_DATA_OBJECT_DISC_*, then an additional (3rd) endianness
conversion is necessary:  The request is constructed in native big endian
order, then converted to a little endian DOE payload.  That payload is
then converted back to big endian so that it can be written with the
config space accessor, which converts to little endian.

I recognize this is crazy but I do not see a better solution.
Dan suggested amending struct pci_ops with ->read_raw and ->write_raw
callbacks which omit the endianness conversion.  However there are
175 struct pci_ops in the kernel and each one would have to be looked at.
I also do not know the Assembler instructions for every architecture to
perform a non-byte-swapped write or read.  It's a big task and lots of
code to add.  Given that DOE is likely the only user and big endian
is seeing decreasing use, it's probably not worth the effort and LoC.


> > @@ -322,15 +322,17 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> >  	struct pci_doe_task task = {
> >  		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> >  		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > -		.request_pl = &request_pl,
> > +		.request_pl = (__le32 *)&request_pl,
> 
> I don't like this type cast. request_pl is local
> anyway, so why not change it's type and set it appropriately in
> the first place.

That doesn't work I'm afraid.  The request_pl is constructed with
FIELD_PREP() here and the response_pl is parsed with FIELD_GET().

Those macros operate on an unsigned integer of native endianness.
If I declare them __le32, I get sparse warnings and rightfully so.

The casts are the simplest, least intrusive solution.  The only
alternative would be to use separate variables but then I'd have
to change a lot more lines and it would be more difficult to review
and probably not all that more readable.

Thanks,

Lukas

> >  		.request_pl_sz = sizeof(request_pl),
> > -		.response_pl = &response_pl,
> > +		.response_pl = (__le32 *)&response_pl,
> 
> Likewise here.
> 
> >  		.response_pl_sz = sizeof(response_pl),
> >  		.complete = pci_doe_task_complete,
> >  		.private = &c,
> >  	};
> >  	int rc;
> >  
> > +	cpu_to_le32s(&request_pl);
> > +
> >  	rc = pci_doe_submit_task(doe_mb, &task);
> >  	if (rc < 0)
> >  		return rc;
> > @@ -340,6 +342,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> >  	if (task.rv != sizeof(response_pl))
> >  		return -EIO;
> >  
> > +	le32_to_cpus(&response_pl);
> >  	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> >  	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> >  			      response_pl);
