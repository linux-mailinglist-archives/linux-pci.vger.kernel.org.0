Return-Path: <linux-pci+bounces-24944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBEDA74CC6
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4603AC7DD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4561D5AB2;
	Fri, 28 Mar 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CYaQssJG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893417BCE
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172252; cv=none; b=L3TB3TfPLyS84HICd1WGAPgIkmUsew9adQ54Ee6eXn0Y1OIVFcBerxp2IGYki8KEGNRNLJ7tIxLfhGK/TP3qzLZ9Xg5xppxW+dQGIvOksWL8v+tFyqL1rCnTBjavRwk0uxLNF9DS1Nrj3SHddWuRuMpGobY+OP40jtKTQI3FvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172252; c=relaxed/simple;
	bh=r69myt5CYJDUUxJ5eZ651vr//FxFOh0JfBQxRjDjfyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oyrHvckC8oDzAsNlw0wlKcZhvbD1KE8BTwC7/E5+g5vc63xzVhMfyRwtHRtdGNNVxEYTkCpeCFR1mVTSOViHdQ3c8Rf4UpjcoYH1guXEQFlFUZ6Gve1A1OodAuceJFf2rjgcn5GnkKn7EnJzqzfWWsj4EcPWJKigGXIPumfSwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CYaQssJG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39129fc51f8so1642298f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743172247; x=1743777047; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xY2G9dr/4ekvZx7BFTEs3c751w4Nf1CQJqhKZMVEU4o=;
        b=CYaQssJGH9CF9609ik2N3bZjYjbqLw3saKXH0l+GQO+7tQKQkYN4pl1NDaB2orzFpL
         Zd96daiHUw4OoaMd7Ybc6Cpj1MbQnTQ0QaaLbQ8MHxHn9jRjk/5zjlVuFTCg4bvrWrYS
         OQ/kBxfsWxKsCaA4OEUI8Bk5jy6ML5f+IB2kXC4iQr50qogMrUMoCwFz2JHgF7kKBiuB
         gS1T32mmw/IiOqLW81n1dW98b2ARcLbVv93E8W5lew/r3Au5d41rPof+lUQz2mmL4/jF
         wJStJz4TH6PZlTH1G69MbyUW5Jswt9AyaOWm5hxM4dJnMU4CWXFVyHcMGmkeJIOpfi9S
         gRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172247; x=1743777047;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY2G9dr/4ekvZx7BFTEs3c751w4Nf1CQJqhKZMVEU4o=;
        b=Bp5yARA66MMhGgr17gbX/NzXEG3gYhUaTFdSAkJQT20RxEVQlzq/cc6OCcsuV0tmYk
         xU+geQN/UU/k8qci4mXpi3i+KPM7CXXyyyIe0Wtgg5CC4kYtY7ShN/jj8JiD7BU71z9U
         LtFzG+LPu08KXJM9STHrkjQC+g7C6ruCyteMD7Rkez/bfHo6C0+P4R+dTXZgKsvlAanc
         53VJhkh5ebj9Ib2EH7oWBHZT1s5IWuaDKzYm37rcEqK31UHxb449WPNbBP7GDYC9wugK
         m1wTTLy0CNcm5BL1Gh2XmsSb6H1jHwadp/DG7GLJpKvaFyuW4rRKQfV48fYMdNZaBzB1
         sPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy77+zRV1tssCgSiME4tuy+5/sWVdQMK47SOVs1Tv0PqfS+WZTxha6omjPMK/gp9uxmu2yx0lLhtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XjZmiX9FHzr4Lb2TAIHgODiP3DYgl0kJimeKB3xLXmK+PLl0
	6YFWM1XgTII3H3nZMWglSTgNWyzv7tU4vC/2SmI4cInOpFp6A5YK8NYkzyE2HDI=
X-Gm-Gg: ASbGncuGd3G/aH+djNmhzID8OgVhAL1bkqHCdvY2Am3Nga8anRTPY2ThTwk8uJkSzrz
	7ofSWWR4VdMOmIW1E+brWcCgRTZZ5l7HzVVWWhowIx8ZqRM554L7o+hHrroKyXyT5s3+rf4w7/n
	LmSoBMfAYxCVFQMRusZsxHHxF3WLr9JBF6dV5d4Riul09Uo8V2kmxVxL7JYksaoWB/Frq39iDwz
	TYRombCFrhy87nFGu+A8Iu1B9dVfT4qKZnxWXpPDogzbErYcSzTcfdbFe2dDQkGKJK81Ae8j/fk
	oxmDalXcIdWyDvXPHIpdkA2br29+ULciwEWmmgnlLlFRKqnAzCB6g4dfPj4=
X-Google-Smtp-Source: AGHT+IEqlAqw/EIsqm1BgyscIBxGUOeIxfC2lXTrnQ19OhlcGKYtCY+38uMpnMJk3wcdZrYVzV+TOA==
X-Received: by 2002:a5d:584c:0:b0:398:9e96:e798 with SMTP id ffacd0b85a97d-39ad17415a2mr7314079f8f.13.1743172246976;
        Fri, 28 Mar 2025 07:30:46 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:70c0:edf6:6897:a3f8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c0b79e0dcsm2789859f8f.64.2025.03.28.07.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:30:46 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 28 Mar 2025 15:30:44 +0100
Subject: [PATCH] PCI: rcar-gen4: set ep BAR4 fixed size
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-rcar-gen4-bar4-v1-1-10bb6ce9ee7f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJOy5mcC/x3MPQqAMAxA4auUzAbsjyheRRxqm2qWKimIIL27x
 fEb3nuhkDAVmNULQjcXPnOD7hSEw+edkGMzmN4MvTUTSvCCO2WHmxeHMYSorRsT2QladAklfv7
 hstb6AfDmTqdgAAAA
X-Change-ID: 20250328-rcar-gen4-bar4-dccd1347fe38
To: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=r69myt5CYJDUUxJ5eZ651vr//FxFOh0JfBQxRjDjfyk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn5rKU93EsfEvQqRKfYw9fYTj3oD6m4KNpZ84sz
 uxMinKIJd2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ+aylAAKCRDm/A8cN/La
 hcPzEACgdAwbHl3qVRBYfJhEGKIBUUVbe3SP6v/HrFIig9GMe+v6Vh5MwjgOI8sSrJNPputEyDV
 LPk+aYT18SfUg0BK3Ji8plS6dtfAAKYqAF2NP7JQrkhFvLf15Wnp2gNSrI0cAvZTNAvc7fTSh2G
 G/FEe0tl80zU7/1p+jtzoN6RJjAI76zroHqREmJlWkELpfluQoDaKIjL56N+kbrCh3DyqqDBfQb
 NCZXUBtoRmw8AsBJquKGDdj8a9NgeGLmeFdxOuf4w2neq+6XEuxaYs/MtSaj+d2Boij8Ppsf91Y
 m/9fOePAM1dvizw3PcrOzzSoKu/oC78vptAYlehYHX6N7x94vl/+iBs4nRyyKUwXR9fgZeZ55M/
 JUuyAmaOQQ8Qr0ef0W1opD14erhPETY9o/9Z9s9wZ/zmb1y7uFVuV9l652kPjKY5eWxzoxrhkNm
 owPbGUdNWeSPockslN6cRjZUmDcJZNGJvLOJtEIGh7Fz+gbhJ6vZYT0U6lqcj1/jS961f9qaT78
 9FC8tNf+f3+zKbn7FUYlIukFgKwYjADEMUsc89sJbqsXqZKFWJqMoWQU0KO2MrMs2CyrTBYzI8l
 L4dmhkVNNTO/VI41+28MryVmwHl7rJbniok+Ucvthn1L1J2ig8sBGFt3K2DuNHm1yh1cG8QQIAI
 upkny4XrrLDWubw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On rcar-gen4, the ep BAR4 has a fixed size of 256B.
Document this constraint in the epc features of the platform.

Fixes: e311b3834dfa ("PCI: rcar-gen4: Add endpoint mode support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
This was tested on rcar-gen4 r8a779f0-spider device.
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fc872dd35029c083da58144dce23cd1ce80f9374..02638ec442e7012d61dfad70016077d9becf56a6 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -403,6 +403,7 @@ static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
 	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
 	.bar[BAR_5] = { .type = BAR_RESERVED, },
 	.align = SZ_1M,
 };

---
base-commit: dea140198b846f7432d78566b7b0b83979c72c2b
change-id: 20250328-rcar-gen4-bar4-dccd1347fe38

Best regards,
-- 
Jerome


