Return-Path: <linux-pci+bounces-12791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E709E96C952
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 23:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47472853DD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464714D433;
	Wed,  4 Sep 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLe0Urnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABD15E88
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484229; cv=none; b=n8rWQibF10yZ0CnZdLVFNPdzM/WjSX8zISz38uRfEQ9zKNOlzB7mWNCWaAHATQtT8dHg3EtR7MoUz5l4MTETLEqBbOxEcBOzoAEs3uVuofx9zdL/lXIX58vc5uVQ93TcPU8eUuyUJaXyaD5luKVN6TnoTHyu9xk8vo76OxjmWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484229; c=relaxed/simple;
	bh=AaWK/QPXRZfLzR92qjHxzhe3iEAWiYE2gFeSf6BoHes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sD/QOzc+6stimwPq5wRG9pUzy7SU6GBnc1FVFNlhn94vsRvuVLGan+K1Xfb2Qkv4eIP0JLjLqft/sGshWQeBHom1ug2EBFycWxJhx+UNqaDnWajaSK0lEf3XPbEPVOgyAT+tWLGg2tk0yDkifNatL8wic8pg/oyhe95/2Z8G56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLe0Urnv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725484225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmlDgdck4DQOj2zQLq7yI2rKc9oAlzHGpi1D8CJZoNo=;
	b=CLe0UrnvCVzldiBMcEI9j89LvSTfGsrgiFkVA8oq+i2IzB6qHQMl80IIoSbNd5tVPqk41i
	F0whKKRNaOqOwcrLs7GeXCiR/5Ehnv6DRivEZrSJr2PCTCfS75P0Qa0jG57dUqPE4LtfIm
	0E402WhE9Tp0wBYLMek9Gc2tq2QZiHg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-vxn9z5EwN9-B5t7MLS8V_A-1; Wed, 04 Sep 2024 17:10:24 -0400
X-MC-Unique: vxn9z5EwN9-B5t7MLS8V_A-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a22a74353so138813839f.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 14:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484223; x=1726089023;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmlDgdck4DQOj2zQLq7yI2rKc9oAlzHGpi1D8CJZoNo=;
        b=bb/v7+E74CdMDRKI9iLNcuxB4jYeiV/JTSp7HfZ4SP4XxTpvY7HaW6zl8bTB+nb8cX
         VlN5XTNGxpPaXeAdR4ZdPFwVgEZs0DKjFdKxCMoLceNkGf66xpQ9MRzkO3YY1AxPkedF
         LXMi71ZXi1cAjxCR/a0OX2jD7M7bauyv2/jY9sAs2SWJodZx/h+7dxR7pkwahyw8Bht5
         hXouou5wJWLoDX7OyKT3vXoMhFn94PZ1Zd5x8dgdwdsDPeUbhmMNq4qcaqDBmM7lH55P
         a4vARAJFJP8r4tkdOcZutPAuL10eIwMbSf0ntjf5w2NQkyQLzmATBwEHWfVkZeDodMg0
         eZAw==
X-Forwarded-Encrypted: i=1; AJvYcCUNSPbslmhFrDlLTsAgjpdv2qLDynJySQC6WdRWfFbRnzS7GIuteeYu7GfU47LqZrLELPBEDjyK0k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXeBKloMa1WuXPDvJ400dQF11Ig2IQ2fkbIXX8aqi/p/7vpr0F
	h6Kb1NIYtg0r04sqmjY9ZxrY++6Bqe/e8G3jGWIPTyttZY6NR+XeQg/Ity9zfbtw9uxSUDSY3bc
	OJe3c7nW13qGF8qteNQW/OTvq+6zQAivKlKSH/f9aoPYQgbHpUHsloc/beg==
X-Received: by 2002:a5e:8a0c:0:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-82a262dccfcmr1147221039f.2.1725484223562;
        Wed, 04 Sep 2024 14:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZYsadPqPXpc7RvQuadK1TsaP01DtwjD+z0URp/pH4uIMb05QskHkC3t5HSszJ5KAhNNz0jw==
X-Received: by 2002:a5e:8a0c:0:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-82a262dccfcmr1147219139f.2.1725484223197;
        Wed, 04 Sep 2024 14:10:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a2f071fsm379684939f.6.2024.09.04.14.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 14:10:22 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:10:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240904151020.486f599e.alex.williamson@redhat.com>
In-Reply-To: <ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
References: <20240725120729.59788-2-pstanner@redhat.com>
	<20240903094431.63551744.alex.williamson@redhat.com>
	<2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	<24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
	<dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
	<20240904120721.25626da9.alex.williamson@redhat.com>
	<ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 23:24:53 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:
> > On Wed, 04 Sep 2024 15:37:25 +0200
> > Philipp Stanner <pstanner@redhat.com> wrote:  
> > > On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:  
> 
> ...
> 
> > > If vfio-pci can get rid of pci_intx() alltogether, that might be a good
> > > thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
> > > There's only a hand full of users anyways.  
> > 
> > What's the alternative?  
> 
> From API perspective the pci_alloc_irq_vectors() & Co should be used.

We can't replace a device level INTx control with a vector allocation
function.
 
> > vfio-pci has a potentially unique requirement
> > here, we don't know how to handle the device interrupt, we only forward
> > it to the userspace driver.  As a level triggered interrupt, INTx will
> > continue to assert until that userspace driver handles the device.
> > That's obviously unacceptable from a host perspective, so INTx is
> > masked at the device via pci_intx() where available, or at the
> > interrupt controller otherwise.  The API with the userspace driver
> > requires that driver to unmask the interrupt, again resulting in a call
> > to pci_intx() or unmasking the interrupt controller, in order to receive
> > further interrupts from the device.  Thanks,  
> 
> I briefly read the discussion and if I understand it correctly the problem here
> is in the flow: when the above mentioned API is being called. Hence it's design
> (or architectural) level of issue and changing call from foo() to bar() won't
> magically make problem go away. But I might be mistaken.

Certainly from a vector allocation standpoint we can change to whatever
is preferred, but the direct INTx manipulation functions are a
different thing entirely and afaik there's nothing else that can
replace them at a low level, nor can we just get rid of our calls to
pci_intx().  Thanks,

Alex


