Return-Path: <linux-pci+bounces-21326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FDBA3334B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A94E3A5CB3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9684253F0A;
	Wed, 12 Feb 2025 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6bsCeYg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE2209F53
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402444; cv=none; b=KL8kGtWtuBUis++WuuOLAnjqmAzXJigSOInDnNon4Wgeoup7SbD3DQxdWaddjhLKUQV9h99JNuQaQps8e7D3tMx+S3S3cNqGJoC4qadbEhJ0Fx5FwCCcRLLovP3RuCUWtsIvPder1J99qsmGStmX5VLpvLCy7NI+JTanhkjn1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402444; c=relaxed/simple;
	bh=QapRnGrAaKxszsVuUBUEG/isw4uxYOKD/1H+q1VL74c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rilJSN62wTLerDGPj+oBOA9NQDd9b4TSz3UHrSgK0J/qsxva94h+Y+n1dZES3ZU1HSEICm+C243gcPftUK0zZF+ijcXwKRh+Vp2EBs56YZpJs1TqwBAByLhXKouZWSP1jL7h9DhMQCBWTuEG28hStUq32Xh+uOxH2APrUowijZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y6bsCeYg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso55541066b.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739402441; x=1740007241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QapRnGrAaKxszsVuUBUEG/isw4uxYOKD/1H+q1VL74c=;
        b=Y6bsCeYgXlDLs7QKFh4dyTI795BUyF39XXNJUJqo6u8Kwbi1JY4z4SiEUZ3hjM++tr
         GApilw2ERiukf0QgWKU3WBUg1PMTw7xl/twS6WJ0O3JU3TFpaMpQJobKIdXy1pQCXCqK
         P7KX2bBfQaCrqbJSp771/kwb9JWOrEV2UrwmCTYy9xE0qaxywq1qpG3BnN+muHBk8957
         4KPXR9J76CR++ALhIbFUl8tk+6HxR2/ojlgVKcDOQWoXA2tbofYvP21fyHdWsr1R5HHh
         3y2dE/qSqTsHLzXAt87zwKTAUycdh58l6BHYfoGPsfBy1PVbfr5HqovrK+N8Cc4s/xtu
         UV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402441; x=1740007241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QapRnGrAaKxszsVuUBUEG/isw4uxYOKD/1H+q1VL74c=;
        b=NNpyYpmbHHguGYlYfrl37SIlIiDfNBL7C7OlJnNe+LDb2WCNqKvFBHC84LK0M05PIY
         q0DYAPMrXaX96kyyw/Jx0m5e3ZDF4jCujtCjhImgTIALrBY9UN2m3tqvgGmg/AN1h5fz
         2t+6x8LvNx1KkaPTmV6587ap/Eu6o4H5aYN6ihehu+gnzliIf+zpsUUVekUQIrQA9YP4
         jbbhGC+5oc+9fXRvp/ztS0HEpp8CGYuc8eFQiPzXrY/4jiZKWsV4f1evJdP0cflw/fZg
         muQfRW/9MoTDm92vsOo1ipeQM6juEzSL3G10T7NdlfKivmHG1ZIC6kiI1DSx25RdilaS
         YfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYgY4WumLNf7isDzEhqZhMIFShy7yUTSssK/RyrApuwHuptLpYO8zHxizhD/QRaKaddwfufCUujfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx89xmM34cDTmM3BnPXM/2BLvGdwgni0qD9aPSgjLl1BBim4Dtu
	IC0/ap32V1Wg6IdG6G9Wg3gnyuDnX58qOdr0ycOZOEr7quu6nmt+H84SLUVMVi4rFkDwHNv+ntJ
	D9BOihm0ljINs8ZukEnQwUdVjmiDM5Y79/cPi
X-Gm-Gg: ASbGncvUwq88dWkvKuGvqUxOxL+5VyRUizzqwuDqruGylHSZ1OBwWY4vnkI6CXdCip5
	3ELk6/aavhMmek4aIwTffFgWEl/hhzwuJBP9ioOv501wRhP7XxotO/CksH455iUchY3pS/REjQw
	rU+3rlq5sYQIMGoeKgqkHiuc8WKL8=
X-Google-Smtp-Source: AGHT+IFYqGC9ubpe3sb/19hskGk7rQ4sqMnHYTILuR+/9ndIvEw+EcGmTfL8cu0DH6O9+CA6MIz/C/5QYSf7edyWmrg=
X-Received: by 2002:a17:907:3d8e:b0:ab7:7c58:7bd0 with SMTP id
 a640c23a62f3a-aba4eb88d83mr110714466b.10.1739402441336; Wed, 12 Feb 2025
 15:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-2-pandoh@google.com>
 <696e0a5c-5d5d-4a58-b00e-7c678290713e@linux.intel.com>
In-Reply-To: <696e0a5c-5d5d-4a58-b00e-7c678290713e@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 12 Feb 2025 15:20:30 -0800
X-Gm-Features: AWEUYZnTEzfiuc_Gi50ZgIhsDt5etGHV5dR8c_GIslfNGQD-N4fVJoOs1UXVkTU
Message-ID: <CAMC_AXX3pN5huHCzMPaSNf6Jgfd2ayMTLeKMhU7d2h2zodHuoQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 8:15=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Any issue with logging when no source device is found in device
> hierarchy?

When there is no source device, an error is logged (pci_info()) with
the same BDF info that is found in aer_print_port_info() (i.e. from
aer_error_info). Will add it to v2 commit message to be more explicit.

> Please remove time stamp from dmesg log.

Ack.

Thanks,
Jon

