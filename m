Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A86E2843
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 04:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406470AbfJXChM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 22:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406322AbfJXChM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 22:37:12 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9087E205ED;
        Thu, 24 Oct 2019 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571884631;
        bh=jzD/o5fFFKb4zWGB61Nq3oM/Rw9gexxnXww5qQGCnnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGHV+0RWpDokCcVFBTQ6ochibC6yeFefd3NENUYBx6NKaKfgAIC2LHU+i/Z0boyx6
         QhDrVJegviiXyxWzpUxADfgu+OjZf6JsncZvsO8Db7CLGgVT6LYPBaP/5hJzfA7hBK
         OSTURxqzz7+fkE7m8UtdRxnKX+NTmYA8LtNgTeKI=
Date:   Thu, 24 Oct 2019 11:37:04 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring
 back old behavior
Message-ID: <20191024023704.GA3152@redsun51.ssa.fujisawa.hgst.com>
References: <20191023192205.97024-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023192205.97024-1-olof@lixom.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 12:22:05PM -0700, Olof Johansson wrote:
> In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
> the behavior was changed such that native (kernel) handling of DPC
> got tied to whether the kernel also handled AER. While this is what
> the standard recommends, there are BIOSes out there that lack the DPC
> handling since it was never required in the past.
> 
> To make DPC still work on said platforms the same way they did before,
> add a "pcie_ports=dpc-native" kernel parameter that can be passed in
> if needed, while keeping defaults unchanged.

If platform firmware wants to handle AER events, but the kernel enables
the DPC capability, the ports will be trapping events that firmware is
expecting to handle. Not that that's a bad thing: firmware is generally
worse at handling these errors.

> +/*
> + * If the user specified "pcie_ports=dpc-native", use the PCIe services
> + * for DPC, but cuse platform defaults for the others.

s/cuse/use

> @@ -1534,9 +1534,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>  #ifdef CONFIG_PCIEPORTBUS
>  extern bool pcie_ports_disabled;
>  extern bool pcie_ports_native;
> +extern bool pcie_ports_dpc_native;
>  #else
>  #define pcie_ports_disabled	true
>  #define pcie_ports_native	false
> +#define pcie_ports_dpc_native	false
>  #endif

You do not have any references to pcie_ports_dpc_native outside of files that
require CONFIG_PCIEPORTBUS, so no need to define a default.
