Return-Path: <linux-pci+bounces-29049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD96ACF4B4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D75F189C283
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1E1F4CAC;
	Thu,  5 Jun 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNZMfxPF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956A272E60;
	Thu,  5 Jun 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142201; cv=none; b=otbfDHR+/1yqUy3RBrDC2fwfAVTJ8cuFY7/i8aWCpfj0oB89cG0mgZXMDB08lLB96oMAS7a5N5drqJUn75s6DX3FCqjOftJuthMI3mkFWrjvKn8OauKRb+/SJutlUdiZd/EVM93mZwk3aNJqBT1wbu7TjA9uOVyqgDQgUbZ8kj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142201; c=relaxed/simple;
	bh=ETmb3L3GatfLSgHNiVwLBrkCwK9RX7VEgFsTt+ukViU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WvraKfnR5LtMi8LSuCswGZTTn48OB4cGLrBiTO1sWo00E+uSgDVZTI/OtngJpb8ArhBt8ugMMacsdsLgXHjvHqERNPhjSvkByXKYZxt7V6wA1shmVYCQARUIdbjqRCDEXrzGk4OpZhl9ycf5O8c4qk8ZIpVMsgjJScw0wPNO3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNZMfxPF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23035b3edf1so12034275ad.3;
        Thu, 05 Jun 2025 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142198; x=1749746998; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhR8lS4XUOYrg/cKJvznCqYvDCeN5D6JpGXwFX6eyoI=;
        b=CNZMfxPF258/1xMoI4hqbNq4/dXA6uzGHVVdubDzc8MD/CTlVymUgWqlgdY6DBkHxt
         f9+6kyC/x1HtYQJIBVaHr4wsYVn/mKngP/SvTtdRPi4CCmoMl3x/Gj8O2HNQaIYtYmcb
         GHiHhg+eJvtUYBXKf0bYqa7u5ho0sKrhl8Z+jz5Cm/aaGcxrZZKMYUnZMo0Hu1X5Sn+K
         6VNFWgI7tvQerL8cDmrxnPoeVcSqmgNX8+mg+X+drJsxUfcbfpFUB2mQ/nxkzBtS72Yd
         +HBJXGLWa9hmrb2sT/J5bLq19aie+Q8nMkX8dqGpe/e/DbWxQ9ZuSdgYreq6fiU28vuM
         gdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142198; x=1749746998;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhR8lS4XUOYrg/cKJvznCqYvDCeN5D6JpGXwFX6eyoI=;
        b=ohWWu8cHpxG8CiCPlERCCBeyEArPuDcLpvWks9f+509zBJqawIBcFY4FnQYYLesMLz
         QU7393knbbcT/WsrcA8lxLulUyN6Y7g4TjujR5Jq52uKbwelSA1e3RigLfZtWzwzEsB2
         dsFfHeJh8bMIxXkg9jhoz6RS7ZTLHr1Rh2tAUB8zKGoc/spiU4bDysl3+123x+wEmH3t
         /I4Dr8xNI2ZST1/ZOvlHP+zc2jvG60KKN898k/R3efoMbBBntZ9rK5YUxiOSeD7sGq0h
         KbQhRmyoU21t00Sc81EndTa0FQVLU2BAMy+lqqY09wEG3lSFwoZtFuVPXnERD2+5erxy
         LHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+e/9+XGLUNhH8BHojCx/7buKicAcbd8/hbAFCm7X1l64IR9qUBvYzxKGeQOKkKKA/V/+twwvdmPOw@vger.kernel.org, AJvYcCUDDiJCG5sTr71BwQQR0rBAbFjRCgDgRWJ/Q7XnEe1ZVzFm54TYAuXloPW8uCTpTdX4ro8W6f+VDtv+zLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCflQexqdg1kh6VlvRA2kUAG7o2osR+WyAmNyfbwpWqnT2dG1
	U8i1zU9L4/HSawSO2rupDp6IUSBovcTsJvt9nvFQK7ELOpqUxDswsl2v
X-Gm-Gg: ASbGnctyp4izV1tsHt0aV7vwYFKIWRAbGnbwBFFK+NuRj2tut1TnGHbHhrJZ9XLXDWQ
	a/Ao2SOCZAtVt3ylj+XvnaNSTIgfLizDy7na2n7vKUqhjZYRIn5y6ZXXQURqdxuXFuS4eS7J3o5
	ijp2ijAbrVIcjSy5XjSciIgaq/3MNX55pzHq2L+dMl1hc9dNWV8/oDLES8UuBQ88pgtVk8ludd/
	mP9N+GNxz5SsjcWuH/Y3vheTkp2zAmiE6D7dSEp8UhQbLjTyFmEoN52mklQXczy8GLlqsGzMiTV
	dgmNqxnTKOGnkZ6AlEqs3VqVLc4MvjzEd5AJ8Gzk2F+ZGzHJ0A==
X-Google-Smtp-Source: AGHT+IGGx0oc6sieE/ILJBMaYCi/QgYY3JcxoraylNTYLqGC8v6LFdTtmeLkbdNepAaATIhTIk1m8A==
X-Received: by 2002:a17:902:c94d:b0:233:fbb3:c5bc with SMTP id d9443c01a7336-23601cfe606mr1324625ad.19.1749142198352;
        Thu, 05 Jun 2025 09:49:58 -0700 (PDT)
Received: from geday ([2804:7f2:800b:110a::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd8c4bsm121358705ad.110.2025.06.05.09.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:49:57 -0700 (PDT)
Date: Thu, 5 Jun 2025 13:49:43 -0300
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
Subject: [RESEND RFC PATCH 0/2] PCI: rockchip-host: Support quirky devices
Message-ID: <aEHKp1JCiez9J4bp@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I understand there are lots of already-working devices with RK3399
PCIe but there are also many quirky devices which just refuse to
work with RK3399. This RFC series is meant to alleviate this problem
and has been tested on my Rock Pi N10.

Resend because I forgot Signed-off-by :)

---

Geraldo Nascimento (2):
  PCI: rockchip-host: Retry link training on failure without PERST#
  arm64: dts: rockchip: drop PCIe 3v3 always-on and boot-on

 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     |   2 -
 drivers/pci/controller/pcie-rockchip-host.c   | 141 +++++++++++-------
 2 files changed, 87 insertions(+), 56 deletions(-)

-- 
2.49.0


