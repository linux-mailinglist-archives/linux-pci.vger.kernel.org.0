Return-Path: <linux-pci+bounces-1818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638678270EA
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF83283B6E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9704653D;
	Mon,  8 Jan 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIjQ5Dv3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394034776E
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so3303894a12.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723570; x=1705328370; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G8PDv2FSbg+fpG2pH/cK5nA4S/4L/t4rfemMnRunnf4=;
        b=xIjQ5Dv3h3Cyhi3fK4GHpbkBvGDDccVM5xgclKzgycJ6WmFpBQqdQ6x6ORLkhQWbH5
         SEdYSN2rjufoWXzM7TRiq5/NWUbxO0VkmzAmeksSLBD23ydPOWgX25fUvm238697ZbhT
         GOhT57soBWk74MgXJ9shz7wSXF4Xf0nS8vLhGkDT2l4+DhKP4D/wEFLF49uPFSjPYJki
         5vOxYx2lE6YUMDPpFDmfq3H02gdsYI32qCc+B0BxCoT8QCTGhGrIGaTtzjHnuaRhNnnk
         u+DEKD5YguXQcATiUKN0Ol2HKPKWihsTkzPIT8G4L5DN5NxofUrlseDMK4pM+qbXM1ZW
         civQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723570; x=1705328370;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8PDv2FSbg+fpG2pH/cK5nA4S/4L/t4rfemMnRunnf4=;
        b=jdFUv/Amug2ZK3rsy27SZW8Ztt86gsALDjhlaUajZYBwhS1zkfY+8AWRWGcwkClYOS
         WsNghtiR4p/dAUH/+BeXwGygzb3w3ZxB9rteBxcmhkzZF1xu94e2WI+tq+yL2//61Q9F
         24LnuLylqFt8P+349q0NAObNNi+5gHhH6skB60UtTRYMyVcP7r3bWN1rCV8JuL6ph7Tk
         x7kkbVm5WsMhD0/Ijpd3iSIHHKLGPsgC1ohXywHuda/EyCe0Lm97pyoSA/7pY9/HSDQV
         hBXRowt1S7KneskIDTz/R0nBLs4/FPWZwBFQsCZT3CaXQCCh5dlRw3bkTAFN8irbSkyR
         m/ug==
X-Gm-Message-State: AOJu0YwRy1+/pcCRC4ShmtUdhzIjnwdegDNMzyJJYCUGfZjn7Alu1z3g
	/CPyB3qA0lqXN8byp100yXHFAgthzbqDSg==
X-Google-Smtp-Source: AGHT+IHoF2GVMteIAfJWH48edmwJwVsK0y2zNkO6YSRmqdrkn/i7tpiGhd9MrOxF+zqL9qk5f8If9Q==
X-Received: by 2002:aa7:cd66:0:b0:557:e391:ec65 with SMTP id ca6-20020aa7cd66000000b00557e391ec65mr303770edb.20.1704723570516;
        Mon, 08 Jan 2024 06:19:30 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id cm25-20020a0564020c9900b00556ee10cfe3sm4319832edb.92.2024.01.08.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:19:30 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/6] dt-bindings: PCI: qcom: move to dedicated schema (part
 one)
Date: Mon, 08 Jan 2024 15:19:13 +0100
Message-Id: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIEnGUC/x3MQQqDMBAF0KvIrDsQoxjpVUoXmoz6wcY0I6Ug3
 t3g8m3eQSoZovSsDsryg2KLBfWjIr8McRZGKCZrbGtq03PYeUQMiLNy8uCv3z6sacXOnW1d4yY
 3Dp2jEqQsE/53/nqf5wUeFGbsbAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=GC+f3neoLgboHBTEPpZpMMiPSHU1n1ZZEPHaW9LLjhU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlnARqEm5SplphLQerlWKUpiXfjyylIZF+WYM4O
 jjNDw5npXCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZZwEagAKCRDBN2bmhouD
 12A8EACQi7ZJlgmYenQmBoez5cmbXSh7W6TxErWQFuATKx8vqI8nrdjeJC4VXQi/gzQTMlQ8Sky
 r+tQmPMQ4yA71THsXQ/yGhG/5MKXzp+vwHF4uHETumYwpM+2TvK4i0YtSGlcsgK9fGDi24t1Z6y
 s59NuoBYhGDA18QFCgtsJEsjsVpLipzjiVTNextHSjLxu72QsqPgM3sUJLhdt8gP6cCM7Ww9urz
 xG2Tt80coNRwac7f9JIB+JAK/+NziBCxaAwPTHZbi8g0zAQSQL4ou+IGCxsAuPXFBHzcDHGyHWQ
 V2qIkRZ2zU4XqCyM36zXD7XDhfIiC7E5wnGn4R4cEQViv/TAxbNc6bESuFgZ+CVyNMcznkDnH6n
 TsKb07iWgU3XG1xCqD+/794fMMygfH5L0X3XZ0R7EOuHAPMxyLT6CWGIM5DQau4r/qxpsaysWRg
 8TO/p8xTIThWv1fAhtsAgNayTjabFZ79R0nc4AyhIz0o6Vn6s64hzvQxFn9475TyBK/I6GG4+i4
 ei4D4lWIqBI0J2UWhr8PFZHUYLMk/0+0sY7oRXxXs6CrMAiDFWZfy5HuMCjwc2TUhcwWTtq+Nti
 b7bG0A+HiMnjIk+RmvaGaSo7Ghp60pJ11yHiHMpnRyA7Zk3fItpak2Rb1p3tp3ZxQQ2BTqbFlRX
 im4/kdb8gGE2I+w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

The qcom,pcie.yaml containing all devices results in huge allOf: section
with a lot of if:then: clauses making review and changes quite
difficult.

Split common parts into common schema and then move few devices to
dedicated files, so that each file will be easier to review.

I did not split/move all devices yet, so if this gets accepted I plan to
send more patches.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      dt-bindings: PCI: qcom,pcie-sm8550: move SM8550 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8250: move SM8250 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8150: move SM8150 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8350: move SM8350 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sc8280xp: move SC8280XP to dedicated schema

 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  98 ++++++++
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           | 180 ++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 157 ++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  | 180 ++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  | 169 +++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 215 +++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 171 +++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 268 ---------------------
 8 files changed, 1170 insertions(+), 268 deletions(-)
---
base-commit: a0bf076e449e022944b440174491f5c583753d84
change-id: 20240108-dt-bindings-pci-qcom-split-624737f7ba67

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


