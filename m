Return-Path: <linux-pci+bounces-23090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28808A56257
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F9D188B644
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270BE1B87D5;
	Fri,  7 Mar 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVkrws6x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE121AF0B8
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335215; cv=none; b=gv5CG/8G1sCgshKKTpzD9ZaP1YZRvMpLK727gIh+4/nzXpzlj55blLNr8hNV1vmgsL9Hr16vgQokXBiGt+tMuruGVDdDewGcA5pr0pNjLruw6XrF7PfSo6c+159er2Jk31UlrRmxrBp8w3+QEmAbfp6DjCkJDcti+PQFIp1u1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335215; c=relaxed/simple;
	bh=MjZEevqiXfdNqsDpkVbJ0/fl8DI8+0lh0TkKwbfW+TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2x9Z7Gel9kKH0CIy5S2f9BtpuIg+sfb1cRFJS4iGmFnSQFF05/zzjWN1uNIlNigQskIFCz4yERgpDeuKOBRa8iCTJ8xwcB5PSxgKHL1Z4J2xTdED6xVyGFYuiahX5G7GfGRZnPCflbrXnBt651H6iSYFz/AbsZIV1T0jNbP+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVkrws6x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ce0445f3aso107335e9.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2025 00:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741335211; x=1741940011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUYIRYSwBjJMKoZRkRVso+9oPdhRUH9hUs2kQff1NnU=;
        b=XVkrws6xq2l70HPihBZ4yRT90f5RMCTFlU212hKTEYTOQMjaybcJVF+n2jMPgOwnVN
         KekmQcxI6IcHtZ8RJbK+XjIHX7dgIXBub2ja7uGafDSs49M+WEUEuJUQlWvOWMEU3tXM
         VcT1qzmbtU7/X5oBqbgwfyWJZjGetFdWFdvQxiG84hq2ZRldCYmQ871stwYOXteERVFT
         YBBlQxtSAJ20o9urNIFEVCReMY2q0rTG8DS2w20khguNZP9mjkJ/mfZmF+4mtIUg3YOS
         O7UitwOga3A5GJb+wkog2QDBS0oDl96dUxkU9CHlMH0Zxe6ffGAa+hO+ODRmP9+hQtEu
         qA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335211; x=1741940011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUYIRYSwBjJMKoZRkRVso+9oPdhRUH9hUs2kQff1NnU=;
        b=vd7oEmwNTMaHimiNlcsG4EBJB4vmqYyq/PBHzxrBKODXNogWBkahNo1noYKNhLoJCn
         bPqnwzXsTRnp1Hmisam4/Jwn+HFWb1gmV/nQupTRBBM9XZn68o0eIYIDICsSGSOFw2Cc
         Qcc1SmDFdIaSgmeb8i25IXd1yaE8CwC/bh1MCU2Jq9KeJ7gWTete2zZeIzxkDAb4/Ij9
         NX5ovp/nbJ2kKGXSUxFdT0czEhz+6iv9lvElarME9o+017j405KAMTmNS3Ebhj4HHxbC
         mfHXUWbymfA5XCreBYGOBXz1+YIRHaNfzQZWdrHVXtcx+jLGit/0lPzpIKRqkyHO8vSP
         hsPA==
X-Forwarded-Encrypted: i=1; AJvYcCUss4Y7f/zlPayGiKoCV+WjUSJdY/i49UBcTwKkYxzt3us1qIgU3B9GxQOT+lpZ7cH10Vd8JBgJvDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHmmppCjO0IxeIyZXlwoGZT7AYEXCdGspCHW36COvVRFhZDVm
	8AGQLRCKvAdYI0cx8EPAPloSJ83thaNmWOO5ufOTkFgZy2M7U7iHiAtw8NL1Fas=
X-Gm-Gg: ASbGncuxXKP0mggcGgYdWhAHdMMc21RETI0oAeOwDfhAWWn6EBhtgGYsVVZKmFBJXfi
	os3dOD26owFsLjTbgVjV0jx/uJmR1nz+TM/2ZO7Dy4CuiJ/mzzynSqrSuMnWzYM2+wFVKxMq0f1
	44i93AW2D4y2hKF+befzUEHTVzlaSfuE9rAAkYGRQPMEwc/2p62CL0G/9BjjefKk5b5r6ZY2JXz
	mzbnxs0DFs0QbXWy22q31OE9/U1h+/qMHbX+7KNlG+KeUnkkoQZruQ/xXvnGfjMVgn/0AXAp/oM
	ZtdMny9a8fiKJoL5hFTRyPmdEjuP+Smp9REiKVIJEPTnxyC5lEHwkeyYIlk=
X-Google-Smtp-Source: AGHT+IFaPYdf2o5TRCCDsHV0LA6cr7wepSimT5aEWBj/BKjySqhoj9YUXPHRsLE3AOXGgp+AlWB6vQ==
X-Received: by 2002:a5d:5f8c:0:b0:391:3110:dfc5 with SMTP id ffacd0b85a97d-39132d30ba6mr243383f8f.3.1741335211559;
        Fri, 07 Mar 2025 00:13:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e222dsm4575458f8f.72.2025.03.07.00.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:13:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop deprecated windows
Date: Fri,  7 Mar 2025 09:13:26 +0100
Message-ID: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example DTS uses 'num-ib-windows' and 'num-ob-windows' properties
but these are not defined in the binding.  Binding also does not
reference snps,dw-pcie-common.yaml, probably because it is quite
different even though the device is based on Synopsys controller.

The properties are actually deprecated, so simply drop them from the
example.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml         | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
index 399efa7364c9..1fdc899e7292 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -94,8 +94,6 @@ examples:
         reg-names = "regs", "addr_space";
         interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
         interrupt-names = "pme";
-        num-ib-windows = <6>;
-        num-ob-windows = <8>;
         status = "disabled";
       };
     };
-- 
2.43.0


