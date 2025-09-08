Return-Path: <linux-pci+bounces-35672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36069B49245
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 17:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788E37A1640
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31039228C9D;
	Mon,  8 Sep 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL/qYTYC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23412B73
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343737; cv=none; b=nfHqAghJTDyMdUX7e1cflSpZDet9nfh2wdTsXhgO9L9i5h0Xv380pknEDK5k40nL9WEjpNwNzItH6ZnsI3ActzECfEKtS//d2jhKuLKYFSzs3eB76MDUQARR8pwNdoHOB1dta6qvRROMDX58c38GrzptPamFWhceTDz3FARgGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343737; c=relaxed/simple;
	bh=NrN2puWX1Om2SrnX1fDXW1TXXcNPXJMRmgjE1JAHh6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twYLUf4EjOonyaMLxFfsvnig7vKjpEYY+4c3LMsvSFxHD8tihGcnawIJlb6F+sTJ0rJ9QRwREFx6T0woWmdVjny61sey3MEWkHWlliLVNgKn4q5tlUnhqIAdgCryk4zerBrQklGKoF2WVMu8an1aQJ6v1lt8VwQlf1bfGlRClcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL/qYTYC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757343734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEWLL5Vbb9k+xSLe/HZhU14b92+dTntX/09oDM7LBgo=;
	b=OL/qYTYCeUPUu/ZgT52ZoWlQFTbdnbJfEDNxVqgZvVnJIcsrQHrnp2Fnkk58eIuoPlZUea
	MGBLVOyMYTjBuLw+EfoMuQaoXACp42HggkwrVxrzU2CHLG5H9wT+lQ2gnvaotKkBg1vDyQ
	n8Bw4sdKX5MB0gEV5Se0R/x/+wkbYVk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-65kc8oJoMXi7OsTGtNm3BQ-1; Mon, 08 Sep 2025 11:02:13 -0400
X-MC-Unique: 65kc8oJoMXi7OsTGtNm3BQ-1
X-Mimecast-MFC-AGG-ID: 65kc8oJoMXi7OsTGtNm3BQ_1757343733
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b6090aeaacso39230391cf.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Sep 2025 08:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343733; x=1757948533;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEWLL5Vbb9k+xSLe/HZhU14b92+dTntX/09oDM7LBgo=;
        b=PsStqRxJoyORkjK94yKa03CODgrHOj+iCSWRng/SXy6hJIqvIJDjvYAksp1HOMNavS
         1Ku7L79CzRT4URKoee5PlzgYjF7Odor2NPy6KsdtFSKCvuJkfNzJTtjCAhA2Jqyuc6cS
         R8rtFo2AZW06qULBPx/VWWDR85MfN2YIVdoPQUdAWIIPgsuf2KjSDFBhVlwsWAOtt4q0
         cLUb6F2vY2L3o0vmcQiz7bvSh5YhIBCU+p5+zP6bZIpxx8oBCeA4+CbBnfElmAG6pkOP
         u+qVNa9I2LtUVdf2TuNU9zHscM7L+tZAJzYihdA8aHHzgt62cWRI+gjWlmqUzRRktpp0
         f76Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDu6XdXEH6Ml47/5BzJA2feRLqYCtuyI3GDIqjbI3K612s5qkmDS7N06gKQemwsAPgnAIi6vkFCks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdSnQxGbfmj8nhRz3+DO9B/ZaUnOCLCmCSLo4ComyFIE+lXeP
	WjNP2SP9071sZCSR4IrOCM4YrntKUk/hwsdsAYVg3J9d0ifyS9kkGwAx9WGKhr8mzuRA+IYXip2
	/VOEB7Boy911kQL/wuQuRPSLzFMqNUfo1TvgNx5n1tyOlmGxWYtyHkZcqsfVf2Q==
X-Gm-Gg: ASbGncst1X4IjA9vbG1BeF+bsUEc0T7aMs7+M4ekZU2K4j7S3RTa7sEumJlQPNSGDhX
	WZSgUrY9G6M0IBwUn0bBefSRh9hYEAb0Zq89EhMSDkVDZCvA3gWtG1XXtxvlyDiea16pIEWQdob
	aE6P0g2tUNYxGyth6dePmsNtVWl/wQQPL8aiBT1fL/ocGRfTpwsMPs+rtqqEAmsTUYvajN3COZj
	Rhqc5QbNuyL3gSMtOulgNalDKkoctPMQe/mdYVDdOIUFZcW8/vnNkPkq/JeKwNlRnYFP/L4xmxH
	CCPRfQJ977mF8kwY6m4fxn/xBT2REQRS/KOCSvo2Fpz3f7Nq6ljld6/wUys71UtbEgAwgCQ=
X-Received: by 2002:a05:622a:38c:b0:4b3:5081:24c8 with SMTP id d75a77b69052e-4b5f846a36emr96660061cf.56.1757343732581;
        Mon, 08 Sep 2025 08:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1uHxMn1TVqLXTn1Op3nB3byCrcQAFulbDefZ4JeRt6YV1a9xoXVRpsi2KDcyzNZDOkKnjOQ==
X-Received: by 2002:a05:622a:38c:b0:4b3:5081:24c8 with SMTP id d75a77b69052e-4b5f846a36emr96658701cf.56.1757343731307;
        Mon, 08 Sep 2025 08:02:11 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f652814sm104251941cf.12.2025.09.08.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:02:10 -0700 (PDT)
Message-ID: <ad1f8cbe29e27dc70db136af5888774ab0b46288.camel@redhat.com>
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
From: Crystal Wood <crwood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lukas Wunner
	 <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar	
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Clark
 Williams	 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Attila Fazekas	 <afazekas@redhat.com>, linux-pci@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Mon, 08 Sep 2025 10:02:09 -0500
In-Reply-To: <20250908075225.sDW_dYzG@linutronix.de>
References: <20250902224441.368483-1-crwood@redhat.com>
	 <20250904073024.YsLeZqK_@linutronix.de> <aLmKlVaKSBurRys1@wunner.de>
	 <bb2b9df1b13fccb7829c5d73a0bddbd0083d105a.camel@redhat.com>
	 <aL55cDBjsNk2xK10@wunner.de> <20250908075225.sDW_dYzG@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 09:52 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-08 08:36:32 [+0200], Lukas Wunner wrote:
> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -847,6 +847,15 @@ void sched_set_fifo(struct task_struct *p)
> >  EXPORT_SYMBOL_GPL(sched_set_fifo);
> > =20
> >  /*
> > + * Secondary IRQ handler has slightly lower priority than primary IRQ =
handler.
>=20
>   For tasks that should be sched_set_fifo() but require not to preempt
>   another sched_set_fifo() task.

SCHED_FIFO already means that tasks of the same priority won't preempt
each other.  I'd word it as:

For tasks that must be preemptible by a sched_set_fifo() task, such as
to simulate the behavior of a non-PREEMPT_RT system where the
sched_set_fifo() task is a hard interrupt.


-Crystal


