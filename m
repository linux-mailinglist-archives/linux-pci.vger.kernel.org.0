Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3511D4566F4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 01:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhKSAmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 19:42:17 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:14030 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhKSAmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 19:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637282356; x=1668818356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JR6vBCKFAMVzRy9WfVVMW5aPmEiisUfqznkDGRDTqF0=;
  b=qzlQlyJSpMAbojFEeHA7kW7IiuxqS1lsoR0NSsJRTRHM5mcABWa4fa8y
   36wt4g7jQKR8CoB914mFhBs9U6aUasbhf/kOc5lzW7i8L8DUKY0M0vbV7
   RMvSgzLf3uVXOM4zGwb7NfEAoPuIJFUOU8v8ywM/09s6Bbitw73In3eFY
   p32rCV0tGwZhKP0xasj01Xko7EeyYlHvlCVQQOrItvyvNGEKXHB6O8CZS
   ww3M9cbtwz6ucDXoA5tNEPtHXGs64X1LoHXD4020p+Low1GgAvXbk/Kuv
   1xtxDA1h3vrzdbjVsRcdXXvySoYo/tDBg12JqI1pd6omfZmzWnJwptn85
   g==;
IronPort-SDR: 4EYo2Pdo1jdOVrIqY9Jezgczwokz8SK3O1vvNLhLAQksFf1H1u0r4EfmbeyKqc2m/UB6wGPh2e
 RtKzf5aAr8gWeQM7aWyKDYdbOzf/HvolU9bOU88xTfaoduDmn2f2Q6jDe+HUfTbPQvtwOtAlE0
 zUcDDOd7uQjyeTtUaw48Z3C48vOYh+qFJfYmiVA28JSWgGL4fPsi72m5yEmX7X8ecqv27gc5Sv
 t/XBCxh3NJO8KHzOIQK36EZgCZJui7/ZXLInnWfLJOYrDOG/ZC2WlM2uCngYVvFwoB2ofuR02g
 b11QODtW0+CrqhSpy+4flAYX
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="144456931"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2021 17:39:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 17:39:15 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 18 Nov 2021 17:39:15 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kelvin Cao <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 0/2] Add Switchtec Gen4 automotive device IDs and a tweak
Date:   Thu, 18 Nov 2021 16:38:01 -0800
Message-ID: <20211119003803.2333-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This patchset introduces device IDs for the Switchtec Gen4 automotive
variants and a minor tweak for the MRPC execution.

The first patch adds the device IDs. Patch 2 makes the tweak to improve
the MRPC execution efficiency [1].

This patchset is based on v5.16-rc1.

[1] https://lore.kernel.org/r/20211014141859.11444-1-kelvin.cao@microchip.com/

Thanks,
Kelvin

Kelvin Cao (2):
  Add device IDs for the Gen4 automotive variants
  Declare local array state_names as static

 drivers/pci/quirks.c           |  9 +++++++++
 drivers/pci/switch/switchtec.c | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.25.1

