Return-Path: <linux-pci+bounces-31098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8EAEE6AD
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385633A5159
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99201D63DD;
	Mon, 30 Jun 2025 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1mx/nIG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B221C5D57;
	Mon, 30 Jun 2025 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307685; cv=none; b=SqclY4oRRaUWI4PvotGPLVWtB2kXeKWL4ZBIDg2T5NLRBHxqvnq9fr7AyNOz07dfZrNB6fYEyxY0SvsleYOKly4LxUgDEGdeld7WDuILz4IT/2U2JBgdJpEZVA/A1NmNmcCXnZDjbz5xn8ylI7j2UQuCWD/++gPylY++E8VLFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307685; c=relaxed/simple;
	bh=mqH/ZCrrChVkEmGXwBE5I5Gq6wow1NmIP0rQxaIGL6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F7KBaE/x42wImaR94FbA4Doc6vdp1xPrHlT1/fmO8Ex+ucGarbQEzuogucY2X+mDH6jo3qWCjso1yciW/ExOj90/HPJevVsoZp2HEPqVLaQe2ntNrhOCLFCVpzPxZfT+OoJl1jHSlTC4RfAj9s1pNZN05DL3Q1N/Jp9U1uFM01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1mx/nIG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a58f79d6e9so65579871cf.2;
        Mon, 30 Jun 2025 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307683; x=1751912483; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5oPe7NuWEBlVMssFfuoeeybtC7f7CEpTOJiXlRikAU=;
        b=k1mx/nIGT9QqlTls6S09v3qblAUgKA+0hhS+WN3dQ3DAKCbxtDZZRilIBCCMp76WLC
         5bn41Ex24WJMzqXX+7D8n1LiGdMapksxesIkl6bO585wnfrA3e5mr+4G8AA1/LX+SzU7
         akGelKyAbJCD1dV3X/sRdP/2Un7VHoVer/Y+mlzUNHtb2eSEZeivi8fQEl1k4kddHk44
         ZJD2U/OVWVu+Ogo4lwTkwCW5793NlmUZi5h43mCEb1azUplzfwAz7nybFOhmvyx7mxd3
         fPKj7NctrOOxaLUeeDtjMeMY7jmwpbHlh5Y6kKLyc3UvGBcsJ96a7orR/O2ZtTqf2BjA
         VgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307683; x=1751912483;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5oPe7NuWEBlVMssFfuoeeybtC7f7CEpTOJiXlRikAU=;
        b=i5Z5gMOBuZVqlA53GmOa/+4mvjIcta4N3YNVEG6cdqbnZ/e3mQKkvKToQpQ4F/ioZE
         GkBl5J8HMzPKQ8uRYwMqZ/1A8mf6+u083gG8JSBakEIlgIlWPEyn3QCJGLaYKbah0dyg
         SVTOVZ8iK+/MzbNTYCYfqc7tkGeOYHHzz7g5QHuKAzCSZGIKbxbDtgsPYYEWUGN2UzDV
         MziVS+RTCEe/GE6VfLm3bqeb2kJikOMtM2sF6gmOeFkLscC6W7trRqsspsA66KytF/dp
         MqX/UT8wRIuFY9G+yyamwns5fZc+FacsUqVbA32Dj7Yh1aayuu+nispRKSBJMuSQHdhi
         TJKw==
X-Forwarded-Encrypted: i=1; AJvYcCV+AKfRrUTGrH3CO/PPhraQpsamKFz2XF6P/5LA11KYkMlGBHy2zCqGobiMwTFu3nCu2ONNmREjwpS1Q1g=@vger.kernel.org, AJvYcCWTHU6KC1Rlc4B4BTFyD4duCdexH2zlb2K19IqSoRfhoTDaTujTTGSbJCgGlT3GmhLi4SIoJynf9hsY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EvvY7YV6U6TJszCuKiCA8Ivy/NvLrfc1jbQU/kaBbPtXWpiE
	k/TGcDEigwTn7qj60in7yHvKsxL8VxelrjOo4TOkvgA6oLHaEqzHpIfX
X-Gm-Gg: ASbGncuJeFcSJ/SiPBZlsDB3fMdvzS87O60FHaY8SEnvmXT8MQ2Ej0TGBQRGau/DqWr
	KsYQxUxET0ZvAbwMovZ4cjg7wBb0CuTP8la3k3PJzaHOabukJhtstJMd1GMrlVW7sAQtj//mJJM
	NHKUcVaQVh7l/BZZ/j3sHxvzHVWYSpnPxHCCrok5JsXe7lUuxTeJ/OPWaXJOj3X32i89ixkr5yZ
	A+Uv/NiiYi6KZK2tqSJZvkKfDq0wR8hvLTMTFKru1U9J1IyEeYno3hJkOm3guMNE6pvbOutxQ50
	CUoECf9LPL5iaEiZ1vgoVKVjd3gpTG34EwIWlN1MLOlEIFNMuQ==
X-Google-Smtp-Source: AGHT+IFsXJjoVwUXm0fcOFhLVNqsYO/moCefhcFNV46+xG5upfucPDlS2Uf2IOjWztKAdTp7b2Jfhg==
X-Received: by 2002:a05:622a:1355:b0:4a4:4af2:5cff with SMTP id d75a77b69052e-4a7fc9d4f7amr238186611cf.3.1751307682697;
        Mon, 30 Jun 2025 11:21:22 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc5cd906sm62801131cf.79.2025.06.30.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:21:22 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:21:06 -0300
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/4] PCI: rockchip: Improve driver quality
Message-ID: <cover.1751307390.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

During a 30-day debugging-run fighting quirky PCIe devices on RK3399
some quality improvements began to take form and after feedback from
community they reached more polished state.

This will ensure maximum chance of retraining to 5.0GT/s, on all four
lanes and fix async strobe TEST_WRITE disablement. On top of this,
standard PCIe defines are now used to reference registers from offset
at Capabilities Register.

Unfortunately, it seems Rockchip-IP PCIe is unable to handle 16-bit
register writes and there's risk of corrupting state of RW1C registers,
an issue raised by Bjorn Helgaas. There's little I could do to fix that,
so on this issue the situation remains the same.

---
V7 -> V8: add Valmantas Paliksa Signed-off-by to third patch
V6 -> V7: drop RFC tag as per Heiko Stuebner's reminder, update cover
letter
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


