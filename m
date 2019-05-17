Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FFA21DC9
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfEQSsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 14:48:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54126 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQSs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 14:48:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C5EC619B1; Fri, 17 May 2019 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118909;
        bh=P/hWDoOqVaRAA//LwTH4zMFxt0mPSjrmyOPmLTB6goc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wk2Z8fzwphZ75dgUXY2CHpEWyyZsHo8h1prH6M2hO85HZN4XHyA5h4Dvskzs32vWs
         W4HzCCMwjxkDGg9JxUw5dAeDxKk7F/R6TYdykTMgeNM5dorPkLmfWfsDAwg0uiWUcs
         ryrhGodqT3DNl8kRY1wsADa6T24zLaL0mjO7tpvU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D048618EF;
        Fri, 17 May 2019 18:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118901;
        bh=P/hWDoOqVaRAA//LwTH4zMFxt0mPSjrmyOPmLTB6goc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfpDLnxeIPU6NUIdpUd/TjJOc/ag7MqQuKJcyux/eHC9sh5ZQi5AzegZRawPdGYu3
         HfEfHMlFkdkx8diUL2rUMcZDn1zSdN2eYynIbfgQJhNC3fbo3o0uXw2qTMpTaBxMaD
         iJ/XKPEcjJnh0B6mm4gAH9V965/21KEPbCCkhHsA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D048618EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, joro@8bytes.org,
        robin.murphy@arm.com, will.deacon@arm.com, kernel-team@android.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: [RFC/PATCH 2/4] PCI: Export PCI ACS and DMA searching functions to modules
Date:   Fri, 17 May 2019 11:47:35 -0700
Message-Id: <1558118857-16912-3-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IOMMU drivers that can be compiled as modules may
want to use pci_for_each_dma_alias() and pci_request_acs(),
so export those functions.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/pci/pci.c    | 1 +
 drivers/pci/search.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 766f577..3f354c1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3124,6 +3124,7 @@ void pci_request_acs(void)
 {
 	pci_acs_enable = 1;
 }
+EXPORT_SYMBOL_GPL(pci_request_acs);
 
 static const char *disable_acs_redir_param;
 
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 2b5f720..cf9ede9 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -111,6 +111,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pci_for_each_dma_alias);
 
 static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

