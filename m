Return-Path: <linux-pci+bounces-30280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BAAE26E2
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 03:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32A77AF90B
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 01:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5C1F5E6;
	Sat, 21 Jun 2025 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaVo96go"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627DAD51;
	Sat, 21 Jun 2025 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750470489; cv=none; b=p7IWUeVppIrQm8vgPFn8AapdAb66KCvavk+D4BcE0S20WYRZPrcwT0JngYj643UbyjoFfW3coItZ2492P3/Y/A2d6ye2NNVzZRYbDzuahkMhifYilzOvJQIS5r7KtfyqPNqXuJLoBaOpj6tNktb2Za89rPnnrjhrRlytBu/QHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750470489; c=relaxed/simple;
	bh=JV3iIQ0wvIAAb9rN56DdMT6pJMgKCT0nlBykOpygmeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u12xNjbyu6NB3jdlmUE72JOafb6LFjKGq3d33jS///vn/9Uq19Xy+lgJJm5yBtQ9WAduP813RVV63DG4ilwbIMNVIKu3xf551WvnBc/JyJGAElfpvFbpRTEJUhfNCXDvU26hUtbAuIOruIYMS2bp1nrUzNfrXQ6eRIHLlQC3Hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaVo96go; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234bfe37cccso31991175ad.0;
        Fri, 20 Jun 2025 18:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750470487; x=1751075287; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXz3exVEQXWDc3wTEzEXN840OGMK0hx/i3YSgfAvZ0s=;
        b=NaVo96goSgDFhJTRLUGLBOueRP3Lzpa58OXTFe8kOyH6wZfQpb5KIqDFgnyKsK0gYk
         gCWXQXT6mvOJYOxBcmoZT8onFdL+lIohSH3NBff3C2SGuQB2MnNF5oDloYEo4RpcD9H8
         bKWNLwwgCOE6I9zAasWSapWqzRMFHrHrkxvn6ElqH1C8l22xtXOmaOyiqDqewpofv9Q6
         sKkEINITUBSnyz0AsFaycSoHOSHlCI3k9TMTS8OzJ51kK69rcUf6pY1HjCw/VTeOYqJM
         DYtItCrWcOn8I9dSmp5S9r7FBNHSx+VODpquTEgSF6I0gOkw7uiVLNkEwTOW3k+1U3MW
         0dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750470487; x=1751075287;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXz3exVEQXWDc3wTEzEXN840OGMK0hx/i3YSgfAvZ0s=;
        b=ChL1oN44Gfx5DuXPEeeEbVqmRq+ZmHrVwHmS0ImGkG6kL/3I13TVaNktfxoqXzvtxb
         NqXvr3cv37OeHTTLAXgAjWI9Ds3tuEQjYjC+OoX7Mt/evu5KXJJ0GkG+riHRTlgQCx/l
         0CR+2oLvgQWNowFXoyFrVJCrk+koiy89VnEzFwKW6e/TKyt0jHtL+BDoEyp7aDWr0zo9
         LEyAP+x1SKyR1/G/wb/wxTMuLMg2PQTle5LRFk5rW27IfU2YDzAZC26W4ABsCX27ywDF
         NdtCgwhmBhF/bYw0XFDEea2XaslxVhxoHuihP5sG4cSJMYWSqeOmgwADA/du3s8LqVhy
         6GCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9B1SY84lYROZV1Bs+TnofCUOhvjRN6N46xSkTLy3Fp2q+6+I7Am8dUVabhgdEb6cPFsK55HOpbuH6@vger.kernel.org, AJvYcCVduNh+cIyvrBObdAp8c2OakaH4jvhRzTFz2hipwfBNlLzUlTvuIk0DheUS+l+ntWhvajNx7nY0dldI1OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzsHDhh1hdQOsRGXQyqx1jCqk8UoeGgXvO34uw6MnrtqRBAAa
	YH6428/GJHK3AxZcC8EN3nyVtL4SY1qTdGyiUjxq/oQzb7UqEQMsGFVq
X-Gm-Gg: ASbGncu7wDBjlknQ/CZZ2IDhV1k04R89f/CUDUOlBqAivIvlgtWq7TrGzFr6/Ih6ZSx
	HxVkPllA5fpTGy+ta4KwhVXPU/B1CX6wgdnuegJQmVFXm3l/eKviJM5dbcRcJxSB5qxD5xmKuvb
	n0hhYvEE/1H1270rRtA2S/NCyIv2y5wWGn8DDH/GsNAxgeTUi1Y4Ok4M1B+rkWrrkYwfvR90Ry4
	SMsyeHoGjbKW13dVoe+YesRICG+7l4dDLTKJPNUCmygHDv6jGZKboRM7Gkb1U4TLGx6ndEDL1u1
	E4jnFQ4QAdwtbvDNNfNI1oi+2BlGdsdWsgJiy3zzD/KbXu0aoQ==
X-Google-Smtp-Source: AGHT+IFMj8zujnmQyUnnom6Sk4SjVcrZEQeYPoia8cwd9VCLwZSbqcg4mJosbw1axQAjm2sXPpgR7w==
X-Received: by 2002:a17:903:32c5:b0:235:2799:61d with SMTP id d9443c01a7336-237d991f9b4mr79363855ad.33.1750470486935;
        Fri, 20 Jun 2025 18:48:06 -0700 (PDT)
Received: from geday ([2804:7f2:800b:d1c8::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393893sm28573845ad.25.2025.06.20.18.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 18:48:06 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:47:51 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 0/4] PCI: rockchip: Improve driver quality
Message-ID: <cover.1750470187.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

During a 30-day debugging-run fighting quirky PCIe devices on RK3399
some quality improvements began to take form and this is my attempt
at upstreaming it. It will ensure maximum chance of retraining to Gen2
5.0GT/s, on all four lanes and fix async strobe TEST_WRITE disablement.

---
V5 -> V6: reflow to 75 cols, use 5.0GTs instead of Gen2 nomenclature,
clarify strobe write adjustment and remove PHY_CFG_RD_MASK
V4 -> V5: fix build failure, reflow commit messages and also convert
registers for EP operation, all suggested by Ilpo
V3 -> V4: fix setting-up of TLS in Link Control and Status Register 2,
also adjust commit titles
V2 -> V3: correctly clean-up with standard PCIe defines as per Bjorn's
suggestion
V1 -> V2: use standard PCIe defines as suggested by Bjorn

Geraldo Nascimento (4):
  PCI: rockchip: Use standard PCIe defines
  PCI: rockchip: Set Target Link Speed before retraining
  phy: rockchip-pcie: Enable all four lanes if required
  phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal

 drivers/pci/controller/pcie-rockchip-ep.c   |  4 +-
 drivers/pci/controller/pcie-rockchip-host.c | 48 +++++++++++----------
 drivers/pci/controller/pcie-rockchip.h      | 12 +-----
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 15 +++----
 4 files changed, 36 insertions(+), 43 deletions(-)

-- 
2.49.0


