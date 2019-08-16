Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB38FEF9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfHPJ0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 05:26:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33391 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfHPJ0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 05:26:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so915314wrr.0;
        Fri, 16 Aug 2019 02:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIWx6CaxG/uLJ4bEXyuLwT1G87Dm8YPWSJ3PPeconzU=;
        b=DQTb2WbWyYu0KnLdqnJVnUTauIbErgLoXBHTLCft0DwoBRcfOWKKyLgZiktN/CLsSb
         dz0Q7MX3u3ZtTtx7nW6iQnIFQI5G64evWA0Fg2XiIFNAu0pDQUAldC3DEZnunJB4LWX1
         LE5riguqfIN5xuMACfpVNp78ma/fcqw9TXG3oacvd9kJKnW4syLcZ4ONtbIwvvJXfchK
         hBbFA/uWtskZDVGIxPhpZXG1fYyd0LGtIHPZnDk/k8EwyU7gQFNH+TseB3KEMuVZyL3v
         MaYy6+WZm51zEeplyiAH5Ifp+a0ohbcghSqnaRXS/SjrIAJqXF1HshzvUuOl5W4gLUDO
         uL0w==
X-Gm-Message-State: APjAAAWnn19fT7HPGsQvxQBHkZXlXvQN3C8AXQDwatA6OiB4tdIak42d
        nfUfgAccI/+wUa8N0B/bozwtx1j/wU4=
X-Google-Smtp-Source: APXvYqwao3NDsFoACbdfqfDD1z7VPAGtorUtFADCe9Hjpb7lK6xv/P1JXTArZYZlE93oqNQ6CwljcQ==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr9588210wrp.253.1565947578220;
        Fri, 16 Aug 2019 02:26:18 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id q20sm16521138wrc.79.2019.08.16.02.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 02:26:17 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] rapidio/tsi721: Loop using PCI_STD_NUM_BARS
Date:   Fri, 16 Aug 2019 12:24:33 +0300
Message-Id: <20190816092437.31846-7-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816092437.31846-1-efremov@linux.com>
References: <20190816092437.31846-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor loops to use 'i < PCI_STD_NUM_BARS' instead of
'i <= PCI_STD_RESOURCE_END'.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/rapidio/devices/tsi721.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 125a173bed45..4dd31dd9feea 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2755,7 +2755,7 @@ static int tsi721_probe(struct pci_dev *pdev,
 	{
 		int i;
 
-		for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			tsi_debug(INIT, &pdev->dev, "res%d %pR",
 				  i, &pdev->resource[i]);
 		}
-- 
2.21.0

