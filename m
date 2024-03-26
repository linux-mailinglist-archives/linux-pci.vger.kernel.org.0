Return-Path: <linux-pci+bounces-5195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115FE88CA41
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 18:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73043B27C36
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130121BF50;
	Tue, 26 Mar 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Z0eTCE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90111C694;
	Tue, 26 Mar 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472752; cv=none; b=GyTTmL/ZwEL3V8OzRpBT4PaRsxKJKthSslR01kpBQDSQnNVSsdbzGV/jNvD8wf4rTPHKLnYx5pF0451uE9DM3O6aNBkQCLB5zqdiatXrtYzCdM6u59QXx8SRdCSwGbxibjo9tYuJx6wU7l6FFjPWDKV517wLl+xmT7l0MJRGZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472752; c=relaxed/simple;
	bh=71bc6Icg2W+tsc/KrncHz55w8fQK/AdKxcY+zxw842I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYQgTcG3yMFa4SlGZnU3TJJPpf5FSc9rarbIcpWhdtGk8+sEjQaqQrTRLZCpaFA6pVkZcuiaY3s1eIAT+/hqufIua+Oe6bPll1tWgeHEmGTljbehsLmpTdSI3p/H6esehtMYkwLQSHRb5/Ml7envCt/2rjcmnow9KgmL33oZDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8Z0eTCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378A0C433F1;
	Tue, 26 Mar 2024 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472751;
	bh=71bc6Icg2W+tsc/KrncHz55w8fQK/AdKxcY+zxw842I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8Z0eTCE91cnVLMjLsMZ5XnbXj46lolCBrEa2MuMCeOGKl2oNVv8YsfvE+OcWzfiR
	 2zZEvqlWd85/5mlWV+X3+eev3YcTeIbNtOytfIp97MmTfdvIP4a8oe/9oP5jsqhEih
	 KrEshn1lL9OneLTXy5A3ktgc7q0v/8hHhC+hUFQCQe22on3BOwFw+XtA/vv/IvGayB
	 hftb7+vs2AaKRqiZXmwNOIiE5v8kPXZX7paNsjz/IcH0HAfnNg+xjjp2EiWvbaYZEf
	 Myua/CeRUH2RRkxwg1P1O6ahhk60xu6EUI2aj/SxXWACo5VfjhGitiA4EGDc9nzM2I
	 xLIGc7N/yvZgQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rpAFK-000000006pW-44Tm;
	Tue, 26 Mar 2024 18:05:59 +0100
Date: Tue, 26 Mar 2024 18:05:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	ath11k@lists.infradead.org
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
Message-ID: <ZgMAdvEADhJ8TXa9@hovoldconsulting.com>
References: <20240325131624.26023-1-brgl@bgdev.pl>
 <20240325131624.26023-5-brgl@bgdev.pl>
 <87r0fy8lde.fsf@kernel.org>
 <CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
 <87frwe8jiu.fsf@kernel.org>
 <CAMRc=MdCv+vTMZML-wzRQqZZavquV3DABYM4KYw-HwqS47sTyw@mail.gmail.com>
 <874jct10yf.fsf@kernel.org>
 <CAMRc=Me5ef_kFDz0SyGZb4S+2Ma4i=Fek_tzwj+bYD4DGSV4mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me5ef_kFDz0SyGZb4S+2Ma4i=Fek_tzwj+bYD4DGSV4mA@mail.gmail.com>

On Tue, Mar 26, 2024 at 05:32:55PM +0100, Bartosz Golaszewski wrote:
> On Tue, Mar 26, 2024 at 4:12 PM Kalle Valo <kvalo@kernel.org> wrote:

> > >> Adding also Johan and ath11k list. For example, I don't know what's the
> > >> plan with Lenovo X13s, will it use this framework? I guess in theory we
> > >> could have devices which use qcom,ath11k-calibration-variant from DT but
> > >> not any of these supply properties?
> > >
> > > Good point. I will receive the X13s in a month from now. I do plan on
> > > upstreaming correct support for WLAN and BT for it as well.
> > >
> > > I guess we can always relax the requirements once a valid use-case appears?
> >
> > I think we have such cases already now:
> >
> > $ git grep ath11k-calibration-variant -- arch
> > arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts:     qcom,ath11k-calibration-variant = "Fairphone_5";
> > arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts:                     qcom,ath11k-calibration-variant = "LE_X13S";
> >
> > But please do check that. I'm no DT expert :)
> 
> You're thinking about making the required: field depend on the value
> of qcom,ath11k-calibration-variant? Am I getting this right?

No, I think Kalle is worried about requiring the supply properties for
certain PCI device ids, in case we have existing or future devicetrees
with those ids that did not specify them or that need not specify them
(e.g. any PC modules).

Currently we only have the X13s controller in mainline being described
by a PCIe endpoint node in DT, but it has a different id ("pci17cb,1103"
instead of "pci17cb,1101" which you are adding here).

The Fairphone controller is apparently not a PCI device at all.

Johan

