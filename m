Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3348CF8B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 01:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiAMAIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 19:08:11 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39020 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiAMAIK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 19:08:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D90DCE0D86
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 00:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A06C36AE5;
        Thu, 13 Jan 2022 00:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642032487;
        bh=MDgHuDUKkZpA7YOw1v3XLpNUYIpHVwXXwUpwObv/ol8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h3ltMKmCmD3tevTq6L9VPtrq5sYLCo/U0POpi8VL9a2TmkgwbC8Swvq3Xo9ReOt2O
         HMCmB9EgV/+VYk/je+wteTDfdS/9v8OCuAXTXKOpd9HYDLlZo2HfOWnDPhW/mHL0+p
         uFJI+i6BMvCgvGGgXmqHspibjHlaG8b+XKNGEEcfMtoJ7Lz1LT/Tti9R8Gic0uQC1F
         O+8khN3dv34B4NeS9F9azDXOJPNgV2czoN8IzXkW5S3GFMHlsmJh6N3Y8Eks1/UDz7
         fXm8oUvW0gKWoD20C/bNxcAoV6SjptP7J35A8L45dU7fIe6yinZpvUFiQEjw7qUmFj
         ald+NR5l2MqRg==
Date:   Wed, 12 Jan 2022 18:08:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Intel-gfx] [PATCH v4] x86/quirks: Replace QFLAG_APPLY_ONCE with
 static locals
Message-ID: <20220113000805.GA295089@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112233043.1865454-1-lucas.demarchi@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 03:30:43PM -0800, Lucas De Marchi wrote:
> The flags are only used to mark a quirk to be called once and nothing
> else. Also, that logic may not be appropriate if the quirk wants to
> do additional filtering and set quirk as applied by itself.
> 
> So replace the uses of QFLAG_APPLY_ONCE with static local variables in
> the few quirks that use this logic and remove all the flags logic.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Only occurred to me now, but another, less intrusive approach would be
to just remove QFLAG_APPLY_ONCE from intel_graphics_quirks() and do
its bookkeeping internally, e.g.,

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 391a4e2b8604..7b655004e5fd 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -587,10 +587,14 @@ intel_graphics_stolen(int num, int slot, int func,
 
 static void __init intel_graphics_quirks(int num, int slot, int func)
 {
+	static bool stolen __initdata = false;
 	const struct intel_early_ops *early_ops;
 	u16 device;
 	int i;
 
+	if (stolen)
+		return;
+
 	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
 
 	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
@@ -602,6 +606,7 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
 		early_ops = (typeof(early_ops))driver_data;
 
 		intel_graphics_stolen(num, slot, func, early_ops);
+		stolen = true;
 
 		return;
 	}
@@ -703,7 +708,7 @@ static struct chipset early_qrk[] __initdata = {
 	{ PCI_VENDOR_ID_INTEL, 0x3406, PCI_CLASS_BRIDGE_HOST,
 	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA, PCI_ANY_ID,
-	  QFLAG_APPLY_ONCE, intel_graphics_quirks },
+	  0, intel_graphics_quirks },
 	/*
 	 * HPET on the current version of the Baytrail platform has accuracy
 	 * problems: it will halt in deep idle state - so we disable it.
