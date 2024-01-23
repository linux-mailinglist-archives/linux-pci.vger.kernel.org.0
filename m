Return-Path: <linux-pci+bounces-2490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4383954F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A32856F6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8AF7FBA9;
	Tue, 23 Jan 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDWjqQOv"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECA7FBAC
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028435; cv=none; b=dfsWt7cqm6I/kPC7aRnKxX3vBFEUgVwdhX5VucAMX5N5AwrTt3gEUtbBRopLpo5cTgH177mV5n0dwqL8BLh1w//qr6jwL/JHDAHUwDSXm0QxMnhKs8qdTLckHGDatev0kWF/Dluur2ZVA1VBEfY1VWaCY65WWC5cqbWYzb9DzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028435; c=relaxed/simple;
	bh=VmqWmkVk2E221iXjM3l2lT8iiChVT3f//bDMS9EMSDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1L06fU4aqE7WgQiC2EYe1DqXTcyNF6R/brXmuQ0kZJpqVM13kj6NEY4DoiJ8Ro163qYDJdtKfH0hWKo72aRWZKR1FTLsOtN1UV31iLipCqMY7RKTSEeoTu9j4Nq10IJZ9pGrJGw6xG4afaPnuBbWQJ3eu6RzEISe2pNp1THecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDWjqQOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706028433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9mM7qlCz6z9YvWSA4Tu5l5wrgkaUMvIE6kPjXg7hy4=;
	b=XDWjqQOvL50+q2tGzd+HfZD6Z2NpvI3NRkHOukbLLzJikJqbvU5OyN7NobuHPibbeqjFdE
	ZrDZ5M6weW+tQvPADsgKW8a7rPnuTqgnD2FHRJYHNX0stMNA0U17jCSVSltmWwRjIqFfsf
	euUWAAreO9w4MaSNeWbeOnbrDyii1cw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-0uP9kSe-O9Wqx4qrxc5pfw-1; Tue, 23 Jan 2024 11:47:11 -0500
X-MC-Unique: 0uP9kSe-O9Wqx4qrxc5pfw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3628abe7c00so7645405ab.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 08:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028430; x=1706633230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9mM7qlCz6z9YvWSA4Tu5l5wrgkaUMvIE6kPjXg7hy4=;
        b=en16FAffdnd9ytrBodM6fhTR9rX/norvO4k8rq3Ucg4Bp66g95otl2b8a5+TNI0Q09
         RcaW4dwOLQSHnh1tyh3xerzMJiPyiy4lu+tN5bewL97hJxnN2pQfIax4iGHEPqiDYzny
         CIREmzYzgRaKdo4/0zlDyL5B6FT78RPxQvazsv3d31hLR+trUgNAe1L2Q+7CtdZjrCTi
         vM7jgEDMTmwKZbrnqsnvBVTRKSIpXlDuACHQ2S1ZhhpjYusxF1syADf55V2abojAlzGd
         eoa33VN1WizehoO8MErrSwpXFyeOhjocvo9VMrMaIdDUjih6JCbiylcL6K6TjXrpVrHD
         uzMA==
X-Gm-Message-State: AOJu0Yy3fjf7Ef1DtpxPNbzIYiHNV/jDQTmOTi3Oe8TE4sWecu11MU+b
	Zq+n2IjRagGEV/nxYIMXc91nNDZSU3p+mykePeCDJxINdvAJeRPNTw9wgAhh7i8uP+TmLFLiHpG
	E4i18Uz1Nf7TIC4NBXTFkz6Ii1VP2YSyIgFPjBpwh7C0oNIRAI7C52TfAcw==
X-Received: by 2002:a05:6e02:d50:b0:35f:f5cf:cbb4 with SMTP id h16-20020a056e020d5000b0035ff5cfcbb4mr115631ilj.40.1706028430660;
        Tue, 23 Jan 2024 08:47:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9fXaWBL0yG1u10Af5Dv9zNtVuVDGLAuHTeJ5fG1osxWhm/qUiT27aEHuqFS5qZWzxjjG/cw==
X-Received: by 2002:a05:6e02:d50:b0:35f:f5cf:cbb4 with SMTP id h16-20020a056e020d5000b0035ff5cfcbb4mr115624ilj.40.1706028430424;
        Tue, 23 Jan 2024 08:47:10 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ck12-20020a056e02370c00b003627a7f95a7sm1797183ilb.0.2024.01.23.08.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:47:09 -0800 (PST)
Date: Tue, 23 Jan 2024 09:47:08 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com,
 mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com,
 Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240123094708.39937bc4.alex.williamson@redhat.com>
In-Reply-To: <20240123161239.GA1386@wunner.de>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
	<20230803171233.3810944-3-alex.williamson@redhat.com>
	<20240118115049.3b5efef0.alex.williamson@redhat.com>
	<20240122221730.GA16831@wunner.de>
	<20240122155003.587225aa.alex.williamson@redhat.com>
	<20240123104519.GA21747@wunner.de>
	<20240123085521.07e2b978.alex.williamson@redhat.com>
	<20240123161239.GA1386@wunner.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 17:12:39 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Jan 23, 2024 at 08:55:21AM -0700, Alex Williamson wrote:
> > On Tue, 23 Jan 2024 11:45:19 +0100 Lukas Wunner <lukas@wunner.de> wrote:  
> > > If the device is RPM_SUSPENDING, why immediately resume it for polling?
> > > It's sufficient to poll it the next time around, i.e. 1 second later.
> > > 
> > > Likewise, if it's already RPM_RESUMING or RPM_ACTIVE anyway, no need
> > > to poll PME.  
> > 
> > I'm clearly not an expert on PME, but this is not obvious to me and
> > before the commit that went in through this thread, PME wakeup was
> > triggered regardless of the PM state.  I was trying to restore the
> > behavior of not requiring a specific PM state other than deferring
> > polling across transition states.  
> 
> There are broken devices which are incapable of signaling PME.
> As a workaround, the kernel polls these devices once per second.
> The first time the device signals PME, the kernel stops polling
> that particular device because PME is clearly working.
> 
> So this is just a best-effort way to support PME for broken devices.
> If it takes a little longer to detect that PME was signaled, it's not
> a big deal.
> 
> > The issue I'm trying to address is that config space of the device can
> > become inaccessible while calling pci_pme_wakeup() on it, causing a
> > system fault on some hardware.  So a gratuitous pci_pme_wakeup() can be
> > detrimental.
> > 
> > We require the device config space to remain accessible, therefore the
> > instantaneous test against D3cold and that the parent bridge is in D0
> > is not sufficient.  I see traces where the parent bridge is in D0, but
> > the PM state is RPM_SUSPENDING and the endpoint device transitions to
> > D3cold while we're executing pci_pme_wakeup().  
> 
> We have pci_config_pm_runtime_{get,put}() helpers to ensure the parent
> of a device is in D0 so that the device's config space is accessible.
> So you may need to use that in pci_pme_wakeup().

pci_config_pm_runtime_get() doesn't seem to align with our current
philosophy to defer polling devices that aren't in the correct power
state.  We require the bridge to be in D0, but we defer polling rather
than resume it otherwise.  We also defer device polling if the device
is in D3cold, whereas the above function would resume a device in that
state.  I think our bridge D0 test could be reliable if it were done
holding a reference acquired via pm_runtime_get_if_active().  Thanks,

Alex


