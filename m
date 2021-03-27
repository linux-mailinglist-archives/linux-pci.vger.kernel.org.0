Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5D34B3E4
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 04:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhC0DHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 23:07:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50484 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbhC0DHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 23:07:08 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E7ADD40396;
        Sat, 27 Mar 2021 03:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616814427; bh=YgEWhwoMwnFlsWEuVKVkKKjj6tDqXAabsNLouryl93A=;
        h=From:To:Cc:Subject:Date:From;
        b=ijKaN0eZbwMOeoXXckSzH6hQPbiwNmFdc/vOTwvdzeStxLch3MOon4/pnF5ZzyiFh
         sDXJWVnEFesKCbhq513P1+cm4GSfCqKZPb0Sqz/TefmScRrjeeCcIWqoN+PGl9Jn/3
         BrED7sZwAAekcWIcJn0aZPWo6Riqcy66TWumyoil0keTHUyXtJns4TKTkICZsRsUrw
         HzHj5kSKJc5NNUu3V4aA+CDV4QhfBwiWwnXEOoaoMzUxJsnvHeaGF/snaYJbT819wy
         h/8VkYIpCfQtSNhaPPTAo6QjRlNvH67CsFLWVxgJAtBN0POZQw2BLuNgxB8MCMyJtp
         0m8CaHZ0tBOrw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 22187A022E;
        Sat, 27 Mar 2021 03:07:04 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Date:   Sat, 27 Mar 2021 04:06:50 +0100
Message-Id: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series adds a new driver called xData-pcie for the Synopsys
DesignWare PCIe prototype.

The driver configures and enables the Synopsys DesignWare PCIe traffic
generator IP inside of prototype Endpoint which will generate upstream
and downstream PCIe traffic. This allows to quickly test the PCIe link
throughput speed and check is the prototype solution has some limitation
or not.

Changes:
 V2: Rework driver according to Greg Kroah-Hartman' feedback
 V3: Fixed issues detected while running on 64 bits platforms
     Rebased patches on top of v5.11-rc1 version
 V4: Rework driver according to Greg Kroah-Hartman' feedback
     Add the ABI doc related to the sysfs implemented on this driver
 V5: Rework driver accordingly to Leon Romanovsky' feedback
     Rework driver accordingly to Krzysztof Wilczyński' feedback
 V6: Rework driver according to Greg Kroah-Hartman' feedback
     Rework driver accordingly to Krzysztof Wilczyński' feedback
     Rework driver accordingly to Leon Romanovsky' feedback
 V7: Rework driver according to Greg Kroah-Hartman' feedback

Cc: linux-doc@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Wilczyński <kw@linux.com>

Gustavo Pimentel (5):
  misc: Add Synopsys DesignWare xData IP driver
  misc: Add Synopsys DesignWare xData IP driver to Makefile and Kconfig
  Documentation: misc-devices: Add Documentation for dw-xdata-pcie
    driver
  MAINTAINERS: Add Synopsys xData IP driver maintainer
  docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver

 Documentation/ABI/testing/sysfs-driver-xdata |  46 +++
 Documentation/misc-devices/dw-xdata-pcie.rst |  40 +++
 MAINTAINERS                                  |   7 +
 drivers/misc/Kconfig                         |  10 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/dw-xdata-pcie.c                 | 401 +++++++++++++++++++++++++++
 6 files changed, 505 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/misc/dw-xdata-pcie.c

-- 
2.7.4

