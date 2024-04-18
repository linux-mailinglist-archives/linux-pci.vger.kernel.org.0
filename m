Return-Path: <linux-pci+bounces-6419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2D8A994A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97381C211D7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA5160877;
	Thu, 18 Apr 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKUNkZ6m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942A16079A
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441548; cv=none; b=QRmPcx3UzPb8qSQOKuvPWAl27+RJpc0ooCf6d1D1rN5E98buOzzNpIdA7qui4RddU4C6ie4fxILXTJoCyIOILi0JxmyDkU5aA1e3zbiD8BkXG9D9I4B8yTpviCK8U7TbvgJ8oNuncVIlmJ3SRbAxe6UaTOjEY4pQUegnAlSecus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441548; c=relaxed/simple;
	bh=ZVpMtASDroG5xgP9YNqj8iEe9ZOXPH9GZK0T5NEQXA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khwJ5JLgjBzM+TdN0VFidNuUxdJu3IHq+ZmAobBchM7G+uVlvD3RsjoWiU+Z5cbroHLp13swcMVwttjB7YDQbFDw+WgydJHIixi2fkQhSksSedqlFwyk0cEHpBYuVU3ilDON8fQvoPpH2xdDbAQOqvv6ym9cL7wKeDU7szuMafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dKUNkZ6m; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso475559a12.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713441546; x=1714046346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbF6jYa8z7u7B75OT+z/3TtJOTDZ/CVRBSy21cpI2UU=;
        b=dKUNkZ6mPbW10yeKDvm7fnx+PhmhTdhzD1lwerdQturSfhllQgZ6R4h27uKFQUnQM/
         DCZ9z0jtFnjykHEGVGFG2mmYJbgdm7BcptS5tuqlK4V8Xm3D2bPOn4n+TcCTIim8yYbC
         pTbVaytKv/+ONB+fnzARJZSXPudhe9hay1MqlKlYRfXNw2tB7jm3taqKBQcRDcL6quLV
         LQirY9sSOlobAdDYmwtDe1tyVIUTAY/PItQuP8I0mmx/e60od6t6C2mjMUXs26KyoU8K
         3PGDBX4yUTurzf+tAN2oykkV4FdYhQlKZA3a9sLwZFDhMFrJImfrPPSk9fNND6UphHeW
         PZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441546; x=1714046346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbF6jYa8z7u7B75OT+z/3TtJOTDZ/CVRBSy21cpI2UU=;
        b=DOhTNnLsCTouos2ky1yzheCisBjzKLfZ0N4pAVdyGr85OfiE0HZ9lKm8DleW3lUNzy
         ua1mgbbcJ9gUcf/fpeAWmm/mV7v6Jp9AGG2ePx5TuzKZB9pkObfK+H99Q22ycjsCf6pc
         CyVLdwaQpI6O3+L89XNLn8K3MiFEHltHH5oTMQAAs5WMW0AxMG+SkbkhhLXcB+RdxMRZ
         EbrH4BiAn9YixR/1M6jm6bVDNEFJiczjws19yuUhgaGOzj4vE/PHq9j5bFfE4xeLSDbx
         HPXQkzalC7dT2CtWQqBd0saRj8fDHYWh1rMcGYYduwU4CiXBa8TZn5Wh40L+c1/0NEpw
         E52w==
X-Gm-Message-State: AOJu0Yz+jJZhgf8k6xnvmZaYNezLymWh1wS2g3qMY1CW18i+iuAJQA0/
	8bnnwFsi4LpLTA52DJUAIvxhLl8MLV7jotagttLzYsMZHHTCDVVecQ8mUV5p5w1N/ymcad2n+H8
	=
X-Google-Smtp-Source: AGHT+IFUqZJeWiWa1CtZkEQ7Bik0cx8rb26ro4ztomJUJSaNvkPyuh+ZAb+eZoScVrR2eXkvMKXePw==
X-Received: by 2002:a05:6a21:2709:b0:1a3:5c61:5ec2 with SMTP id rm9-20020a056a21270900b001a35c615ec2mr3227003pzb.16.1713441545866;
        Thu, 18 Apr 2024 04:59:05 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id ei16-20020a056a0080d000b006ed06c4074bsm1305512pfb.85.2024.04.18.04.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:59:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 17:28:32 +0530
Subject: [PATCH v3 4/9] PCI: endpoint: pci-epf-test: Refactor
 pci_epf_test_unbind() function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-rework-v3-4-222a5d1ed2e5@linaro.org>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
In-Reply-To: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ZVpMtASDroG5xgP9YNqj8iEe9ZOXPH9GZK0T5NEQXA0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIQryOLShZtHiBJVHhVR5JPQwr49V+Xp56OD+T
 vl56bpxcJ6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiEK8gAKCRBVnxHm/pHO
 9US0B/47gkQ24P0LmxNcc5MltwwAeuNL2lgqI7bH8WMSnhlr7Vw4ae+BckQ3Z7MFQ+Kre++QZ7u
 5meroKS7UvPgDJacyQU3BH8ddRshmENayoejpVw+6vP7cKYYKAtYef/b3empWQjgxxsQ7/+Ra7I
 iPmVtYC7oK1a5CGAZ8w6iSrMPbU6aqC5YDnt+8CDMJF9YJDM4jcS4wRTv3/YTFTyDlAHYS6EQsi
 2DGQFpacfDsQjK2mR9p5nNkoT0mxD6bxU21s5sLV7tje4Sk38pbd0u7JdT5VcZdvI8DpwvlAuHY
 kLV7CIVNQ4gYe6argJuCkxp1Z+txQCKiSO1x8jems6Szf/zb
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Move the pci_epc_clear_bar() and pci_epf_free_space() code to respective
helper functions. This allows reusing the helpers in future commits.

This also requires moving the pci_epf_test_unbind() definition below
pci_epf_test_bind() to avoid forward declaration of the above helpers.

No functional change.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 58 ++++++++++++++++++---------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 8175d4f2a0eb..2430384f9a89 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -686,25 +686,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			   msecs_to_jiffies(1));
 }
 
-static void pci_epf_test_unbind(struct pci_epf *epf)
-{
-	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-	struct pci_epc *epc = epf->epc;
-	int bar;
-
-	cancel_delayed_work(&epf_test->cmd_handler);
-	pci_epf_test_clean_dma_chan(epf_test);
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (!epf_test->reg[bar])
-			continue;
-
-		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
-				  &epf->bar[bar]);
-		pci_epf_free_space(epf, epf_test->reg[bar], bar,
-				   PRIMARY_INTERFACE);
-	}
-}
-
 static int pci_epf_test_set_bar(struct pci_epf *epf)
 {
 	int bar, ret;
@@ -731,6 +712,21 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_test_clear_bar(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epc *epc = epf->epc;
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!epf_test->reg[bar])
+			continue;
+
+		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+				  &epf->bar[bar]);
+	}
+}
+
 static int pci_epf_test_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -857,6 +853,20 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_test_free_space(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!epf_test->reg[bar])
+			continue;
+
+		pci_epf_free_space(epf, epf_test->reg[bar], bar,
+				   PRIMARY_INTERFACE);
+	}
+}
+
 static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
@@ -894,6 +904,16 @@ static int pci_epf_test_bind(struct pci_epf *epf)
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


