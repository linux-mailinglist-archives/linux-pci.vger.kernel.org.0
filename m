Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1277E35DCCC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbhDMKtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 06:49:45 -0400
Received: from foss.arm.com ([217.140.110.172]:40228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343982AbhDMKs7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 06:48:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72B3A106F;
        Tue, 13 Apr 2021 03:48:39 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.59.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4F813F73B;
        Tue, 13 Apr 2021 03:48:37 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Qiheng Lin <linqiheng@huawei.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-mediatek@lists.infradead.org, Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] PCI: mediatek: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 13 Apr 2021 11:48:33 +0100
Message-Id: <161831089975.6369.2070015191943714889.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210331085938.3115-1-linqiheng@huawei.com>
References: <20210331085938.3115-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 31 Mar 2021 16:59:38 +0800, Qiheng Lin wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek: Add missing MODULE_DEVICE_TABLE
      https://git.kernel.org/lpieralisi/pci/c/87db343f80

Thanks,
Lorenzo
