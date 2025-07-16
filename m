Return-Path: <linux-pci+bounces-32242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DF0B06FD3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 10:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94BC189F5D7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7272289E3D;
	Wed, 16 Jul 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="E66Mh1Db"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417C2857E2
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653035; cv=none; b=FS+rsqgo6tzytUA5Z5E6XAXz28BdfWEv2HD+TsuubnrMg8xYz7ve6hHHYVMUL3PvpGoRdk7kgwHPu5oZ1dAd6IntJiZeY6Ve0sqOfqL4I3AYPufWwxneUEYm4jVMLb/tXUG1Cuoip9sVrLDEXyDO85yq1a/m29QECfMxWjUX6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653035; c=relaxed/simple;
	bh=PWyG0Hvg1POxl02CDV5NXpcMX19Ft9gYgcFyl5hDkns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf0o0+etbeK8MBOSPstFoPKukdsydEEnp/nD0GyRrRntHPzL6j4aT7ZwcpoeSaj7rru9nCHEEdrCW3eu3ii6PrBjoWedg3ndOZQ1QoIry1GsZLCFYiq1EkT9BIFIkbb+kmY5m5B6nPGogqQWrCY23So5x0/EgH2ET7ma6LVY0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=E66Mh1Db; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5344894a85aso2763563e0c.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1752653032; x=1753257832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PWyG0Hvg1POxl02CDV5NXpcMX19Ft9gYgcFyl5hDkns=;
        b=E66Mh1Db13FNw8d3pIhYvoT0UW6wSZPIUYAySSGh23CaSCg/1SmqaQdUABhT4eETms
         jMAI2amU2J9JAvuV4qzlCRRRJZuIt+CQEZ6WeowH6YT1sn0qmvQOjwPyVDIMkCiZ3cmV
         mH1g2vZy7G6+TVh+mDyYoDAcj3yp3/WLrELWeSJ2eqodTvFkUgXnxxvSvnmynb8dDi4C
         RZUU6Wqgqr01JKKO3PDpiUOIFoyOtNITJERTXWYtawyKDmNOyl2bl1TbyxJgAeH0G3Cq
         faB1YGlh75JII7Y+ft3MMo7waDZxBCSrL7rVwnWysb0ETeVJKhJLgrSCZoywLxXVPOC+
         HUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752653032; x=1753257832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWyG0Hvg1POxl02CDV5NXpcMX19Ft9gYgcFyl5hDkns=;
        b=ePv3qeaTISfN3a3TeOpV1WHyVbc9nS+PMJsISMArKmHVDNnjzAb7oApUuXGLGTisd5
         wAiTOdlB0NHVXkYBLgg55WmNcyPhJikpnUMyVRfBzTsKFpecInAG+sr1mA5ftx075MVM
         8jK5fDfkq1SIwtQWu/OxWOJK9wkFAr33lYbjDle/Hs/CQnwjK/Q/aX0rrgYcICXNdo0V
         RrM+ckhzwb1DflnLMmdDsqz9K1qTt91KA4YUNPvf2euBArp1FrCs0J4LvUu+Nbu+2pKg
         ZwGfP5CRywlL+y65Aqlh0IwDvAR+zhoujJ0Cb7Pq+r8+boz6VjvSh7U5xWCj7p3NmC7M
         cKPw==
X-Forwarded-Encrypted: i=1; AJvYcCWLqN8eVeQIVCbbW0kze6j+DXyXvQtS+cfe/NJ3C+JBrTB2EPj860dgaES43Q4FaxIyIAqlxVodF94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAkjiId51/J5QGrapZmwt4IFuYxlIeHsjpVJYShBcWcQ/rTHOy
	zJHdkRnacsRkt58keF0hA5hs+KGAwPOtrpEeqsk5pgu2hCz6T2JV0zZPoO41poRT8j7mmRnJGZv
	N7rLnSaDi/gGqQHCgu5SCAyaTQkfbTv6NnCeQLOrkoQ==
X-Gm-Gg: ASbGncuWTATaEiGUiVkuTbAanasW3dtvbc9H7jG1yj7n29CBn1SbB3tNE4kLBAsQcDg
	CA+l2FWmbu6rGoH4ODrJqhf2YB9WNhOG80AS4+Fk5BV3cTiuPQVUS5ely1n75jCvitPE99WqGW7
	Eb7sJEP15tACloMyyvsSPOBEBzsRKgRTSlWCG86rJ2Q99RGtto4rbvD7EXfEHMOwfH3OJQNbsoF
	352317hVOu0EbY0
X-Google-Smtp-Source: AGHT+IHuTp8Oe9gp929kW6Hut2cz4zrvspJHOxYdcWVKQbc+cNKYd+ZvcRbFGDU68t4/pUeH0eIZfybUIGS9src9Xjs=
X-Received: by 2002:a05:6122:2492:b0:535:aea0:7a0a with SMTP id
 71dfb90a1353d-5373e272f46mr1343232e0c.2.1752653032364; Wed, 16 Jul 2025
 01:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com> <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali> <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
 <20250715170637.mtplp7s73zwdbjay@pali>
In-Reply-To: <20250715170637.mtplp7s73zwdbjay@pali>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Wed, 16 Jul 2025 10:03:40 +0200
X-Gm-Features: Ac12FXz0TL7qGwSyQ1mpiWrm6IGZDPvVlKHX_1XmAYakRfQ93gQ8h2JQTcbg__o
Message-ID: <CAJDH93uXuR8cWSnUgOWwi=JNuS543mHLPJb9UUac2g=K4bFMSQ@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Borislav Petkov <bp@alien8.de>, =?UTF-8?B?RmlsaXAgxaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hello, thank you for information.
>
> Just I would like to know, where did you find information that the
> EnableCF8ExtCfg register was moved to D18F4x044? It is documented in
> some AMD specification?
>
> I did not find anything regarding this change.

I mentioned the exact specification in my first message. It's under
NDA, unfortunately.

