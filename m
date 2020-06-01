Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA41EA7D6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgFAQbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 12:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAQbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 12:31:38 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801822073B;
        Mon,  1 Jun 2020 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591029098;
        bh=GVYGeNvhpUxVS39NQZztMXeHWSAvoW5iFB39Nc4Hd1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KBSD6sTg4RH9d2Gr1S/wmfLyQj1AlU0rgAcClAIpyXqMw1km4fEsSKox3ZnQnRokv
         co3JDSJleprEschPn7lUbgWNB8pACiVC56U4MnrOEYiKbEQagElczE5iO5PyWZCn6F
         gXkUduaN0Lq79RCPnJSiVNDdLtAyWt0jfwELCyMc=
Date:   Mon, 1 Jun 2020 11:31:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/4] PCI/ASPM: Don't select CONFIG_PCIEASPM by default
Message-ID: <20200601163134.GA724675@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415001244.144623-5-helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 14, 2020 at 07:12:44PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCIe Active State Power Management (ASPM) is optional and there's no need
> for it to be selected by default.
> 
> Remove the "default y" for CONFIG_PCIEASPM.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>

I dropped this patch for now.

Without CONFIG_PCIEASPM, Linux doesn't request control of *any*
features via _OSC (see ACPI_PCIE_REQ_SUPPORT), which means we can't
use PCIe PME to resume from runtime suspend.

https://bugzilla.redhat.com/show_bug.cgi?id=638912
https://lore.kernel.org/r/2e1ee784-7493-284b-96f9-96b2e0c4b817@gmail.com

> ---
>  drivers/pci/pcie/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 9cd31331aee9..5b7b460a8a98 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -62,7 +62,6 @@ config PCIE_ECRC
>  #
>  config PCIEASPM
>  	bool "PCI Express ASPM control" if EXPERT
> -	default y
>  	help
>  	  This enables OS control over PCI Express ASPM (Active State
>  	  Power Management) and Clock Power Management. ASPM supports
> -- 
> 2.26.0.110.g2183baf09c-goog
> 
