Return-Path: <linux-pci+bounces-41515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87429C6A85E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 17:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71B424F4406
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1813730CD;
	Tue, 18 Nov 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nRGm5YFY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAD36A008
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481787; cv=none; b=j3RkMJ0EVaZfQka0dtMNp6ze/B6bDPoFc4Vs72h8YwAPpP6IpPAw7TYUBEAw+WQn0KOGswKKcuK9TgO3oNGd6PtlBAB9gPNwDK6149bPTcQzCxPUMjQF0Ds05oaGZMmv3EA9PCp7LxQUUsvzOFyxNuCNPBYZofzpILbkGvDFCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481787; c=relaxed/simple;
	bh=8CNzFpWGHJiJ/kMik9XkodfqnXW6wo433Z1B1kwxkag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kl0cgjsydXLrt4XdVLfwRUFgB10B+9vg1yBldzoyQCGylvaWwkYhiL+UoYlKnhIKXwp9xPckuZPzGFs8K3zqioqqCfAAkBg+SznVxgtCT3gqHOmWDKjA5s3OYw2fmofNHJYtjPb2kqnrHTXdq7uJtTetppfk7CTwO15D3YTqfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nRGm5YFY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so26682255e9.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763481783; x=1764086583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA1YZwkpqBYNCNgFaNMq2uv3rKscqjzMZ5GFDmRce68=;
        b=nRGm5YFYvRAeiTY9VKkN75pX3nUuSratpLyUvdD+nAQqKQdGLv/K6ViaEDb6xIMAGs
         RQlqwRuyCTpztHvSpgtS9RtnLECP/sU1HeB/cHXPEm1EgMzZaiGVl8dUld+hhw6ePhiZ
         yZ922aTehucxcElz9HsCukBTAUtyYhmOhlnzM/v6PrPlU6mK0tyAfDeYgOLZq8N53in7
         sssnaaXzrBWkg8K7N5+9AxfH/LlG80aRCZk3ZaZT9zM17YwT/zSXS2egORSnaizZniRJ
         LAI9/CWRm22EtcACjSJmEwi0bji43TuCnCh/TRPnTiLc8gL94qhIRXg4Dwl+3EpKpiHI
         WzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481783; x=1764086583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tA1YZwkpqBYNCNgFaNMq2uv3rKscqjzMZ5GFDmRce68=;
        b=qlYoiIuISGQPEgvQu9FTt4tV4ppsprPJXKFEAvST3C7nTfJ7liaW9sJdvTo1A6LrHz
         Ux1QZJ2uZ5Qt30e1IcHEecZ1NFF6iIIp9G+wW0uCUvbzZBwMMPIiRq52Lo94SeeJ402X
         qMUCHpsP3AQw+hmBJP5sYbYCgYASB3umIZDMK0qPgL+lxr1ebQmiW5RX0ioLofpzncrF
         +y1LkSr/H9tmwvCurcuO5V2llTOvBu3yeZBbf23eZHkRZg4I5SOdEPM9KsPfXNfstibz
         zn0Xfryd0uhZit+ZktNh/S9lll2n23erOGIJ7eMhKyLnL7sO7ElGBWzVoofhS12ZYm63
         MxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkQQey9tFH1j2HL9ld2Xh/XbnnasbiwpEy/CuqpxuX/DV8if+6VFkVQlFy8H4vgodwLIbAWsW/0XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpq65LTBZOpdq7S3MXL1e4moouem7d5tOnOuYqAp0oo77emguf
	NAnFKx3KkRd/4DyD0bWiqyxIN8n4v3DLvfay2f3s1u4DY/IMnpSfv2BjwEk9v8Sj+ow=
X-Gm-Gg: ASbGnctpBmju32Yn6lqfViGLUddlyFg9QSVwJljM4S3BNrKoZiEN9lK78tkvBZNGg08
	XpC2y3wNfG6eRDW+TTmYhvvToFDBv0i2JberuUMZRD/PfW2raW+QeX3CezjiXBZnLlMUU8PPpa/
	5Ux6caj8W569xsbyW8+bYDFOVZkYAxFGmkzfbAswkDU427GG1ntKTE8VfsThBvjEOXJWARrMsnJ
	YEzc7k557kZ6kxQS8UqRdaJ0OFaCd4TNa7Hh/5KEc+RL9V/FJKtGzYXbP6aRMJo9bf4Zg0Lm5oM
	ov+TV8dCUn/8Gr8HDruFVmgzJ5Yb/NqxcmrPDVyQGqHHX8bFLSy6kqobYxMaSnolgl4mMZ1PjCC
	bnkQy6qMJJ4m9u7G/muHIka0xN8LOadDiNyVm00HEXADmO53wLAOOXdI9WVdf6LYVEpUXimUEj8
	fuTx18TizdqjOyz4ClDkU=
X-Google-Smtp-Source: AGHT+IHP42lpaoxGDvnSTeMKhUhW83P2qJNjoVXFLokLHe+fGU/P+jnllwRuJQY+oQ4sFZakhTOjHg==
X-Received: by 2002:a05:600c:4714:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-4778fea8d93mr142436175e9.26.1763481783366;
        Tue, 18 Nov 2025 08:03:03 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:76db:cf5c:2806:ec0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779fc42f25sm171954575e9.6.2025.11.18.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:03:00 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 4/4 v5] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Date: Tue, 18 Nov 2025 17:02:38 +0100
Message-ID: <20251118160238.26265-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118160238.26265-1-vincent.guittot@linaro.org>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new entry for S32G PCIe driver.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64b94e6b5a9..bec5d5792a5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
 F:	drivers/pinctrl/nxp/
 F:	drivers/rtc/rtc-s32g.c
 
+ARM/NXP S32G PCIE CONTROLLER DRIVER
+M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
+L:	imx@lists.linux.dev
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-nxp-s32g*
+
 ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
 M:	Jan Petrous <jan.petrous@oss.nxp.com>
 R:	s32@nxp.com
-- 
2.43.0


