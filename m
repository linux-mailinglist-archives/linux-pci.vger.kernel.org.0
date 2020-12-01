Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D392CA015
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 11:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgLAKkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 05:40:21 -0500
Received: from foss.arm.com ([217.140.110.172]:40390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbgLAKkV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Dec 2020 05:40:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 962D5101E;
        Tue,  1 Dec 2020 02:39:35 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.32.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DF723F66B;
        Tue,  1 Dec 2020 02:39:32 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>, robh@kernel.org,
        thierry.reding@gmail.com, kw@linux.com, jingoohan1@gmail.com,
        gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        bhelgaas@google.com, amanharitsh123@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, sagar.tv@gmail.com,
        kthota@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, mmaddireddy@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Read "dbi" base address to program in application logic
Date:   Tue,  1 Dec 2020 10:39:21 +0000
Message-Id: <160681913010.4714.1633762754404351653.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201125192554.5401-1-vidyas@nvidia.com>
References: <20201125192554.5401-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 26 Nov 2020 00:55:54 +0530, Vidya Sagar wrote:
> PCIe controller in Tegra194 requires the "dbi" region base address to be
> programmed in one of the application logic registers to enable CPU access
> to the "dbi" region. But, commit a0fd361db8e5 ("PCI: dwc: Move "dbi",
> "dbi2", and "addr_space" resource setup into common code") moved the code
> that reads the whereabouts of "dbi" region to the common code causing the
> existing code in pcie-tegra194.c file to program NULL in the application
> logic registers. This is causing null pointer dereference when the "dbi"
> registers are accessed. This issue is fixed by explicitly reading the
> "dbi" base address from DT node.

Applied to pci/dwc, thanks!

[1/1] PCI: tegra: Read "dbi" base address to program in application logic
      https://git.kernel.org/lpieralisi/pci/c/d5353c00cf

Thanks,
Lorenzo
