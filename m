Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10EB3D3C48
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhGWOgo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 10:36:44 -0400
Received: from foss.arm.com ([217.140.110.172]:47276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235484AbhGWOgo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 10:36:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF55A12FC;
        Fri, 23 Jul 2021 08:17:17 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.38.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFD5D3F73D;
        Fri, 23 Jul 2021 08:17:15 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: dwc: Remove surplus break statement after return
Date:   Fri, 23 Jul 2021 16:17:09 +0100
Message-Id: <162705341536.22269.16763354143441576846.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210701210252.1638709-1-kw@linux.com>
References: <20210701210252.1638709-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 1 Jul 2021 21:02:52 +0000, Krzysztof Wilczyński wrote:
> As part of code refactoring completed in the commit a0fd361db8e5 ("PCI:
> dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
> code") the function dw_plat_add_pcie_ep() has been removed and the call
> to the dw_pcie_ep_init() has been moved into dw_plat_pcie_probe().
> 
> This change left a break statement behind that is not needed any more as
> as the function dw_plat_pcie_probe() returns immediately after making
> a call to dw_pcie_ep_init().
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Remove surplus break statement after return
      https://git.kernel.org/lpieralisi/pci/c/2999568def

Thanks,
Lorenzo
