Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C391A2B8E9A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 10:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKSJUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 04:20:00 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45650 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbgKSJT6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 04:19:58 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0E609402EA;
        Thu, 19 Nov 2020 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605777598; bh=sOtLmZx5lFn7Nsome2jU6ze9w/hsZktv2ZBpyTUq5b4=;
        h=From:To:Cc:Subject:Date:From;
        b=FNzbJ7q2ovxYy3nhVRk3UDb/j7Klnc+jjnhCaD+pxh9XVrcKYnkW/N32m5Y5e32zT
         YXJ1kFQIBcWKe0HHvcHXBJQG9BN0yrbENVboeuvrlvVUkB9arZKt9xlFBr/u4+0FOz
         zLXtNxWyKVVDIo0VfMyUggQ78fh6usHN6kix644bqqDiL+mBtDtwbYjikzzOF0ON71
         9HY+U+EupqZVn8fYUnlUmMWvDft0vLKAYPgNp4hRAfGwOHVVY/3+mhJSd2E7yy6s5f
         kciVFW3hR3LYwVSx+eGh85zmTq8TcpTbzFfTTsf3ibRQnWk+Y9w3nPqCB76lBJFJGW
         K0NPqM5T0dq/Q==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id D50C2A005D;
        Thu, 19 Nov 2020 09:19:55 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Date:   Thu, 19 Nov 2020 10:19:37 +0100
Message-Id: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
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

Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-pci@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes:
 V2: Rework driver according to Greg Kroah-Hartman feedback 
 V3: Fixed issues detected while running on 64 bits platforms

Gustavo Pimentel (5):
  misc: Add Synopsys DesignWare xData IP driver
  misc: Add Synopsys DesignWare xData IP driver to Makefile
  misc: Add Synopsys DesignWare xData IP driver to Kconfig
  Documentation: misc-devices: Add Documentation for dw-xdata-pcie
    driver
  MAINTAINERS: Add Synopsys xData IP driver maintainer

 Documentation/misc-devices/dw-xdata-pcie.rst |  40 +++
 MAINTAINERS                                  |   7 +
 drivers/misc/Kconfig                         |  11 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/dw-xdata-pcie.c                 | 379 +++++++++++++++++++++++++++
 5 files changed, 438 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/misc/dw-xdata-pcie.c

-- 
2.7.4

