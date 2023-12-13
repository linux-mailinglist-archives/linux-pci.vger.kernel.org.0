Return-Path: <linux-pci+bounces-886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CC811ADB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC191C210C3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B624553E32;
	Wed, 13 Dec 2023 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpqfDjRs"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CC5C9
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 09:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702488203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lW+slIbgOWxQYT2O+S6YlFHh9FNlRvovXoJXaZ6ywjY=;
	b=YpqfDjRsjIXLGoQP65dRC1ETteg+ekDgIGxawxI3rjUkB9vk2mAglsG0b9/3JJyaRt+p6y
	sgOjctp+lqNNdanG6336jbADKiRLcRVRWPQ1YY30aFTzNHkMKG1M0YX6N2TFGc91VO1Wbd
	Qh0N7BA/QHfNcnAeS+BmVi2M66dsHUE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-v5cmeMpZOHGSgaenl1NtpQ-1; Wed, 13 Dec 2023 12:23:21 -0500
X-MC-Unique: v5cmeMpZOHGSgaenl1NtpQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b705896cb2so642627339f.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 09:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488201; x=1703093001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lW+slIbgOWxQYT2O+S6YlFHh9FNlRvovXoJXaZ6ywjY=;
        b=HKpkcaLpQjH7dJx53yVpYYl1HQkHJ9xMTgGStqCmCgJAmAOaG7nB93vdJc6ymKjX7e
         sJs+EF7oGb0ikkYMdKQKuzq53M/b1mLU8XnYJnnfPI8Ug3myx8wirwbYV20GljasUpXr
         KONvsVPu6EdVEqv/fnBJSlz4E0GCMMGa+Eah+z0OUE3UXGkUwKtuVqlvKTvPfT2NEk58
         N0dVJOmztfBHpRsOYH5XATNTjC6LZ3m+Fzmo45mBU5I+be+3YuUsCqz/d+x1rfw7yrqD
         4W/FbaquUys5aUTxvjJKi0W3YcyxYjcXMTyiEAf2tmeMJKs9BUI90stmF2XpQq8TIPWP
         jbuw==
X-Gm-Message-State: AOJu0Yz1yiH6pFMQMuIA1NjltghMeJ7mMYGfWJLvA9Gg+SY5YJLgZNLo
	hTklOZsgZ9kQsT3mtps37RAU4JysyXybnb6Uv9zbedXgMN+AYjOPk2tvN4tkUowLKKRlWdRgwHo
	GbXirjg3xscLIKE+JJsCN
X-Received: by 2002:a05:6602:1a97:b0:79f:a25b:51c with SMTP id bn23-20020a0566021a9700b0079fa25b051cmr10389022iob.11.1702488201170;
        Wed, 13 Dec 2023 09:23:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFCUuyUF4x+tZBY8379UMXrAqtq0HGQyqFOkmn1DuvufBIpPGTKilPvSnotsXstBcZth0E6Q==
X-Received: by 2002:a05:6602:1a97:b0:79f:a25b:51c with SMTP id bn23-20020a0566021a9700b0079fa25b051cmr10389011iob.11.1702488200910;
        Wed, 13 Dec 2023 09:23:20 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id az30-20020a056638419e00b0043a0aa909bfsm2984387jab.159.2023.12.13.09.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:23:20 -0800 (PST)
Date: Wed, 13 Dec 2023 10:23:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: vfio memlock question
Message-ID: <20231213102313.1f3955e1.alex.williamson@redhat.com>
In-Reply-To: <ZXkDn-beoRjcRnjq@kbusch-mbp.dhcp.thefacebook.com>
References: <ZXkDn-beoRjcRnjq@kbusch-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Keith,

On Tue, 12 Dec 2023 17:06:39 -0800
Keith Busch <kbusch@kernel.org> wrote:

> I was examining an issue where a user process utilizing vfio is hitting
> the RLIMIT_MEMLOCK limit during a ioctl(VFIO_IOMMU_MAP_DMA) call. The
> amount of memory, though, should have been well below the memlock limit.
> 
> The test maps the same address range to multiple devices. Each time the
> same address range is mapped to another device, the lock count is
> increasing, creating a multiplier on the memory lock accounting, which
> was unexpected to me.
> 
> Another strange thing, the /proc/PID/status shows VmLck is indeed
> increasing toward the limit, but /proc/PID/smaps shows that nothing has
> been locked.
> 
> The mlock() syscall doesn't doubly account for previously locked ranges
> when asked to lock them again, so I was initially expecting the same
> behavior with vfio since they subscribe to the same limit.
> 
> So a few initial questions:
> 
> Is there a reason vfio is doubly accounting for the locked pages for
> each device they're mapped to?
> 
> Is the discrepency on how much memory is locked depending on which
> source I consult expected?

Locked page accounting is at the vfio container level and those
containers are unaware of other containers owned by the same process,
so unfortunately this is expected.  IOMMUFD resolves this by having
multiple IO address spaces within the same iommufd context.

I don't know the reason smaps is not showing what you expect or if it
should.  Thanks,

Alex


