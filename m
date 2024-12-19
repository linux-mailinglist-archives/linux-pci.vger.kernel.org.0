Return-Path: <linux-pci+bounces-18785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B21F9F8005
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE131188937C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589CD226874;
	Thu, 19 Dec 2024 16:37:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3D2165E6
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626229; cv=none; b=cgJEHgQ3VidLMwuMkjXh6zEuMOwEtqzWrnkAkasIIiqEQDJPSOSBzKWcG8QYhjlTvDTM+zgFvQ98Hk5VOCJfsl9/ZXXL29/YVbVxoU4dhvrTTLd59pZkjpxue4Sbksv0BsP4aVpLE64LHhMwBruKeQliZo1EQujPXr/7snYJuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626229; c=relaxed/simple;
	bh=xeCAqBq9nFl+dgCu9KWBqjUq/jE6Nyvrgf/3jnriPFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB00RomdSJMyx1S9/SbWT6WOvy1k3q3sEzdKdxlPllBQ9db2wlLyzIIQXEnir0xHLTxi1c7m6zi57uq6BUkHPAXVxggoCy/x0qGxCEOMkySVAUnN/ArBhhRIEpAGkgLCJtjr9xLZJFtpop4frSIYeOm1FDZTphui7iriDfemiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216395e151bso6955205ad.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 08:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626227; x=1735231027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciw7ZFYjf/u/FrbzaLHZq3yHV0km/VF+j3Uk5nBhfUs=;
        b=w1oiwfibSgys9jLbfNVdOlz8Gy5ryAddr9zc8j7SKT92aTFTMDuTBCKEZAskubppL3
         A4s1jwAQklqhu2iRrL88MiHKNwRXoKoOLHTL880z42kZ6UTR1/wPDCTlZYhk+F89u3Oy
         fV+NCe6/FRt4aIGfgF/KL3NkSGwIcw90lALOueuxn5h7qdiJJPYlp6i5ZRmw19UyUbsa
         YhiRRQNC56bkSPuYt8MkX8etszclg0jZ3NTGYvzzzeulE+6bTJ4jWStPhRidFkKIOwsM
         mLScQeVkXkgHTPF836aPcFLp0Sk9j9BL27RYxmkfAqebaK3rsBts2hL9aO0bd7dzD4+o
         4JeA==
X-Forwarded-Encrypted: i=1; AJvYcCVMC/cgiZbjmj4NPhbYrvZZ0jcaV+bIf6cLdwGAxWIJbweuPmtVHKWf6gkkhFrszXL/VoYBf7snGNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPrsyDBS/e2jU3IWIkir4MwP40IFOG2eei66n8ZnwDc4Jk80Z
	oNq0y3xJhTI6JHk7grlcqFMPvynqoJo6LOwifMrZiYuEyxnJWvDN
X-Gm-Gg: ASbGncvzJN62/RTiGTtNQjaEJGkltdxeNRerZWsymVfVwKZkT2fwbCerCWEvtR3riks
	WgWOUpiEyjgNKhLoxzX9toXcikaYdp0oRdqdU1UcPHwYvkz56S2gi1Zp685y1VsNuCqKTuedCXv
	STScYHgnbuW/0FlmSS57er8Ph0YQyHBki56o9J+5+u1EgIxHsed4fI6JpVLIgpnK5XxH41I8iix
	393z+4ncdEtiba2IPwFOTi4gR8mTdXIuztW8lqjeG/qJ5pR8Zt+kpNlkytw62hr7rYTROMIA6zM
	0FIeTiStnavaf+8=
X-Google-Smtp-Source: AGHT+IGhhev2wNqzNJXv+ILkpJYLymhNScVKsdPw4O31bO+yn0aAzQr+JO4E/Dgxqbg4tIemlXgBmA==
X-Received: by 2002:a17:902:f689:b0:216:39fa:5c97 with SMTP id d9443c01a7336-219da5ce0b4mr56771175ad.11.1734626226922;
        Thu, 19 Dec 2024 08:37:06 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdf18sm14414725ad.153.2024.12.19.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 08:37:06 -0800 (PST)
Date: Fri, 20 Dec 2024 01:37:05 +0900
From: Krzysztof Wilczy??ski <kw@linux.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v3 1/2] PCI: Honor Max Link Speed when
 determining supported speeds
Message-ID: <20241219163705.GA623969@rocinante>
References: <cover.1734428762.git.lukas@wunner.de>
 <fe03941e3e1cc42fb9bf4395e302bff53ee2198b.1734428762.git.lukas@wunner.de>
 <7bbd48eb-efaf-260f-ad8d-9fe7f2209812@linux.intel.com>
 <20241218234357.GA1444967@rocinante>
 <Z2POKvvGX7HZmqtP@wunner.de>
 <f4b43cee-b029-1c78-2412-7a952e8e83a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4b43cee-b029-1c78-2412-7a952e8e83a1@linux.intel.com>

Hello,

[...]
> > > > Thanks for adding this extra information.
> > > > 
> > > > I'd also add reference to r6.2 section 7.5.3 which states those registers 
> > > > are required for RPs, Switch Ports, Bridges, and Endpoints _that are not 
> > > > RCiEPs_. My reading is that implies they're not required from RCiEPs.
> > > 
> > > Let me know how you would like to update the commit message.  I will do it
> > > directly on the branch.
> > 
> > FWIW, I edited the commit message like this on my local branch:
> > 
> > -Endpoints in particular, so it does occur in practice.
> > +Endpoints in particular, so it does occur in practice.  (The Link
> > +Capabilities Register is optional on RCiEPs per PCIe r6.2 sec 7.5.3.)
> > 
> > In other words, I just added the sentence in parentheses.
> > But maybe Ilpo has another wording preference... :)
> 
> Your wording is good summary for the real substance that is the spec 
> itself. :-)

Updated.  Thank you both!

	Krzysztof

