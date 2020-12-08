Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C162D2D7F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 15:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgLHOtS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 09:49:18 -0500
Received: from foss.arm.com ([217.140.110.172]:50044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgLHOtS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 09:49:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5605830E;
        Tue,  8 Dec 2020 06:48:32 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.35.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D39B3F718;
        Tue,  8 Dec 2020 06:48:30 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        truong@codeaurora.org, bjorn.andersson@linaro.org,
        bhelgaas@google.com, agross@kernel.org
Subject: Re: [PATCH v6 0/3] Add PCIe support for SM8250 SoC
Date:   Tue,  8 Dec 2020 14:48:23 +0000
Message-Id: <160743888873.26304.531428152524309821.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201208121402.178011-1-mani@kernel.org>
References: <20201208121402.178011-1-mani@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 8 Dec 2020 17:43:59 +0530, Manivannan Sadhasivam wrote:
> This series adds PCIe support for Qualcomm SM8250 SoC with relevant PHYs.
> There are 3 PCIe instances on this SoC each with different PHYs. The PCIe
> controller and PHYs are mostly comaptible with the ones found on SDM845
> SoC, hence the old drivers are modified to add the support.
> 
> This series has been tested on RB5 board with QCA6391 chipset connected
> onboard.
> 
> [...]

Applied to pci/dwc, thanks!

[1/3] dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
      https://git.kernel.org/lpieralisi/pci/c/458168247c
[2/3] PCI: qcom: Add SM8250 SoC support
      https://git.kernel.org/lpieralisi/pci/c/e1dd639e37
[3/3] PCI: qcom: Add support for configuring BDF to SID mapping for SM8250
      https://git.kernel.org/lpieralisi/pci/c/1c6072c743

Thanks,
Lorenzo
