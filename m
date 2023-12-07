Return-Path: <linux-pci+bounces-638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA524809683
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 00:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B222B20B0A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 23:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABCC4F8B2;
	Thu,  7 Dec 2023 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkRlxFBw"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A971712
	for <linux-pci@vger.kernel.org>; Thu,  7 Dec 2023 15:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701991312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2A4NN2g2IRl3a/HPVTv7XHKFlgL0Mi4dJpLGEepk7M=;
	b=OkRlxFBwnznAOkEQn71swKViQyRitYxFwtnHxP9/f+eLfn6X8nF1gGyzYHG/ySVdwJp1hp
	boyDMOgXq0RVHvzrNIJtc9M50ZMMaXPjE8eRuXG76atr/Cbbzp6uGzYiOz1g3pBegcJbpe
	yEHTJOr8epZdAzpyaXu3UFslVz3P1ak=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-Hof_fiCmPtGUXCZPYMRQQA-1; Thu, 07 Dec 2023 18:21:50 -0500
X-MC-Unique: Hof_fiCmPtGUXCZPYMRQQA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35d530fe1b5so17665015ab.3
        for <linux-pci@vger.kernel.org>; Thu, 07 Dec 2023 15:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701991310; x=1702596110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2A4NN2g2IRl3a/HPVTv7XHKFlgL0Mi4dJpLGEepk7M=;
        b=WET2XUrJZ1mLP0nzgQCZP8MIbR9AeSWSe7brYoSsMR90FhdzhHJ6RXNQ1aKxBJICQx
         yEVzA4odxNZCarjwKagHqacLo5Wwgj7NwTbb+8MN//x95E3xks/Mo2G0fuicuPrJseVS
         pvSevxxuFBSvpaBkqquxt2DeIboQdjXLwORu9ivrsQ4siYnPQn+vmliCG438SpNsc4gl
         JK7RGaRPP18OXkcfFeahjgYP5P14YVhma4T8hVIZrn55oagpC05hpEVSaa0ealILZZaZ
         TviyL3mJlGXqhBaPI3stXKuUcFlJOW95zYQiR9aL1sAU0K3KtHz+aqOF8/oP4Ww+PfpP
         iwHQ==
X-Gm-Message-State: AOJu0Yy0hPaoWI85hEyPQkUFC1ykfYSIa/SrrC+gHbxLqlMtKjuP3Xf0
	qsIBYXf0YMsp5YNhlUVwoP8CgTEb2CeCfj/JqotoqHejfH42qq0qmREgxb6ut1Mjec/H41JMyVY
	llZfQ4gVhzeBhiRjXjruP
X-Received: by 2002:a92:c5af:0:b0:35d:5995:903b with SMTP id r15-20020a92c5af000000b0035d5995903bmr3034524ilt.46.1701991310150;
        Thu, 07 Dec 2023 15:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwPnwPxJCnGBO8ZWNiwb9MZD6i4z5OEZaWA1m90wazcjxwSbhZecNVdbLVPASZUOCL8SkQdw==
X-Received: by 2002:a92:c5af:0:b0:35d:5995:903b with SMTP id r15-20020a92c5af000000b0035d5995903bmr3034520ilt.46.1701991309890;
        Thu, 07 Dec 2023 15:21:49 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id a62-20020a029444000000b0046674d6318fsm178879jai.17.2023.12.07.15.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:21:49 -0800 (PST)
Date: Thu, 7 Dec 2023 16:21:48 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jim Harris <jim.harris@samsung.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "ben@nvidia.com" <ben@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: Re: Locking between vfio hot-remove and pci sysfs sriov_numvfs
Message-ID: <20231207162148.2631fa58.alex.williamson@redhat.com>
In-Reply-To: <ZXJI5+f8bUelVXqu@ubuntu>
References: <CGME20231207223824uscas1p27dd91f0af56cda282cd28046cc981fe9@uscas1p2.samsung.com>
	<ZXJI5+f8bUelVXqu@ubuntu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 22:38:23 +0000
Jim Harris <jim.harris@samsung.com> wrote:

> I am seeing a deadlock using SPDK with hotplug detection using vfio-pci
> and an SR-IOV enabled NVMe SSD. It is not clear if this deadlock is intended
> or if it's a kernel bug.
> 
> Note: SPDK uses DPDK's PCI device enumeration framework, so I'll reference
> both SPDK and DPDK in this description.
> 
> DPDK registers an eventfd with vfio for hotplug notifications. If the associated
> device is removed (i.e. write 1 to its pci sysfs remove entry), vfio
> writes to the eventfd, requesting DPDK to release the device. It does this
> while holding the device_lock(), and then waits for completion.
> 
> DPDK gets the notification, and passes it up to SPDK. SPDK does not release
> the device immediately. It has some asynchronous operations that need to be
> performed first, so it will release the device a bit later.
> 
> But before the device is released, SPDK also triggers DPDK to do a sysfs scan
> looking for newly inserted devices. Note that the removed device is not
> completely removed yet from kernel PCI perspective - all of its sysfs entries
> are still available, including sriov_numvfs.
> 
> DPDK explicitly reads sriov_numvfs to see if the device is SR-IOV capable.
> SPDK itself doesn't actually use this value, but it is part of the scan
> triggered by SPDK and directly leads to the deadlock. sriov_numvfs_show()
> deadlocks because it tries to hold device_lock() while reading the pci
> device's pdev->sriov->num_VFs.
> 
> We're able to workaround this in SPDK by deferring the sysfs scan if
> a device removal is in process. And maybe that is what we are supposed to
> be doing, to avoid this deadlock?
> 
> Reference to SPDK issue, for some more details (plus simple repro stpes for
> anyone already familiar with SPDK): https://github.com/spdk/spdk/issues/3205

device_lock() has been a recurring problem.  We don't have a lot of
leeway in how we support the driver remove callback, the device needs
to be released.  We can't return -EBUSY and I don't think we can drop
the mutex while we're waiting on userspace.

I've done some fix-ups in the past to use device_trylock() to avoid
deadlocks, which might be an option here, ex. reading sriov_numvfs
could return -EBUSY in this scenario.  We keep running into these
scenarios though and we might just need to pick a point at which we
kill the user process holding the device.

I'm open to suggestions.  Thanks,

Alex


