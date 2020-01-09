Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D341351ED
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 04:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgAID24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 22:28:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgAID2z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 22:28:55 -0500
Received: from localhost (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E187206F0;
        Thu,  9 Jan 2020 03:28:55 +0000 (UTC)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jun Nie <jun.nie@linaro.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] Improve pcie-histb GPIO reset implementation
Date:   Thu,  9 Jan 2020 11:28:49 +0800
Message-Id: <20200109032851.13377-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It switches pcie-histb PCIe reset code use gpio_desc for GPIO
configuration, and corrects the GPIO reset operation as per PCI EXPRESS
CARD ELECTROMECHANICAL SPECIFICATION.

Changes for v2:
 - Split into two patches
 - Capitalize the subject
 - Add some comments for PCIe reset operation

Shawn Guo (2):
  PCI: histb: Use gpio_desc for PCIe GPIO reset
  PCI: histb: Correct PCIe reset operation

 drivers/pci/controller/dwc/pcie-histb.c | 41 ++++++++++++-------------
 1 file changed, 20 insertions(+), 21 deletions(-)

-- 
2.17.1

