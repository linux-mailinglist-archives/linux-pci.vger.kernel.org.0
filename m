Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB14652B8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 17:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbhLAQ16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 11:27:58 -0500
Received: from foss.arm.com ([217.140.110.172]:41422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239441AbhLAQ14 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 11:27:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A6B143B;
        Wed,  1 Dec 2021 08:24:35 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.32.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696F43F766;
        Wed,  1 Dec 2021 08:24:33 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v4] PCI: rcar: Check if device is runtime suspended instead of __clk_is_enabled()
Date:   Wed,  1 Dec 2021 16:24:26 +0000
Message-Id: <163837585219.20378.14215787015819697563.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211115204641.12941-1-marek.vasut@gmail.com>
References: <20211115204641.12941-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Nov 2021 21:46:41 +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Replace __clk_is_enabled() with pm_runtime_suspended(),
> as __clk_is_enabled() was checking the wrong bus clock
> and caused the following build error too:
>   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
>   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
> 
> [...]

Applied to pci/rcar, thanks!

[1/1] PCI: rcar: Check if device is runtime suspended instead of __clk_is_enabled()
      https://git.kernel.org/lpieralisi/pci/c/d2a14b5498

Thanks,
Lorenzo
