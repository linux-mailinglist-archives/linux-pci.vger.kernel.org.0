Return-Path: <linux-pci+bounces-36033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7FB550B3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F701C828BB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9633148D5;
	Fri, 12 Sep 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rphKZ3ja"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3C30FC0B
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686490; cv=none; b=k6FvM7SVzhFlVzcyKf0xk3JcIGNQXR6dtLcRBSLN56I9p8tnXQz+TbekOt3q2am8u7zotTGDkxk/KR5NPWw/l1XWERakKW/BNn7XxqfxX8S/Or5/Pc9lYzcyHRUR81OEyom9UFQsGoUJQ3KcXUk27jXFyPoGBVbyVlFTurgCbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686490; c=relaxed/simple;
	bh=Sx4qNTflZvWx6Pe1Zu0lV/BCv5K0fKMX8u+tZdVvrdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYWCQjiK5JpF5K8j6+iRzV1uoCmImH61ee3eEm2Yqcw5tN5Lij5D2DV2mg++ea6xX85Q4O6DYIhvAiTgW4Ia3JjerdTHZvIUGfQRFLXx17xCFAzTmJu9edKzsbVDiOW/glpmdErY58u6FtSRz4D8Wx7iwGAjPmrRPcnkKoTNuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rphKZ3ja; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3dae49b1293so1076452f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686486; x=1758291286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYYU1SORSnF86QOoLhacy3DzKZyj7/fWijxhLZdd8eA=;
        b=rphKZ3ja+FJcO2sswf6k2cMb+CwbbITompdmCIpYyd7AbNYQcv6BiBZeHWcGENojSI
         4n9EvZfvNhg9pQmzwr8+iqk25LgJMsuNTMpA+EU8dAnHc7mwKsoCAtEtqS1bb7S2KXZq
         WnEAG1+mvgvTQTVdUmasBFc159aYp084T/vBihByvM7LGNxNwXrMHezQogNAzWtSTcZm
         PO+XmNzc+uzdGsR+9/Yr6tUTUn+R2sQJbdF25x0J2aHkSiq0QROY+tOUGmeAWI3KHC67
         RSatsQSeXAq7gpwwihIMI+WUwGbO6thac80jFIvI4EsuDMsZjs/55Ijm5LArmIkFKWKj
         E1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686486; x=1758291286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYYU1SORSnF86QOoLhacy3DzKZyj7/fWijxhLZdd8eA=;
        b=KsYJPC2t7SIySF5xFquBOAvaq4XmlRzojjHIJt5WYEvR3yOsnzhPSy3L3kfKJAfgQ2
         Kz+V8jJevtDySohtFjJ7/3KfLJRNKXMeITL24ziod8qX7EBMmy2U4sXPGDO3l9TFUpQx
         pYMTtNztI4AAsPeHKm4smO5r0DSag/YDe71oGXzKFpQp2is6dY3bUgx8OcSB+d/yufa7
         DrZrv6/TeSoQFTEr+8yop0Igx0NALWXWCrmyr2ktDksiWWDaiOptB6PECtbggRlhnvxb
         111rKQMyAOW6iT0suNG6vsZRKvb/ds3eysJPaEh0yi6aJ22+MSAJy+PfmYykCTUUAPjB
         cRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9sdI/fD+oq8BAme7bT6nBgnrCjovVa9dD0GUfQBtS0/tkjCWgk+gB4oNmmd+/tFwW0omA34Js9bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIu8AEwvbF2PU0jiwR429YNERt2vcOEVeQZxJJMGtFW8pMUlN
	7qh3V0sq+PFZ1P26NJOrejTfS18FeetxNEV94vogfOSJERyO1IbOJ3lxbTnBaIl9GPw=
X-Gm-Gg: ASbGnctMxUuyiRsjl7xpHSM0ue8FsFRg795RtyPQMBsPdsdEsWEIu39BeLkg1AMmCFs
	nfjUp4T/RT/ZYSRVW1K11/7rPvctKDMkvWvxthG7zwZOPW28n6vTLAk/p9GXtvDh1Ia3jhXGPNG
	Ecz0mBRWGIueDzmYOo7P5/94zinznORxa4tZ/P9GEwBJxKza0jLHP8e3U1aHSP8CmLaZqP7NlK4
	lbMSYFs8QDFUsdUdhbypeQCxTMVhc/f5EvFSayuBh1EdOzhbAId4r5RMf/t6nLrZiuTaB5GOyJH
	kRxDnRH/4ZQ5Kl7VeRPX3Xwx2WFe5/8qU5pgx8nCbmC0f5IXZ/9UjiehVgfHLcc/fyewaYNqYWp
	1FB+Vc/Um598xbmDnSZJsdIY2kl1R+Pc=
X-Google-Smtp-Source: AGHT+IELwPDPxYCpFOkmaAqs6QS4n+6xPwFX8EClQCkLmWQOaqKB/UsohwY3InyXz3cWYcEWRVaTyg==
X-Received: by 2002:a05:6000:178c:b0:3de:78c8:120c with SMTP id ffacd0b85a97d-3e765a139bdmr2764778f8f.38.1757686485677;
        Fri, 12 Sep 2025 07:14:45 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:40ce:250c:1a13:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm6680739f8f.30.2025.09.12.07.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:14:44 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
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
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Date: Fri, 12 Sep 2025 16:14:36 +0200
Message-ID: <20250912141436.2347852-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912141436.2347852-1-vincent.guittot@linaro.org>
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the s32g PCIe driver under the ARM/NXP S32G ARCHITECTURE entry.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..e93ab4202232 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3086,10 +3086,13 @@ R:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
 R:	NXP S32 Linux Team <s32@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
 F:	Documentation/devicetree/bindings/rtc/nxp,s32g-rtc.yaml
 F:	arch/arm64/boot/dts/freescale/s32g*.dts*
+F:	drivers/pci/controller/dwc/pci-s32g*
 F:	drivers/pinctrl/nxp/
 F:	drivers/rtc/rtc-s32g.c
+F:	include/linux/pcie/nxp-s32g-pcie-phy-submode.h
 
 ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
 M:	Jan Petrous <jan.petrous@oss.nxp.com>
-- 
2.43.0


