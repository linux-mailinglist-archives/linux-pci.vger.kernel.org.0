Return-Path: <linux-pci+bounces-19118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB399FEF6D
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 14:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2AF3A2DDF
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599019CC3C;
	Tue, 31 Dec 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjNFVd56"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C438382
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735650158; cv=none; b=XNgSPXGEFQ3JYOcmjv58QctQQHS+v5pXonT3230W3ZVPhdU4Pc0hqjdWvfD+bhX+vZidPGRu6no3kHlhK2C0Jm7tnC46a3JsAcXWGPxz7Y+K12cllOrTpPhn8rMmhYtZcIzXihnbil1ohsVjoS/8mLBliHKECA7jqRm79hyGUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735650158; c=relaxed/simple;
	bh=A2svREI4FIVJzkKEwefSXyU94tPzvmDtXnUwV8G8N/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A1SgY5BG19JHNQ6NJvqhG2vbPwcV/7spub3rNRJx86HaBLfnmMeBbANUUdt1guWx0Sk6O5DDIDqVIEIfrgWwGVF7eFlX7S6nN1CYXA8jU9TSBAKe4SV0IhLhreATaOlqxNlKtEuJXB5sUd1OnG9ElxHCmLBhdmP99K5KBZmM0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjNFVd56; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2156e078563so115830555ad.2
        for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 05:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735650155; x=1736254955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pD++1f9rqBnGXBqsB0i/D/VQxXsfJ1lC64nLmc5hcVM=;
        b=EjNFVd56Nz0mWf+vslEky5Oxlk1LYpK8TqT6Jz5+44DHaWdCNCH8UfhtsrRUsB49uw
         2TCER7dtl9LbZ+WxRCt2Cg6du54DE1tQo/c4XGTe6EWEJbDIi4ir4qQLJJx6IfPknxT0
         7uexokrY1RY1t2PhLsJjvLaK90amfBtvGQEoZHvKOgS+MfP5PDZIgglxJJZjtidwS322
         YTBliw0WlSTMeejM/MZKEyEWDhQvzuZTs8o5cEopgOLNCA8pZ887feQr0oeHNiDSqFFv
         JlCGH4L16XvezxFfoP4djSBlxsN/phKmE/dq6ZyFx9owc2XUfjkW9IbR/P3RclYluuLD
         2crA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735650155; x=1736254955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pD++1f9rqBnGXBqsB0i/D/VQxXsfJ1lC64nLmc5hcVM=;
        b=Rdxn+w8kEqUS3EwstQOC9aNdSCihRN21T2wRnEPXMW5jkFmJhVUxYHlp9Z68e4XNxE
         divMVFlYwWdjyvYGQ3c1mQTUWZ6SWOLucL604eKTwTbP+mQ3BC2lPoI7Xe/mFj5NKu/x
         1aEmyKuMdg3v/bZRdl7LuoUDw8iEe+WbTTqxalvb+/sgN5yW61r7qhIPtayIwPMVEcMz
         dqabubZxl0Ha/4iIEMH3eX+G4OjV0BsFrsYOz59pznlZRJByxljVhrtWuxe8K+L+n8g4
         ueDn+U30sZJETaifv/CiXpwRNZnSqiGamEm5kLL52DwXcO03TbzGQ3jU1TfjG7NOMGC5
         n01A==
X-Forwarded-Encrypted: i=1; AJvYcCWzmMQiC3DgT13Nyx7miMMQClJxoiovWEhcAu5vYqhnBBx5sfxeyIv44S8cnBzgAIykAph6nhZswiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22IBAqNuina/UIRKCPATmjGMqF1FTeHqQKG5Jkj4bAhK/KkzP
	f1gBg0W6vnHr/HD8RB/qx3bg/QKxfVN2xTvPJ1AlP6LPhl+e0A6JdtnseYn2XA==
X-Gm-Gg: ASbGncv6c0g35HUtSo9Kuxfu3kMHP/mJjqkDxFKSaIu7XiY/SogPTqswtPYOIsw9lY/
	hYS5+n2dEWVu4FH9hpxwMoPjD4LNAwRX3bPiOjSQsp0Z9S7c2IzRlynekr7uSEJOV2h6q5vUMF5
	c7hhh3+2JylMCJYUn1v+wPGlHn1CUzoGUm5Qm2OVGGp8qzaXHN1iXA8ppmQocTBwcfpE8QTId22
	qVsYmSIunFa0+8U9fqf1mDRc8A/LWZxb99L0CPLd3o7yj+tW38mPcY6MSkQoujh/5Xt/6UZiJMd
	18xon0VkRXs=
X-Google-Smtp-Source: AGHT+IHskOPLWYz3FbdcCRFskO3yH92w/nP2ktKNyWbNAAQ2+U5M+AnqRVc9v6tod88isaSxH0Z6dg==
X-Received: by 2002:a17:902:d582:b0:216:282d:c68c with SMTP id d9443c01a7336-219e6e9dff9mr595650485ad.23.1735650154344;
        Tue, 31 Dec 2024 05:02:34 -0800 (PST)
Received: from localhost.localdomain ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d945csm194514275ad.117.2024.12.31.05.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 05:02:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] PCI: qcom-ep: BAR fixes
Date: Tue, 31 Dec 2024 18:32:22 +0530
Message-Id: <20241231130224.38206-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series has a couple of fixes for Qcom PCIe endpoint controller. The dts
patch fixes the size of the 'addr_space' regions that allows the endpoint
drivers to request and map BARs of size >= 1MB. The driver patch marks BAR0/BAR2
as 64bit BARs.

Previously, this series was part of the Kselftest series [1]. But submitting
separately as these are independent fixes anyway.

- Mani

[1] https://lore.kernel.org/linux-pci/20241211080105.11104-1-manivannan.sadhasivam@linaro.org/

Manivannan Sadhasivam (2):
  arm64: dts: qcom: sa8775p: Fix the size of 'addr_space' regions
  PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED

 arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 4 ++--
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1


