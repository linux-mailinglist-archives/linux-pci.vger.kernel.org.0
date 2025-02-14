Return-Path: <linux-pci+bounces-21437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84339A359FB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C98188F459
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7622D79B;
	Fri, 14 Feb 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dO2qEulz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0322D7A9
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524516; cv=none; b=S3F9zmk3RixggVhpNAbTM5cDW7Ynp2i8FXkE0hDQxb5yf+C6MtR63NmbLPw+V58j+rW8KpDoiIcSnvu9Lbdc5+A8fsNDbnlk5xnB5w3WnmH/IwkLALPCV2xzO5LrTqwDPIbspXxAz5K41TAIW78d1Fj6X+6mU2aBC8I2kISmeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524516; c=relaxed/simple;
	bh=QxHskxdW/qJjXxEJcEm4iVwJnioMXvYvEwhtNkBIjkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is5tyi4gJ1JaUkqGQBBoV0VjEgela/Gg6GmCfAntsuOJuOCDcIoxS4H4ND/1i2Tkps2qFrIpY23tXJYAKuIDFGTkB4Qy+JB/9Org6DgLVOaHe31svOafgbuLr+ETBt9RBr+zr3sBTSLIOkUzvV4UtH/FY622EJz5eeUPMBbZlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dO2qEulz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220f048c038so5821405ad.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 01:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739524514; x=1740129314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1jlwoC2zjFhnW0Vq5XcHJakPinqL/GE+axFVuCQmJjg=;
        b=dO2qEulzIPYnmXewk4PkzDlcoLI1NJUJYMUFGpNxK7ciR3xT0mB8eQaPiyUhiMGqTx
         HWWDlhQBZKX6hG/7h0xAa0QOckvRYQkcOKxmoUwYhVlsLKGU6pDvHeBzxuOEvPv9B52+
         QHUDAO0b6VTgdFB5xtsIdWOxhjjXA84mjJHsW/TBntWv+Gfy+xC0+2buLCPSnlqk5kqX
         YTrnE8yCzu0STeTx8KV6hFp+lML2UGnWtBmHJOzP0zSTA4CgpygJV4+ihtkvdSoXTPsg
         Xvhq3zXbmow/zlL05e6cazY5PyB2njFg/CcqIDYxXeFHPq5CU5jS84yGnKn5vXFANwbF
         6cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524514; x=1740129314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jlwoC2zjFhnW0Vq5XcHJakPinqL/GE+axFVuCQmJjg=;
        b=K9ZXvILpQXnbD1hR6AaaoDq69mjX4+CovG0b0cBUhoihJ1RvNJGLbzIRVwVyicr7AQ
         LSvGX/wc4sYragJsaqJdx7N8NKpLI5Y9TKehSQ0h0lgRIKZBwk0U+HWrqaCvXBZZpk9L
         avDaJgE7rab9AtVqMajnPWi8tlahLTxKcBYAC0Ho0qzdAhcOr/0kGUi0XHexYX9eVH2X
         AyB30mMuCECjrBdQrUggysFguRr/OjsaDUepe1ImOTEAEBPCyZApz9rHqcAoIaMDLxCO
         tC0106xBL9kTYmdU/npeQyEiT7+uUwX7yI9/DOmQx/ZyQcEr2sndBKoyV1aE/mphPE+C
         zgEg==
X-Forwarded-Encrypted: i=1; AJvYcCXKj9KFMNK0szt9yXEzuWxjHOLiMF6t0hO6fVI1UIMUBFPB/LeePT7wR9bgJIlJi9AnPZsIAiGgmBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GaUUgSM+O0wonedynCstmBaN9GkBDI6W+KQfsBLPu0GCMuCU
	zTu5VVFoBaj1llDlzKiMmaEkh7lBJEp0zBrfvQ6d97nvqeRuX1ph4Pc/hGTjaQ==
X-Gm-Gg: ASbGncuoa41Wq8aFV0l8CBnZsaDOKjofG/O31c5B2tPe52TPBWdG/PHgWk2LgzfsdF5
	pUYrEtfP2p8D+DO26AatouHhjZ/HcEwi50P0E41rH9/kPLr29QeRraVVezcAhxw5Lo/OVGUWUoV
	rGoQaQ2Ad0ktHNaf6DJuCtf8B6ITO0J0KnT7RsPOb4BSodvcvckdtMdL14mqm38o9XA6zU6FAMa
	CBhiI6F9sg2xE3AGhEcodrQJDwM99mwix3OeFEYRWUs21lBN/LJDocoDqoRJ8j+Vj4fimAuEpey
	CWDmFgDGlG1PJ7nEMmUo3eyBv35ZGn+4sVOd3YZUgqV42hdmov6+khzfnQ==
X-Google-Smtp-Source: AGHT+IH4EvOn3P2caP6RoKOlQbciczdicneio523CKYdKle4bgTr8IdvpxPYFwTfK/NAEbRF7jghKA==
X-Received: by 2002:a05:6a21:730a:b0:1ee:6af5:e4f1 with SMTP id adf61e73a8af0-1ee6b33e88emr13660066637.13.1739524513379;
        Fri, 14 Feb 2025 01:15:13 -0800 (PST)
Received: from google.com (49.156.143.34.bc.googleusercontent.com. [34.143.156.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324277f4b5sm2685551b3a.168.2025.02.14.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:15:12 -0800 (PST)
Date: Fri, 14 Feb 2025 14:45:03 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <Z68JlygEqQBSDWPA@google.com>
References: <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
 <Zeha9dCwyXH7C35j@google.com>
 <20240310135140.GF3390@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240310135140.GF3390@thinkpad>

On Sun, Mar 10, 2024 at 07:21:40PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 06, 2024 at 05:30:53PM +0530, Ajay Agarwal wrote:
> > On Wed, Feb 28, 2024 at 10:59:51PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Feb 20, 2024 at 11:04:09PM +0530, Ajay Agarwal wrote:
> > > > On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > > > > + Joao
> > > > > 
> > > > > On Mon, Feb 05, 2024 at 04:30:20PM +0530, Ajay Agarwal wrote:
> > > > > > On Wed, Jan 31, 2024 at 12:06:26AM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Tue, Jan 30, 2024 at 10:48:59PM +0530, Ajay Agarwal wrote:
> > > > > > > > On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > > On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> > > > > > > > > 
> > > > > > > > > [...]
> > > > > > > > > 
> > > > > > > > > > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > > > > > > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > > > > > > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > > > > > > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > > > > > > > > > experience.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > If there are any other usecases, please state them.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > - Mani
> > > > > > > > > > > > >
> > > > > > > > > > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > > > > > > > > > being enumerated need to go through an appropriate and device specific
> > > > > > > > > > > > power sequence which gets triggered only when the userspace is up. The
> > > > > > > > > > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > > > > > > > > > hence the link-up is not attempted.
> > > > > > > > > > > 
> > > > > > > > > > > Still, I do not see the necessity to not call start_link() during probe. If you
> > > > > > > > > > I am not adding any logic/condition around calling the start_link()
> > > > > > > > > > itself. I am only avoiding the wait for the link to be up if the
> > > > > > > > > > controller driver has not defined start_link().
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I'm saying that not defining the start_link() callback itself is wrong.
> > > > > > > > > 
> > > > > > > > Whether the start_link() should be defined or not, is a different
> > > > > > > > design discussion. We currently have 2 drivers in upstream (intel-gw and
> > > > > > > > dw-plat) which do not have start_link() defined. Waiting for the link to
> > > > > > > > come up for the platforms using those drivers is not a good idea. And
> > > > > > > > that is what we are trying to avoid.
> > > > > > > > 
> > > > > > > 
> > > > > > > NO. The sole intention of this patch is to fix the delay observed with _your_
> > > > > > > out-of-tree controller driver as you explicitly said before. Impact for the
> > > > > > > existing 2 drivers are just a side effect.
> > > > > > >
> > > > > > Hi Mani,
> > > > > > What is the expectation from the pcie-designware-host driver? If the
> > > > > > .start_link() has to be defined by the vendor driver, then shouldn't the
> > > > > > probe be failed if the vendor has not defined it? Thereby failing the
> > > > > > probe for intel-gw and pcie-dw-plat drivers?
> > > > > > 
> > > > > 
> > > > > intel-gw maintainer agreed to fix the driver [1], but I cannot really comment on
> > > > > the other one. It is not starting the link at all, so don't know how it works.
> > > > > I've CCed the driver author to get some idea.
> > > > > 
> > > > > [1] https://lore.kernel.org/linux-pci/BY3PR19MB50764E90F107B3256189804CBD432@BY3PR19MB5076.namprd19.prod.outlook.com/
> > > > > 
> > > > > > Additionally, if the link fails to come up even after 1 sec of wait
> > > > > > time, shouldn't the probe be failed in that case too?
> > > > > > 
> > > > > 
> > > > > Why? The device can be attached at any point of time. What I'm stressing is, the
> > > > > driver should check for the link to be up during probe and if there is no
> > > > > device, then it should just continue and hope for the device to show up later.
> > > > My change is still checking whether the link is up during probe.
> > > > If yes, print the link status (negotiated speed and width).
> > > > If no, and the .start_link() exists, then call the same and wait for 1
> > > > second for the link to be up.
> > > > 
> > > 
> > > There is a reason why we are wating for 1s for the device to show up during
> > > probe. Please look at my earlier reply to Bjorn.
> > >
> > Yes, I looked at that. I am not sure if that is the real reason behind
> > this delay. The explanation that you quoted from the spec talks about
> > allowing 1s delay for the EP to return a completion. Whereas the delay
> > here is to wait for the link training itself to be completed.
> > 
> 
> It is implied, afaiu. But the best person to comment here is Lorenzo.
> 
> > We could surely wait for Lorenzo to explain the reason behind this
> > delay, but he himself approved the earlier patch [1] (which caused the
> > regression and had to be reverted):
> > 
> 
> This is not a valid argument.
>  
> >  [1] https://lore.kernel.org/all/168509076553.135117.7288121992217982937.b4-ty@kernel.org/
> > 
> > > > > This way, the driver can detect the powered up devices during boot and also
> > > > > detect the hotplug devices.
> > > > >
> > > > If the .start_link() is not defined, how will the link come up? Are you
> > > > assuming that the bootloader might have enabled link training?
> > > > 
> > > 
> > > Yes, something like that. But that assumption is moot in the first place.
> > > 
> > Isnt it weird that a PCIe driver, which will most likely initialize all
> > the resources like power, resets, clocks etc., relies on the bootloader
> > to have enabled the link training?
> > 
> 
> That's why I said that assumption is 'moot'.
> 
> > I think it is safe to assume that a driver should have the start_link()
> > defined if it wishes to bring the link up during probe.
> > 
> 
> I keep repeating this. But let me do one more time.
> 
> There should be a valid reason for a driver to defer the start_link(). In your
> case, the problem is you are tying the driver with the Android usecase which is
> not going to work on other platforms. What is worse is, you are forcing the
> users to enable the link training post boot. It may work for you currently, as
> you need to bring up the endpoint manually for various reasons, but what if some
> other OEM has connected an endpoint that gets powered on during the controller
> probe? Still the user has to start the link manually. Will that provide a nice
> user experience? NO. Then the developers will start complaining that they cannot
> see the endpoint during boot even though it got powered up properly.
> 
> Second, we cannot have different policies for different drivers to start the
> link unless there is a valid reason. This will become a maintenance burden. For
> sure, there are differences in the current drivers, but those should be fixed
> instead of extended.
> 
> So to address your issue, I can suggest two things:
> 
> 1. Wait for Lorenzo to clarify the 1s loop while waiting for link up. If that
> seem to be required, then keep this patch out-of-tree. Btw, your driver is still
> out-of-tree...
> 
> 2. Try to bringup the endpoint during boot itself. We already have a series to
> achieve that [1].
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20240216203215.40870-1-brgl@bgdev.pl/
> 
> -- 
> மணிவண்ணன் சதாசிவம்

Hello Mani

Restarting this discussion for skipping the 1 sec of wait time if a
certain platform does not necessarily wish or expect to bring the link
up during probe time. I discussed with William and we think that a
module parameter can be added which if true, would lead to the skipping
of the wait time. By default, this parameter would be false, thereby
ensuring that the current behaviour to wait for the link is maintained.

Please let me know if this is worth exploring.

