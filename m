Return-Path: <linux-pci+bounces-22680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF5A4A5EA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 23:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DD53B0724
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB581DE4E3;
	Fri, 28 Feb 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="trKqY72W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE631ABED9
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781737; cv=none; b=cnU+566If367hlyG+QLHBpHmnR5+Fws7mRcSQIh40SEhamqijB7DVJEB9c5kVEWj2nFDQYnt89EsRmAP1RLraIn+ndqZtiTC5FZD0iPdedDBZMwK4nPAgIDzuoy+W62QSkA+hUxnYsh209c+K6F0WCwNdyywYBsV+j0pptKcwP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781737; c=relaxed/simple;
	bh=Rt/RIGrKFcJpwly2BDoGf6K6hg031zQKZONPx+aZstw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmNtghYMnhtNHnRnYpMtL7ddOgviMaVkbhPsyOjPHssOyOijmkXY/Nouv0bj3fVkopU7eEFScnQtaqf17gp6Q3BDtThwmFhdkI3sAxpqq6GDBdE5136lLs7gjlcIh3QjG6rwlJLnTko9BDEI8iVDdNT67UPk6sWVxaKItP/q3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=trKqY72W; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso3995264a12.2
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781734; x=1741386534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVypIbgGItwhBuw+Obj7DEi+xEqo6BZ4AwVrncdczdM=;
        b=trKqY72WjHJLqZ7Og/bRGhJHYqP4hHO699VlFfJan4wautQwZGGEzY2Rc6y+t5TJke
         anA/Fo6uwXvDL5lG4M+wgKjvbUZIdhTtF02NkKUhEvK++ac21JYcwdTzZZOL5UJ6LAZb
         BKDXG+YzZ+EoHyYMc+WPAj/pSypk2u50LfKU1m9Ra+XX8PHcrb5fYrPUizJ9OMQUto/p
         /jxWhL+B/SrJIqTA5mO0r1Ex3Au5LJ+mxKX1pzdJsGSNSJKwC0p55hTSaErZXYdplTtL
         n/VTPWmQQNmSt49wTfwGl14lImriWMcowFv7kuNmkflIFxc2NVFBZyACVQehlGUH6x30
         tB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781734; x=1741386534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVypIbgGItwhBuw+Obj7DEi+xEqo6BZ4AwVrncdczdM=;
        b=WAxG84iTbYadZGYO5IOf+4smkyCFkc/fvjtr1q1Q0B+I2LYd+uwTMCWN2McG/4bMHS
         sgADooJhwm+hdTTRj8g22X26wOjUAaIdWih3E9P3TjBm6SLHiz5tuCh7of+QUrTL3cOR
         bgi4oYiq6+Fy76Oa52/6kW1Au/O1MhKSVrE/WhebE/s8HmpV3aQfOkilg7wU5v3aE55B
         d+YaBnjXlG2hGVf7dPO1YSswPU1oczg7ClcEEeGPSMxfzvfjDukbY4I9q8iXd4nWg9Nl
         6VT9Tt06sUaXoQ3Bofy0INQejg3fHb7BvtZK14hYsn/lcSIAdHYkAMVM0DrloC5U0Tre
         Wj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsKDceJ1yIfg3mwS5RkpQU4M2xdpInbzQS/1F50dEUxWv9g6oysF1iVoEL8vDDE57lgCoq1ET+UHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53ctwp1CNL45zIocXw0atYWSbsQ6dAM5WuDWzUvogpq3ZdweN
	CmC6CiEYWLaQP2bSrBI+zWBS8MPwCSTjE+jyrDgVn2mYCQdomRSIdiaVVAr/yBACeIra15KIqRs
	KnuKLn0A1h/rlbG1q6+qsZ5UdTrvoBoQDkJNF
X-Gm-Gg: ASbGncstnI0obEkxYEFZ/j4Y5haorxzX5Gm57M/agCV8uQVF5XVY1xEXQiRbsxRlEYj
	/JwgIFEfLdp5LvY8zV8mL/4N61CL9zO7RcqanCIxn2a9nfuGvwLiCPbN4H1ecA4JqR84F2wE86Z
	wbqwZ9Z7/dKsxWM57xMVvtAGh7Rw+N+tSoLXUN
X-Google-Smtp-Source: AGHT+IGu+7pqD4ZHp3ODEXUSoqU4YtI0VJD8mlUzv4qKuUSbqsfnjHJi5Ns08svZoPo9nVQHjIeH/gUZa1zQeRt+4Lc=
X-Received: by 2002:a17:907:7d8c:b0:ab7:9a7:688e with SMTP id
 a640c23a62f3a-abf265a30b1mr478242666b.45.1740781733941; Fri, 28 Feb 2025
 14:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-8-pandoh@google.com>
 <319344c5-02bb-4257-92a5-424ce72654f9@oracle.com>
In-Reply-To: <319344c5-02bb-4257-92a5-424ce72654f9@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 28 Feb 2025 14:28:42 -0800
X-Gm-Features: AQ5f1Jp3SOO17z9QEzSEq2I5pwTrPW0RitPJXTMM1LvdLfcO96bl-GxwxDIygNw
Message-ID: <CAMC_AXXaxsUDkOa1SED4F6AZ8TQceHOJfQMJ8FpmQ+=gzArV4Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] PCI/AER: Add AER sysfs attributes for log ratelimits
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:56=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> On 14/02/2025 03:35, Jon Pan-Doh wrote:
> > +
> > +static struct attribute *aer_attrs[] __ro_after_init =3D {
>                                         ^^^^^^^^^^^^^^^
> This is a copy-paste error. These attributes are in the read-only region
> and can't be written to, so please remove it in the next version.

Ack.

> Also, what value do we have to write to turn off ratelimiting
> completely? Can we handle that as a special case?

Not something I originally planned, but can add it in v3. Given the
permanence of sysfs entries, would we want one toggle for all
ratelimiting (logs and potentially IRQs) or separate ones?

Thanks,
Jon

