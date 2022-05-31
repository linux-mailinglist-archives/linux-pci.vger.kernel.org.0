Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44925397BA
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 22:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347531AbiEaUDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiEaUDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 16:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AED3BA7A;
        Tue, 31 May 2022 13:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5886AB810F1;
        Tue, 31 May 2022 20:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5054C385A9;
        Tue, 31 May 2022 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654027426;
        bh=Pfk28myHk/3Cvx3u7P+lbHGdGSulMgPmZyXSWfrF0qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WotY6DJAm+Qfsztc9Kj+2n9uGNuzFmnsxvOxOxOpTo3bck4G19bk0xzCrWUSGjYnd
         FNptSvijMh56NRbulr+d4y/M0KGaQfFT3b+S8LIHEZLwq80ueGIHnMoHAR8ZHCeadr
         gIFrMGhClQKhZfPU38kS1iq1w+WA5BxnINQ5j3QYFillDuWRrNI7G+uCYgAEtzuzaf
         mCiM+cjxWIXrpo1bBgFSeNsUX0CzgKAP2hjunFaaoQ1pk4Abrwjb4sNC8EVJjky3ju
         QpCwKE44aRO9Nwpu6jZzAuJ0yIpAOwvJEtZcbjK4MTXABMglcC678ZL7olTvytAEfN
         BEvK3VWjWoI4w==
Date:   Tue, 31 May 2022 15:03:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address to @kernel.org
Message-ID: <20220531200344.GA778872@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220528151411.29810-1-lorenzo.pieralisi@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 28, 2022 at 04:14:11PM +0100, Lorenzo Pieralisi wrote:
> I will soon lose my @arm.com email address, so to prevent any possible
> issue let's update all kernel references (inclusive of .mailmap) to my
> @kernel.org alias ahead of time.
> 
> My @arm.com address is still working and will likely resume to work at
> some point in the future; nonetheless, it is safer to switch to the
> @kernel.org alias from now onwards so that continuity is guaranteed.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Applied to for-linus for v5.19, thanks!

> ---
>  .mailmap    |  1 +
>  MAINTAINERS | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6d484937f901..9ba38a82aba4 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -236,6 +236,7 @@ Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
>  <linux-hardening@vger.kernel.org> <kernel-hardening@lists.openwall.com>
>  Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
>  Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
> +Lorenzo Pieralisi <lpieralisi@kernel.org> <lorenzo.pieralisi@arm.com>
>  Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
>  Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
>  Maciej W. Rozycki <macro@orcam.me.uk> <macro@linux-mips.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 392467e9ab73..4fa6a8da4b83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -382,7 +382,7 @@ F:	include/acpi/
>  F:	tools/power/acpi/
>  
>  ACPI FOR ARM64 (ACPI/arm64)
> -M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:	Hanjun Guo <guohanjun@huawei.com>
>  M:	Sudeep Holla <sudeep.holla@arm.com>
>  L:	linux-acpi@vger.kernel.org
> @@ -2946,7 +2946,7 @@ N:	uniphier
>  ARM/VERSATILE EXPRESS PLATFORM
>  M:	Liviu Dudau <liviu.dudau@arm.com>
>  M:	Sudeep Holla <sudeep.holla@arm.com>
> -M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	*/*/*/vexpress*
> @@ -5162,7 +5162,7 @@ F:	arch/x86/kernel/cpuid.c
>  F:	arch/x86/kernel/msr.c
>  
>  CPUIDLE DRIVER - ARM BIG LITTLE
> -M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:	Daniel Lezcano <daniel.lezcano@linaro.org>
>  L:	linux-pm@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> @@ -5182,7 +5182,7 @@ F:	drivers/cpuidle/cpuidle-exynos.c
>  F:	include/linux/platform_data/cpuidle-exynos.h
>  
>  CPUIDLE DRIVER - ARM PSCI
> -M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:	Sudeep Holla <sudeep.holla@arm.com>
>  L:	linux-pm@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> @@ -15289,7 +15289,7 @@ F:	drivers/pci/controller/pci-v3-semi.c
>  
>  PCI ENDPOINT SUBSYSTEM
>  M:	Kishon Vijay Abraham I <kishon@ti.com>
> -M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> @@ -15352,7 +15352,7 @@ F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
>  F:	drivers/pci/controller/pci-xgene-msi.c
>  
>  PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
> -M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  R:	Rob Herring <robh@kernel.org>
>  R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
> @@ -15905,7 +15905,7 @@ F:	include/linux/dtpm.h
>  
>  POWER STATE COORDINATION INTERFACE (PSCI)
>  M:	Mark Rutland <mark.rutland@arm.com>
> -M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	drivers/firmware/psci/
> @@ -18277,7 +18277,7 @@ F:	drivers/net/ethernet/smsc/smc91x.*
>  
>  SECURE MONITOR CALL(SMC) CALLING CONVENTION (SMCCC)
>  M:	Mark Rutland <mark.rutland@arm.com>
> -M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:	Sudeep Holla <sudeep.holla@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -- 
> 2.31.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
