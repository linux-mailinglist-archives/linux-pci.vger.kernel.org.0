Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40654344E52
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 19:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhCVSUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 14:20:13 -0400
Received: from foss.arm.com ([217.140.110.172]:36474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbhCVSUL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 14:20:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51910113E;
        Mon, 22 Mar 2021 11:20:10 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.49.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA4D73F718;
        Mon, 22 Mar 2021 11:20:06 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, robh@kernel.org,
        gustavo.pimentel@synopsys.com, eswara.kota@linux.intel.com,
        andriy.shevchenko@intel.com, hayashi.kunihiko@socionext.com,
        linux-pci@vger.kernel.org, vidyas@nvidia.com, treding@nvidia.com,
        linux-kernel@vger.kernel.org, Wesley Sheng <wesley.sheng@amd.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        wesley.sheng@microchip.com, wesleyshenggit@sina.com,
        wesley.sheng@microsemi.com
Subject: Re: [PATCH] PCI:tegra:Correct typo for PCIe endpoint mode in Tegra194
Date:   Mon, 22 Mar 2021 18:20:00 +0000
Message-Id: <161643718381.28411.12005523225324572089.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201231032539.22322-1-wesley.sheng@amd.com>
References: <20201231032539.22322-1-wesley.sheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 31 Dec 2020 11:25:39 +0800, Wesley Sheng wrote:
> In config PCIE_TEGRA194_EP the mode incorrectly referred to
> host mode.

Applied to pci/tegra, thanks!

[1/1] PCI: tegra: Fix typo for PCIe endpoint mode in Tegra194
      https://git.kernel.org/lpieralisi/pci/c/10739e2a5e

Thanks,
Lorenzo
