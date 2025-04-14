Return-Path: <linux-pci+bounces-25806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BDA87D41
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B541E7A36C5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14F26989C;
	Mon, 14 Apr 2025 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6/wGTUV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD60266586
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625645; cv=none; b=odsqguwR1T+e07dROJwUcpNxtXzUMaqpZhOfb90pb4GZ+YRE9EZ0VG9QLzoXR+od7XDAOdwa9UOm3Q2RwkfJg+otPBUpN2ijEpUoDfJ/CMyhzarX0B00+HtjXIL/g68CxzdJwhbGbhcG36jBaN96AyZMAgbwIfC4puPv0P4v96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625645; c=relaxed/simple;
	bh=5NV1TH2xrxHb4IO9SixFXKNVM4OWlBJPXwuyr+sXUuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkfcPeeCL21zN2SWoP97zVdhC44mOnRSNmGLg4LVVPPNx+2kQYWeEPocsM4k8Rqf2LZIvTlLiWr4ByhzUlmy/IpVe7fkj0vS1GtS2HKs8xqtQQDFPWvnxuMHTnvifbC1zbntlWItkyrgQUrEBZWyCK4bx7H/Pad3r9YaSSep0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6/wGTUV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224191d92e4so38092495ad.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744625643; x=1745230443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Smsg72GcXkF+Ivv2bDXZHVMpQJJmZfbh7twUx1di6OI=;
        b=T6/wGTUVPSVKDB6nAPFSiKgf3JZkp/d0lN09ZV/zXVW8mPkaUzr4CttcwhGrmNrO1S
         NHlBJIzF3WIQtZULawoVLpjudAyZF47UxGBLymS61W4JnjYLGH7DUkcnZRh4elQijhbD
         xC7gVWrHPs5CAHaV6p7dJu8uey4pnShc3NSbsOvmc15hdnj2nHa3c2VI4qoHFP72ZluN
         V85KefRALsoJLYKA+Fz3pKH397QGY8nbQ7uUJ3aEOrz3lIBciHUVodWpxftIi+E9lxYC
         1PaAzLomtoItIg5OU7MbPksp9Vsp23x0fvBkV3WJAmmNtVoyo9moxqsvdEH966OA8q0i
         v1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744625643; x=1745230443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Smsg72GcXkF+Ivv2bDXZHVMpQJJmZfbh7twUx1di6OI=;
        b=g1OXA//3iSMg7s7/k2dsor7N0hBYJzpR6o3Mhd8MarNy4pRXOSoT212UC0xe9O+o9H
         RPrheoVMVpHa8nunzDq0du0UuLdd0Pu55i8a7Ihfgblvs5aWGFe0Fq7ucUB6fOvwVIyS
         YseOnJllpgpkul/McNZMc/fc5gb90qnQci1trWb5D5H58iIpLRUp3woH1KaC/ZhJ7ziS
         pdmbe4InZGnKE3Y/F04Z2R7+l/tbqUjKMHIotdoZV4MrJalKnR89yaL4cT8I4zPH1/lf
         BDA5/dKYK3yuu2TDBwp+RYWbRNW0CHKA4d9WSk3/uzBzy8xUvHmmpU0COReQU7Fy1SIT
         MH2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+HtNV1STkDDSY6z82E6vn6/y9oU1+ItbmdOhIvio5OkXLr26bf/QEtY3qLe1T+A3F4uHlFFrAZEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQsFIgs7tGhvDglXMG2fv4XUx64HFdz+tXRoHjzjgH94xLHPUW
	sitTIBeXkFwmPp4lFXIR4eSOPlS8M4oYQFpjGPuZu6A3mpAXLH2QKLzojytG5A==
X-Gm-Gg: ASbGnct5EhBl8QGo4Wrd/J5sfT6Cq52thnwmEnfUXL49vbehz26CVGA/1GvozfsDFTo
	fXQ5I+cMFUUs2/o+xW1wObqG7AGTIpR9EewyKJ3U9hQUw7n4izy8D6n7klIgTWXfe9w5btygNGq
	Fom6f3OlDNL2/9rL4bNIVW4PApL2ThTndgBvdGnj7ygKhJdmv4BNTv4BAfU7L/LZnuQ2qN5sGPe
	mZAo4PTfi0SK4/kBImRmqlcrkgGCSIu5hgyHZxZyfxTJXM740ZrwSJuKDin7BRyRgkUetAkItDL
	aPvdBV/CGzUl5g1jnXjCDv4l3QuU/nsBSIeGySp04x8KHnWyfiGOJmbqybddjZo=
X-Google-Smtp-Source: AGHT+IFP91KCL2ubggimJjnRS6FXpsDpAY6dmmHmoDGSKCTanmBivzBpL+STAELx6GokUH9JL1EV7Q==
X-Received: by 2002:a17:903:244d:b0:224:93e:b5d7 with SMTP id d9443c01a7336-22bea4f6649mr164638455ad.34.1744625643547;
        Mon, 14 Apr 2025 03:14:03 -0700 (PDT)
Received: from thinkpad ([120.56.202.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c93addsm95066555ad.152.2025.04.14.03.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 03:14:03 -0700 (PDT)
Date: Mon, 14 Apr 2025 15:43:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 01/13] PCI: apple: Set only available ports up
Message-ID: <egu73pd5m4ubr5ex26kw5vwtmekuto73x46lzzmc3gy2rkiv5m@wjat4ewfsud2>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-2-maz@kernel.org>
 <k3wj3wkk3cymyacboalkhe2fa7jvkpuehq4knpsouoyhvoavpl@bafg4oakp4lr>
 <87v7r7ygq0.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7r7ygq0.wl-maz@kernel.org>

On Sun, Apr 13, 2025 at 09:00:23PM +0100, Marc Zyngier wrote:
> On Sun, 13 Apr 2025 17:57:35 +0100,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > On Tue, Apr 01, 2025 at 10:17:01AM +0100, Marc Zyngier wrote:
> > > From: Janne Grunau <j@jannau.net>
> > > 
> > > Iterating over disabled ports results in of_irq_parse_raw() parsing
> > > the wrong "interrupt-map" entries, as it takes the status of the node
> > 
> > 'as it doesn't take account'?
> > 
> > > into account.
> 
> No, I really mean it in the positive form. of_irq_parse_raw() checks
> of_device_is_available(), and gets really confused if walking from a
> disabled port. You end up with the interrupt for the next *available*
> port, and everything goes pear shaped from then onwards.
> 

Ah okay. 

> So IMO "as it takes into account" describes pretty accurately the
> situation.
> 

Thanks for the clarification.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

