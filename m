Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ECF78C860
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjH2PN3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjH2PM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 11:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3181BD
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 08:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 586FD61058
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 15:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E8C433C8;
        Tue, 29 Aug 2023 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693321975;
        bh=7cZGRo8fUE3rcCsnCSIDZFr+/XhzQ583j9LmFP88nHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbuEj0JqcCbVco7CN8RK1cLBB9MoUmYoJm0dzTbhK141vpSiLKECQ4ModkMUkGY0r
         Xr+X7VkVYMV+C3udjcVLykut71JSkVQx9Hw9GW1fNUHCJwrdapqDQgqzFKultuKpGu
         G2E4J6LXwSPd0Vq2D6AN8A5CJ2Ae/33qIDdgWTmFVjIStyUEbAcCJ7lxlQG+3vMDdn
         IWO/utjNAJ9NZlFJtcQjAhzm1Vq5jn2kuQT0zEcpg2oxL2xJcXCW7XVAvRmpQpBMyL
         Pqn12hRk57UUjags2AqCVcvbcYuLnRx3kvkL2L1LdRQG8rh3uepbEvU7mmTip69Idl
         tarj1JT/6b9ig==
Date:   Tue, 29 Aug 2023 17:12:51 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Message-ID: <ZO4K84tILB5cgixT@lpieralisi>
References: <20230829051022.1328383-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829051022.1328383-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 29, 2023 at 01:10:22AM -0400, Nirmal Patel wrote:
> Currently during Host boot up, VMD UEFI driver loads and configures
> all the VMD endpoints devices and devices behind VMD. Then during
> VMD rootport creation, VMD driver honors ACPI settings for Hotplug,
> AER, DPC, PM and enables these features based on BIOS settings.
> 
> During the Guest boot up, ACPI settings along with VMD UEFI driver are
> not present in Guest BIOS which results in assigning default values to
> Hotplug, AER, DPC, etc. As a result hotplug is disabled on the VMD
> rootports in the Guest OS.
> 
> VMD driver in Guest should be able to see the same settings as seen
> by Host VMD driver. Because of the missing implementation of VMD UEFI
> driver in Guest BIOS, the Hotplug is disabled on VMD rootport in
> Guest OS. Hot inserted drives don't show up and hot removed drives
> do not disappear even if VMD supports Hotplug in Guest. This
> behavior is observed in various combinations of guest OSes i.e. RHEL,
> SLES and hypervisors i.e. KVM and ESXI.
> 
> This change will make the VMD Host and Guest Driver to keep the settings
> implemented by the UEFI VMD DXE driver and thus honoring the user
> selections for hotplug in the BIOS.
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v3->v4: Rewrite the commit log.
> v2->v3: Update the commit log.
> v1->v2: Update the commit log.
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

How is the host bridge probed in the guest if there is no ACPI support ?

I would like to understand this better how this works.

>  	vmd_bridge->native_aer = root_bridge->native_aer;
>  	vmd_bridge->native_pme = root_bridge->native_pme;
>  	vmd_bridge->native_ltr = root_bridge->native_ltr;

I don't get why *only* the hotplug flag should not be copied. Either
you want to preserve them all or none.

I assume the issue is that in the host, the _OSC method is used to
probe for flags whereas in the guest you can't rely on it ?

Is there a use case where you *do* want to copy the flags from the
root_bridge to the vmd_bridge ?

This does not look solid to me.

Thanks,
Lorenzo
