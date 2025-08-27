Return-Path: <linux-pci+bounces-34899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FEB37D9E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CA71B625B0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6363375BD;
	Wed, 27 Aug 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7hCds+E"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E0335BA7
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282860; cv=none; b=lmClGsn4qEA44Hqd213ziljGRwVJv+mehdwi4tuq5cINjUmF0h4Cn1sVSPd5dWRFVJ1rBUTzCn8W6F+RnWiQCfWi1MHd6cHaYJab53fDFI1MRlC/tNJrwJuQc0k8JKDdtq7Ez/kfVEKymt4bmE914lOtb2CM+EB6Ip3gE3ksg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282860; c=relaxed/simple;
	bh=vmSyMG/TJUeIVMZoaBSvpWu37flRBgwZ0Ph0ifH/CM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAWH+rwbPdsSAcxWOTW1OrZw2+0mrD1bHeAClm4Q1kjglWcfXba1lD3ajlkz4tIXvprBmmdNFt9WA5GzhmMqh2PIPi18GV7+bxlHcF9iLxbcupVuptHsDxpB5e4pRYXdHZR520qUH8fi+I9vG688wQEDc/GG2wpE8zr2yIbggQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7hCds+E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756282857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=itUnoaFqfbQDsJKy5iAP7CimhLmDmHDeVSdAY05Jcqk=;
	b=Y7hCds+EMd1x0Eey2CiYRZhhWDhaN5fpRYLn0Awp+VinadrYfdQCcJ55XUBFkSR4HO/jZt
	36qMpzW3YO/uFh0Au8IoZ8J51TG4A5L6f2jMlwXW3Wt/8Cp0ebsXAuT6zGS1LlyiSFT01p
	R+mnQ4m6YYTZgS1DnDiuOeBJZB64o14=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-M4knZ3C_PiGcKRp96sujKA-1; Wed, 27 Aug 2025 04:20:56 -0400
X-MC-Unique: M4knZ3C_PiGcKRp96sujKA-1
X-Mimecast-MFC-AGG-ID: M4knZ3C_PiGcKRp96sujKA_1756282855
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so6690579b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 01:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282855; x=1756887655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itUnoaFqfbQDsJKy5iAP7CimhLmDmHDeVSdAY05Jcqk=;
        b=qSqyxZqttnRKTDvp72h6WVfqc+7RH9cMDQls2mXAuDBt1aekcsj/vb1UdusZBNE9es
         Ef1nq5cNHuc2OE+U9nzNPq3m5U9GGgNYz22se6nqCxG1b1lZo6npGBvfvk1xBESD6KjE
         nqoPvuokLHTYH+5k+TCYQCT1SB2mtJ3JxXXJi1S2SZvVwJkKGhBq6uZVjh5hcCjYjicF
         AX+5OxX4MxRxQY7cC/XsSRmhiAXF1Iyv6W+RtjnPwab/HK7IqS2xM7/0xuAsJEwG4faf
         fd9VwxyldQlUeEgeVuoYnAuKU+K4FP6YNZsPRVe+9mqYdCf1sQGH2Ra0dGjiDgX4kI4u
         xaYw==
X-Forwarded-Encrypted: i=1; AJvYcCW17V8KrbvVq3gEWS4aaJVCgw2mPwJkBEGJTIJBGSGZ5RS0u3X5jF3mTu3KKKeExpoVDQGOvUKfBH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhdfYrZV4rEkoFz2IA5xSC5955LUZKSH8/2u/YMtKVGFE99vn
	OHMqj9gF18fbhn1yVqAfXEp33D+iXOfjPXubE57+FjgoDhdFhZ6AIjgixxy4fUttdK1OILBP28B
	CvaDvw3ny1p870yJN93Dvs+xA5mj1wRNs+PNY2NB1QDnmKt1m38b+2jgdaQIj6g==
X-Gm-Gg: ASbGncuWomIt/2h8FZMER6PHMBMRPuZUJ3zUHsxdrhTLzAyyGyOUOk7Hf2EePnv0rys
	hsssKsSemhJX5oe39kq1z0evZuXCSAsKk+Jqnzv5nWQg6KohTKF9QZUWy3BakCwukTIIcwVqJNj
	DHrQ2IZQ03cYtf1jfJcCIPKmyVIdcv+JeBVjrbfsbY4++ucv/aii3a+Cob0eq6qJb3BFV+mtgmB
	3hyG8sTnH3hXjgtPBt8SDESr24e2r/lv3to9c1GykAOy0jA9mB1P/1nSJLRc9kugosbokhn+yLK
	Bl7RpiCLyV7dRZIwU9/Zk6WuhdmikPw=
X-Received: by 2002:a05:6a20:3949:b0:240:10d2:add2 with SMTP id adf61e73a8af0-24340d0244amr27008081637.31.1756282855137;
        Wed, 27 Aug 2025 01:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2FJN8dt6Gdj10YjTZnHD4mWZmsq42NC+Hy4iGGo/P8vtVLMd8cGd0cyzQQ5JOahSfz6NXfg==
X-Received: by 2002:a05:6a20:3949:b0:240:10d2:add2 with SMTP id adf61e73a8af0-24340d0244amr27008051637.31.1756282854686;
        Wed, 27 Aug 2025 01:20:54 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7720c63d660sm644421b3a.71.2025.08.27.01.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:20:54 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:17:28 +0800
From: Coiby Xu <coxu@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	jbastian@redhat.com, cmirabil@redhat.com
Subject: Re: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <r3k7yvv3ezpmudnmqphlpx56lvd43gabqcaewucwfzsgcwopml@s7zm2cmeifug>
References: <878qjq80yu.ffs@tglx>
 <86v7mt9ai3.wl-maz@kernel.org>
 <i2l2ujhqjd6akzosvzj4njv2vemsfuvywz4gsnj2nwo3fwyjyz@cfhekxpartf2>
 <86ms84974v.wl-maz@kernel.org>
 <gec2yl5wx6vvt67smx5emhcoifvtp4orw6sub24b2nrqwryhp2@i4h7qbtwjo3r>
 <86ldno8yxa.wl-maz@kernel.org>
 <yweverlt7onyse3rbm7phxzwrwfk4pq2dipzdjenrx4onrak6r@dsm4ra3x3gv6>
 <j4atkwhumotioe2nhu6esrb3yrvwsoz2eyqeopwmr7o6iw65ga@wdkvgahnyhln>
 <87qzx6jrql.wl-maz@kernel.org>
 <p7aa2fcm3g32ydulq3nqrvsg57tyvt5ro5cs3oqrdahxesoroj@tqpulky4drlo>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <p7aa2fcm3g32ydulq3nqrvsg57tyvt5ro5cs3oqrdahxesoroj@tqpulky4drlo>

On Sat, Aug 23, 2025 at 11:00:11AM +0800, Coiby Xu wrote:
>Hi Marc,
>
>If I understand correctly, you want to reproduce the issue by yourself.
>Then finally I manage to reproduce this issue by playing with the setup
>shared by my collogue. Here are the five prerequisites to reproduce the
>bug,

Hi Marc,

It turns out host kernel and host machine are not absolute prerequisites to
reproduce the problem. But they matter because they can make it much
more difficult to reproduce this problem. I also did a bisection against
QEMU to find out which commit make the issue gone. For details, please
check following inline comments.

>
>1. Guest kernel    Newer than commit b5712bf89b4b 
>("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
>
>2. Host kernel
>   Relatively older ones like v6.10.0. Newer ones like v6.12.0 and
>   v6.17.0 don't have this issue.

It turns out with other conditions met, the latest host kernel
(6.17.0-0.rc3) can still reproduce the issue but it's much more
difficult to reproduce it. For example, with RHEL8 kernel
4.18.0-372.9.1.el8.aarch64, I need to trigger kernel crash for 3
times at maximum to reproduce it. But for Fedora rawhide kernel
6.17.0-0.rc3.31.fc43.aarch64, 3/10 times I can't reproduce this issue
after triggering kernel crash for 60 consecutive times. For a
comparison, I've listed the times of triggering kernel crash to reproduce
the issue in 10 trials,

RHEL8:           2  1  1  1  1  1  2  1  3  2
Fedora rawhide: 43 60 47 60 12 56 60 45 49 18

>
>3. QEMU <= v6.2

I did a bisection and it shows the issue is gone with QEMU commit
f39b7d2b96e3e73c01bb678cd096f7baf0b9ab39 ("kvm: Atomic memslot updates")
which is last/3rd patch of patch set "KVM: allow listener to stop all
vcpus before"
https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg02172.html
Note this commit shows in QEMU > 7.2 so QEMU <= v7.2.0 can also
reproduce this issue.

>
>4. Specific host machines    I'm not familiar with the hardware so 
>currently I haven't figured out
>   what hardware factor makes the issue reproducible. I've attached
>   dmidecode outputs of four machines (files inside indmidecode_host folder).
>   Two systems (dmidecode_not_work*) can reproduce this issue and the
>   other two systems (dmidecode_work*) can't despite all have the same
>   product name R152-P31-00, CPU model ARMv8 (M128-30) and SKU
>   01234567890123456789AB. One difference that doesn't seem to found in
>   the dmidecode output is the two machines that can't reproduce the issue
>   have the model name "PnP device PNP0c02" where the problematic
>   machines have "R152-P31-00 (01234567890123456789AB)" according to our
>   internal web pages that show the hardware info.

It turns out all four machines can reproduce the issue. I tried to
reproduce this issue for 10 times and counted the times to trigger
kernel crash and here's a comparison

R152-P31-00:        2  1 1  1  1  1 2 1  3 2 
PnP device PNP0c02: 8  3 5 15 11 18 2 5 12 4 

>
>5. The Guest needs to be bridged to a physical host interface.    
>Bridging the guest to tun interface can't reproduce the issue (for
>   example, the default bridge (virbr0) created by libvirtd uses tun
>   interface)

I tried triggering kernel crash for 100 consecutive times for virbr0 in
one trial but can't reproduce it. So I think bridging the guest to a
physical network interface is still a must.


[...]


-- 
Best regards,
Coiby


