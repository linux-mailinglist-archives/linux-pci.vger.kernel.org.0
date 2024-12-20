Return-Path: <linux-pci+bounces-18924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DFC9F9CD9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 23:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCC316BB46
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E721C19F;
	Fri, 20 Dec 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MP0xO4/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D631A3BAD
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734735156; cv=none; b=OKhcJercqfQfliQegOYP8dlaA66UzbaoSiWZxIR+Z8VuoPruDZFCuGqDR8kipzmg4T76gnnWZ2OIE62Pbc4hbN/v3A84pgJsVq6boaU09GOrVHakv1IpgQKM8VU+A3MzEwhwmVKIuAp0ZRf4KSNxUBUJlSH5mRljvTINR8waSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734735156; c=relaxed/simple;
	bh=1O3G10NSviyUvJVc96eWG1GUOWXF9zCjmjnZWiR5uE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nOKBM5s+EaiJH+bQUmyY7QA99HthDvJTDrULQLV5Sqk7QZyhN3aSFcBRUfxhu9wOzHl6ZL+SPOEF8T/4K+V//Zt1DbyZf+6gX55ecCWt5eBUmgR8u2Pd9Wrf9n1wkA17sM9ty75XrVGBVcG+R/JehEJCQ2nR4rPD9cIHzTsMhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MP0xO4/I; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216401de828so22572105ad.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734735154; x=1735339954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPBNquw9bDve05ZXRyZElIGNn95SHQ0uPV8Ww/9iWX8=;
        b=MP0xO4/Ia4JTeJWNC89wy09nR/9F7HmPhnOKXfuuivM+sK+/sV9NljtDPNfVuuUvpn
         Mwc4BTbMHZyb8dJlXX+Tl3BZFaCNWtHn9ofLXYLL2BtzBWoo7J0c/PTTFhBLdii31UkJ
         DbTq+9skFwROM7osVcoFRIh/2MaxJtgd2zELw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734735154; x=1735339954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPBNquw9bDve05ZXRyZElIGNn95SHQ0uPV8Ww/9iWX8=;
        b=OdbRu+HCHEbHZxT142tQfRBKfXU2vU3KEHnEyPi+mgAIWCy8RNy7mNWKP5L5qh6wyh
         zuASrVY+a3SVnqzdMYU3lTIZter61qUo1259yq5O2QAQvcP3Q8shXca1jxZzMda4UcYj
         +TdAVaqbLkr33dHumPdi0JiQVvZubIl+eg9wmQ3twN0hRbyMhVBVqEFsCmu37PisQ4OC
         8cgk8k9z4GoX4hQigN1fprsdlXMwl4L1SPSEnM2uP0FOgPdAY0aLIkRUwFESArjuDvfv
         Xgf4O2hp+ZLmNoUbgkfBu9UqRlllljWz3XaTz8zX7KQyJM6drXdrlOUqhoIRFeDyS/1G
         0f4A==
X-Forwarded-Encrypted: i=1; AJvYcCVS8HonLN/QC3i7/n05Z0BPAXT1UF4wn0bzXqAF7ItfIn9+oeJYzzkErffC9tsWM7LY7nKym0IpEVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5Mt2ITB1pjC7vqEHOhsjuVEaffWDJDeMMk2GBcQ4qmgqxRpF
	PXjJ9BA/IVfUf3SccHENX2xPUkRSS8vjRxQZm/u/DSzgbbWQqX8YAzI6OBGcLQ==
X-Gm-Gg: ASbGncuAEL4HRhVyylzE3ChxFYMEb8FH0fvLz83aEF/B3skajV/r7L3vyxKbM/wpGWH
	63/C4+0yu1H9mbsL3q6Rhdp67poR5+7aLRQc1ebH5ifbpTNNwH22CqhUiq6fw65rF+b3tv9zb9m
	B5CCv7Ra5wJlWhiDu8zYuegGAySSON5cqCB6wyoV3ssfZlwqogXwEoKOQRjD5tbOg0UHoN0tZQI
	sOd6yQOU2pzs9DuvLLm2wIan/tsXTMaJpLByME7W9x2xhRa52awQjasS2/efIvESYGThXU67HER
X-Google-Smtp-Source: AGHT+IGAQkf1R3nFR0oaCc4mviuMrzg5Lh74UTX9WYEEnS7yyvUzZLFXHXFR6wAwBwTUIv3/nUaYnA==
X-Received: by 2002:a17:903:22c5:b0:215:7faa:ece2 with SMTP id d9443c01a7336-219e6f145a8mr61141965ad.35.1734735154069;
        Fri, 20 Dec 2024 14:52:34 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ac44:423a:e4fb:5757])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964b54sm34177065ad.1.2024.12.20.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 14:52:33 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: mediatek-gen3: Enable async probe by default
Date: Fri, 20 Dec 2024 14:52:05 -0800
Message-ID: <20241220145205.1.Ibf2563896c3b1fc133bb46d3fc96ad0041763922@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Like other PCIe drivers, the mediatek-gen3 driver has a fairly slow
probe. Turn on async probe since there's no reason to block the rest
of the system.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index be52e3a123ab..49512786d5e4 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1301,6 +1301,7 @@ static struct platform_driver mtk_pcie_driver = {
 		.name = "mtk-pcie-gen3",
 		.of_match_table = mtk_pcie_of_match,
 		.pm = &mtk_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.47.1.613.gc27f4b7a9f-goog


