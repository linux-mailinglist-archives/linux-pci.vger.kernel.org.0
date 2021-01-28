Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA769307216
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 09:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhA1IyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 03:54:17 -0500
Received: from muru.com ([72.249.23.125]:53906 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhA1Ixj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 03:53:39 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BB07E80A9;
        Thu, 28 Jan 2021 08:54:29 +0000 (UTC)
Date:   Thu, 28 Jan 2021 10:54:21 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 01/15] PCI: pci-dra7xx: Prepare for deferred probe with
 module_platform_driver
Message-ID: <YBJ7vUlzfGR89IQH@atomide.com>
References: <20210126124004.52550-1-tony@atomide.com>
 <20210126124004.52550-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126124004.52550-2-tony@atomide.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

* Tony Lindgren <tony@atomide.com> [210126 12:41]:
> After updating pci-dra7xx driver to probe with ti-sysc and genpd, I
> noticed that dra7xx_pcie_probe() would not run if a power-domains property
> was configured for the interconnect target module.
> 
> Turns out that module_platform_driver_probe uses platform_driver_probe(),
> while module_platform_driver_probe uses platform_driver_register().

I just noticed that the above is confusing with module_platform_driver_probe
mentioned twice. It should be:

Turns out that module_platform_driver_probe uses platform_driver_probe(),
while builtin_platform_driver uses platform_driver_register().

Regards,

Tony
