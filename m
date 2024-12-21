Return-Path: <linux-pci+bounces-18933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556F79FA1C2
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 18:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76051188D55C
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206741494DA;
	Sat, 21 Dec 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmXqCrBR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1EDA59;
	Sat, 21 Dec 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734802574; cv=none; b=cvJwKB87RyKB7uTqaEVa5AMOjIiUyc3kbwELpErsCq7PJektj377MlC5JeS+YVb8SG3fjkGVaaXRQCQehJQixD9bEefZb7aBqhftbCyRAZO+sGlCmXTkWq6b3THHj51KART58TGUd7qfhM2b8jnGmTUn3oslHWzRoFTRBAzGv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734802574; c=relaxed/simple;
	bh=tU+O+KZOr36RsTmzJu2opu6UgeAiZdWTfapZVJd1x5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6d31VeWKuZ0eK7tszzg1oJ5HAaOd9mfuQyIq6oiht8/7hMvVWuZuHxj+QwYp3WSSV/NfP/nGaXJgEWm0i5P3Jy9ZN9XdyALk3sIFO3N4I7RLoKgrIjDg0Plo0Yo5hP23/vEpD6HYShan4liS4v88Q9wY7Mja0slqOTmV0ylZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmXqCrBR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2156e078563so26685985ad.2;
        Sat, 21 Dec 2024 09:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734802572; x=1735407372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gXKafZVySW/I6RvOsdRN7NnO8pCEPiUbxSPkwY5oIk=;
        b=GmXqCrBRM+un1vFDs0Y6sAtxRzpFymxB/awV85rvoHGE+YbFqI7CxI3FA46YKs2k7q
         GYxzlFNr2cVD/XhniydlW8T8Qn5cKQPdOQNZBam2TMyvLox56deLik35KKxxKZIzNBcM
         l2vC3No2hnpZ7qluPSwLJrQ0pZgaAGS8uJrHUqBbxxsNpwVpJZHNo92cjK2T58hi/F6F
         w9NyB9keyI5qQ4jngboO97nUwE8LaDtspRQiv2/Gv8Omn6el4YjkRmK4IJnNi3zJTAve
         ZsaKDFLQ/AqNnXHvhBw0yaKX30Ct6Rh88C4H8oUeaEMjDy/zlVcmIubSvIV2arfwD82d
         K6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734802572; x=1735407372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gXKafZVySW/I6RvOsdRN7NnO8pCEPiUbxSPkwY5oIk=;
        b=Rv/1IEcbzO+w2oGdyr2XyouVMUzyzYH0q1yLI/99EqcYlrolWNg5XF4J/bbV7abx/b
         ahrMNqELYITXFhdnh5elageRl0qElLHZlUYeC0CMXDsed4VLXXaXqTV8ily0Pd51f5B/
         urV/Dp5zSV/+d0LWB4DyquCpPaqooLIJrXSlfITXI5UDTPqIolr+ovRsexz5doLdMUDr
         8j7Uq/5oP1piTFQ8/8y9IMohe1GUbLf5DYhLitqTsUw1GdqdCCJsgoTpugwEmnMGXmye
         dlYSeN824vernkW5lvSji+g0x3IJDy0SNZkGM9MbRZsiSICh2bS2nUnDrtcMBxHvJJ75
         gSig==
X-Forwarded-Encrypted: i=1; AJvYcCVMkH6BcvN9lmVsD+fsZhwxx47q9rr9xbpYFfHoeRKS/AgHhJw4e1Cheq1U49PZpYLUreNhoFnLBRPk@vger.kernel.org, AJvYcCWJbLGPe3HoDT3/6meK/zLKch1VFj7vKkQsvbKVOPHqAOjZo56MK/QJndO1N3p1bed0Bye4+0sXljbA624=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pQVvlwqMVoW6OP0VbvQTvdq7A/nAn8c0pOQ9dMHUctRUKLGW
	cqoteVkAxERsvMlO7Lj9ODDHj2YhxqA2zK8hRon/Q3CQSGr4in4o
X-Gm-Gg: ASbGnctOLOmCc2uDs4yTa0WR8yc54RVCM4+5cnij6g/HGJcxyB4WimsMvs5Lc36fPnX
	Fz9yPUkWUFbMgrPGcNx4NfJSbt7aeNPwdKdDbDX5bItmOKDsX2dHn9ps4uKd0pP5BXD4vo2oWgE
	QTX6SxOv2XKawWkkCasLQ2bQfQeUjHfZsbNvQ8ObuUirMsmy05ZVToEK9S6ggeckZhAsky359mQ
	kfdHvHqDdV8ZFhd43ehTijaHlVOilzS5+Tah4cr4Naeny+2wv5jIbOoEUNnS7Wz1/vK/2OTqY9t
	aWyc8q95P7pkxupQTH2XKxX5OA==
X-Google-Smtp-Source: AGHT+IFnwf5L4ZUOgclEzopgUEVjQ273jKX8nb4A+1KEkRifPe7gssLnCwwtDHO32LCRMBN/FCXQ7A==
X-Received: by 2002:a17:902:d483:b0:216:73a5:ea16 with SMTP id d9443c01a7336-219e6e9e08amr81928555ad.21.1734802571907;
        Sat, 21 Dec 2024 09:36:11 -0800 (PST)
Received: from localhost.localdomain (c-24-7-117-60.hsd1.ca.comcast.net. [24.7.117.60])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-219dc962961sm46584115ad.13.2024.12.21.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 09:36:11 -0800 (PST)
From: Mohamed Khalfella <khalfella@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mohamed Khalfella <khalfella@gmail.com>,
	Wang Jiang <jiangwang@kylinos.cn>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: endpoint: Set RX DMA channel to NULL after freeing it
Date: Sat, 21 Dec 2024 09:34:42 -0800
Message-ID: <20241221173453.1625232-1-khalfella@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Z2Z7Ru9bEhCEFqmc@ryzen>
References: <Z2Z7Ru9bEhCEFqmc@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a small bug in pci-epf-test driver. When requesting TX DMA channel
fails, free already allocated RX channel and set it to NULL.

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Mohamed Khalfella <khalfella@gmail.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116..d90c8be7371e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -251,7 +251,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 
 fail_back_rx:
 	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_tx = NULL;
+	epf_test->dma_chan_rx = NULL;
 
 fail_back_tx:
 	dma_cap_zero(mask);
-- 
2.45.2


