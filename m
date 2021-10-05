Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A54221A4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhJEJGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 05:06:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232167AbhJEJGe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 05:06:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B42636D;
        Tue,  5 Oct 2021 02:04:43 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.51.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B68D3F66F;
        Tue,  5 Oct 2021 02:04:42 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: pcie-rcar-host: Remove unneeded includes
Date:   Tue,  5 Oct 2021 10:04:00 +0100
Message-Id: <163342462761.27889.12032524904883921351.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <54bed9a0e6991490ddb2b07e5abfaf40a7a62928.1633090577.git.geert+renesas@glider.be>
References: <54bed9a0e6991490ddb2b07e5abfaf40a7a62928.1633090577.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 1 Oct 2021 14:16:43 +0200, Geert Uytterhoeven wrote:
> Remove includes that are not needed, to speed up (re)compilation.
> 
> Most of these are relics from splitting the driver in a host and a
> common part.
> 
> 

Applied to pci/rcar, thanks!

[1/1] PCI: rcar: pcie-rcar-host: Remove unneeded includes
      https://git.kernel.org/lpieralisi/pci/c/38d79c556f

Thanks,
Lorenzo
