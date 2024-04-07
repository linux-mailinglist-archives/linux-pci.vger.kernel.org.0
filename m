Return-Path: <linux-pci+bounces-5836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39D89B05E
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 12:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10151F20FC6
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789417999;
	Sun,  7 Apr 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eue9NH8s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3C1DA4C
	for <linux-pci@vger.kernel.org>; Sun,  7 Apr 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712485214; cv=none; b=WHbGgBO7uskn4OakW/Kg9H5SEXamN8WTYK0lRsmMbAamgsvtYYU1WQHcxl35n/m/PtaW7BTSoIUxdChNDXbyZbl3dYm5bDL7tmkaRpfdzprkC2kpugU3p/yOnHG11J3DuOpGmsUk3FgYRGZ7+5QNUCiiIBFbROQnRyt2n+OalnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712485214; c=relaxed/simple;
	bh=0kmWDD3YYQkd6GkpjXB8DvXQjeaBMd22PRWNSrOstXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXs+Y/DXICz80l1MaebMhIB3L97BGxb8tfDGibXPbvyXvD9fMwc6rQav79Elx3Kg4NrenKQpYAGg+snrfOohavwXEQa8xmZzZcvOhkkXQFGoOrI1hOmnPeKNZRqmFthSRmHjv7oFU+fER+/th+hRNKX/OKjiA7Y6CYUZOE/36bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eue9NH8s; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so32157321fa.3
        for <linux-pci@vger.kernel.org>; Sun, 07 Apr 2024 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712485211; x=1713090011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm0CQFK2zv7ApnNYT3L03j1/+cA4iy8BnGCrLtvzqTo=;
        b=eue9NH8sDFKIjYTc8aQsx3naxgv2qXls73o2w3pde1mEzn2N9exBJ9TAmUt7n1vuVy
         0zxb793t7Z33qggAR9j7uChCwraPPTvD95KgGtcGWZOvM4KqvX2YJKwyd7oR6335Oe6x
         7suucrZ5H2V+A/1f/ECkkLmna0qdCNKe49q5JH4igT0DcCXxMpZgw3MZI7dd8gPOr+4V
         EFVK29a4OBdV8QhB+LriE6QVBGIAswrI68I4Mwtd2F2W5SsoUh3m81Qnu6/0zyAq/abL
         q2JJpA5jYqlBiYydb4GhQTnG6/+Lj4MFc08pZ7Bg8rNijyEzyvj92oDcea/Cq7p1UAkZ
         YwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712485211; x=1713090011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm0CQFK2zv7ApnNYT3L03j1/+cA4iy8BnGCrLtvzqTo=;
        b=q6btZ1jR8fCFazTsZPNJs9c7dD8aGcGJGt1M0ia4d7mrpyWHShIkYkavb/mK2z1bXF
         txdd8cXhje6Sdmm/NbvecSFtZoP151yoecpzmJsYie0y3WtjnOrvnV5rjQiBFm6kP863
         zfLY7UM2tk1ixSPPWYNWz+hLdf5zkPKLoxX3g6w30tPPC+38wefBabUb565TI6zqw2OF
         QAcYAeDyFld0KDkgQ4pk6/h5pnmi8QAAtWCBMpAvRWeL6ZRgz2bDaXEVk9aQNzL2uWYe
         ieNnSicsksTuF/qtzhcFSuGHqkXigKSd0+X3rhn/4C1KnzKzPdIAhIGOenRV6epCUYTz
         hiqg==
X-Forwarded-Encrypted: i=1; AJvYcCXFmtW+vtamPzT+yqq2bITSemoCLBQ3BntKe+OJN3vfzi55sn/ti4ciVvJixYnyxLSbCohze+TMvjiVhWqBUZcQ0D/B9sd5QJxL
X-Gm-Message-State: AOJu0YwXJTEcZd63XOtv71rrAN1vWEIVOLohLCB+h9bphgGQk0P/aLvN
	h6JBsMDK2dg++IsWBAiVfBOUTpbtBi+EnKXTVp/hSOvoWVghM7g6cwX/xK7UMQ8=
X-Google-Smtp-Source: AGHT+IEgAjSogfT+sOyuptAU4z+kLewM7d8oyVlExMI6z9adAX4hTN2911WGxmZGRduXlgbWJAsiIQ==
X-Received: by 2002:a2e:9045:0:b0:2d8:681:dc9e with SMTP id n5-20020a2e9045000000b002d80681dc9emr3876638ljg.41.1712485211048;
        Sun, 07 Apr 2024 03:20:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d58e5000000b0033ec9ddc638sm6354395wrd.31.2024.04.07.03.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 03:20:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Will Deacon <will@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: PCI: mediatek,mt7621: add missing child node reg
Date: Sun,  7 Apr 2024 12:19:59 +0200
Message-Id: <20240407102000.37213-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org>
References: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT7621 PCI host bridge has children which apparently are also PCI host
bridges, at least that's what the binding suggest.  The children have
"reg" property, but do not explicitly define it.  Instead they rely on
pci-bus.yaml schema, but that one has "reg" without any constraints.

Define the "reg" for the children, so the binding will be more specific
and later will allow dropping reference to deprecated pci-bus.yaml
schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
index e63e6458cea8..61d027239910 100644
--- a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
@@ -36,6 +36,9 @@ patternProperties:
     $ref: /schemas/pci/pci-bus.yaml#
 
     properties:
+      reg:
+        maxItems: 1
+
       resets:
         maxItems: 1
 
-- 
2.34.1


