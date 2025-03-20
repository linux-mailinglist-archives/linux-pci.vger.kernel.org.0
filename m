Return-Path: <linux-pci+bounces-24209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18137A6A152
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8930416C9CE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032F209F4E;
	Thu, 20 Mar 2025 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eH/HloJt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DF20AF69
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459261; cv=none; b=XXGvIDOtCaRd4rOGSexuI2BKItmLqK1bLVdhlcCUw4afT75uiiLQduFU5E1CRY8tQXos83hLsxKw68lfcZpmq35WDAh9tu8icgQHs9gUt7USBZKwwrsMTE/qOTuuPITOAYWUX5b8YaGvYmg+jh/SNDX2Vl1x3VjWnnm9+gIBnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459261; c=relaxed/simple;
	bh=jxZOVuVb9sxgsOF5RUnLLYoc4VniegvWGipaANPXkow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ndi4Flq1L3+/evKA2d7HXa+poXLZ346FYG8cc0IiHEkjRtU0CXuk9/NE6lItd2FiHCGCqoslPwrmFqH4HpYJkBoy+DTkLIbyhf8hzLlnYWRtWMTVJ56ryRh2L4ZKkyl0LfCHND+Fq5fbJ/KXPySb2nUHgScsYyaW3mFE5F4MKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eH/HloJt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so822920a12.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459258; x=1743064058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ6IVIkjUx7eAWqay3D0P/3Oipt6+7jTICybzYCP/FU=;
        b=eH/HloJtJuFSFSI31bZ41J6i17nu1Y6R4nSXNj6JGNn4KNhLYuCOslX71QShGsgQN3
         JmabfYt9WsBScOVBPT+JdNzxfyrwDBO6hBv4D4I6RiXoYLDUdxbvkNy3OIVxwR4SL5HR
         pPh2cyX4D3mCKtRDYd7yscT7Fcduah9w6lWFy0bZzSb3NIh6IjBFojlprjpeKiifqrAh
         gwp+s60UcPfNxuEF9tjNJ1pUIcbsxoSkdBu7jWMQWvr46Iv7tkIceD/CKSVbpgU8veNC
         /w9Og73vgJjlXb7jndnU2+ERooS0N6OCHQT0Xm84gxfJkAyMAGYO+EAK0XSFbbouRB6J
         H7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459258; x=1743064058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ6IVIkjUx7eAWqay3D0P/3Oipt6+7jTICybzYCP/FU=;
        b=dAVfh0DFiSzXZFDW6XYCmZRqx8PjHJyxnGSz3kKxFXSHZ7XB2ZUNM0kumCTOdRJiIC
         BAmReHu5f4ihIUdwLFcujROIfPaf7B2RKWPpuCZ+YB2la8/bf1EeyxBooyzQtODNqOV3
         QIHynsGlVJIQSkKDV/tK0QfrcayB92UQZWRu0Zn535WRtxb6eGchP+olCShL9VQkwvOT
         T/3NweOKH0RASqgFtcmfn24H1H/996m6/AoeIcqncMOy9Efu14ZG7z72u+AQ/R8zkkrf
         9+CbiLnLP0QCzV5N6oK8blawqI/EiJF9Kxyur68D+a04L1rUkAU6NlAdpg7O2Vj3zcXM
         G84g==
X-Forwarded-Encrypted: i=1; AJvYcCWxLElwDYOmo1aOxCmFyiPR0J2+dFvS87taGZ9+L4VR83XrOMzEsbUFKYaGd8VATNiYtWjn65+NlOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5NtpG9NcaS1zjDszjwUvXWiktWFljDHh0CElMA994Ekc9Xwl
	3695Q+OmQ88z9x98XwfBVK53Qo14BxDstekmGWVJby0KAJIHPi3ADZBJ/uQ5R5QR2CndUiwGppE
	zPA2u5nWrp1bMMg2zkS7C0eFhB8xli+RAkI9D
X-Gm-Gg: ASbGncv21LSSGEFT4aOo3NwTkIqMuf+aZAyHQsIXpIdFdVp+L+DAdg1A8o7mmRDPfeG
	lzqFdHDMfRv9/koTARrKDTsv6G0vqXmEfFtHOX9PBDSOZKDBOwemk+bNwNUXc29MqH9C2FhsFLh
	mLULAe47oPi3ZbhKPkHFGFY/c=
X-Google-Smtp-Source: AGHT+IFMbkFDbTMPHj2IbMknCz2dG5tae2BTwuM3kaLtQJHt2ZjRLjkxYNt/c9tLTGrCkzqnF29npAeO/i93ITBwg9A=
X-Received: by 2002:a05:6402:40c9:b0:5e0:9959:83cd with SMTP id
 4fb4d7f45d1cf-5eb80f705f6mr5474210a12.21.1742459258465; Thu, 20 Mar 2025
 01:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319084050.366718-6-pandoh@google.com> <20250319184702.GA1051253@bhelgaas>
In-Reply-To: <20250319184702.GA1051253@bhelgaas>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 01:27:27 -0700
X-Gm-Features: AQ5f1JqjFZy1RWJovGVT9pPqngucA1xWom-fMGxi5DZYYbhCT4vNLo8nmn_mNvI
Message-ID: <CAMC_AXXmkGPexqfKdQOND2i9B7bU+7HZ57EP-uh4WwFNM-jOGg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] PCI/AER: Introduce ratelimit for error logs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 11:47=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>   - I think the ratelimit lookup and __ratelimit() call should be
>     together since there's no need for trace_aer_event() to be in the
>     middle.
>
>   - The lookup and __ratelimit() calls are repeated and are probably
>     worth factoring out into something like this:
>
>       static int aer_ratelimit(struct pci_dev *dev, unsigned int severity=
)

Changed in v4.

>   - Previously we *always* called trace_aer_event(), but now we don't
>     in the !info->status case.  Maybe an unintentional change?  I
>     think we should call trace_aer_event() always, or change that in a
>     separate patch if we need to.  This would always have been simpler
>     if trace_aer_event() had been the very first thing in the
>     function.

Good catch. That is an unintentional bug. trace_aer_event() should
always be called. Moved it to the first thing in aer_print_error() in
v4 (same patch as I wasn't sure what justification to put for a
separate commit message other than precursor for ratelimit).

>
>   - The !info->status case message is not rate-limited.  Seems like
>     maybe it should be?

Changed in v4.

Thanks,
Jon

