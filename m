Return-Path: <linux-pci+bounces-29614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46145AD7CAB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E1E1688A7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 20:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAF2D660E;
	Thu, 12 Jun 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR3oItHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0C2BE7D7;
	Thu, 12 Jun 2025 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749761406; cv=none; b=Ru265sYj+FDtbuvUdgphED2+quZSBx7Qz9EF82AiDFNQrjc/3YMkRgbtJtNjeNquEbnIRzYE9MvDO+r3VrNB+NvuroLqP64IN3AafUj5+GO5S490hnVXb+0lD8NE4vhjhbZ0h+IQKOshDBPOP2FUdSpgqNCrBVjepp5u5WAGWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749761406; c=relaxed/simple;
	bh=iUgHLNAadS4y5q+Zna7GF0wPrd3qbJ+v+rYYs0/My4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5TWZrfL5tokn+CdYSz8gNoSqZXNyGtLePjcEZ4adKf/soXKTnnP7YQ62OITZyoEdvfSaT1mKPT2h3EKNgp4FCviSt8rm5WCNvTcNBd4hNjVieCNAD0W10rOOMiE5b6ebKwHZePLyeCYjquvnEtbKlGM0fzpueYr0zT6WWUig9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR3oItHw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235f9e87f78so15497055ad.2;
        Thu, 12 Jun 2025 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749761404; x=1750366204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UoLqPJz+BVnnu2pZ/H+yolFKvZxInzCZIkRhDZ6aJs=;
        b=LR3oItHwN/CGDBI/D+97fr9yZROQNVwfIiHc93y7/RJqgP081mKyamCcN17hh/HX7E
         vJo9qGRSbPT2FJy28Z56p78oB7VMDFBnP00gLIJ5LTTEJw0fKou10WnBARQqGv9XUwVf
         qOX9onhl9URJJQan0JN1AEMr4kTf0IpfhkaFUKcLzSz7/8sRAl6JFspYzmoNkmHVmxUG
         ZXnbpyA0NsBRIzBWVWQymmWO60rG84nHG/Hh6xZagSP7v9Ig9mAoKfijGMtGe5Qf4uap
         eyrtguL05fcunrZkubj6QYibwTtzl0S7F8jYFsH9W2ADdN7SPAAWMif3DHlvqQWAgOPC
         wx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749761404; x=1750366204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UoLqPJz+BVnnu2pZ/H+yolFKvZxInzCZIkRhDZ6aJs=;
        b=AhERSSj5PTKiHnqYIaUmoM8FhFTZUeUIIwz20iaYY1dw4UvJFKm5Hv/0iLDzq2km6H
         vx7cEVL/2FmlnTeqnTyPjaTYGcQveiBegMwNvA0BS7EcqmJeG9MKWv0RpKHzZkVfe/go
         pjTu4gW+TyIXTlhXUyLNKESzmrv/x1LnQEPxM2Od2cvRvL4fUJiwy/EW+LnsTgesxaL+
         l6+vWbnRfxIyWBg+plTwSGO90YWGkjlfarvPBL4xlqtB9ABF6ewTaYd6GkNo0PeTdgkS
         s02LURHkolGWWZh9uBTov/uh+WkVfXodk76A3dd9aEkOhDtIByANX7nC9DOE0eJ//Bx+
         DzVw==
X-Forwarded-Encrypted: i=1; AJvYcCVdYHBY89iz5pmpsWTZwoDhYXgwY/xIGFvLfGnpVBLNAHKUxCzoVq7k0jNgxk4fMddUdin4PIYJkdk9@vger.kernel.org, AJvYcCWN4gqY2OI3rMCzyC+nk2ySlC4YfjDZIbKVPsdiUH1+7zeqD8+t5olAP2720KNcIs1i8elt12UqMn2mdrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vD8S+N+gKOqEOcQpEHu6lxaw36kdcMJo4lyGFHCACseqtbTZ
	0ajl7JGaaKdiqwmqoXOHcPKnVF74aeW1y9KOh8qre4MV0WX7X2ghK6B+FAKyPNRL
X-Gm-Gg: ASbGncvBM+JGLl1eWyH1Ja3hPDESbwaOPskuMXpdRm75Yda0djPmLGlMU5lqN784fNp
	AGJ4yzuVShBukcmHqfr9v+K34ohX+/yJI2S8aDMVbpLITNoNGVUstbp2FPCdOnXwPYX77rJ7lTl
	1Rbdzd5JJ35YvMRr2STUgVyeTa9xgNmts+k1r835fbdDkNlpZJXWWG+AN/xNoa/8YQg88Eqafex
	ZFv891hK+MR01k+Vfyyb1YIlWplI+kOiWc+ALA3RJtylNfR6aBGWX7QU+6uGWEqfCD4c2oPWiOo
	2ysujzVXqWYPkzyzwYOVhaJb6pvZo2d5Vo5wkCgJlF8RK6f9LA==
X-Google-Smtp-Source: AGHT+IG+khSNpIZ1lLheFLw/LHPdBlZ34dCXBeuy237kfv8em5EfwIdvXLjGbIw5JRwoxwzkTzKMoQ==
X-Received: by 2002:a17:903:41cf:b0:234:9092:9dda with SMTP id d9443c01a7336-2365da07967mr7032275ad.24.1749761403815;
        Thu, 12 Jun 2025 13:50:03 -0700 (PDT)
Received: from geday ([2804:7f2:800b:725c::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88bfe4sm1670705ad.18.2025.06.12.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:50:03 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:49:57 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] PCI: pcie-rockchip: add Link Control and
 Status Register 2
Message-ID: <aEs9daeceXkePg7y@geday>
References: <28ae3286f3217881ae6ea3aecad47ae4567d6ec7.1749588810.git.geraldogabriel@gmail.com>
 <20250611194259.GA825364@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611194259.GA825364@bhelgaas>

On Wed, Jun 11, 2025 at 02:42:59PM -0500, Bjorn Helgaas wrote:
> I would do a pure conversion patch of the existing #defines.  Then I
> suspect you wouldn't need a patch to add the Link 2 registers at all
> because you could just use the #defines from pci_regs.h.

Hi Bjorn,

I've hit roadblock, maybe you can help?

PCIE_RC_CONFIG_DCR_CSPL_LIMIT is defined as 0xff...

I'd like to kill that define too, since it will be
orphaned.

But hardcoding 0xff seems like illegible solution.

Perhaps there is another standard define that
maps to 0xff that I can use? Anyone comes
to your mind?

Thanks!
Geraldo Nascimento

