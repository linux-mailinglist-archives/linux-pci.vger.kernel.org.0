Return-Path: <linux-pci+bounces-42034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CAC85343
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A79EE4E994F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9063221FBD;
	Tue, 25 Nov 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDxFN2Vw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D021CFE0;
	Tue, 25 Nov 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077882; cv=none; b=lIWcUNfLRZRV3Gn8aYLcpXVUcYQtMLDfLbF3y5VqVHIYCU6ybfkrrmGwD8O0iU4L34FuORVGVsKRitdIoymeheWMxCfOLJiMUEhoock1o627vJ47ZdbRhujncjp12u1WgK2W0ssYZbrwMNDYP9/vL7WrQE4crOAYpWBsmw69wU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077882; c=relaxed/simple;
	bh=WaWemh3y4rrguqMXrqnYhWnG/SlBCsSr3gHlUzN3BbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzI94FFseNExsoWpStpKRZ0bGIChgROjOdu89bPEU5GpoaHobEGA4d1/3gAqi1XHKKpxX5RoatEFeYvoWj5hGjDt4yH+0MU4dtlSG7gNi5INgFUbaflJM8LLC7kZUVBjFIvIfXY7qMCW3twhOsooKwrOycsWhLbZGPlc7BQz4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDxFN2Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED79C4CEF1;
	Tue, 25 Nov 2025 13:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764077881;
	bh=WaWemh3y4rrguqMXrqnYhWnG/SlBCsSr3gHlUzN3BbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDxFN2VwlYHgP2hGL++9gsMotaav9SpDR56P62Co8GX6f9zpYg7e4gkwnmjAcorZ+
	 Dfl6j1ysWyde04Th+mzu07A2UDZyqRvfW1I5EXbh8BfEQjqjemJQYv08pgfmp/56Yo
	 a3WevtUV+ZuR9jGX2kGIQFVGyGf1pEADqEyRK+Rwyd1McDQDRYwc2BMXFNmsj+Ynb3
	 F8yCBLruj6V6GebC8ChYkYF+GYaDrjor6u8d3eBEt/VyL+peFp8XFUXL8/f01lbfST
	 jD7FQFBUAuCarOCJzJcrroPKfT3KYIraz8vXypl07No8s4lK8Se65HB6fCn7XfC3Sa
	 VYWmZx9yDIvEA==
Date: Tue, 25 Nov 2025 19:07:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 4/4] power: sequencing: Add the Power Sequencing
 driver for the PCIe M.2 connectors
Message-ID: <pmwabptoyokh2slcgqwsngxzfa22ivhoqxkkp723fl27gllmrf@s5lgs2fecwct>
References: <20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com>
 <20251125-pci-m2-v3-4-c528042aea47@oss.qualcomm.com>
 <CAMRc=MeutDAwisNUPB1Nkqq2TEifjho+4E3GZ7x2HtbEh=inog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeutDAwisNUPB1Nkqq2TEifjho+4E3GZ7x2HtbEh=inog@mail.gmail.com>

On Tue, Nov 25, 2025 at 05:20:36AM -0800, Bartosz Golaszewski wrote:
> On Tue, 25 Nov 2025 12:12:29 +0100, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > This driver is used to control the PCIe M.2 connectors of different
> > Mechanical Keys attached to the host machines and supporting different
> > interfaces like PCIe/SATA, USB/UART etc...
> >
> > Currently, this driver supports only the Mechanical Key M connectors with
> > PCIe interface. The driver also only supports driving the mandatory 3.3v
> > and optional 1.8v power supplies. The optional signals of the Key M
> > connectors are not currently supported.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >
> 
> This looks good now. Do you think it makes sense to take it for v6.19 (provided
> the bindings get reviewed) or should it wait for the next cycle and go with the
> other changes?
> 

This can get merged for v6.19 post bindings review.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

