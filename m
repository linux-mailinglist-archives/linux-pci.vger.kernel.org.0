Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6748842D38C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 09:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhJNH23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 03:28:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11623 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhJNH2V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 03:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634196377; x=1665732377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X5+DjMGj5EkxrHY6Nro2KJlY+qnoR63CziyM5sji3ik=;
  b=v8amAsrEQoWMEoYR+O1C+FpfdXK8YkJc5RtzSEgeoFB5kuwMNbX5FmS1
   j4NQiz6CB1jl14uEjmaMcwJ96nTSWjd3AovN69rxzbl0LCP9h/bK8WVYJ
   C1DNgfhv2/a9P3C9JcgYkGfsIF2RcgJoLiMwoeKoQeikMVPkSbATud72u
   XXHJ/lA/eUu3ViOZsFAjTYSjO4IX3fp6nE7WQfsO8sX6vKJ7B2qo7M5xT
   9g2t9LWDGwcNUQUyufMUH6bDnt4PUrrVteeaBkRHTk/kYEDiLv30C8DTs
   4OotNVKxID1M+I01IITjxpFMZ9/aOZzdd90Ze0nU+6EWfBqmOzSchpROx
   g==;
IronPort-SDR: ZsV1FKRq6JM4cUKFFr54fPshjo6zl66032qWLdWgeljzfM1bNGLGUcuvZLjdQ839Bopx834IxU
 +EDh1cBdIXMSFCEGWWAVDB4uUQKU6CiJdXV/OQTsMpCQTEuH7z3OM9cVHNicqanaI9WQzd+Jr1
 Iw+DQSW8631F5TwA1XdP3ijtzqCtz4RdGl61SCHqpJTjNBPKaUmame/s/TwJnMLm56AM7zCNnG
 0qzSKrWy5NCzqr5aBXxdRNIMS9WJlPY5K1xgnib1iMR7b5lOPx3yT0rvQxQqLdyApqvrxI1mSz
 jMp3lc06bc10Rt9Q2JDtE0yJ
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="132951845"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2021 00:26:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Oct 2021 00:26:14 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 14 Oct 2021 00:26:14 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH v2 0/5] Switchtec Fixes and Improvements
Date:   Thu, 14 Oct 2021 14:18:54 +0000
Message-ID: <20211014141859.11444-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Hi,

This patchset is mainly for improving the commit message of [PATCH 1/5]
in v1[1] to elaborate the root cause, together with a function renaming
and some other tweaks.

This patchset is based on v5.15-rc5.

Thanks,
Kelvin

[1] https://lore.kernel.org/lkml/20210924110842.6323-1-kelvin.cao@microchip.com/

Changes since v1:
- Rebase on 5.15-rc5
- Tweak some comment spacing (as suggested by Bjorn)
- Update commit message to elaborate the root cause of MRPC execution
  hanging (as suggested by Bjorn)
- Rename function check_access() to is_firmware_running()
  (as suggested by Logan) so the function name suggests the meaning of
  the return values (as suggested by Bjorn)
- Add comment to function is_firmware_running() (as suggested by Logan)


Kelvin Cao (4):
  PCI/switchtec: Error out MRPC execution when MMIO reads fail
  PCI/switchtec: Fix a MRPC error status handling issue
  PCI/switchtec: Update the way of getting management VEP instance ID
  PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP

Logan Gunthorpe (1):
  PCI/switchtec: Add check of event support

 drivers/pci/switch/switchtec.c | 95 ++++++++++++++++++++++++++++------
 include/linux/switchtec.h      |  1 +
 2 files changed, 79 insertions(+), 17 deletions(-)

-- 
2.25.1

