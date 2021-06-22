Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130273B0033
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFVJbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 05:31:12 -0400
Received: from foss.arm.com ([217.140.110.172]:45146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFVJbL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 05:31:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 238C4ED1;
        Tue, 22 Jun 2021 02:28:56 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.45.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B3153F718;
        Tue, 22 Jun 2021 02:28:54 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>, stefan@agner.ch,
        l.stach@pengutronix.de, bhelgaas@google.com, kw@linux.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Limit DBI register length for imx6qp PCIe
Date:   Tue, 22 Jun 2021 10:28:45 +0100
Message-Id: <162435409906.28379.3949669734109981179.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1613789388-2495-1-git-send-email-hongxing.zhu@nxp.com>
References: <1613789388-2495-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 20 Feb 2021 10:49:47 +0800, Richard Zhu wrote:
> Changes from v1 to v2:
> - Add reviewed by Lucas and Krzysztof.
> - Refine the subject and commit refer to Krzysztof comments.
> 
> drivers/pci/controller/dwc/pci-imx6.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> [...]

Applied to pci/imx6, thanks!

[1/1] PCI: imx6: Limit DBI register length for imx6qp PCIe
      https://git.kernel.org/lpieralisi/pci/c/36ff5224f1

Thanks,
Lorenzo
