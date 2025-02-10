Return-Path: <linux-pci+bounces-21127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E9A2FCAF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 23:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681A2163106
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6F24CEEB;
	Mon, 10 Feb 2025 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhq6jIKV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54D1C07D9;
	Mon, 10 Feb 2025 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225472; cv=none; b=JsnXGrsvBZJ6Sgm8fMnqPMB9SPcuod+mo6pYTaw8/m7t1hach+96YWHc+L7oBB9+JuqJHMrhyWPM0arkzSR/Jj2MJwjMCTSh+o5ytqGK6xeuluSJo0Nda4+XqHwR+9zML+1xQYLubyHhKzXe/dU9v2GF+HbOjLQCLhSRtXKOjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225472; c=relaxed/simple;
	bh=fxlBqkkfGS9G0KmkfiGacPTftMamdDnTKm1+cbpRGcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tz3P+px+3Zb5Mhq9cxXolp28QKEkVCkWnOZRUB1NvB5D2YgF0rEW36aqBRXYMjkJtv/AaQPjF3eDc7VT5Gl3BSKAEw+vH848MYM+1ZfAhTFeQCkJe5Lfou0u1i9vj0PJDKHQFiIjru9VBJH6QY1h94f/Z9khVL11uQKBHF9t6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lhq6jIKV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2560901f8f.3;
        Mon, 10 Feb 2025 14:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739225469; x=1739830269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBnqMoe0ij4/z97GnIELIa4Xg29mNqaZDUnaHmVwXd0=;
        b=Lhq6jIKVh77dhBzPnXYlynb6LVA/5IhnLlN1pDD/k+cUl8m1kjC/1K7oC5VDTtVZuo
         FD9wTdqcZlyU+GtGyovGyAwoF0CJhFmJHpjIenrVBw71cvyFL8XegNIkIpkpqN5Fdaf2
         EI4drSwg7+nJ/FLSp9IcHr0PoAosRaO7k6glwSj7zF1VZCFB+sxRmyWSxDNg7a6Q/agy
         LavzWNWAffws32H3BJjwrJlNkftJHbhPUAgI9qjF2BPs5dJl/EAb8K3rc/ppmnbyt6x7
         nio4KP37ESD5RKxdCFLQ3MhQsyTkrMn0HM/LRVoxEcR48kCYnNjGZ0NvoWeduamLE1FW
         8+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739225469; x=1739830269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBnqMoe0ij4/z97GnIELIa4Xg29mNqaZDUnaHmVwXd0=;
        b=XlP0Uif5Ai/NBBSIrpWUOIVyIOuIolurL9MnWDW9nl6aA4X3Pmdbh+J7CECHlyAKXw
         X7STnIggbTTZRxON45P2JFSkF2pGcP/rPKb/DNczkxT6qrp0dEyt05nnKu25/Z3UINq2
         Xc2RPHJRFVLaA4+n2cNEVkJe1TZaZKHk+3Fq0ksUE41qEYhXafi6wPGp9GS6vMLfYYHW
         ifN7mBFLn9eh2SbHMDdamEBVk6nYXWRDRq8baTEN05FqaobhElPmbHo33BO6ArqQNHwY
         /1ocrJXhJdIzb8txw+RsX83EhxZAAYuWat6cUq1OXe4ezEibojDWARAd43ECnwjAJ6IS
         VzgA==
X-Forwarded-Encrypted: i=1; AJvYcCXE77YrNQUsQ0Lz5Fd0jHNfMtLZjNIkNNvU1uBUqBdxW2q90DxuWiMSjiAU9zBVTUnef25bLumuMsWr@vger.kernel.org, AJvYcCXJ+EFBIKhtjcl+oF4AwAxbxp1gEkty0Eq7ZUvZWfJlelGJtZUax0gJfL/OosjGHjHam/ozAwrEYPaXHYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG70p/I6mMUt3iBC1+av48wSDJSBFetRb36DOdS9NRWBgb5e+U
	2oZppbjnT8K3ol010HboNn9MSbd8t0gDZz9Okkhm3dQ1Qu9PN78n
X-Gm-Gg: ASbGnctWsucEDFID6DCd1QYJ3tg3Xi0xue2RmOozDJ4El4HWCR/w6rVTXSVaSlQkFyZ
	0TlOTTwub4eAKX5qcdyMS3rHQNZGXQy/Z4rpBBIl8CeQSNO2L/7W/PpXoJ/dw2ujDXUVlx6ACJR
	35AKHNktJv5zhSsDWc+POxZtx5mUB8xvtIcAqeQQDYA+3H8iEq53VFRKHjumyGqkkvYXhPIE9sx
	IbciaMLLX2bM9fxrqHeg6Mx3QcVXKmTKDjiQrWlhVRot3/ljRu2R/GWYqvlSFZNS/fueYFkVDMu
	Pp9hgkqvK01FvDYLutn13/SDhIQwEsSmWUX1Q/sG8rkMVkgP3OMuHQ==
X-Google-Smtp-Source: AGHT+IH5FQdV2KOv/gbgcQCqZR0FYgwe8smObXUqh5iXmhfVX0k4hW3h0dtARWlMLxDGeGEW5k/EDA==
X-Received: by 2002:a5d:6da9:0:b0:38d:e2c1:9749 with SMTP id ffacd0b85a97d-38de2c1995emr3032192f8f.35.1739225469117;
        Mon, 10 Feb 2025 14:11:09 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf2ed900sm13123689f8f.53.2025.02.10.14.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:11:08 -0800 (PST)
Date: Mon, 10 Feb 2025 22:11:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 mitchell.augustin@canonical.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
Message-ID: <20250210221107.60d608ba@pumpkin>
In-Reply-To: <20250210134848.78a1ab4a.alex.williamson@redhat.com>
References: <20250120182202.1878581-1-alex.williamson@redhat.com>
	<20250209154512.GA18688@redhat.com>
	<20250210093641.0be242ae.alex.williamson@redhat.com>
	<20250210195658.GK32480@redhat.com>
	<20250210200819.GL32480@redhat.com>
	<20250210134848.78a1ab4a.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 13:48:48 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon, 10 Feb 2025 21:08:19 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > On 02/10, Oleg Nesterov wrote:  
> > >
> > > On 02/10, Alex Williamson wrote:    
> > > >
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)

You probably need __always_inline to have any chance of a compile-time
test of howmany.

> > > >  	unsigned int pos, reg;
> > > >  	u16 orig_cmd;
> > > >
> > > > -	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> > > > +	if (__builtin_constant_p(howmany))
> > > > +		BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);    
> > >
> > > Or just
> > >
> > > 	BUILD_BUG_ON(__builtin_constant_p(howmany) && howmany > PCI_STD_NUM_BARS);

	statically_true(howmany > PCI_STD_NUM_BARS)

> > >
> > > I dunno... Works for me in any case.
> > >
> > > I don't know if this is "right" solution though,    
> > 
> > I mean, atm I simply don't know if with the newer compiler
> > __builtin_constant_p(howmany) will be true in this case.  
> 
> That I can confirm.  With gcc 14.2.1, if I change the call in
> pci_setup_device() to use 7 rather than 6 for howmany, the build fails.
> If you confirm this resolves the build on older gcc, it seems like a
> valid fix.  I installed a VM with Fedora 23, which uses gcc 3.5.1, but
> I haven't yet been able to successfully build any kernel with it.  I'll
> post a patch if you want to provide a Tested-by.  Thanks,

Far too old a version to be supported.

	David

> 
> Alex
> 
> 


