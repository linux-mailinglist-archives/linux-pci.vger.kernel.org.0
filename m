Return-Path: <linux-pci+bounces-3452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB9854B66
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 15:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B9028581A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE557304;
	Wed, 14 Feb 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVXjPJU0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5454BC9;
	Wed, 14 Feb 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920947; cv=none; b=YlaVR1nH4Qm95VwD6+FKyRHA1w+XgDOpdYgL7MpnDeSaHmdIHw+baT+Svfv/qlyBQFJB/rSLLawkGeOK9fA5XK98a91+Tvdr+RrCkT5IhJNfFd2Cqrkfx/tGkqKeh1Y1qjXutuLPpHuwKqY04Xro8XiTV6dnH/oR2R38HxmKkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920947; c=relaxed/simple;
	bh=4PZnpdOC7nL7iSy6IqRjbXbXnr5kNh4hCRe0YlxfpbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU92+VZOvKtbCHFw0r5NGCotM3lDH86kNrB/hosjUQAE6DiRwMbQ6i2vsLoErlHEadD335JhCE7FECWA7+hVRzOyK/4xv0PvlwtoIDpNtqU+Wec5op+P8Nc6ZYyj0/6TW/E0gBXEwXdExjBKboK8iAmLt1dl0Ih9bw2Y91RVaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVXjPJU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AA6C433F1;
	Wed, 14 Feb 2024 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707920946;
	bh=4PZnpdOC7nL7iSy6IqRjbXbXnr5kNh4hCRe0YlxfpbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVXjPJU0NBcOWMTf39vw8+II4IjZ6ZS1xuxWZCaEPpMRtVrcpjvdSZ5pbQbrzfyl5
	 5p+9MWOmLWaPsr7LOgqJVuXpNEGu9HP5o6oHpfYm48mw/cwuZA2rOiL0TSqwgjNwtz
	 Te7GoztDlKGI1AjilnKM5j4xJ++Ihif+bCcL80YZs2PpixddZDzKfANZjpMNrMTAKA
	 m1PIhUC8uWSafZPkoiTw++ALnHkJPvW96yiRupPJsd6ECJAQnxwBqtTMY8b5ucoUh3
	 icNpqgGguQ5ARz4ENnmS+uuUsuFTn88qiMgy7Lk72p/ca5ZczM4VSsbR95m3vy8ro5
	 PVL/t1eKkJnZQ==
Date: Wed, 14 Feb 2024 19:58:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>,
	Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: Re: [RFC 8/9] PCI/pwrctl: add PCI power control core code
Message-ID: <20240214142856.GG4618@thinkpad>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-9-brgl@bgdev.pl>
 <7tbhdkqpl4iuaxmc73pje2nbbkarxxpgmabc7j4q26d2rhzrv5@ltu6niel5eb4>
 <CAMRc=Md1oTrVMjZRH+Ux3JJKYeficKMYh+8V7ZA=Xz_X1hNd1g@mail.gmail.com>
 <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>
 <20240208113201.GA17587@thinkpad>
 <ycorratd3jxzg5nijbpgk6hrlgq5rl66cttfg7wv4oyyxivfm4@kfbhrlytiafe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ycorratd3jxzg5nijbpgk6hrlgq5rl66cttfg7wv4oyyxivfm4@kfbhrlytiafe>

On Fri, Feb 09, 2024 at 05:43:56PM -0600, Bjorn Andersson wrote:
> On Thu, Feb 08, 2024 at 05:02:01PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Feb 02, 2024 at 10:52:11AM -0600, Bjorn Andersson wrote:
> > > On Fri, Feb 02, 2024 at 10:11:42AM +0100, Bartosz Golaszewski wrote:
> > > > On Fri, Feb 2, 2024 at 4:53 AM Bjorn Andersson <andersson@kernel.org> wrote:
> > > [..]
> > > > > > +             break;
> > > > > > +     }
> > > > > > +
> > > > > > +     return NOTIFY_DONE;
> > > > > > +}
> > > > > > +
> > > > > > +int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl)
> > > > >
> > > > > This function doesn't really "enable the device", looking at the example
> > > > > driver it's rather "device_enabled" than "device_enable"...
> > > > >
> > > > 
> > > > I was also thinking about pci_pwrctl_device_ready() or
> > > > pci_pwrctl_device_prepared().
> > > 
> > > I like both of these.
> > > 
> > > I guess the bigger question is how the flow would look like in the event
> > > that we need to power-cycle the attached PCIe device, e.g. because
> > > firmware has gotten into a really bad state.
> > > 
> > > Will we need an operation that removes the device first, and then cut
> > > the power, or do we cut the power and then call unprepared()?
> > > 
> > 
> > Currently, we don't power cycle while resetting the devices. Most of the drivers
> > just do a software reset using some register writes. Part of the reason for
> > that is, the drivers themselves don't control the power to the devices and there
> > would be no way to let the parent know about the firmware crash.
> > 
> 
> I don't know what the appropriate design for this is, but we do have a
> need for being able to recover from this state by the means of
> power-cycling the device.
> 
> If it's not possible to let the device do it (in any fashion), then
> perhaps a user-space-assisted model is needed?
> 
> Turning on power is an important first step, but please do consider the
> full scope of the known problem space.
> 

Agree. I'm not ignoring this issue, but this is a separate topic IMO (or an
incremental change). Because, power cycling the device in the event of a
firmware crash or even upon receiving AER Fatal errors is valid for platforms
not making use of this driver and an existing issue.

For sure we can accomodate that functionality in this series itself, but that's
going to drag this series to many releases (you already know how long it took
for us to get to the current state). Instead, I'd recommend to merge it in its
current form and have Bartosz or someone work on incremental features such as:

1. Runtime/System PM
2. Resetting the device in the event of fw crash etc...

Wdyt?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

