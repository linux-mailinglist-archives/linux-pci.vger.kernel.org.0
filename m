Return-Path: <linux-pci+bounces-3279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A2C84F25B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 10:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F909283BF1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2B679E7;
	Fri,  9 Feb 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFUPVvsm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D6651AC;
	Fri,  9 Feb 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471529; cv=none; b=TpySMzWNRVF42yeoUTGZUj3s5dgMVZejb531S+I4FvQQXNIvQOkSlosR9gqvQEEJnwqhnlrQdtNs5rwKVbabAyDBEs/7AwtN+vIPa79nOOTuSP9IBaSCFgjtP6iM6QDOsAImo3du1JrJtRM6F+eAroGjCnA678rgw6fAUO/3S0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471529; c=relaxed/simple;
	bh=dEK5MLKQfiIZqixssJklw9y0fREaNMf3USH5yVCloyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn7jlkuMaVbHm44E7NCqHQ+sseJ3gteq8h/m2LvcG8/F/LKE+0R0erUI/szsBQSZCEPsk31vnQpfrsq1Brroi2KLkl2bwMjHDO4KOwrJ5heU4czVOfLMfnZaVqH/5GntIZlrEqN4UP8qMcojOLioiSJKc7IKQLj6m75hcu0cKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFUPVvsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDDFC433F1;
	Fri,  9 Feb 2024 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707471528;
	bh=dEK5MLKQfiIZqixssJklw9y0fREaNMf3USH5yVCloyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFUPVvsm4u+vUOmBCXw5BnRhkLeBE5z9K6h8L0PipM2YCflMoenBpR0saxwhZCtXa
	 w9hAeAYNhvKCQu7iJWiN0s1koYNTnDJLiwTZaprON+6yzuT38qBsQ+EwvjAaoHx0Bs
	 sUvTwxSTuJpqonB3bEYTOg7XGfWpbURipBESlWmvRbzspALw4oXGB372jFyo3yXmt3
	 q/3ZSpuYGwLIVREGHXh4deNEwaN1CSVClJmzJY6JQvuStu6Q6mfawZYV4akceFpaSr
	 2yy2icRGSS58AdAALAJOkULCDL0GtZHL5ppLIBMK+pXvaYkxdfuGjufoRZNlI9w8r2
	 McrlusVnmwsHA==
Date: Fri, 9 Feb 2024 15:08:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Andersson <andersson@kernel.org>,
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
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: [RFC 8/9] PCI/pwrctl: add PCI power control core code
Message-ID: <20240209093839.GH12035@thinkpad>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-9-brgl@bgdev.pl>
 <7tbhdkqpl4iuaxmc73pje2nbbkarxxpgmabc7j4q26d2rhzrv5@ltu6niel5eb4>
 <CAMRc=Md1oTrVMjZRH+Ux3JJKYeficKMYh+8V7ZA=Xz_X1hNd1g@mail.gmail.com>
 <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>
 <CAMRc=MfsdsD4f3sC-BnR_sqvaHNEKWCZ+Xe+-ZhLU8vFYA06=w@mail.gmail.com>
 <20240209090433.GA18651@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209090433.GA18651@wunner.de>

On Fri, Feb 09, 2024 at 10:04:33AM +0100, Lukas Wunner wrote:
> On Wed, Feb 07, 2024 at 05:26:16PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Feb 2, 2024 at 5:52???PM Bjorn Andersson <andersson@kernel.org> wrote:
> > > On Fri, Feb 02, 2024 at 10:11:42AM +0100, Bartosz Golaszewski wrote:
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
> > 
> > How would the core be notified about this power-cycle from the PCI
> > subsystem? I honestly don't know. Is there a notifier we could
> > subscribe to? Is the device unbound and rebound in such case?
> 
> To power-manage the PCI device for runtime PM (suspend to D3cold)
> or system sleep, you need to amend:
> 
>   platform_pci_power_manageable()
>   platform_pci_set_power_state()
>   platform_pci_get_power_state()
>   platform_pci_refresh_power_state()
>   platform_pci_choose_state()
> 
> E.g. platform_pci_power_manageable() would check for presence of a
> regulator in the DT and platform_pci_set_power_state() would disable
> or enable the regulator.
> 

This will work if the sole control of the resources lies in these platform_*()
APIs. But in reality, the controller drivers are the ones controlling the power
supply to the devices  and with this series, the control would be shifted partly
to pwrctl driver.

I think what we need is to call in the callbacks of the drivers in a hierarchial
order.

- Mani

> To reset the device by power cycling it, amend pci_reset_fn_methods[]
> to provide a reset method which disables and re-enables the regulator.
> Then you can choose that reset method via sysfs and power-cycle the
> device.  The PCI core will also automatically use that reset method
> if there's nothing else available (e.g. if no Secondary Bus Reset
> is available because the device has siblings or children, or if FLR
> is not supported).
> 
> Thanks,
> 
> Lukas

-- 
மணிவண்ணன் சதாசிவம்

