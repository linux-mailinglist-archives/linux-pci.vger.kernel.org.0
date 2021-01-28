Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F953073F1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 11:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhA1Kk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 05:40:29 -0500
Received: from foss.arm.com ([217.140.110.172]:56252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhA1Kk2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 05:40:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D1411FB;
        Thu, 28 Jan 2021 02:39:41 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.46.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B27E3F766;
        Thu, 28 Jan 2021 02:39:39 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: dwc: remove useless dw_pcie_ops
Date:   Thu, 28 Jan 2021 10:39:32 +0000
Message-Id: <161183035514.4271.3911411429293996469.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210128144208.343052f7@xhacker.debian>
References: <20210128144208.343052f7@xhacker.debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Jan 2021 14:42:13 +0800, Jisheng Zhang wrote:
> Some designware based device driver especially host only driver may
> work well with the default read_dbi/write_dbi/link_up implementation
> in pcie-designware.c, thus remove the assumption to simplify those
> drivers.
> 
> Since v2:
>   - rebase to the latest pci/dwc
>   - add Acked-by tag
> 
> [...]

Applied to pci/dwc, thanks!

[1/2] PCI: dwc: Don't assume the ops in dw_pcie always exists
      https://git.kernel.org/lpieralisi/pci/c/f2213e5f3b
[2/2] PCI: dwc: al: Remove useless dw_pcie_ops
      https://git.kernel.org/lpieralisi/pci/c/05e11f20f5

Thanks,
Lorenzo
