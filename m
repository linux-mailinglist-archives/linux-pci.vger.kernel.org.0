Return-Path: <linux-pci+bounces-26023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307E5A909B1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 19:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934E31895437
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC37215F58;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a5sosI7U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A68215F4C
	for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823699; cv=none; b=m7vdvCP3hCz58kNfE+4FBI9BFqkfRE3UfbHarMcLf6RzEnUU2U+0cWwPsjCI/O7/rp0Td4Z9rttTZM9Vbz2uds1oz1bFhUFcRT6X/4LsZR5QGWR7P4jgDOrslFo9jl6iEZpabnt93Aa6BLlvPlKniLz4N0Fs7pSUeJUKPFfqzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823699; c=relaxed/simple;
	bh=9SkCY6iihCFwj7IPPmUbxABHAZCNX2kKzqx/NAUf1WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFS7aAgUTu27GJfkaeVVS67o4AKqpxHPh3fLU8XkMfbpaJsx24NyFaGVGHlOrefi6Man4WgVjmug1FVHJjN8+CZuMcRxleXN+3ii8ZRorzK4Iz/2bjJwXB26FWOhQQFjh4TqjhlEQagpcKGdIN0pB0ep/o4Ow0yO5ljBib+2fBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a5sosI7U; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2279915e06eso77433665ad.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2025 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744823697; x=1745428497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVzvcllkC0jfEMoiDKBA8hFV4BOeetLydl7c79dBAS4=;
        b=a5sosI7UFJ5dwWyiuI0ZS6uta22vYc+y6dL0D1YwBsBtGBdMpqT1MTFlvgjL4MI0Yv
         30efuyq5xl9nhMUIf+/bVL15I9N2cEohFz4GJlrnuMRh5lWRrFRWkHpDM4LsPjl9AVZv
         zZzg3f/1eyCbfOmJ3ioF1l6hOboE4BNAVbRZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744823697; x=1745428497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVzvcllkC0jfEMoiDKBA8hFV4BOeetLydl7c79dBAS4=;
        b=oi9hPifoax1h057enRBODu7XF245+wnOoK82L1Scx4aOdYzz6Kyzxh6Ja9gHugfyxW
         rKAgHg3U/B4FY3gzNxScYSf7t2x5OOISlYFMXo3hjbcc0Oq63F7PPCQvEWYAk4LVoVRe
         8dK3y21Npw3z7yMkGxxBs6IxRlpOljWO+tmh5gmOtDu4850MyXgXnDSc/7Vxvw4KhBx6
         dAwJmXEY9/IO3/IHqVpb0CZg6PITt3aWVRm51+zYP6FFGzW6Tta4KVcEcb9MehROHULs
         qP2H5QShvgMQXLymVEXyfbn7/lG7DeAM5Fp/HIWMtVI3v2KWLrVOXQLV6NEkbW34Nza3
         2DmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU18RnSUq/FET+gvgqwgBKRcaByA/j2SAfUuuJ+4YLpCYnhmDFS+GE91jSedHmXkCxLR+9bWVgd7H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL14qwbDsCg8qz+QDX1N0wEOQHtXSzM+qGFUHwo78fwedNahMZ
	88b9vHRKPIBcbyjpSVBFDKc+nBHldvA50yOXwxBh9gOZTppHXMi/PxVjTpanIg==
X-Gm-Gg: ASbGncus5E3opUBOg3FG/mxvc6rcB0bveOBIcMROuKHcs+SoSBYJU/wMIXwmqSZd50X
	QSL8Kf4Mpj0ZTIj24hjckRbi3E7pVGsYy85krTrUe6apD/sUkRwETbGKP+PiPfdQL9OYVO0+NZL
	PNMhUHA0fmmoo/KFsnxUdgJGeLqXdGPA7R1ilrNH5Jroehm8I7f/wH7nsyTC2Iv+D8Zxu0sDagl
	ZUkDMOjo+MDeBhiKf32FT37fuJbr9NZcBVcNH2dIe2qCV2sbuRReaIwViFFRRWiZlzldm6MCFRF
	+Hnzv9Q2a2M3GafH2l+Zfc99p71Z+QYCkc2ZZcz7Q2HzMxyZb3e2un1G4Yp1rNdIhAX2uGl5mqM
	uuWk=
X-Google-Smtp-Source: AGHT+IGro/X8tybGDrXPwFullPBzAQWDFsX52G7fyEPBaGNoBYml6oJkaZxBKpAOBoBrGK4soTkl2Q==
X-Received: by 2002:a17:902:ebc1:b0:223:67ac:8929 with SMTP id d9443c01a7336-22c357ad512mr44104645ad.0.1744823696816;
        Wed, 16 Apr 2025 10:14:56 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:f195:5eb7:420a:d820])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c33fa7638sm16880035ad.142.2025.04.16.10.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 10:14:55 -0700 (PDT)
Date: Wed, 16 Apr 2025 10:14:53 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	dmitry.baryshkov@linaro.org, Tsai Sung-Fu <danielsftsai@google.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
Message-ID: <Z__ljc6WaK8u5kff@google.com>
References: <Z_WAKDjIeOjlghVs@google.com>
 <vfjh3xzfhwoppcaxlov5bcmkfngyf6no4zyrgexlcxpfajsw2t@o5nbfcep3auz>
 <Z_2ZNuJsDr0lDjbo@google.com>
 <4pwigzf7q6abyntt4opjv6lnvkdulyejr73efnud2cvltskgt2@tjs2k5tiwyvc>
 <Z_6kZ7x7gnoH-P7x@google.com>
 <eix65qdwtk5ocd7lj6sw2lslidivauzyn6h5cc4mc2nnci52im@qfmbmwy2zjbe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eix65qdwtk5ocd7lj6sw2lslidivauzyn6h5cc4mc2nnci52im@qfmbmwy2zjbe>

Hi Manivannan,

On Wed, Apr 16, 2025 at 11:29:32AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 15, 2025 at 11:24:39AM -0700, Brian Norris wrote:
> > We might be talking past each other. Per above, I think we can do better
> > with (1)-(3). But you're bringing up (4). Problem (3) exists for all
> > drivers, although it's more acute with DWC, and I happen to be using it.
> > I also think it's indicative of larger design and ordering problems in
> > pwrctrl.
> > 
> 
> Now I get what you are saying.

Great! I probably didn't include all my thoughts in the first place, but
then, my first email was already long enough :)

> > As an example less-cute way of doing pwrctrl: expose a wrapped version
> > of pci_pwrctrl_create_device() such that drivers can call it earlier. If
> > there is a pwrctrl device created, that means a driver should not yet
> > wait for link-up -- it should defer that until the relevant pwrctrl is
> > marked "ready". (There are likely other problems to solve in here too,
> > but this is just an initial sketch. And to be clear, I suspect this
> > doesn't fit your notion of "generic", because it requires each driver to
> > adapt to it.)
> > 
> 
> This is what I initially had in my mind, but then I opted for a solution which
> allowed the pwrctrl devices to be created in the PCI core itself without any
> modifications in the controller drivers.
> 
> But I totally agree with you that now we don't have any control over PERST# and
> that should be fixed.

Yeah, if we have to handle PERST# and its timing, then we have to touch
essentially every driver anyway, I think. So it's definitely a chance to
go a (slightly) different direction.

(Side note: I think this is potentially a chance to solve the odd I2C
pwrctrl problem I linked in my original post with the same set of hooks.
If a controller driver can know when pwrctrl is finished, then it can
also defer its LTSSM until after that point.

I doubt this will be the last set of "odd" HW where additional
platform-specific dependencies need to be inserted between pwrctrl and
PCI enumeration.)

> > IOW, the pwrctl sequence should be something like:
> > 
> >  (1) power up the slot
> >  (1)(a) delay, per spec
> >  (1)(b) deassert PERST#
> >  (1)(c) wait for link up
> >  (2) rescan bus
> > 
> > Currently, we skip all of (1)(a)-(c). We're probably lucky that (1)(b)'s
> > ordering doesn't matter all the time, as long as we did it earlier. And
> > we're lucky that there are natural delays in software such that lack of
> > (1)(a) and (1)(c) aren't significant.
> > 
> 
> Let me go back to the drawing board and come up with a proposal. There are
> atleast a couple of ways to fix this issue and I need to pick a less intrusive
> one.

That's kind of you. Let me know if I can help at all. Or at least CC me
on any updates you have.

> Thanks for reporting it, appreciated!

Thanks for walking through it with me!

Brian

