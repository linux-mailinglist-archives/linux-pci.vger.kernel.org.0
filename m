Return-Path: <linux-pci+bounces-2991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D72E846B2E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E48F1C2695B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411C60244;
	Fri,  2 Feb 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lpOw8qrT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE05FF14
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863722; cv=none; b=OemScakCVzfHFaXHpk8B4ijTHCHrVnFGqd6/nEuM9JQaR4QeQX96ABODRrvY6EWSmQAExS/mn5QOMYt7vm5sAQMHfKkd4ArmhZZtMF3LRk6zE41QF00gjMyiiSXWumOiljxixp7LjF6p+72cHQtHcoTGzEt34bHwYN15aA1t6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863722; c=relaxed/simple;
	bh=sxX6A1jY2QUTnGziquDNeweaFL0CvM8/+UjRl9k6dKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVR/14fGmEwE9Y6Wciz5auFgp1I+b215Mw/hD/bC4Oj/JcDuDa5h9Ot8/S9BnWEa96bBsr39tp/ITNZU7VbgWBelcSTxRdPZXJ+Xp4/E3vv5EqN9SiKUxI+K1SNByvdPtOtyAHLpHUcNKHlZE3UiMmFFaC2zvuvOn0mCE1+/g0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lpOw8qrT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-290a55f3feaso1464705a91.2
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706863720; x=1707468520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TItsROaQHyjEbJFLwPA4KC7BHoQVWA8FloUjcj8REgk=;
        b=lpOw8qrT/7eEPoth7zOhVcLEX9OJWruHy4yfIfIdqquPCOvj67p5PV4ysnSJnTnSEW
         qCwxnCOsE7nfCHNbgbIJwaz0M47byGNvhfWcaP0XNotebjeCXZcy9+zH09oTXXgunGO6
         Nq/kYlqIz+ZHMwJlGCFVp7Wn0NFGLegQQdCbIkR1Dw2NlA2p8oXAuFSlyxzFUwq976c8
         M5MpsXewjGUnFOrvBLuMfQVErU35kcW6O+bEIOHzvAmiA0ytXdAnV96XTQIr+j9pXjsI
         nwicTAbaFkyI3IAfO2vAvHLlB0i5yud7pRqT/hW5SwIb3sjjWDc2eEVe3u3Tc2VOmZpD
         aJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863720; x=1707468520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TItsROaQHyjEbJFLwPA4KC7BHoQVWA8FloUjcj8REgk=;
        b=O7kusrPWJQpOFf88FaQzY91QKuIbIY7VSIBQBe4xiSpcfTKEarlCoiQORkiJsn3RAz
         EmMKJwPR02YwR/I3Z3bIzCk2HD8mVcoZCupj/HMGPEYLa2PQos98egzD6J99AE5LzS0X
         MfUWsBK8hVzyqTYcz0fAZ1F+JJED+A1i7DXZPNi+nhMjdfbkwuf9m4C+3bugIpfLuiSq
         pNB2QGhOcfBHFGrTRChc8PtJgvc0hCnH+tUraypH8gRFU2PeKl3UypzyLe+Ru+6IM0G5
         14jdXwW4PnD6XDump0FFVp7qa+swe2Z0T1WWhY4lhZDNyUKfsM7H5X/WjcdWn8B+VLp+
         1qVA==
X-Gm-Message-State: AOJu0Yxg+koH3QAWARr7VDT4mvH2dHYPScAw9bLBckEA54SGg/ndUiAa
	yOkg7lWHt8BPmV7ZgFqwoPMnav/wAeryt3b9rONc1armKY7U4p2IT2E3hSNZSKQ=
X-Google-Smtp-Source: AGHT+IFKJTKBJ1qZaEdzHRI6R3ULv7nSG6aIb1erLw8eof4kdB83jJqiV5IsTHm9r+TtHnCR1jZmWQ==
X-Received: by 2002:a17:90a:9415:b0:293:eaec:fd67 with SMTP id r21-20020a17090a941500b00293eaecfd67mr7058447pjo.14.1706863719736;
        Fri, 02 Feb 2024 00:48:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTEwJbtE+hsf4fe9iCtFquFGaddaPiWZ6SnyAr0Einu4dhTiJbRdR7UsVh3wDijhbLCJy4cgq+WMa32kNB4DVIJ2CTvjvXu0QA+jepl2n5oU047rQfjh9yHEHsiiZ+3aZVPN2LIIzPHR59vKArcMIcOGJnWSGcxBhqXb0TN0G04w4wTYfPowAIDmztFuw3hXmNVpH/zvuBW4p/QvlVMswA4AJlDPiFke0+cJC8VBOZEPAQgzm4hnXEjuGRTNbSYioOI/Q++uuarI9wkhlxcl5I/iYC8zOTF+O5BAWMOKXF8GJmHwEOCoeUxQ21aQ/KeZpdSNG+68oMJ51E2GniW1hMaJrxApOTFBMSMCQGwlT0ne8wRSNvA2p5z5j4f9Y1MkgOUW/sdryWa5PgJxIHDqPHSheCrCT7xbEOIL8mNdusCKQpve8UzaMbCRG6fEz3HztBo4io4GCsbdgYf/1hEo6jY7yscTM4euX7ng586XMYFPY4lUWHwAeHZb1XYtHyRIKmbQ43J31dY25rJbxYBSi2SXlZTf1I+etr5v6pZjLBurjzWF9YzWmS602pOBZV+Th8SH99xW9a0+HO/D+WYHwmaRpdLRXX+xGrUGyJKI4iS992HPL5L2yc2C19Aiu/pkxxCLNMOjjMh6SewbZHG5CEqgva9cPnS9GJGjqgxTvbudduv7QTe0cO9p6r6VSsC1kZ
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id kb3-20020a17090ae7c300b0029647c140ddsm564007pjb.17.2024.02.02.00.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:48:39 -0800 (PST)
Date: Fri, 2 Feb 2024 14:18:31 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 05/21] pnp.h: Return -EPROBE_DEFER for disabled
 IRQ resource in pnp_irq()
Message-ID: <ZbysXzWX6FH5e6AH@sunil-laptop>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
 <20231025202344.581132-6-sunilvl@ventanamicro.com>
 <CAJZ5v0hHYa4c2U-tegdBtoTak=MirXwyBXbN9yrWPx_x-+yMzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hHYa4c2U-tegdBtoTak=MirXwyBXbN9yrWPx_x-+yMzg@mail.gmail.com>

On Thu, Feb 01, 2024 at 07:00:51PM +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 25, 2023 at 10:24 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > To support deferred PNP driver probe, pnp_irq() must return -EPROBE_DEFER
> > so that the device driver can do deferred probe if the interrupt controller
> > is not probed early.
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  include/linux/pnp.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> > index c2a7cfbca713..21cf833789fb 100644
> > --- a/include/linux/pnp.h
> > +++ b/include/linux/pnp.h
> > @@ -147,12 +147,18 @@ static inline resource_size_t pnp_mem_len(struct pnp_dev *dev,
> >  }
> >
> >
> > -static inline resource_size_t pnp_irq(struct pnp_dev *dev, unsigned int bar)
> > +static inline int pnp_irq(struct pnp_dev *dev, unsigned int bar)
> >  {
> >         struct resource *res = pnp_get_resource(dev, IORESOURCE_IRQ, bar);
> >
> > -       if (pnp_resource_valid(res))
> > +       if (pnp_resource_valid(res)) {
> > +#if IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI)
> > +               if (!pnp_resource_enabled(res))
> > +                       return -EPROBE_DEFER;
> > +#endif
> 
> What would be wrong with
> 
> if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI) && !pnp_resource_enabled(res))
>         return -EPROBE_DEFER;
> 
> ?
Hi Rafael,

Actually, this is v2 version of the patch and there is recent v3. Please
take a look at [1] for the latest version.

However, your comment is still valid for v3. I will update as you
mentioned.

[1] - https://lore.kernel.org/linux-arm-kernel/20231219174526.2235150-7-sunilvl@ventanamicro.com/

Thanks,
Sunil
> 
> > +
> >                 return res->start;
> > +       }
> >         return -1;
> >  }
> >
> > --
> > 2.39.2
> >

