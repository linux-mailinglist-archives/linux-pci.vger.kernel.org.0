Return-Path: <linux-pci+bounces-4924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC9E880A12
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 04:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF651C21F27
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADEC101EC;
	Wed, 20 Mar 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2LKfsF2"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5A12B7D
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904414; cv=none; b=IQUxBpxQDXcH6rLaJOCjeVQM7Nm/8qhQ7nkG58JdmPadpd25KoPJkE9Pz1abmPVxNKRGK+u0oU7p0yTlLS5VEYFWNbPPRY82r5/83xos++VTz/nZJh+LMml/0nHXGt/Q1Gos0/aGcoEmdQZIAI35O7BV5z9o+sKGQ3fXby6Qokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904414; c=relaxed/simple;
	bh=XV379SZQ55e4xAf1CMadA97UbFa+JnT2OmO/S5sG6KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Avt1k6oxCn/5Nji72rCNXXw6HFcrmjUu4r8Dm7h/5XiFwFtvE1jhR2TZVp0P72XAYp34p0SzmSaioKf4xlqTYI25OmIaHxszwMTV6vSXMrtMgNiDRsoJ7x5+DKxpb+MQmAB0QXc+LMhtF9woyaH15y83QlY5tdzPc+jFZETXbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2LKfsF2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710904410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQejs4ySvuw8lsjacVnZQCtdK5QD3pI/qG4QGiCUYgo=;
	b=C2LKfsF2ixrT43UiZIgZu3NgVG07SCnmzUpTkG9Ccll1XntxPzgtb4Cl0Ab+0XBQE0SPls
	oOJa9Jzc9RRzrIiB8IeGEcZZbGAEF27BlOSPe87SVlLqG+uPmQZC2E69/p+hJNRXPoaQnh
	dvvOpllxo9I/a6j/62imiSZJoPVlHLo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-cssH_BSmNk69AHd-xWtP1Q-1; Tue, 19 Mar 2024 23:13:28 -0400
X-MC-Unique: cssH_BSmNk69AHd-xWtP1Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29e06733018so3271103a91.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 20:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710904407; x=1711509207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQejs4ySvuw8lsjacVnZQCtdK5QD3pI/qG4QGiCUYgo=;
        b=P/KTRJb7RkfQBBfrTyxJdEsDrvkExmV8m6yBH/G+VBIJF4LW11CGCP9NsTWechlVmU
         YdgDJiMj/syfV2RrFLx+Z05fwjyX8dwFZxCVltQwQegOkYCqZd007ym2UnjxRYZ3GRoy
         erGp5R/gHjkoIcl2B/ZId3C4ePyh/Enq9EH3ntt5iI0X+XfetchsbL3ZDhvTlVBe++Zh
         MYssxNEkdGXhic3wLgavaZsVJkBh9sG6HpMs07JCVMn8xHHlm55UXeB1xGB86jWoWzrC
         Q29eu7PYTL3eJnfSC/fNWxl5uBt+03Ejl+BurR+3vMeSBv74vcPLq2/qUsXSI4SvYUr9
         H0NQ==
X-Gm-Message-State: AOJu0YwPkN1lY6lS6Dkk9vCHcanCPCwCD3keammVYSa89un/8HpbH5mr
	VViEw7RHeCsoj8l+Z3Z4HyrX78wVpsaCy+A2IQ0xHpuIL1ADS2bNdVqTVc5JLSOFlkLCd8vvndN
	uLOBispgbphOWhRSWgh4fix3M7wBJMpjl+qdyX5cVIGFzFLDhqOxYAW4dyH/CA295ZXrdeQfD4z
	l9l8ldcdvWHb7TMr8g/bUDuadeVv2Ti60lqzX7UChjVW6rpnd/
X-Received: by 2002:a17:90a:e60d:b0:29f:8b48:b390 with SMTP id j13-20020a17090ae60d00b0029f8b48b390mr899166pjy.16.1710904406981;
        Tue, 19 Mar 2024 20:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG8Mf/3c46oS+6xFdeC0nDqLLGLi21Z8NA6fsaBEzG3mh9RDzSRbI/vgXoJtniBuk/IjTBPmcVqp45i3bwLIE=
X-Received: by 2002:a17:90a:e60d:b0:29f:8b48:b390 with SMTP id
 j13-20020a17090ae60d00b0029f8b48b390mr899163pjy.16.1710904406679; Tue, 19 Mar
 2024 20:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+WDQXvFB2xEs=8pU02qseVHCWJvEVv5RRZFQnHbJFa=cw@mail.gmail.com>
 <20240320024647.GA1254126@bhelgaas>
In-Reply-To: <20240320024647.GA1254126@bhelgaas>
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 20 Mar 2024 11:13:15 +0800
Message-ID: <CAGVVp+WxLedyv_McUhiMhMc1wKByp89xZLt86Z2dgAdzCQy8qg@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 0 PID: 226 at drivers/pci/pci.c:2236 pci_disable_device+0xf4/0x100
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:46=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Wed, Mar 20, 2024 at 10:16:06AM +0800, Changhui Zhong wrote:
> > On Wed, Mar 20, 2024 at 12:30=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > On Tue, Mar 19, 2024 at 03:34:56PM +0800, Changhui Zhong wrote:
> > > > repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
> > > > branch: master
> > > > commit HEAD:b3603fcb79b1036acae10602bffc4855a4b9af80
> > >
> > > Where's the rest of this?  I don't see "WARNING: CPU: 0 PID: 226 at
> > > drivers/pci/pci.c:2236" in the snippet below.  Please include or post
> > > the complete dmesg log.
> > >
> > > Is this reproducible?  If so, how?  And is it a regression?
> >
> > it reproduceible=EF=BC=8CI can trigger it every time on my server=EF=BC=
=8Cbut I'm not
> > sure if it is a regression=EF=BC=8C
>
> Great, it's always easier if it's easily reproducible.  Can you please
> try an older kernel, e.g., v6.8?
>

yeah=EF=BC=8CI can try it=EF=BC=8C will feedback test result later

> > dmesg log on my other server=EF=BC=9A
>
> Please include or post the *complete* dmesg log all the way from the
> very beginning of boot, not just the snippet you included below.  The
> complete log contains useful information that we need to investigate
> this problem.
>

the complete dmesg log is too huge. I intercepted a log from boot to reboot=
.
please check  https://pastebin.com/0iuYhFCR


