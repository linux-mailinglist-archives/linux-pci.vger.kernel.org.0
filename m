Return-Path: <linux-pci+bounces-31689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDECAFCE35
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B105D164332
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED02DC33F;
	Tue,  8 Jul 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uG6qN1IC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65601E521B
	for <linux-pci@vger.kernel.org>; Tue,  8 Jul 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986215; cv=none; b=uumVWsQXZv0BZyZBDfkkhNK4HqHI9M8GBB5ULJRnfjD5gufZsVDHWScxlVk0nDgCcmPbNpVCQhKWNQzatBlrTfUTS+oR+7Jsh4ENv4oWjEV6OL0m5+jkPCTHaW9NxVZX+Uy8Imfz2m9mc3Fz5iXTIcHBGW954jXDMQqxgKspv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986215; c=relaxed/simple;
	bh=HEgvTY7DvqUTASXbAkoz2Cq2W+UACAG7D0XiharOkiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LfvI57Un3dDPgnN3Scm60NLGA1Q9pYxBnUeCySS38WqE7g6vXuxuRrGHJBFFQfxO2q+4Klqo3Ji5aNocIvQI6lmxK6hy9vgPuplgGVUc3BQ58oMkSf5gP43ILG5JYjmZ8hf6RX90HCPE3H0M4SCLuiBw8LYEDDGwBMMcYAi1Ixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uG6qN1IC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453634d8609so30793855e9.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2025 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751986211; x=1752591011; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+mcJ7ZL40yfdI/6L1U2sq8kmJCRggUCq7uPF858vik=;
        b=uG6qN1ICF86hD6jJf/IrYo8dfj0Xt4vgNY58oRn4PewJeOXeatbjqdV7DnwUG1mxYU
         gzC5LHXiAIaLVa8BVMNkvcY0vgxlSdEFOcbdAWlnaik44fe0nb28Tvy6KGsm4I+Gic6E
         xRWspBvLZJH8+LYvJsgtlxzf1OOlwQHm5U9BqOwqZN3p5fENhvLrW1yRh3y4ilGU7rd4
         Akr9z4CtMra9c98BRGY4wA2hHH26boKR/ZCbEgxs60d02Qf4iEc71RWjuHmjX3E50Y/g
         wpGqsNvQhaJOfxkik/dDniIdpGjICFALBnudhynF8xdTQtkcE2abBqEkqx5QSnYqYXym
         rgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986211; x=1752591011;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+mcJ7ZL40yfdI/6L1U2sq8kmJCRggUCq7uPF858vik=;
        b=l9CWJ2dveBTRrMf9vzk19T3vMIpgGAU7LIdqHgqP0F9Z81LMPhNH6y3e+u0IQ4QA2e
         W/gB+kW4S+F9Tc50x3PxWloKwQQlHVt1GLT753vVL9hiU3nuaqjba44BD9Nzj6IQzFgz
         a0X5OOruTt1UrNttpkRI7OhH0F/VOQ/ZCwRrwRmXiqBInwzefaUFu1YVybPjtndHDqIJ
         AkMSr4dXOcm7UKXoNFIzpO2QdIZNDb03YKtAHYcPipXbJrPlr2I4T8F1Nk+EDV1g+7CM
         Kt23eByxO1GzaU2pr+OoT+LNxiLOreOzwZmyn1xS3nq+8JY9cnB1h2BvsWskbGQkV57k
         256A==
X-Forwarded-Encrypted: i=1; AJvYcCX62NbwTJa9EJkW7GsyAFxxVy4FPaVHSnp35ELSGmobxnZc0ELXNwPqCkAJunkxrs9QITTIGPwF+yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8ndZn7pPuz5Zl3wfbZQjBFScfnZQaATd1ks0akQf9TBGARat
	UfLcSnGpeybrQa/RU1VBMaHs6X2eg4YfJg9yC4xPIRdjouIxD1Jx9sSP1lD4Ezi4xlA3dCfQBRs
	6qx6K
X-Gm-Gg: ASbGnctfWJWJRx+wNypGNMQLbf8MDIHn93nDDYmODVtADyawQCMNK8Lo8AnNGCIRKcp
	63qcp72yTNGcWDgLtXG9REYIXMv5TQqleDe4PtnqiSAIqyJ0jBdXEi6L9vyGmwcjx/lDnCu2f/Q
	F/z+lOeRIOFdazec+AnJjlwPwZVdRbrPl1mwaHfNOk/DPWsYnziHJuxZ5kDLkzwhi+wKk1cDRcO
	HAHMI6bxlUu4fkG0aabvmhX1ubt2Md2Nry+g9lAvm+7KsFRJq6j3UGP7yMWpnDOJOPRaYRxS8+P
	Oezb8FsIFxSR4e5DwaebE+jJ20UN7TnOVL0tPR01BDaSqzp+ehaWCnA8MLpTeFw+8s96NFVZZ03
	L
X-Google-Smtp-Source: AGHT+IH2G2zx5csQczqgTBlBit9l6rKgdpM4AL2R7/oW/cCxn22xdVAIxyhu7QXZ0RNJGTHll7v0Sw==
X-Received: by 2002:a05:600c:8b0d:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-454cd5234b7mr32681735e9.23.1751986211084;
        Tue, 08 Jul 2025 07:50:11 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dfdf:dfe3:8269:12e7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b47030cdf5sm12988879f8f.1.2025.07.08.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:50:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 08 Jul 2025 16:49:57 +0200
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: fix MW2 configfs id
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABQwbWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3bK8kiTd3HLdtMyK0gLdpGRjg0TjVCNLAzNDJaCegqJUoATYvOj
 Y2loA1x0n8F8AAAA=
X-Change-ID: 20250708-vntb-mw-fixup-bc30a3e29061
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=HEgvTY7DvqUTASXbAkoz2Cq2W+UACAG7D0XiharOkiI=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBobTAdm1+n8PQLlMWBQtM3sujQ9VlXuPytqjO/b
 RX4fjO7geCJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaG0wHQAKCRDm/A8cN/La
 hbW9EACZxPPbx9A9N7wzBBwK+X69FdGNxhFWZa4r0v2iig7LecShid9JdCCgxxpoMTiJ4Y7h/WD
 iepvHs56AKjPYLS3TQ1QSc0bhbHJco0KzUCQn+zJq153Oz9QNAYjSAYTXDblnUxvBHUE2TIT0nP
 UKcKt1RKzVpbMNSoNEuONomEejyFT35evSOKpyVwRiBENRx/IJipuJu3unfu6AzvVPsTRFsVaL0
 Lmc8lU+DFtm9eeA91jTOsStJBhdrz6ROjci+1WTlq6zdhJox60lw0FndiXEGAEI59CYsqSttzCL
 V7e8bZcPiJ4jeqt/FhpTO9dLn6gN42Xs6u/sOBxIKp1YHhME+zTphrFXptfSJUl3qa3PJRcW0Id
 Rz/y6L+YqCuAj3I12VWuJPloVzQZ30Iv/nQxk+zMICLF5ktrtpKQt7w7DPRbFnqR7NYF4xlIeox
 qFgBgTF5DPamsFhI2Rb0tYLY8LnmyYK6NYOri3ZUnibpXG6D0Q7s9rteRkbyT7ZyNZWZpQSN4nV
 3EnS5022AvlTmNfq3FqWqmGJphqMc+udewNL1w7PZbhlCpqF+zzQ4zE2og0wHhz+HNRyaNGDC3t
 IWg3bFShM8KgULCpQXVoiodbPpMix9DlvXjZiRvCme3UokWoxG1wc3WmNDxkNv909JVLYjrhDEi
 oG1fcYX8ebohO8g==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The id associated with MW2 configfs entry is wrong.
Trying to use MW2 will overwrite the existing BAR setup associated with
MW1.

Just put the correct id for MW2 to fix the situation

Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 41b297b16574558e7ab99fb047204ac29f6f3391..ac83a6dc6116be190f955adc46a30d065d3724fd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -993,8 +993,8 @@ EPF_NTB_BAR_R(db_bar, BAR_DB)
 EPF_NTB_BAR_W(db_bar, BAR_DB)
 EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
 EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
-EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
-EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
+EPF_NTB_BAR_R(mw2_bar, BAR_MW2)
+EPF_NTB_BAR_W(mw2_bar, BAR_MW2)
 EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)

---
base-commit: 38be2ac97d2df0c248b57e19b9a35b30d1388852
change-id: 20250708-vntb-mw-fixup-bc30a3e29061

Best regards,
-- 
Jerome


