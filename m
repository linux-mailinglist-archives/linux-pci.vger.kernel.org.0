Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE929F49C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 20:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgJ2TNy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 15:13:54 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgJ2TNx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 15:13:53 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9AD204016B;
        Thu, 29 Oct 2020 19:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603998833; bh=adaWdd4918dH5QofOud6/FpszAlAtDiMVKXnRU9LOhw=;
        h=From:To:Cc:Subject:Date:From;
        b=ixjPq/dpAmc1IpSWCjBNWMBk9MoDtLGf+3UQUH+DP66mfmMrPY/TVwtA4KJPnWfyg
         S9fL8wD09toS/ZxfCFXO7hGhNVYeS5zdHDALVQtueVg/33WDC5TVNtzQbG6CMD5f/T
         /xaBd1+isr3xl40aS1T7QwvmFbaIYsnL4bmELs5zrVxNoE8AAu9ww2M4ZAogxiskml
         CEL+nNogfp5pHcYmf/37Jkr19Btq8BvWWmHy2wK+yz6AkxrZZGNuaNkdaHiXOSyLBS
         Sp4Wp/EO1rcwoII89TrcL8Z7bG5G4xrDMlffIdJYk27kAyDufAgVHuFbzzPUgEiWFc
         hGyXrQh6jn7OQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0D767A01F0;
        Thu, 29 Oct 2020 19:13:50 +0000 (UTC)
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
Subject: [PATCH 0/5] misc: Add Add Synopsys DesignWare xData IP driver 
Date:   Thu, 29 Oct 2020 20:13:35 +0100
Message-Id: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
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

Gustavo Pimentel (5):
  misc: Add Synopsys DesignWare xData IP driver
  misc: Add Synopsys DesignWare xData IP driver to Makefile
  misc: Add Synopsys DesignWare xData IP driver to Kconfig
  Documentation: misc-devices: Add Documentation for dw-xdata-pcie
    driver
  MAINTAINERS: Add Synopsys xData IP driver maintainer

 Documentation/misc-devices/dw-xdata-pcie.rst |  43 +++
 MAINTAINERS                                  |   7 +
 drivers/misc/Kconfig                         |  10 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/dw-xdata-pcie.c                 | 395 +++++++++++++++++++++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/misc/dw-xdata-pcie.c

-- 
2.7.4

