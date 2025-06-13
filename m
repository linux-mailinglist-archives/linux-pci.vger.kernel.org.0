Return-Path: <linux-pci+bounces-29738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BE1AD90A3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB801BC18A1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F94207F;
	Fri, 13 Jun 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN8YoqKA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF12E11B8;
	Fri, 13 Jun 2025 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826858; cv=none; b=sEK2leiDiVr6Wj75ogIWImvZbW8aiDHOjflxjgd+KSYDlT2WOPWGr1UvkUkOdRwo2kdLzZzUvjYXEuywSrwzEbmycqeDWPc81EbmQi6BK780StHxxbrUdqWgMMztjyXln1SFFdiUpFGPVuStnLqzFbQkwglgctltaUR6SdjB4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826858; c=relaxed/simple;
	bh=ERR0N61HPhTY7ubFfMWXyYEDkqxRO2pES3k1QCgQ86Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6n12olNspzk3cnJWGIrOJ92DVRL/faav+sVmo1Vjw4Tc1TtcmrQXCdgdgrwsTQhK6bvfOGAQvsp96EH14PO65WY+pCv/TP7ZdnGtccpjxNeJxg7zyJIgjcydRScKfJzUBS9HcaUZ9sAMlMAd3IV1F8HvFOTCaKe4fTW98vEvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN8YoqKA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso2073041b3a.2;
        Fri, 13 Jun 2025 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826857; x=1750431657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8jiEiES8+qUM2cqXDPdwSgaPuU6OGlRs4pC0s/GeL0=;
        b=CN8YoqKAh6WC5F35GECMbxBjksY5nFQ+iNFEXD4LWMCmrGyXByJ2F7RsQX8SQN6xLd
         qW5Jph2FVb8IHciB4oBcfU1eTuQUSxRXTrCkfzufPZmNo2ZJ0l4zHBDqVTtZ1cv1I7Gw
         FdOxaisCWBz2oZqFMzTuo2cceZuksGJ65rD9n31CIoHQB0+z0TX4S9P2PFUnBTUk/Yww
         PKS0BETuBEBjqmUyHHBiIPUPxixQ19FQ3WTPnPyqKfMHgVQlzF6uQwFBVOV9VswunVV1
         jU60vZ1lMWanfcFsaaUA8LWPw8kSTsC5Kpm7uJaRvLMWfbX334TItlRpgal3G0URccGK
         oEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826857; x=1750431657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8jiEiES8+qUM2cqXDPdwSgaPuU6OGlRs4pC0s/GeL0=;
        b=hOI3fB+xb9dbeOucXaxamiXghsLpCBud20TACpnNNdFy3gPxW4ahEsH6Hut/SHU9Gn
         9yndQYjVHGEcYwp6+aGL32qUfiEb33i7sHxyczAHuM3zcFVs1leD/5CyObVtIJhDieCI
         ME/jhoT7swwqZQg1RUABUc+UdgYAYkwDyJ+h1SsdWDuNxLjNOKba7t/xN24t6uNRAdDS
         F3NNxisv+z0kkQmBkj97mdGLPD/KDY8m9nqDfsESvPkJIsuhu9j423eOmypw1dvNPj5E
         +o00zBIqoyOPJ/w8etxYBi98GRGxpm/f1/eOv3GyHTFFeaJunCCkSAzVTHdislvomVb7
         1BgA==
X-Forwarded-Encrypted: i=1; AJvYcCVKSJbvOtraiCWfN79vPSnY0NznrPrh15EUjGGHhLc1q5tEf5gEz0/WNuAalMhVTiipDDG3g4Rt+4uZ@vger.kernel.org, AJvYcCXtOouhwsIYDxDwGDP+1ax/qCbLTrnfmUf36llvReIiCdep95AWyoQiWHfVSu95bVumBFbPcKDawPkOAlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsmAmDOjVXvayI3hoorbKcCyJ8OPOd0LTcPGbzwBnvrYUjV54
	//WtB5MVUDczDd5nK3OGwTrhdMZctz5WwHxL8eldCT28pXA5cgeH58qF
X-Gm-Gg: ASbGncuYLNkTtgtUpO16aG/3YgXVrySpGMdHsNnZwzEoKNYPXCjNojtCdansUYzC9RB
	YFtMRa0t8KvPNyTHfTNvajOUjqLequqBCyzSN+tC3fKfNrphf4ELizwYcnzT4xCBJa653XwXw6/
	B3WPmtNr+KPefjBgRUq3l3oBtwtxHTUomHQLfHqGIkTVY9XiaGCmGmHfDN3VtS3FRC/xi5MDqJ0
	+PvTsQY1+PpyJLywPzK97XBUMYqHUvy2LlUILjVaHUsrbXs9eDIFSXIicvBidpe6XSjMcVd4ZDi
	kdHunSkNLtmJ5e4DDrkAgj6OFm49/ni66FcEK7QmXlgjmaZuP0iHACBWMkwT
X-Google-Smtp-Source: AGHT+IHC4qfJgFLaeGwJ0qqEkImTRcGA8emN7/hG0BhuZcGgDlfiA7i4akpRVf9dQJcSyAfy5FGJnA==
X-Received: by 2002:a05:6a20:2445:b0:215:df62:7d51 with SMTP id adf61e73a8af0-21fac8b12d8mr4816889637.11.1749826855282;
        Fri, 13 Jun 2025 08:00:55 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1691be9sm1813060a12.68.2025.06.13.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:00:54 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:00:49 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/4] PCI: rockchip: Improve quality of driver
Message-ID: <aEw9IVCAtANnLPib@geday>
References: <cover.1749825317.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749825317.git.geraldogabriel@gmail.com>

On Fri, Jun 13, 2025 at 11:48:27AM -0300, Geraldo Nascimento wrote:
> During a 30-day debugging-run fighting quirky PCIe devices on RK3399
> some quality improvements began to take form and this is my attempt
> at upstreaming it. It will ensure maximum chance of retraining to Gen2
> 5.0GT/s, on all four lanes and plus if anybody is debugging the PHY
> they'll now get real values from TEST_I[3:0] for every TEST_ADDR[4:0]
> without risk of locking up kernel like with present broken async
> strobe TEST_WRITE.
> 
> ---
> V3 -> V4: fix TLS setting-up in Link Control and Status Register 2 and
> adjust commit titles
> V2 -> V3: correctly clean-up with standard PCIe defines as per Bjorn's
> suggestion
> V1 -> V2: use standard PCIe defines as suggested by Bjorn
> 
> Geraldo Nascimento (4):
>   PCI: rockchip: Drop unused custom registers and bitfields
>   PCI: rockchip: Set Target Link Speed before retraining
>   phy: rockchip-pcie: Enable all four lanes
>   phy: rockchip-pcie: Adjust read mask and write
> 
>  drivers/pci/controller/pcie-rockchip-host.c |  4 ++++
>  drivers/pci/controller/pcie-rockchip.h      | 11 +----------
>  drivers/phy/rockchip/phy-rockchip-pcie.c    | 16 +++++++++-------
>  3 files changed, 14 insertions(+), 17 deletions(-)
> 
> -- 
> 2.49.0
>

I somehow have screwed-up threading again. Please ignore. Resending
now.

Geraldo Nascimento

