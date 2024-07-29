Return-Path: <linux-pci+bounces-10927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966293EB32
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 04:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528D2281A81
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0F76F17;
	Mon, 29 Jul 2024 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IdFl1slG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAF7580D
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219892; cv=none; b=g8GiyspHuaO54eRMU9RH72yRPMYhrP48FAZkROgKLKRsxpom9TN4kIuRKUMRoeVuWwWAOkQm9npUsvY4G25LUI04jjRSEzWyYZxk3/q2Ex5IgVPXb4lJkRdTB6HJWyUFzGQuLQ5FQ4jsfOSGIr2i9b9ZKWcNtBqWW6v+yQBNQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219892; c=relaxed/simple;
	bh=7ZJr2qPLfzGOtmLOuiFRhw+vwX2H4pAlmFj8krEKhEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOetHluFmes4bMvLieg6oDLqMYVc1VwFFUdHoWcBs9OATUVRX31zmJjdFQl8bv+YsdKavuMd1BsDoqrBX3s0PPAjgvv4n6eJ2z+Dwgs/G9eV15AcFSYNuQ3UVFWL3YQREi49yjnCaLaN/WKFwrFpFwuk6u6RZ8v8fQJLMsBKrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=IdFl1slG; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 125253F433
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 02:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722219882;
	bh=CmV/ggYFbpcIV+CZdy96FFABIX7/zLLVJz8oRkArprU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=IdFl1slGPgpBr9Zc6tU6L0nGoAatNqDrUoyPTYNOdPoH0hr+DWuNhQLR16VUlnU92
	 HQ4Hj7TTKXXw+/rziF/5dHcHjEP41+34apbt+iT/P/8g4pxnhmmiVJiOR1+BuwgOsy
	 YmqVTX9rWb3JnyGBd5dl4K/xplr7CgzxFLZEYwlUxDkN9tfHLazDfdAv8dThb+82zD
	 mbBlyMhEMMcVscQ06iwBdkonH0GK/50DK5jZEOUQwk9zoRYdJT042Kwn5iCqZIqSz2
	 PN7Oeasardd9wopOQjOB3M7m+HnFHhfBrIMoxC4+2B1Xt4e07FmKAAg05OowCrsCN2
	 3szr8ZrHp9wHA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c965f8f813so2640827a91.2
        for <linux-pci@vger.kernel.org>; Sun, 28 Jul 2024 19:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722219880; x=1722824680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmV/ggYFbpcIV+CZdy96FFABIX7/zLLVJz8oRkArprU=;
        b=hrYgombcgBm7SxNLSL/7dCkD5Ke9shqSZ5wY2o3s2zzTBWoNmufzEbTXlW9BpmoSav
         HI3eqQ+0x2cHCAJegRIL4VPQ94fOxK5QJrMOIemFhuPLouIDHBd0gURpg+1OdiMfXrxQ
         kDdTemDSzZHSoCUD/Gsv0UAkmTm2WvL/j6EXzZZwyEuJ+xnFMAP9QE32ra2GctYOChjR
         br3jK84/bmrodPuYmAR/nn3eDiVdRRO29LKbj3OUtHl/N3r4vZy6Xtfi4kKv+/hqXVIX
         16pll74Fvav01mwTLbGromQ4AUkvAdEGblxFFKAm+3EAGSxa5SLD7cwitwmZdYkKEASK
         Njlw==
X-Gm-Message-State: AOJu0Yw1OkDGyx2qwQ0zJtpGXcuBqVlHV39lFlayMS/xJeRAZtLwH76C
	E//6nrooy9u4Y+aHKml03n+1idGfRt1zurnI/iZYWMuhunHl/u4EMlKQmOgIHBhDhcUW5mdvOjG
	shWseimp1o5Bx/GZnFWPTMYgtoXpm78xIanYBepRu1TnH3rIN0A0MtZzR1sI3zwbsjb8BrpTfPn
	b2Suiva9bh9k1QmTfUKXM18xuRYMle8nXifC2Sa4zDOhaHlP7A
X-Received: by 2002:a17:90a:930f:b0:2c9:9f06:bb2f with SMTP id 98e67ed59e1d1-2cf7e1a1d9amr4142250a91.6.1722219880411;
        Sun, 28 Jul 2024 19:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/6WcZAQCL48dKOKCaO7rysDJm1KdMhDjjZ+PcVCXVbVJvY9ZRBK8MHlWuqjtJ3TTvSJhg7qG5dMGCJwVj/sM=
X-Received: by 2002:a17:90a:930f:b0:2c9:9f06:bb2f with SMTP id
 98e67ed59e1d1-2cf7e1a1d9amr4142241a91.6.1722219880067; Sun, 28 Jul 2024
 19:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715214529.GA447149@bhelgaas>
In-Reply-To: <20240715214529.GA447149@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 29 Jul 2024 10:24:28 +0800
Message-ID: <CAAd53p4pr5GPKj3RKbBScDFqUJ+2eCb+t3tuALKuhCigLfeeHg@mail.gmail.com>
Subject: Re: Lack of _HPX after reset, DPC
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Austin Bolen <Austin.Bolen@dell.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Tue, Jul 16, 2024 at 5:45=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> I think Linux is missing some important _HPX functionality.  Per ACPI
> r6.5, sec 6.2.9,
>
>   OSPM uses the information returned by _HPX to determine how to
>   configure PCI Functions that are hot-plugged into the system, to
>   configure Functions not configured by the platform firmware during
>   initial system boot, and to configure Functions any time they lose
>   configuration space settings (e.g. OSPM issues a Secondary Bus
>   Reset/Function Level Reset or Downstream Port Containment is
>   triggered).
>
> Linux currently *does* process _HPX for hot-added devices.
>
> The spec doesn't call it out for boot-time enumeration, except for
> "Functions not configured by the platform firmware during initial
> system boot", but Linux does process _HPX for all devices enumerated
> at boot-time because it's not clear how to identify devices that
> weren't configured by firmware.
>
> But AFAICT, Linux does not do anything with _HPX in the device reset,
> AER, or DPC flows.  I don't have any problem reports that I can say
> are caused by lack of _HPX after reset, but it seems like something we
> should fix.

The consumer grade devices I checked don't have _HPX in the ACPI ASL.
So I can't really delve into it any further.

Kai-Heng

>
> If we could find a system with _HPX that does something interesting,
> we might be able to demonstrate a defect by looking at a device before
> and after a reset.
>
> Bjorn

