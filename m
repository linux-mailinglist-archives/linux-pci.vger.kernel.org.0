Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C8D117191
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLIQ0w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 11:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfLIQ0w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 11:26:52 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839772080D;
        Mon,  9 Dec 2019 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575908811;
        bh=XmMuS1tdYvjAP/dOf3MN6vwqugHg0P62ECl8srBnh14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOU+VVGKwRrsQ0D+daeQ+x/xsP+ATGq5Wl9RqLMP25OEiY225038UWy37UJhw427c
         daPKborkT9vmKrlKEnjdHU05mgGRcG8eVRcpb/wMvX8g9vmrQcTXv0EFF7BeKw12Kf
         l0lhHe8IOzGxUjarOFoGOoeadP8wDld7a054/8Sc=
Date:   Mon, 9 Dec 2019 16:26:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
Message-ID: <20191209162645.GA7489@willie-the-truck>
References: <20191209160638.141431-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209160638.141431-1-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:
> From: Deepak Pandey <Deepak.Pandey@arm.com>
> 
> The Arm N1SDP SoC suffers from some PCIe integration issues, most
> prominently config space accesses to not existing BDFs being answered
> with a bus abort, resulting in an SError.

"Do as I say, not as I do"?

> To mitigate this, the firmware scans the bus before boot (catching the
> SErrors) and creates a table with valid BDFs, which acts as a filter for
> Linux' config space accesses.
> 
> Add code consulting the table as an ACPI PCIe quirk, also register the
> corresponding device tree based description of the host controller.
> Also fix the other two minor issues on the way, namely not being fully
> ECAM compliant and config space accesses being restricted to 32-bit
> accesses only.
> 
> This allows the Arm Neoverse N1SDP board to boot Linux without crashing
> and to access *any* devices (there are no platform devices except UART).
> 
> Signed-off-by: Deepak Pandey <Deepak.Pandey@arm.com>
> [Sudipto: extend to cover the CCIX root port as well]
> Signed-off-by: Sudipto Paul <sudipto.paul@arm.com>
> [Andre: fix coding style issues, rewrite some parts, add DT support]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/configs/defconfig        |   1 +
>  drivers/acpi/pci_mcfg.c             |   7 +
>  drivers/pci/controller/Kconfig      |  11 ++
>  drivers/pci/controller/Makefile     |   1 +
>  drivers/pci/controller/pcie-n1sdp.c | 196 ++++++++++++++++++++++++++++
>  include/linux/pci-ecam.h            |   2 +
>  6 files changed, 218 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-n1sdp.c

Where can I buy one of these? They're "unreleased" according to:

https://community.arm.com/developer/tools-software/oss-platforms/w/docs/440/neoverse-n1-sdp

and I don't think we should wreck upstream because of a platform that
doesn't exist.

Will
