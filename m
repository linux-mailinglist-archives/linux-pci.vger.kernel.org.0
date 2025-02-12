Return-Path: <linux-pci+bounces-21321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F387FA33342
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B13B3A3756
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628BD20011F;
	Wed, 12 Feb 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbrGXk10"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E91FF1D6
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402405; cv=none; b=mOGL/sI301GwNOws4wB1lOfmiJ3xlOTNQuOe1niMAsM94MHYe8UdPc5Fn+XIzRsMyjNpFzjTSyzk6q3QclUrfDDf541shm6/FTVZaHaL2nyZzyuDrR8UPqv9Il79T1pnB+mTQdXcocSF5/Ig9UCN2NYALcUGrg2E0dJ2xi+Pslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402405; c=relaxed/simple;
	bh=ECDOnrcoJYSI9eHQUC14y3oHio2NNBQYqzdnTL6jXTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OctG3vfP6GWL5Q0PPpfAugzsoXB9je9BpnfivoYHcdE1y3jJtB303hd4Xcjic9Khc71tO0GYtS99u5yEgsx7YtPF7bqznEBn8kuYA08wqUVM6cEk0dNtL5kw9zEdgakuCIqVssXZJwtbpHCdEtiEYus3vAYTtSjKLBOYJe9lmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZbrGXk10; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7f860a9c6so66470166b.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 15:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739402402; x=1740007202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPAz+7QaCN4t3sOliWEc2WzbgMXe/2BOaCfPz1FmYRA=;
        b=ZbrGXk102JqiCTXD3uTTz+rb5zilSJmxCj7m1rsH4E54gsZhSAk9SLFNDYcbeC8Vpt
         6B0oxtxghl55xw3e6nGRw15sNPLu1TTNhME2BqxrlhP/Rh+u/hhU251orjvT2h+p0KHg
         TekIsE3EvwYN+RNFX+1MDLeZgahBowPy0zIIFqG+2/+b4yH6FbqRvKWEymYVrnEEZcF5
         XQ5niTVno/b3XG+Hxydo9+JXZPR2xY7u/g17PAW+R+pU6vqn9xqdFjntT0t38+iALl7c
         rsXGxOSviNPm7CvP9ToSEvzjKf+qjvx1OWdXDphH9v7FZ3IHedn/+kGZ5V6NXcZT5dNK
         tfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402402; x=1740007202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPAz+7QaCN4t3sOliWEc2WzbgMXe/2BOaCfPz1FmYRA=;
        b=ikN0CsG9l5DM7FzEOkJqd8WY8lfoKJSM4maSGxNbpDCNHa6UjCxAnh7s8X1W3iViE2
         VHzY+moVM54GlJf4GN2XkpFs8kHYiibNvbIIaBoe1z7CuW3YOtJssSqFgI3LKxTN+MeY
         1dxpBvlsR2767DbhKBDlxfF3AYWLpwU/Db06QBr41VyaNxyKQec8Kr4xk1HIJ+zpqVP8
         4yZ4LTa7GTtHwoZLzdYEr7PDyGlbfibI4TS9qWg0SUOFKqVa3cnoMHzUxX5obpW3mGna
         izZQFj5sXbnFK7Ol037TqObztcBOkMU34M8h5gyhVy2rOcUMS3wczHp/kLo26DcVnZ/t
         wJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy/0dmlXZTMOiW7wBK2jfNWCJyYP23x766YBieH4mhI5Lu85xzLuG5dTSqO7MY+6oQmoR0xZA7Z/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq6Ru5uDvPnLmBLlqhKuBQ1CklvzBz8fQ7BczevA0XmNoagSs
	1Vn7phwXmKk07y8hChS4hD49su8L3xhNZ/nrU92Ipqvk2N5EbXxpG7C9SAe7CWzuKwGbnCfFg7A
	d0/lRMKRTdX3kM9ldt0K5t0SnxiBlWmqgCTRJ
X-Gm-Gg: ASbGncsOW51Uu+LuSNCxSzDGQkqj5WBJIQwBMwxfHe5xzSW8U7gcuo80AwuZB/6D5Q1
	E7QbwNRtXfbrp92N457SlOWPqfAoUEktVqna2zJpm363dYf3NY7UKgsFsV0jjLKF7U5XIE9UlZ0
	WE3ODbDLj6gJHRHoK985eATCj3VPk=
X-Google-Smtp-Source: AGHT+IGdhmDVY6lbP5aeW4Ibzq5PlPe2KSKO56JQvI1OYvmyzxmRzF1RQrgfL3sspdubwOAM7XeWXEgSie0jjtQfg9g=
X-Received: by 2002:a17:907:3d93:b0:ab7:8520:e953 with SMTP id
 a640c23a62f3a-ab7f34d4f0dmr424193266b.55.1739402401787; Wed, 12 Feb 2025
 15:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-9-pandoh@google.com>
 <620bbbde-35a9-4232-9cf9-a1fa1e899f8a@oracle.com> <CACK8Z6Hyx4D3d=BK15f55muYu7kMLYV7fEusc7dTiUJJ3G5KuQ@mail.gmail.com>
 <20250131143616.00007a73@huawei.com>
In-Reply-To: <20250131143616.00007a73@huawei.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 12 Feb 2025 15:19:50 -0800
X-Gm-Features: AWEUYZmMqsW6zIXfG_DQcM1ljiBTNxUtzjZDstqgL6A8rW8IEHyzbQEwtRUx-n8
Message-ID: <CAMC_AXWoojfVR8G1caW4yKM8gYmKQvoAR4BoDc5gT58BgtBP5g@mail.gmail.com>
Subject: Re: [PATCH 8/8] PCI/AER: Move AER sysfs attributes into separate directory
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rajat Jain <rajatja@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 6:36=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> You'd need to be really sure no one is using them or this is
> ABI breakage and will need reverting.  If it's been live for a while
> then we are in a mess as we have to revert and break new users...
>
> Generally I'd go with don't touch the existing elements.

Ack. Karolina/your feedback echoes Bjorn/Rajat's comments in internal
review. Will drop it in the next version.

I posted it to solicit outside feedback from other users (e.g. how
many tools depend on the path).

Thanks,
Jon

