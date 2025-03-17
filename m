Return-Path: <linux-pci+bounces-23995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51FFA661C8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 23:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99A4177706
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 22:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E5200B9B;
	Mon, 17 Mar 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWshK70t"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6F156F4A
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251149; cv=none; b=fXPvhdsLlNLol7OfVB2jq3U/5EQ9aryPPXN5Y1PlvQ1DJq4i4hr23HofcvX1BhNuQZkYAQ6Z9HHE3dihBfbx1oGZ/2/cMV0P7QWzEkyxsXcfl4ii4sxRQNlo9A2vcYDGMp+hc67qifEx+OD5LYLDAYMd77YZ8F/o/I2JfTmRgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251149; c=relaxed/simple;
	bh=mquX9i7pAQ/himAy6+VWYSp1OgDbQoyAvlhyricqX+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6/qmz/lxZk5OvhMWLj/TN8TXc64zMKbVOo4p7aSZLjAu/Rtmq8BjQfUzvXyFY9Rg4fqmLqDMRq2CRoCUmdGdy60T1mSOcu6gQCVImlJyCUCZjCjq+6BXEHX2HSlJLfvvH3uLQDQbhkNkE5abKSedIy8goOr3/oDdsc8KBOt1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWshK70t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742251147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmYgdowPoipn2eB0gwBS5Rlmh9/HbjoRVzD1SOShhrs=;
	b=gWshK70tnIMr6avvIZw6WK+tl7EHEjLXqbc1lMyHUdufs4pUMtqih2GFb9CpGfiwOaeZei
	6u7GvhQONzmaavZyjYLgX10M8tn48Qr8h2FsPnP2Pp6vuJdFPJ/rGUZTE0mEobk7Y6iNf+
	IHg0scg4ci0FjqeDg8vebgPqBL8OhwU=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-VFGIAHgcPKKWDnRFM04ZqQ-1; Mon, 17 Mar 2025 18:39:05 -0400
X-MC-Unique: VFGIAHgcPKKWDnRFM04ZqQ-1
X-Mimecast-MFC-AGG-ID: VFGIAHgcPKKWDnRFM04ZqQ_1742251145
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2c2dc0ea814so297046fac.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 15:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742251145; x=1742855945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmYgdowPoipn2eB0gwBS5Rlmh9/HbjoRVzD1SOShhrs=;
        b=N/JqKf//G3TpGZY9RR1bd7eR6rcDnE7tddVHgkTFtOfsgdr5dhGMAwaBC9s90beolP
         4uDSTS2a3Ikyem4PstUJ9BaSM/zXf9WXan0pz8reeWB4sIzNoCgDbbhpIQRH+2RUlSOC
         ZLEZGmw4Ndd0nmSRCJcMKTQolcPbFp+RFeBT5lHOU3eI8QDZVJs9ZckEA3NyDrq/662O
         zObAQk2X3gAhwq3XkfG8+PzLTz5wQFTP2JkucwKdSbV+CCkRebPa+PwFE6LXvu0K1CMd
         OlouN3IGazWcj8W4SG0hnNEtJZhlPsV6Dw3v4Nzgq9wfMgozh2rzExhNIR4lsjBJIMON
         wZPg==
X-Forwarded-Encrypted: i=1; AJvYcCXo2vgy/ao03tOIZyPJZGD1CYyg9oneyrmSf32olAJ2HFmoZEAXfJ9j28yCO6cNL3Pq1lAHCuC7G7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlG67RzC16o2PVkN67hO8q2rQK7ORwYsSBG1k3JvejjvzY1JI7
	yrRiTO17lY0ZWXQtnzQXCn3EnC2z0XC/UQ65lPB5ZWfZj9xPDmVbjxBYth9zsa1MWAZN7P8YCWs
	lt9X4eq0IGAcsyHvXAnoiVAaFCSgV+hojLbx232poED3AsvgshCR+3hx4uQ==
X-Gm-Gg: ASbGncubzJqatvx/83DvMZG2wToEaVsPgUss2n4ALtODZ7LTTXkCaRipE6z1eOwQs1Y
	bBDkAoi5IjETdg1gnmvQhE3VJV7y713UPfFqcTI9dOl7kzeS88Y1RwzxqmLSckrQZqEs4G9GnXb
	r0MXKaIzANOf/L7Xg4XdWgbItdhFNraP0bo/YHJwBNRR29hGxRH4ZOfHkMTO9A+7RlCM4SUVacw
	Fsrjmt9fxiroJkblCSWOfG3Z8b7kQB0lbVljML6Xvmw8nSncObhU44TA2UPGEPlpVWfaLGUdJAU
	STVOJWpq0octnpkrR4k=
X-Received: by 2002:a05:6820:270a:b0:600:2729:25ba with SMTP id 006d021491bc7-601e45be988mr2442910eaf.1.1742251144855;
        Mon, 17 Mar 2025 15:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbsNciZRw/nFluLflYZvQyGShPH55bNzYgUMAisb3ebrP4tjURZQuOYf8gabdM+YWR7SpgVg==
X-Received: by 2002:a05:6820:270a:b0:600:2729:25ba with SMTP id 006d021491bc7-601e45be988mr2442906eaf.1.1742251144509;
        Mon, 17 Mar 2025 15:39:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601e4f41f85sm1426282eaf.16.2025.03.17.15.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:39:02 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:38:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250317163859.671a618f.alex.williamson@redhat.com>
In-Reply-To: <kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
	<20250314085649.4aefc1b5.alex.williamson@redhat.com>
	<kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Mar 2025 19:18:03 +0100
Micha=C5=82 Winiarski <michal.winiarski@intel.com> wrote:

> On Fri, Mar 14, 2025 at 08:56:49AM -0600, Alex Williamson wrote:
> > On Fri,  7 Mar 2025 16:03:49 +0200
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >  =20
> > > __resource_resize_store() attempts to release all resources of the
> > > device before attempting the resize. The loop, however, only covers
> > > standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> > > assigned, pci_reassign_bridge_resources() finds the bridge window sti=
ll
> > > has some assigned child resources and returns -NOENT which makes
> > > pci_resize_resource() to detect an error and abort the resize.
> > >=20
> > > Change the release loop to cover all resources up to VF BARs which
> > > allows the resize operation to release the bridge windows and attempt
> > > to assigned them again with the different size.
> > >=20
> > > As __resource_resize_store() checks first that no driver is bound to
> > > the PCI device before resizing is allowed, SR-IOV cannot be enabled
> > > during resize so it is safe to release also the IOV resources. =20
> >=20
> > Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, which I
> > understand is done intentionally.  Thanks, =20
>=20
> Is that really intentional?
> PCI warns when that scenario occurs:
> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/pci/iov.c#L936

Yep, it warns.  It doesn't prevent it from happening though.

> I thought that the usecase is binding pci-pf-stub, creating VFs, and
> letting the driver be.
> But unbinding after creating VFs? What's the goal of that?
> Perhaps we're just missing .remove() in pci-pf-stub?

I guess I don't actually know that leaving SR-IOV enabled was
intentional, maybe it was an oversight.  The original commit only
mentions the case of a device that requires nothing but this shim as
the PF driver.  A pci_warn() isn't much disincentive, the system might
already have taints.  If it's something that we really want to show as
broken, it'd probably need to be a WARN_ON.  Thanks,

Alex


