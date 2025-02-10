Return-Path: <linux-pci+bounces-21121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F9A2FB06
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 21:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349897A1A26
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832C26462E;
	Mon, 10 Feb 2025 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcI+jwqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AC264609
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220535; cv=none; b=YvoYqlLTQBJjxb6NP2qYJx2zXAHY1DO+3l16xgT/tQj/2Z7WI3mYt12BX0VTkF5SHiLAMuR+4RMwh22in0HxJ4aKjndy47WlLPGEDrAEIA9WE7gHN6uSHSiARn+2z1qM/7WTcC5BtXBJ8LyyOirTWHd5Meuuk772ljB1awUz3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220535; c=relaxed/simple;
	bh=RRRPpwruUsMjT3Xooj+QMNHrLT0enoIwFKJZqNokock=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVM2f1O8omgjiKXLbbHCGHnUdTRbdQ8OiCUEkUTSM+rxh9uR2845tS5ycdJTPS67UwWNdEDogvd3OD3nQtjmtxEg1HuXSZlFckk0itgB5jKCg4iQpks+g/v+rBNJ7R/FimsbousqqD/JOJcg5AVO/w5JDlPeHpFyiJWVkAEOo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcI+jwqz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739220532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr6oImSUmoNV37vte3KexwGdDf++3dEa4MUIBt+66BI=;
	b=ZcI+jwqztbba73uhyn888NXxwIb9V0UXFbb27VrWe8bSO854g4kNkXw/GapLL1K09bMtbv
	R8jQpro4mTLVfx2c1Icbjl9kIw9JGu2BSN/nDj651ijyUCtuI36WbC3IOIshcFQFrUIBDS
	nfLzMTdhRfHPkX/E/oXTcU4jiHNFjoA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-ifExaciIOdyyF2XFBMzVUg-1; Mon, 10 Feb 2025 15:48:51 -0500
X-MC-Unique: ifExaciIOdyyF2XFBMzVUg-1
X-Mimecast-MFC-AGG-ID: ifExaciIOdyyF2XFBMzVUg
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85522c731dcso8621239f.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 12:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220530; x=1739825330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr6oImSUmoNV37vte3KexwGdDf++3dEa4MUIBt+66BI=;
        b=taitm0HeYh9wkyH5mRgigNGluyrP+cYPx1A1uiPbwn7Y0o8Qs3wBoAf3M93jg0y2lJ
         B4ExQDtP6O2BpCWTEaNTY77knEikKu8g8Zz1fT/bEYXh8hTCxWnf9l5OoD0hjNWsh48+
         mC4LJqJWpjSrhKMY9Ahhs2VFFnOm9DT1yk1IH3CSuYXOcAJxk1Q1OLMJpuyhBgXWtXMZ
         32TZDq81asAs6srnyYEnltn9GorVOI6qAsQlLWHpZ9agwKO19mOQ9XUFL1LyuXpWh7SW
         Fksed2UVn94BX4Oxo6vNB+W7Gdh/+PYGoT6Rx4DYtKDzUR7KTJflcDTZjQ67z/RanaiJ
         fsEw==
X-Forwarded-Encrypted: i=1; AJvYcCVSph9ma50Jx6NRRyL+HD8gTLKpeNYahfKWiRoPWMz0DSftWyyG+XPjn98T5BYetx+EelpBhPDxets=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJWBTU9t48EaZCk3Jw/68o9obWhJxO7o4KURClAQq7+NEezdF
	pT09uRLi3cnizr2kTkYQU6zUbLNuBnaXuHVftreE/nYkhUfohgKZWfkqX5EyjO3jyEge53+uRBY
	lsE+UAzrnJ8Ojk5jxIxy+fJ/KnykeehJd4BWrvaI68UwH//H1eEcHM97Xtg==
X-Gm-Gg: ASbGncu5ssJ35E9mG+eFI4Oggd5a/tWs+62/w06B7soyyLLQIJC2FVY65uhN/6F2U+u
	TaT8oH++l+affq6jc7YsQDiiyErjpJkTgV+E4VXTOzNlSP6WYOQAeV4yhAp72Fq+ue4TT6G5ZzE
	AldMgHnw1J3mvvCQ6ivsuUFJJ1+Fond9xx2L5J0li0t76vPb5rWdUTQHtXFWIMZm7lWfGA5SHaA
	dr+iXkg98HZ2VvbZ6HiO8SNIttzUycCvU0YE2ymsDUPGbG8aqyLO05FrAgaIj27ZExMyzMRp0On
	GpwktCGr
X-Received: by 2002:a05:6602:7288:b0:83a:e6b2:be3 with SMTP id ca18e2360f4ac-854fd9bddbemr395256439f.0.1739220530163;
        Mon, 10 Feb 2025 12:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx7Jnqea7i+39aCAKRmDysnisRHYNE/bnZVGB72yJEa4fDq/Fmq2JBu9PYMb77P0FAI73D7A==
X-Received: by 2002:a05:6602:7288:b0:83a:e6b2:be3 with SMTP id ca18e2360f4ac-854fd9bddbemr395255839f.0.1739220529884;
        Mon, 10 Feb 2025 12:48:49 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854f6792733sm228731839f.37.2025.02.10.12.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:48:49 -0800 (PST)
Date: Mon, 10 Feb 2025 13:48:48 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, mitchell.augustin@canonical.com,
 ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
Message-ID: <20250210134848.78a1ab4a.alex.williamson@redhat.com>
In-Reply-To: <20250210200819.GL32480@redhat.com>
References: <20250120182202.1878581-1-alex.williamson@redhat.com>
	<20250209154512.GA18688@redhat.com>
	<20250210093641.0be242ae.alex.williamson@redhat.com>
	<20250210195658.GK32480@redhat.com>
	<20250210200819.GL32480@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 21:08:19 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 02/10, Oleg Nesterov wrote:
> >
> > On 02/10, Alex Williamson wrote:  
> > >
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
> > >  	unsigned int pos, reg;
> > >  	u16 orig_cmd;
> > >
> > > -	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> > > +	if (__builtin_constant_p(howmany))
> > > +		BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);  
> >
> > Or just
> >
> > 	BUILD_BUG_ON(__builtin_constant_p(howmany) && howmany > PCI_STD_NUM_BARS);
> >
> > I dunno... Works for me in any case.
> >
> > I don't know if this is "right" solution though,  
> 
> I mean, atm I simply don't know if with the newer compiler
> __builtin_constant_p(howmany) will be true in this case.

That I can confirm.  With gcc 14.2.1, if I change the call in
pci_setup_device() to use 7 rather than 6 for howmany, the build fails.
If you confirm this resolves the build on older gcc, it seems like a
valid fix.  I installed a VM with Fedora 23, which uses gcc 3.5.1, but
I haven't yet been able to successfully build any kernel with it.  I'll
post a patch if you want to provide a Tested-by.  Thanks,

Alex


