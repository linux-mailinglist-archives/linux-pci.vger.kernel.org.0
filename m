Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51B72890B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 21:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjFHTwt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjFHTws (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 15:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C0C2D52
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 12:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A026187D
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 19:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A67C433D2;
        Thu,  8 Jun 2023 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686253963;
        bh=VJNbfl7ur9asyNZBqTr7SnXNe0VdqWbZjoHtSp9mbDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KxAxzHcyP9KgJs1oCW2E0PJKveamozbtzTq0toPwxSwPMJZsVS6+BlnbrrvG5eASB
         ad8kQD2WITB/hrP+6UqfI2bKHDpC0M2spiobAkjoKF9jwdyBSQC9DC+ipJzILHppso
         2qdIWzE0RgVkqrSigmvJepxOYv1udyQOD7DN6eBeDyDyRZsUleoeSDawglAzQEQFIa
         l6eryb+mxYAt97ETvmWLsssm0E3KYMSeLCaBuE7w4MIXGXWG7BGOmLmpDMuBCCIb+b
         64AzN0Y5bUNPRNnwuAdDgqLj1vMrR8hqvI6xOiROhNItZPE7n3t9awhk0hb1QdptZf
         M54fBkYtoN02g==
Date:   Thu, 8 Jun 2023 14:52:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiwu Zhang <shiwu.zhang@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH] drm/amdgpu: add the accelerator pcie class
Message-ID: <20230608195242.GA1211647@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523040232.21756-1-shiwu.zhang@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/pcie/PCIe/ in the subject.

On Tue, May 23, 2023 at 12:02:32PM +0800, Shiwu Zhang wrote:
> v2: add the base class id for accelerator (lijo)

Please include a commit log.  For PCI, the "v2: ..." stuff would go
below the "---" so it doesn't get included in the git commit.  I don't
know what the DRM convention is.

It's OK if the commit log repeats the subject.  The subject is like
the title of a story -- it's not the first sentence of the story.

Please include a spec citation for the PCI_BASE_CLASS_ACCELERATOR
values in the commit log.  I think it's something like "PCI Code and
ID Assignment, r1.9, sec 1, 1.19".

> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> Acked-by: Lijo Lazar <lijo.lazar@amd.com>

With the above:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_ids.h

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>  include/linux/pci_ids.h                 | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3d91e123f9bd..5d652e6f0b1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2042,6 +2042,11 @@ static const struct pci_device_id pciidlist[] = {
>  	  .class_mask = 0xffffff,
>  	  .driver_data = CHIP_IP_DISCOVERY },
>  
> +	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
> +	  .class = PCI_CLASS_ACCELERATOR_PROCESSING << 8,
> +	  .class_mask = 0xffffff,
> +	  .driver_data = CHIP_IP_DISCOVERY },
> +
>  	{0, 0, 0}
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b0..4918ff26a987 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -151,6 +151,9 @@
>  #define PCI_CLASS_SP_DPIO		0x1100
>  #define PCI_CLASS_SP_OTHER		0x1180
>  
> +#define PCI_BASE_CLASS_ACCELERATOR	0x12
> +#define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
> +
>  #define PCI_CLASS_OTHERS		0xff
>  
>  /* Vendors and devices.  Sort key: vendor first, device next. */
> -- 
> 2.17.1
> 
