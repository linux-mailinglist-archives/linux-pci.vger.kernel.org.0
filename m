Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238D919FE33
	for <lists+linux-pci@lfdr.de>; Mon,  6 Apr 2020 21:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDFTmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Apr 2020 15:42:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42301 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Apr 2020 15:42:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id 123so4752768qkm.9
        for <linux-pci@vger.kernel.org>; Mon, 06 Apr 2020 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVcVw2+XyarjLliJhsWbk6Q+A4rEQZQLlrQ6mwENqLU=;
        b=NAWrTQpU9z1FzQHFypjlpm0r6nUpn4uhOvlOMqh0GMp5CY+40xEfFABK6mtg44ZVaN
         Z+4QJdrEBUAak/momf4dsXLDaz5hn9xWFORkfPAw/c43f51WEwLkK34uJ3gdNapsnQFI
         WfDCnwk7b1mPfgyU3iLOovyOcwUIEAvIDAx8EuEV55mNnJ9mNASFq/dFIcKq5/FV0xvI
         vhvX/mTmLsoVTOyTErHrrh2Hb1nZolCoGTaD1eBOQTO++T/6PZDsUC8xCv3z3mvMfnli
         nlXp5g4y2XNnyxPqe8sopxJmo/vai3bQangq00OLrjyM4lTKYdb31VYy/9xgChQK1BH0
         1vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVcVw2+XyarjLliJhsWbk6Q+A4rEQZQLlrQ6mwENqLU=;
        b=rjddwnNUmQp2kKDZwjqYsQJLNzeLqNi2/0nHiXewpaLKeGR/8SIAFK7RcvDMWGFBMn
         1Mk/j+tDflEk8QhN0bvZguqm16HntQN9hLQ5+CYpzB6zmjUFOoaP6hr8gLP7tBVZ0T4B
         r6n4dnvPvf8C0qU5Gh9UTsw+OOAlU5bZ02aL6/edSuqPaUxAVbDMfM/yUApMolbaEa3e
         Wb5FwG5hqSFFqzao9uvXUEf2nQbEpHvC36CBAbdAL7zxPrXBJXJ42kqmZDmhaKtjd0f1
         HYCWkDZOUh7CKnqfINZl+GTomH8rBvzMntvy59aNg/SRlCHjWuvQlV9ixFtZIz6VYyrS
         +6Cw==
X-Gm-Message-State: AGi0PubDVRip4UxDwF8JFxVOxSXp9nPZkTDmh9GHI2WXXSADYncCKF8Y
        3qBaU9dpsrAIgxKCEq98tVJjb9CD
X-Google-Smtp-Source: APiQypIWVjqg/SrJqtr1Az8CQIC+itQCYKBI+NiaqwBhkUbAt8MgrMTrSiUTv+DVAzj05q+ewNFzfg==
X-Received: by 2002:a37:9544:: with SMTP id x65mr21445577qkd.48.1586202129416;
        Mon, 06 Apr 2020 12:42:09 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
        by smtp.gmail.com with ESMTPSA id z6sm11246360qkl.95.2020.04.06.12.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:42:08 -0700 (PDT)
From:   Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] PCI/P2PDMA: Add additional AMD ZEN root ports to the whitelist
Date:   Mon,  6 Apr 2020 15:42:01 -0400
Message-Id: <20200406194201.846411-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the hw architect, pre-ZEN parts support
p2p writes and ZEN parts support both p2p reads and writes.

Add entries for Zen parts Raven (0x15d0) and Renoir (0x1630).

Cc: Christian König <christian.koenig@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/pci/p2pdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9a8a38384121..91a4c987399d 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -282,6 +282,8 @@ static const struct pci_p2pdma_whitelist_entry {
 } pci_p2pdma_whitelist[] = {
 	/* AMD ZEN */
 	{PCI_VENDOR_ID_AMD,	0x1450,	0},
+	{PCI_VENDOR_ID_AMD,	0x15d0,	0},
+	{PCI_VENDOR_ID_AMD,	0x1630,	0},
 
 	/* Intel Xeon E5/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
-- 
2.25.1

