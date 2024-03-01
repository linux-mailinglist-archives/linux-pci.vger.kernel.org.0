Return-Path: <linux-pci+bounces-4337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0D86E683
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A61C250B0
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95958259B;
	Fri,  1 Mar 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmEmkUWc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBED2570
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312356; cv=none; b=RkZ49Akjt1KQDBxLc8slcJr/BuGg/VUZEple0HRSFx0R6PTH2hPguGYiuWVsZ9x6FDtxJwkMD9LQEKXXy7AAxH7/cEdlCuZ0NVe2N8vtZoLY6C8ZyvVceNxHJ7KG2toaxgVHDrjEuM3WG+Rs/V+yE93ghcPE4Nq5TH3WR34DrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312356; c=relaxed/simple;
	bh=NZB9LRB2QOrRJ3ixKPv2+2PISpkDe3kHMMxpEBwB44Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kCtvr3driXCQrbBfwTeVbylyw+NeBGaeDfXrf1AFAnHCX1rZvjfaGa5xWQkfqazcldSMxeWl4KtORDr8oH/8G4hkdbEKhY6+bclm6gt/A+HKXtVa+YCBjtQFuvLO/WLvDy2kP0TfbFs3wxGdsShav+KgkR0d90oHBTGkXD9DIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmEmkUWc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso650871066b.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709312352; x=1709917152; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jRboemFfgfa1ISiAS1bwq6CDoDUCEYcfuv7d0r7KbFM=;
        b=ZmEmkUWckxMblWEuXTyy8YkUhPQXmmHs44MPQGJLmunUX1viNrRi+H6PB45iHtxYr2
         vEHuvXKMalenhSgpXhXEDV6WZL6NiqCO62cD8m7aWq3a8Ni659w1ewsAy6kyQaDKvjTo
         F6C/clQ2cTQojaY3F/T+gG6WEVZoClw2Ac5u4qq7I1IWJeVmxUk5kB6KlFr3TOkhlFYG
         sG0qQfznwM15EwRl0wNAmOvsESQl5gNkcVpNW7M7MGReGPKvCxbJ2Ob7nX7+t4dpiAg/
         DlEkSi2vgoWAQn5i7hKuCFYulJgGDTNtY5nuWEPuMpYoCdXY8XZSBWswr3HePGQlpF4P
         YW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312352; x=1709917152;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRboemFfgfa1ISiAS1bwq6CDoDUCEYcfuv7d0r7KbFM=;
        b=haHBuAPV0MHpVWe7o0pNCr/u6wakP+8OMyaaQXZ1qcf+z0CBvNlrY+d3B3Khn9Ad0P
         +K9wuHVKmni5+yEqGO9zYLg37mJPCCOVldWp5sAN/SgQT4+vMh2+Y/UgJkDQJReg9zQH
         7/M8Ghxa3aEI30vGTLGHhJn4Cy8/FFepiOpgtcQQg2te3PWelPWJXb/ZLRh/XtYGl2n+
         2XszxhmrADxUmd4KmJaNn6+jZt62Zxe7uhu2JyY5VoFDbucHLwDfVmP7myLMWFHwhdkw
         9onJiqJBxLOOqpxrfo/qYnd0ZJ7pRpRU5l3pUu+jrmJiwYUiA5AMknbJ2g3uy3MUsN3c
         DrFA==
X-Gm-Message-State: AOJu0YzZsshFU3CkEAqn0BD9hG/CJHwOnm8ZNtkpVwf6cNRCZItg2niB
	VghJ4lULMJzT5JsEBZzcSA8lkAI7W8JXlxOyVVBPknMlAX+/Na9T7TqGX5fK0O0=
X-Google-Smtp-Source: AGHT+IFBQNV4AZVdrbr7Tyv1iO/tRxJs+D/cYdtN3eTg0CF1sPeuI6fCoo1ydNx5LNnbQELCBKnutw==
X-Received: by 2002:a17:906:2c48:b0:a44:2073:39b9 with SMTP id f8-20020a1709062c4800b00a44207339b9mr2043143ejh.10.1709312352580;
        Fri, 01 Mar 2024 08:59:12 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906578b00b00a44b405121csm294460ejq.9.2024.03.01.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:59:12 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 0/2] PCI: qcom: Add PCIe support for X1E80100
Date: Fri, 01 Mar 2024 18:59:00 +0200
Message-Id: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQJ4mUC/32Ny2rDMBBFf8VonSkzelnOqv8RupDscSwwcpAak
 xL875WzadNCNgP3DueeuyicIxdxbO4i8xpLXFIN+tCIfvLpzBCHmoVEqUgiwY3YISHCpY/Ayg8
 dGReC1KIiwReGkH3qpwql6zzX8pJ5jLeH4/RR8xTL55K/HsqV9nZf10iye15fCQh4HMbWuK61j
 O9zTD4vb0s+i31pla9oCQheWzsQWmeC/U0fmleUaQ354NBop/451Y+znj+0qnTrpHHcaVM/T/S
 2bd/adsEgcAEAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=NZB9LRB2QOrRJ3ixKPv2+2PISpkDe3kHMMxpEBwB44Q=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl4glWk0wx0/5gvpLofEZZAw3EgZUXuInULn5fW
 ZLwK1W3vmuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZeIJVgAKCRAbX0TJAJUV
 VplPD/9m3O0d8uU4quz6MHx2frXg6kVXV/YHIUY02fFUDWeFdoTogxDeznL4+eOG/WOe2/obzSc
 gX+IAyDPZL1vZ7VW8mY13G5yXEJsg6wUaBOimMcTGEgWBK1OKvu5P3IbYyeWTTrxGM4ta8F7wqB
 YPepLlV5t5sUGjFfXHrRAC9G8d1kD7lhBqGwP48ENwsNRtozOEMLKoMFwLNaLXFmZfuSAWUy08N
 6qD0cUQaNaoHVBp1P7ETvoPIvSD7SxufHOAGRouY0oLJ2mLIwBupo5effYojXwdNk+XpPlNPRmv
 ZS8hc8D1izrryFkTl45yEQmcnY+SaS+4ICtF2PwMQOnKfoiS3p+YzQ4Ef3t0ZF0cMH2XDrDMXfJ
 QEGY9TGDU6ihkK+RKrexrhsYaZ/ZpRyZd1R/m2n6L6sznbVSFF1tKKWiWht5cHNaKPYs/ONAWAW
 iWn8NSOmtXPBHaShaD2N7IlyvGVjB6sP2nqBo+/8SdzElkygYKejSHByjsfBe15YFV9XA1go3yg
 UTwbhTpOWd5v51KPoOulajIBhuF0dBdWQJnsSqSfILVhxzgu1Z+B7uoqr3eiPkk6W9Q/+AzdP7n
 Pj9n122ZEkD262FmlvvP/d5c1iaTXas6syg+woPLGCInPWzlTbdIslVuJ66N5SSC6CA3/iUT5Rq
 W7EM3wkA+hStDTA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add support for PCIe controllers found on X1E80100 platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v4:
- Added dedicated schema as Krzysztof's work that splits the rest has been merged.
- Link to v3: https://lore.kernel.org/r/20240202-x1e80100-pci-v3-0-78258e9451e8@linaro.org

Changes in v3:
- Added Krzysztof's Reviewed-by tag to the bindings patch
- Added Mani's Acked-by tag to the bindings patch
- Added Mani's Reviewed-by tag to the driver patch
- Re-worded the commit message of the driver patch to include
  things like the core version, the max link width and speeds.
- Link to v2: https://lore.kernel.org/r/20240129-x1e80100-pci-v2-0-5751ab805483@linaro.org

Changes in v2:
- Documented the compatible
- Link to v1: https://lore.kernel.org/r/20240129-x1e80100-pci-v1-1-efdf758976e0@linaro.org

---
Abel Vesa (2):
      dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller
      PCI: qcom: Add X1E80100 PCIe support

 .../bindings/pci/qcom,pcie-x1e80100.yaml           | 165 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
 2 files changed, 166 insertions(+)
---
base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
change-id: 20231201-x1e80100-pci-e3ad9158bb24

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


