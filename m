Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CDC2FA524
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 16:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393450AbhARPuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 10:50:15 -0500
Received: from foss.arm.com ([217.140.110.172]:38318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393415AbhARPuL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 10:50:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CBA2D6E;
        Mon, 18 Jan 2021 07:49:25 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.56.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98293F68F;
        Mon, 18 Jan 2021 07:49:22 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Toan Le <toan@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: altera-msi: Remove IRQ handler and data in one go
Date:   Mon, 18 Jan 2021 15:49:16 +0000
Message-Id: <161098493526.24324.9715924807340481057.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210115212435.19940-1-martin@kaiser.cx>
References: <20201108191140.23227-1-martin@kaiser.cx> <20210115212435.19940-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Jan 2021 22:24:33 +0100, Martin Kaiser wrote:
> Call irq_set_chained_handler_and_data() to clear the chained handler
> and the handler's data under irq_desc->lock.
> 
> See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
> IRQ handler").

Applied to pci/misc, thanks!

[1/3] PCI: altera-msi: Remove IRQ handler and data in one go
      https://git.kernel.org/lpieralisi/pci/c/3f0ea2360e
[2/3] PCI: dwc: Remove IRQ handler and data in one go
      https://git.kernel.org/lpieralisi/pci/c/ad1cc6b75a
[3/3] PCI: xgene-msi: Fix race in installing chained irq handler
      https://git.kernel.org/lpieralisi/pci/c/a93c00e5f9

Thanks,
Lorenzo
