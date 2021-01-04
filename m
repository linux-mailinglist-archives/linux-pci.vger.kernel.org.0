Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8902EA051
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 00:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbhADXDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 18:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbhADXDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 18:03:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C42322581;
        Mon,  4 Jan 2021 23:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609801387;
        bh=NXwP1ErKyVJODnA/aF275bllkVjGP9RBRQ1wzKV26FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amu7uWsHmLuJzrq+ON928FZE2SqIcsShInYhnf8uGlJCXlWXSgV5aUVhoPGtGAxBa
         pgNNhIp4xqzYjF/kX74xhTxrc6FYRpNK6xC/U0BnkvhPBmBgS4TC/fdAv52KvYlxqh
         +Z0l9iXoxMQb9CBuqVx2+GzjRmPoI/jiTevrjAnIfgHNadaqoig4nlovXVQS8OhdO6
         cocT7NoPleBWi1s8GoVafQmf5GQI2PPU28RG6eq0b3UI1MbShz5xifARhOXo5vivS1
         JbRbpPPd1Ina5UwapYEKCHCi1P5I7m55KWvePXfKvz/g1/kuqVoJ4ds76gsW6rmx02
         kZX4IfFmd8L8w==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCHv2 2/5] PCI/AER: Actually get the root port
Date:   Mon,  4 Jan 2021 15:02:57 -0800
Message-Id: <20210104230300.1277180-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_dev parameter given to aer_root_reset() may be a downstream port
rather than the root port. Get the root port from the provided device in
order to clear the root's aer status.

Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 77b0f2c45bc0..3fd4aaaa627e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1388,7 +1388,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	if (type == PCI_EXP_TYPE_RC_END)
 		root = dev->rcec;
 	else
-		root = dev;
+		root = pcie_find_root_port(dev);
 
 	/*
 	 * If the platform retained control of AER, an RCiEP may not have
-- 
2.24.1

