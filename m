Return-Path: <linux-pci+bounces-40728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6282FC485FA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6C524F0E45
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451BF2DCBE6;
	Mon, 10 Nov 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsMUlAY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1D2DAFAA
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796026; cv=none; b=PFo/lUrEawSuGY7xFyUViOrTQV0LDmu9MYBFRvb7U5GTWVG5PZkd6XprXTKl/3G6v70Sl7aV+xlaw4qe/T+YJoZX+EltAt+taU7Gf+3/KvzQViT/kXgZI4UNIl4JhA6zFGk1XmKX+69H2fWhqUx87+K8alHv41+vKK1ouZfiE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796026; c=relaxed/simple;
	bh=DtKMJowc8zPPK7iC/rmKldEQoigsxp57cIpDSZGk6rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcBBxvvV6t+n0VMOctFbZKhFwpA3WkQCNsjZlSBMiK2wt2lMoWggK/OhaTYOaIbK4deQV7nm5JeT7OvYjCT9GVwmqf7Lr9AzghEyu68u6J4jMibgCXCCr9jP5Fj8RHgQVcfP0Ew/zkir8+9BOlJiSzkEgWYSU7/GB0pOhZGY/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsMUlAY/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632b0621so22647675e9.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762796022; x=1763400822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWzPWemnSbElAjabzmde4Itt9ehqptnppmUVmOqIRpI=;
        b=AsMUlAY/hzDdJcNbRA+g8fhdi9DayB4GJGOQfRbw6vcCCPW5JShGEQoDEMsIKRaeaf
         g5CkVgPhf3c1RzAPReaKMXQhpnEoty3QFg5nahPOa6rtOPmIFWMeIJ0zJc4NovYb+rZd
         RiJxSrZZclsU5+aRFE364NuciRvCVwmMBNTw6EERA0RKJZUgxQ5Egd9klVTxgX8rZEq7
         2ANxxAYN/2SmEeID2VmiJUiFNtgEnRzygyOK+bc+Q7FBPqk8OHEjyjltk3cJIoP1Gwmp
         Fun62+q64TzzSZk1F8TuuietOOPlfUh8DMGBZlZXymr+qqKEo+myFrfwCRtR6pWtGY9L
         svSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796022; x=1763400822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWzPWemnSbElAjabzmde4Itt9ehqptnppmUVmOqIRpI=;
        b=liMhXZ/brJRLxvB+nvp2kyK88Hi1Y6m7f5Y+bzj/NkdIQm1oKysh0umwFdVa+NtA/e
         8bJ41k1f3Dqjya1GzdFNwXklFde6HaNx3uGw70g4zuRxHev2alxAWAMncIIHvaHFvu7r
         d2vd0c09CPshBd3pffT8NXqdvdzpN9My8nGpG+Wn15Fj8yTssaYqgxAPkkbH913liEeN
         rpTRgK2KKkF8PSf9qWpSlhOqn1GAB6P8SNxnm0RAo1gWX9UiF+otlVT/XqM7Bsru7vt5
         VocAoo8hC24/nuga6X9RUJS2/YpYwrJ8kNa3oD8ST/gGSBo2DYPDZYYRL3BzssmbMTh1
         bDvA==
X-Forwarded-Encrypted: i=1; AJvYcCXkEZMP28shvhx5h9Bv0DBTuaJ9lIL68+BWUherK6PguT7tmktAKZGf0up1E7481oxchjFeN4cyuQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ur9h5YUPuPlvon5xBGX3I918UeT1isENhFZXqE7F2a0CjF3t
	J03/qiU+ic6VSR7XW4kUTdy4C5fSEFXTe0K10f1i1h6Jzqiv/Fk4QLiZn0kkaDy67BU=
X-Gm-Gg: ASbGncvTNP8k03AltJYvyrdJSlzXiFZhr7i6M/xSgyK9FVQerqTMil1OA6ULJ5+6J69
	lIQu1YQm+8iz1d0oqDxXUcC8f5sOXT1qVLDctwsPTgtNt0xWzSdiXbiRU4MF1Ozcrbezz7q1HUa
	FnEPfPmukmkGmA0qCHij2En40Om2B9zsrSK+9gHYcMlBHd4wV2rnfODfGPR+ygpdwzILWUiqlKA
	7xAq3lLor5nC8gFMccu2OJJGDS98yp4TUH7YfrV/kfWfaBlZuRt+jwbNc0EOBETdEsdyqtWX/CM
	EI7Pw03nuGwaXvQjRSHHcqsPz9ygtmIQLqeAEi+9G7onjDOm639rZanqXFRbdNj+9BrEnceMdG+
	6gSj4o4/Rl09bbkYJywxmZJmzivtl4N17qxzOYYvgWJQCMfmOckESxOITZcg5+SpOG/ox/arspm
	Hg8GEOJWA5dI3BIe/Z0yg=
X-Google-Smtp-Source: AGHT+IFG+zeZs8i0HcOK4EFCqMFXkt25jlhJO9xhRAVgjZV+KV4HEsFl6cEM5lLjaVjHEaqSmZ4BKg==
X-Received: by 2002:a05:600c:530f:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-47773465f2amr89513515e9.7.1762796022324;
        Mon, 10 Nov 2025 09:33:42 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d5ec:666a:8d59:87fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774df2d80sm140111375e9.14.2025.11.10.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:33:40 -0800 (PST)
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
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 4/4 v4] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Date: Mon, 10 Nov 2025 18:33:34 +0100
Message-ID: <20251110173334.234303-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110173334.234303-1-vincent.guittot@linaro.org>
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
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
index ddecf1ef3bed..922ebd4787fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3136,6 +3136,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
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


