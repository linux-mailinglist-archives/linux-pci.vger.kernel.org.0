Return-Path: <linux-pci+bounces-41456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08364C66549
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39E694E5105
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61162D47E8;
	Mon, 17 Nov 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMdApfBo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F154280328
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416020; cv=none; b=nIP691thZnwlzWrwnDATZPdR8Ml2XDxugxa4LIW2bkvpZzNxcYhtxvemf/GfmfOfRMMtkWWS+/1lxERYjwLbUJtsmvLSuP0U4agCPS7O6MmOB1bpW/xfBI1qdXjT5dzbmg5jYWvs45mpHHt1ag0voG4L5OsTL4GpKEKI/n5xlng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416020; c=relaxed/simple;
	bh=rZZYh0Z6hazqOpK0tIYhzdwEKCoh5DJAeS1csO74I8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZA56fQW8bUlRii6CNFIqhCCc97N8jS7KolSlaJZ0DDZBy5rRRkKoww7ucneKD1SgJmihGjyVekN+g3jz301ogCWchw4/cSg8kWARBfubmhF6HlukdBTatrdvV44yHMYvI+AnTo/z8zapoHc+DZOupTKe7pIY1FYkA8l00CcXodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMdApfBo; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4501b097976so2345006b6e.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 13:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763416018; x=1764020818; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ztw2S/9TdbV5pr9Z6JYx0AXFtBg6AP2dg0jB76kE09I=;
        b=BMdApfBorMFn0dwjbjj3T0CkwROmR+Q0pLMTuSkvigWKGnfaR72GUIEcFVfX3pdwPh
         MWg8rFIdQFOJdNl5BtxJDblz9ykrphr9EfyGUMlWKk06aAO/vdgtXJUBKThUx2QR6HTD
         Dt64sdW2YretMFiJYKOo5QqwPViff+AFbLxvyWouB5G5ZbgJ013KjrCWLRaefwOEtULg
         6S1xJURAC2ENWJljlN1BA7CR9q3+5P6F8wy5dRP+MV2DNZdlGQRtDAjK0b9AlPINV5k0
         ZbPIzyBRS1TfhrBu8T5YRKJoGpOdWsiZBYsv2+LYYjU3hMfRJDKaRFhRYJjaRs+1MkRw
         9v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763416018; x=1764020818;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ztw2S/9TdbV5pr9Z6JYx0AXFtBg6AP2dg0jB76kE09I=;
        b=czXX7OmQyql7EMZ2vq8m/cml7fU/QbHPcJEKY4vrl5tf1tnCzv5r6kwl6LWw881ROL
         w95iWv+i4p/tLKPwD8Qx6vIcQoPh813qqeCuS6xXo6hxYXn9zzArrPoqrgpoxg4qUvr+
         YlVBHJIrLQjAblS7hRty2q3NMdiY8eSzdLsWQBh3JYVOetlpP6oEUHs2TI2GcvapgUVL
         hkIEOr6vCYti9kDvBwKvGilrYTAvxBaH4kxDndDZ01jPF06lye5nUAOHKlOOLiUcZ8FC
         ZHadJPWkc/pqRj4HAFHe29+TjmJDaRqU6PjfoXFNYsehgD+zbDBfECjDxRieHbQrUDfb
         dPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsYRv97mWqBVaw7GaITIshjuJUxm9zQDyr/kIjXg1dS70eYxrfxu4aj63FR7O1FQVHBf1BKBVu7qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+zyYmYfzdlVbkJvCl85FrnNTHyBnOdEY12LDdGSqRs0IR0P6
	AZOe4EF4tqO50hfbxK3xcR7ma6HsQBR8+mabf8siEIKwIMyrBqUs5eDh
X-Gm-Gg: ASbGncv/qxkxCWITigniXmlmpie7Fwq1aVrmSS/XAv199z+cHiDU+iqSMckRwgX2+J7
	wum67PjgFUQckKGEPxdMU6W3CMWneXaHHHPaYQaSlBBUrQYhdsK7iURrlPEOhBTTouwu3w3xcyN
	lvleJFA8E6nx7V0TIKm6ciuNNYGi9Znsuhen8kjq/ZXwS1oTDaSMT2uBP3O2lUrDvwVkU6btfb+
	J90luXDwvfeQ+qCoObiZqUzb0BHkB9Tenr49cAoVNl5RnkfnP9LNQNYuuD8HROKMOywXPJN/hHi
	/DeF2gFArKG8ffs51ibDe/bwPcDutC0j5EgnTN0LY38L1HjwAhzm5I31MCyTHJFOdvVZv7d+y8V
	BdqDU102PNlkG/tiAVpOMdNDEuw8GFtZSCci5ae4QiTPMXpr049JzV2hUhevS2kMAyI3gQJwh9T
	fvNJ79ubSU5ZF095B0TkY=
X-Google-Smtp-Source: AGHT+IE2vvEkzYPE2YeNk5ikw8gx+yWVLzAS4i95En/N092Es//XEtJ9aw1jpXdrlGJlPu0ojIqUyQ==
X-Received: by 2002:a05:6808:1b14:b0:441:8f74:fd3 with SMTP id 5614622812f47-45097637992mr6914942b6e.64.1763416018072;
        Mon, 17 Nov 2025 13:46:58 -0800 (PST)
Received: from geday ([2804:7f2:800b:a807::dead:c001])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4508a6df248sm4594480b6e.22.2025.11.17.13.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 13:46:57 -0800 (PST)
Date: Mon, 17 Nov 2025 18:46:43 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: rockchip: 5.0 GT/s speed may be dangerous
Message-ID: <cover.1763415705.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dragan Simic already had warned me of potential issues with 5.0 GT/s
speed operation in Rockchip PCIe. However, in recent interactions
with Shawn Lin from Rockchip it came to my attention there's grave
danger in the unknown errata regarding 5.0 GT/s operational speed
of their PCIe core. Even if the odds are low, to contain any damage,
let's cover the remaining corner-cases where the default would lead
to 5.0 GT/s operation as well as add a comment to Root Complex driver
core, documenting this danger. Furthermore, remove redundant
declaration of max-link-speed from rk3399-nanopi-r4s.dtsi

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

---

Changes in v2:
- hard limit to 2.5 GT/s, not just warn
- add Reported-by: and Reviewed-by: Dragan Simic
- remove redundant declaration of max-link-speed from helios64 dts
- fix Link: of helios64 patch
- simplify RC mode comment
- Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/

Geraldo Nascimento (4):
  PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
  PCI: rockchip-host: comment danger of 5.0 GT/s speed
  arm64: dts: rockchip: remove dangerous max-link-speed from helios64
  arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s

 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi    |  1 -
 drivers/pci/controller/pcie-rockchip-host.c            |  3 +++
 drivers/pci/controller/pcie-rockchip.c                 | 10 ++++++++--
 4 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.49.0


