Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E7F2F7865
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 13:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbhAOMN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 07:13:56 -0500
Received: from foss.arm.com ([217.140.110.172]:37378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbhAOMNz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Jan 2021 07:13:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03365ED1;
        Fri, 15 Jan 2021 04:13:10 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.39.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2E223F70D;
        Fri, 15 Jan 2021 04:13:08 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
Date:   Fri, 15 Jan 2021 12:12:54 +0000
Message-Id: <161071270539.14930.6952855162402367410.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201016120431.7062-1-marek.vasut@gmail.com>
References: <20201016120431.7062-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 16 Oct 2020 14:04:31 +0200, marek.vasut@gmail.com wrote:
> This fixes MSI operation on legacy PCI cards, which cannot issue 64bit MSIs.
> The R-Car controller only has one MSI trigger address instead of two, one
> for 64bit and one for 32bit MSI, set the address to 32bit PCIe space so that
> legacy PCI cards can also trigger MSIs.

Applied to pci/rcar, thanks!

[1/1] PCI: rcar: Always allocate MSI addresses in 32bit space
      https://git.kernel.org/lpieralisi/pci/c/c4e0fec2f7

Thanks,
Lorenzo
