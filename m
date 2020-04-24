Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978BD1B7F0C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgDXTee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 15:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgDXTee (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 15:34:34 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C4C21569;
        Fri, 24 Apr 2020 19:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587756873;
        bh=XlN3/cmmeMS6sOumJroNKLPNJ7h8Pi2dg4csqdNF2cQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bpR8TYz/0BBtfr53mlK6vrBtW/HFW459GBBgCHzAyT9H/BZbkUC6zVbF2bmWr88UR
         Rlr1XcaZBUgVdquVEZcVLp68Z1isLJnCMPALR1T1zq4P3cXxBvnM/J9kg1FDVvXMmm
         VprYO35Picq6dlrBZ4+o8K6dsRqMCTr28uYyugQo=
Date:   Fri, 24 Apr 2020 14:34:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/PM: Call .bridge_d3() hook only if non-NULL
Message-ID: <20200424193432.GA178780@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415000635.144283-1-helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 14, 2020 at 07:06:35PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") added
> the struct pci_platform_pm_ops.bridge_d3() function pointer and
> platform_pci_bridge_d3() to use it.
> 
> The .bridge_d3() op is implemented by acpi_pci_platform_pm, but not by
> mid_pci_platform_pm.  We don't expect platform_pci_bridge_d3() to be called
> on Intel MID platforms, but nothing in the code itself would prevent that.
> 
> Check the .bridge_d3() pointer for NULL before calling it.
> 
> Fixes: 26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied with Mika's reviewed-by to pci/pm for v5.8.

> ---
>  drivers/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 595fcf59843f..dfa7ec008963 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -868,7 +868,9 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
>  
>  static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  {
> -	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
> +	if (pci_platform_pm && pci_platform_pm->bridge_d3)
> +		return pci_platform_pm->bridge_d3(dev);
> +	return false;
>  }
>  
>  /**
> -- 
> 2.26.0.110.g2183baf09c-goog
> 
