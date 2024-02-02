Return-Path: <linux-pci+bounces-3035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C074A847563
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F461C27526
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189C14A0B6;
	Fri,  2 Feb 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2D9EslL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB6148FFA;
	Fri,  2 Feb 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892736; cv=none; b=msi8S+hEbvxEt3m6/f87l00AbL7gQdvMu/cZjDzUMqlj8LoUYYIxpW0mXxU2PFWzcDOxmJ9i9ij1JaZsJbWgbRLkHrkgYdz+SRLGjlQ+Jq1gMdRGAbDVWQjb4taRStSvnFpKD9aVzhZ0DdMBITp97486PwLac1x9HHizBAEICTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892736; c=relaxed/simple;
	bh=o6Wk5X1+6XzuAVSiW3qXZI3/x4eFqjgXnq87Cvd29GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtCb91fRUVqajnrpaQ8mpoiCY35U8T8pPscEXWaDjmmgRE5Keg5lzI8TOmU61kHf37d9HRYGdVfS5TVy4gKZ+04/lomprZhrd9RQGNsie80i0E0IQEpuCX9LmZkyWwbjevTADjaOfNLx0/caBBi4q0vJQrbQuxYNfI7EtxVzt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2D9EslL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E628FC433F1;
	Fri,  2 Feb 2024 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892735;
	bh=o6Wk5X1+6XzuAVSiW3qXZI3/x4eFqjgXnq87Cvd29GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2D9EslL+3JfRKRa4YVOQ6d3cpGJBLXuXVPoK7d3gweqK5VgBTvQvTMm2uTxWg6AF
	 FsjPVQ23903rAzgBgl5LC+dLx7E8JI8a0il9LUcp5exeLA6UXPHIaTwBOcZXr3Wk0H
	 661iqFLChJGxHaRXPSNiTN6dEtPMs4YFlogPE7ooBrt6vw/g0iv9J50tlIBW0sNAlH
	 QG6wEOudTpX/y3Ilp/dsZYX1XCfdEdR0GJxfyR4yrtOZMJColGW8gdbvr41Nnebooa
	 BK8OadhTp8LBEa3R1tzpgx4xwZ2KXER3c2SW6NHaAaBia9jiZq6JjEGIsZ9rEfLmQE
	 5RZOmsYJmtOJw==
Date: Fri, 2 Feb 2024 10:52:11 -0600
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
Subject: Re: Re: [RFC 8/9] PCI/pwrctl: add PCI power control core code
Message-ID: <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-9-brgl@bgdev.pl>
 <7tbhdkqpl4iuaxmc73pje2nbbkarxxpgmabc7j4q26d2rhzrv5@ltu6niel5eb4>
 <CAMRc=Md1oTrVMjZRH+Ux3JJKYeficKMYh+8V7ZA=Xz_X1hNd1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md1oTrVMjZRH+Ux3JJKYeficKMYh+8V7ZA=Xz_X1hNd1g@mail.gmail.com>

On Fri, Feb 02, 2024 at 10:11:42AM +0100, Bartosz Golaszewski wrote:
> On Fri, Feb 2, 2024 at 4:53 AM Bjorn Andersson <andersson@kernel.org> wrote:
[..]
> > > +             break;
> > > +     }
> > > +
> > > +     return NOTIFY_DONE;
> > > +}
> > > +
> > > +int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl)
> >
> > This function doesn't really "enable the device", looking at the example
> > driver it's rather "device_enabled" than "device_enable"...
> >
> 
> I was also thinking about pci_pwrctl_device_ready() or
> pci_pwrctl_device_prepared().

I like both of these.

I guess the bigger question is how the flow would look like in the event
that we need to power-cycle the attached PCIe device, e.g. because
firmware has gotten into a really bad state.

Will we need an operation that removes the device first, and then cut
the power, or do we cut the power and then call unprepared()?

Regards,
Bjorn

> 
> Bart
> 
> [snip!]

