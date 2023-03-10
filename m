Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2A6B4063
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 14:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCJN1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 08:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJN1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 08:27:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4B3C06;
        Fri, 10 Mar 2023 05:27:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40930B822AB;
        Fri, 10 Mar 2023 13:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E15FC433EF;
        Fri, 10 Mar 2023 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678454821;
        bh=1fevsLWDSygfQVCGJ0gejYAP/iPQR1DJXPBRLgwub5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZ9djVPO9O9RVXaRK81zFJza+wLcKtwndrNkdJ9Zn2JE1TAn7CBPWuyTwHWJqExFz
         jC1FmCzmQUw45IKAZm0ZC3jJ8JnnXIacUjkzDkc0Z2pRTPPH57cClleCNoKzKj1DwL
         NHyLRml5GBpaIJ/F727SA9BADk+mI8KY0AtqUKPns5t7gn7JPL9TE9u6XesrKjT07m
         RuT0YYM9X9Eh4A3SuRZgs9ZMSK932suN9l3LfSjUGZdWv0zWMIhplbLM+isQEeU/ZI
         /ORhY67EtKL/47+lGK8srv4Qiy3bqYty92ox95oiNIUX7VHrW6oNrK4/ldIVBr0yJo
         QVJZfJ/UJHkHA==
Date:   Fri, 10 Mar 2023 14:26:55 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Add quirk for platforms running Windows
Message-ID: <ZAswHyaYjeqjW/+A@lpieralisi>
References: <20230227021221.17980-1-shawn.guo@linaro.org>
 <20230308185310.GA1030878@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308185310.GA1030878@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 12:53:10PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 27, 2023 at 10:12:21AM +0800, Shawn Guo wrote:
> > Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> > host bridge windows") introduced a check to remove host bridge register
> > resources for all arm64 platforms, with the assumption that the PNP0A03
> > _CRS resources would always be host bridge registers and never as windows
> > on arm64.
> > 
> > The assumption stands true until Qualcomm Snapdragon Windows laptops
> > emerge.  These laptops describe host bridge windows in PNP0A03 _CRS
> > resources instead.  For example, the Microsoft Surface Pro X has host
> > bridges defined as
> > 
> >     Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
> >     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> > 
> >     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >     {
> >         Name (RBUF, ResourceTemplate ()
> >         {
> >             Memory32Fixed (ReadWrite,
> >                 0x60200000,         // Address Base
> >                 0x01DF0000,         // Address Length
> >                 )
> >             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> >                 0x0000,             // Granularity
> >                 0x0000,             // Range Minimum
> >                 0x0001,             // Range Maximum
> >                 0x0000,             // Translation Offset
> >                 0x0002,             // Length
> >                 ,, )
> >         })
> >         Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
> >     }
> > 
> > The Memory32Fixed holds a host bridge window, but it's not properly
> > defined as a "producer" resource.  Consequently the resource gets
> > removed by kernel, and the BAR allocation fails later on:
> > 
> >     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
> >     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> >     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> >     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > 
> > This eventually prevents the PCIe NVME drive from being accessible.
> > 
> > Add a quirk for these platforms to avoid the resource being removed.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > We are running into the issue on more devices than just Surface Pro X
> > now, so trying to sort it out with a quirk as suggested by Lorenzo [1].
> 
> One thing I don't like about this application of quirks is that the
> list of affected platforms is likely to grow, which is an ongoing
> burden for users and developers.
> 
> Can we have a conversation with Qualcomm about how they *intend* this
> to work?  Linux is probably doing something wrong (interpreting
> something differently than Windows does), and if we could fix that, we
> have a better chance of future platforms working without quirks.

Catch-22. What if some firmware would add host bridge MMIO register
space (marked as consumer) in the _CRS ? We would end up allocating
BAR regions in there, which is not right, so your commit:

8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from host bridge windows")

is correct and if we revert it we would trigger regressions on some
arm64 platforms for the reason I mention above.

We can look for clarification at ACPI specs level but for firmware
that is out there I am not sure what options we have.

Lorenzo

> > [1] https://lore.kernel.org/all/20210527093200.GA16444@lpieralisi/
> > 
> >  arch/arm64/kernel/pci.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 2276689b5411..896dbd028b67 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -109,16 +109,42 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> >  	return 0;
> >  }
> >  
> > +#define QCOM_DSDT_QUIRK "Host bridge windows in PNP0A03 _CRS"
> > +
> > +static struct acpi_platform_list qcom_platlist[] = {
> > +	/* Thinkpad X13s */
> > +	{ "LENOVO", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> > +	/* Microsoft Surface Pro 9 (5G) and Windows Dev Kit 2023 */
> > +	{ "QCOMM ", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> > +	/* Microsoft Surface Pro X */
> > +	{ "QCOMM ", "SDM8180 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
> > +	{ }
> > +};
> > +
> >  static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> >  {
> >  	struct resource_entry *entry, *tmp;
> >  	int status;
> > +	int idx;
> >  
> >  	status = acpi_pci_probe_root_resources(ci);
> > +
> > +	/*
> > +	 * Most arm64 platforms that do not run Windows describe host bridge
> > +	 * registers in PNP0A03 _CRS resources, but some like Qualcomm
> > +	 * Snapdragon Windows laptops describe host bridge windows in there.
> > +	 * We do not want to destroy the resources for these platforms.
> > +	 */
> > +	idx = acpi_match_platform_list(qcom_platlist);
> > +	if (idx >= 0)
> > +		goto done;
> > +
> >  	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> >  		if (!(entry->res->flags & IORESOURCE_WINDOW))
> >  			resource_list_destroy_entry(entry);
> >  	}
> > +
> > +done:
> >  	return status;
> >  }
> >  
> > -- 
> > 2.17.1
> > 
