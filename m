Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD6B4875D0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 11:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiAGKlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 05:41:07 -0500
Received: from foss.arm.com ([217.140.110.172]:39272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235996AbiAGKlH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 05:41:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A0913D5;
        Fri,  7 Jan 2022 02:41:06 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.36.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88A003F66F;
        Fri,  7 Jan 2022 02:41:05 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Li Chen <lchen@ambarella.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: endpoint: set_msi: return -EINVAL when interrupts num is smaller than 1
Date:   Fri,  7 Jan 2022 10:41:00 +0000
Message-Id: <164155195563.13819.16266334939063780280.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <CH2PR19MB402491B9E503694DBCAC6005A07C9@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB402491B9E503694DBCAC6005A07C9@CH2PR19MB4024.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Dec 2021 02:59:56 +0000, Li Chen wrote:
> There is no sense to go further if we have no interrupts.
> 
> 

Applied to pci/endpoint, thanks!

[1/1] PCI: endpoint: Return -EINVAL when interrupts num is smaller than 1
      https://git.kernel.org/lpieralisi/pci/c/50b620303a

Thanks,
Lorenzo
