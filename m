Return-Path: <linux-pci+bounces-37557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A0BB7962
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9C748655B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56AC2C15B7;
	Fri,  3 Oct 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1K9103b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF041DF25C
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509751; cv=none; b=IDECCIxtdHpkkyVCPdRfZD1sHeKtceXd+MZenYulOobMSkhQ7Ze2b3Y44NCAvhivcX65phErTqTNOqjUGbeijG9OD8wEKYvUSa8AeFwnwroNhHorvGiDdv/XVvlxQ/ecGsTfiqwACI/i2ZYp5ov3yyppn3k3f7/KP5/NP46SH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509751; c=relaxed/simple;
	bh=tT4rIjRvSYCPH1NNHSlV3mpq6XJdV6RRM306+mUs0Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAgakHQD8OW0KZWPIqEFBx77iKdSNvd9xY6SK87rEUDzRSxlp+RQDglP4eQXI0usRPd3AwuUpQtvFekiRelVUgpdIMa+RaI4BWgMLVZupUIKg/cJHjVMhbYJVSl2nEEf0RoIWodjf/ub1EFvXhLLr8ndw8+LXGPi8LMLPFVVZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1K9103b; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-587bdad8919so133e87.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759509748; x=1760114548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT4rIjRvSYCPH1NNHSlV3mpq6XJdV6RRM306+mUs0Lw=;
        b=s1K9103bTXwFzGA5D4M2+gkP8jFXCU7oqI4NO0/LgobXbnvZHs7G6voEgOQ12nn7Ws
         qfb3M7VV9ZM+64yJkJatLOzNnMnliTlWC6iwyGpjqrVHeMhTxa+wJEk0zJlgE05j2URB
         qsKVdXALewru0BAuuGcNe4VCFCMHpNxVpnWgtxw+IvJP0KUacnDQR4L1iei0R9Uq0x9P
         DYVaGJsmFvlFVt1i6oqttQPjF/OPxR5uWOa8NxB0coZ3eDODd+nEIyoUST8IZwU29rwB
         7hkt3U3/u79xLHhTIfgskU0BdHVu7jUmpKGqWeLsZ2pIwsP/JrewtDfJjwLw4VnbpA7g
         bhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509748; x=1760114548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT4rIjRvSYCPH1NNHSlV3mpq6XJdV6RRM306+mUs0Lw=;
        b=UkW9XSxSPaYWjWcqFZ3dYgy3yi8uVGXp6aO6h23MyeaRIdnJjGVpTTbDmRkfTJczVU
         d6H+8Ig3TfdYR5hJnLdrZ/+IhfXFoBGB8KLf2l99vbF1pYVwWQiUOlpnX/5wAIi43zaw
         vLO2DDGLTAkCd/4uDB8FNC/UZ/3BGlZ2+XbcyQq7W912BT6BXhL26yktOjk2wfIq+V/9
         ZJzK/dD7QYp9v005WkH9xgmzSFPF+V8vpBge1KYRK8PR7piQcjiGaUuJUCnG1Pk4NiDL
         GvNtdYFbVyUD4dUzQX5mEEq6d8myXyrvvTEtDJm3ouCodrAynayV16ANyO3ACZpR8ufo
         XYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy4gagHmgWg00QT04j8pz7W+ptrJcTb9CiZoLtYCIpIg1qreBh5QEyM5IsBeIe/40GUPFFhUaIl7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHc6NxuYpZSJHO8NkziBC9Y9lQWQB2pwFaeBEGSAQDnKulmNN7
	QBx56yWGfVw/TLC1SpEHmJfwznNAoSM9UA/3c+ilffPkPJ0OYrZ4VozpZc9CSpERTeH5H/jki78
	y0QQmurtDJ4x7GoyGrAZQSE2nxxH9ay26gRPyUxmY
X-Gm-Gg: ASbGncteUJyxRFJr2P96703YrfQXITY7gTXo89ZEvLOmqSV8/HXZQxnz4goHTDzXntG
	H5Rg61XHzGmpQLnNQIOVqYjynxoPfZjE3/RJvm24oOBAMkVk4P5XkVAfN+m+JKVIKQtk/s3ySrx
	1JyCONOjnZWr/bB0eILySJrLLJq5Quv2q+joTem6B5S013TeqVBtgqrLHBZCWmUl+wQQghjMibu
	vqhLA3oHavKuqqVm0xIK8pUUHzNnD9M+y5w4w==
X-Google-Smtp-Source: AGHT+IFqcHHNLXDZwKQTjsXX4M2eYXbNbIBvJRQGHDGc0LD+gyEovYNCEF4ZnQT0KPGBrO6LNIQACl17PxjlNaBzO0E=
X-Received: by 2002:ac2:4191:0:b0:579:78f4:9c37 with SMTP id
 2adb3069b0e04-58cd9097003mr243088e87.7.1759509747606; Fri, 03 Oct 2025
 09:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca> <CACePvbXdzx5rfS1qKkFYtL-yizQiht_evge-jWo0F2ruobgkZA@mail.gmail.com>
 <20251003120638.GM3195829@ziepe.ca> <CALzav=eGXp3uHxRytfsKQdrtAV8xg8teoAs9n_sggqdAp_Hznw@mail.gmail.com>
In-Reply-To: <CALzav=eGXp3uHxRytfsKQdrtAV8xg8teoAs9n_sggqdAp_Hznw@mail.gmail.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Fri, 3 Oct 2025 09:41:49 -0700
X-Gm-Features: AS18NWAMnBsWWTpg4HgFgRyPlVOWpaiA-3tsEKIhlCcWxe4qMo14DNvQzaeShVI
Message-ID: <CAHVum0caxqVdKfoXNLa92NFEBLwTbLCRgbH6y6kvnsWQPgcbwA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:27=E2=80=AFAM David Matlack <dmatlack@google.com> =
wrote:
>
> On Fri, Oct 3, 2025 at 5:06=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> >
> > On Thu, Oct 02, 2025 at 10:24:59PM -0700, Chris Li wrote:
> >
> > > As David pointed out in the other email, the PCI also supports other
> > > non vfio PCI devices which do not have the FD and FD related sessions=
.
> > > That is the original intent for the LUO PCI subsystem.
> >
> > This doesn't make sense. We don't know how to solve this problem yet,
> > but I'm pretty confident we will need to inject a FD and session into
> > these drivers too.
>
> Google's LUO PCI subsystem (i.e. this series) predated a lot of the
> discussion about FD preservation and needed to support the legacy vfio
> container/group model. Outside of vfio-pci, the only other drivers
> that participate are the PF drivers (pci-pf-stub and idpf), but they
> just register empty callbacks.
>
> So from an upstream perspective we don't really have a usecase for
> callbacks. Chris ,I saw in your other email that you agree with
> dropping them in the next version, so it sounds like we are aligned
> then.
>
> Vipin Sharma is working on the vfio-pci MVP series. Vipin, if you
> anticipate VFIO is going to need driver callbacks on top of the LUO FD
> callbacks, please chime in here.

Currently, LUO FD callbacks are the only ones I need. I think we are
fine for now without PCI callbacks. I will have better clarity next
week but for now I am only using LUO FD callbacks.

