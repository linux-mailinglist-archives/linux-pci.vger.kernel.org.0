Return-Path: <linux-pci+bounces-11793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E60955DEF
	for <lists+linux-pci@lfdr.de>; Sun, 18 Aug 2024 19:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329A2B2139C
	for <lists+linux-pci@lfdr.de>; Sun, 18 Aug 2024 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F9414F108;
	Sun, 18 Aug 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKk1X/sw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0631EB36
	for <linux-pci@vger.kernel.org>; Sun, 18 Aug 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002132; cv=none; b=splXc2gRLLqiN9hMk9ZtCOuh3gDhai3cCuwK9p/6lEuf5lsUO9s+1E4flwynx66ZH+FiMOE/NBg6AJgr/CewLXFpmK/qUWV6BrNsMgbH/NPAJv9PIMXGwVWFjV7/Rcv//4CoOCek8GJaD0VMGNe6gcv864H+KyAoBXbZREVpsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002132; c=relaxed/simple;
	bh=EcLybmfw+0g9pG7qN2rZISIWYbjARPz79yYF0pURgRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGzYGnCvSsrDE93GMcoYk1HU0DWAMLXwbITfIfAT7p6RjEQZoXoz/xRyiUr+ZYJ5q93Re8o2enYG7WWvGCeGAPbOEo7lJaGIJcSuo0YtBagfKfWHAJZMUS1yczBgOr0zJ9bq4CR4Rw6ATnx2jtt+vbvZ8xPRbs+D7b6cUO893nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pKk1X/sw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-371a9bea8d4so646347f8f.2
        for <linux-pci@vger.kernel.org>; Sun, 18 Aug 2024 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002129; x=1724606929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNx0581gmw5KmVnKNMArHkHEaJIxEm4/jRsnasy6Iao=;
        b=pKk1X/swdl2oN+2bNpUL5GH7qs4Ir4Cgl7LUFUkNE/562P1P/ui1Jib+Q88VxAIgb9
         /jSdiQSVxOeddjSASj4ktt1tDxLEzXdVzHhCGLdLO5I6vCXF+HtYyuzBJFabrWfpHaaK
         6P+eSRT5tdh3Ly4sBzReo0jdKyhaEGmkZ4jekegK0KF+5UT6fWW2yQeVaITVAuww6pl3
         Z65Ywt3UbN98sQ9CFk6tXyg01er/bw5utj0jY0/7GiMTo+tKbN5XCMLxfkHhFrdl6xni
         tl99lm2DNlB3uzROAwPOZJMyFDLrhbL0xX11zd2ASHCsCqVLUFPXRBOaSdCqVvhd/OJx
         1ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002129; x=1724606929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNx0581gmw5KmVnKNMArHkHEaJIxEm4/jRsnasy6Iao=;
        b=JdgdD9VMyFw8i2F6wEE5KGNi1Ubx+8PKbZnjI6sLlEb2RSuRLT4vahpzkygs4Df2RY
         ZK3MGBJrRtEjqtQ8zc0OaAl+8FFpOTiCbsMr+vkPHQRV7mJcteZyn5dJSXlou3ShZwWd
         O5wV8jedfRrMbbVp9DwBdNGlo3xYBb+JOFmm3MbqodKIQIC85i2cU672S4WAljdrA6ST
         /QQs35pnznR212vUvceEMTvvy+cYoQ8Js5lDKt0ba+Ixit691WO8+8t1cAFWOwDXh0Qw
         AE/YgAm+C7c0sHOlfepORvSVADv85/P5w4zMtViGrqRLJMSd7fIFvWjmWGYWJjIOPOmX
         oQYA==
X-Forwarded-Encrypted: i=1; AJvYcCVyeYO9Kjy33Z6d/stL8bAPmFYW98uTAf9XBOHLbCeZlTTcDu5bE+iEpDwiFgc2m4RuQmzdV9Xc7PRQQMtkFf496AgjS/k1PZwm
X-Gm-Message-State: AOJu0YxKsdwLuvz5JCJsz3qHqi6hlrcPauafaD7xsa5uX9aKPKuj9IsA
	uBD6sNkwcYls+Qgh4gMpSKCKstjtUenkdylg9zFWuigsXtQchpVFXy6QOwdrWRQ=
X-Google-Smtp-Source: AGHT+IHhIVY0bWR2O7mz+r0RXXbWCwIx/u27MbcgBTwXx1CRg5LFhEFV+GL/Fw9bSLQnd+XYkgRWkw==
X-Received: by 2002:adf:f285:0:b0:371:888d:7aaa with SMTP id ffacd0b85a97d-371946b1ae9mr5217302f8f.49.1724002128655;
        Sun, 18 Aug 2024 10:28:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a31csm8518541f8f.17.2024.08.18.10.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:28:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: PCI: hisilicon,kirin-pcie: add top-level constraints
Date: Sun, 18 Aug 2024 19:28:41 +0200
Message-ID: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clock-names and reset-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/hisilicon,kirin-pcie.yaml          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index c9f04999c9cf..e863519f3161 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -37,7 +37,8 @@ properties:
     minItems: 3
     maxItems: 4
 
-  clocks: true
+  clocks:
+    maxItems: 5
 
   clock-names:
     items:
-- 
2.43.0


