Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724B639A58E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhFCQQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 12:16:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCQQo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 12:16:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600F711B3;
        Thu,  3 Jun 2021 09:14:59 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF2A3F73D;
        Thu,  3 Jun 2021 09:14:57 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mobiveil: Remove unused readl and writel functions
Date:   Thu,  3 Jun 2021 17:14:52 +0100
Message-Id: <162273686948.20440.4943742054393052900.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210510023032.3063932-1-kw@linux.com>
References: <20210510023032.3063932-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 May 2021 02:30:32 +0000, Krzysztof Wilczyński wrote:
> The PCIe host controller driver for Layerscape 4th generation SoC was
> added in the commit d29ad70a813b ("PCI: mobiveil: Add PCIe Gen4 RC
> driver for Layerscape SoCs").
> 
> At this time two static functions were introduced that appear to
> currently have no users.  Since nothing is using neither of these
> functions at the moment they can be safely removed.
> 
> [...]

Applied to pci/mobiveil, thanks!

[1/1] PCI: mobiveil: Remove unused readl and writel functions
      https://git.kernel.org/lpieralisi/pci/c/42d7a8dc19

Thanks,
Lorenzo
