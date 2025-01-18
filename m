Return-Path: <linux-pci+bounces-20089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECC1A15AF5
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 02:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42F23A8C78
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160CB17C61;
	Sat, 18 Jan 2025 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWcNExXk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD717548
	for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165461; cv=none; b=qB0dbXcujm2O5+H1mdu6qthCCwW/Yo7yI8oG52vdF7Pvby0XgzhQX7OjpUKZxflu7UdOixivRguQK4sEjRAUaUoUN5ZwJjcseaAVJi1xuEehZ//4v104fKOYZzQZXGCmhOCBEAkKkazvfzz6QovNgN5s4FaBzWY1SjBK0dA8OMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165461; c=relaxed/simple;
	bh=1HYAxjPFkwZHAEiOhlKcNzZRbTgE8kBrNz5QcpjmdC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXaxNBW3ais8RW7RS1Mv9P/yMskRdmPiCF27P1KhVLKy4sJHlc2qyO954dDhVhJhg8LfDziyRsJBkonBCrhLDxGuDapUnYlIo/QwholcruxF5KC703uJlKripkLSv1tk960eURezPoUlhT72DN9FdrVFZ7LM0TvitKj3+2wfjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWcNExXk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso520176166b.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 17:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737165457; x=1737770257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqjvD87/AEN0XY9ti/HUisXBtCKCR1rDPhmeOp4MJlk=;
        b=eWcNExXkImo8gokrzjz0/DPfWty/3roKDn/1cdY2EsQTbuAhu3hVrzxQg4x9LGS3c7
         zB9uCEXDguF9rBmyYL5c89XXY3G1YhEiy8dxWlC1/tKQrXMicLTv/9eWezMag0qJqrfc
         vWzCFCQ3aQuYtsT34+TuNZ5PmiWhr0BEtVX28ahtUBofu+KKIuRVm4FA0matXZ1nAL94
         U3/pVZMMu2Iyu/T2eTxQcQ9HZxN0SYss2vEVGF2P0v77208oedob0y55ldx1iqkJhoT9
         OAdYJCxnNcAZIO/hLHg0YlYjSV6T3fmylwdLlQzeZ3jc30TNL280NETpNyI9dVKiJ+8D
         K2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737165457; x=1737770257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqjvD87/AEN0XY9ti/HUisXBtCKCR1rDPhmeOp4MJlk=;
        b=cfzToLuXAAF6yevyCUlHNj73D3F11n07p+uRJNxPxKmV5gWs7h9d1KEWmXyprMc6du
         GRPNvbGwfvYMUB+kZRXSD5Bh0Blb4kP0wk3lOT+i2MYUEW557IwWsgTojBxHRm+afcJw
         mbyF+ni/EBlr3AauoxIgaQ52Sm+If3TpNvpRzYyFjKarX5PToMGG4OptbxADC9wdNyfu
         gOKz/EsU29HkGochN9uH9N+eVktwdInbV6sWq8OMTLqkwm+Qe2YY8e1KqcJsJQ7Huz4Y
         RViKznbLEcBWabWko+tFYbJ/HtGgHwVaMD3DFi7TGRfuL6DR1YnXTyBqbsAd9zaf8A99
         B6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHVsrMYHViE8NdATxZdn1iehxNgyxW+Edw/y372ZQMzCXMC4G0zUl4yKGDpY4lS/cJ+xBYJ87XGso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeCQDcf8ZcDfEKQV30ufDdCQ4DVAydY1jUdW88vBcm5CVI0ssv
	8nszwrwRQOh2HPo1VBEXKKu4MfZIwJb8VfoLcxRE+EIafAO42otJxX8unPk3o8CoTJv2sCRRdLQ
	WsoUUToKjGRZpZ+bHoy0/Hc0u4NUrfMlIdBBU
X-Gm-Gg: ASbGnctuieiNhxh5Jgyu/5ZMhHDz73a9LQeffatn1md8vyt3zn45tn5OknS0uvzgYX9
	MhHBBsVoT8QJAleqML0pxeJwxxfUWyBaAvdY62z0zwumhBPou7V+FK+1jgRwdxphS7NS6ynaNLe
	AI59cpmw==
X-Google-Smtp-Source: AGHT+IECtaIV6cdH+MkYiIO1ZL3PAmcYu97MfrMuSNxnEhsQJ512F5m5MjAsE8Npa0XoG1e7gyl/pJ87nCzf3X2qXSQ=
X-Received: by 2002:a17:907:969f:b0:aa6:6a55:ad81 with SMTP id
 a640c23a62f3a-ab38b3791c1mr598080466b.41.1737165457460; Fri, 17 Jan 2025
 17:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-3-pandoh@google.com>
 <2448a813-1cce-4bf9-bf78-f84daefa1289@oracle.com>
In-Reply-To: <2448a813-1cce-4bf9-bf78-f84daefa1289@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 17 Jan 2025 17:57:26 -0800
X-Gm-Features: AbW1kvZCt-DNmwLHXK8AJ4SH7MUbPebWzsjArf0K0EVq8F6QEBpLAbK2LyTRknU
Message-ID: <CAMC_AXW33+f83_pkxd2Rtyw6fVzN=F==4caCuDfDibcCeWD1RQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] PCI/AER: Move AER stat collection out of __aer_print_error
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:47=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> On 15/01/2025 08:42, Jon Pan-Doh wrote:
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index ba40800b5494..4bb0b3840402 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -695,7 +695,6 @@ static void __aer_print_error(struct pci_dev *dev,
> >               pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
> >                               info->first_error =3D=3D i ? " (First)" :=
 "");
> >       }
> > -     pci_dev_aer_stats_incr(dev, info);
> >   }
>
> With this change, we stop calling pci_dev_aer_stats_incr() in
> dpc_process_error(). Is this intended?

No, this should be fixed.

We can call pci_dev_aer_stats_incr() in dpc_process_error() (similar
to aer_process_error).

Thanks,
Jon

