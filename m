Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012EE344459
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 14:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhCVM7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 08:59:33 -0400
Received: from foss.arm.com ([217.140.110.172]:59574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233296AbhCVM6I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 08:58:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A1141042;
        Mon, 22 Mar 2021 05:58:07 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0615D3F719;
        Mon, 22 Mar 2021 05:58:05 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: tegra: Constify static structs
Date:   Mon, 22 Mar 2021 12:57:57 +0000
Message-Id: <161641785574.526.7300746340083499342.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210207221604.48910-1-rikard.falkeborn@gmail.com>
References: <20210207221604.48910-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 7 Feb 2021 23:16:04 +0100, Rikard Falkeborn wrote:
> The only usage of them is to assign their address to the 'ops' field in
> the pcie_port and the dw_pcie_ep structs, both which are pointers to
> const. Make them const to allow the compiler to put them in read-only
> memory.

Applied to pci/tegra, thanks!

[1/1] PCI: tegra: Constify static structs
      https://git.kernel.org/lpieralisi/pci/c/d895ce7030

Thanks,
Lorenzo
