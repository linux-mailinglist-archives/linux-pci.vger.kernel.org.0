Return-Path: <linux-pci+bounces-6929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAB08B84F5
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C250B2287A
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28014D11B;
	Wed,  1 May 2024 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEMbBxmM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E04C60B;
	Wed,  1 May 2024 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537748; cv=none; b=G49Vxx+FpVxl1IWvOM//VofwAcSaPWYRKGOUYFCl8vzOArsNhhpXs74vz9dZU0i1Tu2r9h3qJXa7Cm+/4lC2C2oAn5k9F2yzDyqRIYex9WhkxsQz7mGWBWQBCiYa0rrsHPfAYq69JvJB3lY1ejE0NsdqymOrQjVjj1qxsBHmqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537748; c=relaxed/simple;
	bh=l8wNOtYhNTub8tqUC0hD6JfTNva6XfYe64dArOyPXTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZnbLgmbV1CwHOzLUuHMo1/LqT6wQpz0TUiVueOq3ZOQY3AuDdxQ+wLnfG5gw7+pUcG7unVe4Tp32VtIdLqYWvHIEPg14Aa+t1Jop1DvXHCNd8uY9EFEC1JIBxAws+7AM2236VqhxkiAPX9L0bGPXw//k/77pdaueJW95Nkopjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEMbBxmM; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5acb90b2a82so4385005eaf.0;
        Tue, 30 Apr 2024 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537746; x=1715142546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghcu5svxDDMwf9Ya6V/1d6nG/9vm8dM7H011zLAoFaA=;
        b=VEMbBxmMylie1ihK1lDkMg//yHOZjXINjDPOKhimRZ6jVGgB1gqyGmI0syZOwdWK67
         TUtdCmfLLeYT3THcGnUZDnfh0AYk0emLnoQ+AXnJivDw0WqEtgRDhsfQE5vsLUTMIy9G
         QSOhof7zJE6ybpfIdYNV2wXkppzsera/LrTE4iM/ZlSPNOl+UcoFn3U21p1hBvl+NwG/
         mexJsqdW2JTKeCER/35Cr2ojfnd5OwB0+tNjfDTlJxPS/iHd0deE5U8lGC6Bqz8jKcJT
         3EZFFLT3xHnQHGwtnUjCLOVmG3vx1kzoJdPcVqwZo2jkvov1j17c3qRZZPLtqkP6dhfw
         HScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537746; x=1715142546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghcu5svxDDMwf9Ya6V/1d6nG/9vm8dM7H011zLAoFaA=;
        b=DvwoV/bu8860mjIwMq8UIOPZV3+LM11lL0YuOekQRC7Ajn3tflsPXwP1mwYNgNw81I
         OnXRR6KK12+yjigvCLucGCXI5XNh/y2LSiBxyz6QQHC5v4vIgaOAjYYmOQv2dx/6s68H
         Pte2Wg+SR1hwYWUgpe5a9eUGQHlhuqEB4p0yoMmjzUGm3q0lPgiDnHPq5aORc04rLOp8
         wNl9g7N4ZEdreDWmZ/02Gs+NNJoIxk5LmMKCT3HnT393OTLSMTJx+dEUk4hJ2K0/3p7W
         2KjNjBpntZEfN4aPegvTO9q0wZzLoYIZx6KtmCkQe2hYZ2jnM/Cp2xht3fccdzYH3WyL
         yPnA==
X-Forwarded-Encrypted: i=1; AJvYcCV4eQbXrmCSU7HdG/0Lyuyau5ov3bazEWVBUG93Cjbndt2p9n+aipxYHGS6S4WMo84WKhasisWDUhsMsZ3v4nMEaxRbt2z0j0lypbjbwhI50okI3Pjt7CZntTliWp00/7SSXk7dz3ncuV1PmcbTCL1vblN6qsDDJ4bwXhJh4flayzCtD37nMcnOEaHKiWHUJR0vcOGwH1Xzierc5/19VrP7NWgLmbexFrWKZqY6uMH7JK1u/9HTBphjTxeuqpM=
X-Gm-Message-State: AOJu0YwtPegj1OohG9mOzvK3B+GTBJa2jQ7lA45Ukk/Nx2FLN9ZJ1r6T
	SEwmkEGPqylh26BxQZnm/rVYftCAlLjtPI3i6iHjnynjmYccrC0d
X-Google-Smtp-Source: AGHT+IGuOws9D5HywIMomsEHBpmwNMBHOiAd1WrLlD8IpVNqouORPEssFMM4SDAMdkQm51ay6SbDEg==
X-Received: by 2002:a05:6870:1f08:b0:22e:d541:7eb5 with SMTP id pd8-20020a0568701f0800b0022ed5417eb5mr1667093oab.38.1714537746449;
        Tue, 30 Apr 2024 21:29:06 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id do26-20020a0568300e1a00b006ed6dc9fd54sm2719058otb.25.2024.04.30.21.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:29:05 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v4 RESEND 6/8] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
Date: Tue, 30 Apr 2024 23:28:45 -0500
Message-Id: <20240501042847.1545145-7-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ9574 gen3x2 PHY is very similar to IPQ6018. It requires the
same parameters as IPQ6018. Add a new compatible string for this PHY.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 .../devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 634cec5d57ea..8a8e23282d1c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
+      - qcom,ipq9574-qmp-gen3x2-pcie-phy
 
   reg:
     items:
-- 
2.40.1


