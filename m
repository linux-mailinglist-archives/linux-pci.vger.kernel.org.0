Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466716815EE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 17:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjA3QE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 11:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjA3QEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 11:04:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D45C42DD7
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 08:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C9A5611C2
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 16:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A4EC433EF;
        Mon, 30 Jan 2023 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675094677;
        bh=doxsvnh/slaEbhaypj6o3i+tTR1IJYbvw7umrl1GjfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Fd2xdrbFujoiOnEqZBoxzUAh5Prc/8aNwalGDqwx1DyolzcbpO5xNAzf5A20mDYO3
         ZjLgd4JxVmjSWxqHJStbnK2qkASI3hojLbW/5izSlIZ9ha64PgBUuEmis0UZDdSWpJ
         8q+WfU+6XXVhriIX7oAAYb1Om/rxeAa26jmPHQlEE9o4K7/O7IrX3NHIiD6DecjksT
         aen8R/0ok8VpFv2KB93PdzYa0smt+Ta/X2BsU/Posmkitc441707V1ekg1Jwcrt6cf
         KnFs9g8Hn/17qPFZp7IBNIzwMUM6u8uzcl3wB2J6R0t5yVvkbuT4cvL5enf4iIhIh3
         c5W4kCnRaQYUw==
Date:   Mon, 30 Jan 2023 10:04:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
Message-ID: <20230130160436.GA1678344@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9fmPef6PyBfcqt1@x1-carbon>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 30, 2023 at 03:46:06PM +0000, Niklas Cassel wrote:
> On Mon, Jan 30, 2023 at 09:21:11AM -0600, Bjorn Helgaas wrote:
> > On Sat, Jan 28, 2023 at 10:39:51AM +0900, Damien Le Moal wrote:
> > > PCI passthrough to VMs does not work with AMD FCH AHCI adapters: the
> > > guest OS fails to correctly probe devices attached to the controller due
> > > to FIS communication failures. 
> > 
> > What does a FIS communication failure look like?  Can we include a
> > line or two of dmesg output here to help users find this fix?
> 
> It looks like this:
> 
> [   22.402368] ata4: softreset failed (1st FIS failed)
> [   32.417855] ata4: softreset failed (1st FIS failed)
> [   67.441641] ata4: softreset failed (1st FIS failed)
> [   67.453227] ata4: limiting SATA link speed to 3.0 Gbps
> [   72.661738] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> [   78.121263] ata4.00: qc timeout after 5000 msecs (cmd 0xec)
> [   78.134413] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> 
> Basically, we can read and write MMIO registers in the AHCI HBA,
> but the communication between the AHCI HBA and the ATA device does
> not work properly.
> 
> (Because the AHCI HBA did not get reset when binding/unbinding the
> device.)
> 
> The exact same kernel, using the same generic AHCI driver within the VM,
> can communicate perfectly fine when using e.g. an Intel AHCI HBA.
> 
> (With both the AMD and Intel AHCI HBAs being bound to the vfio-pci driver
> in the host.)
> 
> We can send a v2 with the above dmesg output.

Don't bother, I added the above and applied this to pci/virtualization
for v6.2, thanks!

> > AMD folks: Can you confirm/deny that this is a hardware erratum in
> > this device?  Do you know of any other devices that need a similar
> > workaround?
> > 
> > > Forcing the "bus" reset method before
> > > unbinding & binding the adapter to the vfio-pci driver solves this
> > > issue. I.e.:
> > > 
> > > echo "bus" > /sys/bus/pci/devices/<ID>/reset_method
> > > 
> > > gives a working guest OS, thus indicating that the default flr reset
> > > method is defective, resulting in the adapter not being reset correctly.
> > > 
> > > This patch applies the no_flr quirk to AMD FCH AHCI devices to
> > > permanently solve this issue.
> > > 
> > > Reported-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > > ---
> > >  drivers/pci/quirks.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 285acc4aaccc..20ac67d59034 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5340,6 +5340,7 @@ static void quirk_no_flr(struct pci_dev *dev)
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> > >  
> > > -- 
> > > 2.39.1
> > > 
