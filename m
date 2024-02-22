Return-Path: <linux-pci+bounces-3848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17CC85F06D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 05:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013921C214DB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 04:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AA2382;
	Thu, 22 Feb 2024 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNPenOKo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE810FA
	for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576221; cv=none; b=Bb/yDzjHcOJCcmdPxSPcuEmYz0tY1QPTm5KePCui2aMmnDALjtlvQxm2rc8IiGi3uA8pSauA2VtNpDMtbwaiMoetF8wUIoALDKeaNPNxgCN4CIQSpM+YycxVmSNfejTNEkVZK1qz+BcNjtWFZM5JsaMn56cLR9ufI/XiMiODUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576221; c=relaxed/simple;
	bh=3FzBfAXaI9M/10P8azIba04RP5t0EdJWaS66eVT7FLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG5zawiHv/G+Fhz4RcDUpdVeDUufWrLDdV37M3iGd+8CwdoeOdmlX25a2j9iRuGIQYz6z8PG3RSj3hQG7wimLRlxZ9nahLgD0TGwwKyllj1NqPXfBhHWl01KHqO4y+c2LOAmNb/fdgjeBZA4blG0o7m+4JodJHOXrphhUjOT5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bNPenOKo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e46e07ff07so2607631b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 20:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708576219; x=1709181019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RuTLvVidS21XoBw9o2fSjXG33vaKOkPGRjxlAwcHZ9k=;
        b=bNPenOKo9LBXqBYLRi69z9qftY2o204VV9795vah9bBuSa81PiZ7gKhuBNmywvEN8h
         4aPlLoJk8391X99s4ZdzbDJk7jhAepawc0Bqp282xtOBzjw/XKQaUz3m7NR6J5C45/P/
         IndmpyOzUx9saDM3Tn7uxBIOJZsH0deGT/3SumApCnKkQzy+7bkuKfAvDKc51nJyuW1r
         B3PcRfA2Dyo2FWHxay+Qy5LWfPeFp7xLy7kcV4+Dn+3MVfcD898yK6DmZKW3K56Zlbi1
         osIrmdYkoAKRlAF8FI9kRZm6cqk5xCVX0xF6zNvSIl/b7nFTpqC2m2Dj5rVOpimHpXAi
         dpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576219; x=1709181019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuTLvVidS21XoBw9o2fSjXG33vaKOkPGRjxlAwcHZ9k=;
        b=m3avF9fwY9Q+Cj2tREex/8Ka9sM309SYx/mv3dVqHHwecS3IalE4ySDBgMQ5gUeteU
         UCS85Ya1BIDid56Kb0Ws0u7VoUA0CZ/SZY52KeKIVvnFpGnCATWlZR/sI6drvWofpqTj
         Sh0/GdeRFdZJ4YGBOx0/a3wLy7QKoEsKA62//vzMpw69KJ/Q7TJAB1SEyvjVLECeHETI
         A8wnRaczOjT0idJSIEb+wO0WPGtlDdDi1QonRCD4suVZhOJ+43u3ljNIBoUcjTm5G9Ke
         FnQ0Lp6FfnnVJ3eO1LtrzHDzVSTstnoy3bgxsxxMEIbiB/sAMplUm+jau0BurLL9hzGT
         6z3A==
X-Forwarded-Encrypted: i=1; AJvYcCWhFWMWuo7W0QXwTSKDruC8VhDf6Qf/GIhTLxHUw1VKUVtuRlJMwo5gImcsCiHIZLnxzZb1W9eHEN8nS7yVKcM75wLwLYuWX9lq
X-Gm-Message-State: AOJu0YwG5t+o+di/Q7i+sYmQITmk5QNkX3HZZPOK9vl11nAD4RgxIbHR
	NQ8iYlimqxNdS6W8LKFIW21zuup5zVAiyox5Yq1lHZqbTPa9Ji3oM1jr1N9qXQ==
X-Google-Smtp-Source: AGHT+IHAp/Zsd6Plm9qOrAa053ZBJHTV9DEi7zbFF0DhknGSKs2Cy1RM4dVLX2YNFxUtAAsK2KGnzw==
X-Received: by 2002:a05:6a00:9a0:b0:6e4:7b27:2887 with SMTP id u32-20020a056a0009a000b006e47b272887mr9414047pfg.7.1708576218495;
        Wed, 21 Feb 2024 20:30:18 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id h11-20020a63530b000000b005dc3fc53f19sm9426375pgb.7.2024.02.21.20.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 20:30:18 -0800 (PST)
Date: Thu, 22 Feb 2024 10:00:09 +0530
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
Message-ID: <ZdbN0b_pEqoFPP3s@google.com>
References: <20240206171043.GE8333@thinkpad>
 <20240214220228.GA1266356@bhelgaas>
 <20240215140908.GA3619@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215140908.GA3619@thinkpad>

On Thu, Feb 15, 2024 at 07:39:08PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 14, 2024 at 04:02:28PM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > > ...
> > 
> > > ... And for your usecase, allowing the controller driver to start
> > > the link post boot just because a device on your Pixel phone comes
> > > up later is not a good argument. You _should_not_ define the
> > > behavior of a controller driver based on one platform, it is really
> > > a bad design.
> > 
> > I haven't followed the entire discussion, and I don't know much about
> > the specifics of Ajay's situation, but from the controller driver's
> > point of view, shouldn't a device coming up later look like a normal
> > hot-add?
> > 
> 
> Yes, but most of the form factors that these drivers work with do not support
> native hotplug. So users have to rescan the bus through sysfs.
> 
> > I think most drivers are designed with the assumption that Endpoints
> > are present and powered up at the time of host controller probe, which
> > seems a little stronger than necessary.
> > 
> 
> Most of the drivers work with endpoints that are fixed in the board design (like
> M.2), so the endpoints would be up when the controller probes.
> 
> > I think the host controller probe should initialize the Root Port such
> > that its LTSSM enters the Detect state, and that much should be
> > basically straight-line code with no waiting.  If no Endpoint is
> > attached, i.e., "the slot is empty", it would be nice if the probe
> > could then complete immediately without waiting at all.
> > 
> 
> Atleast on Qcom platforms, the LTSSM would be in "Detect" state even if no
> endpoints are found during probe. Then once an endpoint comes up later, link
> training happens and user can rescan the bus through sysfs.
> 
> But, I don't know the real need of 1s loop to wait for the link. It predates my
> work on DWC drivers. Maybe Lorenzo could shed some light. I could not find the
> reference in both DWC and PCIe specs (maybe my grep was bad).
> 
> > If the link comes up later, could we handle it as a hot-add?  This
> > might be an actual hot-add, or it might be that an Endpoint was
> > present at boot but link training didn't complete until later.
> > 
> > I admit it doesn't look trivial to actually implement this.  We would
> > need to be able to detect link-up events, e.g., via hotplug or other
> > link management interrupts.  Lacking that hardware functionality, we
> > might need driver-specific code to wait for the link to come up
> > (possibly drivers could skip the wait if they can detect the "slot
> > empty" case).
> > 
> > Also, the hotplug functionality (pciehp or acpiphp) is currently
> > initialized later and there's probably a race with enabling and
> > detecting hot-add events in the "slot occupied" case.
> > 
> 
> As I mentioned above, hotplug is not possible in all the cases. There is a
> series floating to add GPIO based hotplug, but still that requires board
> designers to route a dedicated GPIO to the endpoint.
> 
> To conclude, we do need to check for the existence of the endpoints during
> probe. But whether the driver should wait for 1s for the link to come up,
> should be clarified by Lorenzo.
> 
Lorenzo himself applied my patch [1] which had caused the regression on
QCOM platforms. So I am assuming that he is okay with removing this 1s
delay.

 [1] https://lore.kernel.org/all/168509076553.135117.7288121992217982937.b4-ty@kernel.org/

> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

