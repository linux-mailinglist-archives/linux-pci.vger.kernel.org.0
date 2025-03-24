Return-Path: <linux-pci+bounces-24522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55667A6DA5E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 13:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1411891CEC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81725F978;
	Mon, 24 Mar 2025 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9816ev+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EB25F96D
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820733; cv=none; b=kGFkv3uWXfHQWGxOg9p+Jp6BkK6j9wvf+mGmR8dZyLw5m+ZvjG7+xXhUF5zRxRwt3cKhNybiQU9Igfi8hnwvBRlBYvW8owc0kdGGCLOhyN9SjaxB8s09W+ol68okN48FkwyfxgXkCiV/2S2dYEdS/q3RsGMpH8v7n922Yw5Y86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820733; c=relaxed/simple;
	bh=i1xTXb/kURab0z/vsFoOuKtPU1o69hNH5a43i79jDDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaPYj0VNQ6AuNG5ZZGRv9TvtcfkjM1T0Vm8GTMaxP9pDeMxUWg60iVVzG/1qIewlFDhL+wyCFv/B8yViN8iO4ktQcs8Cxvo4rR7X+83QvAgwitlqVNVipQlPe4joC2bJiIpn+Ymmbf6+AMxwVZJd097Qi3uNjqeucLJC3hE2+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V9816ev+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912622c9c0so486982f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820729; x=1743425529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjmaPyBHSXf8PuBe3jKy6bt1Qi4MPOA66CdtkxcGuKQ=;
        b=V9816ev+iIvP8PJoHQNsZbn/DnulgrHyK/jP3X0O5p36Y2wUgG75gl6GhVCs+ZkQ2y
         8seId9KmtMzf8yBlPhLob1EMCBTjPJ/EFasFr72VAdgDwzlgCI6teCNgiX+Nb2DWSrm6
         R9Lo/oGb8UqbawMFsU1n4RblxlNDrQMCRe2aXag0ZwoZpUm/hxMG8f0YPzNPcatmrWu8
         tfuGIDcoj8m5Ttm8c/JqRiBvzMUDIOSbbVyG6QgnXag7zlxX4j2kj9vh8BY+uOidnvCb
         3+0Jf7InItCMEXrllWXwmFb984TT4TdwNmr7q01xz2ZLLSuwo7toAhdctAmjSykskuIz
         9t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820729; x=1743425529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjmaPyBHSXf8PuBe3jKy6bt1Qi4MPOA66CdtkxcGuKQ=;
        b=LgsHBuyueRSqCFMqEgHmFyuLTv+UuL4uKX4sxzf13SKjjg5AD8x9f3KjphBKEG6Egb
         kGJ/PExwmlmC6l4gEaqXwTwiQsPqdtPvkdJohEEpOUpo3vXFuoT1uVWgR4HVxvSrHitx
         XBubENR/ETaQWKN/lffflI/CQCa/FhMrVlpPtd6q10ZJBWd18Y9lh/zJtgAjq04ZcXk7
         kpH5L3wfsv6x1KTryA8foMFp5x72/4vkq38K113AtedKQYqD5a+rvb1OAJBm607mpXh3
         7FW5s0jLU7h/LhE8HSanGPP8xXUwyzRHmgeRBwFfrrjnloIsesOsc2+15EPszmX1fflW
         kRsA==
X-Forwarded-Encrypted: i=1; AJvYcCW6dVd8nwwCHwxAXXoPCGgjxnWvPBjItxS0A7HmvxdDWrQVn3H1Am6o7YF4sfPuBdR5e0PXxdUW8Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXG7qDXGdU3P2E2yOFiLDwgJIDzmaPExFa3iSkfE4SN4zThCej
	QCkLIClF+vCEYiUNUAWgKKIMi1YLppqmDpQX8gMO3UXJbGbmNasNNozK6fypQYA=
X-Gm-Gg: ASbGncsAMMAk20GUovWvX9CmJkV7+MnBPzhzeSDSNIxDdiHrpuO7gnfl+j3ckAH8frK
	hVwJcnyR4vl4ZW6Xa8qaGfk+ePaMuVxaQs+0ZB6KN6U77Mwh9qmDYE1OiQnCaK9DJpd6gg57y6G
	LtjkDxFVzp0Zhc9OxOvINjyr+nJLh/Kd998+yBOANxR+uDhxwA76EGAWbo7CBrWzIZb7k4u6ri2
	pcZXqr560TvS7QQ6aTzp/xBtif4APPBi9zfICclOHJCGnvfXOqs/LvTXHMPXfxxiHfvHdZiKifz
	2WjqxL5gWsdaqPc9tgptq+64AkC+v7by70djUllbndEOo7f29cgO0rw4rg==
X-Google-Smtp-Source: AGHT+IEqvip+CcbtHMcAP3ZwBIgJtEmf4kkkBavjhgyRCafFGFSCWjHrpx6YQVQWOVUsbGUmdeCJag==
X-Received: by 2002:a05:6000:2c8:b0:391:320d:95de with SMTP id ffacd0b85a97d-3997f8fd165mr4483091f8f.4.1742820729282;
        Mon, 24 Mar 2025 05:52:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd2704bsm118704565e9.18.2025.03.24.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:52:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: PCI: sifive,fu740-pcie: Fix include placement in DTS example
Date: Mon, 24 Mar 2025 13:52:02 +0100
Message-ID: <20250324125202.81986-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
References: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style and common logic dictates that headers should not be
included in device nodes.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index 844fc7142302..d35ff807936b 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -81,10 +81,10 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/sifive-fu740-prci.h>
     bus {
         #address-cells = <2>;
         #size-cells = <2>;
-        #include <dt-bindings/clock/sifive-fu740-prci.h>
 
         pcie@e00000000 {
             compatible = "sifive,fu740-pcie";
-- 
2.43.0


