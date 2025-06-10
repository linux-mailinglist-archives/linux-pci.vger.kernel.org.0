Return-Path: <linux-pci+bounces-29346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155BAD3F1D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DB8189FCD1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1223D281;
	Tue, 10 Jun 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxqa6DW4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D823F43C;
	Tue, 10 Jun 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573426; cv=none; b=Ay8Xk0nUttxbLamnIX2d8rGDLZ/7b167OdLvfOSP0Dly+R8bTrOl3wX/CystyqbggJS/+axNbbLFmORM0xMXITLzyqnhT9og+nbIlkaHBsnvt3NSRIvpSOG5Iz9quv+NoNDvsUMsZgH9mD/yqeuZ6+Kzm505jpsa00sViji2u0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573426; c=relaxed/simple;
	bh=IDSOkUX9zDMF+Iu/bNW9Z+Ppjb5+bcDLYqZu0MLOhJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f/dfJc5mxz7QedeyF99pJQxkmprgGtR+Sl6j9lrbrtlUjqooMEklV21xHjDRRFn7RER8xB4R7aX2Uc5FybWaUWWPaufnD4AjkdhOMs+7yIEDF9t0+c0teOfxaIMRnJb6bF2GRE66KMlfKM12N8wZIq7jAXoFrbN5LUnK4UYoIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxqa6DW4; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so6337241.1;
        Tue, 10 Jun 2025 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573423; x=1750178223; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nqEkPlu56izKVRCcBxWQQRBgYviwPk2wR3cGWZ9+hA=;
        b=Wxqa6DW4AwgBMHZBe+1n7zDXKR8qK1+QD0LuVLsytFMdvdZb132em2oGNAlkBifc8h
         tgdMUpANBs9fQ2ZjdPDL2Jgcy4SqLa7yBd3jp8Hm4FB0NAfLteUerqRSFAdb0AKIRwq5
         2dTkT0Q09l5vyXpNqIY3br8jzwU37sFAFV08OjxjJTLirU4ke/mR6ZRphKVu7VbhVdJA
         iGt7PLYFoHtSPZZ91yqXcYrauaJN16xTvRmCCVg2eilslH1EtfqZVExE5P5+F8pHo/iI
         typYqr1YJvQcb/iAIj6bfNnC0wT4ynnLWlMsdf5GFvQCxPxq4arMOq4R/w/HHH3gzTLq
         5brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573423; x=1750178223;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nqEkPlu56izKVRCcBxWQQRBgYviwPk2wR3cGWZ9+hA=;
        b=m0vrqtEs9nJqC1DBmeSsC3Kh+iaDWWucYAQbHJomPYKtvqCr8ERUVAwQOrs+06xaDv
         oWJkhDed77OdFI0VN2lxyuvAeOg0yXEKYmieUm54D8pUqtbdoQ+n+IvpDtvbTByTWUqL
         5Z7N9BTnvteMcW+OiuAZGCp9d+h5fl8WBfUZVU6GwprU+mo0oadvddMtW16V1t0DFvK2
         wCvRuDWwWujTgr1G+J13EcRg5T9Keau3EZ5oeSbwfwZRXQBurzYq2sPEoN0FwfLsMOTC
         5eG25fWf8Z3ViCnAsw2D+WPOFi53SiQqJ/aMBwYV5ezpfmbdEDW9bsLRkY5oSvmxzxqL
         SMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt0JgB4tZ4A/NDZcNyD1ifGYB1g0bmFwEoDDT3w3hyWoaiYIDkh8So/gDxZEDLrlJh0dXrj5n0Orfa@vger.kernel.org, AJvYcCXW79dikxFBEspdh0zNAeIgFT5kRpdXFkWhX8OBSOOpncjhDZqLYe1HZOI4+mc/sO5PQXFf9S/09AdO4hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQ+tgPzptjbdhLhvkYgAxX36Ulc8zWA9izHp14aKusZTY0yIR
	bgxl1L2yRJaPxeSMiLH2twrRA7xPUmOxQJvAHBYG1GHyllBPAQBJo1SbafXvflSn
X-Gm-Gg: ASbGncuDpB0bEckw5xdUNGSSnVCElVyyhzan5OkutUVCq5JaBrflvTjTLezSU931nvl
	2+Y2Wi0S+mbf1JpSahffk2zlJ5p0trxpdzLa470jt7ieeHQgEGZUUHH5sOL3roPPjYEuXARlW1c
	ZyIS/w2h2IM4bJhb9Svb4j6xgbfw/xQ7Fc7AaYzgPM+KqCVgrvib13abb1pgDjbBOAqQTH5R0ux
	uFNjErbWqe/hlq/q3sHH0VoQ1+iGE8pheIJS7tx8EgW+2wkO95ZPjn+lemIC/ny/Xoi/ARvlHZ0
	Uj0xX1k+Tgpelu1p000jxcv+JbWCi5Dwllbo/W/BjT7AFVXUO6mOXOEDuyne
X-Google-Smtp-Source: AGHT+IGEWQ9kp7g1IHALe6XyZa16xeumaOw/ktccGJAoVzbIN5nr7Lb+92+/jcCF/Cfok6IL1EUV+Q==
X-Received: by 2002:a05:6102:f9f:b0:4c5:2c3e:3841 with SMTP id ada2fe7eead31-4e7ba629798mr145476137.5.1749573423174;
        Tue, 10 Jun 2025 09:37:03 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7b5c7421esm801753137.13.2025.06.10.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:37:02 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:36:52 -0300
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
Subject: [RFC PATCH v2 0/2] PCI: rockchip-host: Support quirky devices
Message-ID: <cover.1749572238.git.geraldogabriel@gmail.com>
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

Hopefully this time the series will be threaded. Thanks Heiko!

Geraldo Nascimento (2):
  PCI: rockchip-host: Retry link training on failure without PERST#
  arm64: dts: rockchip: drop PCIe 3v3 always-on and boot-on

 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     |   2 -
 drivers/pci/controller/pcie-rockchip-host.c   | 141 +++++++++++-------
 2 files changed, 87 insertions(+), 56 deletions(-)

-- 
2.49.0


