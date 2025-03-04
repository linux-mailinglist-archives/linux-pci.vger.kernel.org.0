Return-Path: <linux-pci+bounces-22896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B45A4EBF7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1DE8C83B2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE254202C53;
	Tue,  4 Mar 2025 17:58:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B561255246;
	Tue,  4 Mar 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111125; cv=none; b=fFjxqezUy47jIB2g8u1HJG2ylo1XslH0/41YFbj4kl/ISrTlR1WgyJCKJgRb9Htg+XWPyRwM1Q5qV09NK6bSkskiHnwa2azLQTYypLcWgZv+UE/bkhlBbAQtD8PhZyyhuJFDl4mZlCiPAMUpkBaxLhOZVT16EvxzsHpyRGa4EsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111125; c=relaxed/simple;
	bh=Ujw4MWb/0WOb7SwC+35n2U8PfAcDz24lLFOjDyOaR6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT/1FcFF0sXqbSApN5g+iVeeckrPvqRL0m2aLJ2mBJLDesCB70w8ALsov95IOAO2w/4LGy7y/Jphs+6dQHFLWFiNr82RYhnTA5XEZ+X5RHFKqBVBnYDee9NK+k2R2Tucw3WkREKJvB40W6wy2z6jqhgXofItGBbPFLWXyhi0vhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2235189adaeso969055ad.0;
        Tue, 04 Mar 2025 09:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111123; x=1741715923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa+NEDuZcYixtAYlNBsjFq3LjZunv0045SB9vkqgOdQ=;
        b=WlT/bH6DTaCOn/cthLwS3C6oxBedIPoNDoIoEWSKPP8aK1PX+SFSupy3r6ubSJE4CG
         Yd9NR2vcoXO5p+FmsBjfI2w9N+EaM7u8tMnRWl2qCGUHxMNOGurtuGPpfFo7aZkUYa1N
         k0k2+iapURyCdDpPo4Oguy7WecZ6sLRJiZ98VpW2PqIcn66XgTOU5VhAdKSHboAhy220
         fqlw9LQfXhlDGcu28SJPVBS1gtFkkjSsappKLMvppzXMj3ZASAvk0Gh4XIG9UbMU2J8J
         XZ37kO8t8yoH/xcC9nIvmtQ3TTwIfWeycHCVulxWlnGTtqjYE1VqYUhvgZJpAfbXyQPz
         bX1w==
X-Forwarded-Encrypted: i=1; AJvYcCUCfbBdehQ0nMYmnCtg2prlgV3qBB9IDEU9xIvlNR8Rer36kypyBGIwRoinnsY5LwJGBxThpFiRL4W6RaDhgy+5VQ==@vger.kernel.org, AJvYcCUZq9GVP4XtmOAsPtokmGbmpkqKf7s9TbDIyOW7qcyP9SHMr/XIa1LOls8kojlQoWVwm2bzV+D1jmxrrHgy/WhzCD0=@vger.kernel.org, AJvYcCX67ACzPQFgCqBCiThYfP/0YLSdZONbAK06GW7XfANoLR6pW58TlLzfRLTYHNBwLDPeP/fMV8XvSpjudys=@vger.kernel.org, AJvYcCXRf3n7N2qNxPLODIdCG3Dc2hlt8hktYJInqEI2f/HI1kpkYAE1XQgek7adzOKCWo4d4haFBiP0EciI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dHQE2L6BvaoTlhPxe8LPuM2R7FQR9qjrQh+mU8VW3V3RJId8
	hx9PcqCtMYOe8ML8kNRaDGW2eB99Dm3mh8yASiqJG+ZbBVOSyqHU
X-Gm-Gg: ASbGnctNZV09i8tc3t3EEU9OHL827SxkqHnLCTqu8K9gHsRkoZcMARgWKNRbDcrQWKH
	S2a1KaS7430bJkZAnP0Ahc6JL3RiF+Oyckc6lqOzbJK6jIm4pt+VQVxsSrAiTwDstN3ZUfBPg2I
	kcjic1eG6wchOq7UaKBbqg9yDqJQNumclUFAapZuSSj9EhWd0fAL6Rx2pMuhoU4DM8Cu+4OUruY
	hnpixUU7iC+cDpKFNBHohYgHZRaEkHkKV5f1MJXWuki2w/VMrb1OyB3vGKuMTK1wapEKCXhINij
	+MsqHAH9JbF4K6d2syghzyfZ4qvaZhjn3KwuvhIg/91FJdpsVTESTIur1sJsi2J8cTz/IdvzzUt
	obXc=
X-Google-Smtp-Source: AGHT+IGxJOcaLpgJti6tTG0QJg+XMjirIbznemnIcFt44IjryR0KVwwvI5ls/IBoAD0A13h4IrVAXw==
X-Received: by 2002:a17:902:d48c:b0:21f:40de:ae4e with SMTP id d9443c01a7336-223f1d3ed62mr895285ad.9.1741111123284;
        Tue, 04 Mar 2025 09:58:43 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22350531a43sm98524575ad.238.2025.03.04.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:58:42 -0800 (PST)
Date: Wed, 5 Mar 2025 02:58:41 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Fan Ni <nifan.cxl@gmail.com>,
	Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250304175841.GF2310180@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
 <20250303194647.GC1552306@rocinante>
 <CAMuHMdWens9ZZrjNH1Bd2AN3PJEP1KSUGdiJcBCt0uPGH_GiiA@mail.gmail.com>
 <20250304154638.GB2310180@rocinante>
 <20250304171154.njoygsvfd567pb66@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304171154.njoygsvfd567pb66@thinkpad>

Hello,

[...]
> > > > > > +   ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > > > > +   if (ret)
> > > > > > +           dev_dbg(dev, "RASDES debugfs init failed\n");
> > > > >
> > > > > What will happen if ret != 0? still return 0?
> > > 
> > > And that is exactly what happens on Gray Hawk Single with R-Car
> > > V4M: dw_pcie_find_rasdes_capability() returns NULL, causing
> > > dwc_pcie_rasdes_debugfs_init() to return -ENODEV.
> > 
> > Thank you for testing and for catching this issue.  Much appreciated.
> > 
> > > > Given that callers of dwc_pcie_debugfs_init() check for errors,
> > > 
> > > Debugfs issues should never be propagated upstream!
> > 
> > Makes complete sense.  Sorry for breaking things here!
> > 
> > > > this probably should correctly bubble up any failure coming from
> > > > dwc_pcie_rasdes_debugfs_init().
> > > >
> > > > I made updates to the code directly on the current branch, have a look:
> > > 
> > > So while applying, you changed this like:
> > > 
> > >             ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > >     -       if (ret)
> > >     -               dev_dbg(dev, "RASDES debugfs init failed\n");
> > >     +       if (ret) {
> > >     +               dev_err(dev, "failed to initialize RAS DES debugfs\n");
> > >     +               return ret;
> > >     +       }
> > > 
> > >             return 0;
> > > 
> > > Hence this is now a fatal error, causing the probe to fail.
> > 
> > I removed the changed, and also move the log level to be a warning, per:
> > 
> >   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=c6759a967e69aba16aef0d92f43e527b112e98a5
> > 
> > Would this be acceptable here?
> > 
> > Mani, would this be acceptable to you, too?  Given that you posted the
> > following recently:
> > 
> >   https://lore.kernel.org/linux-pci/20250303200055.GA1881771@rocinante/T/#mab9cbd5834390d259afea056eee9a73d8c3b435f
> > 
> > That said, perhaps moving the log level to a debug would be better served here.
> > 
> 
> Even though debugfs_init() failure is not supposed to fail the probe(),
> dwc_pcie_rasdes_debugfs_init() has a devm_kzalloc() and propagating that
> failure would be canolically correct IMO.
> 
> So I would still opt to have my version + your previous one.

Sounds good!

I combined both changes (squashed your fix for the RAS DES capability
detection) together directly on the branch.

Thank you!

	Krzysztof

