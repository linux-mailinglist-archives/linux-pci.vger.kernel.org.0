Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86794469515
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 12:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbhLFLjU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 06:39:20 -0500
Received: from foss.arm.com ([217.140.110.172]:54808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242519AbhLFLjU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 06:39:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89CE21042;
        Mon,  6 Dec 2021 03:35:51 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.33.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4F2E3F73D;
        Mon,  6 Dec 2021 03:35:48 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczyi=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        qizhong cheng <qizhong.cheng@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Jiey Yang <ot_jiey.yang@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: Delay 100ms to wait power and clock to become stable
Date:   Mon,  6 Dec 2021 11:35:42 +0000
Message-Id: <163879053288.15266.2451470623160398574.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211104062144.31453-1-qizhong.cheng@mediatek.com>
References: <20211104062144.31453-1-qizhong.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 4 Nov 2021 14:21:44 +0800, qizhong cheng wrote:
> Described in PCIe CEM specification setctions 2.2 (PERST# Signal) and
> 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> be delayed 100ms (TPVPERL) for the power and clock to become stable.
> 
> 

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek: Delay 100ms to wait power and clock to become stable
      https://git.kernel.org/lpieralisi/pci/c/1fa610f217

Thanks,
Lorenzo
