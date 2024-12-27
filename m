Return-Path: <linux-pci+bounces-19077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CB59FD367
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 12:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6CC163964
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB31F1310;
	Fri, 27 Dec 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="OTvW66Sp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF4157485
	for <linux-pci@vger.kernel.org>; Fri, 27 Dec 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735297654; cv=none; b=Gh+9XvkiPLT/3EKmXOZe86/VMHhudxFp8vYUT6xsOSEcIr+q83VqT0HAn4BrgQ8tGLzhg2gq3zuauT+z5uNTpetCKJpE0P9roYyY5CN9FUB88C8m4j7A7WhHZaOuL8YJjX5CI79lZTp0ahST/1i4KsR2emZfr+EWMecS71dzUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735297654; c=relaxed/simple;
	bh=9xL37oGYYc2ulNYz2tTj5hnt/NWxhrHHVUNrdmRW0qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1LFtng3Lj3B4SiQJUwYCulpwwQ3rRm9wgSOHRAeVSX4/tn8tKU12EQHLnEytkxNY9UhtUseVk/ScoPX4ciS2Ky+nLZg3Tpfa4OeLA6/Y/t7c1mvolwGoitbbx8+SDaU4Njx7N8B8Cxx9C6SHa4aqLOOJpFGFBs5Gab5fEur69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=OTvW66Sp; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4aff5b3845eso2449883137.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Dec 2024 03:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1735297651; x=1735902451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xL37oGYYc2ulNYz2tTj5hnt/NWxhrHHVUNrdmRW0qk=;
        b=OTvW66SpJGzglaswvV97yNA+Lt2ZqqBAVidECL68s0T7N8+crxFhcpAoFF6hCBKPA/
         RuINrBbMaSzZQIdQkf0MSvaKpVtnv/U077kLtsKk/YKaTfPmCwuCXeC8mrGVhCKBEZuv
         xWMNvDC/aDf9LQtFW6vohUuoyfbitwaE02Qs6BE4tPH3z4frRR5CcXxXvgR/3aEUCDJM
         cv8VrC4ld5YvbaEsOCiltcwVJtnvjPMm8j6MPQbL/nnLeGFpp4nogDRqhA0ZGqUqqaBM
         jec6XfDEQYjmCjH0zYTapGWi8yxgbIbULz9fGNW6qR+6I0NOpWxeLoFWecSSe2RF0VjK
         8eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735297651; x=1735902451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xL37oGYYc2ulNYz2tTj5hnt/NWxhrHHVUNrdmRW0qk=;
        b=qLe4PbXmlKtUVl+UIJcL5Phmq6+l5zi0QOYWmbjVYfNtcRhs9kGYxKyKihHk+0ny+4
         5DA0+Q2Ibdrvp6NxCkSKKOF7Nd4+ZxuUPxO0DIG1LTLjiZ19emPteSK68NRU/90f8MIc
         raXemO01GFl5N/QaubbFru9EJ70PFzW1hPmxytE7/7prrirb9L87zvQUcUVMUD8Gm8ny
         EartnMrGUNXkX4obnrcRSb5voCbdwv7eYRnoLkrb5B/WJJLFhlIATIxftlTW2F3Wqw0n
         fXScSu7nQos5NdSnrmXxXHPueW3ysWNPzEFZ2fKVNMFVrW80mtZY0+1EplpQEFJBPUIs
         P8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVukaOquBTdGtAepGFor9eLX4FeyKeSe1FMhr5XGTv/AHU+tIjnZM2SmH0d53Y66zTOVoELkcgdnP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9OT/Tu2xIEyb+odVUVoQDoA3eRUSUDFxXElfgYP3eknNVRG0
	ExXK2MAeyMHYFz0mid0O2MzMRLaav3yWIPRkFHJxrMoBLX3wjJfUxlZSXsytI4QKpnXXv8r8t7H
	Z/imIYEvn90GUIx28DwHbcee1/BA6mJIpH1iXdQ==
X-Gm-Gg: ASbGncvDDfBfQQILgJlx205lXT8WK3739THc2wagZQa1BPA3M7H3azaOyCtunAQhb6j
	uxiokgOOYB+2NFvRCVEALWwK5OZBHEMukc1Me
X-Google-Smtp-Source: AGHT+IEKKk39eBf60/LxFYyrHqRojOWZz2AhcO0loBpUk0HmSOhqnqJ1WXM6r6CWgFYWi9vFQwXrIyt43EDNi6aux58=
X-Received: by 2002:a05:6102:3751:b0:4b2:73f7:5adf with SMTP id
 ada2fe7eead31-4b2cc351714mr21333421137.9.1735297651003; Fri, 27 Dec 2024
 03:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
In-Reply-To: <20241219164408.GA1454146@yaz-khff2.amd.com>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Fri, 27 Dec 2024 12:07:20 +0100
Message-ID: <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yazen, Borislav

Thank you for the elaborate reply.

> Things to try:
>
> * use the latest upstream kernel
>
> * add some debug printks to the paths you mention to see where they fail
>
> Looking at the relevant chapter in the PPR - 2.1.7 or 2.1.8 - that
> should still work.

As far as I can see the behavior should be the same with the latest upstrea=
m
kernel and the same configuration (see below).

> I expect you would want CONFIG_ACPI_MCFG and the "MCFG" table should be
> provided through ACPI.
>
> Can you please confirm if this config option is enabled, and that the
> system provides MCFG?
>

Neither CONFIG_ACPI_MCFG nor CONFIG_PCI_MMCONFIG were originally enabled
in my kernel, when I discovered this issue.

> My understanding, based on the above info, is that ACPI should be used.
> The direct register enablement is still possible for backwards
> compatibility, if needed.
>
> I think your observation proves a good point. The registers were moved
> starting in Zen. But this is not an issue on modern OSes since ACPI is
> used by default.

This is my understanding too. However, what is the desired behavior on
Zen if the CONFIG_ACPI_MCFG
and CONFIG_PCI_MMCONFIG are both disabled? ECS should not be possible
since the registers were
moved, right?
If that's the case then, at the very least, it would be great to have
a warning message.

> For your specific issue, I think we should determine if there is a
> configuration or a firmware problem.

To give a bit more context: I am porting the kernel which works on the
AMD Ryzen=E2=84=A2 Embedded V1000-based
device. On that system, it seems like the firmware doesn't disable IO
access to ECS (which is wrong), hence we
have never experienced this issue before. Now, the R2000-based
device's firmware disables IO access to ECS
(correctly) and that's when the issue starts to happen.

Thanks,
Ros

