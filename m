Return-Path: <linux-pci+bounces-39185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE73C02D54
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297633AB521
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0036348447;
	Thu, 23 Oct 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cPOD1Keg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FF261581
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242500; cv=none; b=b2h/ypHPO2xJzSmQ6bUfDOMK5F9WUk1iKKLD213o9TfEh8TDA4jJgbHdnf5Lek+WJlQVfJYtbhTvov/+JezhBmAiyllsaEQEp9po27exi6pQhFtsTNarD0CqP0ztxIOrH796vyu8nOOrkWspubcrOqoZb8e8esQCRjRDpA7Dafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242500; c=relaxed/simple;
	bh=+11krxrYSQBIL8PS8v62mSeTP8oZ51XSj0cM3YuN+vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Obk6LJBGp2qcwhvGPxALOrl/w/rcQlr/qIa0fdAKmccFnxsXRbWi6WtRcLj2isVbvIxDAbKzh32Taxo2V9yGcEHgWk7nIQs19ZINJ1H5UcplzRyxreoseLEYHD1ck7qCkbdCcw+ADo1/PAF7TCBaAp1dipY2aDjQyRNiYVdbqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cPOD1Keg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso981114a91.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761242498; x=1761847298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fVJOJqOl/DPUXtsK6eZUYyA/D6xvUpAsP3hFipiCWw=;
        b=cPOD1KegM61aTrEPJxaRI9ZtHfLplA8R4BbE7ei2hOB1ghzLSxecOR2ToC6QybmS00
         jhai4f6HXSEgAXDL/RKFnn1BuAJ5CYtepJFfA8Haw+z31+yKJmDB4kdFxbX4cVNAIlSc
         HB1zQo4eQaf4mb41PEQTLRldGNzOFUcCkjne0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242498; x=1761847298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fVJOJqOl/DPUXtsK6eZUYyA/D6xvUpAsP3hFipiCWw=;
        b=E51PWyoU+9M5Gu3vmCk7ab6GV/8K6tLnvPFFrQaBCgWaRDEOwZhzRQSkGpVL/dzugQ
         wSPUndiHJejtbet+3Ra/Wu0KYYnon66RKNPAoENxol1ReXecLuO21KVPDnc9zNPeZdtL
         Vibk+0eOkuUroU5eysuVyItwV9gzLoFokvxJO567z/0aFcC8lPR+GR5EYj0465zIi7t/
         ackqrLAixnMv8ki78y/9AcEhb+w3Wanp8cy78t44oTmQ6HS5yAfNcnXYHFxd/6KI2fq+
         /VHeGM3Fsg7U1YH6XmyDl7YMj6koj/jBztCKjfix4yo75CEnyzU4L+jqVrPdF7Qa6q+S
         Vudw==
X-Forwarded-Encrypted: i=1; AJvYcCXdC96R38gYq4xRg3Z07OfrB02aeL5w5//DUx0jbQr+MJK0riPiDIA17EMCSGbUCR5mdbvuJdcGVzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZxqQObilYX+0J54F4GtGDuddIbSTN1eVSaC9Q6wsTnyOZi1b
	0NLN/qwTulBJ2WDUyzkg43T6EHPYfWxW8xBV2kwTLD15hpbfamU+ev1gAiMm2moK3w==
X-Gm-Gg: ASbGncvIq1HzmaCHEjRIPlwv0REfcRCAGvLCJNLYy1pcsTT7aW+nVjugap2NyCf+O6G
	UpsrVT2sXQFTLufiiIRJs39SwBmr7ano1Oy0PQTESgSi2lUIAgLrxC7j10DwyTqdCnlZfiWH1uM
	/gfjdB+duorfLFp4a1V67fV7oBre0d6+9XhqV0Y2AyXZ8t07A+rSmz7Vki4YSAdWy/X/jsKyHyQ
	AS6ynRVyMtL8MW71sJyJN29bsVG3Zq86BKHl7zj07NAfd3ZkDQuqx51xmaoS5oI4A//KE7ZFHMM
	hSRXvHZGuHtYJzlKA5j0tA8wfQPiTLORwGI9rGuNCBwqwam1Cn9oMwWpC5FmBjHPezcP/5Pl5Rq
	3HDdhYhzwBYbW3UewzWHkC7iQWVKT4aS7OGskH51R+FN7bFOtjlD8wDQ89790Xwn0Mi6YvBYG52
	VNhEgdwsjKsiPon9SP903e7e/Cxe545VQ9N8LxenalIHwkE7bZ
X-Google-Smtp-Source: AGHT+IHMEl1/yOcEnK1WSum08iBEotApLa8nOZXGnnHDG0khuXHK2NNe5VrwxePf061sm8+ZE7PtOQ==
X-Received: by 2002:a17:90b:1b4a:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-33bcf8f7cd5mr35772646a91.26.1761242498180;
        Thu, 23 Oct 2025 11:01:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:839c:d3ee:bea4:1b90])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33faff37afesm3047298a91.1.2025.10.23.11.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 11:01:37 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:01:35 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PCI/PM: Ensure power-up succeeded before restoring MMIO
 state
Message-ID: <aPptf2gLpoWL3Ics@google.com>
References: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>
 <20251023172547.GA1301778@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023172547.GA1301778@bhelgaas>

Hi Bjorn,

On Thu, Oct 23, 2025 at 12:25:47PM -0500, Bjorn Helgaas wrote:
> [+cc Mario, Rafael]
> 
> On Thu, Aug 21, 2025 at 07:58:12AM -0700, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > As the comments in pci_pm_thaw_noirq() suggest, pci_restore_state() may
> > need to restore MSI-X state in MMIO space. This is only possible if we
> > reach D0; if we failed to power up, this might produce a fatal error
> > when touching memory space.
> > 
> > Check for errors (as the "verify" in "pci_pm_power_up_and_verify_state"
> > implies), and skip restoring if it fails.
> > 
> > This mitigates errors seen during resume_noirq, for example, when the
> > platform did not resume the link properly.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Brian Norris <briannorris@google.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >  drivers/pci/pci-driver.c | 12 +++++++++---
> >  drivers/pci/pci.c        | 13 +++++++++++--
> >  drivers/pci/pci.h        |  2 +-
> >  3 files changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 302d61783f6c..d66d95bd0ca2 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -557,7 +557,13 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
> >  
> >  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
> >  {
> > -	pci_pm_power_up_and_verify_state(pci_dev);
> > +	/*
> > +	 * If we failed to reach D0, we'd better not touch MSI-X state in MMIO
> > +	 * space.
> > +	 */
> > +	if (pci_pm_power_up_and_verify_state(pci_dev))
> > +		return;
> 
> The MSI-X comment here seems oddly specific.

It's just as "oddly specific" as the existing comment in
pci_pm_thaw_noirq(), as mentioned in the commit message :)

The key point for MSI-X is that unlike the rest of pci_restore_state(),
it requires touching memory space. While config registers are OK to
touch in D3, memory space is not.

> On most platforms, config/mem/io accesses to a device not in D0 result
> in an error being logged, writes being dropped, and reads returning ~0
> data.

On my arm64 / pcie-designware-based platforms, that is mostly similar,
but there are some cases that are different. See below:

> I don't know the details, but I assume the fatal error is a problem
> specific to arm64.

Maybe. See my response here also:

  Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
  https://lore.kernel.org/all/aNMoMY17CTR2_jQz@google.com/

In particular, when resuming the system in a case where the link was in
L2 and failed to resume properly, the PCIe controller may not be alive
enough even to emit completion timeouts. So it might hit case (a):

  "PCIe HW is not powered [...] and this tends to be SError, and a
  crash."

Memory space is unique, because while config accesses can be
intercepted/avoided by driver software, memory accesses cannot.

> If the device is not in D0, we can avoid the problem here, but it
> seems like we're just leaving a landmine for somebody else to hit
> later.  The driver will surely access the device after resume, won't
> it?

It's a possible landmine, yes. Although in my case, the link can go
through error recovery and restore itself later in the resume process.

> Is it better to wait for a fatal error there?
> 
> Even if we avoid errors here, aren't we effectively claiming to have
> restored the device state, which is now a lie?

I'm not sure we claim that. The device will stay in PCI_D3cold, and
pdev->state_saved will remain true.

But yes, it's a tricky situation to decide what to do next. My basic
assertion is that it's not OK to continue to restore state though.

Alternatives: pci_dev_set_disconnected()? pcie_do_recovery() /
pci_channel_io_frozen?

> Even on other platforms, if the writes that are supposed to restore
> the state are dropped because the device isn't in D0, the result is
> also not what we expect, and something is probably broken.

Sure. IMO, that's even more reason not to run pci_restore_state(),
because that will erroneously drop the state, and we'll have zero chance
of restoring it later.

Brian

