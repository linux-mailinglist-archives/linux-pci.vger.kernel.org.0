Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B22B289B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 23:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKMWhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 17:37:35 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56096 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbgKMWhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 17:37:33 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 219AD40461;
        Fri, 13 Nov 2020 22:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605307050; bh=jjkOVwgDQT6TA0CdHPVWIovLMbPvZdCCS0xgiauS52c=;
        h=From:To:Cc:Subject:Date:From;
        b=NhVuex5bcOfR4Fb0kZDp4b+3vLXu6139yYIyeGqed66ruvf/SHZqnJOx5Bbh+Sddr
         9rrDQuBNPYm7RdoB5+rea1KlFdkJnVclwW0nisvyJNp0QWe0BuhMkNaMopJfXeuDr6
         kLBuwoqll84UStVSAgAB0ykqoWefQCqTd1etSV4TaxRIQCwljY5YU++HQF1dIuyrnW
         nCQRytX8Hgoo1mIUycfQOqTWx7B0xpKA2Rzi6HKZ1mCtfthMW4y3qPYi1/s+dWxkNQ
         o5FAkHuBtAkRKxq1zaGl2aOF/vfCzQM5YBvFqTLs+hAPpNUp83FHkiMJeaoLynIots
         /SY/KtExiRtvw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 873D2A005D;
        Fri, 13 Nov 2020 22:37:27 +0000 (UTC)
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
Subject: [PATCH v2 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Date:   Fri, 13 Nov 2020 23:37:11 +0100
Message-Id: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
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
 drivers/misc/dw-xdata-pcie.c                 | 390 +++++++++++++++++++++++++++
 5 files changed, 449 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/misc/dw-xdata-pcie.c

-- 
2.7.4

