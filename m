Return-Path: <linux-pci+bounces-4675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C9A8768A5
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7038A1F21829
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEC715C8;
	Fri,  8 Mar 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuLX91ne"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B0291E;
	Fri,  8 Mar 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915875; cv=none; b=M+1wE/a5xNnyoRxrUem/6s/orq0aEtoZdEtGlqGVaYHeJDnzSinZQTwpSZeMcNsHyO/2AJ2UFFIv0nqn2fPS0YDziQhoC0APR17ws3qq+7U3+bBzK610Cd5E0JF7NWaHhMVNNBfLd+HEGszopcfLJ4jjyLWlC6R+2QSnWqc5Xf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915875; c=relaxed/simple;
	bh=KL8RCkcWqSd8XgfOapZoaXrPGEaLE1ze7TfYfS7DQPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAGputNROJ0yoO8M5MN/ieV1su8XoIlzfQOfzXMXQp76LNWvZA6QUsGKgouypu1IUmXuyACwViePShib0C/OdDoXptCjv1m+AYnO9hEyFHConAmw+fziC5cGtPTgzKPL3zA1P+LJS2NORknvnixk7sYgfquQq1IAhjgX9hg2+YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuLX91ne; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1376338f8f.0;
        Fri, 08 Mar 2024 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709915872; x=1710520672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JesRgTUuNt1xE/krs+/X0XneE8maUM05vwUraJuO3Y=;
        b=YuLX91neOv/LFF/E+F8sH6i4hWRQfivyCnyPY6g/k8CS2hf4Q8FLsdfyoK3nxIIPp7
         2rF1J9GJoQXU/KEZyVyobgN4l/UkADCUgHgkiuQKSBsn45HmEF60Jk4QpJdnkP0gPrP/
         7i/Mqi0NvfYDhGvtP3rBqK7s41EKrmovnz9HE3x+42aO+IcBqHAPJLDSG0fK52UaPfJw
         BU3Wfpmrrvzj0FXa9ZlVlXyOAc0NDgv76JRoshZn4Uu9Aj0qAPsB/LIV+gaSdzBl0a/X
         pJEjEbQHEa40C3rbbtCcWMlaph7tiFi8ot1QHHukJl1JwVRls2lu5gbwA4EVCMwu1FlF
         m82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915872; x=1710520672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JesRgTUuNt1xE/krs+/X0XneE8maUM05vwUraJuO3Y=;
        b=EZMSlcQSMs51kAKwmp1AJDw0+h1TNkOQ316znHgLcdwlYV48I4TMDkBsbdJ8BiTUHI
         AebVYqKILfwhYlp7h9tLw/ShVDmjTnR7kLq90cunKIGVxoNtcXSpiBD/M1p5qaj6uUXf
         hR0QlNvtZOS9Eb2dfxstPpQ2BXGLaXdncqF+OMT1Qn8ZAokEcbc8WcmkqpyxetpL5UPS
         92tpykd4y1UvmDdkOvX/u60lY8zk67C11h87S4XNt9pEqXz9C7JxiZF4XVEOHYVVIvfG
         Dk69n1wWaNG3aPWBmlwCCR1rf3Ak+xKGsGKmGbAj08XDb0fd2ZRiw0QjRFS9zjtRNjgg
         rXxA==
X-Forwarded-Encrypted: i=1; AJvYcCVonKd/OtkJa1rE7+XIUj1en7quH6U31eInoT1pxXkAnD/8yD1puAtK8cQDUNvkQU1TGxAEkKKHjRFDuvQb9A+K9n/zgLomkTYsqVgiKNx8CqsshbAfuIM/1ImVdHdL
X-Gm-Message-State: AOJu0Yz10/F/+1JdTgF9O9du1DwpxYxwVEHpF3oqJN4rGBTeEBhDjp3d
	+yqqmk1c0CQHbuiosDDgkQeWKCbCUAKeFS9sTZss5wVYry7j40SD4giKV9KAgfSt4Ts//6DrRYg
	61YQlTf9sX+qrkVFipt2ibnw37BI=
X-Google-Smtp-Source: AGHT+IFXA8k9e8qbckQo0rY/uY6uy5njvrqYYq3CiI0AMi4h+wRSUVu4NMbB2uyXdDPqPcwFmb2tq340tNJ8GMAHSog=
X-Received: by 2002:adf:b1d8:0:b0:33e:12a4:8619 with SMTP id
 r24-20020adfb1d8000000b0033e12a48619mr760550wra.24.1709915871988; Fri, 08 Mar
 2024 08:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
 <20240308161331.GA682898@bhelgaas>
In-Reply-To: <20240308161331.GA682898@bhelgaas>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 08:37:40 -0800
Message-ID: <CAADnVQJ=_HwPo=Cnemwd095dcsLXKtp=VVBB4bG9_ovfwG8bWw@mail.gmail.com>
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:13=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Mar 07, 2024 at 07:49:16PM -0800, Alexei Starovoitov wrote:
> > Ok. I think I figured it out.
> > Please try the attached patch.
>
> > PCI address range is managed independently from vmalloc range.
>
> This suggests that the PCI maintainers should be aware of something,
> but I don't know what this means.  Can you elaborate on what PCI
> address range management this is, e.g., what functions allocate from
> it?  Or how PCI should have been able to avoid this issue?

I believe Chritoph's long term plan for ioremap_page_range()
is to be used for ranges _within_ vmalloc range only.
The vmalloc ranges are allocated by get_vm_area().
In PCI you don't use vmalloc address range.
PCI manages its own PCI_IOBASE, IO_SPACE_LIMIT address range
independently from vmalloc range and they do not overlap.
Hence this proposed patch.

