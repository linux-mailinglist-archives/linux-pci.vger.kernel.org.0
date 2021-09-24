Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6B5416AB7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 06:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhIXERV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 00:17:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3740 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhIXERV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 00:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632456948; x=1663992948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ujSYJSJibS7ZEanYJFqh0rqX/WIrmvvKSo6Fvc8sU5s=;
  b=XsVtegzgDcFFdUHUig6PRS29ML7/L4tsCby7OxZClfPsKb004SMAAc5P
   OKAGk/OWAxqILicrmadde6NTC7UV5i3BlIsMVkcNr/nlc6jbK8SlU6Xyw
   bAdv06ugLIi7CCf2dc/28zxExgnFnMxJ6Qe8jrfRR4xlMrMzodkrjwMV/
   HEs/SazAjuyHKNx5Sa8kQvnHySBv4qrJMvqB76FU38uyLSf4WeietVPZi
   XMxlUi0PSs8pTz8h5K3FfkZ8sEXCTXaBkR+i7i2Jy9A7uipGY9LBKziYt
   esOBCvsbxNA1UFpkqyaahP4v8+GDkZcPVGs8Tt5AoEPJDegDfWlpkleZG
   Q==;
IronPort-SDR: ssDjp59dke5Or09pxBHKbnZ0yDTP2HtzXLM0YJG/D8Uil/T/jE9s0DD9ph2o+2/nZoKy+PxUj9
 ad9Zo2E4ot/AFz1/jB1PEzHbOy475ktIoKH9WbkbglRevrtvt44LhFvTYTbO77ciygn7I/k++Z
 McczPAhvbNFgNqGmHqUXg6bMlRZ1N4qzQto6NfhQBlko5hYnDIOMql7AOTxhA23JAyBWYQILtY
 1vXr2XIM6bYDlQc4pO3RWuJ44FJ8l1/cSZjIJ3utLG03upfzUtzqIMdDdTBgAIyN4Lp5Pw4Ebv
 kPF+k2FtL6knv6tmKKeVfZnq
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="130437083"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 21:15:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 21:15:47 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 23 Sep 2021 21:15:46 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 0/5] Switchtec Fixes and Improvements
Date:   Fri, 24 Sep 2021 11:08:37 +0000
Message-ID: <20210924110842.6323-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Hi,

Please find a bunch of patches for the switchtec driver collected over the
last few months.

The first 2 patches fix two minor bugs. Patch 3 updates the method of
getting management VEP instance ID based on a new firmware change. Patch
4 replaces ENOTSUPP with EOPNOTSUPP to follow the preference of kernel.
And the last patch adds check of event support to align with new firmware
implementation.

This patchset is based on v5.15-rc2.

Thanks,
Kelvin

Kelvin Cao (4):
  PCI/switchtec: Error out MRPC execution when no GAS access
  PCI/switchtec: Fix a MRPC error status handling issue
  PCI/switchtec: Update the way of getting management VEP instance ID
  PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP

Logan Gunthorpe (1):
  PCI/switchtec: Add check of event support

 drivers/pci/switch/switchtec.c | 87 +++++++++++++++++++++++++++-------
 include/linux/switchtec.h      |  1 +
 2 files changed, 71 insertions(+), 17 deletions(-)

-- 
2.25.1

