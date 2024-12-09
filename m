Return-Path: <linux-pci+bounces-17903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C239E8C0D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19496161E36
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C322C6E8;
	Mon,  9 Dec 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxb4sbSl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD621481E;
	Mon,  9 Dec 2024 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728825; cv=none; b=FqvZvlF42NkS+Q1A0qgazZzkDZcPTkJ0rifHVm8+WhX/RcsHuKW/4ti3/6L0h4h2pV6t6Pl5M/WjZwviRMdS5+Rr6kXNYxyunXjrnp/GqoMjxrcuO8uvUZINqC7GsK2mLBwDuUbzuS3x2Etzuy9Bp1ftzABYqIs6mT3ISYpL7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728825; c=relaxed/simple;
	bh=Fr9jJDyazkAxm1yCzozauu1TWkL0T9n7MPOs6LoXAUk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lX48RZvmVfL/GXeMZcFP0oGwX778r6QmAeFSdvr283V+aYcN5DDq9cjsDTx9M0qdR8kqxRwkdgAs/t/0Cp6Ln8zB8FcdrkVFzQn7Lm2cQQDNAb/0TO4bDcfuCRsgH1G9W3OaPK6ggGswFi9jUYIogXgSbCNBoX8kMCemxbDipGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xxb4sbSl; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71deb8054e1so419432a34.3;
        Sun, 08 Dec 2024 23:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728823; x=1734333623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6YQ0GzT2dh6d3+cDp1ybb0EefAGpyFstieUs8RwCKE=;
        b=Xxb4sbSlFRtNkZwxhRFlw4paqiEgYZIWU0E0nOmJsSSg97AfCyAfDgq3gHkp5KIe64
         4oi3hiW7g+ZcDzVGis2NgbzMKMmkxsc1IfTeAfO876m6IhuazyugRsNXuch4xZH3VdB+
         KFbpHePoQbznCdfPhYsrvWnKhzK5yWy+iH0YTu62b5CcZyXqz20CmjKhprQfux2pCfFv
         O1a2bUiquLQ6agGd5PTlG3HSB/CNWVNfVCmiHPzUB0mpOJinWIAXa4+RkhnKgEDCvKws
         7sQ2bhYf0iBRYkNZ9y3I30kY7f14AgxiqaTiNBw4PI+Sl6cn4nadAb96fW7PKRe54mM8
         Q4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728823; x=1734333623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6YQ0GzT2dh6d3+cDp1ybb0EefAGpyFstieUs8RwCKE=;
        b=WsZQIGGm08PKkFNEMv1sPc09KaZVxJ8w+znfkvQi+yH2MgFX423CGwyHRIado+ktAp
         KJCm1HW+iff/AE35ikQjtycgo9wIDpxUsp+BjR0yg3csY58oMTtsCW0S7CG9TJevCQBi
         tOe6g3xSFD/QUJoI7TVzIMSkHBIUdqzKCWwlvcUIFKWmdpLlsZp5MPPRT+N76t8d/NBv
         chpHiXEmq8Oi8Wwx967E9mM/EiAS7UkCcDxYdXD8VKqsxSYhtfLSfLDN5OzFOAF0kuXs
         /2FbXU5TdToA34+9Ct+UNKkCyA2wlz9bvGBMa4HQcDf5NpNZxGZ55DA7P7cCgiSrz9f2
         X61A==
X-Forwarded-Encrypted: i=1; AJvYcCVpcA+zbmp+VzRf1yBsttbmYuNp9N2S3IGPhr6f9DvE0p/nBUR/YkIvE24fZ0AipOCo2ZWwrEXEWEYvJcnL@vger.kernel.org, AJvYcCWzO95QHsqdyRALpE6eW916r2PhE+w0CKCXF5Hf22/G9e/uiUv1nEMI6M1xfeHDfzsa05fnHxx1IKDL@vger.kernel.org, AJvYcCX3eg97wB7bfCF4AtXeUiCLz27cyhODgroFguQJdgZ7Mf4XxQXUJjX2Ao4Ng/c472KJ+sQ1DETB3l5e@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOEQ5B1eLY845iszLE9qB7amEPffXOT9X541lyPPnIekUXwAw
	fNoU0IuDvSNq1xL3rsTH39kCWHlOAYU4ejpjH5u+omARJs/kFqF5
X-Gm-Gg: ASbGncvigNgOup5CQ/irxvbXDX2FL9e5GnhajVdNlsZlszosaQYHY0tdp7/2E5IIUur
	N/lgh6iRN/jSnrYBbwAqOZ2hvYenDcw3sjXu1dEBYP9HDed5FrygCmazKN9KnXg8tYMv7+KG7yR
	H1u6rvxIdxjFNxm1ol/TqC9PORf/BfJycFC/wa+vMqDx6NLN4AnDIKYCpMBrxQRG9xuwlidkmr/
	a1DgTtjk6ztGfIiP1zkK1ok/UdZk2KkvuZNZy4sA3e2MsGKHhTMCn/SfcmJ
X-Google-Smtp-Source: AGHT+IHqaEN/srMd0hN83wcfS1YvS4PEsil1moDw9xoC0lsg+kGLgxp++DQy1DAhEkfiqMtdRGr+qQ==
X-Received: by 2002:a05:6830:610d:b0:71d:5084:3223 with SMTP id 46e09a7af769-71dcf4e5f65mr7035025a34.15.1733728822893;
        Sun, 08 Dec 2024 23:20:22 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dc747d31dsm1973452a34.53.2024.12.08.23.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:20:21 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: kw@linux.com,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	lee@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pbrobinson@gmail.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: [PATCH v2 3/5] dt-bindings: mfd: syscon: Add sg2042 pcie ctrl compatible
Date: Mon,  9 Dec 2024 15:20:14 +0800
Message-Id: <29ceb01afb1838755b4b64ae891f51a5b1bb7716.1733726572.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733726572.git.unicorn_wang@outlook.com>
References: <cover.1733726572.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Document SOPHGO SG2042 compatible for PCIe control registers.
These registers are shared by pcie controller nodes.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index b414de4fa779..afd89aa0ae8b 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -107,6 +107,7 @@ select:
           - rockchip,rk3576-qos
           - rockchip,rk3588-qos
           - rockchip,rv1126-qos
+          - sophgo,sg2042-pcie-ctrl
           - st,spear1340-misc
           - stericsson,nomadik-pmu
           - starfive,jh7100-sysmain
@@ -205,6 +206,7 @@ properties:
           - rockchip,rk3576-qos
           - rockchip,rk3588-qos
           - rockchip,rv1126-qos
+          - sophgo,sg2042-pcie-ctrl
           - st,spear1340-misc
           - stericsson,nomadik-pmu
           - starfive,jh7100-sysmain
-- 
2.34.1


