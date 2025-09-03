Return-Path: <linux-pci+bounces-35407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B88B42C09
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 23:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A5C1BC802B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569F2E92D9;
	Wed,  3 Sep 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQEMBa1j"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFC287518
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935553; cv=none; b=mlQC+K42Lf8caoDJSr5JoIcscbCH+T2Ox0ZPSyocaK9mjC5yoBe7b9jjONd8vUGBLMlDl+8XZU7tu+79fpNE64RJYdpoc29kaNkucxUfySVcTd0+HBhCDfukJGcarKHv39sOw/wnC4J9x9jpEYaMy/8xZ68gR3+yw3yUO7hFKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935553; c=relaxed/simple;
	bh=og1lhoElF6db9WxHKkfi+3t1iLGA0iXjfHdS+QkB0Z8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YiHc+vv4F58qe0I/xvyMCkNVg2Yp4/Q42v6ncElcpQPLpmpsBYZ45GBuh+dXWQoAbT0FhjaScxhKuZXdmGjDYzeW05PuBZ/u1QF7NW8XAsUuqNN2de2G+NSP1gYmUFkUFwC+A1BncgoZ867+TWTy6jy7iBVmTn/t3BAu4rhbg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQEMBa1j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756935550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF/pjT3YTUMVt1BEngnlRmga+KCNH7T6bly4syRc1NE=;
	b=BQEMBa1jyKab9t+o8SCIbDoozEk8LK+sYuKDUYkKnO7CDTI3l/aIwT5HgFDqST4/kYOODh
	MLc+FKnUlB7Wavk6JI3xkNjCwwOJb9INRb2ANwumnD8Jv945sF5ktF8wRP74M5Mr4oIxxK
	RO3eUhvxTt5i0rLr5xg3YwnlON8mNwA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-u0ylZbUEMeSKGHVjjvi5OA-1; Wed, 03 Sep 2025 17:39:09 -0400
X-MC-Unique: u0ylZbUEMeSKGHVjjvi5OA-1
X-Mimecast-MFC-AGG-ID: u0ylZbUEMeSKGHVjjvi5OA_1756935549
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b32d323297so7205851cf.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2025 14:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756935549; x=1757540349;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tF/pjT3YTUMVt1BEngnlRmga+KCNH7T6bly4syRc1NE=;
        b=Q0GL4iqyTxbxEfttT4F2tlgmQeka3MNnpklwPovuyIDAY5cqQUqn0TacBlMwhn2/kE
         7Akavu60OONih5LK2EqNMMLQS4egsKyRVW8PkDBxvhlVF5IeYAWrDkSIAvDCV43n22i4
         f4uoxVraLlD9OmzRYFoCejlklez/qwwXO3N3/H/HKT3tyi7SwTlrWxiSQppVFtpWp+TE
         7vpWbHLmGELX0RWl+tYUyxdfIpliD93bOHxyTOL/Ks79wRfJ1wD18j0UBQgwK/5EA+jg
         l7Sg3tIVTA+hmmZBjy3ihAet8W8+UjbUZKCYjo/4oCcAqw2/6awjubt2ZY4RZtrJbHR+
         ZZ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWi+lHmOsHErIZ3Yftp+r4ErgLLligIYtGUTBh4KnWzmDk4q0iYRfnIhrJBgjT2LuToy663sQLp13w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx102QdLMbhseccx62wZCGvubF+HcTFYcOlkoGzYdm0FKF5604C
	mRgSuN/6OuIN2rdFS87mVQMNCTMcsZOIq8NvLgAPWN/GrO4AsjxS836DfXI7SQpEIniCJQBOYWy
	RPZ59Me0nEFF84Ok2vK4M8sDLYB9KGK9pgO56PFclHn2vizlTguDIZeyuLvClng==
X-Gm-Gg: ASbGncsYlz92Ijg91SnbuRbnHmyAabprCxOq9kV4vcRhVrXubl/G8Po/Ozauc/L6l1B
	TXrrHrlQrZpNXoExBCqKHA4aQWfAFq7wbPSTVNgCZLP6vjVatCxaA91fZXXffEst8rT1oW3L8BX
	dTvU7Cqt1KgPpRt2OFQqvtjLZ+PygjF2Q+pnhUXaAsfRyYFiq6e7N0XQBOutby/9rmeYLtm2UGt
	S9sj/8c5s2hnrJsDPPvXsqJUtHHOdU9pk1NShf6Cm0My/9khSnUH4XB0TyB17ZP0AFz9d8qZG5C
	FsUdG1jMas6r22bvc2ju3tV38I9JLXZDaBJpNNj481TzE5b9ZN9Z7+8aq/DPpknf53oRCFw=
X-Received: by 2002:ac8:5a47:0:b0:4b3:1697:4e53 with SMTP id d75a77b69052e-4b31dc68174mr218431461cf.66.1756935549113;
        Wed, 03 Sep 2025 14:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMFz3QEIBlrasaJqBAuiIO+woAELo43+OkB+gQBfqAVDSldF8huM9fr9dqA3cdog7xNrl/xQ==
X-Received: by 2002:ac8:5a47:0:b0:4b3:1697:4e53 with SMTP id d75a77b69052e-4b31dc68174mr218431201cf.66.1756935548703;
        Wed, 03 Sep 2025 14:39:08 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673fecsm17501531cf.21.2025.09.03.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:39:08 -0700 (PDT)
Message-ID: <72c259c60ce28d3e815d7f243e472661932ef2ad.camel@redhat.com>
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
From: Crystal Wood <crwood@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar	
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,  Attila
 Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Date: Wed, 03 Sep 2025 16:39:07 -0500
In-Reply-To: <aLf34pnRmk4ip7KS@wunner.de>
References: <20250902224441.368483-1-crwood@redhat.com>
	 <aLf34pnRmk4ip7KS@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-03 at 10:10 +0200, Lukas Wunner wrote:
> On Tue, Sep 02, 2025 at 05:44:41PM -0500, Crystal Wood wrote:
> > On PREEMPT_RT, currently both aer_irq and aer_isr run in separate threa=
ds,
>=20
> My understanding is that if request_threaded_irq() is passed both a
> non-NULL handler and a non-NULL thread_fn, the former runs in hardirq
> context and the latter in kthread context.  Even on PREEMPT_RT.
>=20
> So how can aer_irq() and aer_isr() ever both run in kthread context?
> Am I missing something?

They are both threaded.  See commit 2a1d3ab8986d1b2 ("genirq: Handle
force threading of irqs with primary and thread handler")

>=20
> > at the same FIFO priority.  This can lead to the aer_isr thread starvin=
g
> > the aer_irq thread, particularly if multi_error_valid causes a scan of
> > all devices, and multiple errors are raised during the scan.
>=20
> I'm not seeing aer_isr() waiting on a spinlock, so how can it be starved?

It's not about locks... Maybe starvation is too strong of a word since
aer_irq does eventually get to run, just too late to avert yet another
multi error that starts the whole thing over again.

-Crystal


