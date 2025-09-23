Return-Path: <linux-pci+bounces-36794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354DB97102
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D323A5786
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295538FB9;
	Tue, 23 Sep 2025 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DMM9b5Aj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4FC27FD62
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649338; cv=none; b=B0c3I0+ZHTNExdkdEeth0Qq8wyw6f8fSPctCgBCgfirZfO6exlb0toe5oJtyplMK/znZp4B6j9iy1S36/SYsZ8d2sQhZpkuIIWkt74gABb/KdWw4rKVlEGOsqpS+bOSsGbOa9zNy3JxbmxCq59X2yNbgoo7sfo7vM0ZZ9veFH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649338; c=relaxed/simple;
	bh=6G5hq2ESPXxgPR53Lq8sJO77YPWnS5k2F15nLBfDTQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDToA3yqwJyfq445cUmeNqvZDuzNyayvo7U2x4JhWgtvY/Wwy7zCQ6Pb/h+RhgiRa2tFozL6zICveVGUderkPuVDVv22whfhTD4Srg4OgxyXnH4H0mk0mlmr7fkUkDbX2o5tGvZzpDjuUCwkVGOeWgym+XOhiPpmlrqCuXhSmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DMM9b5Aj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso3933826a12.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758649336; x=1759254136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=;
        b=DMM9b5Ajy3IOhVOBk7y54ekzwIDr/1TF22r4z5B6hOlNuDv0FPMAs3EJFbw8+CNalH
         B6GTxKMqrVAo/OCFJDkpoRwvSuklRmz7QOkErP4zua26IKf+tC6ZFFeY4UDGml8mBjEI
         ULPNyc5PoNtn1Ff3XocHVciCu6I2k3c+JaXxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649336; x=1759254136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=;
        b=LoFhVwU3wcRuTiGXLM31YHmiCifQk2rDYBUc+a0jQ8zbdtL6LPffUuxGRPtH1vxPvq
         Y99pjW3ZRSgfKcveT5x9GUQ/PQYf5XQFTO3rXKkJlsyPrgdvMcgkA8BQ7SacRKjliKwl
         9n+MD5EEQiJy79DeL0tEU4A1p63Y4JDp31SHfS+GZa2Wxn5hwI5TgojA547zHvm/kW8p
         dpHPXfAwlPTaP/4zDnoBvrXLGGgmgBHUhy5XUMDBTxRc/GZkWtiPBHQPJVbcO0Tqvmnc
         L/m0YfmuKlPhDlGxrg1d27pNBwtJHoiW6c3El+J765aJDRCKCbEWbhHDBpV05w4P9eh8
         wtGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWOnpMYBwEBYrlm/Vob4ljI7JWqnxbrDi1sW5Vk6H9W+kEbYkJm6AdF85SZUim/e4ZxmStH9hzmSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmHkETOGckDa2u8clTrLFfcC+y3c8qKzlKdvkWIegqms6iIg3
	o7T3TArWuFeM67aKkkhhVVhllF/EjBzQM1HPmPwwuySZovRyX0ifGUqs0qEPGXLF3Q==
X-Gm-Gg: ASbGncudwVTSWzbAvH0myC4s+/0tsVYqLVIOt0Z0J5ru9IQ/KdKSVO2guw41USqu4Jm
	8/UmPgTuXZPkrMTskxJ/LZBBLe9aa96n+DAfAXySYDUDb4Xmc0QPnxex2EyKEUn+JQTOHN9CW2V
	FcUy1Enu8peAwaBrdwhtL2032W4087gznvK5rXUNke76HME7NFvV723r5jhopaIn2J0mIqAqeuq
	pn3Bq5MCO14TdU3ULz8RLbjo2DEEFooNnM3XZ210vflu/Cff8b8BnaQXarHHrjCN2GW7Vm6onft
	NCb7IeRlRxuLCrv2hMXLp9aKDg/e31aharfbD/GZV19sjS4NdiJA69obG3eE2vnE4LtfVTE/s5K
	vuRHz0DUvzpDaoF+3IRMu8GevwxS0U3kkzC/QbB17TB9h086Hoc1RY9npsg4O5ZXtPz+7H5opsE
	+Qy8M=
X-Google-Smtp-Source: AGHT+IHJbwEaaCpD6dZUF3mz350pgxjUUNoYTVUR2WMjcFJjbWFfvBHQKr1Y1HlZkG2OkTtL8B8Dkg==
X-Received: by 2002:a17:90b:3cc5:b0:32e:8931:b59c with SMTP id 98e67ed59e1d1-332a9909c66mr4171539a91.27.1758649336532;
        Tue, 23 Sep 2025 10:42:16 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f126:ac9b:b8ac:e280])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33060803335sm17000731a91.24.2025.09.23.10.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 10:42:15 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:42:14 -0700
From: Brian Norris <briannorris@chromium.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
Message-ID: <aNLb9g0AbBXZCJ4m@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>

Hi Petr,

On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
> On 9/13/25 12:59 AM, Brian Norris wrote:
> > @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
> >  		return;
> >  	}
> >  	pci_do_fixups(dev, start, end);
> > +
> > +	struct pci_fixup_arg arg = {
> > +		.dev = dev,
> > +		.pass = pass,
> > +	};
> > +	module_for_each_mod(pci_module_fixup, &arg);
> 
> The function module_for_each_mod() walks not only modules that are LIVE,
> but also those in the COMING and GOING states. This means that this code
> can potentially execute a PCI fixup from a module before its init
> function is invoked, and similarly, a fixup can be executed after the
> exit function has already run. Is this intentional?

Thanks for the callout. I didn't really give this part much thought
previously.

Per the comments, COMING means "Full formed, running module_init". I
believe that is a good thing, actually; specifically for controller
drivers, module_init() might be probing the controller and enumerating
child PCI devices to which we should apply these FIXUPs. That is a key
case to support.

GOING is not clearly defined in the header comments, but it seems like
it's a relatively narrow window between determining there are no module
refcounts (and transition to GOING) and starting to really tear it down
(transitioning to UNFORMED before any significant teardown).
module_exit() runs in the GOING phase.

I think it does not make sense to execute FIXUPs on a GOING module; I'll
make that change.

Re-quoting one piece:
> This means that this code
> can potentially execute a PCI fixup from a module before its init
> function is invoked,

IIUC, this part is not true? A module is put into COMING state before
its init function is invoked.


> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
> >  					      sizeof(*mod->kunit_init_suites),
> >  					      &mod->num_kunit_init_suites);
> >  #endif
> > +#ifdef CONFIG_PCI_QUIRKS
> > +	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
> > +					    sizeof(*mod->pci_fixup_early),
> > +					    &mod->pci_fixup_early_size);
> > +	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
> > +					     sizeof(*mod->pci_fixup_header),
> > +					     &mod->pci_fixup_header_size);
> > +	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
> > +					    sizeof(*mod->pci_fixup_final),
> > +					    &mod->pci_fixup_final_size);
> > +	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
> > +					     sizeof(*mod->pci_fixup_enable),
> > +					     &mod->pci_fixup_enable_size);
> > +	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
> > +					     sizeof(*mod->pci_fixup_resume),
> > +					     &mod->pci_fixup_resume_size);
> > +	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
> > +					      sizeof(*mod->pci_fixup_suspend),
> > +					      &mod->pci_fixup_suspend_size);
> > +	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
> > +						   sizeof(*mod->pci_fixup_resume_early),
> > +						   &mod->pci_fixup_resume_early_size);
> > +	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
> > +						   sizeof(*mod->pci_fixup_suspend_late),
> > +						   &mod->pci_fixup_suspend_late_size);
> > +#endif
> >  
> >  	mod->extable = section_objs(info, "__ex_table",
> >  				    sizeof(*mod->extable), &mod->num_exentries);
> 
> Nit: I suggest writing the object_size argument passed to section_objs()
> here directly as "1" instead of using sizeof(*mod->pci_fixup_...) =
> sizeof(void). This makes the style consistent with the other code in
> find_module_sections().

Ack.

Thanks,
Brian

