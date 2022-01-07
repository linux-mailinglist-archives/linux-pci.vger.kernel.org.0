Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F79D487562
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 11:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiAGKWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 05:22:55 -0500
Received: from foss.arm.com ([217.140.110.172]:37994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbiAGKWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 05:22:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E60C13D5;
        Fri,  7 Jan 2022 02:22:54 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.36.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E362C3F66F;
        Fri,  7 Jan 2022 02:22:51 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        qizhong cheng <qizhong.cheng@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: mediatek: Assert PERST# for 100ms for power and clock to stabilize
Date:   Fri,  7 Jan 2022 10:22:46 +0000
Message-Id: <164155095225.6775.655179565397700923.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211227133110.14500-1-qizhong.cheng@mediatek.com>
References: <20211227133110.14500-1-qizhong.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 27 Dec 2021 21:31:10 +0800, qizhong cheng wrote:
> Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
> 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> be delayed 100ms (TPVPERL) for the power and clock to become stable.
> 
> 

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek: Assert PERST# for 100ms for power and clock to stabilize
      https://git.kernel.org/lpieralisi/pci/c/65ace9a85f

Thanks,
Lorenzo
