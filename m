Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC10782668
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 11:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjHUJiP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 05:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHUJiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 05:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9249B
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 02:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C0C62EDB
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 09:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C17C433C7;
        Mon, 21 Aug 2023 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692610692;
        bh=wnWL/EKTKbDsVFerCxlrC/+i3Vo1wiCav9QNTfkNnI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t17A+wdfs1OBvAtu3NJXfstNmkci88Z+bLJlVM6owvwBCKyY7ttPJLiEyxufPJtqR
         4idnkC1P6ul69JTZFIWUKCCAqojRWqBhs+K3h+Vebrcl6xnwWFYIDMbEsGRvAhbjcM
         bwAakQtmszlsXkqdSuf3Jps1dmfobBYsTjPDApz+E3+nX4kYs1h2EzaD2dIIrhR46v
         5wUQNuqKXfKs5mojvRCS9MfE1C1BVlLArQjZP0xf3TV+1ifSlJrmd+8TnrQXBJIkga
         s0DIkduT5YnSWtCXYvBE7+dGSq4Fb763ZBmCmUZabEa5Ko6ecn70vPU4Hunxq502dN
         A5wJOPizrq0Gw==
Date:   Mon, 21 Aug 2023 11:38:08 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Do not change the Hotplug setting on VMD
 rootports
Message-ID: <ZOMwgFHc3Ngv204W@lpieralisi>
References: <20230725035405.932765-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725035405.932765-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 11:54:05PM -0400, Nirmal Patel wrote:
> The hotplug functionality is broken in various combinations of guest
> OSes i.e. RHEL, SLES and hypervisors i.e. KVM and ESXI.

What about the configurations that are actually working ?

Will this patch change anything on that front ?

> During the VMD rootport creation, VMD honors ACPI settings and assigns
> respective values to Hotplug, AER, DPC, PM etc which works in case of
> Host OS. But these have been restored back to the power on default
> state in Guest OSes, which puts the root port hot plug enable to
> default OFF.
> 
> When BIOS boots, all root ports under VMD is inaccessible by BIOS and
> they maintain their power on default states. The VMD UEFI driver loads
> and configure all devices under VMD. This is how AER, power management,
> DPC and hotplug gets enabled in UEFI, since the BIOS pci driver cannot
> access the root ports. With the absence of VMD UEFI driver in Guest,
> Hotplug stays Disabled.
> 
> This change will  cause the hot plug to start working again in guest,
> as the settings implemented by the UEFI VMD DXE driver will remain in
> effect in the Guest OS.

This explanation is unclear to me - in particular the link between
code changes and the commit log. Please write a commit log that
explains and justifies the changes you are making below.

Thanks,
Lorenzo

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
