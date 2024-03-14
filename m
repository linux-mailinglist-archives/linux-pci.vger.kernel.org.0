Return-Path: <linux-pci+bounces-4826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB187BFF5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2271C2297D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59273526;
	Thu, 14 Mar 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TlpE4MTu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495B7429F
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429867; cv=none; b=raddwUcQ2fxm8NO1P7ZjiBKpdxiueakzrCe4pOvJDpIjNS31Vrt3FLusoyrd8sow/HDJOqCXStfXMcSXbXPgJq+/zH0yN1lf7GFiMMa45dE1hDly24gX1jJAbRnUjAWAR6EQbVOEzM5O7xXx35oiaOAHsoEa5QVzYTHDORjZGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429867; c=relaxed/simple;
	bh=DtlRqv5F0Ytl0/lk4U3qf6wbQNKU/3llSWJh3kC84BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yal9T1K5SlXu5MUCxe/NMGOlNkQmabALZsl5D/VsthASm2l5f8jsrmqCA1Wn+rs8zaAmj9auYGQgUAIoaStl2hrUH37AJhG20lgEh5bB6mpbdgtNpPDMvoj5kuOzsLOOeJK/JAyowXKCTKTBGjLnqAVH2Vuh/12jFMyN/sB5XEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TlpE4MTu; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a43329565cso322476eaf.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429864; x=1711034664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UC/JTb5/el0zq5fPOBPWkuJ8boNZcgw6JdBjsjQkQVo=;
        b=TlpE4MTuTiq7VE4XDnBBxCBLW38T3bkwCc74Wi8eEvgnv2A7sj4lLtG2UmyMMoTWsI
         uo5QsMOmWIY2bPNrOxA9xs0j5wGnaCfizzwL8ygXJnCX9J95dg3pTgH45Gq/y06XP5yZ
         V8lq6gdno3B8qIs9ldMvEXWkylaYYuZm67ruJ1XtpNFBTpSNDwMorgkzYDY7AJBNG8Od
         54qxw7w/XhT4iMx8mp5+FoxOnMjzvCS4yjut+8augQuyp3fOh7wkoS3y6dWQXiQg2STl
         PMFTLrD0ZSyvOEXX6w9Q+y0WPigrbhtW1yuGA+bTW1nraQYYC3D74fEgKVL9bVh1Ijqf
         eWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429864; x=1711034664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC/JTb5/el0zq5fPOBPWkuJ8boNZcgw6JdBjsjQkQVo=;
        b=gA01BAAdEMdRTaJYpncMyo2QGcv665gfH/G1KOOsM08GH18zcuWEt53BXKhq7+iJUz
         ESm+PIGXCdj7oWcizqQlgUcYScSg1Zy4/RewygER6RpT3dWqePmGbQXBd535M2HBcZXH
         ALlT77HqscbGKl/OqJBGgcJ4ELqTRp//53AczOtqmM4KlHJDVFgjrIrMiPyeaCkB22Vb
         6AahFZ1xNjqte2wnHYcctNnjjQpdHMD1zvbBhH99+Y6OIezY7TioOBwyFyy81wMXj16e
         OBaqoLu1pvnylqbtmPP6Qld2P77BUZS54MwIhMao2U0B4CuuOPnNxSzHWcdQvcJD7Yu+
         d82g==
X-Gm-Message-State: AOJu0YxAti+QsC7PL2CnXqFq8r0ZwfyyTz4q6bqdR1/+XReIHh7tf1qn
	1Yqs1qV87+x5fFWYpjuNuyqElhoeSXslHKpQERb2De1X9THjFh7Usn2wq/3NTw==
X-Google-Smtp-Source: AGHT+IEvaMb+kq/9lTqNU5RsDY6HF44EQNDk3hWuMaLlsYMMXmYN4cL3/H6gm79wueLO7Uah/GddRw==
X-Received: by 2002:a05:6359:4595:b0:17b:f721:4565 with SMTP id no21-20020a056359459500b0017bf7214565mr2583482rwb.9.1710429864237;
        Thu, 14 Mar 2024 08:24:24 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:23 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 20:53:43 +0530
Subject: [PATCH 04/11] PCI: epf-test: Refactor pci_epf_test_unbind()
 function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-epf-rework-v1-4-6134e6c1d491@linaro.org>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
In-Reply-To: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3251;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=DtlRqv5F0Ytl0/lk4U3qf6wbQNKU/3llSWJh3kC84BI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaPAyz+988uZe7rmcr+FE4mObQJvWgDMjtPA
 pAtrbNOuvGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWjwAKCRBVnxHm/pHO
 9eAoCACI5/CJ9PWdvD+VU8d2Gn0KeJ6lsXgzuOnuu7+hCl2uaapddhtT3FSiPt8UOBMPW32QezH
 voUagEwTlRqpJMy0UkgnEoq1kMK6xbhDLeY6hIGR6RnSxfEm1gRiD3gLtV0rNnktVnLxUdRPmJM
 zdTyuxOgUqqzpQ6MNumI/x1yw0WQfuKiw+upojxa1/FiXJ7M/sel6J9BNXwlAhajWItXWqbTXgR
 Bkh3Uxczc4c3Tzhsw2aMUMYM6nV88U3neL+jQQirLKOI3T/vE/WJwgdtlZla9fhFgM0Qj4iJ7JP
 YnzT7vSyoFTjsesiBTM7ZgqPwTUSfCATX++DwyKM1V80BZSB
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Move the pci_epc_clear_bar() and pci_epf_free_space() code to respective
helper functions. This allows reusing the helpers in future commits.

This also requires moving the pci_epf_test_unbind() definition below
pci_epf_test_bind() to avoid forward declaration of the above helpers.

No functional change.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 63 ++++++++++++++++++---------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1dae0fce8fc4..2fac36553633 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -686,27 +686,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			   msecs_to_jiffies(1));
 }
 
-static void pci_epf_test_unbind(struct pci_epf *epf)
-{
-	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-	struct pci_epc *epc = epf->epc;
-	struct pci_epf_bar *epf_bar;
-	int bar;
-
-	cancel_delayed_work(&epf_test->cmd_handler);
-	pci_epf_test_clean_dma_chan(epf_test);
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		epf_bar = &epf->bar[bar];
-
-		if (epf_test->reg[bar]) {
-			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
-					  epf_bar);
-			pci_epf_free_space(epf, epf_test->reg[bar], bar,
-					   PRIMARY_INTERFACE);
-		}
-	}
-}
-
 static int pci_epf_test_set_bar(struct pci_epf *epf)
 {
 	int bar, add;
@@ -746,6 +725,22 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_test_clear_bar(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_bar *epf_bar;
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		epf_bar = &epf->bar[bar];
+
+		if (epf_test->reg[bar])
+			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+					  epf_bar);
+	}
+}
+
 static int pci_epf_test_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -885,6 +880,22 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_test_free_space(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epf_bar *epf_bar;
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		epf_bar = &epf->bar[bar];
+
+		if (epf_test->reg[bar]) {
+			pci_epf_free_space(epf, epf_test->reg[bar], bar,
+					   PRIMARY_INTERFACE);
+		}
+	}
+}
+
 static void pci_epf_configure_bar(struct pci_epf *epf,
 				  const struct pci_epc_features *epc_features)
 {
@@ -940,6 +951,16 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_test_unbind(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+
+	cancel_delayed_work(&epf_test->cmd_handler);
+	pci_epf_test_clean_dma_chan(epf_test);
+	pci_epf_test_clear_bar(epf);
+	pci_epf_test_free_space(epf);
+}
+
 static const struct pci_epf_device_id pci_epf_test_ids[] = {
 	{
 		.name = "pci_epf_test",

-- 
2.25.1


