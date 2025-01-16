Return-Path: <linux-pci+bounces-19935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D278FA130F4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 02:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF018164EAA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 01:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0A4D8C8;
	Thu, 16 Jan 2025 01:56:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B617BD6;
	Thu, 16 Jan 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992576; cv=none; b=uhZmYnaQjqkE2hYgKCby+lLSVxYpF/frwP/AsOZEyAdu1RucT4bLxgW9E/u3dvzgT88PDV0B2MtX1Xcm8Jz107iegZdzSJ3FZPkby7f8ZCgxgNYJccd9Va5n3+bsthvaIYcqttegs7Enz5sbehxSXsvPLeUb3x7TNEFqKsOadAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992576; c=relaxed/simple;
	bh=M8KRNKIeCxlHpSnunFXinVKwJ6BlKLwYSggX+T00lq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCEXsN1VEm9UC/o6NrwZ+/Z805qXUHx0LhVEw2RLswsqhJIUGt2bDsR3rdI5uPhCA+KGNicclOKjNuVRvaVtp2OZEhOhGFHzRJ5Jdc5edA5IocZe4+FcpBgL5Wlxuy371N4GMWMKe49vbaEG7glpSh7hrhPBOtKzjCqLr6d9Ucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2efb17478adso807150a91.1;
        Wed, 15 Jan 2025 17:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736992575; x=1737597375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPT7HO0uKhENdBsBoDbMFzCNa+LMh6a1srxsA8S0Gko=;
        b=cQ6TfL57+PT94vMGQL3+grg5oIT22xi3azd2MPbspCLp7GahLtIFbzAVJhMC5yDgUF
         bHXlpIUjBVxZl4y7r9FXxxyumvwmEGKq5QJgAHwJkSnSAVa4210rHjTK3ZjNDNQZ4CZY
         NuV5PoJMQECGFLZ7vHEs6tmF/rTogy9xvgHyPBrHrzKLxdTUSi7vOiKvaf1HEwr7t1iY
         Tfj8Lwcl5688ywJyN9Ju2UjMfiMv16lejv9tyAc3S9h2rxKKfgN0JJZwEteNL3upCx+f
         Nh/TMeDB2v1e39MRQO+GS1NHCfG97vhmsknE5fjenHzH8unFIq9JEEzAfnN9Xr6wgiRM
         shmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGOM/YX7t/QXjPAM56p+9utYs32eJsAkCjRa64aHdNBm1t7tM9qUYrUSggk5qIKtQSA3FYv82HI827@vger.kernel.org, AJvYcCWKtmE0IOod116WhzP+3fmn/O7lnCGbwiwoiETk1Re8148eliccJ3pngv+pHi3Jph2hO2sMyTOJCHBDNujE@vger.kernel.org, AJvYcCWbFmLTWksmrPemuThWuz8x09jw5QsR8re/Jx5A6DWjux2ua1+upMY3w6CY1cbdHVq2bfLSoMLhj8x6@vger.kernel.org
X-Gm-Message-State: AOJu0YySSmQbMMPiBLBXGYu/e8q9jGgHQY2WrrKOsowFzPCzFVT+dFWJ
	hUixUqFcMYAYZMlzK1AbHNGtBHHuVmIHCpggrWOrH38j5nwt+cTU
X-Gm-Gg: ASbGnctu+aJP9b3HmHsUMHBxxckUoktzTO5ZNMcj1JrkhQhyi9wr8MsuGlmjfNrJFQY
	zdUlFrAmlXjsctZfc8fzRjDVIZ5qfAuqeemV3A5Rwbd7VJ3WuMkuFitNpaDVFbRkCi6rVqJ0pMF
	lc4s9z4k5qrHbYrR1xb/1/S4H3CzH95093ItPzTsYnMfp8eyv+hG0GMiDH75aVrrB548Vs/BwXm
	D9F0ixjIoIwl91BtDcJgnMrtzhMedwB4VyEEUOXPOQchpxRmjKo3sJESZQOaA8OKgq4rLSOjVox
	7pMMH8Hy2DDZkiE=
X-Google-Smtp-Source: AGHT+IFLaJYooeBDIow3d6P4KJcawUwpbKu9ceRFklBWxLItU2fkeooWGqXZ3z89KdMiKUuR60q/Sg==
X-Received: by 2002:a17:90b:6c6:b0:2ea:8d1e:a85f with SMTP id 98e67ed59e1d1-2f548f44771mr51223268a91.17.1736992574668;
        Wed, 15 Jan 2025 17:56:14 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cec9dsm2087075a91.29.2025.01.15.17.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 17:56:14 -0800 (PST)
Date: Thu, 16 Jan 2025 10:56:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <20250116015612.GC2111792@rocinante>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
 <20241124143839.hg2yj462h22rftqa@thinkpad>
 <Z1i9uEGvsVACsF2r@lizhi-Precision-Tower-5810>
 <Z2R6HET6FZEO+uwi@lizhi-Precision-Tower-5810>
 <Z3wPX1F4VrQZhICG@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3wPX1F4VrQZhICG@lizhi-Precision-Tower-5810>

Hello,

> > > > Series looks good to me. Thanks a lot for your persistence! But it missed 6.13
> > > > cycle. So let's get it merged early once 6.13-rc1 is out.
> > >
> > > Krzysztof Wilczyński:
> > >
> > > 	Could you please pick these? all reviewed by mani? It pave the
> > > road to clean up ugle cpu_fixup_addr().
> >
> > Krzysztof Wilczyński and Bjorn Helgaas
> >
> > 	Any update for this? All already reviewed by mani.
> 
> Krzysztof Wilczyński and Bjorn Helgaas:
> 
> 	Happy new year!, could you please take care this patches?

Happy New Year 2025 to you, too!

I apologise for the delay, especially given you chasing few times.
  
However, we should be good to get the series out for the v6.14 release.
 
Again, sorry for the delay. 

	Krzysztof

