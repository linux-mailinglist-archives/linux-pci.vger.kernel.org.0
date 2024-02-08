Return-Path: <linux-pci+bounces-3232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EC484DFC6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 12:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94482B26DBC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE374E12;
	Thu,  8 Feb 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcDdQ1ts"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF974E01;
	Thu,  8 Feb 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391932; cv=none; b=sr6+85z/A9Q1kCbg6V53wAH906/nCVSEhw5joRBH4DA9QmJiVVrx+AbEU9JuM26N4exY3saw6i/Q53HLF9X8nZ911NYBhEOIGO126AV0E7altK0WUVOijaKk7orL13/WT/d6krfkUIdCf6ny/8xjPm+6xqF7myKZ8Wr4BFhBhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391932; c=relaxed/simple;
	bh=c9feIDL+wPu/P9Bna8cXPwQm7UA/Zrt/xWP3vAOeFJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKJfjefEXgmJnBX4Tau8VhRNIPMoSw1U6jduvvYUbkshDNbEZ3Vhz6mmjJ5OC1Wi/Xj1GvXh05B5FZbke1SjRFHVjoePuSexj3/L2Hts8p2lY2pSQEAZ2QfipTvsM88klrYTGIO6pNtVMvQsdrJtq+IAEuOuniMI785n04H/kKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcDdQ1ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200A5C433A6;
	Thu,  8 Feb 2024 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707391932;
	bh=c9feIDL+wPu/P9Bna8cXPwQm7UA/Zrt/xWP3vAOeFJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcDdQ1tssINDor/7etReaO6E+9DfS2U0syvI4DfMpqc3+QOLm5aprQYxRD/6AK67M
	 +bEsLNXQAMBw4VCZTq9Zu5niqscpAGJCnGO4WBdTewPVexU6muSYVo8Ej/FFQsHn4C
	 fl6XQCdSrir1oEEE99jplnpAj32ST8aBicm0HTb/W1Ttbb+AcEvynDNvcqhfgJGFRU
	 Ah4wbmaRVjvxFrISW7ADjV2pvNrQYeP8iBbObZ9ohLM3Ty4qQhVdKcYCf+5jE/IUFu
	 0bbyptByWK1UMrkv9KBxSmXcKkkV96jpUkrAMw+/yHOj55NJS7EUx120sUZbZRkw8p
	 KjkOCp3oPkzjg==
Date: Thu, 8 Feb 2024 17:02:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
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
	Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: [RFC 8/9] PCI/pwrctl: add PCI power control core code
Message-ID: <20240208113201.GA17587@thinkpad>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-9-brgl@bgdev.pl>
 <7tbhdkqpl4iuaxmc73pje2nbbkarxxpgmabc7j4q26d2rhzrv5@ltu6niel5eb4>
 <CAMRc=Md1oTrVMjZRH+Ux3JJKYeficKMYh+8V7ZA=Xz_X1hNd1g@mail.gmail.com>
 <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>

On Fri, Feb 02, 2024 at 10:52:11AM -0600, Bjorn Andersson wrote:
> On Fri, Feb 02, 2024 at 10:11:42AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Feb 2, 2024 at 4:53 AM Bjorn Andersson <andersson@kernel.org> wrote:
> [..]
> > > > +             break;
> > > > +     }
> > > > +
> > > > +     return NOTIFY_DONE;
> > > > +}
> > > > +
> > > > +int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl)
> > >
> > > This function doesn't really "enable the device", looking at the example
> > > driver it's rather "device_enabled" than "device_enable"...
> > >
> > 
> > I was also thinking about pci_pwrctl_device_ready() or
> > pci_pwrctl_device_prepared().
> 
> I like both of these.
> 
> I guess the bigger question is how the flow would look like in the event
> that we need to power-cycle the attached PCIe device, e.g. because
> firmware has gotten into a really bad state.
> 
> Will we need an operation that removes the device first, and then cut
> the power, or do we cut the power and then call unprepared()?
> 

Currently, we don't power cycle while resetting the devices. Most of the drivers
just do a software reset using some register writes. Part of the reason for
that is, the drivers themselves don't control the power to the devices and there
would be no way to let the parent know about the firmware crash.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

