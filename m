Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24A422195
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhJEJEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 05:04:06 -0400
Received: from foss.arm.com ([217.140.110.172]:55834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233365AbhJEJEF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 05:04:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D5336D;
        Tue,  5 Oct 2021 02:02:14 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.51.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02CD93F66F;
        Tue,  5 Oct 2021 02:02:12 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: pcie-rcar-ep: Remove unneeded includes
Date:   Tue,  5 Oct 2021 10:02:07 +0100
Message-Id: <163342451358.26857.6595725847149939957.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <7c708841a2bf84f85b14a963271c3e99c8ba38a5.1633090444.git.geert+renesas@glider.be>
References: <7c708841a2bf84f85b14a963271c3e99c8ba38a5.1633090444.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 1 Oct 2021 14:16:09 +0200, Geert Uytterhoeven wrote:
> Remove includes that are not needed, to speed up (re)compilation.
> Include <linux/pm_runtime.h>, which is needed, and was included
> implicitly through <linux/phy/phy.h> before.
> 
> Most of these are relics from splitting the driver in a host and a
> common part, and adding endpoint support.
> 
> [...]

Applied to pci/rcar, thanks!

[1/1] PCI: rcar: pcie-rcar-ep: Remove unneeded includes
      https://git.kernel.org/lpieralisi/pci/c/ea52bd3459

Thanks,
Lorenzo
