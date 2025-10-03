Return-Path: <linux-pci+bounces-37566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF519BB7E1F
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 20:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E403B3284
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129442DC771;
	Fri,  3 Oct 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i37GG8P2"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066B2DA77F
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515960; cv=none; b=WspSPLOybB10Ym7kQ0nz3WLL0gw4LwjLCtmV6vlaZVzE5z5HVuHNFu4WG8AGWtLfxPLOP1Ia+4nIBv2dG6d2mmS2KaeGPk8bQQ6N6RUJbcWgouldajQmFsqYjsIzdQyj+GrzhHCIONMl6qU/gpqRVRFlUGRkDBX3QkquAyJMgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515960; c=relaxed/simple;
	bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Syn4KPKPHeV6CoAmlT7JRwdC2MWCHMLZ6Wk5ss5P3F5mAc+g2QZLgmzHJFce+rEUJi8APUhznJ0Pre3jdgd/fn+NujV45OwUgF+Pz6KbfI3MxG0vhrTVvG729RCegAXFfDWQbOG/fdUJEnFb5Mht8tSy5+P52cpMt+CYoKiqgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i37GG8P2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759515957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
	b=i37GG8P2YTAVSmZ+cj1CiEPOtjhTn52e1RvFqS35ZUfUtbGHRBWPLaudRcjgvCEpY0Yccw
	cofY3vCqwmpQxU039bkZXu7g2a3BiJfkEZagZFvK0mdDbpp6XlsLvmWGlMGOePKpV3dyRz
	SwhKmIZ4hbVCjRGcQ/bfQ0QIe6AJ6zE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214--60yLzFqME6rlllg9feWcA-1; Fri, 03 Oct 2025 14:25:56 -0400
X-MC-Unique: -60yLzFqME6rlllg9feWcA-1
X-Mimecast-MFC-AGG-ID: -60yLzFqME6rlllg9feWcA_1759515955
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4dfe8dafd18so106687171cf.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 11:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515955; x=1760120755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
        b=l9TVUWe3VHDWJwBQvWz2kqajCw5PM5KBgBxzroKeDLPDIkcKNZ+t9uLxX1fGtlXE9q
         oa9OrYQy0+O/kZd2OjKDKGhi4LJOK7hK63nIxzkWDE7BgEt7GuOZyqu95ZfdB2P97Xo/
         E2y1aqb4soueTIQMfqfcKTpV9421A4gS9gZhA/qAf0SBiugU5KOAn3/lsr+JJWEoXuls
         Vf3E+YWYhNGmp6BwVtnZnYNpNNZTYqTAW/0bijz3d8xj5dYnTibbxuMcCN7LN0iNDmd4
         fRqFhvI2d4oFmDNBdfbIrZVNiJGYBNPxBlnnUXn+bBwmDJv+Z3sLMjOKyNsyQVPNzOzJ
         DuSg==
X-Forwarded-Encrypted: i=1; AJvYcCXBhYhQnKN+AxHFw++mo7g0k79wR+ve93WQXPJCf5Q4tE3PMOqDp1NAfDo7NbC6JlPI1FYLdx46L5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBQK46SyHK3J0v5W8wR/beQ7Hr+dbPYvLO1RoT6xnQR2d9qr7
	Y0cwyRu9OyozI/7e22y3x0CiyGhRfmfTAXf7/r3el3XqlqLlN9MP0zqvW9jRiVtbnN5wyI9caI+
	/z/0/M11q/orGNhuQe5EirAWRlMBFeDwxSrRew2ywe4cWfg/kO7L5FjSIfzUIsQ==
X-Gm-Gg: ASbGncsIqeg2oY5q1Jxnlnu0ctqgLtaGeyNW4Sd2ZD4TRq+pP5wEPA7oe5krQKBA+0v
	ICr1Kw/7vS3b3DseTlv61ymEzKX+5PbjyJFvG4xrPbOIYEgXatI/HcAOpWC7WFOimy+VoI/IvhF
	MBDkbq6JDWopl9EBHQmw1KVGNGOTjlDieCKWJPLHELuF3X1vx81WFlVbDhDnXrxrpoW7lsXGaJY
	ae+rHlpKo+zldv2j1TF/Ug1EqhRq47GqBYEywGI4AYkEyh/7ErJAtLvhWKksnk3vXRt7JVnJWLL
	bKUQbUsk7JUyWjGA6YlXFgHDnRMp/6fwEqedOxABIwW6PkRnCJO8A5T2bcqKLCirh7a5/0SGbw=
	=
X-Received: by 2002:a05:622a:420b:b0:4de:5adb:20df with SMTP id d75a77b69052e-4e576b49fc9mr51800421cf.75.1759515955468;
        Fri, 03 Oct 2025 11:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl6MbKs3Xb6exRfHKs8R/8W88faZKEv/f6HSCYFxtPk4/rUynv2mK5zOAipf0zbQgK3MTWtQ==
X-Received: by 2002:a05:622a:420b:b0:4de:5adb:20df with SMTP id d75a77b69052e-4e576b49fc9mr51799931cf.75.1759515954967;
        Fri, 03 Oct 2025 11:25:54 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf52afcsm44134596d6.46.2025.10.03.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:25:54 -0700 (PDT)
Message-ID: <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
From: Crystal Wood <crwood@redhat.com>
To: Lukas Wunner <lukas@wunner.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>, Ben
 Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, 	linux-kernel@vger.kernel.org, Attila
 Fazekas <afazekas@redhat.com>, 	linux-pci@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Bjorn Helgaas	 <helgaas@kernel.org>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>
Date: Fri, 03 Oct 2025 13:25:53 -0500
In-Reply-To: <aM_5uXlknW286cfg@wunner.de>
References: 
	<83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
	 <87348g95yd.ffs@tglx> <aM_5uXlknW286cfg@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-09-21 at 15:12 +0200, Lukas Wunner wrote:
> On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> > I obviously understand that the proposed change squashs the whole class
> > of similar (not yet detected) issues, but that made me look at that
> > particular instance nevertheless.
> >=20
> > All aer_irq() does is reading two PCI config words, writing one and the=
n
> > sticking 64bytes into a KFIFO. All of that is hard interrupt safe. So
> > arguably this AER problem can be nicely solved by the below one-liner,
> > no?
>=20
> The one-liner (which sets IRQF_NO_THREAD) was what Crystal originally
> proposed:
>=20
> https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/

So, is the plan to apply the original patch then?


Thanks,
Crystal


