Return-Path: <linux-pci+bounces-17332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F59D9566
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 11:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599DE282026
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA5E1CDA04;
	Tue, 26 Nov 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3bJ1CGm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A23195FEF
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616580; cv=none; b=VGBCUH76hCiXZ+JVoRL6bIy6qy+DTo1TDCut268htjupjRVy//6fr0zXmA7EIT8UY7hR1pXY7058vWq0IbzpteFmjzYzGd+qVZ0CBOAZWgXdtCupf4HZ7rfsoi9KvlR/o74MkKNDsMbTr45uFSLrcCp5HDelb5Q1Yp8dZVWD1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616580; c=relaxed/simple;
	bh=DSfkUxtAoj5mu81yWWFvAAd0RzmXItr4kWCdyj1bISk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0b28tfn7tr1EHhrcb0OALJT18aKHsbWXfkf7TDdfAYyZ/rN/bZbgzR5XC6ONviGYFu+sl8WfRuNoAkEgzc3m87RZKW5JPiB/lhRaylLoiXtyLwuW7wfzkr1QCXXBB0Kp3albTJIpROLBxW1BsyEeWJL3CnJeyFpj/2SHYtiS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S3bJ1CGm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a1833367so9053785e9.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 02:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732616577; x=1733221377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGY7qn3T/vVH05XwetJnmcN100gMBe4kn/nqWGga67s=;
        b=S3bJ1CGml+rVJGVxl4jTciWrCEhbfod+SdDcZiH5zPZbRcQ+og0nmEeMZcEtFuAkof
         tm6KGVXO4YkmOIb1I+BZZiE8YfafcgbqDJyvJxXNkiFcHjeN/SzAqS+iX6hzsyeBGhkM
         TelUbSVscGXMiVtvPqlcz+mFsUOUoiHS162M6EgKYGXOFTcM1zcwFYyjg/x8Y4y5kc8l
         WgAmcLbSf52PqzsBqqlE9VQGVOVh0n8fbHEhLn34kNv5mYkMdvKq9cXzLjbeRWedOKry
         JC96+Ku/tTc/ArZVq6qGwtm+RfQzruY6DYP7IVEwiRg7dSydcIKn3Xvp9/l61FUWd+sO
         UqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732616577; x=1733221377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGY7qn3T/vVH05XwetJnmcN100gMBe4kn/nqWGga67s=;
        b=KV1ozhJXqXu5uN0t+82EVOxhOlOYFl4yAs2JUs1EtAYF+HDmXMGcPwAFwzRtomCx/U
         31J9E60kwCPr6hq7JMW9REO5tOnJA3s7FE+ELSep9COcU1A91wo9r085ToP7c8x2ZuLt
         fmQg8GeWLashiQGYNghvH5qGludCFI1Zi48tpk8ro/bxnfzK4Qa1JQSJCQpzKAnNueWC
         VSRPuavb5oTJj4vblWBZameXO1QU3h5M7SQ0ztNhzIWJzze0ndfRZ3dLU/qUChKViq6T
         D/VeD90PqoFPYL4d0/axnQKt3AVNI4LpXkG8zct8RaSj7BhkaRP4eCuPzRHnK+jnyr4H
         wxrw==
X-Forwarded-Encrypted: i=1; AJvYcCXG1zJ6RP0J8HyQfH4bK/3X9HZHVD2ndIL9pQOYSbU4fAp7S7S/hEeXdQvWYHpuqFIdrZhJ4qYpvVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcruao1MwjSs9lHsn3V9qjOyAloDd+bb5Shegd+eTLf79LyEs
	/dkeZkvWmcvTvSqCExy5qUbMWjoACVKoYL2KsFH8MAzSr52aF4Uow4DfcSzi7XE=
X-Gm-Gg: ASbGncuugbw3q650CkLf6tmVpfjcRrHet443bGCNeVkGg6lokXIvVuJj2ABPhM70yZ3
	aXzhaas8Ab0CSJObvDnqKknDS3xtcCH1HEItCLcCttufvnlopFHFJ1HjuPGEq/2E21GBUnajLep
	jIXOxdoZVaZ6rNV4WKmSEvKRnxIMyO1W+ove98Hw3LqSD5KROSkk8K8CbrjrSJkRBEhPesjYxU6
	9gZ9NUYDmmXk86PJ8hrtygqg8cdxP0uvPeFGVpZfI9Pz7Rerl/okPfDEam+PLMhfLfshjc=
X-Google-Smtp-Source: AGHT+IGPAdKF60KJgbdHpQ0rkkHhQT35BoPjigPNj6uM+GadsiYB0acZNjOjuCklQM7MHaWYJOgR3g==
X-Received: by 2002:a05:600c:3552:b0:431:55f3:d34e with SMTP id 5b1f17b1804b1-434a4e97451mr21967545e9.15.1732616577530;
        Tue, 26 Nov 2024 02:22:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1046sm228378075e9.4.2024.11.26.02.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:22:57 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 26 Nov 2024 11:22:50 +0100
Subject: [PATCH 2/3] arm64: dts: qcom: sm8550: Add 'global' interrupt to
 the PCIe RC nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DSfkUxtAoj5mu81yWWFvAAd0RzmXItr4kWCdyj1bISk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRaF9prwC2FE/20VAFkxL2ILMYJ+aAmceOxTvbWRS
 z4ZM7MOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0WhfQAKCRB33NvayMhJ0bHOEA
 CG5c18zN7eCFM7GX/zPfQuFA7GTJzLR2x/AC88IfhPfsmqMToQCucnNGm8OhNoq92kLLMMv7P/6qR3
 uhlj9VIvuZCbODoAKm+9fDgi6A0qGikNYp5X5y/39351trqDgEQfsEVOqXlHAW8PUvL574nffugOjP
 3brwvr89SeGqpVci8pCM/MNwukm8MTPax0eTl/k6gEJGbZIKtl4TYRTlBIsMi0K76pwI11qXuYNHB9
 X4T3KzeeueNn7XvKlB8ZFarJfNd6n8WQAVHZ8Sh76nHPMLi/aPsC+J0NCpI/Pt/Oc6pr2PQ/dB3xWK
 YJNrcqQSEXQGjLEnGACG5LLBkRkvAsYRokxV/cSrMVBCL2wMPJCM4Ciesk1kkLEiJqgMV4jJh5CdHB
 cZdfTfRlmx5SbM1KIwQNRYg3lEcvJt0Bnd5D6XBbBxQ9hQGd4bhmUTaBBEeJpquDLPqHuIli7+xooF
 0cLHpXR9IPykR7iA8QlDAAKqW+YRgu/HEg51nt7c+X0IbuZjBBlJFmVVeb6Noyc6kwCeEHrquVIydJ
 nvx8YrkpTgqVJqDI5rK5Q+DY/W8K6sVCbWlTTuh1G7FdKPmNrKH5Mf8c4MYue7D5iGk5VJBBBIgdDW
 +sqPlG/LpvsT/V8qkgbh6FVHgdIwC4Ado8JpIZXGqJRsU0G5b4Kkfy7hK0xA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPUs. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, add it to the PCIe RC node along with the existing MSI interrupts.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 9dc0ee3eb98f8711e01934e47331b99e3bb73682..44613fbe0c7f352ea0499782ca825cbe2a257aab 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1734,7 +1734,8 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1742,7 +1743,8 @@ pcie0: pcie@1c00000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1850,7 +1852,8 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1858,7 +1861,8 @@ pcie1: pcie@1c08000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.34.1


