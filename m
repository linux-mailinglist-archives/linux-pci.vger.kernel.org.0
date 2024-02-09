Return-Path: <linux-pci+bounces-3309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17AC8500CD
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 00:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8B4284386
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 23:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C638F88;
	Fri,  9 Feb 2024 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLrmi2Ug"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ACF38DE2;
	Fri,  9 Feb 2024 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707521824; cv=none; b=WFfBX9S3MzyEss4+/oXy68eEHa12w6tysbuhrZ9kq96gMfdv1v6dY/Bfm0I1HE+uM49JbRAzyV5VobLMJj8GJMx1ZsYNkzPZGOpqaIRHsD4PsROE/3tsJwAVoIt4XEj6KPwRtA1NgxWcgNf1Sl1wWGuV1jhQy5imCTVoHeszOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707521824; c=relaxed/simple;
	bh=vab66JaH+98JX7uwKvF0gxBwsDwHTA+LMjKxktqFBFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCMh8gIzVWyF0QsqPwornGl6bScGVlXBqAiT3zsHcRHeWymPNi5JhWCnnflz4zprt3VpzkLO3InEuW9Zl+YBwUEfbbtA5EiEeHt25LRr/smEp/0n2J14xm9biolVw023wwPpLB7t+jj/PxPux/OdUoJ/PFRdU97h01xNY4eCGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLrmi2Ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BEFC433F1;
	Fri,  9 Feb 2024 23:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707521823;
	bh=vab66JaH+98JX7uwKvF0gxBwsDwHTA+LMjKxktqFBFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLrmi2UgocGnOO/gap5TAGTQkug/s/k067+bvJPqRjk02YmbV1+nxy3sDJAyB1HvK
	 14++nREuC0sMSTr+hpQhKlx2HG/LjbOM2lb4MK/wfkzlqlP3P8F3iDxChowgCJCeZy
	 FKKXv2Sgu/LzYTvr5OiH6nz0xyW8+ybUsRv9HM+mcC6OaC8BHzlADy/kXvXMM2pKxH
	 nKkxd1vCgAvIa7WkQv/dvw6Sq7Mn/5GWVhmzkze32/ZZJZD3fmBIL+fPh1D/k6NiSt
	 3hB62JPL7qL2Sd/RFwUJq6s9V4x9xd3YXVquvrU47evSzfphB8Sz5bQY9WTnCxaI/n
	 bjBR24cpsmSZg==
Date: Fri, 9 Feb 2024 17:37:00 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: [RFC 9/9] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
Message-ID: <nezjddfz22a74rbhjovq2nyba46752lwf66rw47oebfa3xg6zv@ad6wag5e5zrk>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-10-brgl@bgdev.pl>
 <jb4hzijjxjv4kiy3cn2fuc5ox4x5uutredbxiwo2fvnkh2xudf@5w65qtp35ase>
 <CAMRc=MdQ_uRq7a24RYt=KRSff9sw_1soQ+8ONEpNXy0emk5ChQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdQ_uRq7a24RYt=KRSff9sw_1soQ+8ONEpNXy0emk5ChQ@mail.gmail.com>

On Fri, Feb 02, 2024 at 02:05:59PM +0100, Bartosz Golaszewski wrote:
> On Fri, Feb 2, 2024 at 5:03 AM Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Thu, Feb 01, 2024 at 04:55:32PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Add a PCI power control driver that's capable of correctly powering up
> > > devices using the power sequencing subsystem. For now we support the
> > > ath11k module on QCA6390.
> > >
> >
> > For a PCI device which doesn't share resources with something on another
> > bus, the whole power sequencing would be implemented in a driver like
> > this - without the involvement of the power sequence framework.
> >
> 
> Yes, this is what I did in the previous incarnation of this code[1].
> 
> (I know, I should have linked it here. My bad, I will do it next time).
> 
> > I think it would be nice to see this series introduce a simple
> > pci_pwrctl driver, and then (in the same series) introduce the power
> > sequence framework and your PMU driver.
> >
> 
> I disagree. I was initially annoyed by Dmitry asking me to do a lot
> more work than anticipated but he's right after all. WLAN and BT
> consuming what is really the PMU's inputs is simply not the actual
> representation. That's why we should make it a pwrseq user IMO.
> 

If the PMU registers the "internal" output regulators, then PCI device
would consume the PCI outputs of the PMU, the BT device would consume
the BT outputs of the PMU. The PMU requests inputs enabled and drives
BT_EN and WLAN_EN according to which subset of these output regulators
are enabled.

Pretty much exactly as "regulator-fixes" isn't a pwrseq device.

Regards,
Bjorn

> > One case where such model would be appropriate is the XHCI controller
> > (uPD720201) on db845c. Today we describe vddpe-3p3-supply as a supply on
> > the PCI controller, but it should have been vdd33-supply, vdd10-supply,
> > avdd33-supply on the PCI device.
> 
> Sounds like a good second user then!
> 
> >
> > That would provide an example for how a simple PCI power control driver
> > can/should look like, and we can discuss the PCI pieces separate from
> > the introduction of the new power sequence framework (which is unrelated
> > to PCI).
> 
> I agree it's unrelated and it could possibly go upstream separately
> but the particular use-case on RB5 (and other Qcom platforms) requires
> both the PCI and generic power sequencing to be addressed.
> 
> Bart
> 
> [snip]
> 
> [1] https://lore.kernel.org/netdev/20240117160748.37682-7-brgl@bgdev.pl/T/#m72f52254a52fcb8a8a44de0702cad1087d4bcfa1

