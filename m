Return-Path: <linux-pci+bounces-25385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D37A7E264
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB74A7A44EF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA01FF7C3;
	Mon,  7 Apr 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sY/Qfux4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00F1F91E3
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036774; cv=none; b=sw1TMSUK3Y7FIKQCPjOos2De/rWrqpx0DtphD3biDDODGUIhnTCcm0bvdRnyrNhROca1ybSHhOdmbJf445UIUyEroKvSxRuvm3HSI/PyP+HYg9arzMx87QYyNYCm1A/PHPYSKLXTIaO+ZUQ5DUm2N3WcxorhAjGN++trfg6YmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036774; c=relaxed/simple;
	bh=VMQRvj8CO60hVIlMMgdkTE1dtBACF+fNeO1bhBVnQsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ux2WhftdPuLdUFtvbXVABVwB+aHQdi+REgqxdjXMr3leb7Lfr0aZrcfnoXtmHeu24FSLSKdp4IglV5DPHZfwDMZCG/yHpuVaNo/xxd2WgXr+mEhytSfM6/Wr2XjEVSg4wICPkunjHTtrSRqR0TYuCjgwH+ihbJ6Xwk0aHUodL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sY/Qfux4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf257158fso31067525e9.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Apr 2025 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744036769; x=1744641569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=;
        b=sY/Qfux4gitYxD5bucZHE8bB/tfelW6IUCOG3P7D9JjYSzaY9fDYxELg8SExkl0M+6
         otmXZyt/vOe+peWCEZtiyCU9ws6wT4sdPK2xVOtggUlWx/F56zfgkQL9Ddf9Ck0x93bs
         tvGU+B4q8jKflaOvzGQWnB+8dzXFGaGbDKMWqhiQhvjlhid5sN1N+Tm/QsUxOBvuvhdl
         xSKY6Kd77Sog4KaMfoGuYgsFeVfQ/Y7dhJ05jVYo45O6pPppg89xyKtwko0n7MK4HF8X
         O4ZXK6huc0nk+WNqDq8NEHNXIPmOWp5H6l/Yj9q3Wrjokc0No9ZnY0lMJfKlMxtZkjQV
         RWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036769; x=1744641569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=;
        b=sibwIZSB6H+rymMRWeLNfVBGVrlLCNXkpa33cBvNHoMTjMeBoD4xVYylW8RwhhfWhm
         e12BWL0MrzZNzKgnO/1LYoptkDT1hqwrMylzievi76z4cyamy+cAepLMNQSxAD5uWFfv
         TPGr7MXjrS29UDJjMHjEfVyE5ODjsTg53pmg87AkIEArqYsj0mFRqWMlh158skrARgCS
         RzA0wz/svdGbwSb3z3lUNG2/or9UHrd5Qpo9C3BJQE/Dyn1jEbuVnflJtYMHM9CVVThZ
         53S2y0ys/b2NScnVJZ0vk75ExhWfafrqWVmJQy8nmbq+OLLNNywv3VnRzXCob0SgXFi4
         T6/w==
X-Forwarded-Encrypted: i=1; AJvYcCUS3xAEB1arx1C4y+foglZBa//r/L2hdrJDqKGURqOPs6j0TXWpSBVBp3gMtMnXqjZ6asWGOL0DGAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XOkTq0hFj85ap0H7fyWABV8Ru0rU3jt2SuANB3YY8ox2LKiB
	iHQWCfEaZQVy4BClnKHhzgT6Y63CW0kIHeamFkTPUg27ZONjDPmUO3PiVmcwcipyRAIRmbwreH5
	2
X-Gm-Gg: ASbGncsdwJn4LF3wkX1MDeUz4EGHIkmQz8+C+tHZW/mi49l8WKtMAsxsFnfOfiZe/oz
	rMfiykD1bTYfG1enT9Uj5sir/U3f3vA3wSFRn9oZf4qhllTOqwHxvkNp+WmaT6rU79/CoNZQ2ed
	Ky7pEUXwtWsWFfK+aZhuODWw8x5QN06+V+noDvMM/tyEnrMdqqQo013845mTnxA2vL0T4ldxoD1
	c5zlWf/iJEp/6wKpXwbU3rsB2iWT757cEVngjQX2wdXcEYDIC9POVjXjzQYwBBmC+6uImpHqG3K
	gGN1jCP7ikgtIYXNEU57Unzf/uoqtmrEZIn3DI3ROi08Wbj5Qe2XZC0a3Fg=
X-Google-Smtp-Source: AGHT+IEubbxZPgQUSRZzvvQhBmDtFalBkcWkhDKsJzJ20didIoJnFHLspvjPaPuLm6u+H9tSSj/f+Q==
X-Received: by 2002:a05:600c:1382:b0:43c:f8fc:f69a with SMTP id 5b1f17b1804b1-43ecf8231a8mr126309295e9.4.1744036769270;
        Mon, 07 Apr 2025 07:39:29 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm135003705e9.9.2025.04.07.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:39:28 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 07 Apr 2025 16:39:09 +0200
Subject: [PATCH v3 3/3] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pci-ep-size-alignment-v3-3-865878e68cc8@baylibre.com>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
In-Reply-To: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=VMQRvj8CO60hVIlMMgdkTE1dtBACF+fNeO1bhBVnQsU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8+Ocp5qrU6t7BkdRqC40BGTRhG7GQXtWTrTgD
 yIlZpB1YGOJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/PjnAAKCRDm/A8cN/La
 hWRHD/9g//XvxSZqH7CmO0Os/k5ApJ/k9nXjmH7ZssT55T/YPBza5Ck1OyaluYJjja7C9k1gitK
 Wjln7OTMRKwA0VzH1g1UDleQkt+jb1NBdtHlx8jupKsX8zyjnDaZmZwl7jjNpRxaFw+Wjq8MUg1
 TjpNZssf3Q4kG3iqg+sqziIgeUCk6Xi4WHBlqNolxkkqUSsSRf2KWk8tUBDA+EBPv+/psSmdfFC
 dBIjEtm7dsQoXpApCzIV1+myZh939mnlIPuh/trWJ3dIglJrl6XT5x9tBm6+Nq/cPRfLXHseEIP
 ncliq6apj8jXQMgKFD99eYT8ARDSrJoXhbXhHoHRMrZxmCCHCcsgFXcgovDYLsQWXQRwT7gO3mH
 wGW3a4D+6XUxWihlx8J7UJ2xthK8ZAstsSOdJUXwBkXui6lHUOr+euZFVK43ymcFqfxtqQT2hjR
 nOljtrKlt8MLWFPLORpH9PcYcdzp2lTTRgA3GBzMg9f4tB40N3x0oEUUXpRfWWMDLQFYzQ4J0ay
 hfC7zFLsq/XX6YZbAZwG30s+lL+dkmODzrVaBXC6o//nyL/U0ho7u26khB//KhdPuSPeohl/NZS
 YK2cDoltbNR4i94PvtU86XBOfMK+F2OsqAlsMja7w1OfMEgkZijdiePOiY9asNzKvoKZptEVXPc
 Anao+OnAuOocI/A==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
should not try to handle the size quirks for underlying BAR, whether it is
fixed size or alignment. This is already handled by pci_epf_alloc_space().

Also, when handling the alignment, this allocate more space than necessary.
For example, with a spad size of 1024B and a ctrl size of 308B, the space
necessary is 1332B. If the alignment is 1MB,
epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
been more than enough.

Drop the handling of the BAR size quirks and let
pci_epf_alloc_space() handle that. Just make sure the 32bits SPAD register
are aligned on 32bits.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8f59a5b9b7adec2c05eebae71c6a246bc5a8e88c..bc4a9c7c4338db6cc89fa47de89dc704d0a03806 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -413,11 +413,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
-	size_t align;
 	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
-	u64 size;
 	struct pci_epf *epf = ntb->epf;
 	struct device *dev = &epf->dev;
 	u32 spad_count;
@@ -427,31 +425,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 								epf->func_no,
 								epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	size = epc_features->bar[barno].fixed_size;
-	align = epc_features->align;
-
-	if ((!IS_ALIGNED(size, align)))
-		return -EINVAL;
-
 	spad_count = ntb->spad_count;
 
-	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
-	if (!align) {
-		ctrl_size = roundup_pow_of_two(ctrl_size);
-		spad_size = roundup_pow_of_two(spad_size);
-	} else {
-		ctrl_size = ALIGN(ctrl_size, align);
-		spad_size = ALIGN(spad_size, align);
-	}
-
-	if (!size)
-		size = ctrl_size + spad_size;
-	else if (size < ctrl_size + spad_size)
-		return -EINVAL;
-
-	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
+	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
+				   barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;

-- 
2.47.2


