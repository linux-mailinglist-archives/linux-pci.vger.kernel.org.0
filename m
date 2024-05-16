Return-Path: <linux-pci+bounces-7572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFBE8C76AC
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 14:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF01B222DF
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C9145FE7;
	Thu, 16 May 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epxHKuqW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC75145A17;
	Thu, 16 May 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863302; cv=none; b=Zn64GQkfQsiRdyMcTdAIjVUZryIwFS5xfPvDtOxCv5349U+FOFLGaXudi6ye8RsvgFjmHQYZ/bx4D9xQRKkseN/ykB3LZAcRI0I6Qfj1S9mUSSO3H6bPHTpkr0eecfdu/hUzdc0dmyjJiR8rArXr+BqS2S9ouwjFu+GYLvahESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863302; c=relaxed/simple;
	bh=B+xVjOfvO94VsbpW3WnBIH1v8CNe36Qt198iHyCObg4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK8w5u81QEG4v6YT+f8onpP2I94rmfrq4Hd4ubExRKX0OFS6INmdeaxAAPmOJo5hDNImIgR1yEUxu57LmxyF5VDmxaSYNl3eKtShqtAHmZ2mUhzMKjl01rCZ8fQvrCL2Mfs0PodIACy8xQ6UNMezOfcrnXrW2U1Z3w3Fmruhow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epxHKuqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4FBC113CC;
	Thu, 16 May 2024 12:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715863301;
	bh=B+xVjOfvO94VsbpW3WnBIH1v8CNe36Qt198iHyCObg4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=epxHKuqWvTO0oeNAsYBi87u8aTHJ+pCRL32DaJeL0OKyCEFDkVT3qGJTGKaxRJ+5s
	 xBji9nIwG7RgW8gYOaqdQt73UaIJnHfijquChdg7sbWrK3u9ZoEgW+u1G3q2HRtQ6x
	 kH0rheCUF6RCXG6ZqedAHTMR+NgxQSu6MmCCUtMW8E+y59fmTX4IfZxaPvYyID4Fn+
	 2lQI+hGNXqHimyFnNnHmGAcwe1vnd8oRsq5wNnzgXuU1wQ+5r+MaARvfsZnysAidTn
	 6CFnEGlMced0YpnVFaGcBx4AANyCk0SlKFCPmYcv+SPK78GygrG3cYKkirKFsVRIwD
	 EWW9OGaa27kxQ==
Date: Thu, 16 May 2024 14:41:35 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
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
Message-ID: <20240516124135.GA11261@thinkpad>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> 

Okay. I think this could be _one_ of the exceptions we have in the kernel, but
I'll leave it up to Lorenzo/Krzysztof (PCIe controller maintainers) to make a
call.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

