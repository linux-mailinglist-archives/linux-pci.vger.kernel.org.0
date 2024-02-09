Return-Path: <linux-pci+bounces-3310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98248500D3
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 00:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8DF1F26152
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 23:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B2383BF;
	Fri,  9 Feb 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXCqog+r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84A20DEA;
	Fri,  9 Feb 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522240; cv=none; b=sqWF2JEhAaRLQvzrwYQlbcVirE5N1slc3RU5zb2gBB+baUp7P2EucCVYAPbS0ZAuFrssC3r9ze2TMCK6toVaKZS6sXdAvDQBFGNGc1Lzx+J4ZfLLXV8nxbhK77GDXSGOPBSNCxDftZw+CVhWPmk4UMVWY6ETdzoRAjyl/T/AcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522240; c=relaxed/simple;
	bh=PChwu4/1OrFrHhMXnzyoAQoSeUStfLQSXILf2gucizc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GceTVmqjNNvaFCDzQ4opru5iFiEcH5Sp2kAWQTDvrD99UsA3KGKsO00Zr5O5xjH1w0Y4xpmNuv4h4CDIwIHwLcwc8ApbWT8g6MRlhEuW22eS7tg/AbMXihX6f7RbPcXYQ3q/m9+SdWeDisAWScoLqm1+3C/G3spR22sCrRdLDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXCqog+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B540C43390;
	Fri,  9 Feb 2024 23:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707522239;
	bh=PChwu4/1OrFrHhMXnzyoAQoSeUStfLQSXILf2gucizc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXCqog+r61bJ1tTkTKw1BAAknBvxi4kadeE8hG5scztIb/y/jZM5FQda/TTqe9Xha
	 lgSfVblnEK/iV1CRQ8GcEwxPNL8Mf3Uws4WTfeyhxM7I3hYy+uq2wFbOCaDTfST4Wn
	 gObPFvadpmu2nGJelsne8IyCnIfiZcVkdiXlfG5FUZXneL0hN0S3TnqDHz/9KBtjTa
	 oZUHIO3TqAR9tZpbTsjYQkc53b0vn7qrwnTx/3/zHWyXp0NDTfnj8yjPik5MQ1MYXl
	 62+sNWBCLQiZXgGFEm175XUlGTsdk2VPKekt4U+qwriLcdPPXquMDWwrNA/m6hg9Qj
	 Zr20XdKhkbYvg==
Date: Fri, 9 Feb 2024 17:43:56 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: Re: [RFC 8/9] PCI/pwrctl: add PCI power control core code
Message-ID: <ycorratd3jxzg5nijbpgk6hrlgq5rl66cttfg7wv4oyyxivfm4@kfbhrlytiafe>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-9-brgl@bgdev.pl>
 <7tbhdkqpl4iuaxmc73pje2nbbkarxxpgmabc7j4q26d2rhzrv5@ltu6niel5eb4>
 <CAMRc=Md1oTrVMjZRH+Ux3JJKYeficKMYh+8V7ZA=Xz_X1hNd1g@mail.gmail.com>
 <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>
 <20240208113201.GA17587@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208113201.GA17587@thinkpad>

On Thu, Feb 08, 2024 at 05:02:01PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 02, 2024 at 10:52:11AM -0600, Bjorn Andersson wrote:
> > On Fri, Feb 02, 2024 at 10:11:42AM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Feb 2, 2024 at 4:53 AM Bjorn Andersson <andersson@kernel.org> wrote:
> > [..]
> > > > > +             break;
> > > > > +     }
> > > > > +
> > > > > +     return NOTIFY_DONE;
> > > > > +}
> > > > > +
> > > > > +int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl)
> > > >
> > > > This function doesn't really "enable the device", looking at the example
> > > > driver it's rather "device_enabled" than "device_enable"...
> > > >
> > > 
> > > I was also thinking about pci_pwrctl_device_ready() or
> > > pci_pwrctl_device_prepared().
> > 
> > I like both of these.
> > 
> > I guess the bigger question is how the flow would look like in the event
> > that we need to power-cycle the attached PCIe device, e.g. because
> > firmware has gotten into a really bad state.
> > 
> > Will we need an operation that removes the device first, and then cut
> > the power, or do we cut the power and then call unprepared()?
> > 
> 
> Currently, we don't power cycle while resetting the devices. Most of the drivers
> just do a software reset using some register writes. Part of the reason for
> that is, the drivers themselves don't control the power to the devices and there
> would be no way to let the parent know about the firmware crash.
> 

I don't know what the appropriate design for this is, but we do have a
need for being able to recover from this state by the means of
power-cycling the device.

If it's not possible to let the device do it (in any fashion), then
perhaps a user-space-assisted model is needed?

Turning on power is an important first step, but please do consider the
full scope of the known problem space.

Regards,
Bjorn

