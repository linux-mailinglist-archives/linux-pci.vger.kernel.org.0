Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8EF3B0152
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVK3B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 06:29:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhFVK3B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 06:29:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98F1E11D4;
        Tue, 22 Jun 2021 03:26:45 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.45.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66FFA3F694;
        Tue, 22 Jun 2021 03:26:40 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     stefan@agner.ch, shawnguo@kernel.org, andrew.smirnov@gmail.com,
        kw@linux.com, bhelgaas@google.com, l.stach@pengutronix.de,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [RESEND, V5 0/2] add one regulator used to power up pcie phy
Date:   Tue, 22 Jun 2021 11:26:34 +0100
Message-Id: <162435757430.23554.7915398163187258032.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1622771269-13844-1-git-send-email-hongxing.zhu@nxp.com>
References: <1622771269-13844-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 4 Jun 2021 09:47:47 +0800, Richard Zhu wrote:
> Changes v4->v5:
> - Refine the commit logs refer to bhelgaas' comments.
> - Resend v5 patch-set after CC "devicetree@vger.kernel.org"
> in the mail-list.
> 
> v4:
> https://patchwork.kernel.org/project/linux-pci/patch/1617091701-6444-2-git-send-email-hongxing.zhu@nxp.com/
> 
> [...]

Applied to pci/imx6, thanks!

[1/2] dt-bindings: imx6q-pcie: Add "vph-supply" for PHY supply voltage
      https://git.kernel.org/lpieralisi/pci/c/6d78fb2ea5
[2/2] PCI: imx6: Enable PHY internal regulator when supplied >3V
      https://git.kernel.org/lpieralisi/pci/c/a9560daaa3

Thanks,
Lorenzo
