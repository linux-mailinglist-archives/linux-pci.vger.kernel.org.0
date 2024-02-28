Return-Path: <linux-pci+bounces-4167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB88686A6F0
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 03:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DB1F2A53A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 02:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D271CD13;
	Wed, 28 Feb 2024 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/puvzcM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADD1CD0F
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088970; cv=none; b=RrVXQt5K01wfzeTYmKq1GnxdHkeJAcSDeXQFuPggVr6zmZ2YzvM/WR2lvGHg+bR2Xn/wElDSwy5BPI90SQTxWW5iEyW6lABGqSUY0OGpMGZVoWB3WVkDHnbaIqxbcg05Klobx21N7PRs4u+ZPAD6M6c/uGuoKzrT1sDG8D9/4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088970; c=relaxed/simple;
	bh=FH96oV7a38f0agXJlxc8Uq/wx355YA+Wc9LQAqH3UVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcWavC4AXlV+w6tzk+ugqgoF29T7GspuchtfJykdocN9aqobJBcvV/HunmRBrNk8gXwcYI3ATEgrD8WuT6GaBDe0JV7wsiW6C4NaODzCTDzODwlAtG2RhSV4BdlmvYjhXbTueHv+m4XyqeZiCTl9p8jHOS00dlY7yygdl0drxDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/puvzcM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29a378040daso3702126a91.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 18:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709088969; x=1709693769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CnlPmE7MlVaSQ5beDat/xllh7q+4+hw8oXcKD+TOUsE=;
        b=D/puvzcM7kF4RQ9Yeixm08+SIyTeXV9OEZ8KJymUcQabUSr43M+nBwlSBaMkG6PcwQ
         g2Kf/RSCPBx22FwHVzPa3HYjHmJXkctoJeUYHyPozWzFw+g1rex8Q5FrG6GuFB+neitQ
         rcWDJfdhaAlJHhKZ43W1GQ505s1hb+NlhFAfigvgNi/5dR0fae67TnhlrktqXPnkHKGF
         ImCIpdILmE4fDn0q6w6HZESP3R0PMn9NpnGpaa5Y0li1CoNzoe8GUivo8jX/SuJLslaK
         Gj95bX3EZjcZEAjKV+1cFHl/bzPdTmUJ8RPHjkDaM3ta2bQavYSC/lJrvomn48LCNDll
         yidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088969; x=1709693769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnlPmE7MlVaSQ5beDat/xllh7q+4+hw8oXcKD+TOUsE=;
        b=JBe9NCrLITb7KOmtLGCGSeBE1X6F9hcJZWURd0rq7UO6BTl6Zdi3d81nrCOvJJHq2S
         jMJmVKVmBlNd8UtO3qM5McFjIz+td9AB/Ez7d6nGciZoLblBEdN/hlE0AlVeUVy8ve7x
         MdaTwpeRN7ieskyTPLkefKoaW5ko+N/wsL1qs4RJ+Yc5/rwDGIEG69D45RfHsPdEhb7p
         beu67ZIY/LBNZGSqQvP8hwj1K6jDb7SarZnV7J8I1rGKsG8z1adx1cZlCTUYDzVwx/0X
         n87nJSe7/+5rSTIbNVjSJkUSvP4NupDt8AZ7atpTO1VrxASRFYOH4Mf66dV9C1VqgEj2
         7Vcw==
X-Forwarded-Encrypted: i=1; AJvYcCWTewXFaIv59oZm5pAsCjsxyOsea1YLgbn76fMJzFV7f3IZrwGXUZ3lPoFtEBNArtVoyyrUuQryB1+PeBH1J4nxYC7gXhk5iBH6
X-Gm-Message-State: AOJu0YwCoaS8w44613v4nxFSFh88MV5+6Sp+/czYdhsO0699NOs/iZpL
	V+Bn4Ibqw8B5ZuOHIsO5z49yguTWHXoDNDaBXOzubxBsKqqHt4TQzS2LQm7UAw==
X-Google-Smtp-Source: AGHT+IGQZ5j99lgiSRB1jG+y4gWBcRAA/GMwC3m8TdaJ2EWi3KC6O7qmrkBjmOAk6BB+/yEfPRxT6Q==
X-Received: by 2002:a17:90b:1050:b0:29a:9ba0:8a5b with SMTP id gq16-20020a17090b105000b0029a9ba08a5bmr9193495pjb.5.1709088968477;
        Tue, 27 Feb 2024 18:56:08 -0800 (PST)
Received: from google.com (122.235.124.34.bc.googleusercontent.com. [34.124.235.122])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090adf8f00b0029a8a599584sm300263pjv.13.2024.02.27.18.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 18:56:08 -0800 (PST)
Date: Wed, 28 Feb 2024 08:25:58 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <Zd6gvkvHozWk2Pqj@google.com>
References: <20240206171043.GE8333@thinkpad>
 <20240214220228.GA1266356@bhelgaas>
 <20240215140908.GA3619@thinkpad>
 <ZdbN0b_pEqoFPP3s@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdbN0b_pEqoFPP3s@google.com>

On Thu, Feb 22, 2024 at 10:00:09AM +0530, Ajay Agarwal wrote:
> On Thu, Feb 15, 2024 at 07:39:08PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 14, 2024 at 04:02:28PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > > > ...
> > > 
> > > > ... And for your usecase, allowing the controller driver to start
> > > > the link post boot just because a device on your Pixel phone comes
> > > > up later is not a good argument. You _should_not_ define the
> > > > behavior of a controller driver based on one platform, it is really
> > > > a bad design.
> > > 
> > > I haven't followed the entire discussion, and I don't know much about
> > > the specifics of Ajay's situation, but from the controller driver's
> > > point of view, shouldn't a device coming up later look like a normal
> > > hot-add?
> > > 
> > 
> > Yes, but most of the form factors that these drivers work with do not support
> > native hotplug. So users have to rescan the bus through sysfs.
> > 
> > > I think most drivers are designed with the assumption that Endpoints
> > > are present and powered up at the time of host controller probe, which
> > > seems a little stronger than necessary.
> > > 
> > 
> > Most of the drivers work with endpoints that are fixed in the board design (like
> > M.2), so the endpoints would be up when the controller probes.
> > 
> > > I think the host controller probe should initialize the Root Port such
> > > that its LTSSM enters the Detect state, and that much should be
> > > basically straight-line code with no waiting.  If no Endpoint is
> > > attached, i.e., "the slot is empty", it would be nice if the probe
> > > could then complete immediately without waiting at all.
> > > 
> > 
> > Atleast on Qcom platforms, the LTSSM would be in "Detect" state even if no
> > endpoints are found during probe. Then once an endpoint comes up later, link
> > training happens and user can rescan the bus through sysfs.
> > 
> > But, I don't know the real need of 1s loop to wait for the link. It predates my
> > work on DWC drivers. Maybe Lorenzo could shed some light. I could not find the
> > reference in both DWC and PCIe specs (maybe my grep was bad).
> > 
> > > If the link comes up later, could we handle it as a hot-add?  This
> > > might be an actual hot-add, or it might be that an Endpoint was
> > > present at boot but link training didn't complete until later.
> > > 
> > > I admit it doesn't look trivial to actually implement this.  We would
> > > need to be able to detect link-up events, e.g., via hotplug or other
> > > link management interrupts.  Lacking that hardware functionality, we
> > > might need driver-specific code to wait for the link to come up
> > > (possibly drivers could skip the wait if they can detect the "slot
> > > empty" case).
> > > 
> > > Also, the hotplug functionality (pciehp or acpiphp) is currently
> > > initialized later and there's probably a race with enabling and
> > > detecting hot-add events in the "slot occupied" case.
> > > 
> > 
> > As I mentioned above, hotplug is not possible in all the cases. There is a
> > series floating to add GPIO based hotplug, but still that requires board
> > designers to route a dedicated GPIO to the endpoint.
> > 
> > To conclude, we do need to check for the existence of the endpoints during
> > probe. But whether the driver should wait for 1s for the link to come up,
> > should be clarified by Lorenzo.
> > 
> Lorenzo himself applied my patch [1] which had caused the regression on
> QCOM platforms. So I am assuming that he is okay with removing this 1s
> delay.
> 
>  [1] https://lore.kernel.org/all/168509076553.135117.7288121992217982937.b4-ty@kernel.org/
>
Hi Mani, I am wondering if you have any thoughts on the above comment?

> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

