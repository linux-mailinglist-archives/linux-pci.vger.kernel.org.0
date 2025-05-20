Return-Path: <linux-pci+bounces-28061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3886AABCE23
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 06:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA86717DD39
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 04:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECA37160;
	Tue, 20 May 2025 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnRYFi16"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296701E50B
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747714323; cv=none; b=N2yilIR+Zkm3jbwJrIBFMs2vjaADTgu6njJxb+G1MxzmSgiffLrJjU+cvls5bpvT0jTU8fPyx1awuiQCpb64HEc+6gGGw08iGd7+KmnkOVXrV/SMVrMoX6Ag0UBnH8SVWiCywduzh1yF0AZKYQ2HaRf39IduT9nOhzv5Ik5Y8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747714323; c=relaxed/simple;
	bh=+nVqLXQzAUXtU6rXQO/uDTq0S7NoZEiNzrVwzWurv+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbu/yTjhdM4b8ofTID0zAB6iF0gTcW2HrzFSg72jz+57+u01MLyJgglpzEfIjZnWuSOJp3Fb6Nv8MfVbwKXw+NA4N7+HgqTkEwCbca+a9LiRaMIAEnPSIjuKCM4MPY8ZhqNOFfq0tEX/0r5EKhSCGDK/wbt0xwGjnAOti8rdtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cnRYFi16; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-601609043cfso5448377a12.0
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 21:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747714319; x=1748319119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JJ4w6HZWC21taaNUcUkPdU1qr9/9bqU78LWPpUGReeQ=;
        b=cnRYFi16dHhcLVDckO+S3DSicyVKyQdvS7LM3aQfkuh5tSrgVBwfWXjNuGlq1sUn/O
         UNJiT2YbIqjoHZxNDNR4bqgGx2+L3k47CJWk8PxsgCamrSK5dd/6Rp+M4Vn8ZV2fs3b5
         rTf7xH1imQmMqcuXsyRkn6HnT1CoUBbAJ3YCwODRMsFNmALbgk1P5yl7G9GGz4KmRQao
         UEB0QhZO4GHOg9jBl3jSUvAyqJsPjPCJWW9gXsNqcqzOMycoP0S14uyOd3xc2iUN5E/d
         +/z1sr8os3AvhhkWpyAlKH+52qlxQijwwtnAhx5YZg8dmtUsHNjc4BVhxN3vnqo7qaW3
         4OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747714319; x=1748319119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ4w6HZWC21taaNUcUkPdU1qr9/9bqU78LWPpUGReeQ=;
        b=LlRNoIGkrIT8/rXbSSPlg3KOa7PIT0IMxrZqY11AWhrs/ItaaVQKB5LQr2V6ruGRwe
         sSuIjvlNDOBIvqv1pT2WnFslENa7gcDyFPi7f56DzsAJyr2Ahq/+0BuqzCUOSJVqilJa
         mPnzQtecrD5wp3hMymVwM7e7EPqj/14lTewKO1zaoUc9Z8dUhfqPp3qzHRFEnMiVf7cx
         BlabKWx9Ha+icsaUb2Z1w3GOrlUAzzpEVbAOnGXPxOpS9B5m4p7NJMDnnRMLzDsDDnCw
         8mXMYHx4vYfOUfWCVWrzKAI+c70hrcBsK72ZInoMRXxQzWHyePfdxvBRjT+z9mXREoII
         5OlA==
X-Forwarded-Encrypted: i=1; AJvYcCXDoLniV73Tfiu7dyHG7fwCYmAbDvNjx0LrhM02MnNcptGtIYmPxEiQchodSb8RsS5Ve3hZg6DGRf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPiE8owg83kWmfb6MATwJp0kYJ+LJQI8kZoahK22R42yGRkxqQ
	Aw1//bzgFm1cLijlB8vwkg3B6U7H5tGeroiQrhGQwdtYcAbrIB2qpj1DK8NEIttTzw==
X-Gm-Gg: ASbGncteOgU6t35X2DmeVf3rUal04D3xSEJOm5ZhXEWa7rxdW3L8rhsXOkjQO6bKAqj
	Qm4jwFLPP1elxBZs0oQXsevRzz43RZujR9iqEDNKYbDqvlYlIev4dTENCimvcq6pl1hBPRwV/Qr
	IhrpspFDxEOX0Vs7/WDDSXGeQkfbqSjzwJIkDnk1EGZqEM3yV/guaUHmFt0p7U+tO2blk7hjEPy
	5BOb3vURx7L5WWy++iYT1ycHOwE7rIRaURkISuHUpadLO0bJrcIAzsgFPpYpHkYHvqb7iFHOMZZ
	WXO/HT8e4sy6dB9ftXs71yCO6A8HyetdGiHfJDET/mZCBiyoBPb38PAkG/3UHitTzMeqLJ5nci0
	Ktf8zG74z7edl9vEfpvW4Cme4qRZ0OyikvQ==
X-Google-Smtp-Source: AGHT+IGAVrjm4vkS4WYOts9rGVN5WWFIGthPRmq8Gxw82A1ZUiahfTlT4Cg8JULY7ES5ySi4OyIccQ==
X-Received: by 2002:a17:907:d716:b0:ad4:f5ed:42db with SMTP id a640c23a62f3a-ad52d4b3699mr1556075266b.17.1747714319251;
        Mon, 19 May 2025 21:11:59 -0700 (PDT)
Received: from thinkpad (host-87-20-215-169.retail.telecomitalia.it. [87.20.215.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4381d5sm684049266b.99.2025.05.19.21.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 21:11:58 -0700 (PDT)
Date: Tue, 20 May 2025 05:11:56 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>, 
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 'Cyril Brulebois <kibi@debian.org>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, 'Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
Message-ID: <pxscvlfsvzaatjwty3bt3lpjmhhq4hriwmqo2s4vycwb27uvpq@m3afnghha5dd>
References: <CA+-6iNxkYumAvk5G6KhYqON9K3bwxGn+My-22KZnGF5Pg8cgfA@mail.gmail.com>
 <20250519215601.GA1258127@bhelgaas>
 <CA+-6iNzY4n=E+4Fcbxu7UU+xyUjEQZBSLQ3sMv26smoFS+nGOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzY4n=E+4Fcbxu7UU+xyUjEQZBSLQ3sMv26smoFS+nGOA@mail.gmail.com>

On Mon, May 19, 2025 at 07:03:18PM -0400, Jim Quinlan wrote:
> On Mon, May 19, 2025 at 5:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, May 19, 2025 at 03:59:10PM -0400, Jim Quinlan wrote:
> > > On Mon, May 19, 2025 at 2:25 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > > > On Mon, May 19, 2025 at 1:28 PM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > On Mon, May 19, 2025 at 09:05:57AM -0500, Bjorn Helgaas wrote:
> > > > > > On Mon, May 05, 2025 at 01:39:39PM -0400, Jim Quinlan wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > I recently rebased to the latest Linux master
> > > > > > >
> > > > > > > ebd297a2affa Linus.Torvalds Merge tag 'net-6.15-rc5' of
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > > > > > >
> > > > > > > and noticed that PCI is broken for
> > > > > > > "drivers/pci/controller/pcie-brcmstb.c"  I've bisected this
> > > > > > > to the following commit
> > > > > > >
> > > > > > > 2489eeb777af PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created
> > > > > > >
> > > > > > > which is part of the series [1].  The driver in
> > > > > > > pcie-brcmstb.c is expecting the add_bus() method to be
> > > > > > > invoked twice per boot-up, but the second call does not
> > > > > > > happen.  Not only does this code in brcm_pcie_add_bus() turn
> > > > > > > on regulators, it also subsequently initiates PCIe linkup.
> > > > > > >
> > > > > > > If I revert the aforementioned commit, all is well.
> > > > > > >
> > > > > > > FWIW, I have included the relevant sections of the PCIe DT
> > > > > > > we use at [2].
> > > > > >
> > > > > > Mani, Bartosz, where are we at with this?  The 2489eeb777af
> > > > > > commit log doesn't mention a problem fixed by that commit; it
> > > > > > sounds more like an optimization -- just avoiding an
> > > > > > unnecessary scan.
> > > > > >
> > > > > > 2489eeb777af appeared in v6.15-rc1, so there's still time to
> > > > > > revert it before v6.15 if that's the right way to fix this
> > > > > > regression.
> > > > >
> > > > > We need to find out what is happening in the pcie-brcmstb driver
> > > > > first. From Jim's report, it looks like the driver expects
> > > > > add_bus() callback to be invoked twice, which seems weird.
> > > >
> > > > The pci_ops add_bus() method is invoked once for bus 0 and once
> > > > for bus 1. Note that our controller only has one port.  If I do
> > > > "lspci" I get (our controller is on pci domain==1):
> > > >
> > > > 0001:00:00.0 PCI bridge: Broadcom Inc. and subsidiaries Device 7712 (rev 20)
> > > > 0001:01:00.0 Ethernet controller: Broadcom Inc. ...
> > > >
> > > > It is the second invocation of add_bus() that has the brcmstb
> > > > driver turning on the regulators and the subsequent link-up, and
> > > > this call never happens with the 2489eeb777aff9 commit.
> > >
> > > Actually, I don't think it is sufficient to just revert that one
> > > commit.  If I checkout 6.14-rc1 and just bring in
> > >
> > > 06bf05d7349c PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()
> >
> > 06bf05d7349c doesn't exist upstream; I assume it is 957f40d039a9
> > ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> 
> Hi Bjorn,
> 
> Yes, sorry, you are correct.
> 
> >
> > > I get the following after getting the Linux prompt:
> > >
> > > pci 0001:00:00.0: deferred probe pending: pci: supplier
> > > 1000110000.pcie:pci@0,0 not ready
> > > pci 0001:00:00.0: deferred probe pending: pci: supplier
> > > 1000110000.pcie:pci@0,0 not ready
> > >
> > > Basically, brcmstb already picks up and controls the regulator nodes
> > > under the port driver node.  You folks are adding a new generic
> > > system and we are stepping on one another's toes.  The problem here
> > > is that I cannot seem to turn your system off using CONFIG_PWR*
> > > settings.
> > >
> > > We would certainly be open to adopting your system when it meets our
> > > requirements; such as turning off/on on regulators @suspend/resume,
> > > and the ability to not do that if the downstream device has
> > > device_may_wakeup(dev)==true.  But until then we need a way to
> > > disable your system or allow brcmstb to "opt out".
> > >
> > > AFAICT this regression does not affect the RaspberryPi SoCs, so it
> > > is not a big deal for us if we take our time to fix this.   But if
> > > so, it is incumbent on you folks to help me get past this
> > > regression.  Is that reasonable?
> >
> > What systems does the regression affect?
> 
> All Broadcom STB chips, including the RPi sister chips.  Now is there
> anyone but our team who runs upstream Linux on our boards?  Probably
> not.
> 

I forgot to ask you this question. Is your devicetree upstreamed? Because, while
introducing the pwrctrl knobs, I made sure that there are no upstream users
using the supply properties in child nodes. All our existing users are using the
properties in controller nodes, so they are not impacted.

Here it looks like you are running out-of-tree dts, which we do not support
unfortunately. But it doesn't mean that I do not care about the issue you
reported. I'm flying back home from vacation tomorrow and it will be the first
thing I'm goona look into.

Adding suspend/resume support is pretty much what I'm going to work on the
upcoming weeks (combined with some rework). So until then, I request you to
revert the changes in your downstream tree and bear with me.

Bjorn, FYI: We do not need any revert in mainline since the issue is not
affecting upstream users.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

