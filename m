Return-Path: <linux-pci+bounces-7913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB958D23DE
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B15B237F6
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B36817A93E;
	Tue, 28 May 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GD6cdrQ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA40178390
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923035; cv=none; b=pVuPJ5tM2PGIkW7Y6GIUYizxC8b+OJkSgIt/JEY4e/J9txrJq9Y7/DGRN9wvqKkytBPXTcz+6X5R5CdBMB0IIFjILFOFuQXUvsFgbSLWqZHi6fxHMfC426RGaQ+RsejjhB6pxndOl9bVdoxivvff10UKtmQXOjRFrwSlKjyH4eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923035; c=relaxed/simple;
	bh=oRemnPOX+Y4y6DXbFK5HOZntLeOPfGF7GbKdePpA9zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qD0vjbfCvJAPkr2Yv1tW2qzqnDSjvurmin/K3ha9cd78uIxNwD7t4tUeDvrbuSoHnIthds1NHWU96kXtp+4S0uN6zf2w7X0YceYZgD45ghoL5gyAFfZP6NNK2jmkAxb64Jh04iPCZwCOhJzF2kxu+IExSQYNnlIZ4jPJfnW8NVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GD6cdrQ5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so10900935e9.0
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923031; x=1717527831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcKhaZF/3m76T8k+V6gAZs7oJGtFN6fcRMmIkblBf4U=;
        b=GD6cdrQ5pjCcjQJqedR3bws6y9/Dy5jGuQLY9Io1enNIIDjVnd1qs1qwxAsqJPYLvT
         mPfdsSXNVz34tM1J7ET9s0tIztkzOaGmhspf8caS62NeQ3SHuaUl0iVBtSl7KcvYnUMS
         rqBAcm/8wzQQD5NWi6POtW+Q11kUrqcXK4KNzqXu/ZVlNLTLnjFtnWixQ3lbw2cA4NkO
         C9vu1lWSzr3jM0zNZkpxjX1bua/FVRWYG+5aLSMR87UAOEdWjQg7SUtBENZZNiHGUgb0
         pHT87nZbEZqzwMJXh1mdq1RnnxkVnzPUgFnNTA+oiLVOWgTxMtkNkJDzzcDRzHMlS5YP
         2dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923031; x=1717527831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcKhaZF/3m76T8k+V6gAZs7oJGtFN6fcRMmIkblBf4U=;
        b=X2TSvZTq9lzyvWUdUEVfQOnrOIuayIA2i1X/mQayJBoXVhSUe5NNXDbmt81sOFBT92
         VCBTFkvABpxep4Vxl4mprKEEJaVVYIM1EuI5/kvJpElg4zDBEJapBXNHTKR8z5pACLaR
         SHXxcTYKNdunI+q7aRZ0XTYIB281DUNMm842iT77LGS+iriqhA5TC+0QdesPB5bA6N/2
         hhPbnqZbdGRwcwhntHxyjYftOOiWHhdxYoA18xnR4RVMHf8GzylOxPhtRLAJja0m5aI4
         aDVfWqk0nM3QJFzMLVlRSdetp2xqmc6TuQ1G+vEJ1fkIiH4wr3BgW3grpFHUEIaG1Imn
         +KIA==
X-Forwarded-Encrypted: i=1; AJvYcCVp4z3DJP0O/91Uef4WOVfGf/W2Xfye0ph48lM2ynLhBzM4RukDpJ++zQn62cbZYPs3FyFlDohEd/zUDgGsDL/TpAQzFhNGdSzD
X-Gm-Message-State: AOJu0YzvOHXU6j2jjN2FDyDuES3wRXgyC2tWr3nkfRZukeSGIZQiGFc8
	AfGa6+CGS1QWOzJrEZoIfNmtFOBxWb/Y2ezRI/TBaS91H0yflD+ho030dO+c0d8=
X-Google-Smtp-Source: AGHT+IF/dKVBXTZg7FRNE2nApY7BnYC/zWCFxSOBmiuzEJpp4OoVNhdMhJz26eWOi6yugTJBEg9vIQ==
X-Received: by 2002:a05:600c:1381:b0:41f:b0e7:f299 with SMTP id 5b1f17b1804b1-42108a59292mr87164795e9.9.1716923031568;
        Tue, 28 May 2024 12:03:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:03:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:11 +0200
Subject: [PATCH v8 03/17] dt-bindings: net: bluetooth: qualcomm: describe
 regulators for QCA6390
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-3-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=hux33j/WCCoK4y0/gy30fq+au9a8XJPG6iF4mQD3wuY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqMAIW27hbwtUHKtDlPKtGzwQfx8XB4FdKGP
 UwHo+RxVieJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjAAKCRARpy6gFHHX
 cqJ6EACvM49sa2TtM8BCIBqDJ8xsKyv9TAVs0UGYuVEvXoITLzjg3SFZmBLQipM4vrsnINwSrp0
 ggtbDdNjk/cV5MtOkioi25AkPss61r6G8TLGZbbweugEKxzAkgzuqIOUF46FKVjcuIDh9/WDZNg
 f9SzmUHw0TtIxRR+Yigj/atgNMCxESXAUegJ/IIcIWwGR4tUBE5bPbH9epEblv400NMIFqf/X4Q
 oR+X7Gg9Hf0cWY00tODNlEckxN/9DRl0EsA3ZNPFjBmkedks65/F48uX3nfAj3HpSiZ0RDm2cKm
 sXLxqXP4b61rPKTcf9SQ5eqEP1bOWY0jJOEoIc6y/SjH+o0Btx9pKO8cCvL69Eapx7Fzs9D8Pr+
 NdLfzvmslXYNfc8PGPFXGDs/Pb8qcBjr2p6nqL/wRSAEyRaS2MPjmZ6sTtMTlAl8iQXW9yHUcTz
 fnRWy4apTTWT9HFN8K5B0Lrpi41cNiXWFYWDtU4SEV0uRsOw3ydCA3rd1ernAkCRVWHjaCqTO8s
 jwSUpAKYUVSnvNrcAAsyLN2EtxpfdOXBDLejdFtuiVZYow1zb+wGnLGV3vbbUfTy4FSfkY/pfcC
 qCnjp9eTFegybj3kI/PfnfBTRgUnC0dgsYw9aF0W9bcxZhVGyAGQONdqntO90LRZa40f4yhwpEK
 50NWrd07iIfsQkg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

QCA6390 has a compatible listed in the bindings but is missing the
regulators description. Add the missing supply property and list the
required ones in the allOf section.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 055a3351880b..48ac9f10ef05 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -62,6 +62,9 @@ properties:
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
+  vddbtcmx-supply:
+    description: VDD_BT_CMX supply regulator handle
+
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
@@ -184,6 +187,20 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p9-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qca6390-bt
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddbtcmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
 
 examples:
   - |

-- 
2.43.0


