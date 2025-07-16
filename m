Return-Path: <linux-pci+bounces-32321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58BB07D91
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FB31897B3A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5F29A333;
	Wed, 16 Jul 2025 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Hr1+KhK+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A713D503
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693986; cv=none; b=qcrPFBb+QFU51raLnNwHzSxGdOZZ0iJ/jcQirZwRD4GvCAjwLgoJGpm5m0xeQl34AqiogoIEFgyIDRiD6suCeNLEldKy/qAn8Zs9KoDQwmyBPai+Jb+pRQUWz6BMLJPiYmmzdVoXGbDmTLKjxDFxhBzinu/0Z+BW7DZpvwMa+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693986; c=relaxed/simple;
	bh=xR0XjQiaS7rIsB0NZlYci1cTGX9iJJqeejML5l9Zrpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+Frk+xRBMXtvo1WwUwkCbwlVgMRJiNdGIvopMv8u+bF+B/pDhmtpNd/5UYzC7OiWwd/YBB1Nzy894mW5weim6/JEWyvc5WryVF4T6SWAMdvWSF/gwFh3qx0sUJTnamKub791X1Ti6ICiey30fQ8j6+NvPQ80gh87v/S41k1yx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Hr1+KhK+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ef62066eso2000995ad.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752693983; x=1753298783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C/VLHRijXpR1ghxEBCofdkv81gaq1NzP6Jk3MgP7IQ=;
        b=Hr1+KhK+xqtQHC3oMeORYW0BfxtR1YK5liQhlaFyZaFaCYMxvTOgQOOWvSHs1Yh3H+
         ACXs83gv2lQP0DONA7Tv9DprQpvBs2inY8rNUr/8nQSvtEHQw4H7TkWfb1UOfwqbY1y1
         HSGhdwA3tLVxooMuD3YYcCrzgHULm52R19MxXTL9liFwofQ7q0ab7oOewcmPvQHuEiZF
         nTcd81cQxMhcl6XrVeBZxi6ix58DPNytSqBe9XuOCZtfYD9yzkUniEIeRUrkXTdC1BYZ
         bzNqpKJdRmuUtgjPTNty8gXbhwVuzckl9usdGPwRgeavCP6jIywQkJC3oSggZEL+wJtD
         uUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752693983; x=1753298783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C/VLHRijXpR1ghxEBCofdkv81gaq1NzP6Jk3MgP7IQ=;
        b=rYynt0mi+ACWz0TMQngEUWGPpMkR4KteLpd2YrruoFNh2x6tY5NrDcXiOSxeraDJw8
         COi/o5snqvUhKEva/mc05kEOdsXJ6VcPjKymztx8THJPiHXpsng0HJi+Xx84WDSdz6Sp
         1rtiDf5d3T90cpNWxrM2rr4sbioTBuMkMNopJrfKp8ptYE3RxY7lvONBNmLfPYz5d+j+
         mdBZJFTOvP3nZvHmOKWAtwYXoBj9gmUGS0VheWt4AOZ2THV8cHBlpepr7vOyivNozf7N
         vFZ2M79BHKyC/fYY2wGWzmx9lS7aQhuAMgKF5qntLp9L/6HuT9UsuUDBHh7FGKDmNZe5
         W6kw==
X-Gm-Message-State: AOJu0Yyxk34R3tUmbvzljNdIFuFA2086Lt/65VQCb6ynXCO+9q1qOJQx
	PwzYm/AYhB8snxDSX+vgEpXO6xLLlPQffgv5mqVZCBrt7j5kmn6Xvh3nrRvS/j8IG27rgfpz6EF
	ZbQXwuDCDlLCgjQOIAN3Ln4VIHegyKhK/oj60r+Npu9MJYwyOR5RLjvQsv/wkKT00ZLnwU6qpOS
	3KzeB2+onqwEgDe4tJpxHP8R5dRoqUNeVdSzlXEq71EfjZ5Q==
X-Gm-Gg: ASbGnctwrp6bqccogEW0Zyj+Dn7+70V9wTJtmxXYLXAKw/oBQ3hlQI8AFGzduLMWq/u
	mS214hYRAPcMNfFMA1lLnlweEgR8E/1bUgzIFmFf+Utb7Jb5fiybDKH7HV8aNjdkYiLLnlvuTk7
	HotPezRf9ovdysdAFfEHkNZjfe6Xh0axKWn/ZxdguebBVsZimwPa+vDPLiyPesZrrVPD0cJvARe
	IC1jDRX/9rq/BLcPej6m8lhnfSqNx/2anYKAIATlGTuI+pzPzvWw2WPM9Ll9XOXpuUq90NaucHQ
	+6fp07j4MYBXAF0PtRm6lC8l1qnISJ/WrhYUnziaINVUSqhzMuR4arMTY6rM8yLRHHe4DpemaqV
	4fNby92jQeNkTDZc8rFOx5uqSQfQoKoztQnr3uT2Db9Pnj9Nh
X-Google-Smtp-Source: AGHT+IEgXCvra9uOHJdHIIdThzlQnNtZ3baWdpTLYvk+AMUVDI/tlhicIiGt9Em+1RLmwGH6NF/FDQ==
X-Received: by 2002:a17:903:8c5:b0:23d:da20:1685 with SMTP id d9443c01a7336-23e302821f4mr2990905ad.4.1752693983428;
        Wed, 16 Jul 2025 12:26:23 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de42b28a6sm134716765ad.87.2025.07.16.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:26:23 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	ashishk@purestorage.com,
	macro@orcam.me.uk,
	bamstadt@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 1/1] PCI: Reset LBMS state before clearing DPC status.
Date: Wed, 16 Jul 2025 13:25:46 -0600
Message-ID: <20250716192546.16942-2-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250716192546.16942-1-mattc@purestorage.com>
References: <20250716192546.16942-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have observed LBMS becoming set when DPC is triggered on some Intel
Root ports. Since the primary feature of DPC is to contain errors by
disabling the link it is desirable to avoid carrying previous LBMS
state into the next time the link comes up after DPC status is cleared.
Specifically when DPC driver waits for secondary bus it should not
take previous assertions of LBMS into account which could have occurred
as a result of DPC or for some other reason a very long time ago. This
prevents the kernel from being heavy handed with the pcie_failed_link_retrain
which may thereby force a link to 2.5GT/s when it could have achieved its
max speed. If the EP defers bringing up the link until the quirk
pcie_failed_link_retrain() has written 2.5GT/s speed to TLS register
the link would be forced to 2.5GT/s until user intervention or a later
hot-plug/dpc event.

Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
---
 drivers/pci/pcie/dpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..0bcc99231dfc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -164,6 +164,13 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	 */
 	if (!pcie_wait_for_link(pdev, false))
 		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
+	/*
+	 * Some RP's observed setting LBMS when DPC triggers & we should also not
+	 * consider an LBMS assertion from an indeterminable amount of time in the past.
+	 * Provide a "fresh start" when waiting for secondary bus & thereby prevent
+	 * pcie_failed_link_retrain from degrading a healthy link.
+	 */
+	pcie_reset_lbms(pdev);
 
 	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
 		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
@@ -330,6 +337,9 @@ static void dpc_handle_surprise_removal(struct pci_dev *pdev)
 		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
 		goto out;
 	}
+	/*
+	 * pciehp will pcie_reset_lbms() in remove_board().
+	 */
 
 	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
 		goto out;
-- 
2.46.0


