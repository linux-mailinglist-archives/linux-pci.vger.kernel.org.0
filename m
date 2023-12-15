Return-Path: <linux-pci+bounces-1059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87138814625
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2807DB236F3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2171C28F;
	Fri, 15 Dec 2023 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="Viy03zJ2";
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="DmdhF3Ij"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9067288DF
	for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flawful.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc3facf0c0so4738791fa.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 03:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638037; x=1703242837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lq6j0mU5Mll9Pawu/xX7IuMY9JzP34OhaczRh9tSeeE=;
        b=HPijH+WTTR9LICg2dlD9dd5va0y0WhnQszdbIfRpv8xb/xRejBKl1Nu9P0bw3j3TTt
         eD0YWA9hrXyOVsC7vLqJpkTr3PUX8vEvbVLw62JMuoNAkLmki0w9QdnhtWg4dVVhdAoQ
         NTg8s0hKYwTxD1dtUeRYzN/8L3fcfFPgYoansE40Kbf+t7d3KfnopKUrd1SSiIT0kROb
         zyN/KdUFPMv9xpQfDIIPs3hp1XT8GJnAgLCg+2PTx4FoUskEjTdni13sB27NmSfUX4jF
         wUqCig3t2Er9r+QgYNvUrWMej0XOX3PUiBNNnBE7SDv34apHwvIbEmTDJffUagnoxiCb
         WKJg==
X-Gm-Message-State: AOJu0YxQiJi0OEqEyo5Rl7HjMutpELU+St2dURHsjJR7HLVwjRW1Hf7e
	1fbDXw9IGLnGIAjFVzp8gXzSVBKjYDpTLA==
X-Google-Smtp-Source: AGHT+IGYP8jd/9BZHwFUf3uBW0yT65DMb7sWp/K9ut2pWkm1SrzMw3swFrYjV+NUsYS9CER4qoMUhg==
X-Received: by 2002:a05:651c:1a10:b0:2c9:e9e4:54bf with SMTP id by16-20020a05651c1a1000b002c9e9e454bfmr8460827ljb.6.1702638036778;
        Fri, 15 Dec 2023 03:00:36 -0800 (PST)
Received: from flawful.org (c-55f5e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.245.85])
        by smtp.gmail.com with ESMTPSA id r6-20020a2e9946000000b002c9f71e61f3sm2413297ljj.6.2023.12.15.03.00.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1702638035; bh=6XnQr7IR4mSYvHDqnRSpGCYXwO21MgtFIwPtN9/Ek6g=;
	h=From:To:Cc:Subject:Date:From;
	b=Viy03zJ28HZL3+AjtMxwzNdHVQTosg8vwyQSZr73f4/bX7kvVG+cGdxmbJ2AIijWo
	 qFoCCg8AN4kgCuiR8+NpZbHn+2tbVG6oDMBwpg2mZUycOAk4MkDcx/M3tPS8VPCBas
	 6Kn6LRo9f2aw0/PPkvE8AApWozhj74Rd8eSy+yLc=
Received: by flawful.org (Postfix, from userid 112)
	id A8A32267; Fri, 15 Dec 2023 12:00:35 +0100 (CET)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1702638015; bh=6XnQr7IR4mSYvHDqnRSpGCYXwO21MgtFIwPtN9/Ek6g=;
	h=From:To:Cc:Subject:Date:From;
	b=DmdhF3Ij/86U/cHpdj9MLqHAcON6J/tO7NWRB7EIFQLOgsz8Xi83EtMu07dMQ9z+s
	 94I8YXAjUWazp1v7pDyFqSXkhwOG6LU3j8XcKs9O7oSXzl+/8R38kD2icjtxpwxnII
	 hM67ohCIBveltk/cIAIIPm/ghwa5LfOqtwePF580=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by flawful.org (Postfix) with ESMTPSA id 0A2BF60B;
	Fri, 15 Dec 2023 12:00:08 +0100 (CET)
From: Niklas Cassel <nks@flawful.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Use a unique test pattern for each BAR
Date: Fri, 15 Dec 2023 11:59:51 +0100
Message-ID: <20231215105952.1531683-1-nks@flawful.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <niklas.cassel@wdc.com>

Use a unique test pattern for each BAR in. This makes it easier to
detect/debug address translation issues, since a developer can dump
the backing memory on the EP side, using e.g. devmem, to verify that
the address translation for each BAR is actually correct.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/misc/pci_endpoint_test.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a765a05f0c64..7ac1922475af 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -263,6 +263,15 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	return false;
 }
 
+static const u32 bar_test_pattern[] = {
+	0xA0A0A0A0,
+	0xA1A1A1A1,
+	0xA2A2A2A2,
+	0xA3A3A3A3,
+	0xA4A4A4A4,
+	0xA5A5A5A5,
+};
+
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
@@ -280,11 +289,12 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 		size = 0x4;
 
 	for (j = 0; j < size; j += 4)
-		pci_endpoint_test_bar_writel(test, barno, j, 0xA0A0A0A0);
+		pci_endpoint_test_bar_writel(test, barno, j,
+					     bar_test_pattern[barno]);
 
 	for (j = 0; j < size; j += 4) {
 		val = pci_endpoint_test_bar_readl(test, barno, j);
-		if (val != 0xA0A0A0A0)
+		if (val != bar_test_pattern[barno])
 			return false;
 	}
 
-- 
2.43.0


