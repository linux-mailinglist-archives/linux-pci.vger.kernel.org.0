Return-Path: <linux-pci+bounces-32280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CCB07981
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028745808F0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D14F2F50A7;
	Wed, 16 Jul 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m36XHinj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A82F5086
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679244; cv=none; b=Jt8SHbMUAn+JmgNEUqECDUIxNmPZWzknrcvdWKRCI0oNbA+JEs97c5O7oYE+REQHSP+4RN8/BXchviQaKrvjs2Su1i5QrsSgd8kSdOfPBp2aOAjNz32ipDkjenzQZkQViToGmUXLCUk90YVAWgYELn7RREWeQALdM7nd+tPok+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679244; c=relaxed/simple;
	bh=tXWo9DI0U4S27QdRpkx8bqAWOudlVH2rRpbfURoXpLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVexJm02JatoxOvbiU0Vn7vVM8t5booSEFA7fgwOS5VWHNITAyxx+GELuVGQog1IFcRW61x+2wZtqZ913xWIkksahH9geOdFhly9wymAt2UdNCgvdqD/mv14NRVDQGV3vYo7XrcRohNj6W6pat3fbIrzFg1p9re7NmPGLybn1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m36XHinj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so58813195ad.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752679242; x=1753284042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kvAy9JuKk7cJOpP3kEzrHj2nDxIOe89eZJRSs0ppsc=;
        b=m36XHinjMbQRFdf0KU6WIxrx7c8yoqXZsQKuUxBZ3THW7kWX3h9H6RRkWHBe12KQjw
         TEOA3/cry9c08khweHEcjP0tmv5bGHGx+jZ4KCAwAMuQvdhUz+NKYNlRCEOVCXboKIfK
         Vl/p1ZqKRnjUQa4FIfRNR2iOwvel4ggYjVkXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679242; x=1753284042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kvAy9JuKk7cJOpP3kEzrHj2nDxIOe89eZJRSs0ppsc=;
        b=MXhXGqDmGdi4DlELHHCi1vuDpBS/AcGZPBV1lihIL7IWOpkUkjOOqU/ORMegYqJQf0
         Jj67HKpO+zaMZbBvZs4fb89D0NC1hfhl5TNQYaQ/CtLdYL1jpapn1GXX8aCDcLeBf1vN
         Od/wKJeOj+MWDASIpDiVrbGA1BgK+GQeBG9eS/JZwmNMuLiNMNa9c1ah5znSHtsRjKWf
         FVGGGui1yt6BkSG+hjBK2GVlSLxEF3TOnrtihKcCe3TYDzGgCgUOdgQ7oFuB2U+Jn3bI
         cnDSXK4lZZa3GAgRjuLhQaARqwZU8eeZfykS5399xl6jTiGGuUl8cX/ATsj0+2zHS4KS
         vJfA==
X-Forwarded-Encrypted: i=1; AJvYcCXhem+4+4E+NbupwqbJygeLDd7PFdVMEvSnYEaeNs1Q3xtUleSqStFQ8pd3AFCR3zWQdiGrAZUTElQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7jwrXekFOt8A0u8nzFv97adUGa2NpSb+r/6YAeWDfsEJHSh5Y
	xF4bLbiGq7aTbJ1i7/AJMPxcsWBSiZflA8idOpAGr4hORSwycm3Fz9MOXijyUfITBg==
X-Gm-Gg: ASbGncvrCs64O/tJaqIjQ1wg7SZEUhswPYTkYXDLzoHtsOkhiZoEfXVaNLeOvfVD6UD
	5nmwpALQUURPfx4zeTYUS+vVAT+ceT0j/uTsVQLkgW7/XAZrRoSNyAdla5C+ljejYYQKwu2lhDP
	i/H6HqphvPXuUlG+38OmP3y9mvSER35G8iC0qWUkliurODIBhzlDQKb2i7Xvvrn587hQ2v3zuoy
	R8zb7g0Z3FtnVSZVJ70vIn1Kp8gULSaTxWc6LIhmcHhotG9c78DxQ261dHTlme6F0s7gaZLAkVz
	2NeqF3cnCU3f3wKoKEu3brSPgUan5FhmE1gFhFMgWnVgEcWc3RLn1gJc2mHlaFIFbErR3aVprLr
	XA2k3vjq62BAeE3atPj6mFGsXcbABygUo2uQxX0jHspxhVueAUhQy4BCJkxLNyVulIAdZpcQ=
X-Google-Smtp-Source: AGHT+IGcYoDvzs2xrFfDj2S6BlQ3ZOLJw8uglFXYfVPAkAzuv1JUfWvGeNjcSV0DwEnPsEttZXrSDA==
X-Received: by 2002:a17:903:3c23:b0:237:d486:706a with SMTP id d9443c01a7336-23e25778025mr49299945ad.48.1752679241689;
        Wed, 16 Jul 2025 08:20:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:17f8:90f2:a7bc:b439])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4285a38sm126118035ad.44.2025.07.16.08.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:20:40 -0700 (PDT)
Date: Wed, 16 Jul 2025 08:20:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <aHfDRm2S8N8Qus_m@google.com>
References: <20250702223841.GA1905230@bhelgaas>
 <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>
 <aGXEcHTfT2k2ayAj@google.com>
 <tikcdb63ti6hbpypusxdiaoattpuez5rgpsglzllagnqfm5voa@5eornv77pl4i>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tikcdb63ti6hbpypusxdiaoattpuez5rgpsglzllagnqfm5voa@5eornv77pl4i>

On Wed, Jul 16, 2025 at 12:47:10PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 02, 2025 at 04:44:48PM GMT, Brian Norris wrote:
> > On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > OTOH, I do also believe there are SoCs where DWC PCIe is available, but
> > there is no external MSI controller, and so that same problem still may
> > exist. I may even have such SoCs available...
> > 
> 
> Yes, pretty much all Qcom SoCs without GIC-v3 ITS suffer from this limitation.
> And the same should be true for other vendors also.
> 
> Interestingly, the Qcom SoCs route the AER/PME via 'global' SPI interrupt, which
> is only handled by the controller driver. This is similar to the 'aer' SPI
> interrupt in layerscape platforms.

Yeah, I have some SoCs like this as well. But I also believe that I have
INTx available, and that even when MSI doesn't work for AER/PME, INTx
might.

Do Qcom SoCs route INTx?

> So I think there is an incentive in allowing the AER driver to work with vendor
> specific IRQs.

Yeah, I suppose even if my SoC (and Qcom, depending on the above answer)
might work with INTx, it really does seem like an arbitrary decision
about what SoC makers connected which DWC signals, so I suspect this is
true.

Brian

