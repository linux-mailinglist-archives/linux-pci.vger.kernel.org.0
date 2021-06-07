Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2339E9FD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 01:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFGXTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 19:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhFGXTD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 19:19:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8212610E5;
        Mon,  7 Jun 2021 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623107832;
        bh=5YBJ3ZGmylsFEQqB7/z0jRfb00GGp7AJqiDfJuVstXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j+fHvT9Fw3GihSK/FrJ/ocFxJQ9lQ5NGMeWS7aHEBTqipqnFw222U5D54BIJ9fahO
         iitNL3KqhcPqSErvqty+lmcJnTmOcpG3/5WXTL755vc3tz3faXUxKCNa85ZZYhuv1+
         F6r4fJ7l++wEMN8Gdb75WpfJ4PalMfdzI+X4x6o5Jiwud2Q1J8VQG/Vmfi8Wc1rfyZ
         G3hUEuQRsh+jz3Klme2yw5LC4nUTWCefpIlBawCGo+9+21/pK98v7l2DebMN8vKftD
         bcACHADAqVztggjvuI7KtLUHajfg3+JKRq4E5m0jBlDybMyguw3/ODNNwWa/txyXL5
         rPWb3fMoDcqYA==
Date:   Mon, 7 Jun 2021 18:17:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Konstantin Kharlamov <Hi-Angel@yandex.ru>
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210607231710.GA2539577@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506173820.21876-1-Hi-Angel@yandex.ru>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, Rafael, Andreas, linux-pm]

On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> On Macbook 2013 resuming from s2idle results in external monitor no
> longer being detected, and dmesg having errors like:
> 
>     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> 
> and a stacktrace. The reason turned out that the hw that the quirk
> powers off does not get powered on back on resume.
> 
> Thus, add a check for s2idle to the quirk, and do nothing if the suspend
> mode is s2idle.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
> Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>

Applied as below to pci/pm for v5.14, thanks!

> ---
>  drivers/pci/quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..86fedcec37e2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -27,6 +27,7 @@
>  #include <linux/nvme.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/suspend.h>
>  #include <linux/switchtec.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
> @@ -3646,6 +3647,13 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>  		return;
>  	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
>  		return;
> +
> +	/*
> +	 * If suspend mode is s2idle, power won't get restored on resume.
> +	 */
> +	if (!pm_suspend_via_firmware())
> +		return;
> +
>  	bridge = ACPI_HANDLE(&dev->dev);
>  	if (!bridge)
>  		return;
> 

commit 4694ae373dc2 ("PCI: Leave Apple Thunderbolt controllers on for s2idle or standby")
Author: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Date:   Fri May 21 02:55:01 2021 +0300

    PCI: Leave Apple Thunderbolt controllers on for s2idle or standby
    
    On Macbook 2013, resuming from suspend-to-idle or standby resulted in the
    external monitor no longer being detected, a stacktrace, and errors like
    this in dmesg:
    
      pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)
    
    The reason is that we know how to turn power to the Thunderbolt controller
    *off* via the SXIO/SXFP/SXLF methods, but we don't know how to turn power
    back on.  We have to rely on firmware to turn the power back on.
    
    When going to the "suspend-to-idle" or "standby" system sleep states,
    firmware is not involved either on the suspend side or the resume side, so
    we can't use SXIO/SXFP/SXLF to turn the power off.
    
    Skip SXIO/SXFP/SXLF when firmware isn't involved in suspend, e.g., when
    we're going to the "suspend-to-idle" or "standby" system sleep states.
    
    Fixes: 1df5172c5c25 ("PCI: Suspend/resume quirks for Apple thunderbolt")
    Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
    Link: https://lore.kernel.org/r/20210520235501.917397-1-Hi-Angel@yandex.ru
    Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Lukas Wunner <lukas@wunner.de>
    Cc: stable@vger.kernel.org

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dcb229de1acb..0dde9c5259f2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -27,6 +27,7 @@
 #include <linux/nvme.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
+#include <linux/suspend.h>
 #include <linux/switchtec.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
@@ -3634,6 +3635,16 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 		return;
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
 		return;
+
+	/*
+	 * SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.
+	 * We don't know how to turn it back on again, but firmware does,
+	 * so we can only use SXIO/SXFP/SXLF if we're suspending via
+	 * firmware.
+	 */
+	if (!pm_suspend_via_firmware())
+		return;
+
 	bridge = ACPI_HANDLE(&dev->dev);
 	if (!bridge)
 		return;
