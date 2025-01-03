Return-Path: <linux-pci+bounces-19268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D47A01053
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 23:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F8A3A4819
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441932E401;
	Fri,  3 Jan 2025 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="chzta081"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F137DA95
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735944434; cv=none; b=pSWgOd6Apxjqq1a8togqdeYL121/2Xi+t8kFyoHBu1kFTz+19O08kLwj8QCj74KmMD7xWNq2Hh+XhZlh7T+L5JxSEBBrC62zyc32EL0pS4pbHx44fFFMxRBfe1d+T3N5UMgt3XFebvjX1PRyuqv2zGotK6VmH5GF2DavTt2dmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735944434; c=relaxed/simple;
	bh=P8E+gvJmIvygKyvlnRGIsNHsgErZdgNurCHrS0UTHM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxdrXuRI8uK0VHy6FMEQ06vNXfWh3XvketnjFavArEMhw7GWwhBMIBABcjV/VYaYkG4tCuvWUMApUAb4YQCyl1wqNpMDY1M4z7Zf41W0Xa7A9GigMelMQ4IV24Z7stcYR0AXvRBSAxpPZM3DH845HeAZQfw+Mam5Q98uqcIYKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=chzta081; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21661be2c2dso162150385ad.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 14:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735944432; x=1736549232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wbZWcvbmbP2zpaLuv9bUzmsFWqJNzUQlwoJwEbV2MJA=;
        b=chzta081nGGCZTTB4ahFWRcCfM9joxFzzEL5pL0ta8QTUzWE+sw1Qd04mf4kz4usOg
         YvSFFeL07T2nWZ8dJILLONAbM9lQO3nn3LfU3vw4Ui0XlqCYi32I6CpzHgzDmvQlSUiK
         b8Vs6mmXlCCmX5dWFelDPMXCmwf2/L1lg/qj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735944432; x=1736549232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbZWcvbmbP2zpaLuv9bUzmsFWqJNzUQlwoJwEbV2MJA=;
        b=LhMO/Ye21FZADs9TjEcj2k1N5uIVThFAjDeD8MTRjnpYwpGIzjwMvreKqM+j3bB2tc
         qXMXjElb6RR+QSpf1j5NX+BCy9DesrkUZFwlknHUieeAfSDYVBfLHXkIx6e/e1ILSPcs
         YBtGkJhRffnJOkxePo/O5cuRSJHH3SCaOg7ViEuaLhGWlRI9w5qSXAvoTVGRdNRprIEB
         6xvD6gxN2erlKFujEVgrIAXRNCfELrbLglaGeiBJ+ApS3Ph0ZUSMMSNTVnXw3b1AOrLu
         MvgTSSWw3nFHFiZ88qCmOCWa027RHi3KVfAqIVhvhTnRPA9RPn/7fO9Tvh0FJccW+k54
         U9fA==
X-Forwarded-Encrypted: i=1; AJvYcCVd6hkwHQvts0SWeCET+LnYmTFDZCaHyL6PFLJIeB/hc8e6lM7VOCK3hndg2f/wKM5EPs4z+p6X4XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfF1uoYq/yWdXpziHIkZtbNDYxOI3ebohWqGLbllJFxzPT6zqv
	YALABLTPSgvE4S4eQAeAZ3I/Yd74MAYNo0oUpfWdnhqnYsg9/06tnbmHQ8I32g==
X-Gm-Gg: ASbGncshYSPWcU9Etph85/eFJd+CcteHkdscLDeW8qg8hyc/XbxLwo+h6uOMO5l57DP
	A1YlkUajEJzkkvSXgMazK5R5i4HNh4GR6XrIHbntCKTXHUh5LBpJxHegEV8ZPwyE89HDWuFBA5s
	McTNdXRUN3CZsN/m0iO3+Tds2OhtR85SVKSdVsbr8V5RVA8VaHH0VApWDcptqrEKBEM2o2LA1ZE
	iTr1goRC9f6tYauCWFtya447A08I47FAp6rVTERou5YKZM5lWFuIzRdr/u3UriIqsI+IVwnNOPn
	t7zJtKzJsyJZcZ0786s=
X-Google-Smtp-Source: AGHT+IHaT2+DbkcwEInnWPgtxUJOcNbztGCijdx/qVD4rKIGVGtz8a1VPVJnqU04Mu39O7QyWx49uw==
X-Received: by 2002:a05:6a21:3115:b0:1e1:af74:a235 with SMTP id adf61e73a8af0-1e5e0499fafmr74460516637.24.1735944431936;
        Fri, 03 Jan 2025 14:47:11 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:3330:154b:5c45:7be8])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-842b1ce1fd5sm24652155a12.25.2025.01.03.14.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 14:47:11 -0800 (PST)
Date: Fri, 3 Jan 2025 14:47:09 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Use level-triggered handler for MSI IRQs
Message-ID: <Z3ho7eJMWvAy3HHC@google.com>
References: <20250103174955.GA4182381@bhelgaas>
 <20250103175839.GA4182486@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103175839.GA4182486@bhelgaas>

Hi Bjorn,

On Fri, Jan 03, 2025 at 11:58:39AM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 03, 2025 at 11:49:57AM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 02, 2025 at 05:43:26PM -0800, Brian Norris wrote:
> > > On Mon, Dec 30, 2024 at 10:41:45PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Oct 15, 2024 at 02:12:16PM -0700, Brian Norris wrote:
> > > > > From: Brian Norris <briannorris@google.com>
> > > > > 
> > > > > Per Synopsis's documentation, the msi_ctrl_int signal is
> > > > > level-triggered, not edge-triggered.
> > > > 
> > > > Could you please quote the spec reference?
> > > 
> > > From the reference manual for msi_ctrl_int:
> > > 
> > >   "Asserted when an MSI interrupt is pending. De-asserted when there is
> > >   no MSI interrupt pending.
> > >   ...
> > >   Active State: High (level)"
> > > 
> > > The reference manual also points at the databook for more info. One
> > > relevant excerpt from the databook:
> > > 
> > >   "When any status bit remains set, then msi_ctrl_int remains asserted.
> > >   The interrupt status register provides a status bit for up to 32
> > >   interrupt vectors per Endpoint. When the decoded interrupt vector is
> > >   enabled but is masked, then the controller sets the corresponding bit
> > >   in interrupt status register but the it does not assert the top-level
> > >   controller output msi_ctrl_int.
> > 
> > "the it" might be a transcription error?

Nope, direct copy/paste quote. I unwisely chose not to include a
"[sic]".

> > > That's essentially a prose description of level-triggering, plus
> > > 32-vector multiplexing and masking.
> > > 
> > > Did you want a v2 with this included, or did you just want it noted
> > > here?
> > 
> > I think a v2 with citations (spec name, revision, section number)
> > would be helpful.  Including these quotes as well would be fine with
> > me.

For the record:

DesignWare Cores PCI Express RP Controller Reference Manual
Version 6.00a, June 2022
Section 2.89 MSI Interface Signals

and

DesignWare Cores PCI Express Controller Databook
Version 6.00a, June 2022
Section 3.9.2.3 iMSI-RX: Integrated MSI Receiver [AXI Bridge]

Sure, I can send v2.

> Oh, and it would be awesome if we can motivate this patch by mentioning
> an actual problem it can avoid.
> 
> It sounds like there really *is* a problem at least in some
> topologies, so I think we should describe that problem before
> explaining why we haven't seen it yet.

Yeah, that's probably a good idea ... I'm still working out the nature
of a problem I'm dealing with here, but it has to do with when (due to
HW bugs) I have to configure the parent interrupt (GIC) as
edge-triggered. It turns out this change alone doesn't resolve all my
problems, but:

(a) I was hoping to get feedback on whether this change is sensible
    regardless of the adjacent HW bug I'm dealing with (I think it is);
    and
(b) I don't think I have a great publishable explanation of my HW bug(s)
    yet.

I understand (b) is not really a great situation for public review and
would understand if that delays/defers any action here. But I'm also not
really an IRQ expert (though I have to dabble quite a lot) and am
interested in (a) still.

(If it helps, I can try to summarize the above in a commit message, even
if it's still a bit vague.)

Brian

> > > (Side note: I think it doesn't really matter that much whether we use
> > > the 'level' or 'edge' variant handlers here, at least if the parent
> > > interrupt is configured correctly as level-triggered. We're not actually
> > > in danger of a level-triggered interrupt flood or similar issue.)

