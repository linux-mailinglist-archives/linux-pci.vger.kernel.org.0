Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0659484490
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiADPad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:30:33 -0500
Received: from foss.arm.com ([217.140.110.172]:60838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbiADPad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jan 2022 10:30:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AF4213A1;
        Tue,  4 Jan 2022 07:30:32 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.35.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC613F774;
        Tue,  4 Jan 2022 07:30:30 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Constify static dw_pcie_ep_ops
Date:   Tue,  4 Jan 2022 15:30:25 +0000
Message-Id: <164131021058.29680.10277687483686428897.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211204220316.88655-1-rikard.falkeborn@gmail.com>
References: <20211204220316.88655-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 4 Dec 2021 23:03:16 +0100, Rikard Falkeborn wrote:
> The only usage of pci_ep_ops is to assign its address to the ops field
> in the dw_pcie_ep struct which is a pointer to const struct dw_pcie_ep_ops.
> Make it const to allow the compiler to put it in read-only memory.
> 
> 

Applied to pci/qcom, thanks!

[1/1] PCI: qcom-ep: Constify static dw_pcie_ep_ops
      https://git.kernel.org/lpieralisi/pci/c/840a720aaa

Thanks,
Lorenzo
