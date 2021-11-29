Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E511E4614D0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 13:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhK2MQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 07:16:20 -0500
Received: from foss.arm.com ([217.140.110.172]:37186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232507AbhK2MOT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 07:14:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83BEC1042;
        Mon, 29 Nov 2021 04:11:01 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.34.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82DDC3F694;
        Mon, 29 Nov 2021 04:10:59 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Ryan-JH.Yu@mediatek.com,
        qizhong.cheng@mediatek.com, Tzung-Bi Shih <tzungbi@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Disable DVFSRC voltage request
Date:   Mon, 29 Nov 2021 12:10:50 +0000
Message-Id: <163818783058.10689.5907894274885753855.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211015063602.29058-1-jianjun.wang@mediatek.com>
References: <20211015063602.29058-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Oct 2021 14:36:02 +0800, Jianjun Wang wrote:
> When the DVFSRC (dynamic voltage and frequency scaling resource collector)
> feature is not implemented, the PCIe hardware will assert a voltage request
> signal when exit from the L1 PM Substates to request a specific Vcore
> voltage, but cannot receive the voltage ready signal, which will cause
> the link to fail to exit the L1 PM Substates.
> 
> Disable DVFSRC voltage request by default, we need to find a common way to
> enable it in the future.
> 
> [...]

Applied to pci/mediatek-gen3, thanks!

[1/1] PCI: mediatek-gen3: Disable DVFSRC voltage request
      https://git.kernel.org/lpieralisi/pci/c/ab344fd43f

Thanks,
Lorenzo
