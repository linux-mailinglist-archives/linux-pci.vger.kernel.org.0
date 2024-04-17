Return-Path: <linux-pci+bounces-6383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7588A8D82
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 23:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB11C21312
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A81481BB;
	Wed, 17 Apr 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aClyTeqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8EF524D9;
	Wed, 17 Apr 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388186; cv=none; b=rjlOPIhmOqsNj9EWD9TBjGBrbM4eiJ21XnVajtyMEcREVZKHWiR3UAU+c/1d5mWgdWvq76CAO7VesKvb01nDBPPAmz1CIhICqStxRkuEADdVSKvxOaG3hzNNhylbTfqiO/YQ7xZ74D/jCge1vSgI1YlNTpTHPnZbzK9adAI1Mt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388186; c=relaxed/simple;
	bh=cuh1OHui6t5s2+TUiZ8RUAlkinFvy8M3FadxFyze++w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ca/PnRASfEwGuGbYkvQbYzK4tqOKzt4TCIM84SMkhQfwV9hBDCKb6aJeGyWnrqd5wiSAD6fqWMM5KQbOOdGkSfBpbZT13XIlalBLGBsAKv6nvn+7UKe+09ObmA/MN6THm4QGh4wofKW/Kh/1jZUcjh+VlJhU+SmmNzu0kV7uFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aClyTeqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C3BC072AA;
	Wed, 17 Apr 2024 21:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713388185;
	bh=cuh1OHui6t5s2+TUiZ8RUAlkinFvy8M3FadxFyze++w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aClyTeqLk+cwibgYRldv0mbzdTqyFBvsR+ohlku0Nhr0GU5mGC6ao7fzutM6CdFgo
	 js2WfErTPOgS/oeJFgmCcE3QzvepvXtmL1uJCNPwBtXNovnAL0I2Nj65frkN5tc0gw
	 0sxwE4qPwKDRAUUawQGq8cokREu5hypvkwkac8Ex8dkk7SvZ0hnIFCVvdvOa0dmLIf
	 Xtq3G7XJuP1kC0APJ9cQW/Foixko6x5Iys+WdBnP96jLU3rObAlPcBaGfkRP275J6h
	 T7Nx9KZjgsPjE/Rn3INv8ky+OQnGkv77jZMbPI0haK++trm8DLCkmeY6+FB+EQ2yly
	 4stfRitmpXUKg==
Date: Wed, 17 Apr 2024 16:09:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-pci@vger.kernel.org, Mateusz Kaduk <mateusz.kaduk@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, Tj <linux@iam.tj>,
	Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/pci: Skip early E820 check for ECAM region
Message-ID: <20240417210943.GA215723@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd58Z1X05YMa_03eZi48h2kY9q+0v8ymscQ2-HdU33tHw@mail.gmail.com>

On Wed, Apr 17, 2024 at 11:47:27PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 17, 2024 at 11:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Reported-by: Mateusz Kaduk <mateusz.kaduk@gmail.com>
> 
> > Reported-by: Arul <...>
> > Reported-by: Imcarneiro91 <...>
> > Reported-by: Aman <...>
> 
> Isn't bugzilla public enough? You may take emails from there, no?

Good question.  I think email addresses in bugzilla are only visible
to logged-in users, so I wanted permission before publishing them.  I
got that from Mateusz and am hoping to hear from the others because I
want everybody to get credit for their contribution.

> > +               /*
> > +                * 946f2ee5c731 ("Check that MCFG points to an e820
> > +                * reserved area") added this E820 check in 2006 to work
> > +                * around BIOS defects.
> > +                *
> > +                * Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be
> > +                * reserved by a PNP0C02 resource, but it need not be
> > +                * mentioned in E820.  Before the ACPI interpreter is
> > +                * available, we can't check for PNP0C02 resources, so
> > +                * there's no reliable way to verify the region in this
> > +                * early check.  Keep it only for the old machines that
> > +                * motivated 946f2ee5c731.
> > +                */
> 
> > +               if (dmi_get_bios_year() < 2016 && raw_pci_ops)
> 
> I probably missed something, but where does 2016 come from?
> (I've been following the bz discussion)

I made it up based on the fact that 946f2ee5c731 was added in 2006,
and I just added 10 years.  I would love to get rid of the E820 checks
altogether because they're really completely bogus and an ongoing
headache, but I don't know the details of the machines that
946f2ee5c731 fixed.  I'm open to other suggestions.  The Lenovo BIOS
is from 2023, so it would have to be something earlier than that:

  DMI: LENOVO 83AG/LNVNB161216, BIOS MHCN40WW 12/15/2023

> >         if (pci_mmcfg_running_state)
> >                 return true;
> >
> > -       /* Don't try to do this check unless configuration
> > -          type 1 is available. how about type 2 ?*/
> > -       if (raw_pci_ops)
> > -               return is_mmconf_reserved(e820__mapped_all, cfg, dev,
> > -                                         "E820 entry");
> > -
> >         return false;
> 
> Not strictly related to this patch, but now it can simply
> 
>   return pci_mmcfg_running_state;

Good point, changed locally.

> In any case, LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thanks!

Bjorn

