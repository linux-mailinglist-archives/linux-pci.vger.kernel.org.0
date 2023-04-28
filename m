Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D466F201E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Apr 2023 23:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjD1Vac (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 17:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjD1Vab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 17:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617661725;
        Fri, 28 Apr 2023 14:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB52645A7;
        Fri, 28 Apr 2023 21:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0223FC433D2;
        Fri, 28 Apr 2023 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682717429;
        bh=LZyvQOlA+YPLE+u/H4MSi/7JEM8BoKst314zkORamyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=scNMVTiK+VrCxkEm4YpMEKmW87PGkYkYyYdp6RXnUtRMt/VRZJWrcXtkoBBk++qy0
         Za3H+LFtJwN0E1O6M0oSK8R6wrh92prC7RryMEiDkAA+XgzdrQSZmD8WPDesPo3fIy
         faBVHY3G0oo6DwDmnou9KfWJcSPuUBufRU+wprVFZDE/UrGBbVhJoAYPUXEEf/9MYH
         DB1ozSHYZrTEWkd14yHVwn7XnulTLIofDkuKPx9Tei4URqOamoYxqI6c7Cnyc6uBUc
         Bafhm2RD9A2I7aUcdPtyHhc+BWMAk296O8FJBOYne2NqeZEs8JXAXaOlNuj/J//T4Q
         HAMPm3JzuprfQ==
Date:   Fri, 28 Apr 2023 16:30:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2] arm64: PCI: Add quirk for Qualcomm WoA devices
Message-ID: <20230428213027.GA363093@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423030520.9570-1-shawn.guo@linaro.org>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Andy, Bjorn A, plea for help from Qualcomm firmware folks]

On Sun, Apr 23, 2023 at 11:05:20AM +0800, Shawn Guo wrote:
> Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> host bridge windows") introduced a check to remove host bridge register
> resources for all arm64 platforms, with the assumption that the PNP0A03
> _CRS resources would always be host bridge registers and never as windows
> on arm64 platforms.

That's not quite what the commit log says.  The 8fd4391ee717
assumption is that on arm64,

  - _CRS *consumer* resources are host bridge registers
  - _CRS *producer* resources are windows

which I think matches the intent of the ACPI spec.

> The assumption stands true until Qualcomm WoA (Windows on ARM) devices
> emerge.  These devices describe host bridge windows in PNP0A03 _CRS
> resources instead.  For example, the Microsoft Surface Pro X has host
> bridges defined as
> 
>     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> 
>     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>     {
>         Name (RBUF, ResourceTemplate ()
>         {
>             Memory32Fixed (ReadWrite,
>                 0x60200000,         // Address Base
>                 0x01DF0000,         // Address Length
>                 )
> ...

> The Memory32Fixed holds a host bridge window, but it's not properly
> defined as a "producer" resource.

I assume you're saying the use of Memory32Fixed for a window is a
firmware defect, right?

(Per ACPI r6.5, sec 19.6.83, the Memory32Fixed descriptor cannot
specify a Producer/Consumer ResourceUsage.  I think that means the
space is assumed to be ResourceConsumer.)

> Consequently the resource gets removed by kernel, and the BAR
> allocation fails later on:
> 
>     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
>     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
>     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
>     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> 
> This eventually prevents the PCIe NVME drive from being accessible.
> 
> Add a quirk for these devices to avoid the resource being removed.

Since this is a Windows laptop, I assume this works with Windows and
that Windows will in fact assign BARs in that Memory32Fixed area.

If we knew what the firmware author's intent was, we could probably
make Linux understand it.

Maybe (probably) Windows treats these descriptors the same on arm64 as
on x86, i.e., *everything* in PNP0A03 _CRS is assumed to be "producer"
(at least, that's my experimental observation; I have no actual
knowledge of Windows).

So I guess 8fd4391ee717 must have been motivated by some early arm64
platform that put "consumer" descriptors in PNP0A03 _CRS as Lorenzo
said [1].

In that case I guess our choices are:

  - Add quirks like this and keep adding them for every new arm64
    platform that uses the same "everything in PNP0A03 _CRS is a
    producer" strategy.

  - Remove 8fd4391ee717, break whatever early arm64 platforms needed
    it, and add piecemeal quirks for them.

I hate both, but I think I hate the first more because it has no end,
while the second is painful but limited.

Obviously we would need to do whatever we can to identify and fix
things that depend on 8fd4391ee717 before reverting it.

Bjorn

[1] https://lore.kernel.org/lkml/ZBA2Gl5xCjk7mMoW@lpieralisi/

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes for v2:
> - Match devices using PPTT instead of DSDT to avoid maintenance burden.
>   Hope this is an acceptable compromise.
> - Add const delaration to qcom_platlist[].
> 
> v1 link:
> https://lore.kernel.org/lkml/20230227021221.17980-1-shawn.guo@linaro.org/
> 
>  arch/arm64/kernel/pci.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 2276689b5411..2ff2f3befa76 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -109,16 +109,44 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  	return 0;
>  }
>  
> +#define QCOM_PCI_QUIRK "Host bridge windows in PNP0A03 _CRS"
> +
> +/*
> + * Ideally DSDT (Differentiated System Description Table) should be used to
> + * match the platforms, as the quirk is in there. But devices from different
> + * manufacturers usually have different oem_id and oem_table_id in DSDT,
> + * so matching DSDT makes the list a maintenance burden.  As a compromise,
> + * PPTT (Processor Properties Topology Table) is used instead to work
> + * around this quirk for the most Qualcomm WoA (Windows on ARM) devices.
> + */
> +static const struct acpi_platform_list qcom_platlist[] = {
> +	{ "QCOM  ", "QCOMEDK2", 0, ACPI_SIG_PPTT, all_versions, QCOM_PCI_QUIRK },
> +	{ }
> +};
> +
>  static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  {
>  	struct resource_entry *entry, *tmp;
>  	int status;
> +	int idx;
>  
>  	status = acpi_pci_probe_root_resources(ci);
> +
> +	/*
> +	 * Instead of describing host bridge registers in PNP0A03 _CRS
> +	 * resources, Qualcomm WoA devices describe host bridge windows in
> +	 * there.  We do not want to destroy the resources on these platforms.
> +	 */
> +	idx = acpi_match_platform_list(qcom_platlist);
> +	if (idx >= 0)
> +		goto done;
> +
>  	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>  		if (!(entry->res->flags & IORESOURCE_WINDOW))
>  			resource_list_destroy_entry(entry);
>  	}
> +
> +done:
>  	return status;
>  }
>  
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
