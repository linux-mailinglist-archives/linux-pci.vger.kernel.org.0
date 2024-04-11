Return-Path: <linux-pci+bounces-6137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 866528A1B50
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82E01C21734
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44B79B8E;
	Thu, 11 Apr 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVxuE2g4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9B7FBA2;
	Thu, 11 Apr 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851258; cv=none; b=kVutbDWy3ryqdF51sHEtrZiB63vYzaubs7b6MyUMFmcwRKuiEvOyPcMaF1TCS+W6P2wyDBUVozQppfuyPpKPXeuUvaJT/k3+joqQZZjBa+cfq3Eu0tKNjYxzuGYxPaeuykBAbkHzMu/FF8MvQBugu8CdzS6gtU7KQZxySVsJD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851258; c=relaxed/simple;
	bh=4rLA/HSwGcqOerjQJOn9pYbVTF4v9Q606DpK3OhBHoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF18dG08x9DvfgrGvaOFQd4eqzJQhxXBThOYQRHkB2mDmPb/iWiOySoqolXYFszpfO17SbGIg/g302r2kvEamjtIgR5po+jt8WHuLPBFXy7GmJ4qfZ7zNKFk7buunyR79tvMe3G76xNnI4rWBv50YMIIOr+QmT7X8T7eIXyIpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVxuE2g4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-417d02ab780so61455e9.3;
        Thu, 11 Apr 2024 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712851255; x=1713456055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rLA/HSwGcqOerjQJOn9pYbVTF4v9Q606DpK3OhBHoc=;
        b=AVxuE2g4W+sc839sbVflVa+/ykG+J+ISl+XslLK2xwuRtOxtR8yL4vSnR9bFNtQgdF
         Ax5vr8ZT7GSIdFm5SKGjpFEqU2JyANnL7U3WE/9SDDXXGnTFHLkcm5djjQwgFwxqiiR3
         C8pMf5ICIHSpOXaSHt3TIKINgBJ+mwlSxfQAa9SGNCGU9t4YLJWKcXEGu/coIQzoTbEi
         q/Z3ev5M+BXriaGmEAi2HYOvix2lKcaMCei4XnQaYmyHKRN3usa5SDmbIQK3hUrCI3iE
         ImTDjrkjwF/otLc00lhkVElP/DIbp+7CaLbKWmfec3Nn/CAY6jvFa01xFDUYesVKIwD2
         qFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851255; x=1713456055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rLA/HSwGcqOerjQJOn9pYbVTF4v9Q606DpK3OhBHoc=;
        b=ut88uQBLP8W9VO8QjgEwsnAwbADOsziFFSDCEn0DS17NvQFdfboS13FEnYB1bECLco
         QP/IuPvXR2o/XIXauikxB691V9bxlAPlvureO/6iwDl9cTMqRrJIymO3sHWqgqptDV3Z
         6Iw6UtYi6AiW4+sMYCjk437ZdMN0XjH8ZAHimN9xKeWRNAug+Gm+QkBqH8VaqT8TApc7
         OITF3RzBjLCDxLVYmVz+JZZaDzbwyzNGg2cZhGjZ9s9u6oeJ8DnH0eHkxzbEW3+IQ6zl
         K6AFXtHUQfZJXhA0foRCe9GEE2PB5e8eZk1M1RpLJAjBhmrxrvAfNTk21cDCSl9i9hXs
         HssA==
X-Forwarded-Encrypted: i=1; AJvYcCWviqTYAJpL7F2b7LzCDoK5nyaIDtrfYFfV68WZyL9gkhzgqxahMsA/AGmNr8yaRxMSMxBnyyBcQbQNhTpv8JBnAWMIW9U9XDFCSm7pXjhcQWkpYo87+8TPpTYfRwAdTlXT
X-Gm-Message-State: AOJu0YxLst+g3ES0cPK3C4ZAR395olI0pieAS6/UKx4hE76hmWzWLo1X
	DqPjWWKWVtwNS5jRoaYeXZdEP5WZXwJVAfAZNjTq4qkzyAolKVAoAeBojyWZF6wKcx0AiX9qe03
	64zIKDa94mfnG8bqvbeKZ3B8Misg=
X-Google-Smtp-Source: AGHT+IEv6SkaFO9TkhvK08UGmkS4usIr4ciEBe+v3bRUvwWKFX99Y5TXj+YL4XTvo1UgCMBYbiii2Ktw4EdqDTu8F5A=
X-Received: by 2002:a05:600c:1d1e:b0:416:644d:6dba with SMTP id
 l30-20020a05600c1d1e00b00416644d6dbamr177103wms.4.1712851255217; Thu, 11 Apr
 2024 09:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
 <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com>
 <c820695d-bda7-4452-a563-170700baf958@lunn.ch> <CAKgT0Uf4i_MN-Wkvpk29YevwsgFrQ3TeQ5-ogLrF-QyMSjtiug@mail.gmail.com>
 <c437cf8e-57d5-44d3-a71d-c95ea84838fd@lunn.ch>
In-Reply-To: <c437cf8e-57d5-44d3-a71d-c95ea84838fd@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 11 Apr 2024 09:00:17 -0700
Message-ID: <CAKgT0UcO-=dg2g0uFSMt2UnyzF7y2W8RVFDp15RZhy=Vb4g61Q@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	John Fastabend <john.fastabend@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:37=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Well I was referring more to the data path level more than the phy
> > configuration. I suspect different people have different levels of
> > expectations on what minimal firmware is. With this hardware we at
> > least don't need to use firmware commands to enable or disable queues,
> > get the device stats, or update a MAC address.
> >
> > When it comes to multi-host NICs I am not sure there are going to be
> > any solutions that don't have some level of firmware due to the fact
> > that the cable is physically shared with multiple slots.
>
> This is something Russell King at least considered. I don't really
> know enough to know why its impossible for Linux to deal with multiple
> slots.

It mostly has to do with the arbitration between them. It is a matter
of having to pass a TON of info to the individual slice and then the
problem is it would have to do things correctly and not manage to take
out it's neighbor or the BMC.

> > I am assuming we still want to do the PCS driver. So I will still see
> > what I can do to get that setup.
>
> You should look at the API offered by drivers in drivers/net/pcs. It
> is designed to be used with drivers which actually drive the hardware,
> and use phylink. Who is responsible for configuring and looking at the
> results of auto negotiation? Who is responsible for putting the PCS
> into the correct mode depending on the SFP modules capabilities?
> Because you seemed to of split the PCS into two, and hidden some of it
> away, i don't know if it makes sense to try to shoehorn what is left
> into a Linux driver.

We have control of the auto negotiation as that is north of the PMA
and is configured per host. We should support clause 73 autoneg.
Although we haven't done much with it as most of our use cases are
just fixed speed setups to the switch over either 25G-CR1, 50G-CR2,
50G-CR1, or 100G-CR2. So odds are we aren't going to be doing anything
too terribly exciting.

As far as the QSFP setup the FW is responsible for any communication
with it. I suspect that the expectation is that we aren't going to
need much in the way of config since we are just using direct attach
cables. So we are the only one driving the PCS assuming we aren't
talking about power-on init where the FW is setting up for the BMC to
have access.

We will have to see. The PCS drivers in that directory mostly make
sense to me and don't look like too much of a departure from my
current code. It will just be a matter of splitting up the fbnic_mac.c
file and adding the PCS logic as a separate block, or at least I hope
that is all that is mostly involved. Probably take me a week or two to
get it coded up and push out the v2.

