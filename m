Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7FC344DBA
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 18:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCVRup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 13:50:45 -0400
Received: from foss.arm.com ([217.140.110.172]:36120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhCVRug (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 13:50:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9032A113E;
        Mon, 22 Mar 2021 10:50:34 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.49.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5D873F718;
        Mon, 22 Mar 2021 10:50:32 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        'Wei Yongjun <weiyongjun1@huawei.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: brcmstb: Fix error return code in brcm_pcie_probe()
Date:   Mon, 22 Mar 2021 17:50:27 +0000
Message-Id: <161643541156.14738.11988404247172921585.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210308135619.19133-1-weiyongjun1@huawei.com>
References: <20210308135619.19133-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 8 Mar 2021 13:56:19 +0000, 'Wei Yongjun wrote:
> Fix to return negative error code -ENODEV from the unsupported revision
> error handling case instead of 0, as done elsewhere in this function.

Applied to pci/brcmstb, thanks!

[1/1] PCI: brcmstb: Fix error return code in brcm_pcie_probe()
      https://git.kernel.org/lpieralisi/pci/c/b5d9209d50

Thanks,
Lorenzo
