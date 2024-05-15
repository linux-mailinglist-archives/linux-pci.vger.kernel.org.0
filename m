Return-Path: <linux-pci+bounces-7510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5428C6A8A
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 18:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654782873FD
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DCD15664A;
	Wed, 15 May 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWIXxFWq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D813EFE5;
	Wed, 15 May 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790368; cv=none; b=XcGAEklhiwXE/Q2+R4VeAMtIgFAZZsbmD6HPIKGLXq9sDM6Dc4H9GyzdEvsYPa+JKdUTJm38YZjvxCwO2B7AMo2mLhGSqAujySUQ6jE2O4exu+UPssv9YREUzwuNTMlRd8CUDk8fEpWvzezllview2cXh/S/5S2L2jxXIaavjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790368; c=relaxed/simple;
	bh=/QLd5pElGb+brw7GOeOIfpCMWq2XW/fJcLnL4LqLKPw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYRIh2XVY49q4YE4cstFCGh62qJnnLzTWFrCsI0kvpsj8jxaziBfTJ4rxOhmeFB1qSDezAKIg55nexu0dhg8NMBsMCOkZRosS2QSfZiX4PaE+zR/+6h6MItg0Z27Vis2IYZHQBZTqShYU/vVINBZ+wbfzaUxnH/pGr/KV6Iz0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWIXxFWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0AAC116B1;
	Wed, 15 May 2024 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790367;
	bh=/QLd5pElGb+brw7GOeOIfpCMWq2XW/fJcLnL4LqLKPw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=tWIXxFWqe023uzxYSpP2M5OJUGckwP0jQFy+9hVbYUnYBrcjAssiG2uwzjWJRVsAX
	 reoYlgTu8kYwmowmJjfTEm/9EkL+XbKp71uI0X1402K/DrJLhb9r4t19DJkEqP4kNH
	 VYL6ov26m57s3p2kWELK6gUPwxkPpWUme62Zq6FYmzJb7VpVW8SVd3D/YAtFZLz7hs
	 xqbmPgADiMhEL81p0GPGfCXFHdyA7EMkf/zMTtI1+lu/M25cQjOc05Izxa+OnGOoHW
	 YRVvMLVF3Ia8GdTGvIzadbI9qjFa9PIGe0w2O+099/b6F65bX/1SYd8pFexLHhmhLy
	 pUt6KikYWp2xQ==
Date: Wed, 15 May 2024 18:26:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <ZkTiGWxJK4tbOF5y@ryzen.lan>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-7-yoshihiro.shimoda.uh@renesas.com>
 <20240511080257.GF6672@thinkpad>
 <TYCPR01MB110409C8FC92A7C466627E0A2D8E32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <20240515075954.GB4488@thinkpad>
 <l62l4ksr2rkxxi7kwatd3pfwmwv4ytfumhwkthjsurgla2prno@felahg5h5g7o>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l62l4ksr2rkxxi7kwatd3pfwmwv4ytfumhwkthjsurgla2prno@felahg5h5g7o>

On Wed, May 15, 2024 at 10:59:39AM +0200, Wolfram Sang wrote:
> 
> > > This is because that Renesas is not able to distribute the firmware freely.
> > > 
> > 
> > Seriously? Are you saying that the user has to sign NDA to get this firmware?
> 
> No, the user has to buy the SoC and will get the firmware with the
> documentation. Renesas is not allowed to distribute the firmware to
> non-users of the SoC. So, linux-firmware cannot be used, sadly. We all
> wish it would be different.

If Renesas could bother to spend the effort to be legally allowed to
include the firmware in linux-firmware, do we want to spend the effort
to maintain the support for this PCIe controller in mainline?

Is there even an example of a device driver that *requires* firmware
that is not in linux-firmware?

(I know of some device drivers that does not have firmware in
linux-firmware, but in that case the firmware is *optional*,
so the device driver still works even without loading an updated
firmware. For this patch series, the driver seems to error out if
request_firmware fails.)


Kind regards,
Niklas

