Return-Path: <linux-pci+bounces-2328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D58F831F3E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E682811B0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 18:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C782E3E8;
	Thu, 18 Jan 2024 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZpzqD4B"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA12DF9F
	for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603857; cv=none; b=rwBG9oeP6xQg+uFfoZQLmE3hM+j5BKAF3AmtEHxaGXLIN/Ad+41EgAJbJzNAPOdZfIoq8NWGWOvQ4TF0MyiqvCsxL6sL5RIbpV8kNGXKONUaKpqY/FCnKja8Bh/SA5XZHM8xO/qfFHuGxsS4txPuH61ivfxkU/qzh7aS+fj7j/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603857; c=relaxed/simple;
	bh=5DBvOOjTo11dY72JQZ4WQ4Zc6CbG9VDQi1fPHIhX5xY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6xrZRJCeCYtdJzK42a3NFCzk5I0h8oFBkvJ/LHkBFmo0R6boqp6A8J21Bg2b+mSyadXlTdLb5mWwlo52Igk5FdqJTNJd9Xi+gwfBXsMrPe8KY2ahFJZSEiiflaeGKjpc/qToaYJpOv84qrfmPro9pImT2ieZCZbLZKdbjh+wCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZpzqD4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705603854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFsvWH24N9UYJpCv+/zyLoQIPbNvOSLwuLZ1f5QrG/0=;
	b=gZpzqD4BKikguHbWqaxDVgZmzE1mIvsPgj+sZh5E0XoWfGBP1Qi+bgN4kJhz88QQbhvg1Y
	nhEjxZaDLJFDRi6nud2hMS1iUjTwPqEXNxZbpx9rkM7FfrGMt3lH0advDKjja7lOZnWVoZ
	l1/oRHp/rYPOFWZ0VY/i0isaR55bZvs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-Xx2J3hi6Pb2bMJyQdU8aTw-1; Thu, 18 Jan 2024 13:50:52 -0500
X-MC-Unique: Xx2J3hi6Pb2bMJyQdU8aTw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360d8e54839so58455155ab.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 10:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603851; x=1706208651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFsvWH24N9UYJpCv+/zyLoQIPbNvOSLwuLZ1f5QrG/0=;
        b=wvsnXp57ZIE83B/dX5sKG7eBMuPbybi/OsAVnZGC+8WSknv8DF8BD7NXKMUS39sh9C
         fdfQkGAMGvHygbsaUrqx6NwO0LahrA9z1E/cOsYJ4bNhfbL29DHpTMENQQQkXePRXpK1
         MVDoTBLktyq9YL216ng3knRROn3lU0QP5GmkGoKPPFTgrd3XVo5iPIBAif4e3dncqIBL
         gG3AJk6QeqFw1CkExXXmlD9O5ynTJ5oguNWCC2emoz4tyspGV7kJ+RCR1TkQgPL0Oy/M
         QOAlQtrnA6abU2bW0OR9/PV6FCuEglPF52KWu4jpZkHHkzsBcBAFfOnKcxZOepm1maHf
         j/DA==
X-Gm-Message-State: AOJu0YwABTTjqueCRzO2NET/Z3CAUf4sCuE/2NVRCnrldlNBEWMdK+cJ
	u72xvwXG+dJTDxfLhxSqpPS4aze7KcfQOuXbk94qkOqQpuqTIpAvzNhwSnRb9sTI50PY6mSp5XY
	TwYvppo+QJMwET6+JZhNeXe9P8xt1xApxETw5zjEwvQN4CzfRaIpO691Tew==
X-Received: by 2002:a92:c703:0:b0:361:8f09:f6c2 with SMTP id a3-20020a92c703000000b003618f09f6c2mr1328640ilp.96.1705603851709;
        Thu, 18 Jan 2024 10:50:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvla97OHsxwYj++ANJcOgBsiy9ieFQr9Qeas2EYBvsXjL4N4symvjrWvpCyjwHVhgLT697ag==
X-Received: by 2002:a92:c703:0:b0:361:8f09:f6c2 with SMTP id a3-20020a92c703000000b003618f09f6c2mr1328628ilp.96.1705603851392;
        Thu, 18 Jan 2024 10:50:51 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id dp1-20020a0566381c8100b0046923df89easm1110484jab.158.2024.01.18.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:50:50 -0800 (PST)
Date: Thu, 18 Jan 2024 11:50:49 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
 eric.auger@redhat.com, mika.westerberg@linux.intel.com, lukas@wunner.de,
 rafael.j.wysocki@intel.com, Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240118115049.3b5efef0.alex.williamson@redhat.com>
In-Reply-To: <20230803171233.3810944-3-alex.williamson@redhat.com>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
	<20230803171233.3810944-3-alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Aug 2023 11:12:33 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Testing that a device is not currently in a low power state provides no
> guarantees that the device is not immenently transitioning to such a state.
> We need to increment the PM usage counter before accessing the device.
> Since we don't wish to wake the device for PME polling, do so only if the
> device is already active by using pm_runtime_get_if_active().
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/pci.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Hey folks,

Resurrecting this patch (currently commit d3fcd7360338) for discussion
as it's been identified as the source of a regression in:

https://bugzilla.kernel.org/show_bug.cgi?id=218360

Copying Mika, Lukas, and Rafael as it's related to:

000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")

where we skip devices in D3cold when processing the PME list.

I think the issue in the above bz is that the downstream TB3/USB4 port
is in D3 (presumably D3hot) and I therefore infer the device is in state
RPM_SUSPENDED.  This commit is attempting to make sure the device power
state is stable across the call such that it does not transition into
D3cold while we're accessing it.

To do that I used pm_runtime_get_if_active(), but in retrospect this
requires the device to be in RPM_ACTIVE so we end up skipping anything
suspended or transitioning.

As reported in the above bz, I tried replacing this with:

	pm_runtime_get_noresume(dev);
	pm_runtime_barrier(dev);

The theory here being that the barrier would wait for any transitioning
states such that as far as runtime power management is concerned, the
device power state is stable.

This causes live locks where the barrier never returns.

Instead I'm considering that since we're polling the PME list, maybe we
could just defer devices in transition states, for instance something
that looks like pm_runtime_get_if_active(), but would return zero if
the device was in RPM_SUSPENDING or RPM_RESUMING rather than requiring
RPM_ACTIVE.

I'm not an expert in PME or runtime power management though, so I'm
looking for advice.  Thanks,

Alex

> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..bc266f290b2c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2415,10 +2415,13 @@ static void pci_pme_list_scan(struct work_struct *work)
>  
>  	mutex_lock(&pci_pme_list_mutex);
>  	list_for_each_entry_safe(pme_dev, n, &pci_pme_list, list) {
> -		if (pme_dev->dev->pme_poll) {
> -			struct pci_dev *bridge;
> +		struct pci_dev *pdev = pme_dev->dev;
> +
> +		if (pdev->pme_poll) {
> +			struct pci_dev *bridge = pdev->bus->self;
> +			struct device *dev = &pdev->dev;
> +			int pm_status;
>  
> -			bridge = pme_dev->dev->bus->self;
>  			/*
>  			 * If bridge is in low power state, the
>  			 * configuration space of subordinate devices
> @@ -2426,14 +2429,20 @@ static void pci_pme_list_scan(struct work_struct *work)
>  			 */
>  			if (bridge && bridge->current_state != PCI_D0)
>  				continue;
> +
>  			/*
> -			 * If the device is in D3cold it should not be
> -			 * polled either.
> +			 * If the device is in a low power state it
> +			 * should not be polled either.
>  			 */
> -			if (pme_dev->dev->current_state == PCI_D3cold)
> +			pm_status = pm_runtime_get_if_active(dev, true);
> +			if (!pm_status)
>  				continue;
>  
> -			pci_pme_wakeup(pme_dev->dev, NULL);
> +			if (pdev->current_state != PCI_D3cold)
> +				pci_pme_wakeup(pdev, NULL);
> +
> +			if (pm_status > 0)
> +				pm_runtime_put(dev);
>  		} else {
>  			list_del(&pme_dev->list);
>  			kfree(pme_dev);


