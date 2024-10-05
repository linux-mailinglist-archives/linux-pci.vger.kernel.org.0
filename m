Return-Path: <linux-pci+bounces-13882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A583C99145D
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 06:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D8DB2301D
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 04:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2B27473;
	Sat,  5 Oct 2024 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShvWWMPI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E5200A0;
	Sat,  5 Oct 2024 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728104198; cv=none; b=RRjmcux1zyr6es/oHz1u8ZgE41gMI27eP/zxq2+fIGMK6MrjxwA0mDPRi/OcJbWFP6pCT4a1JIwUhYn266DK7Xbw0+a2XLomqmfKr6uI81ORzHS/XbyRPOdor54nMeMEcJ17JYPEAmVc2Oh4HDPykzXdTIPVCpsbAEdcRdKCzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728104198; c=relaxed/simple;
	bh=94QPiCMy4HQWSMIX0zaNCQ+EuyvV/a4vuL65JXOgun8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMsd87dhHwjNKMHJVEcJtwBKXe8KUZm17v4QbbYDpf6cLDgXcuW4KZ8oWzCDGmQ906ee4sQnLmn3hLCqUPboO2huuDoL4kAEfxAWpBpPMqkEqdNOyqFH32wEIfDobIBOLeQUfxfEB7KTdK5ety6vZsQZYFeXaOKlv7MZc86JZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShvWWMPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9A1C4CECD;
	Sat,  5 Oct 2024 04:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728104197;
	bh=94QPiCMy4HQWSMIX0zaNCQ+EuyvV/a4vuL65JXOgun8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShvWWMPILPNnHx7vupAmuEpX2KmTobDyNFJ80YDRVSCB+iaJMajGy72S36rPZiH0q
	 ejza6VH1dcRTaytfFes/U/TG3WyffxKJrunn0MRaTstgCWoptT3EpbcaGVFeyOKxRl
	 UQvljSs68rIeRfv/fgdAbVzI5zn5Ekij1WasCyzEY/ioYdXVpzD2vPqH6PdFVz8JBZ
	 Q9Oe21eQ3sNELVyMdpO2SyKwot0LiGqEJ5cN4Fv8KKw9NE1X1WnFzaU/pni70IDwmP
	 WhPPJ24X5qh65w4C1ylg3Pe7yhyVzYDgMOthcPVDU0vr+i5i/gF6c99kkuZw/ASrqD
	 NBNCliFGvOPtg==
Date: Fri, 4 Oct 2024 23:56:35 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH] PCI/pwrctl: pwrseq: abandon probe on pre-pwrseq
 device-trees
Message-ID: <hprji6khyermqaw4lsla573elajv4omyn3bzh4aw3e6kiawz6i@glxqiyb2zwvk>
References: <20241004125227.46514-1-brgl@bgdev.pl>
 <rog6wbda7rdk6rebjyprnofgz4twzpg6kt4pnmeap4m4hga532@3ffxora5yutf>
 <CAMRc=MekMuV6ULeX_x8mgQiL=XoHuH3PrJLihqucWqowN-YRLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MekMuV6ULeX_x8mgQiL=XoHuH3PrJLihqucWqowN-YRLQ@mail.gmail.com>

On Fri, Oct 04, 2024 at 07:59:41PM GMT, Bartosz Golaszewski wrote:
> On Fri, Oct 4, 2024 at 7:31 PM Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > >
> > > +     /*
> > > +      * Old device trees for some platforms already define wifi nodes for
> > > +      * the WCN family of chips since before power sequencing was added
> > > +      * upstream.
> > > +      *
> > > +      * These nodes don't consume the regulator outputs from the PMU and
> > > +      * if we allow this driver to bind to one of such "incomplete" nodes,
> > > +      * we'll see a kernel log error about the indefinite probe deferral.
> > > +      *
> > > +      * Let's check the existence of the regulator supply that exists on all
> > > +      * WCN models before moving forward.
> > > +      *
> > > +      * NOTE: If this driver is ever used to support a device other than
> > > +      * a WCN chip, the following lines should become conditional and depend
> > > +      * on the compatible string.
> >
> > What do you mean "is ever used ... other than WCN chip"?
> >
> 
> This driver was released as part of v6.11 and so far (until v6.12) is
> only used to support the WCN chips. That's not to say that it cannot
> be extended to support more hardware. I don't know how to put it in
> simpler words.
> 
> > This driver and the power sequence framework was presented as a
> > completely generic solution to solve all kinds of PCI power sequence
> > problems - upon which the WCN case was built.
> >
> 
> I never presented anything as "completely generic". You demanded that
> I make it into a miraculous catch-all solution.

That is correct. I strongly requested that you would come up with a
solution that worked for BOTH (all two!) use cases we had on the table
for PCI power sequencing.

> I argued that there's no such thing and this kind of attitude is
> precisely why it's so hard to get anything done in the kernel.

I'm sorry that you feel it's my attitude that's the problem here. I
don't think that is what make this hard, but rather the technical
challenges of the problem itself.

Regards,
Bjorn

