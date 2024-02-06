Return-Path: <linux-pci+bounces-3174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814184BD0E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 19:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E3A1F2507B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC1813AC7;
	Tue,  6 Feb 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCXBvv7Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189DDF59;
	Tue,  6 Feb 2024 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244978; cv=none; b=R+XmB6JyZb7GercumYxW7hJnuw5oCGHFCiYnEpSCLj0tEUg0QDoGNT4MlBmu2dqka90+aAqzlH/IEdWx2WfGkEn+cE4T4ZUpikuDgdbE5rZ8m41eJ5DOavf+t0dZMjeLUqs6E374YPvj88rQvvlMWNIC+pxnm6Roph91tJMouvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244978; c=relaxed/simple;
	bh=2zNd/00J8nJ45V0bvSTkrCoVNw1xN/0ldoVU9aufm6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i1lgQNwtJkTbAwomYK9OTrMDTarDJsh9rMdpGQM1QDdh+bXN9KLMwtVtEWSJfnezaXIziFxcea8B1coCzoHVme5cXJMYE6Nf0XkL8udxHsg2uACkhESg+ByRfoeT4mZncs/24aOFC4ATtc0d9iNTkiZXBqur0Mw+pfd8FazC4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCXBvv7Y; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b4b0a3bddso352018f8f.2;
        Tue, 06 Feb 2024 10:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707244975; x=1707849775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcYd3aRpfgCUSG1LIYQnSsuSSC3YGgnUABVKV+senFA=;
        b=lCXBvv7Y3TtXrXZtOV7TOpORY6tM26/2ffLnLkB8+Folz6DZ64HRfIZ6J2la0vrfFI
         KQvCNZ2LMblfWWS38qAO3VAhOq+WaCLCaEU/v4lv8MrPgnIj59IgATcA+3Kt+KXIsUWf
         A+ZhAyFziCOMsQ0s8lH5L5zVjyI9AVxOeaUOUexks7cOlzUkR0YiswGYduUoca5og2DI
         ORRFIDtN4ahXiafsw2kmdWBHY78BZCEMM55c50/+wuHbE9z3d4o6NtnKlZQrWLFH/0h4
         g+D0Mz9ocvMzc/MT9/RDRnt7WxKkicUkJP7f5GOrj51or8Aymx2iC2wwLmB/937PFiAK
         0yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244975; x=1707849775;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcYd3aRpfgCUSG1LIYQnSsuSSC3YGgnUABVKV+senFA=;
        b=T4kRjfyeCZalZrorbuZE4MlpVo91lhNhxph5bJtXX6XVkrQpoV5vk8UlGQX8OeFCyS
         ruVn3Jyo/t+vpFS9fFuYkExLBIZ6oGnWd8nAea4cqgNMucdUdoxm16KNtMRQLY1qCHlB
         eribRTNBZMhr+YmQvuWdgvdDKn7opMHCvt6L610AZ/aPLBKaCXn1mcOr8Yhcp2llDg+R
         fMXp+5qXCyUUnQ/XVSCN9z0TH4yWjYjkJsiGeXrl2DNXUxXUCJEuz1wKR11J/vt6IDL7
         XpLzvA1j0Rl9HTJLP8xsdcFx/R3uJCUKZb8N9HSNuUYUBQmJRwZYdmtyww6Y0ukyMehL
         lorA==
X-Gm-Message-State: AOJu0YxaXm1bPVXmlwE0/jGlGYHbbrfWul8lzjaT28MqxdyCvRvS8FV1
	HGfW0PdQUe8nJn3amDQODWwIz1B4KgW55T2inAJeq9tQX7/XYVav
X-Google-Smtp-Source: AGHT+IFtMiHNSHvx8KI/0xWb8L1QJIfX69P8hOKwZtnEAwxcw9gDu8J/XoZUlF6EE2Dq1ZZ0UKJL+A==
X-Received: by 2002:adf:e9c2:0:b0:33b:1494:e4cd with SMTP id l2-20020adfe9c2000000b0033b1494e4cdmr1923628wrn.3.1707244974770;
        Tue, 06 Feb 2024 10:42:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXF70vsTfTExShWiaK8oLQuWyCr/fKtj89R5eL2A4ujeldZ9kz/oaFGgySfBaS4vKgSg0p4m3+Rh8Q8Z7doJWNT8KpGs1T5B+6GQt6YXezuphuC++2lmKZaqhzB6cPzvPtwvYV5J+XAzWUVqIWwwHJ9ZHxNETOK8qobyvt4z8TAJis0/NIH9Nw9qOZc2Wao0ceTTDtrIyWcAXu5TRlo8lIyL4Pb/LoQEydAvMwVFHFopActFvRy79coIjeh/wWFnq9HyLVe+yUyby9zZ8GIq8hZ/9UsswTLzMmYl3LMcwbgNodGAyRteb85nXvXMaGpTS+Ok2N6J6Xg/eAuF2GpLekpMbmzMZkPu8kn39Xaps6IugWFjStek33DfPpW72MWhRROMSnbAAeXRvkQ4pwBsHC/cz6VzI96EppEhaJif+If/85PT2i/V8z9tyvi0HFNUYNMix8ZSeY47cyaY3vKiaKgnvqElbmJtvrjsVdStTa0MWdyj05RfklUJtuVW4eTE9rLb0MvIHvx11lx91LKScadS8PSgraft4mIeESMXrT358eE2uGGgwKyIkPUlspHSARdsWYvN3ns7metDHICypAKroZsbRmMwN97zokrjn6sBEVkNn/bWAd1dbKZN2eDGxV+BPmHyOyJ5SZnTf65q6TuKWUGICMno0HhksgDckTH0d4qbR/DeO667ldbpPCWugFKbMf+rR/7dR57ItMbhBqPTF2Eb+omDk+KE5/A3UfBxbE0dSjOckRYgKEsHrvWY2xvCq+6OOfChfk+GGc=
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d514f000000b0033afe6968bfsm2704594wrt.64.2024.02.06.10.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 10:42:54 -0800 (PST)
Message-ID: <051a3088-048e-4613-9f22-8ea17f1b9736@gmail.com>
Date: Tue, 6 Feb 2024 19:42:49 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: wire up the can_remove() callback
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Le Ma <le.ma@amd.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 James Zhu <James.Zhu@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Shi <alexs@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
References: <20240202222603.141240-1-hamza.mahfooz@amd.com>
 <20240202222603.141240-3-hamza.mahfooz@amd.com>
 <2024020225-faceless-even-e3f8@gregkh> <ZcJCLkNoV-pVU8oy@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ZcJCLkNoV-pVU8oy@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.02.24 um 15:29 schrieb Daniel Vetter:
> On Fri, Feb 02, 2024 at 03:40:03PM -0800, Greg Kroah-Hartman wrote:
>> On Fri, Feb 02, 2024 at 05:25:56PM -0500, Hamza Mahfooz wrote:
>>> Removing an amdgpu device that still has user space references allocated
>>> to it causes undefined behaviour.
>> Then fix that please.  There should not be anything special about your
>> hardware that all of the tens of thousands of other devices can't handle
>> today.
>>
>> What happens when I yank your device out of a system with a pci hotplug
>> bus?  You can't prevent that either, so this should not be any different
>> at all.
>>
>> sorry, but please, just fix your driver.
> fwiw Christian König from amd already rejected this too, I have no idea
> why this was submitted

Well that was my fault.

I commented on an internal bug tracker that when sysfs bind/undbind is a 
different code path from PCI remove/re-scan we could try to reject it.

Turned out it isn't a different code path.

>   since the very elaborate plan I developed with a
> bunch of amd folks was to fix the various lifetime lolz we still have in
> drm. We unfortunately export the world of internal objects to userspace as
> uabi objects with dma_buf, dma_fence and everything else, but it's all
> fixable and we have the plan even documented:
>
> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#device-hot-unplug
>
> So yeah anything that isn't that plan of record is very much no-go for drm
> drivers. Unless we change that plan of course, but that needs a
> documentation patch first and a big discussion.
>
> Aside from an absolute massive pile of kernel-internal refcounting bugs
> the really big one we agreed on after a lot of discussion is that SIGBUS
> on dma-buf mmaps is no-go for drm drivers, because it would break way too
> much userspace in ways which are simply not fixable (since sig handlers
> are shared in a process, which means the gl/vk driver cannot use it).
>
> Otherwise it's bog standard "fix the kernel bugs" work, just a lot of it.

Ignoring a few memory leaks because of messed up refcounting we actually 
got that working quite nicely.

At least hot unplug / hot add seems to be working rather reliable in our 
internal testing.

So it can't be that messed up.

Regards,
Christian.

>
> Cheers, Sima


