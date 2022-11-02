Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7B6172FC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 00:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKBXpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 19:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBXpP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 19:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9946455
        for <linux-pci@vger.kernel.org>; Wed,  2 Nov 2022 16:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78C9361C83
        for <linux-pci@vger.kernel.org>; Wed,  2 Nov 2022 23:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91A7C433D6;
        Wed,  2 Nov 2022 23:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667432542;
        bh=455Cu4D71HuazAlAm2UNip7yTxEBIKjaFHgDNfbLmWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cM3bUA4e1vObYJIurQAxk676Ktef1WfeT316vF3csdwIJBVYf2APZndJaA4vHqg8N
         1HbLxDOpBrxSqpmaDZnpIrjYBllnchqaT08Xg58+YH/8jZLKxS1qPybhenacc9aaO1
         f71dFmpch375i39ItJJFoeYvUEVSxCpqLDYGxMTwYx/ByOdgNsFlRdmgLOcrQt2MgX
         Na6BSERVVD/L3kKGVArbbnRKXUSPOblDD4PTDWkO2K6ozqyAXCUxEMQqsLHcVNdsTs
         ozQXfBggT/6bPhPUkvB3MG/UHHDw84dPuJmuaXZew0DTF9NE747vlQmw11nBM9BuVa
         IVsqho0j85Y6Q==
Date:   Wed, 2 Nov 2022 18:42:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     francisco.munoz.ruiz@linux.intel.com
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH V2] PCI: vmd: Fix secondary bus reset for Intel bridges
Message-ID: <20221102234221.GA8153@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031214501.28279-1-francisco.munoz.ruiz@linux.intel.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Myron]

On Mon, Oct 31, 2022 at 02:45:01PM -0700, francisco.munoz.ruiz@linux.intel.com wrote:
> From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> 
> The reset was never applied in the current implementation because Intel
> Bridges owned by VMD are parentless. Internally, pci_reset_bus applies
> a reset to the parent of the pci device supplied as argument, but in this
> case it failed because there wasn't a parent.
> 
> In more detail, this change allows the VMD driver to enumerate NVMe devices
> in pass-through configurations when host reboots are performed. Commit id
> “6aab5622296b990024ee67dd7efa7d143e7558d0” attempted to fix this, but
> later we discovered that the code inside pci_reset_bus wasn’t triggering
> secondary bus resets.  Therefore, we updated the parameters passed to
> it, and now NVMe SSDs attached to VMD bridges are properly enumerated in
> VT-d pass-through scenarios.

Did you mean "guest reboots" above?  If the *host* reboots, I assume
everybody (host and guests) starts over, so a reset wouldn't really
apply.

Is the scenario that the VMD device is passed through to a guest, and
the guest OS is running vmd_probe() and vmd_enable_domain()?

I thought VFIO already had something to reset devices between guests.
But maybe this is different because from the point of view of VFIO,
the pass-through happens only once, and during that single session,
the guest OS reboots several times, so you want vmd_probe() to reset
the downstream devices?

Should this have a Fixes: tag for 6aab5622296b?

s/pci/PCI/ above in English text.

Also add "()" after function names.

Use the typical 12-char SHA1 + subject citation, e.g., 6aab5622296b
("PCI: vmd: Clean up domain before enumeration").

> Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e06e9f4fc50f..34d6ba675440 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -859,8 +859,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	pci_scan_child_bus(vmd->bus);
>  	vmd_domain_reset(vmd);
> -	list_for_each_entry(child, &vmd->bus->children, node)
> -		pci_reset_bus(child->self);
> +
> +	list_for_each_entry(child, &vmd->bus->children, node) {
> +		if (!list_empty(&child->devices)) {
> +			pci_reset_bus(list_first_entry(&child->devices,
> +						       struct pci_dev,
> +						       bus_list));
> +			break;
> +		}
> +	}
> +
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
>  	/*
> -- 
> 2.25.1
> 
> Hi Bjorn,
> 
> I updated the commit message with more details. Hopefully, this will 
> clarify its purpose.
> 
> Thanks,
> Francisco.
