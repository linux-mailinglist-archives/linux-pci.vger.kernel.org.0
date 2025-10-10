Return-Path: <linux-pci+bounces-37822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8216BCE117
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817503B492C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F842049;
	Fri, 10 Oct 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/lfwDDP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2A218AB0
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116698; cv=none; b=eR8ZoRBV0yFyfTeI+2w0z/yIjiK0ya9DO7r8/G0BC8B9t59JEwfiMogNiFC2QsJ6oKmMwIOEGvhw9cmyHhT+wta9b9ptt0SpznVAOhlg7Xtd1rBbJvx4NKioTqZ7ObPubGSE0rfo/Zc5h6HbaMLMwPiG4XaTsGYdlLk5dES7atk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116698; c=relaxed/simple;
	bh=Z8Bgg8Yh3z/S2AKEWMy72snzKqxcwIZAWYiJw1H/xlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka0gyTOE7v7/8B1AwWaLGRm4IT2q5ca1Cb2Y/JYYTy+l51NpogsRIV5OI6b0IRmg29zwog1uP2IccQGTBaIHZ08gevHubsjtJ06BBhMAhLt0Diev/pPAS1Y10hvUzunPpVnKpEFyIpheU9tGfQtmZ563cWW6sVlW8MAg70/yeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/lfwDDP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so1635299a91.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760116696; x=1760721496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BfVsigI/RIm7lCLr6Chg7lwMcGQgn9TsXQSX3+pXnM=;
        b=G/lfwDDPTIJm8F10JlGVZ42+ooBOZZXzLjuA2ttCnThVp9CKtnJUF4Gl8qy1BD1itS
         UIFvhdkeIHPS5A0RAB+QETV0YKlOorO4mbCKjLIeDpugPXH2XBCig4gq1xeqne8iIhuJ
         1Lpv2vkFO9YUMRITCuTAn3qaznCTNI9o8dmEzcVJIp/XjRBBaVl+txBIDZ8/yDqCwQhU
         H1W7EuIU/3rFbEwvMnRps35TyFxgP6gQaEPsl0dgQmBbZT4upspBgwIR6JvsOUxK/LjT
         T8V7UIl/eiVmrfW1yyZrsqI+Wf22UtaskmcWiemq2Ud9jPFFDoORu+yfzTpHn5BfWbY1
         TnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760116696; x=1760721496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BfVsigI/RIm7lCLr6Chg7lwMcGQgn9TsXQSX3+pXnM=;
        b=vsqYyCo75HCtAJVicnsOYCpDOfHGHsGnt2UNW2S0MXQuhz9Qtoh4LnCsBCrdhp1RcK
         XPIn8iNWDW/KDx2ff1lQBf+iJYLnCKykfYx+8erAcOsoqTtgzit7qYY0BRAYdYQRmV47
         ussYk4FFGyeukNAUDFiX2h4Dwa+qzi5zVv+Qdhmge4f7VpLOTj2+DJnz1lQaHZffoagJ
         J+GrqE9NuTFrlJ03OlnLze8Qo92iOn7f+i4+2DXjr6VvFM/pl8QGejPG7pBkJVXh1dxt
         JyEl1VOgABnU4qYq6KOo0N4qo9LyRdWKGcp/jwknVAt2pdC890mdjAUc+fn49O5fzLDk
         4PFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNwWnGReUvAWG1ciJR6NdV5+JvX/tB6l1ZVu8cyk8QX2Dv5atn9C4+nnpHYRB4qNHaM6ddMYaIODI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0XN9voFFzJf3JfhdFQUVBB5wCNE7QYtEDQa9KLKyHhuOAeun5
	zdl5meWCaBk7F8CVqge1ZQuCM7Ug7s5U/TEO2c0S0+XjrHw12R/KZD8ddfVrCncNV2V8CWnvJeB
	pITadtr39lvmbr5PWVeyzMkg51Oe5hlc=
X-Gm-Gg: ASbGncvd+OyAQBIXJ0daqbJWZzZXNojaaFGwPMU2MiF6l4U7bjXcQJJttNjjKp9PvuV
	WOwWh08NUb+jkUjm1/4y3RTDRWC9gq7Ur2VAMRKfjFJf4692kOY7VCscA3lUujElB71u6hsnZla
	0qpJ7PQaCUHEemHMKefQ0glX9NZRCUTvin1XIBCV1GXaUl5+LlmsXJZSuNw0I+Q9x1Y1cfYG2ee
	grmwOr6MqWF9Cnhp1NZZ/zEdU+nIwXLWfvD+g==
X-Google-Smtp-Source: AGHT+IH1giPZcnOv6CGAjB6Rl2QcFEzz3CPtE14GWTh10ezJZ6kvXIL6/4N3fdyqX9JAPTZlX1XtlfpaKep3fWug9Ws=
X-Received: by 2002:a17:90b:1fc4:b0:32b:d8a9:8725 with SMTP id
 98e67ed59e1d1-339edadd5b9mr23216650a91.18.1760116696201; Fri, 10 Oct 2025
 10:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com> <20251010071555.u4ubYPid@linutronix.de>
In-Reply-To: <20251010071555.u4ubYPid@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Sat, 11 Oct 2025 01:18:05 +0800
X-Gm-Features: AS18NWB9IwjfwJLLXvf_C7PSNG6WlpQ2fa-Gc_uHnrsGBHqIZb9E1EFejDVQ0N0
Message-ID: <CAH6oFv+SUo7B6nPPw=OgQ1AhqVfQYC1HvX=kjcHJX8W13kTwZQ@mail.gmail.com>
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 10, 2025 at 09:15:55AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-09 15:06:50 [+0000], Guangbo Cui wrote:
> > index 91acc7b17f68..6dd231d9fccd 100644
> > --- a/drivers/pci/pcie/aer_inject.c
> > +++ b/drivers/pci/pcie/aer_inject.c
> > @@ -523,8 +523,8 @@ static int __init aer_inject_init(void)
> >  static void __exit aer_inject_exit(void)
> >  {
> >     struct aer_error *err, *err_next;
> > -   unsigned long flags;
> >     struct pci_bus_ops *bus_ops;
> > +   LIST_HEAD(einjected_to_free);
> >
> >     misc_deregister(&aer_inject_device);
> >
> > @@ -533,12 +533,14 @@ static void __exit aer_inject_exit(void)
> >             kfree(bus_ops);
> >     }
> >
> > -   spin_lock_irqsave(&inject_lock, flags);
> > -   list_for_each_entry_safe(err, err_next, &einjected, list) {
> > +   scoped_guard(raw_spinlock_irqsave, &inject_lock) {
> > +           list_splice_init(&einjected, &einjected_to_free);
> > +   }
>
> I would either convert _all_ instance of the lock usage to guard
> notation or none. But not one.


> Also I wouldn't split everything to another list just to free it later.
> I would argue here that locking in aer_inject_exit() locking is not
> required because the misc device is removed (no one can keep it open as
> it would not allow module removal) and so this is the only possible
> user.
> Therefore you can iterate over the list and free items lock less.
> This reasoning of this change needs to be part of your commit
> description. Also _why_ this becomes a problem. You do not mention this
> change at all.

Hi, Sebastian

Yeah, you're right. Once misc_deregister is called, no new user can add
err injection, and aer_inj_pci_ops was deleted by pci_bus_ops_pop below.
All places that access einjected have already been released, so freeing
einjected can be done without locking.

I will drop the lock in aer_inject_exit, and update commit msg.

Best regards,
Guangbo

