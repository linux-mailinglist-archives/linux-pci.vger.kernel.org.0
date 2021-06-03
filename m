Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A188939A366
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhFCOh1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 10:37:27 -0400
Received: from foss.arm.com ([217.140.110.172]:42888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhFCOh1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 10:37:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68FDD11FB;
        Thu,  3 Jun 2021 07:35:42 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D8AD3F73D;
        Thu,  3 Jun 2021 07:35:40 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: xgene: Annotate __iomem pointer
Date:   Thu,  3 Jun 2021 15:35:34 +0100
Message-Id: <162273091651.8127.9532868398514111811.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210517171839.25777-1-helgaas@kernel.org>
References: <20210517171839.25777-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 17 May 2021 12:18:39 -0500, Bjorn Helgaas wrote:
> "bar_addr" is passed as the argument to writel(), which expects a
> "void __iomem *".  Annotate "bar_addr" correctly.  Resolves an sparse
> "incorrect type in argument 2 (different address spaces)" warning.

Applied to pci/xgene, thanks!

[1/1] PCI: xgene: Annotate __iomem pointer
      https://git.kernel.org/lpieralisi/pci/c/eabbc3ccbe

Thanks,
Lorenzo
