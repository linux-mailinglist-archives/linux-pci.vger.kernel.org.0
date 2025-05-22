Return-Path: <linux-pci+bounces-28264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1DAC08E8
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 11:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F03C188E3C7
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37031264610;
	Thu, 22 May 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIFUBnD2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066D17BB6
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906926; cv=none; b=F0iG1VxG6BNon8FPaI59D/IB90+oB6+xAxThmc/OdTjiYOw5OG1WQtoLW864OKSZ4DoWZ3JiEUo/KGuBSlJhp/Y5cKD+pvCRJ2BdDElHMF/NX7KFQwDWm+abaEwUY9N4G6fKso0krX73dRv31W7O4G2sKWedV9Y5Qk6JqnuQq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906926; c=relaxed/simple;
	bh=AaXVgDa1eBKpI8kWchWJy0Boh6XId2G2feXa2Caqkh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY8VeCv9G1U9yE+7U/f7IeQIbhIpPiav3GERlCiKfyJ0nsdq+YwLeDjWQrPZnqxUR27eOBkJFdHnsJ41wPBUIIX8h1alPSHsKa/CfVDKaeM1LNNaoqb6gUSOvDyqyo3FVfUjsYY49SrjhelpNrWwYrQ6jrZBu8NOaWWGVuOQXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIFUBnD2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33677183so62996595ad.2
        for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747906923; x=1748511723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2W9pDs2fUjwyXWIYRNrL2TSTjfx1+/7VESqDmUiYB7s=;
        b=LIFUBnD2EV0SwfbHxnO/OQ/Kf2GSHNu23tMpeq7xB2GC+X/WxUPq0H9Bd12e6DZAsR
         MQk0bIXYnfpx/V6XHJB3bL21ZEBA+Hq8mQUnQtPOUoEq5kZWsjvogdFoWH51ZZx8cCmH
         oW6tGcH6RljwdxURZZuDFGCigWXmflCgJmz1CRp9n57VjxPHMpfHhLwzEuDOlhLNHnjc
         5c12MDaxnd9ArXK5QXc42VnlVwT7T2qKv2I3iRKA9nYyKw+5IH0nvZpSzvkTFIxJBWmg
         TnGoUnl1rog/NzuryhMCqDBIR6/IK/IJyHxWz13nHOjWXvxLbi4TVJMz06R4QvrbkJIT
         Hw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747906923; x=1748511723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W9pDs2fUjwyXWIYRNrL2TSTjfx1+/7VESqDmUiYB7s=;
        b=aGtDWGEiQiOOmYR1Q3UY4kvyNjwHfe46bvLca5+quk+RpH0NcTPqYg2eVD+KW8xmvt
         i+4gmOcJPPFduSTUZgdkUtLVitbyaQN3j2WqBcFBzJgDqsFL8su/9zTxgM+RX9B/om57
         k8DDFT0nbcACK3OrKGo12XQstApkpRrNO7SgmtxL8x92C3akZkxG9875dkWdRge4g4Kf
         7cFGMjlveZt+GaCrbNKmDHAbGWNktu53W9RuNfzPYX49ndODsJPcKurioao89E8TOroA
         bBCIjzVpHaem6GUaUGaezMuVcUdes9hNZrxSYrNz0dGANPkjdVaafvcl4SaEYqaAOZn2
         FzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVblun3kbutd+Ro7qnigBTcRL2WyaZUq0ek9kFjYxXwObCeS3OKJT797bWQ5SGwP40hltZzOdgfQlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNMWrF9ebLbLTiNHEkNe31r70xqrDuzNWNHJqfY4sSjq0v4RT
	B/90Y1xmm2eIYz7551/i+JQthY/nqPUH7b59AS/pTRvHee7TSxCMTljtj/N64vie+g==
X-Gm-Gg: ASbGncvTt81w9tdLM9jLh0SkuRq33lGTGkte7P8MhM8KQ2G/LWYhZUGHtkubnWqtepi
	GjykGcNeEHZbu3yCdYNKxK60ZRx2Y8oBafWeqC+wk+2zUUvVMJ6Q170jFGSCFl8yv0L5ueYglv6
	CQTeeydRcyuP3JI9gFx5jdcKEqnj8VvPFJXCQZKEvFE1e35f/1vhxXDTFbvNxgLgZ1wiWOkNbcG
	WX25Xy6bNCirGprI2C0ydNkefrxCgInlAwFW+x0x30wIbm167EnT804pV9WHQ9D4WWTQzzsEl5r
	CbdIPnUEQOaFO4NuG2gmzrsaxhhNi6LpzRJlvjl7/zpSq9gf1CVg3a3T139rlw==
X-Google-Smtp-Source: AGHT+IEC8lIoCISzMMJj1zQvnTEQ9Ckv+Jlw2n1VOmoUYBsbME34b4s+KjzcmPoCAmRhfzBt6vRNRg==
X-Received: by 2002:a17:902:dac5:b0:22e:4509:cb89 with SMTP id d9443c01a7336-231de21d4d5mr320912565ad.0.1747906923409;
        Thu, 22 May 2025 02:42:03 -0700 (PDT)
Received: from thinkpad ([120.60.130.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebac18sm105471675ad.193.2025.05.22.02.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 02:42:02 -0700 (PDT)
Date: Thu, 22 May 2025 15:11:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 'Cyril Brulebois <kibi@debian.org>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, 'Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
Message-ID: <vazxuov2hdk5sezrk7a5qfuclv2s3wo5sxhfwuo3o4uedsdlqv@po55ny24ctne>
References: <CA+-6iNxkYumAvk5G6KhYqON9K3bwxGn+My-22KZnGF5Pg8cgfA@mail.gmail.com>
 <20250519215601.GA1258127@bhelgaas>
 <CA+-6iNzY4n=E+4Fcbxu7UU+xyUjEQZBSLQ3sMv26smoFS+nGOA@mail.gmail.com>
 <pxscvlfsvzaatjwty3bt3lpjmhhq4hriwmqo2s4vycwb27uvpq@m3afnghha5dd>
 <CA+-6iNz-qyKDKif5mv5FProqbpkQdfOYx+nSUA4NHSiCL9Ng5Q@mail.gmail.com>
 <uye7kpakmj5vx6bdzzy4tsmqqi777rhdb273tqsvgr6tv27apy@jyneanv3blit>
 <CA+-6iNwTkrmVWuitrmkLJ+=B935LFuK6Q91obMWe03v7sZ_MCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwTkrmVWuitrmkLJ+=B935LFuK6Q91obMWe03v7sZ_MCQ@mail.gmail.com>

On Wed, May 21, 2025 at 06:08:14PM -0400, Jim Quinlan wrote:
> On Tue, May 20, 2025 at 7:40 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, May 20, 2025 at 11:06:33AM -0400, Jim Quinlan wrote:
> >
> > [...]
> >
> > > > > > What systems does the regression affect?
> > > > >
> > > > > All Broadcom STB chips, including the RPi sister chips.  Now is there
> > > > > anyone but our team who runs upstream Linux on our boards?  Probably
> > > > > not.
> > > > >
> > > >
> > > > I forgot to ask you this question. Is your devicetree upstreamed? Because, while
> > > > introducing the pwrctrl knobs, I made sure that there are no upstream users
> > > > using the supply properties in child nodes. All our existing users are using the
> > > > properties in controller nodes, so they are not impacted.
> > > Hello Mani,
> > >
> > > Our device tree is constructed on the fly by our custom bootloader
> > > and passed to Linux, so it does not make sense (IMO) to put them
> > > upstream as long as we strictly follow our upstreamed YAML bindings
> > > file.  As I mentioned before, our  brcm,stb-pcie.yaml example, which
> > > is upstream, contains a "vpcie3v3-supply" property under the pci@0,0
> > > node.
> > >
> >
> > Okay, thanks for the pointer. I was not aware that you have bootloader
> > constructed DTB.
> >
> > > >
> > > > Here it looks like you are running out-of-tree dts, which we do not support
> > > > unfortunately.
> > > The brcmstb YAML file is upstream, and a grep for the standard pcie
> > > regulator names would have led you to it. I don't see how you can say
> > > you don't support a DT that follows the upstream YAML file(s).
> > >
> >
> > I didn't say that exactly. I thought you were using some out-of-tree vendor DTS
> > which doesn't adhere to the DT bindings, but I was wrong. Your usecase is
> > completely valid.
> >
> > > But it doesn't mean that I do not care about the issue you
> > > > reported. I'm flying back home from vacation tomorrow and it will be the first
> > > > thing I'm goona look into.
> > > >
> > > > Adding suspend/resume support is pretty much what I'm going to work on the
> > > > upcoming weeks (combined with some rework). So until then, I request you to
> > > > revert the changes in your downstream tree and bear with me.
> > >
> > > I would rather our systems peacefully coexist, and take your changes
> > > voluntarily and on my own schedule, rather than wait for you to add
> > > future features.  I'm a little surprised that the CONFIG_PCI_PWRCTL
> > > code seems to act on the PCI regulators even when its driver is not
> > > present.
> > >
> >
> > I overlooked at that part. Would the below diff help you?
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 4b8693ec9e4c..b38a62f40448 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2514,6 +2514,9 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
> >         struct platform_device *pdev;
> >         struct device_node *np;
> >
> > +       if (!IS_ENABLED(CONFIG_PCI_PWRCTRL))
> > +               return NULL;
> > +
> >         np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> >         if (!np || of_find_device_by_node(np))
> >                 return NULL;
> >
> Hi Mani,
> Yes that works but I have to set
> 
> CONFIG_ATH11K=n
> CONFIG_ATH12K=n
> CONFIG_ATH11K_PCI=n
> 
> in order to get
> 
> CONFIG_PCI_PWRCTRL=n
> 
> This would be a problem if we had a customer system that required
> ATH1[2].  We do have one with ATH9k but we are safe for now.

Yeah. I do not intend to make it as "the fix", but just a workaround to get your
driver working again. The actual fix would be to convert your driver to use the
pwrctrl framework, which I'll do soon.

> >
> > > In addition, I need the ability to cancel at runtime the
> > > suspend/resume off/on of the regulators if the downstream device.
> > >
> >
> > I don't get what you mean by 'ability to cancel at runtime'. Like I said before,
> > I'm going to rework pwrctrl little bit and probably add suspend/resume (system
> > PM first) on the way, if that's what you are referring to.
> 
> If you look at  drivers/pci/controller/pcie-brcmstb.c and search for
> brcm_pcie_suspend_noirq(),, you will see that we only turn off/on the
> regulators on suspend/resume if the downstream device has
> device_may_wakeup(dev)==false.  We discover this at runtime by walking
> the bus.  The idea here is to support an optional  WOL scenario.
> 

Oh yes! Supporting WOL is indeed a requirement when the system PM support is
added to the pwrctrl framework. Also do note that some endpoints like NVMe would
like to keep the devices in D0 during suspend. So if you connect it to your
platform, it most likely will not work during resume. I'm also intending to fix
it.

> I'm currently inquiring whether we can lessen this requirement somehow
> and will let you know when I get the answer.
> 

I don't think it is needed. We should support it anyway.

> >
> > > That being said,  I don't mind if the series stays as long as you
> > > promise to work with me to have our systems coexist.  But I do not
> > > want to wait for future features to be added for our code to work.
> > > >
> > > > Bjorn, FYI: We do not need any revert in mainline since the issue is not
> > > > affecting upstream users.
> > >
> > > So is it a rule that all DT  must be upstreamed, or is it sufficient
> > > to have a bindings YAML file that defines the DT for the driver?
> > >
> >
> > The latter IMO. If the diff I supplied above works fine, I'll submit a patch for
> > that. Eventually, we do like to control the supplies from the pwrctrl driver
> > instead of from controller drivers. That's the whole point of introducing this
> > framework. But since it is not enabled in defconfig yet, your driver should
> > continue working in the meantime with the diff. Later on, I will modify brcmstb
> > driver to adapt to pwrctrl framework. Since the binding is same, the driver is
> > going to be backwards compatible also.
> >
> > Please let me know if it works of not!
> 
> Yes it does work.  Not a perfect situation, but it will keep me going
> as we move toward having the pcie-brcmstb driver move to the pwrctrl
> framework.
> 

Thanks a lot for testing. I will push out a patch with your tested-by tag.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

