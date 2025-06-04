Return-Path: <linux-pci+bounces-28952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C0ACDAE3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B991899349
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4E169397;
	Wed,  4 Jun 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3XQlZ5v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349819F101;
	Wed,  4 Jun 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028920; cv=none; b=Clyty9lN6dPbS5RV/MEQOhZhPjK4KKSZKUhZChDq2CKa7T031SpQoq2CMzZMClInBbmfDJ9dwKMGpEbT/xBH3ebUyJxuQ+/g0XtxH4hltxZSisa6E9YFJq6+c7Mp1joogUJNSHaAESIXZ0N7qOVEtWGTe8qUEnwH76+fk+RGvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028920; c=relaxed/simple;
	bh=AIZnosm+FLDSBVgzOE5rLeYDMXQml3oDZavBSAeAVkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gZMbB8JGIFMwO2DDEt/lok8E/k9w9yuBCwVKLCgZXFb49jk4FDIK4VCKTNlLm5BqfXkgOsUj9t2Cw/QwraSdkvB37OXH+gZ6dW66vZZNV3WQI3T+DzT9PcIF+9TBJ060VzFsF0GEV1Liz7gXDJm1cdO/BLoBf4OA9uk9OtUptho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3XQlZ5v; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747fba9f962so663382b3a.0;
        Wed, 04 Jun 2025 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749028918; x=1749633718; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VDgfijz38wfqRmFtK4m0Gqr6eDYnbyCuwTRs5UPI5E=;
        b=J3XQlZ5vHM3kv9oLw4EH+bV08j6jwKmYJ+MPQXUZ45BRYG7YppejOoXBjjm+NdIvFb
         K4ij3/CM2n7dvdI8OSy9DwOMdCGHssjUlyaezPjjsxKAjl5oMQH/cZgLd/x7uvJCrf+C
         Wu32EpBPylRNXHEbSyQLpFBK7gzFALeaRDJDVJkJS/CEG8XouzmDQi47ICc/Ljrn8vVD
         QOA/XyCmm8Vvcb3VblnDJNmJVlI44NT5XSNSj5SGcHx4tCntiaxjfQP99NQ2yX225vQZ
         h00HBlQE61duG+rXgyuKUIqXr3PPIysqxNUvtUXsdpsIN2vJWU/DLnjpiMy75fVQJ6qZ
         IIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028918; x=1749633718;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VDgfijz38wfqRmFtK4m0Gqr6eDYnbyCuwTRs5UPI5E=;
        b=A+gaxpXmrrqTyI62C7LsA+AjlkI8MZDrVSNDA2nZmRJ4M4setieVOZfdstAzkyaWCW
         lRuDSN9kieFjgM1M2vQYvYwagP+Q8eLreUb7uUleaRdmQCZ3f8oAL4hAbasXz/TbOLeq
         op5uhZFbZ9jgMLJ7DbNOv5sQVAP7U+AU84DDven6ZGG9uQaOeTNu9wMn5j77WDK/cyZe
         Fn3E1lYsiQihrduNDbisOKyhBSGfRU9vi8F6n5OuKsYeMeHSHy1cjD05sHbsQORzL3M6
         MtPrmvSFvD6t/4ld4xcvnmJkcDspUYeM7TJS1aQs0UfHU7nm2+bOyAZfOBVlWajKG/NN
         +ExQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9J8COsRs5flYY6BWrsfzda33uK4gbhyvr86OQx0NFnxOV0AbvqB3/xms6ab/dpKxdQcPLtN0bNNqafvg=@vger.kernel.org, AJvYcCVkZ7gFcqaw9jNMEgvhuSIwk4DtcFH082Ji1aBL6XbEIbXrQ9GG9DXUbCEZ7uNJhHLxaQTEz5xoxGrF@vger.kernel.org
X-Gm-Message-State: AOJu0YwwL43sqCeVphyMoeZa2EElMlWh49WomfILf/KoDiyl4WsV1RsG
	5ZzhArf8szUV8YoyXWvddqszJDmtPL92unPN/qhc2MNwYG3ULu8HwaCX
X-Gm-Gg: ASbGncuWO/vgonfT5IBUY9QoGdzTySJTJsVWJqxGCXmwcUGw7SvRRiu2DvsOjGaKh3O
	SzRLNXKJbZajjZf4v0Z2eM2Rx3yn7xkHe1ri/FYwPBjoban67Z7sQiebYL1o0K4ZAzImY91K/jz
	sG/Y8acrH29/JLP76L0ct9MCaZG926aEcx6o9MOyF0EzDjDApWJNupwU+BOijSmhjlbfYC5xGgn
	P9MwL7joxcA7dhf9ya7DvFrCQ81AOC1aEbNz7ElScVSmGhH0uCeUFcaR4xUwDoe8Y8Qjoq6YJZK
	Q48UYhOzV5hj4LqtMJ6BuNxRxi4N4+IRvcmhqg==
X-Google-Smtp-Source: AGHT+IE9lIxZe52g46OWQp8Lw4qB+x9M66i/HCShonwVogndogjTY9y2HrMxF8CUQxE3BdFwz/9X5w==
X-Received: by 2002:a05:6a00:318e:b0:746:1c67:f6cb with SMTP id d2e1a72fcca58-747fdfc9152mr6296211b3a.5.1749028918431;
        Wed, 04 Jun 2025 02:21:58 -0700 (PDT)
Received: from geday ([2804:7f2:800b:6be::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed34fdsm10722510b3a.75.2025.06.04.02.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:21:57 -0700 (PDT)
Date: Wed, 4 Jun 2025 06:21:52 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] arm64: dts: rockchip: drop PCIe 3v3 always-on and
 boot-on
Message-ID: <aEAQMHAQU3VgTghK@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Example commit of needed dropping of regulator always-on/boot-on
declarations to make sure quirky devices known to not be working
on RK3399 are able to enumerate on second try without
assertion/deassertion of PERST# in-band PCIe reset signal.

One example only, to avoid patch-bomb.

---
 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 8ce7cee92af0..d31fd3d34cda 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -25,8 +25,6 @@ vcc3v3_pcie: regulator-vcc-pcie {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie_pwr>;
 		regulator-name = "vcc3v3_pcie";
-		regulator-always-on;
-		regulator-boot-on;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-- 
2.49.0


