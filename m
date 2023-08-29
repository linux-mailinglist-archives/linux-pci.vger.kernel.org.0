Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0478CB9D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjH2SBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 14:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbjH2SAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 14:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD85D184
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 11:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AFD563175
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 18:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BDEC433C7;
        Tue, 29 Aug 2023 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332046;
        bh=CZlOeBaCLYxheyM4jEejW8guDyP/djRpTW1k22OIKh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=blk1nYXmYC9nvkpbh8pCmMMCWBQX2LeHfFwkHH+On7tcwGEplBB0/96NIHRWximwv
         wuLSBoKEhmxan7wH2LRsvidbOkT90aQsISsNZMJiJ44bWF0qXxDaxJzYbD62ZxtVv/
         qFxPl3lgmtNkR5y/6bWX+n7MGjDmf/WKkLgYPwQiVouXmZE0GJ3EAbCr58oZqYcZst
         AdH8ygQpaja7kQ4bU+vNUlr8Akadk76p65iOOJ3/KGsWAcVb9vYL0XDWmV7dGVm39r
         iq/dZheAMc0X8lgHwG6nyCX1XDOYcmcWehqa+C6TpmpKWT3f5V1LlfPgpbd0Sy46pO
         24WkdFvKzXQfA==
Date:   Tue, 29 Aug 2023 13:00:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Message-ID: <20230829180045.GA800434@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829051022.1328383-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

These settings are negotiated between the OS and the BIOS.  The guest
runs a different BIOS than the host, so why should the guest setting
be related to the host setting?

I'm not a virtualization whiz, and I don't understand all of what's
going on here, so please correct me when I go wrong:

IIUC you need to change the guest behavior.  The guest currently sees
vmd_bridge->native_pcie_hotplug as FALSE, and you need it to be TRUE?
Currently this is copied from the guest's
root_bridge->native_pcie_hotplug, so that must also be FALSE.

I guess the guest sees a fabricated host bridge, which would start
with native_pcie_hotplug as TRUE (from pci_init_host_bridge()), and
then it must be set to FALSE because the guest _OSC didn't grant
ownership to the OS?  (The guest dmesg should show this, right?)

In the guest, vmd_enable_domain() allocates a host bridge via
pci_create_root_bus(), and that would again start with
native_pcie_hotplug as TRUE.  It's not an ACPI host bridge, so I don't
think we do _OSC negotiation for it.  After this patch removes the
copy from the fabricated host bridge, it would be left as TRUE.

If this is on track, it seems like if we want the guest to own PCIe
hotplug, the guest BIOS _OSC for the fabricated host bridge should
grant ownership of it.

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
>  	vmd_bridge->native_aer = root_bridge->native_aer;
>  	vmd_bridge->native_pme = root_bridge->native_pme;
>  	vmd_bridge->native_ltr = root_bridge->native_ltr;
> -- 
> 2.31.1
> 
