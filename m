Return-Path: <linux-pci+bounces-29369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB63AD44AB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 23:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419E7178FA3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BF283FC9;
	Tue, 10 Jun 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSHUFZvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F428469D;
	Tue, 10 Jun 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590384; cv=none; b=u6FyOS9DUl/TtmqJ/1q2G+MHZljob0xR0ZtXunYobf6gD1tfEEq6OD8or2RxozPdX9/jIXrL0KShbUGSxbz0fKirymvck6XgjpNIWF+GREL/O6HWdMYQvJimJNQvCQUchpt4lhkmAdS9yXDfW0HOJDNRwR9fuU1I8LmvvsGRL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590384; c=relaxed/simple;
	bh=o3j7N+lW9p53Qr1N/xuODCFVMulol2SV643RxfFVSxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Joe8OIgsbyGVrYT8iMbd1wHl89/4FDq9OvbMZIPaSmFhhc6VeXw+cJkhCHc8S7QXjAhnFXmCwck/fcbM7y+L+qZV05mJCLgbl0f1lG2hO0r0gGaTht/2xqFaXEhkhl8TbAzqNn/YuRRc6LA7y7/8pAzCw4tEA/GJuzHQa1dIdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSHUFZvh; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-87eeca0d038so405264241.0;
        Tue, 10 Jun 2025 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749590382; x=1750195182; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTlGqNZZG2nk5U6PtVHAFn03jhmY0zJz2faCvEujVB0=;
        b=KSHUFZvhH59Ht18n/hamWzDnbAMhCji8lf8/cStYzjz8GyPEVOR9bzReq3Czu99ViX
         z/4j1Fyn8+NC4vJ247dEMY5Jadd8xQ8LqhpusTBAhNdt0A79P2WNadBB0Ycz1ZuN1YjG
         9rohbCOY4Mx4+BZFZ3o9rnSdlMBEypNnqVVB7lrZSdrEbg0QMKtwpbHoyVXEVAvvhjy0
         2X70E8++Sw01ZbXRPJ3eBbTZa3vt9DdZX8aaMEOQV4GTlgclYAFisHlcsvKIIo8GPCsw
         0SuMpwULecSO/sK0D9wFk8iyg2uUqVyhZHPJulZPKbQN7WSa19CBt3M70eSbDUTCeZ8r
         yHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749590382; x=1750195182;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTlGqNZZG2nk5U6PtVHAFn03jhmY0zJz2faCvEujVB0=;
        b=LUdUIoBMDL7zkSrRDHjwgZTfxWaZ09l4JWEg+hmVi1Blj+5iQOrsS8Axp6XeY/Eyia
         5Yj1UZqwH3f4LCNf0HQRMuTE/tb7wNJvzXl1r5sCkmFUSTYKDqZc98WpUvRwJoIUU5Xh
         aFjix5B+s2XRih5MWd44KewaRWjnSmFHSZoBOVEMpiOliFxPpiEloZvwvcYwBiWGEuZF
         J6AkpbYy1Ba3I8tk29tV1bQYGEsjw/pwv9+7rhyPqJ84l1rPJ4tSQxufy21YFmifcngA
         qs3vM/oelPOS1wzia1ERNfIjfEnPk5aQuhDsPxKfAPnFNtboP+7a4jbUr7Tpbfjj0AMP
         yXDw==
X-Forwarded-Encrypted: i=1; AJvYcCUYJr24KPXYmEAfDPdXsAVpdyxzX3ZcGzRZ1jomKLeSUxFyECc6V03AWyyY3Bdxb6iYrsOrNajeA83i@vger.kernel.org, AJvYcCUj4RKU1q/b25wa99omOICjJmLtFBylB4geCBGXSiOqZrzTlk1638faPwAuW8kaKX43OTlTwH7dhQv6sBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1b1L+Eu7ZFAOY4VPi07dXGRJRiP7G6jH+L2CEvlie8v02/qzD
	mH04ANctPXAsfxzZDTXj1QF8MopV8XuI/duSpkYC0qVTRQ1+g0iv3nq6
X-Gm-Gg: ASbGncsa+OCnuYTyfNbHrwxs+upyInyH/pdhkkQo1PlIxmQNDxka8blaNeDyeaTR07Y
	YpW1gT4ayyRQfN23oOiAvMyS7MpQ4O7W40zugVsvpGn0asFD6eGV8p4IQ7hdxx1uP5WJF24RxvG
	kDfPRLlI2/R9DAwzKWZKjYxiyJRmxK59MMr1CqqgLIWLGwOVZFieNp9Li9u120U3naJGcZV0HKw
	aMTNODmJIi0nWADnBw9cpl5fdjKxcIoNFP6YEWhD5BT+tilMoFb5Ll/u1Fyn3CaBwtLdKsSECNi
	rKOb60X/p1jFqJ+j0Lym9VkJIsZRpLinfNjSJbbD75DqRnKhBg==
X-Google-Smtp-Source: AGHT+IEc8tayspwhyZzHQNxg9nAlirC8xTvZilA/RPHMja+AJaaRaWniixRITKIg88b7BD1jFLaxvA==
X-Received: by 2002:a05:6102:3e18:b0:4e5:8eb6:e8f5 with SMTP id ada2fe7eead31-4e7bba3689cmr949646137.3.1749590381691;
        Tue, 10 Jun 2025 14:19:41 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5ce9::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae7722bsm1880161241.12.2025.06.10.14.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:19:41 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:19:35 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/4] Quality Improvements for Rockchip-IP PCIe
Message-ID: <cover.1749588810.git.geraldogabriel@gmail.com>
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
5.0GT/s, on all four lanes and plus if anybody is debugging the PHY
they'll now get real values from TEST_I[3:0] for every TEST_ADDR[4:0]
without risk of locking up kernel like with present broken async
strobe TEST_WRITE.

---
V1 -> V2: use standard PCIe defines as suggested by Bjorn

Geraldo Nascimento (4):
  PCI: pcie-rockchip: add Link Control and Status Register 2
  PCI: rockchip-host: Set Target Link Speed before retraining
  phy: rockchip-pcie: enable all four lanes
  phy: rockchip-pcie: adjust read mask and write strobe disable

 drivers/pci/controller/pcie-rockchip-host.c |  4 ++++
 drivers/pci/controller/pcie-rockchip.h      | 10 ++++++----
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 16 +++++++++-------
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.49.0


