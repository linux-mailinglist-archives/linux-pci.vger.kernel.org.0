Return-Path: <linux-pci+bounces-37992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 503BBBD6973
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 00:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 956394EA654
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782622ED87F;
	Mon, 13 Oct 2025 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGIzS1P+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EED2FB610
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393598; cv=none; b=eGOgCyJTHpz7rlgavgNk44bLGfb+6kdLVc3QdS4zq7rmBQNwJNa+3tkCEt9t/ApNGcoVZKSZa+ca8q+Or60QKLcFCUa92R0qNl6JILBc0AkMIIRrX/VigBzyky9Qd/N9sftkOOYUxl7f/WIkiitI1HbaZBeo+Odfk2PURTzXfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393598; c=relaxed/simple;
	bh=wjoYvXDZz0DfsX9uSWQcckKoP6w9GXLrRSh8PGU2nkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZPWsL/+MVa06WE+NMylS9TvEhnVpMcUt/IMZtnNRgM1Gr2Nv75GfnOLaTHfKaAlUVviUORHx0RGqXkargCJlmh0Fo1WRuccLzubYMsQI0FZ2v3zaiOSEIaCNU6yBgk4XRnIZA4J3EfVFQsICVe5rZMXVuYfsQYeHpog0WGyl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hGIzS1P+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so54055015ad.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760393596; x=1760998396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwDIVnwjatb9wZcHCyfzRACsLl5kuks0bwo7xSwJ8VY=;
        b=hGIzS1P+9aouRtCGIyPObV5aQOQTsIoji7nzyHJQ1Jj2Gr/mCXDEbbQG8I5ZfxeRzi
         o1KTI1s1MmHDMicgBi3YxeJGXzEQOXHpw30f2X+/dnhi+wOv+lG3vjBrocf+mXPMN4Wm
         rwM1d6RQjW2UQNK1ZP+4cXxvjDun1s4bdF3sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393596; x=1760998396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwDIVnwjatb9wZcHCyfzRACsLl5kuks0bwo7xSwJ8VY=;
        b=VNvMrjzBECQCaZ/Fa0kiaqDz6puAYjKa7gZDdMxiDGV3LPrrIzsrBj9jZn84yGB1H8
         966pZtB3CCFWoGPN9FlaUzwOIS+tprwupcIWEnmBhZwB/pFhId3xxnGW2XWYyI+z33Bf
         gk3+5K3RG7x0yvgWloyAop1Kj56rn6olQiEQhKlMSbSbxYdAWICBnh2ryR6hQXhqZyCJ
         4z6jRQR6CgqSpWxuQ+vg6rg3EWnjZziF8YWLHSPaf7ND8BXO6kFTFp+MHR5lQsc0jybs
         e7HHTPuTgWMYG8lA6gT1IDgVL97+SCk9dIZ5Ld1gah2IuxuZlZiQTyJz8mdoR2EMBdtg
         EN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUwEZWD2Rb+n17atNdx7Ecp8o+K1lndQ9D/OhiWff9fOnUpWjFsVzm2NuTLKWM5Qd1fZIG2y9D7N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWc940KQi2llHs/C/mqswceIlQAF2RhCmU65CrhrLWk4W8Lbdt
	oTB5SQ1YO7+rkf/MVLX8Kk4sKT0K7AKTopCUjeh+GNi6cmUkLznF6MpE7SBEb62nDw==
X-Gm-Gg: ASbGncuLPXxWSXEoPcLoZnJ/aLq/i70YWk4fFQh61GiOzhp9d5Kh3p8EYggNCAjKS0y
	Jiv0dL7RR1gaMKh1pMAoiK++K+9RRzX2NOtFAq7TjnCAk1mqZPHp1o7CRcaVFcTHgPlZDP8SOFq
	t1SQ7VrUrvWkuJZtJFpZt8Dci3zyGNwHrVLQyJ62abtPrWCikZQFq7AH9+FcUx924M+fi8G3gpF
	sxnFHsjcN1PMYawiVhItMtTMT8hmoUOT3GCM6qRj3FSoBdIen74YX1tctYjYILFYvNQ1ahVAVAW
	i0aXdnuAcXvFMtavhqzQ/w4ELTvfCxevXZCk0fEaGhvfCZimhwbF8FE6i+TxZSBuifammFNhN30
	2DtPR6M+Aga8yuCiPzICo7ZbkRdBUIcBng62W710Uxwi4Xbi1F0kEgA0cyqsaaeM6eJ9SL6IrWQ
	wFhKqZWt5/s8YQYjxz2mY1KTk=
X-Google-Smtp-Source: AGHT+IGFg5uCIhEU3lcn0qGmOLjSNLHjIAYyVFAFUM7gEwBM59gQGW1r0WNu8Fra1LpnKfzMHn+JxQ==
X-Received: by 2002:a17:902:d607:b0:269:8f2e:e38 with SMTP id d9443c01a7336-29027356528mr293017275ad.6.1760393595967;
        Mon, 13 Oct 2025 15:13:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4cf5:d692:bb78:20c])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034f36cb1sm142736965ad.100.2025.10.13.15.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:13:15 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:13:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <aO15eFW430nuXMa5@google.com>
References: <aOQLRhot8-MtXeE3@google.com>
 <20251006193333.GA537409@bhelgaas>
 <v7ynntv43urqjfdfzzbai2btsohaxpprni2pix2wnjfoazlfcl@xdbhvnpmoebt>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v7ynntv43urqjfdfzzbai2btsohaxpprni2pix2wnjfoazlfcl@xdbhvnpmoebt>

On Mon, Oct 06, 2025 at 04:13:26PM -0700, Manivannan Sadhasivam wrote:
> On Mon, Oct 06, 2025 at 02:33:33PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 06, 2025 at 11:32:38AM -0700, Brian Norris wrote:
> > > Some PCI drivers call pci_set_power_state(..., PCI_D3hot) on their own
> > > when preparing for runtime or system suspend, so by the time they hit
> > > pci_finish_runtime_suspend(), they're in D3hot. Then, pci_target_state()
> > > may still pick a lower state (D3cold).
> > 
> > We might need this change, but maybe this is also an opportunity to
> > remove some of those pci_set_power_state(..., PCI_D3hot) calls from
> > drivers.
> > 
> 
> Agree. The PCI client drivers should have no business in opting for D3Hot in the
> suspend path.

I dunno. There are various reasons a device might want to go to D3Hot
some time before fully suspending the system, and possibly even before
runtime suspend (or they may not support runtime PM at all). For
example, on the first step on my alphabetical trawl through

  git grep -l '\<pci_set_power_state\>' drivers/

I found a driver that supports some power-toggling via debugfs, in
drivers/accel/habanalabs/common/debugfs.c. It would take nontrivial
effort to evaluate every case like that for removal.

BTW, we even have documentation for this:

https://docs.kernel.org/power/pci.html#suspend

"However, in some rare case it is convenient to carry out these operations in
a PCI driver.  Then, pci_save_state(), pci_prepare_to_sleep(), and
pci_set_power_state() should be used to save the device's standard configuration
registers, to prepare it for system wakeup (if necessary), and to put it into a
low-power state, respectively."

So sure, it should be rare (like the docs say), and it's probably
redundant in many cases, but I'm not that interested in shaving various
drivers' yaks right now. I'm just fixing a (small) performance
regression in documented behavior.

> It should be the other way around, they should opt-out if they
> want by calling pci_save_state(), but that is also subject to discussion.

FWIW, that's also documented in the above link.

Brian

