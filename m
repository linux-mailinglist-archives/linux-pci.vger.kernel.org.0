Return-Path: <linux-pci+bounces-19649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7DA0A9AB
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2025 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19AD1885B54
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2025 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877AA1B6D0B;
	Sun, 12 Jan 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plXFvkcA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6921B6CF0
	for <linux-pci@vger.kernel.org>; Sun, 12 Jan 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736689153; cv=none; b=bWQMxFlskpnJTEsuTm+5R59SnYEN1VB2/0uPmgwAK5ZvLo/1V+ob6Ew6iSjOXTn8XS/kVRxNZdVFnTUL1NgTHfKrhH3X2M0p3mxGq7l3otyL33VnkJCp6h85qM+dS7MmZuKG/jjqZxOHVEuA+DfMRU4cS8X1O1xk4bPAgTYSPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736689153; c=relaxed/simple;
	bh=x+i17n32J9BE3xJWGZWzaweD1AZbhL+oqQjbrPfkdJw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OOH9O6q4//DPDBtaKIOpeXg4QQFIfIgqTFdEkZwkB8X94Jv1n1CpxhXe+GLmfxeSsYH5eXugqMg9KGtxDLRViR+fEozAqxWWB2uKNQy0tCAlPi/lalzQnFLu7G2j/9/F0ay/iaPG1KGdZIHg/Oc7BwK+9gruJmim+xF/SmlUHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=plXFvkcA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361aa6e517so4502015e9.2
        for <linux-pci@vger.kernel.org>; Sun, 12 Jan 2025 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736689150; x=1737293950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7Ty18ut1e9jMhl/AkSFuE2MdVzmvveKnbQmIojHQTU=;
        b=plXFvkcAr08Itb+/GUOkY8J0o8txl5R0vmZscL5/TEdvj3rsLTBzzI8yjUQNbIMD5w
         kpzEOOR/dTZO9+amLQZOleZwUPlpl3353len9xsaZegznCQgJcsOWNDHw8ZpLiwF6gPE
         dYZvTKL2L4JTHUChX63CA94+EOecNwPkwbaspupDiyvk8z/wL9EP8mNSL74RT4fDh12g
         mCwCmOTpx/QW/WOCb9ivM7FfqwbAYMruHbrn6sriTlTHJ3mh7Qknsm1AZR3m+A8HtZw5
         oIaAXB4+iejsWB/zBU2RbVR46l3hJTwmUM7FR5cT1DUlTKvx8guIoWAxh0+4DuUfm+VR
         31Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736689150; x=1737293950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7Ty18ut1e9jMhl/AkSFuE2MdVzmvveKnbQmIojHQTU=;
        b=wn/m5A41lAghemMh6DMs5tfagopmZ/bWTzWVwPfZHvcKL3yJkjsFe0XUNeSBogRjiC
         DZP/Eeay4WG9wh217jWd27w61+iG3YktZaW/VaA+lYH8xdqgU3Ugv2MD3ExWxwtcRsdg
         tLRuZJgzYIcSJgsALaLpmNFwwZ3yq/8we5h3UissIDKiqzADigewFALl8AxLCmXqq/rJ
         3FNzV9VjFnoLkU5lMHsr81xskJxxOKTvFTFHoZnkRdoR43JuGQ48HLqEv8OoTLTUOjFL
         Pv6D1iKsi5LdgEQoyVvgEARWr7PmiaJiQWCWvHFp46Ln5Lwp/aWyotdUOKqnIkGIUuNp
         bi0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrAOJUsg5FXuxcNw2WDo0s+hE0dkb7V81iZ3PZkUr3YdRtpkipLtJfLycQ0PuIJu8pKVO0WkZE45Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/KHkYSkCF/OsEIBhc1fzaegdLhe7JspN0epYzupogvDZwRi0
	PiVMVMKXxx+Ww64IWRvq/l9Hz/U4XHEA/TfYm7SRMViLJ2COGJwJ7WdmzMuA6RQ=
X-Gm-Gg: ASbGncthP4KYsRiDD/ewvdY/1hCMRnzGBrQH+AlddIDO7093ZgQFEkt1S3FkCKZHDGb
	RQcSbA7PP9XhGU11/T2k+qKKH688qPmH0VlFhYz8CErG/aM2q1DhC3mXk/boQUEbTgziwPFOZle
	By1S6TFmXqfGwJ+F5Wa1OOjL1qSV0RlaetQEuW1niHNCMvqFJ+U5AHqrg7Lftj8YVkaVXnzmfY0
	BZO+e0G2QIiCbK+x/zPkqxpJZ/42PGL1cEx7pVGCdE7GLbrkhfvtpROR3VVldHlZ+EykI7b
X-Google-Smtp-Source: AGHT+IHhfop11bEN74u0ET9V0abdMLDcSBys+gSbyZcc1Oyi50RffMGbjeAYxlnbPrRkwqyrU0ID3Q==
X-Received: by 2002:a05:600c:a09:b0:434:f1d5:144a with SMTP id 5b1f17b1804b1-436e2557087mr63456395e9.0.1736689150005;
        Sun, 12 Jan 2025 05:39:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c006sm9581924f8f.46.2025.01.12.05.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:39:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] PCI: Simplify few things
Date: Sun, 12 Jan 2025 14:39:01 +0100
Message-Id: <20250112-syscon-phandle-args-pci-v1-0-fcb6ebcc0afc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXFg2cC/x2MQQqAMAzAviI9W3AVEf2KeJC1akHmWEEU2d8dH
 kNIXjBJKgZj9UKSS03PUMDVFfh9CZugcmGghrrGOUJ7zJ8BY5F8CC5pM4xekYe+a/uBiJmh1DH
 Jqvd/nuacP7HF0+1pAAAA
X-Change-ID: 20250112-syscon-phandle-args-pci-d97537922ddd
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=666;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=x+i17n32J9BE3xJWGZWzaweD1AZbhL+oqQjbrPfkdJw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng8X3fpKo9Fo2SJTRBmFQDvDSbyoSOE5+H61jh
 WVIyJ+vkH2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4PF9wAKCRDBN2bmhouD
 1wnKD/4gxTfv+tXPYb5SNsiZrYl54aARJsvzHavNU/1Oep+K0WSyRw+jj2XwM3C+OYsw4RhApPR
 2OoXL0k+JjPCwoDdX5E3hGTdIpJR3TrixOEteHnc3xs2lxeeHh3nt9iRGa2ZjMlE+5p12BDy8K4
 hnhqOE8qIT5+j7vsJwTJt/7nQqwgCvBRY9JvlaKfc1TRRIY7Y4dOzvSSKhjA/KQrO18YaybJ3qq
 Bnace1Td91tf1hDQwMy6d/pmermVgtYHqtY84HNY7Rcqyul7VtiTmoXXPSqruEIKxupAoJie3T8
 hHv1Lj0AeEV3geNQ8/CviDs5+fHAt9ybjCdLevrdhunHcEic2U9dlpx0+Dn1rthZJj3oeXMdMno
 iWT6sI7VL+wUD7SrQBWQlst3HfwCKkQqj03Leh90PKuvyIeRaqgp+ZokavbtdyO4Mpd0gMgrL7Y
 gNBtIAMICO559+r6VpoXytH7OdIJKJ0Z7Ohn+sKk7PBh8kHMkC3+JTjNtSWQhyDNOcmh7Tu42DV
 2njcZXMQksL97QcbGfAcgi8U+WsG3HeITLzJVuNq8e8YHOuyjLNHhmeJ/axSTjMc0n5uiT61P4p
 6Il0Pk1UozPnyoc+VNNbPIYwGwkJ3S//dY8kkyV+srFvKF8rARseRo4CqNKvnnfVky4ozzDmdXA
 lSYkUsupahUkEmQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Few code simplifications without functional impact.  Not tested on
hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      PCI: dwc: dra7xx: Use syscon_regmap_lookup_by_phandle_args
      PCI: dwc: layerscape: Use syscon_regmap_lookup_by_phandle_args

 drivers/pci/controller/dwc/pci-dra7xx.c     | 27 ++++++---------------------
 drivers/pci/controller/dwc/pci-layerscape.c | 10 ++++------
 2 files changed, 10 insertions(+), 27 deletions(-)
---
base-commit: 2ddfbff29a2d45551e8c3e4f0c6b7c4618de24b7
change-id: 20250112-syscon-phandle-args-pci-d97537922ddd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


