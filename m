Return-Path: <linux-pci+bounces-27185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C78AA9AE0
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26697189FEB6
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C326C3B0;
	Mon,  5 May 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I411hL8P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7526B942
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466929; cv=none; b=WAkD76ufiJYZhnfntgtZZi3sHxTp2t48tgn4KlS2OQ3bGIBJsdOgttEGZ7KPzf8orPZWskVqE3xFWwfW7dQ51958kbrX+qhwGSueimSguCjfpxeU0KAhtD4ChsfUsg8H5jJBSonJU2bJNZTJndpe9WdOveXrdxgPbEJGtaqZt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466929; c=relaxed/simple;
	bh=fAH11pHsRrYKcysroQjLM8Q9UwAmjfM3znAZKnmfIi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLZtRYbIEMlfa/DWkEuEDxehvFVgZXSaMKb0WHfTHTSfUpDeqClvM4caJVjrn69/LhxSo9AJMHM/SFoyRIBfzDqd1kahACVneg28TC+km8Av6mn//v5T7f6y/qtfFMSSkjK0iBrDypd2Aq01oWn29WWKrU4QAYqHnuaUmGK24Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I411hL8P; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so3698325f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746466926; x=1747071726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RjSK5+oOhqZKQ0oK0twEFsYWTKP2YoDTHH/eJYqDLQ=;
        b=I411hL8P9bibRZoMbu52yEjnvCF6kAmIchHnNoTP6/TqNQWeQEKlw5UY5RW1j9I/UG
         Pk0wABnp2ASWeB7xc/qRADcxa1G98nylvxf9VEeb1yspaucfBWX9UDlJU3C5dKcpKV2N
         NYZUDcbt+v6cj1hmUsZvHymXaMPopcVvvbktEDXJ/zIkhsKfy+LFxIDOM6SpfJksNREO
         7RBFZ/fLsDSkGC1N4dZodQp9CLkI0mrtXkQe7eXCgyasWbUZtU2cYcT3q6azFF2loG3G
         E2KGAEJjxy7v5TB1xNyH4T2QUey4HiOzVgwfdx3WyoeQUvtY6p6MNXanKZFuhXjO9AAc
         ObFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466926; x=1747071726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RjSK5+oOhqZKQ0oK0twEFsYWTKP2YoDTHH/eJYqDLQ=;
        b=sdskFqzOSzUbXKq8+3N0XzZqbGO/GTfVVf5oeMUhKsaaU6S7zmuk7U++tv8+xj2Crm
         8oFA45FbrYmNS03dkLHEJa51cjjEDdtxVqikWmyVqvt9Ct5LwcBprLQNnrEjxP53XjBF
         H0Oz8pi3xJkYyg6m+E4byAEruapX5dkla6rcfAiOMepWxrUMR5X5n2DUue6p2QfaphK7
         qY7Oj5mYGO4IioBDnof7sCfECki+iWt6hBz3Ks3h3RX1MduOmecljnhwY/BH+FcHjsaw
         3yO+zdifHoX1bmJ3k4ucRlE/vqiVdLFnxbVK8Yu2Dy2/hOY4yotJ1kXGNOTa9cmKnlGZ
         4RMA==
X-Forwarded-Encrypted: i=1; AJvYcCVD1wHFU4dbID2R/82cCXsl14pN313ymAOCstaRYGAfXh4bZzdvaLmnQ6aFUDnpsGdDUbF9C19Oklc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywup557upOQDh0UDRIM+1JGGGzPP40EyYMy5A380vg2anHLXxKv
	1lw+ODgIz3BAj6gm0LkvQWjyadDYwQM8O4KjodYoZ6YNjtXGnnWA14UoXtTJk4V7Vmc17m4d2oI
	K
X-Gm-Gg: ASbGncsRneI3ihrT9GqMuqBP0gHSOrP7Gr087jh/NhPhB+1Jxp1yJd7CWNrjD/qjzmc
	omMeefjDiiepTTebRFjVhpD1f4LBULBCQCzx70TiErBg/UusOXAqOBWfNbZ7CKX3VGxQl5nVzBK
	miVLldaFhUj8vSoBubMD4Wro1Z/D7WgV5JkG7mULBytrUWAo1nxxVz3e8hE9G9ty1DOxFhJgtU7
	gUXLxtsLdNpN6hDBFLL7y3Fd+0wXc7buAVRfC35LrZ9RtFs40xQATkeWxamFcnuDkwjUGrKVQkn
	BdGXTY5UlPYxz4wCBBsapS9WLq6hCU7Bh0M2ECod387detQy+DHTGw==
X-Google-Smtp-Source: AGHT+IGAYa+if0CukQnbgX4pEVrN5Xsiai21uC7+G5ERCrGhLg5b+LFY/FpMStNNjBLuuOjsvZ9R8Q==
X-Received: by 2002:a05:6000:420e:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-3a09fd7c855mr6686785f8f.33.1746466926206;
        Mon, 05 May 2025 10:42:06 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dc81:e7a:3a49:7a3b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm11345829f8f.69.2025.05.05.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:42:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 05 May 2025 19:41:47 +0200
Subject: [PATCH 1/4] PCI: endpoint: pci-epf-vntb: return an error code on
 bar init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-vntb-bar-mapping-v1-1-0e0d12b2fa71@baylibre.com>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=fAH11pHsRrYKcysroQjLM8Q9UwAmjfM3znAZKnmfIi8=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoGPhoKlIvsdmRmR9d6/kM75+1NA+V25FqgfZ4A
 LjBSUdeufeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaBj4aAAKCRDm/A8cN/La
 hWvCEACJQ3glDx7dWhKRBd+uiK+/HZdut2ULVasmSE/3OzCr5HaDdpm5oFp1p/SPpmW/13cgqIR
 ju1V858zABuU9lVRidP/F6No+RTJfhh2lRQRLAFJ7y796sHXI96Wnky6L+g3nloKQQ557hwSITC
 nIfr8pW2RffnHuorPF4sr0W7gzKLAIEOJaxeGn2EAYFThw0vJmjLnHcAzpKlu2gNqRUsV6UokrB
 QMWj+UrP9UNAQ9fryuVyxCOW+JtIbjmTNno/1bjwWPEs3tG+MswgbT7UCFBl5KBNtmD3QWUyt4x
 XEniJy1KhdE/8AvcBfctFTMM8dZpY6P1cTQAukOThQbd3Pxrd9eq/jG5t1tP2vMxF3BFETc5mt1
 PA349TzY8INQGg2vQJvRE7nfneZSM/++WL/z5Hf9oa6fLO1ztBIvuJghyfNjYXKYJDD+VMMPc20
 nwan4o5n+1O7DR+qMMwaaI5JDLFOnUQ/NegzCtUR6t0kgXd4xOiI+kBScwwMmeulsE+pX7jVxMN
 s1a4kUeYqC3unYWS5WdD9Otwqw2abNqWYhiAS0o9s+O0MT2mPLJ1ndYYuOv/Ytjz05t+5EEi84T
 0ZnPAcYq11sHoEg1ECjqdj4ayc4axe8FqKUyKI3eUSH2r65VOleE2GX3Tij5tF7j3ANz1GUtLL6
 VfwZygZfa1KIWNg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

According the function documentation of epf_ntb_init_epc_bar(),
the function should return an error code on error. However, it
returns -1 when no BAR is available.

Return -EINVAL instead.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index e4da3fdb000723e3adad01f0ddf230ecc0e572a7..35fa0a21fc91100a5539bff775e7ebc25e1fb9c1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -680,7 +680,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
-			return barno;
+			return -EINVAL;
 		}
 		ntb->epf_ntb_bar[bar] = barno;
 	}

-- 
2.47.2


