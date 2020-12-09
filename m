Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283FC2D4BD6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 21:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbgLIU3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 15:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388544AbgLIU3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 15:29:50 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4710EC0613CF
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 12:29:08 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id i24so3014027edj.8
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2020 12:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XvOrQQikyFZP1dk0scKROHnor8nIKA0FBCn4xEGM88M=;
        b=p/Mr4hZKnBQ6uMkLv/CYnrS0YCPHBmDNnePF3xjqOqeLMDfoFmFMHs18zRt3Myy2q/
         dD+l28ROgymioziTk+pCGPXIXK/rxMxy/9S8AMSWXtVoi5dLif9DChBMyVTYo+I+EPGp
         OWtAISkZKGHIOicwWQlnAj584YDSFfW7tDs61pLWm5h1fEwEWN1uvlDIaIsP6Ey8rykh
         EnIVim4eaRKtXZMXL09J8gizza2qhc0k5DovtvsPD2xRy1rTmmOoi6VWuw3oricdB2wd
         3zopf0xJsgRi5vlfM+J8R6Q0EgtRnJB1c9eeBLyhijE3a4v7seo2D2fFtJdplN2/AofW
         iH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XvOrQQikyFZP1dk0scKROHnor8nIKA0FBCn4xEGM88M=;
        b=EBqBdjTItIoH5wukPQhVIapFeFQCgEXLI1m0xOxkvps0zMXkf/ot5IP+tph8a0xMqI
         UY/KrLionga2AQhj1/1lXCfeU5bzYv/0RgbS9Urj/4IgOhzd1HOWre8+r4XqSVGSB8zb
         zR9SWBDaxLs3aUhOqciYoYLpaz50ukPJavBYeDgADbOTySeVBCRa5gSRfQo3dZhgWj9v
         7va6MsD9oG96pAvOs/V2ZXiekzE87ktmQ6fX6tnYn/O1wdQ8NH8IGcEcK5XZ5rww1zew
         cFmelDFtCvZJrCTl2/khGzYV6JlZhCw3ycjxgNlNRKjudf1Dw2ECRTRnuVepxFNvaOY/
         9DSw==
X-Gm-Message-State: AOAM533xU9xprvobHduK9xFbrMvM1THbSmWCeeJfa+ttPvzfYVMPdsDR
        H3fFGcxONO6cxPYGHGG/R2U=
X-Google-Smtp-Source: ABdhPJxJHVQbiVMn08uFjPNqG+711U3u24nhX3cqdu63kSPfA1/wHWjtXpncjioK1RckcCEw9PQcFw==
X-Received: by 2002:a50:d2d2:: with SMTP id q18mr3643551edg.346.1607545746987;
        Wed, 09 Dec 2020 12:29:06 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id z12sm2551375ejr.17.2020.12.09.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:29:06 -0800 (PST)
Date:   Wed, 9 Dec 2020 22:29:04 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, lorenzo.pieralisi@arm.com,
        kw@linux.com, heiko@sntech.de, benh@kernel.crashing.org,
        shawn.lin@rock-chips.com, paulus@samba.org,
        thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de,
        Alexandru Marginean <alexm.osslist@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201209202904.2juzokqhleusgsts@skbuf>
References: <20201209145707.GA2521966@bjorn-Precision-5520>
 <c6d067abcdd5278f259bd7300730dc76@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d067abcdd5278f259bd7300730dc76@walle.cc>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 04:40:52PM +0100, Michael Walle wrote:
> Hopefully my mail client won't mess up the output that much.

I can reproduce on my LS1028A as well. The following fixes the bug for
me. I did not follow the discussion and see if it is helpful for others.
I don't understand how the bug came to be. There might be more to it
than what I'm seeing. If it's just what I'm seeing, then the patch was
pretty broken to begin with.

-----------------------------[cut here]-----------------------------
From b184da4088c9d39d25fee2486941cdf77688a409 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 9 Dec 2020 22:17:32 +0200
Subject: [PATCH] PCI: fix invalid window size for the ECAM config space

The blamed commit forgot that pci_ecam_create() calculates the size of
the window for the ECAM's config space based on the spacing between two
buses. The drivers whose .bus_shift from struct pci_ecam_ops was changed
to zero in this commit are now using this invalid value for bus_shift
in calculating the window size.

Before (broken):
pci_ecam_create: remapping config space from addr 0x1f0000000, bus_range 0x1, bsz 0x1
After (fixed/restored):
pci_ecam_create: remapping config space from addr 0x1f0000000, bus_range 0x1, bsz 0x100000

Fixes: f3c07cf6924e ("PCI: Unify ECAM constants in native PCI Express drivers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/pci/ecam.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 59f91d434859..9fda0d49bc93 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -28,11 +28,19 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 		struct resource *cfgres, struct resource *busr,
 		const struct pci_ecam_ops *ops)
 {
+	unsigned int bus_shift = ops->bus_shift;
 	struct pci_config_window *cfg;
 	unsigned int bus_range, bus_range_max, bsz;
 	struct resource *conflict;
 	int i, err;
 
+	/*
+	 * struct pci_ecam_ops may omit specifying bus_shift
+	 * if it is as per spec
+	 */
+	if (!bus_shift)
+		bus_shift = PCIE_ECAM_BUS_SHIFT;
+
 	if (busr->start > busr->end)
 		return ERR_PTR(-EINVAL);
 
@@ -46,14 +54,14 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	cfg->busr.end = busr->end;
 	cfg->busr.flags = IORESOURCE_BUS;
 	bus_range = resource_size(&cfg->busr);
-	bus_range_max = resource_size(cfgres) >> ops->bus_shift;
+	bus_range_max = resource_size(cfgres) >> bus_shift;
 	if (bus_range > bus_range_max) {
 		bus_range = bus_range_max;
 		cfg->busr.end = busr->start + bus_range - 1;
 		dev_warn(dev, "ECAM area %pR can only accommodate %pR (reduced from %pR desired)\n",
 			 cfgres, &cfg->busr, busr);
 	}
-	bsz = 1 << ops->bus_shift;
+	bsz = 1 << bus_shift;
 
 	cfg->res.start = cfgres->start;
 	cfg->res.end = cfgres->end;
-----------------------------[cut here]-----------------------------
