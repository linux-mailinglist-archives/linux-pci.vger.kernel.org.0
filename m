Return-Path: <linux-pci+bounces-35477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E87B4474A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 22:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F30D3B8D65
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B11627FD64;
	Thu,  4 Sep 2025 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZY+FDx1"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880CA27FD4A
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017667; cv=none; b=S2Ng6oXkpUTlHYBlv9pwgCvxZxBF+uQ6rMyiICgAbJuMga36HTKJiPcVVSqHv67X4Ig4xhhyfsxsTMOpEAabOLyRuE8cwDS3HZN6mcVYSil6B9FpWdXVHO1h7KJzg4ce7NPOwUUP4Ny3o3qoYb3XiKlEgway1+5HmCldetCK4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017667; c=relaxed/simple;
	bh=n/pY7Ssm0YwUXAN73X5e1njk6VYADTAa6tdLoz+QgAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FtCQEqnz+wUMhRpGMnvufvcQaGJfkS25kj9JU+3Nulouy6A58m5tWwabbwOB2RxVkEgeamo61Ty8+hNi1Gjw8hWisblpAtJ11FnRR3mxXQyxW3+vQKrbkwnu7R9oiwFMMc48ISLNe5jM32m5wJX39WhoCyHM+lJSZTw5wAmqN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZY+FDx1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757017664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZ1ZQZXiD/ZO6OVnKe6uaA+6mzR9P3Qvw3jlDLaXgXU=;
	b=FZY+FDx1/RXivI7mivFX/SYExJhC9SHywLuqUwuhB40yB/JcJperQhsWaFSLtjDSOCxf79
	9c1MvZK9U5kdiIv/toBTbyeIZElwjpV0+7cZuHGmTNuxC/w0LvXyq0alJOYjpqGjQ4+uVO
	kG3UgZQjmS1J/KxXFGhS8fGa+ZLr/38=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-gZUxN-o0OwGYWa3ujn1kkQ-1; Thu, 04 Sep 2025 16:27:43 -0400
X-MC-Unique: gZUxN-o0OwGYWa3ujn1kkQ-1
X-Mimecast-MFC-AGG-ID: gZUxN-o0OwGYWa3ujn1kkQ_1757017663
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-72108a28f05so37963626d6.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2025 13:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017663; x=1757622463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZ1ZQZXiD/ZO6OVnKe6uaA+6mzR9P3Qvw3jlDLaXgXU=;
        b=QekT2mQyWsU0YOTC5A61G8q2zo2dIgjGtHqY/zZyIAoUl3hnhfvFNG9ba0DHfOYeKC
         BW70/YzzZsgg6PQc3L5k/sw+OK8Aa+4PvMH4M6++qwbmTlwPtNL4GXSkIcmjT5mp5Oli
         wZKNZwb8zzZVtHrXlexIcKdJqz7PK3VgvdVcOBiZgx7v5qpoWAvmdmZBYBw/GI9jnt5w
         ko6P3pvEoViqU6GulV3wFVPp3AEA7/2bGrPtlYdYKcOT2x2lzWQ/Y4DA5XQbqTKz5/Fq
         d9b47Y+BBBvM3v1BEUClkbH1YaSTQWIlFZILJFIZjiymXHRmJ8z6UIHxEKFtMP4qvHG3
         jW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUckVKDM1X11DJpTxWnDA2S02+D041Jz328bh634KK57cjVKRzUfx5hUijqdTzr6UC1n0tP3nkUXck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Z/fWqZK43yGcM48jZvNjE24+EubVqCGfSlctv9v4yKwsucRG
	PslXUGs7oeJPqdmPgRPacFsqja9jBRNzIXqaftI2kM0VgiD/TRpO0owj8DeEo+6mWsAijikvyCg
	kUjSgE6cRhpnYqsXFa9KrC8UrsNxMBFOImZm6SiuhiRhPwZDz8NGnvF0G22e4cg==
X-Gm-Gg: ASbGnct2kj4k55kghR9QlazvqzlGIxfPM4gI2HhIdeWe/Z+KUpqL0FHZFhSS9YTtWoO
	oQnfmgBSrfvMcO2Mn4H8kbjWGB1hn/8lkzBspAuCbrndgxpl61CBsPc1BuEmw0eisIhVC1EWRKy
	t31Wk/0/ccm3/prK8lH2EJXZGKPbbxLDQUigYJBRGcPk0FFL2Kzat+si3ZExq+aXyxs6HAll0LD
	+FMtZ/vYqVYBtnZso2BktREB8+bp8XwNXJQ8xk8oNBpGY318iiKyOg47K4HXcXXlzpYDUryKLSH
	XvWXYZHq+W9cVehvSTJbqSsszQcYDcf3SXziarxWgNRher7JM0sTjNpcFJ8Q2JtZjKn4VFw=
X-Received: by 2002:ad4:5aad:0:b0:726:1de2:2806 with SMTP id 6a1803df08f44-7261de22ebfmr85045846d6.60.1757017662757;
        Thu, 04 Sep 2025 13:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SPpqxVrAbA38PLE0lpRBaYsie8jxvbY2zZCX+I3O32JAnLmwjhFOblpyGk+BfBfntAn/UA==
X-Received: by 2002:ad4:5aad:0:b0:726:1de2:2806 with SMTP id 6a1803df08f44-7261de22ebfmr85045526d6.60.1757017662137;
        Thu, 04 Sep 2025 13:27:42 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cbc78sm52569886d6.23.2025.09.04.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:27:41 -0700 (PDT)
Message-ID: <bb2b9df1b13fccb7829c5d73a0bddbd0083d105a.camel@redhat.com>
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
From: Crystal Wood <crwood@redhat.com>
To: Lukas Wunner <lukas@wunner.de>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar	
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Clark
 Williams	 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Attila Fazekas	 <afazekas@redhat.com>, linux-pci@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Thu, 04 Sep 2025 15:27:40 -0500
In-Reply-To: <aLmKlVaKSBurRys1@wunner.de>
References: <20250902224441.368483-1-crwood@redhat.com>
	 <20250904073024.YsLeZqK_@linutronix.de> <aLmKlVaKSBurRys1@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-04 at 14:48 +0200, Lukas Wunner wrote:
> On Thu, Sep 04, 2025 at 09:30:24AM +0200, Sebastian Andrzej Siewior wrote=
:
> > On 2025-09-02 17:44:41 [-0500], Crystal Wood wrote:
> > > On PREEMPT_RT, currently both aer_irq and aer_isr run in separate thr=
eads,
> > > at the same FIFO priority.  This can lead to the aer_isr thread starv=
ing
> > > the aer_irq thread, particularly if multi_error_valid causes a scan o=
f
> > > all devices, and multiple errors are raised during the scan.
> > >=20
> > > On !PREEMPT_RT, or if aer_irq runs at a higher priority than aer_isr,=
 these
> > > errors can be queued as single-error events as they happen.  But if a=
er_irq
> > > can't run until aer_isr finishes, by that time the multi event bit wi=
ll be
> > > set again, causing a new scan and an infinite loop.
> >=20
> > So if aer_irq is too slow we get new "work" pilled up? Is it because
> > there is a timing constrains how long until the error needs to be
> > acknowledged?

The error needs to be cleared before the next error happens, or else
the hardware will set the "Multiple ERR_COR Received" bit.  If that bit
is set, then aer_isr can't rely on the error source ID register, so it
scans through all devices looking for errors -- and for some reason, on
this system, accessing the error registers (or any config space above
0x400, even though there are capabilities located there) generates an
Unsupported Request Error (but returns valid data).

Since this happens more than once, without aer_irq preempting, it
causes another multi error and we get stuck in a loop.

> Since v6.16, AER supports rate limiting.  It's unclear which
> kernel version Crystal is using, but if it's older than v6.16,
> it may be worth retrying with a newer release to see if that
> solves the problem.

The problem shows in top-of-tree.  The messages are ratelimited, but
the problem isn't from the messages.  It still does the scan.

> > Another way would be to let the secondary handler run at a slightly low=
er
> > priority than the primary handler. In this case making the primary
> > non-threaded should not cause any harm.
>=20
> Why isn't the secondary handler always assigned a lower priority
> by default?  I think a lot of drivers are built on the assumption
> that the primary handler is scheduled sooner than the secondary
> handler.

That also works, and I agree it's more intuitive.

> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
> > >  	set_service_data(dev, rpc);
> > > =20
> > >  	status =3D devm_request_threaded_irq(device, dev->irq, aer_irq, aer=
_isr,
> > > -					   IRQF_SHARED, "aerdrv", dev);
> > > +					   IRQF_NO_THREAD | IRQF_SHARED,
> > > +					   "aerdrv", dev);
> >=20
> > I'm not sure if this works with IRQF_SHARED. Your primary handler is
> > IRQF_SHARED + IRQF_NO_THREAD and another shared handler which is
> > forced-threaded will have IRQF_SHARED + IRQF_ONESHOT.=20
> > If the core does not complain, all good. Worst case might be the shared
> > ONESHOT lets your primary handler starve. It would be nice if you could
> > check if you have shared handler here (I have no aer I three boxes I
> > checked).
>=20
> Yes, interrupt sharing can happen if the Root Port uses legacy INTx
> interrupts.  In that case other port services such as hotplug,
> bandwidth control, PME or DPC may use the same interrupt.

It's shared, but with another explicitly threaded interrupt.
This is with the patch applied:
root         778  0.0  0.0      0     0 ?        S    Sep02   0:00 [irq/87-=
aerdrv]
root         779  0.0  0.0      0     0 ?        S    Sep02   0:00 [irq/87-=
pciehp]
root         780  0.0  0.0      0     0 ?        S    Sep02   0:00 [irq/87-=
s-pciehp]

If it were shared with a oneshot irq (forced or otherwise) wouldn't
that have already been a mismatch?

-Crystal


