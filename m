Return-Path: <linux-pci+bounces-37834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D27BCEC74
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 01:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 422DF4E538E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE32E9755;
	Fri, 10 Oct 2025 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BupDfTxv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B82E9ED1
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760140197; cv=none; b=lQK1Dp1YgmRz4iYtz6YYJ01rdzx2X6i9eAgK374JKp29vBsQM5CDf7r/wE3esfv72IZnlAcgx9oeGagjMmbTm1UIMmi5xN4Bfm1oh+isNgNdtnc7uZopvECQEC7eL0/hQrePsBpOYLRl1Av2K9U6TqfMLfq4pjex9VZYKRfSWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760140197; c=relaxed/simple;
	bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fwt72MeV5Sx0+naC0Reny6N3toiNyAZsNHFjfT1JocSpCXrGf7IC7ZwB0rtFGNtNI7HzOJ2uQcMDMO59imh3b1C501vac9J7ThGMCpMYxsqGeggIiwH0qzgezlbCsQNYIZjWoLFM2AnjPU37EooXFAWnRy2MUnN2QdJKeTJH3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BupDfTxv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1131776f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 16:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760140194; x=1760744994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
        b=BupDfTxv5Pq7lT7BYAzcajdCjINpun1dHRcCFSli60tJ+7qTQwCc+eyeXJH7oG0TcL
         FLMSJSAdSyu8tV+Id9t0qPTQT/U7I1UPtQsOm209zh70AuXL6TsRdZ7jgkP+wfntLYx8
         7jhziQkcQMkBBccg39lp03ZuU/cuCyUa3MijrjIvt9jody7o43yPmksz/taSqiJukFtq
         0z1aimfTJZ0xkGKLY+eWXoc/MfMhX/bIR4mMP9oR5kCEhCKyVr3j0cjx4zf01X8Dlax5
         siErZ6uPF8/Lm7IZop1myrx6kuQyRglUqI7vu726tL79mVjlWV2sYMHm0HXB1RA0EF2L
         8QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760140194; x=1760744994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
        b=n4P6sOseW2MN0hdmde2Z8KDXDk1e4TmQEvbUBo9D81xH/XxhKWjgC5YkX0OlXOq79I
         boEEhky1AHvbTA9bqKqg3g4ezFomtGdD5SCT/r7q3KAlwJBL2LCbPrnwtBDRMvvkMCQy
         cm8gcueEtbC+5KI1QkP2EHRbZSeS3LqN4gh5qqft5LIYe8wJuBS1T/BY/UNXkXPop1Em
         DTfGBZU6wb/xESIzlJxKI/ev6YiTt9NTfMIaYKoroVCcKsj6yB73wN2yVeW2yRvJtPpn
         Id7B8RmyemzcdE83saKyvCyaHRlrqsH7V77YVNp5JhNVhj+RRTg/jdEGwFPX1QIiEuJk
         ZfXA==
X-Forwarded-Encrypted: i=1; AJvYcCWsHZiOo1Kuk9UBxbtccoNs0Tkd2pFaE7myhNd12Cd5uylcPy2JA5Mwu9mi+DFUyOBGjRSAj8NjcoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaYuBwpyRkUhuPmeGahLxw2RYVrF+eSlEGikrxeC68kXo0/Lcj
	bzVnTjgZuR0LxkNjWTd21wImvsIz4JVAK1cygGW/82o7I7JjSrSm6L7tT/bNYVxzLOjcI1V0S5k
	Cw4nz4XEMa+/SUVXYDQF6yGGZ0JsTpRPc+ze20cW1
X-Gm-Gg: ASbGncsahpCaZB0nI8rRncaSb2hfp6yGWAoXEhPTN16zpc12SD99i1BTnrWWg35rKVZ
	vTWCYFeu8FiftcOVodQzH8mc+laEOfb1Hah5UCAIk42s4++6dZhvnwTtRTK067BDkciQSEdTapb
	bE0436mvh5CvIHTfK0ekOShJV+xE+VxXC00KZnYjRGJYfirM63wXrflxb+Ex4A7bW4ynhGUaKAW
	JdgZlc2QkothDY2U/Ur2kk5/LRLEqeJtJxxE6v9nn406lvgWaN5GHDCcIEXXYLtfmoduLB2gw==
X-Google-Smtp-Source: AGHT+IGS7tHdk0+ETIMQ93W4HeQKhAfSX1r/IP5abeF7P47AIA+uA/W8V68hokpCSKCF75Q0Jydg46lHFEFDPVRzp1M=
X-Received: by 2002:a5d:5c8a:0:b0:3e9:d54:19a0 with SMTP id
 ffacd0b85a97d-4267b3396eemr8310605f8f.57.1760140193870; Fri, 10 Oct 2025
 16:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
 <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
 <mafs0a51zmzjp.fsf@kernel.org> <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
In-Reply-To: <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
From: Jason Miu <jasonmiu@google.com>
Date: Fri, 10 Oct 2025 16:49:42 -0700
X-Gm-Features: AS18NWAkIO8EZmSKJ-cwcP3nrGVdmHJFmF8q10W7Jv6EeQBfqtNvpvxC46iB9-0
Message-ID: <CAHN2nPK34YfrysN+sraiFVjU_9Lw7E-yFVF-9x+nt1OUppZX8Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Chris Li <chrisl@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Oct 9, 2025 at 4:21=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
> >
> > On Tue, Oct 07 2025, Chris Li wrote:
> >
> > [...]
> > > That will keep me busy for a while waiting for the VFIO series.
> >
> > I recall we talked in one of the biweekly meetings about some sanity
> > checking of folios right before reboot (make sure they are right order,
> > etc.) under a KEXEC_HANDOVER_DEBUG option. If you have some spare time
> > on your hands, would be cool to see some patches for that as well :-)
>
> Sure, I will add that to my "nice to have" list. No promised I got
> time to get to it with the PCI. It belong to the KHO series not PCI
> though.
>
> Chris

Hi Pratyush, Chris,

For the folio sanity check with KEXEC_HANDOVER_DEBUG, I can follow
that up. Would you tell me what we like to check before reboot, I may
have missed some context. Thanks!

--
Jason Miu

