Return-Path: <linux-pci+bounces-30289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB67AE28D0
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 13:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC53189D289
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C721E3DDE;
	Sat, 21 Jun 2025 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URKiGKqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66743AA8;
	Sat, 21 Jun 2025 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750505590; cv=none; b=qbWm0GOOTuJkyJGih/7xRMP3oXWIM81qB0uDrs635D7jh4G3vXFoAhjQSPnMmBSIXEhJv9Utont0ba3jKOTt32D3OT5GsFMMzJgYB1QPtNlFhFbysauUgJLy3EoP75H/0dOkjYtm0fl2+84pBqWOGziPffwwcMbNF6yXlQKyEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750505590; c=relaxed/simple;
	bh=B0YQJuQAJ5JfVPCP8NJktO7x2CM0QDZH86+KZ7/x97c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntyd5NZh1p/u/TRJvZfoKv25IiD8asRxwrW9xBN3CXrENn8zcq+59nb0SJ6QDilQplubCe5m5WxJfdL51HwjTzQ/lIiBzwMU5RWFXFw0vdSB7mxyJ7HNjaZ1CBHrhdHoJjG9K0EuH8w5xS9ZypOmUekCIKlDB+1gbqwM6EE2Lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URKiGKqK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b31c84b8052so3042671a12.1;
        Sat, 21 Jun 2025 04:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750505589; x=1751110389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m6xWMsAWZYmxQCQIsCXgEHzm6wGct00ke2bZk96Vt4g=;
        b=URKiGKqK7Jd8r5MTYfS/xEeqh+LMt+kBOmwZCx82ypdZmgwP+QQz67xRaIxEip4vDo
         E8P/U64d1U1IJqsFVcFB58SHpGUfPTCdcMwIggtpm+BqMtaZinE6Kbx7+9ugV4G3dEq9
         xokeUG4gVG7ArNVE/ztwmlkN+5sJpK6VPNKPT6YcZlufTkhj+dffKOeYxffoZauLR1pm
         I+EnUiDHZ+ybX4Y/AMABkdAT2drVp0ttm8fZGS2At/yXYZfCGCr4ljbx7PMiRGEQwtqs
         HJAdZSHxXCal5nAR7tCGrMoiAjG1z8F0hv5XzA0vZ3gSXXzq78CQOIkanjbxf48XzeTa
         Ar9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750505589; x=1751110389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6xWMsAWZYmxQCQIsCXgEHzm6wGct00ke2bZk96Vt4g=;
        b=b27HUyioRhY/mfiRwOTpYscEnLmM595JSsR3iXbKirxV+aHvCr7B7vvQ9T6NoRY6O1
         hIszyuq4ZMi3UU9P89o5YUbU0YarVMqDiluy1AkqlnufxcTHM+qzTWCEFQZCAcIHNidS
         sPRNDYectvMVCsugE+2EaH5rZv9dkB2HTB4L8XEP6ykAoVjgH5I8b5c/iN54p3QXPVav
         +zxxwGm++zv0XSh9yd7lVwBImsA/SnjqXhD87LGBznEYg1VsgPIpKH4GHU4SN0CTaf7t
         dDgYDWRqNCRmEk8yIQPJjErk5SUFnh5q1T5gDKfgWFHcl+cfFpDqqxDMPyLke5IyYbBk
         qbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVHMHOU2nNSEnc50ytBnCfwiOEl0KeFR52suWFRSNvP4PYb8+PsCh9m+5kyNTbI14QxUnfW17s1gI4+3k=@vger.kernel.org, AJvYcCWTl283ORm32DqMgb3XRgpt3xOfWvnC+Lr/laLOoLIYauDBGpKM2SqDp2MkOahZFMhDUsPZ2+e29GLm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gIF6No2FJ8wpumc8wnOJj4VyKh2SeNdHAgvIimqXdWJUnVPr
	y5WaayUxtloRVI5ef412Sa96xX3j1vqkFdEW2WONaLWaLiPpVVkGzJQk
X-Gm-Gg: ASbGnctIgsFKWSpp7rlepCt+TBVRsgEK3DNCtRnIL/lJFhEUXDqv34kwh2KmgESDhp4
	am0d/rtHzHwkXLzdB9gmPyoC/ZFFxCsuGXOcyimWno9RkWwl4MN+7krLvap5VSBVD345ztdVulK
	hL0aqznEzcvKVGNXVJzIQduFMgysGaMjJZarZmoM4UUy51ztwUZF88Ac4K96vCqlWlMVR+PDxOm
	POTc717oWeBVceFn6Qc+SLHmhCD0e34qZxGSgwi7gfysdaOmcutIyUiNoMGGQUtCgL0RhHDftgh
	x1fAdftJJQ1LYBqDFSEaaj2dmqwQAtqql6AhV85iVkYhri/4Eg==
X-Google-Smtp-Source: AGHT+IH6gtQnon9pj6eccRXS/FbkW5+UypmNMlcvNoE6c4fJcgUCpR3GPt9papU67FN/24ZcWA6t+g==
X-Received: by 2002:a17:90b:1f89:b0:313:176b:3d4b with SMTP id 98e67ed59e1d1-3159d7c8fb2mr7713377a91.22.1750505588733;
        Sat, 21 Jun 2025 04:33:08 -0700 (PDT)
Received: from geday ([2804:7f2:800b:d58e::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226f7asm6301825a91.10.2025.06.21.04.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 04:33:08 -0700 (PDT)
Date: Sat, 21 Jun 2025 08:33:02 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] PCI: rockchip: Improve driver quality
Message-ID: <aFaYbqRRV2l7nPcr@geday>
References: <cover.1750470187.git.geraldogabriel@gmail.com>
 <4760493.mogB4TqSGs@phil>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4760493.mogB4TqSGs@phil>

On Sat, Jun 21, 2025 at 09:39:08AM +0200, Heiko Stuebner wrote:
> Hi Geraldo,
> 
> Am Samstag, 21. Juni 2025, 03:47:51 Mitteleuropäische Sommerzeit schrieb Geraldo Nascimento:
> > During a 30-day debugging-run fighting quirky PCIe devices on RK3399
> > some quality improvements began to take form and this is my attempt
> > at upstreaming it. It will ensure maximum chance of retraining to Gen2
> > 5.0GT/s, on all four lanes and fix async strobe TEST_WRITE disablement.
> 
> just a driver by comment, you might want to drop the RFC element from
> the patch subjects.
> 
> It does look like things take form nicely and how people read those
> RFC marks varies wildly. Some may even read it as "this is unfinished"
> or something and spent review time on other things.
> 
> So if you're mostly happy with your changes, just drop the RFC part :-)
>

Hi Heiko,

thanks for heads-up, we really don't want people to ignore patches so
I'll drop RFC tag for next iteration. The cover letter needs some love
too.

Thanks,
Geraldo Nascimento

