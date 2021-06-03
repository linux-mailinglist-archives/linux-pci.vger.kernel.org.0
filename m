Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2BA39A62B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFCQsh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 12:48:37 -0400
Received: from foss.arm.com ([217.140.110.172]:45694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhFCQsh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 12:48:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E004F11B3;
        Thu,  3 Jun 2021 09:46:51 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60D3E3F73D;
        Thu,  3 Jun 2021 09:46:50 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/1] PCI: mediatek: Remove redundant error printing in mtk_pcie_subsys_powerup()
Date:   Thu,  3 Jun 2021 17:46:45 +0100
Message-Id: <162273879476.3130.11393537705815421285.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210511122453.6052-1-thunder.leizhen@huawei.com>
References: <20210511122453.6052-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 May 2021 20:24:53 +0800, Zhen Lei wrote:
> When devm_ioremap_resource() fails, a clear enough error message will be
> printed by its subfunction __devm_ioremap_resource(). The error
> information contains the device name, failure cause, and possibly resource
> information.
> 
> Therefore, remove the error printing here to simplify code and reduce the
> binary size.

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek: Remove redundant error printing in mtk_pcie_subsys_powerup()
      https://git.kernel.org/lpieralisi/pci/c/28bba1e220

Thanks,
Lorenzo
