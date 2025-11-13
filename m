Return-Path: <linux-pci+bounces-41058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D030C55C8B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 06:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B0B3AB5D1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B90265CBE;
	Thu, 13 Nov 2025 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVuiyaYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400E219A89;
	Thu, 13 Nov 2025 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010960; cv=none; b=KHsschAlHNVnS6sDRbUyuwTIFCWxyZKCInQi3cnWAlkFhRN7s+9nrevrmBtWlvzrDJZF/VAs3EMVZO93JhGLHNvG1ixugVoUwyggUT9raN6T5i4H4H2b2BFUXA/aRx4sxLw/1Ld2/uwIf35rgs1pBmo8VfZP17jvLDWjhh33gRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010960; c=relaxed/simple;
	bh=kYF+v51HiH8f+oyjLD8Cw6AcWEWsC5LFA5+wU5FAo20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkXxB17mRAiUVtGu+2hyCgxl4JbBORy+G6HhB0GxdSKHPW7UtvKST8tGrtCaXVlaWJd7whw4lUctp49SjQvafY6yF5K1ZriTntS71bCELkkH7akddFVmvqnxaRK27s0mk2IIucM482pAq2bMJyK7YnLHWgVjjyIuguGfTgf9DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVuiyaYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E95C19422;
	Thu, 13 Nov 2025 05:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763010959;
	bh=kYF+v51HiH8f+oyjLD8Cw6AcWEWsC5LFA5+wU5FAo20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVuiyaYucSNIVgvOzygjjmNpCJS2H3qyavnx2/sxZyLzQNuRHoJfMdE/OkjRuCDb4
	 nCOg1PyrQ+PVf9pL6W7aGVVQcSXk7WkNBJmT4FAfJDda5LY2PmCQYi3Ugt5LqSdmD7
	 /+3Jtl5cLtmvFA/0R0P5+9/ODBh26PWd27j1OOa2mR+9tfjM+5L1y4oennPlbqcAhD
	 xht3cTQQ2YvguLhoIVJEHLA7MqL2UVmaivbvsadrid7nX59htdpThCWWaPWyvRdI6e
	 rZO/VbDWV9E0Xw/fFRmamCh0ojFU29uvsXovnGgyg5ws+Z8nZ/osM2174EEcN99tsS
	 56tWpHi+YVTFQ==
Date: Thu, 13 Nov 2025 10:45:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 1/9] serdev: Convert to_serdev_device() and
 to_serdev_controller() helpers to macros
Message-ID: <vajsqzw2z5jljmlys6gk3eltj3b2fr4xymyv252idk57lk3wm3@gfff56nn25is>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-1-97413d6bf824@oss.qualcomm.com>
 <CAL_Jsq+dZOUCosma1QJ-aqtjWs4NDLRkAdB3Aaro=8_Ep7Y0Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+dZOUCosma1QJ-aqtjWs4NDLRkAdB3Aaro=8_Ep7Y0Rg@mail.gmail.com>

On Wed, Nov 12, 2025 at 03:13:54PM -0600, Rob Herring wrote:
> On Wed, Nov 12, 2025 at 8:45 AM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > If these helpers receive the 'const struct device' pointer, then the const
> > qualifier will get dropped, leading to below warning:
> >
> > warning: passing argument 1 of ‘to_serdev_device_driver’ discards 'const'
> > qualifier from pointer target type [-Wdiscarded-qualifiers]
> >
> > This is not an issue as of now, but with the future commits adding serdev
> > device based driver matching, this warning will get triggered. Hence,
> > convert these helpers to macros so that the qualifier get preserved.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  include/linux/serdev.h | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> > index 34562eb99931d808e885ce5022b8aa4577566885..ab185cac556380dfa3cdf94b7af6ee168b677587 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -49,10 +49,7 @@ struct serdev_device {
> >         struct mutex write_lock;
> >  };
> >
> > -static inline struct serdev_device *to_serdev_device(struct device *d)
> > -{
> > -       return container_of(d, struct serdev_device, dev);
> 
> See container_of_const()
> 

Ah, didn't know about it. Will use it in v2.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

