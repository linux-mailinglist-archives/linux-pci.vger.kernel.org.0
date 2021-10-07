Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0614254CF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbhJGNz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 09:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:55630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241887AbhJGNzU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 09:55:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BC271FB;
        Thu,  7 Oct 2021 06:53:26 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.53.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0845F3F66F;
        Thu,  7 Oct 2021 06:53:23 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, robh@kernel.org, kishon@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        skananth@codeaurora.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, vpernami@codeaurora.org,
        hemantk@codeaurora.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 0/3] Add Qualcomm PCIe Endpoint driver support
Date:   Thu,  7 Oct 2021 14:53:17 +0100
Message-Id: <163361478005.9266.2494067596905949961.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
References: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 20 Sep 2021 12:29:43 +0530, Manivannan Sadhasivam wrote:
> This series adds support for Qualcomm PCIe Endpoint controller found
> in platforms like SDX55. The Endpoint controller is based on the designware
> core with additional Qualcomm wrappers around the core.
> 
> The driver is added separately unlike other Designware based drivers that
> combine RC and EP in a single driver. This is done to avoid complexity and
> to maintain this driver autonomously.
> 
> [...]

Applied to pci/qcom, thanks!

[1/3] dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP controller
      https://git.kernel.org/lpieralisi/pci/c/6da2051594
[2/3] PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver
      https://git.kernel.org/lpieralisi/pci/c/c206ae06ea
[3/3] MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
      https://git.kernel.org/lpieralisi/pci/c/b969e621b1

Thanks,
Lorenzo
