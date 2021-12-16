Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD76476EEF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 11:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhLPKeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 05:34:07 -0500
Received: from foss.arm.com ([217.140.110.172]:41680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbhLPKeG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Dec 2021 05:34:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C8A1474;
        Thu, 16 Dec 2021 02:34:06 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.36.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 450473F774;
        Thu, 16 Dec 2021 02:34:02 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     vkoul@kernel.org, tharvey@gateworks.com, robh@kernel.org,
        l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        bhelgaas@google.com, marcel.ziswiler@toradex.com, kishon@ti.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-phy@lists.infradead.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/8] Add the imx8m pcie phy driver and imx8mm pcie support
Date:   Thu, 16 Dec 2021 10:33:51 +0000
Message-Id: <163965080404.20006.5241609551643501749.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2 Dec 2021 16:02:30 +0800, Richard Zhu wrote:
> Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> one standalone PCIe PHY driver should be seperated from i.MX PCIe
> driver when enable i.MX8MM PCIe support.
> 
> This patch-set adds the standalone PCIe PHY driver suport[1-5], and i.MX8MM
> PCIe support[6-8] to have whole view to review this patch-set.
> 
> [...]

Applied to pci/dwc, thanks!

[3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name properties
      https://git.kernel.org/lpieralisi/pci/c/3e15f623bb
[8/8] PCI: imx: Add the imx8mm pcie support
      https://git.kernel.org/lpieralisi/pci/c/d5a8dec49b

Thanks,
Lorenzo
