Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2BA34CD50
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhC2JwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 05:52:06 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:49344 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232068AbhC2Jvz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 05:51:55 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 58272C044B;
        Mon, 29 Mar 2021 09:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617011515; bh=gGq1c8aqOf1302YIPm9v0n//UDI5gOHoGXzH2qD7k+4=;
        h=From:To:Cc:Subject:Date:From;
        b=P1yt4YVcdufwzBC27fQl7HceD/S+EJw39N/IKJvZI/3+MYcApvHScONhq9qPrbhTT
         SNvSTrKItebOwcaFWpGNfZrwgi8Jl5BpsKzWrWLPjii1FQLK3k7k82+JBVGJbyZeKz
         cCIulbcR51+o8z8Cq8LNZs+dy4paONSPxVK5RedxcGEdn6DTsqn3onR4OWQIzzGlyB
         ONdsiX9a6BvgHL7w5sZWVIXY1xRr38I7KTEljNJBV2tVVsv9btplQDs5aivzgV7CbG
         vvJD8lrILfI3RMDME8QztjihjHHbNO+3fM91E9TDmx15J2H9+vYvAs/q+AGeV5AxRT
         zQrnKCt4590yQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 78657A0234;
        Mon, 29 Mar 2021 09:51:51 +0000 (UTC)
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
Subject: [PATCH v8 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Date:   Mon, 29 Mar 2021 11:51:33 +0200
Message-Id: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
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
     - Replace module parameter by sysfs use.
     - Replace bit fields structure with macros and masks use.
     - Removed SET() and GET() macros by the writel() and readl().
     - Removed some noisy info messages.
 V3: Fixed issues detected while running on 64 bits platforms
      Rebased patches on top of v5.11-rc1 version
 V4: Rework driver according to Greg Kroah-Hartman' feedback
     - Add the ABI doc related to the sysfs implemented on this driver
 V5: Rework driver accordingly to Leon Romanovsky' feedback
     - Removed "default n" on Kconfig
     Rework driver accordingly to Krzysztof Wilczyński' feedback
     - Added some explanatory comments for some steps
     - Added some bit defines instead of magic numbers
 V6: Rework driver according to Greg Kroah-Hartman' feedback
     - Squashed patches 2 and 3
     - Removed units (MB/s) on the sys file
     - Reduced mutex scope on the functions called by sysfs
     Rework driver accordingly to Krzysztof Wilczyński' feedback
     - Fix typo "DesignWare"
 V7: Rework driver according to Greg Kroah-Hartman' feedback
     - Created a sub device (misc device) that will be associated with the PCI driver
     - sysfs group is now associated with the misc drivers instead of the PCI driver
 V8: Rework driver according to Greg Kroah-Hartman' feedback
     - Added more detail to the version changes on the cover letter
     - Squashed patches 1 and 2
     - Removed struct device from the dw_xdata_pcie structure
     - Replaced the pci_*() use by dev_*()
     - Added free call for the misc driver name allocation
     - Added reference counting
     - Removed snps_edda_data structure and their usage
     Rebased patches on top of v5.12-rc4 version

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
  Documentation: misc-devices: Add Documentation for dw-xdata-pcie
    driver
  MAINTAINERS: Add Synopsys xData IP driver maintainer
  docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
  FIX driver

 Documentation/ABI/testing/sysfs-driver-xdata |  46 +++
 Documentation/misc-devices/dw-xdata-pcie.rst |  40 +++
 MAINTAINERS                                  |   7 +
 drivers/misc/Kconfig                         |  10 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/dw-xdata-pcie.c                 | 416 +++++++++++++++++++++++++++
 6 files changed, 520 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/misc/dw-xdata-pcie.c

-- 
2.7.4

