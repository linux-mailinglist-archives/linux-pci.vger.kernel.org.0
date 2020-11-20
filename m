Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4305E2BB116
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgKTQ5k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 11:57:40 -0500
Received: from foss.arm.com ([217.140.110.172]:52484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgKTQ5k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 11:57:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714C01042;
        Fri, 20 Nov 2020 08:57:39 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.59.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F7E3F70D;
        Fri, 20 Nov 2020 08:57:37 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar-host: Drop unused members from struct rcar_pcie_host
Date:   Fri, 20 Nov 2020 16:57:25 +0000
Message-Id: <160589135951.28652.16815637433396377893.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201023162008.967-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201023162008.967-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 23 Oct 2020 17:20:08 +0100, Lad Prabhakar wrote:
> Drop unused members dev and base from struct rcar_pcie_host.

Applied to pci/rcar, thanks!

[1/1] PCI: rcar: Drop unused members from struct rcar_pcie_host
      https://git.kernel.org/lpieralisi/pci/c/6e8e137abe

Thanks,
Lorenzo
