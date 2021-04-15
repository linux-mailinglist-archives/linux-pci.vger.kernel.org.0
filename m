Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A775360E30
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhDOPLu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 11:11:50 -0400
Received: from foss.arm.com ([217.140.110.172]:48688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234595AbhDOPJs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 11:09:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86098106F;
        Thu, 15 Apr 2021 08:09:25 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.59.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3027A3FA35;
        Thu, 15 Apr 2021 08:09:24 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: move dw_pcie_msi_init() to dw_pcie_setup_rc()
Date:   Thu, 15 Apr 2021 16:09:18 +0100
Message-Id: <161849933971.28465.1647999882970399921.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210325152604.6e79deba@xhacker.debian>
References: <20210325152604.6e79deba@xhacker.debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Mar 2021 15:26:04 +0800, Jisheng Zhang wrote:
> If the host which makes use of IP's integrated MSI Receiver losts
> power during suspend, we need to reinit the RC and MSI Receiver in
> resume. But after we move dw_pcie_msi_init() into the core, we have no
> API to do so. Usually the dwc users need to call dw_pcie_setup_rc() to
> reinit the RC, we can solve this problem by moving dw_pcie_msi_init()
> to dw_pcie_setup_rc().

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Move dw_pcie_msi_init() to dw_pcie_setup_rc()
      https://git.kernel.org/lpieralisi/pci/c/fe08db2835

Thanks,
Lorenzo
