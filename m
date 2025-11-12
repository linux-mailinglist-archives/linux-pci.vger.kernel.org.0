Return-Path: <linux-pci+bounces-40974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E2C517C4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E15F3AE548
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413E32FFF94;
	Wed, 12 Nov 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsF0FxMS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CF2FFF81
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940257; cv=none; b=q3UknGo8CECTGSraMeqOX2NqFjjeeSM3VgktS4ePU4aGftdC//t4ssdO0/c2iWKJOIa/WDSZBZpOf/qY1AIIEjxnECr7KTKgAb1vfFFInY9/E35y026EXseNj17NdtzZKlhiwQcWbgVqipUbCS++VnxaA8cQxTeG1obLq8hMyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940257; c=relaxed/simple;
	bh=hCDeVTqFeb8OCPymlEUvRNJIVTTjvVc1/ClAQBXXnOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZFMQjVtWbRx7y30CPo1dRLcO0WGAsy9VtAhmJdPhVoTKTxYVXu3ZLP8lLpVMcsKOS40I7lO/lRy0kEOKtrXPa3VnW2iId9C7jMGS3HRpAg/smx4+TNXyC+EbquTlGlJizJTGIhkWm0KCWegNZn3vvR30Qx973GrYbJ4glKhb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsF0FxMS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b67cd5d88ddso87550a12.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 01:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762940255; x=1763545055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfWmqteduDoVLqj6JdhBgBiH8a4Ayud5Tb7Bt0CJ/gA=;
        b=WsF0FxMS8mzXEeyWRR7r4qLWRZO3QGbSO39+9raslSbMBDM7uF3e3vgkocLsjZ278a
         BYAU8rBorVNKWsZHM3+I44i1OurmXTuWZ0LwgLNUXYW883h2R69L3GXXqe8g1lOiCJxB
         kyjv0K7P0ra9GSOpHWaJGGTHToKrOraFxDKibnMZm7LDj+0scKTDB/M0GKb292nJ3oYR
         meLuSl/C+Gt+QB7Xz2gharKc/e99nCXIyNXzO6K/lpA7dUMO66xjnCREecQTSquqa7pM
         xBfLuDoHfiwltF6xrNz8k5/hfD19IXO5+KB6pyMaq4ncy45n64VZipbXSl/YS0/UEbxQ
         qQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940255; x=1763545055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VfWmqteduDoVLqj6JdhBgBiH8a4Ayud5Tb7Bt0CJ/gA=;
        b=jU95UuJrIrxrD+yp4l3OwsZeCCc5sQOihsQFWvySY/qumEO4cpQJXPgMddnkuaYdD6
         hzvYXF+Lnt4BjzX9PbRiFL2GuSCLCd+zyA3Kgn37fz2OvTDoLbDb6EMVuwBdbMu/j0zL
         SFp5htD+0XGvPW920lGQwUUyqFokHVH/7zK12BjbshCGfl/k5THlETsLVNRqJoC4zumV
         Ncj5qvwGZwG26ZhVEpF6JGeyP1QgrVnwL1XfV1bwpE3iY9tmX6E9v0h8MKv11Y9zJLA+
         cR9xCoW0w3Z6B725Nep8TrSK+kYyfnJD0vYTR0k23PrRqOg0ElJ7kGsHRxEuokC3J5+d
         ussQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS+qE4r8XW3YaVxoC3ya9lVRKIw9/OTnNH3QVMdpI+zrsAWYXjtZjlKt6ElHQSAkWLcOZkbHVSn+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KH5JHFdMbSArBN36B9TrNTYHt+UwSiqt3s1NhUBjo7RuEpKc
	6sriGIqe1Y3gYTv8GEQxbJiTiPNBDgty6q771T0D/0DFNpD3lIvrh4n7EcYiCJZLSMnVanqkdRe
	ev8urw34Wfp1rsk7rIzSEUIocp/l5unc=
X-Gm-Gg: ASbGnct1nTZLHxBiBeaUyozEekGFu3OfMyk7wCffhZatKn0qud4dMkanx/We2AM4+Sn
	6ZJ3kn6SJO6W8zDPXbWyS4lNyCbfd0k2VGJ+R+dzKlw3w8FMamF/PXvT0jVQ1JX0EkExwysB9bh
	YJQHRLqp7A7Q9a+CxuznYbWPurjI/nIS+baO6oKPYChdS0QHzw7JE0dr0FQiAd9a0r6Pli/lLA9
	GXhWRN07E9RDcPLwymQLYof05aiTTEnRgOqkl2lCNcxb9aSU50uPFAVEvOskRVJYFrlRHiGLPv/
	+HJ62dDlCLm74g+LfjYrmpSoo4H8p+66TyGpLrccVYJY45vBmcYAZvtRV9QnRZpCA2fHH8/Kmf5
	O5Ro=
X-Google-Smtp-Source: AGHT+IF7dXQUMFsuDu6yVFEy1qQhkvdBAqpDcIJQlWtpA21Ok2PTF3w0o0PHF/4blQHATl8xPBVAytdXYF1ksZ+cx+0=
X-Received: by 2002:a17:902:d507:b0:295:3f35:a31b with SMTP id
 d9443c01a7336-2984ec8c0d5mr19207665ad.0.1762940255046; Wed, 12 Nov 2025
 01:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101214629.10718-1-mt@markoturk.info> <aRRJPZVkCv2i7kt2@vps.markoturk.info>
In-Reply-To: <aRRJPZVkCv2i7kt2@vps.markoturk.info>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 10:37:22 +0100
X-Gm-Features: AWmQ_bmCvbaIgHZdY2OvUnghnEILgb9lSGGzpn6r-4k_0J9xQP5iYx7rCXgAVnM
Message-ID: <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Marko Turk <mt@markoturk.info>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 9:47=E2=80=AFAM Marko Turk <mt@markoturk.info> wrot=
e:
>
> On Sat, Nov 01, 2025 at 10:46:54PM +0100, Marko Turk wrote:
> > QEMU PCI test device specifies all registers as little endian. OFFSET
> > register is converted properly, but the COUNT register is not.
> >
> > Apply the same conversion to the COUNT register also.
> >
> > Signed-off-by: Marko Turk <mt@markoturk.info>
> > Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")
>
> Can someone take a look?

Your message was in my spam folder -- that may be affecting who saw it.

From https://www.qemu.org/docs/master/specs/pci-testdev.html:

    "All registers are little endian."

So this seems right. A couple tags:

Cc: stable@vger.kernel.org
Link: https://www.qemu.org/docs/master/specs/pci-testdev.html

Cc'ing Dirk, since he tested the sample originally.

Thanks!

Cheers,
Miguel

