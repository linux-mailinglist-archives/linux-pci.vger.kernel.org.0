Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93231496065
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbiAUOFM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:05:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59900 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381012AbiAUOFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:05:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7BA8CCE237F
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D473C340E1;
        Fri, 21 Jan 2022 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773905;
        bh=ewoePo20ssj83VYilqS7VEGgrvKYzOP+7LEO+rjyGTU=;
        h=From:To:Subject:Date:From;
        b=KSYYIxE2gygBSZiWTH2XznPGgzp+FVOZp8rLsdQAy311saR+MmQpeIoKjPcGkiX1h
         zkwgvDC6OkHXCf1J6M4jsT3r6RBP7uD2UQPNKfbuIMysxIi95WBggmG8+bxb0BHaP3
         MpO5T5e07PdJHGY/dC/EJlfqXXeNqM+7gBaZWkFk2cUyn8YaZ2/mrsEV+DkHphu1k2
         mcIvbt9Qo+QsPfvOGF38met7rgMOVIBX1zxE/OnVPwS+k4vnBcRhHQJqe+WDSEIL1R
         Dtrx5A9WKUptIiCeKWGns5/aVQvIB8MWJ91YhAABCNNXl9LPwaedAlOa0aXB+51hUz
         fgMzL8jLbybLw==
Received: by pali.im (Postfix)
        id 190DF857; Fri, 21 Jan 2022 15:05:03 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 0/4] Support for PCI_FILL_DRIVER
Date:   Fri, 21 Jan 2022 15:03:47 +0100
Message-Id: <20220121140351.27382-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both procfs and sysfs provides information about used PCI driver.
Add support for a new libpci string property PCI_FILL_DRIVER, fill it in
both procfs ans sysfs provides and use it in lspci instead of lspci own
sysfs code for retrieving driver.

This patch series is based on top of another patch series:
https://lore.kernel.org/linux-pci/20220121135718.27172-1-pali@kernel.org/t/

Pali Rohár (4):
  libpci: Define new string property PCI_FILL_DRIVER
  libpci: proc: Implement support for PCI_FILL_DRIVER
  libpci: sysfs: Implement support for PCI_FILL_DRIVER
  lspci: Replace find_driver() via libpci PCI_FILL_DRIVER

 lib/pci.h   |  1 +
 lib/proc.c  | 22 +++++++++++++++++++--
 lib/sysfs.c | 13 +++++++++++++
 ls-kernel.c | 56 +++++++++++++++--------------------------------------
 4 files changed, 50 insertions(+), 42 deletions(-)

-- 
2.20.1

