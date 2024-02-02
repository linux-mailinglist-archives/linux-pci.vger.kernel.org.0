Return-Path: <linux-pci+bounces-2977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B9584688E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 07:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6DD2894DB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 06:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDEC17755;
	Fri,  2 Feb 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgsfUMmw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63C1774A
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856869; cv=none; b=lMrRhCbXBNOTCcNUlu8kjUkhvMvTaQ1AuRrUlP7DpUbsp5DPPWyhCAWrwNb200AAScaeuZxHwn4v70dM1RjISVH1KyhFR1sZzgoWzkmelOaVxSmGt5tJWXZPo78eGK9M0EHbIYvxpZOFrEpghqHhw07EK98K40yxt7dHapccGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856869; c=relaxed/simple;
	bh=/Z6Gfxk6zv/UTEFpsRc8yXJK7I0IYouR/YQWcbNG2D8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RTK/H4Us5EZwwQofv71FOks0BRpj6CpCl0/+GdxKtypHdFBIQH6JJKD0lXSU0aZ5XhaMGlNYUFcbCKCsx6L7fM/o4xGAspR4QKny/zmu9C/nsFZ6IwfTFh1XvqCh3wbrCSfZ8dT22/tdRrH2bcT+51Juor+zF5H8GBTNQM5G244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rgsfUMmw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-295ff33ae32so1438955a91.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 22:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706856865; x=1707461665; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXc5N7jLjVVYRrxW0fl54GMYDq7C5q264hyj4PfnayY=;
        b=rgsfUMmwYZVicPNPswp6oU5K8lfpxSFasUDIHkTMzNo2Bzmf8XmnclQdRgL5XN28dX
         QkGXmnNOmTRgn9EZiyasex1YnR3ZrwRqPOPq29VwEQ7c1iQGtKXfthraI3w0sQaZxxRg
         tA8S6a4UzAeqqkTUoS45A41z7lulQtI1t9olXe4j37eveaO93RL9geObS6OPphpsp5br
         gFMkudvxy3Kh0ppL/MitgYdG1KwQ3OzbcA3HR3ZumrIxc5lTr8qqXGeU+OQdy7fGpO8m
         WUV1lLsFIayjbCu7W39YwzmVDpQOyYkcyxUfsQQPI5aLnDpBznttQtH9qGnJBXuVEWQr
         ggmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856865; x=1707461665;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXc5N7jLjVVYRrxW0fl54GMYDq7C5q264hyj4PfnayY=;
        b=r/ZzBn0rORXAwU27BzQbq96pkkQKDd9VYFYTFg4FTMpURrZLXRz/E/NfY9goM2usfv
         CPH6MHA5EhDAPu6sSTmTe51VuHGNEo7b5sG8O4ZhjwokYbnl9YuglBjMMeJ4LXjoDwsr
         fN00sS9RPpM0a6eOsW+vdxbcWnH344rdMpq5f1EKs4g1q/wHZANjmDTtQAf4B3pFXkAI
         DVgedL0l/3CU7tbSVzfeq38i64j1x18JYxZQOuCdjR+I1alXpfbCTrDiT+2vQDCOwCrq
         gPND2VITDjvIk73/zO8/J2ogRlUiEqrKgUVHMcBW2W+sjHShpWq2XSUj2dzt1DITmJlm
         6fqw==
X-Gm-Message-State: AOJu0Yzfh1g/6TfnVSl+J5H6HBL6k+jbwLqN+ex3tN3ZCi12ouD+a2Sj
	JIKQkHMCLd9N08lCWnRyINfyoQajSxrIAehxQggl7Z3B19TsMaSWap4VOKXvsQ==
X-Google-Smtp-Source: AGHT+IGJktvTyc45ZlwjQWsv2W7NeP0PXBRa5IyqGb+84B0iVw3F6Sq+NfyvbRv8TPuwoDLtx+M8EQ==
X-Received: by 2002:a17:90a:db02:b0:296:3edf:d48a with SMTP id g2-20020a17090adb0200b002963edfd48amr852874pjv.3.1706856865524;
        Thu, 01 Feb 2024 22:54:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQFGzgZGcTnk1Hu0xZ9QsoxFHwRKZbfQovetoT/jCtHCn0v8630g8MlZTKoi3Lrmeg9vL1owgtc7ygpWvhGao6TNdIgrqYBdEqTPf4sCWWgMdihtiZawlfOutVliShLICbA5bvgBzZpU+btHmC/DujBKYUKWa9/e6fQvcWmdH1OziIDxTXBuViGa91yPOrgpuaoOXFht57Hbs+Qdi1frf2M5fFRO34pnIhQTOhhp6yrXhG6hFayDStZMjlw1O5m1+Zj7aoo5+jJfyp7+TKdMhetXrSN/ADmr/OSfENnSLnM2qL9XliCkdkhVw7fBwmQAuEM2PiJyEQwmfiCvrT+GPszKH6B1YsGF/RV9cZ1MLRY9kCMHoxFO6GcV2FINuPdbW2IH5RUUq9g7Zq4YQ9dddnbHCDzO+iRlqgdPJ/JEiQEvBF4F68jMLY7w==
Received: from [127.0.1.1] ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b00295f900f38fsm984763pju.11.2024.02.01.22.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:54:25 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Enable D3 support for Qualcomm bridges
Date: Fri, 02 Feb 2024 12:24:16 +0530
Message-Id: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiRvGUC/22NwQ6CMBBEf4Xs2ZptUSuc/A/DoYUFNlGKW0M0p
 P9uxavHN5N5s0IkYYpQFysILRw5TBn0roB2dNNAirvMYNAcUJdazS2TerThrrxwl3t/OqNxlbX
 oSsizWajn16a8NplHjs8g7+1h0d/0JzP4R7ZohaonspX1vT+ivdx4chL2QQZoUkofsq8LgrEAA
 AA=
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, quic_krichai@quicinc.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=/Z6Gfxk6zv/UTEFpsRc8yXJK7I0IYouR/YQWcbNG2D8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlvJGb0tBz1I/mHFmY8tdYtl2wYfhikEj3G+83z
 07lIROBk7SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbyRmwAKCRBVnxHm/pHO
 9X4lCACBuF53Tik6iD9RvygIXPGClNBC7CQbSrc3HtQ5YHe7wnGGJGOaRV154AiytpamAKuL4Sc
 wstH1Q0mHhaZE96CrvOT9Dhw6W/D1lZCg5B4KknxhHpzP8kolOw6FMatzzY4QFxBnLEWYlaNdXr
 Qqyl5S0d06pfAvVNtnrB6WQjEtGD7dnLltdBoVah2fcVdlkfXgMsbm1khVNzPGlS7fBxRcupc6F
 mbqVkLsqSjU//Y/KCfsfu24NLm2Xd2Gzuo/TRdlc+by8vjht32nQ0IlED+4YxzkdDKsqESmWoWl
 akVYfcvS6y4e5l/8YyRyjZW7QpH12SskBbcsBndK8uJV4d5e
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This series enables D3 support for PCI bridges found in Qcom SoCs. Currently,
PCI core will enable D3 support for PCI bridges only when the following
conditions are met:

1. Platform is ACPI based
2. Thunderbolt controller is used
3. pcie_port_pm=force passed in cmdline

While options 1 and 2 do not apply to Qcom SoCs, option 3 will make the life
harder for distro maintainers. Due to this, runtime PM is also not getting
enabled for the bridges.

Ideally, D3 support should be enabled by default for the recent PCI bridges,
but we do not have a sane way to detect them. So this series adds a new flag
"bridge_d3_capable" to "struct pci_dev" which could be set by the bridge drivers
for capable devices. This will allow the PCI core to enable D3 support for the
bridges during enumeration.

In the Qcom controller driver, this flag is only set for recent bridges with PID
(0x0110).

Testing
=======

This series is tested on SM8450 based development board.

- Mani

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

---
Manivannan Sadhasivam (2):
      PCI: Add a flag to enable D3 support for PCI bridges
      PCI: qcom: Enable D3 support for the recent PCI bridges

 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 drivers/pci/pci.c                      | 3 +++
 include/linux/pci.h                    | 1 +
 3 files changed, 10 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-pcie-qcom-bridge-b6802a9770a3

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


