Return-Path: <linux-pci+bounces-29358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081CAD4270
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0961177B62
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0525F995;
	Tue, 10 Jun 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1bPlUQg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704225F98D;
	Tue, 10 Jun 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582324; cv=none; b=LZDkIvIZYpPjNY9M2u64XrbeJHiHkVbLlC7YQcRlig20+DmlsYpT07vBerFGtOdkSMOgBFe9iErHfATIFX6pBOLWD+FKh+ALpmb1oiH8BJjMwnEQ/p7w0zQrqEYrEiUEXC7sVI6zZQ1mEXgc7RzhaQu7BV0b3HjHpnfERzUdp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582324; c=relaxed/simple;
	bh=jlwPb7DytBASrpUOpJyp/vDFlXACuhoHQ9OMkR9/6aM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M6ci3NvPHduVBu8gbUH1ma1vPx47XzHcQHpvlpJtozzFX+Q8uQO6DqKP8fVgwAhbZLQMZrleawfJfSdmN5osb0vtNLtRyAKW7p0clikZczwuEORg6tBcrYBlDl+tU1aTLmH83+NTMVYeWuCJZKGDx+S/OuLVdg1pvwIJ/+EfNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1bPlUQg; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-530f9edd032so88137e0c.0;
        Tue, 10 Jun 2025 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749582321; x=1750187121; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBMArELZ+b7OqxMIf1SSzcpla2zyCJLD/sNtyqPFkUk=;
        b=B1bPlUQgJtk0O3NIaDTPcANB88Zw65lHRo/TUVEpQAuVihe4A7g+5z7UBC9LL91SHS
         Y/g6AX6KIXpnQ/l17E4oPcikuWFECfbLUHMYAZ7QYVwBA9v7hm6QWalzm4WTR6JvQSMj
         gIOI+uPdTOl8XMYN5ngxb3XsQPNAa1L0vxxA85xUPHZ2lkd5PydVPba/9kLsa4fenehd
         Z9zMTEe1OqQ1Ae7RWp/i7FT0+F8aan9wUL6UXqnLdQ8AnXfn7nNU/8H6b6/8xxM8AiZA
         x+SYl5cKDR92sHM9nlt+yakkHqK2s4WzBN5KxDDALhNsF853LFEPkCcsUqzRZGNZuOUR
         c5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749582321; x=1750187121;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBMArELZ+b7OqxMIf1SSzcpla2zyCJLD/sNtyqPFkUk=;
        b=rMokuxO00EV1i2+3Ed+zl3T+c3xPQQtTvSk1xCxS3FVK2WSdUvZwqKGYBRvDjIfIkk
         aNDuVZgLmjSwEcb40wugCA1SVjGb872qSpU0udZw14OkmnH1vuPLwiLYwSRCqC5UtxxN
         y8F6WwPCxPXQvuBT7zof0dkLlrClZiH2QtacV0CVfjDclxK/sFYGglzW1V5bEqzYOtv4
         1KlToxO65SbOIZWv6c7Y8AozyTCouapaW0IKML5/wWdZ0oIZoqQcaQv6pTZ0Ub+c0u8H
         T114YY+XjImMX+f0Ivm8JvHl8cePBXqBYt6s8s+Xz+oM53twNNe9XZbcF8X8RTUJBsgv
         2boA==
X-Forwarded-Encrypted: i=1; AJvYcCVHaz/ebmGclOjfkKwRPwwkBsxf6nF2Du/4LIub0DWcf2W4+FzY4PK1+NVX9w1PWi0pmjR21+aJn7PZlMY=@vger.kernel.org, AJvYcCXYh+9aGfqScHhtwaC2Yv5o4tMj9iTPRLhMF2H8ks/s9WvfuzWPovT2e+t6v3f/HPYWRAJ03gPdxLyQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoRuTo37W+9f5rc3rfW2FE/rdDbiGfwzweBslhxiYdSB5ks/9
	+PaA2xnI5uhgx4hOaEfVOpX4o53lmHxrXaFM88eUamRR1vtXFP4dTxbN
X-Gm-Gg: ASbGncvaUt9iXJwKmuYOmzQgXELohmtngKF15vGFS/Ee/MZ0r6guSE4lXzmQA82A4A+
	xhSoQssXkBsczAiiw8b9QDSD/Hmw/WdmUqvVrBBN/fpcHfe06P8rqM3wKcg+xvkJXogrWTG/SNf
	veL35gml0zX0Crqmayh8RzRmFxCmsBZrHUcRyIe8xhgbP8rChDB2d5L51vcIuB+ENnLYoK0rCch
	RIa3RxZalJNxtfLVdjTBjU/Ar0O9siEoQnhNYYDZCO5oka1MiwvcRzVL/sL0uoL0zp0sd37K+JG
	0j2u5fKgO93Mzn5IPlDNfOIrs2V07NJbsKd99WeZw54wXK5S5WbmTlygGurX
X-Google-Smtp-Source: AGHT+IFvkvLxAMuApjj0TaS8+IPnWrq0/20erFO4UhwpQr7lrHSO8t8VmHDaRPRY4P2rvSgSjxJNlw==
X-Received: by 2002:a05:6122:4f9c:b0:52d:beeb:c6a3 with SMTP id 71dfb90a1353d-53121d50761mr1104020e0c.1.1749582321327;
        Tue, 10 Jun 2025 12:05:21 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeaf3b7c6sm1735824241.21.2025.06.10.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:05:20 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:05:10 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/3] PCI: rockchip-host: Support quirky devices
Message-ID: <cover.1749582046.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

while I understand there are lots of already-working PCIe devices
on RK3399 there are also many quirky devices which fail link
training and refuse to enumerate. This RFC series is meant to
alleviate this problem and has been tested on my Rock Pi N10.

Note that with these patches, link will train for quirky devices
but with Gen1 only and only one lane (x1). I have separate patches
for improving to Gen2 and all four lanes (x4). They don't depend on
this fix however and since I predict the present patches are bound
to be controversial, I decided to send the quality improvements
separately.

---
V2 -> V3: separated commit for reordering function as per Bjorn's
suggestion
V1 -> V2: adjusted commit message to be more clear about change

Geraldo Nascimento (3):
  PCI: rockchip-host: reorder rockchip_pcie_set_vpcie()
  PCI: rockchip-host: Retry link training on failure without PERST#
  arm64: dts: rockchip: drop PCIe 3v3 always-on and boot-on

 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     |   2 -
 drivers/pci/controller/pcie-rockchip-host.c   | 141 +++++++++++-------
 2 files changed, 87 insertions(+), 56 deletions(-)

-- 
2.49.0


