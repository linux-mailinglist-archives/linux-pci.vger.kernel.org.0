Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8C785360
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjHWJBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 05:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjHWIzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 04:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF62126A2
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 01:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 580B66267B
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 08:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0C7C433C7;
        Wed, 23 Aug 2023 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692779983;
        bh=q8QTxSkFDdlVvFJzQ68pK/h0JGpQPINNX67F7iFNkg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUc+Zuub6bzx1IpuoY+kr6XnRwqb9e1WGkC+wqclMmswzQdSMb4rXN7Qp7QHzcb47
         0/FH78o9QxluAcsKYVCDwIZOCKkQfAZQOXfIOvZxItMq1EDypesLwp92Vi6V9C9EI4
         OPt+rrd32mmeC2bNVZnjfDFuE6rnHBpym+hFDHp3MmkSAD9a9yIhqvUYKKW4Zf3l9r
         vEmAcSZBjND2jxlg+mnNCN0yA7Jo5plI8YvAB6X/a7UxhbeOsK6KerejOWJfW3DVHr
         s/rLpokVNzSdgchAZVwM+tj+ZJZZuTh/AqmrpaVHk/MO7owTYobCXH4mVbmMcoKfLy
         MuXbPA1kOvuvg==
Date:   Wed, 23 Aug 2023 10:39:39 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Message-ID: <ZOXFy7WE8VC9eK0i@lpieralisi>
References: <20230822144522.1310839-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822144522.1310839-1-nirmal.patel@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 10:45:22AM -0400, Nirmal Patel wrote:
> The hotplug functionality is broken in various combinations of guest
> OSes i.e. RHEL, SLES and hypervisors i.e. KVM and ESXI.
> 
> During the VMD rootport creation, VMD honors ACPI settings and assigns
> respective values to Hotplug, AER, DPC, PM etc which works in case of
> Host OS. But these have been restored back to the power on default
> state in Guest OSes, which puts the root port hot plug enable to
> default OFF.
> 
> The VMD UEFI driver loads and configure all devices under VMD in Host.
> This is how AER, power management, DPC and Hotplug gets enabled.
> Since the Guest BIOS doesn't have VMD UEFI driver, Hotplug  along with
> DPC, AER, PM are Disabled.
> 
> This change will make the VMD Host and Guest Driver to keep the settings
> implemented by the UEFI VMD DXE driver and thus honoring the user
> selections for Hotplug in the BIOS.

It is still unclear, sorry. AFAICS this patch disables native PCI
hotplug and by doing that it allows the guest kernel to keep the
hotplug functionality as programmed by the UEFI driver (in the BIOS).

Is that what it does ? If so write it in the commit log please.

Describe:

(1) Current Host boot
	(1.1) what UEFI/BIOS does
	(1.2) Resulting VMD PCI hotplug configuration
(2) Current Guest boot
	(2.1) Resulting VMD PCI hotplug configuration
(3) Problem to solve
(4) How you are solving it

Please write it to the commit log and then I will merge it.

Thanks,
Lorenzo

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v2->v3: Update commit log.
> v1->v2: Update commit log.
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
