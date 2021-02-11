Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649CC3186D5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBKJQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:16:56 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56602 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230046AbhBKJKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:10:48 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E2391C00B8;
        Thu, 11 Feb 2021 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034550; bh=1vhPCybPaU1gp8Q22JtWBqzxeYFMfx3q1bNItmKLjzE=;
        h=From:To:Cc:Subject:Date:From;
        b=V4+mpXRPw4UkkXdeSFKmKUD00AojT2Zm6HQwo+qT41Lc/omq5ggGaaq78xtjLfqc9
         3clxhfzvNBw4+VbIHCDuxJZhwrGR9YW2AjmwO7owijN43zgIPbyQCea2TFKFe5kT/k
         rmvYQLvLl2sWQOxVikLJHiOM2/AEEOyFav7Pd9d2sGP4UAgojs9ldW/QM0g7X3K0IU
         MQ+0TAefGx+rz1xAo82TgI1eOidv+o/c+R+TjR5OXNv3uvXAFpnawbSMj99NyIAV6z
         FwwAbD2ecrUVI5Vv/BtxYY/G7twcTbz3s76lytUOQJdioo5Fvl5VpMRQM2vYLJ0TeU
         JO51N+DyzwH1w==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2C69DA005C;
        Thu, 11 Feb 2021 09:09:06 +0000 (UTC)
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
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 0/6] misc: Add Add Synopsys DesignWare xData IP driver
Date:   Thu, 11 Feb 2021 10:08:37 +0100
Message-Id: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=n
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
 V5: Rework driver accordingly to Leon Romanovsky's feedback
     Rework driver accordingly to Krzysztof Wilczyński's feedback

Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Gustavo Pimentel (6):
  misc: Add Synopsys DesignWare xData IP driver
  misc: Add Synopsys DesignWare xData IP driver to Makefile
  misc: Add Synopsys DesignWare xData IP driver to Kconfig
  Documentation: misc-devices: Add Documentation for dw-xdata-pcie
    driver
  MAINTAINERS: Add Synopsys xData IP driver maintainer
  docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver

 Documentation/ABI/testing/sysfs-driver-xdata |  46 ++++
 Documentation/misc-devices/dw-xdata-pcie.rst |  40 +++
 MAINTAINERS                                  |   7 +
 drivers/misc/Kconfig                         |  10 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/dw-xdata-pcie.c                 | 394 +++++++++++++++++++++++++++
 6 files changed, 498 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/misc/dw-xdata-pcie.c

-- 
2.7.4

