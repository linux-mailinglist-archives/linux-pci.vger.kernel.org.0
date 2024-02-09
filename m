Return-Path: <linux-pci+bounces-3278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425CE84F1E0
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 10:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91E1B23156
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70664664B7;
	Fri,  9 Feb 2024 09:04:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E37664BD;
	Fri,  9 Feb 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469479; cv=none; b=Ek/COwWCJGeT4MKX70+zsFGyBYoRgcBBnpM/3GLdDpZKkASb95FsABiXZfPN501vkayXSA4aXAGmGnVOu1euTiH5nejrQ62uAcn4zCjTNXZLAj9JoTDB48ga3TDlrW1KaFWf0IL3Zhr1y6+rJLMXRf2OBRgleG0PWzT+50B17I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469479; c=relaxed/simple;
	bh=WDlbkaEhExeSC6m6O4mA/Olpggr5HL955m2MFzYt5XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJmWwd5+C39B15Eans5KmeXgbzk5+vcU67kVXZKmpTE1FnazAoJT+aniAfVZLJnZpv942J+Fz0+NBziwP9PJPnn0CaVVtjbagMs8olWoDQmPw1l/X7QX41ZZiaV0TS+iiQ0dFVOv3o5K7CJwRWv2/VZdzwUNa4inLZ0HDDb8lZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 352F72800C91D;
	Fri,  9 Feb 2024 10:04:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 240BE4E7B09; Fri,  9 Feb 2024 10:04:33 +0100 (CET)
Date: Fri, 9 Feb 2024 10:04:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20240209090433.GA18651@wunner.de>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-9-brgl@bgdev.pl>
 <7tbhdkqpl4iuaxmc73pje2nbbkarxxpgmabc7j4q26d2rhzrv5@ltu6niel5eb4>
 <CAMRc=Md1oTrVMjZRH+Ux3JJKYeficKMYh+8V7ZA=Xz_X1hNd1g@mail.gmail.com>
 <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>
 <CAMRc=MfsdsD4f3sC-BnR_sqvaHNEKWCZ+Xe+-ZhLU8vFYA06=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfsdsD4f3sC-BnR_sqvaHNEKWCZ+Xe+-ZhLU8vFYA06=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 07, 2024 at 05:26:16PM +0100, Bartosz Golaszewski wrote:
> On Fri, Feb 2, 2024 at 5:52???PM Bjorn Andersson <andersson@kernel.org> wrote:
> > On Fri, Feb 02, 2024 at 10:11:42AM +0100, Bartosz Golaszewski wrote:
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
> 
> How would the core be notified about this power-cycle from the PCI
> subsystem? I honestly don't know. Is there a notifier we could
> subscribe to? Is the device unbound and rebound in such case?

To power-manage the PCI device for runtime PM (suspend to D3cold)
or system sleep, you need to amend:

  platform_pci_power_manageable()
  platform_pci_set_power_state()
  platform_pci_get_power_state()
  platform_pci_refresh_power_state()
  platform_pci_choose_state()

E.g. platform_pci_power_manageable() would check for presence of a
regulator in the DT and platform_pci_set_power_state() would disable
or enable the regulator.

To reset the device by power cycling it, amend pci_reset_fn_methods[]
to provide a reset method which disables and re-enables the regulator.
Then you can choose that reset method via sysfs and power-cycle the
device.  The PCI core will also automatically use that reset method
if there's nothing else available (e.g. if no Secondary Bus Reset
is available because the device has siblings or children, or if FLR
is not supported).

Thanks,

Lukas

