Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49757752943
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGMQ7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMQ7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 12:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E178268B
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 09:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B6DC61ADE
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 16:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFC5C433C8;
        Thu, 13 Jul 2023 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689267538;
        bh=wnZEPMl0YiEdF3xGKLIlgfqs92g9SvZXF42My1zlqD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PWnwvIrud5PN9b2I3dzSchRYWCLJSOwZXPkZ40NgVCZstQnltEbDf5FK+sG9ubRei
         1xmLGJHLWJjt2Hf6GWS8SI02Uz0KB5hzeqHxWa93rUbJq593zyHeZw/vpZyU5jFm9T
         c6aw/6sC0266RaFl7JfHck2IFIc4JJf73uIGl+iVjH6yKXq8kM/FYlDjEmxNnNPlz6
         MhKMosrxvJ3ir9KTKwzkuEIOQPZkBAKuyW4+kZYe52LlTNkFY/URaHEtdOhWKRrZWZ
         DWYxGCzzpG1/kK7VCrZb2LbBT9ZqjlKoEMqdCm9p6bxxrqjfGvdWchZc1kMXcV+2Hq
         qD5KMO11SxieA==
Date:   Thu, 13 Jul 2023 11:58:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: vmd: VMD to control Hotplug on its rootports
Message-ID: <20230713165856.GA322319@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705172038.844706-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jonathan, Lorenzo, Krzysztof, Rob (from MAINTAINERS)]

Can you make the subject line say what the patch does?  Repeating
"VMD" is probably unnecessary.

On Wed, Jul 05, 2023 at 01:20:38PM -0400, Nirmal Patel wrote:
> The hotplug functionality is broken in various combinations of guest
> OSes i.e. RHEL, SlES and hypervisors i.e. KVM and ESXI.

"SLES"

> VMD enabled on Intel ADL cpus caused interrupt storm for smasung
> drives due to AER being enabled on VMD controlled root ports.

"Samsung"

Enabling AER should not cause an interrupt storm.  There must be
something else going on in addition.  Are you saying the Samsung
drives have some AER-related defect, like generating Correctable
Errors when they shouldn't?  It doesn't sound like "Intel ADL" would
be relevant here.

It's not clear to me if this is directly related to *hotplug* or if
it's an AER issue that may happen because of hotplug and possible for
other reasons.

> The patch 04b12ef163d10e348db664900ae7f611b83c7a0e

12 char SHA1 is sufficient.

> ("PCI: vmd: Honor APCI _OSC on PCIe features.") was added to the VMD
> driver to correct the issue based on the following assumption:
> 	“Since VMD is an aperture to regular PCIe root ports, honor ACPI
> 	_OSC to disable PCIe features accordingly to resolve the issue.”
> 	Link: https://lore.kernel.org/r/20211203031541.1428904-1-kai.heng.feng@canonical.com
> 
> VMD as a PCIe device is an end point(type 0), not a PCIe aperture
> (pcie bridge). In fact VMD is a type 0 raid controller(class code).
> When BIOS boots, all root ports under VMD is inaccessible by BIOS, and
> as such, they maintain their power on default states. The VMD UEFI DXE
> driver loads and configure all devices under VMD. This is how AER,
> power management and hotplug gets enabled in UEFI, since the BIOS pci
> driver cannot access the root ports.

s/pcie/PCIe/
s/pci/PCI/
s/raid/RAID/

> The patch worked around the interrupt storm by assigning the native

I assume "the patch" means 04b12ef163d1.  Sometimes people write "the
patch does X" in the commit log for the current patch, so it's nice to
be specific to avoid confusion.

> ACPI states to the  root ports under VMD. It assigns AER, hotplug,
> PME, etc. These have been restored back to the power on default state
> in guest OS, which says the root port hot plug enable is default OFF.
> At most, the work around should have only assigned AER state.
> An additional patch should be added to exclude hot plug from the
> original patch.

Add blank line between paragraphs.

> This will cause hot plug to start working again in the guest, as the
> settings implemented by the UEFI VMD DXE driver will remain in effect
> in Linux.

This is a lot of description that doesn't seem to say what the actual
underlying issue is.  It's basically "if we treat hotplug differently
from other negotiated features, things work better."  And it seems
like it depends on what the UEFI driver did, and we should try to
avoid a dependency there.

If the issue is too many Correctable Errors being reported via AER, we
have that problem regardless of VMD, and we should handle it by
rate-limiting and/or suppressing them completely for particularly
offensive devices.  We have some issues like this that are still
outstanding:

[1] https://lore.kernel.org/linux-pci/DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com/
[2] https://lore.kernel.org/linux-pci/20230606035256.2886098-2-grundler@chromium.org/

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..52c2461b4761 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  				       struct pci_host_bridge *vmd_bridge)
>  {
> -	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> -	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
>  	vmd_bridge->native_aer = root_bridge->native_aer;
>  	vmd_bridge->native_pme = root_bridge->native_pme;
>  	vmd_bridge->native_ltr = root_bridge->native_ltr;
> -- 
> 2.31.1
> 
