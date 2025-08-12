Return-Path: <linux-pci+bounces-33854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30223B22453
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 12:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA663AB6CA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336382E973F;
	Tue, 12 Aug 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTLWF1/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07A3596B
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993456; cv=none; b=PB6g/cU+2ToN7V1tdKlm0hvoiwDHHHmDY9G7ZmOim3wDinOQn4NSNRWnCaC9ZIsLQ5FWSrKMMMWAwf+WNy12lRTpki6z0zZS3PHU/+dM2M36ny/uqHwfSnP2wwA7YTIlzwmE+UXoZg7E+p/PnJGLQDE4+B8LxgWz9XVjUDHfj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993456; c=relaxed/simple;
	bh=FZTb8zklJooj5PxjRoR6o57GyL01JBwJnmODzTBr1TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sILuF69ljCzMykR2GvGZ7ygWIA3vpNrc4cx2mSugNRSs29j51gJcQuqdr0yBFIpYOg6VriKK8tuEbMVHWu1tcYX+9XfI4sNaX9eXOe60EgzI6pMwrj1yD3kcP+r9ni6HwilMEhIDFNEipVii+a2cmIRbniDzVJHN5Vi76v/QXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTLWF1/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754993453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNSs6KOwqyOQOFmsrg8IFO4ZjDR6oQrd/gvk1o5f7v4=;
	b=UTLWF1/mSA4/r3i2L+WzO6FcpHxBbn+przBd6pJluGDkEK0orEtIbz5yBaqikIyAyPqsuw
	QnSjMCHMEnect0L2HkSZcTuNE6kySKyEG5+8QT9jyz+IHp0ibYTJ8ZdJiRVsDfsdBS9jFO
	EqpujGikeOdtG8wV5o2M62/cVW5g7gQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-dx5MH1sQOdqboKlwnI-cMg-1; Tue, 12 Aug 2025 06:10:52 -0400
X-MC-Unique: dx5MH1sQOdqboKlwnI-cMg-1
X-Mimecast-MFC-AGG-ID: dx5MH1sQOdqboKlwnI-cMg_1754993451
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76bf8e79828so10230037b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 03:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993451; x=1755598251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNSs6KOwqyOQOFmsrg8IFO4ZjDR6oQrd/gvk1o5f7v4=;
        b=j14f0N1UziHbsddCIAVr7FsVXcmU8o+1ofBb/OBBiteyXm5BMQzrZFKBlgZiTjtjPY
         YW3nKVGhvbrKBTf3K5WM9gY8an+adAGULnymNxTxwjDRq2LtUKRLVC8PE/jlTLXhFcAz
         g7d+qLnZNmNdOkA4gYguqQjPvMUG8qjV69xw/aCFSCfY4A2SbjVd3TvoIbuOne33pUJB
         VROVFqx2txfrdpKn4LR+tqEZSrg+9HOVBTt4AEudjHeJZUtfV37q2yzAZae1ezgekjDO
         Fzj2sm1IGjc0FR2ZG4WlHGS/LqWZ/AQ2cft2mzXQLF2zPNeb/zFgzbWPkC8iylYklSc5
         lJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjQptZ8ShO1C7iEPJNGKv7rfj/pNX/3mhdYzkRtGNYyQ6+HO3XZIoHmEaporU5RiDY+5yLRhir/cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0z7Qc+Peuxlv5DZzo1GX4OUrb3XkxUnZnBvQyTzgDbbpttdS
	QKBV1lgga1Pvx0ze6tAf4stjbOTm9wDUiuQvSKw0nC3hg7/wZ+MLbkBRpW9+eGearR68Nr/ol8m
	9vQSnKHA6oZDGtqN4pHFRw+N1CNvE6d/dAdUYydw5p7ryr2EhqT//Fi0DFt/Amg==
X-Gm-Gg: ASbGncvXyvfSXtBvlL5PZ6B9LDhhwfYeUjaHoybEZHKvJXAWbvHL5DQkcCQPrGGQ4IF
	6PtqesoTFyD+EyI2ugIqh+P9h1y+vC0405U6YfRexH7CWBY7hxBpRE4sIGQUKPYeEw2zscjrwdl
	JqOWrE6WzLoRVG0uKefRzLREHyxul0bnaswhIWXoCeFjcU0esO+4SBDdgjvZBOgarko06ESFBvf
	gi4Uq+xJFtYU0qQEwQZbmdeLOwoaWBpthKdHHiSEq7migpIisRHi2VCDLiDOUdkz4YUkcY4plv2
	bQ7xAm/E313ONTIzsmazCF/sXO564tM=
X-Received: by 2002:a05:6a00:460e:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-76c4615b6a0mr21473771b3a.12.1754993451053;
        Tue, 12 Aug 2025 03:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLAmaQr1HIbt/+T8A3Xj7cx8a6v2gYbnrKNkZvVwyFoSL03wtB+5VA+cs4MTHadDVFeK0cFA==
X-Received: by 2002:a05:6a00:460e:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-76c4615b6a0mr21473742b3a.12.1754993450666;
        Tue, 12 Aug 2025 03:10:50 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm26811520b3a.6.2025.08.12.03.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:10:50 -0700 (PDT)
Date: Tue, 12 Aug 2025 18:09:12 +0800
From: Coiby Xu <coxu@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <i2l2ujhqjd6akzosvzj4njv2vemsfuvywz4gsnj2nwo3fwyjyz@cfhekxpartf2>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
 <87bjom8106.ffs@tglx>
 <878qjq80yu.ffs@tglx>
 <86v7mt9ai3.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86v7mt9ai3.wl-maz@kernel.org>

On Mon, Aug 11, 2025 at 03:52:04PM +0100, Marc Zyngier wrote:
>On Mon, 11 Aug 2025 14:03:21 +0100,
>Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Mon, Aug 11 2025 at 15:02, Thomas Gleixner wrote:
>>
>> CC+ Marc
>>
>> > On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
>> >> Recently I met an issue that on certain virtual machines, the kdump
>> >> kernel fails to get DHCP IP address most of times starting from
>> >> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
>> >> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>> >>
>> >>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>> >>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>> >>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>> >>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>> >>      # Provide MSI parent infrastructure
>> >>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>> >>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>> >>      # Prepare for PCI MSI/MSIX
>> >>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>> >>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>> >>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
>> >
>> > There were follow up fixes on this, so isolating this one is not really
>> > conclusive.
>> >
>> > Is the problem still there on v6.16 and v6.17-rc1?
>
>Yeah, there are way too many things that have been addressed since.
>kdump is also a particularly nasty case, as it tends to rely on the
>redistributor tables programmed by the previous kernel.

Thanks for providing a clue. This may also explain explain why I fails
to reproduce this issue against 1st kernel even with the same cmdline of
the kdump kernel.

>
>Also, this says "virtual machines". What's the hypervisor? 

I'll contact the lab administrator. What kinds of info I should collect
to help you narrow down the issue?

> How hard is it to reproduce?

It can be reproduced reliably on certain machines. But as of writing I
haven't reproduced it on other KVM virtual machines on three different
host machines.

>
>Thanks,
>
>	M.
>
>-- 
>Without deviation from the norm, progress is not possible.
>

-- 
Best regards,
Coiby


