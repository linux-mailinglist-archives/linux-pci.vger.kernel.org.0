Return-Path: <linux-pci+bounces-3324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D285058B
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 18:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9281C240E5
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF0A5CDF3;
	Sat, 10 Feb 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWyThwhk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D539ACA
	for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585016; cv=none; b=iE7sP1gmZP9sw1/i3xVMNl80bb6zK5VIf6S0HNVY4AEwydr1CkmDNzyei0nCxjTVZBhrIogqJ4Mekzi4tOB6jLod254q9enymGF3dlQqzMIG74b8piePodCS0dYjwEDQh/NQ+kGsM36ZvgdZo/SDBIL3fEV2sZh5iKWn4QZi+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585016; c=relaxed/simple;
	bh=BaU/bP7v133m08+SRbtNQA0dEb7SZt1w/Yj0I4z/vi8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RmLCrYKYesxf5RWuKfaANOfHppz4IqXWCyDd/4ZkWhwfKAc5qjD/uc49kGMKeGRBitYltiqg3Nn9B7N/OG+B6zuyEBHY4PeL+dmU3+aPpRVmX/iH4e/DZdificWj+l+CLqSUbgphX8CPkw2p/Zg8Ug4/bZxk8/ivmEsIKd53SPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWyThwhk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3916c1f9b0so264054666b.1
        for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585012; x=1708189812; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub3t1C16XKKLVPOgvYEAt5qRjsjAUqaoq3TtQjsnA8Y=;
        b=DWyThwhk9S/AeiJp2XcUqp3ugX3TBOoCLUA1Fwkc6vHGSwyZspWiSRAoa1RYiMkxo1
         nGQxO+TRX+KMKfOlHv3ISePZkGV+1fPs4MTRAuSqiueM0ZLJlVPgEGOGp3SSZ2RM2p+g
         DxSQzh937uwWi51qctypRgX0CGgZDUw0vUlcSBlU23NwG5KyfEyBmNi5mJL5zEOfvVqN
         FudlJIJEUglFzXOOt0VuQjm6PG7dUtZ55kxhiDoL9s+s6N/QWSVoAW6bNMrdGP5EQOae
         YSvUS9evpFU88sMRX2P9hpxbyJJbaUAfB/y2PSbuj9LlEcdOpOYW8VcGASuVhwHbb9EO
         P7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585012; x=1708189812;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub3t1C16XKKLVPOgvYEAt5qRjsjAUqaoq3TtQjsnA8Y=;
        b=eCQudjekb+/S/KB+i2s0WC/XzuSeCbWdf0D67lLtUGc50xhUkEfoUME/aNk8RtMLNT
         STI/OezRZ61HhwvPw8D3dGRrRoY1rFJEjIz6Mz3jHaVCxCKWGOooybNJV5wIa2faBS7t
         mGs5ojli7XZZuXckPDgnH6uBj2j21wr5EyP07pnYv+klw7C6QslK7+jd6luH/x2SQ6pf
         987xc/0idyk2X0hZcUZpR+4fDy7aouh4tkKwj+mvVT+csqbrOsU3kyT0IV8s+FpcD3Pi
         nzfRiR35PsuwtGuYeVuIXHqsK1czDz1GAimUnCfsae5UgRL3CaswKhu0C6uHMP1MBEmS
         Abpw==
X-Gm-Message-State: AOJu0YzjO30fJGn+NRknOfPRWGmE0sUG7afSm/0/rvAUY4ont0MUgOG7
	gB31ZdFsdJF3lIDFIKAa0gcbgLgQKKG+/TmsF6ewpvl/RhwZyuyIkl4wMVMWyyg=
X-Google-Smtp-Source: AGHT+IExF/deVU4o4/K2ms8bjUDjITAx9RfeeX+sCanQBh2dY/Sb0Uw4sJCB71tV0mSzUGyVn7kvqw==
X-Received: by 2002:a17:906:bc47:b0:a3c:2bfd:1495 with SMTP id s7-20020a170906bc4700b00a3c2bfd1495mr1389894ejv.59.1707585011898;
        Sat, 10 Feb 2024 09:10:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUo3eDpPjMri7X98qBTjTw/GCgFdL055iuYdVbwRL7jqJSxjR0Wa9x1oicDkObOMIDb0OzOApIl+GYIPeIemivemNHEmoD1y52VRa+TxmXk7aFI7/4eAHeEhSyceTAVpsVgN5tlCKLKLmOq8UNSh9PlExAFmW4qH19kfeUtlAwspMikyvwXWXUpFDSWOKt+bfJI7EbgJb1XINT2E0WwQF5MQPfN6BBY5jY70k3+v8xdNUP3N/63/YjP7gZW6O4nUMHAKi0fFmcI99w+YjtTU1Va6sZu8LTQAeWgmCUeNgCAF8csv+EgNbHeVa7MUXc4keHF/aJ3gjwV5KVpn+4xcG8RI7FpgXMLD5FhiRvvLmRriey1oM3EZNmF07hDgunsUpwKLUwNDtFDcvM/gJR3tcNG++O2mCSFRFv8rw==
Received: from [127.0.1.1] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3c1e1ca800sm973242ejc.11.2024.02.10.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:10:11 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/3] Qualcomm PCIe RC shutdown & reinit
Date: Sat, 10 Feb 2024 18:10:04 +0100
Message-Id: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOytx2UC/x3MQQqAIBBA0avErBOmQUG7SkSEjTUbE40IpLsnL
 d/i/wqFs3CBsauQ+ZYiZ2ygvgN/rHFnJVszEJJGGlBdZxKvLFlckhdW3ulg7GAskoNWpcxBnv8
 4ze/7ATcsVpVhAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.13-dev-0438c

This series implements shutdown & reinitialization of the PCIe RC on
system suspend. Tested on 8280-crd.

Changes in v2:
* Rebase
* Get rid of "Cache last icc bandwidth", use icc_enable instead
* Don't permanently assert reset on clk enable fail in "Reshuffle reset.."
* Drop fixes tag in "Reshuffle reset.."
* Improve commit messages of "Reshuffle reset.." and "Implement RC shutdown.."
* Only set icc tag on RPMh SoCs
* Pick up rb
Link to v1: https://lore.kernel.org/linux-arm-msm/20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      PCI: qcom: reshuffle reset logic in 2_7_0 .init
      PCI: qcom: Read back PARF_LTSSM register
      PCI: qcom: properly implement RC shutdown/power up

 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 178 +++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 44 deletions(-)
---
base-commit: 445a555e0623387fa9b94e68e61681717e70200a
change-id: 20240210-topic-8280_pcie-c94f58158029

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


