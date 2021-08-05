Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7443E12E1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhHEKnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 06:43:37 -0400
Received: from foss.arm.com ([217.140.110.172]:42568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240388AbhHEKng (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 06:43:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C06E81FB;
        Thu,  5 Aug 2021 03:43:21 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 438F63F719;
        Thu,  5 Aug 2021 03:43:20 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jonathanh@nvidia.com, thierry.reding@gmail.com, robh@kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: tegra: Fix OF node reference leak
Date:   Thu,  5 Aug 2021 11:43:14 +0100
Message-Id: <162816017970.17991.9169417632084960512.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 May 2021 19:17:42 +0200, Christophe JAILLET wrote:
> Commit 9e38e690ace3 ("PCI: tegra: Fix OF node reference leak") has fixed
> some node reference leaks in this function but missed some of them.
> 
> In fact, having 'port' referenced in the 'rp' structure is not enough to
> prevent the leak, until 'rp' is actually added in the 'pcie->ports' list.
> 
> Add the missing 'goto err_node_put' accordingly.

Applied to pci/tegra, thanks!

[1/3] PCI: tegra: Fix OF node reference leak
      https://git.kernel.org/lpieralisi/pci/c/eff21f5da3
[2/3] PCI: tegra: Use 'seq_puts' instead of 'seq_printf'
      https://git.kernel.org/lpieralisi/pci/c/804b2b6f2a
[3/3] PCI: tegra: make const array err_msg static
      https://git.kernel.org/lpieralisi/pci/c/fd44e8efcc

Thanks,
Lorenzo
