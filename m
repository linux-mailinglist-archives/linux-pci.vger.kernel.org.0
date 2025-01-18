Return-Path: <linux-pci+bounces-20090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30511A15AF6
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 02:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7F0188C0A5
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 01:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8B17C61;
	Sat, 18 Jan 2025 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRpNMRzg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50517548
	for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165492; cv=none; b=sUVCAvXHp/j6m4W9P045eOXuDTQB6xh0jmc9wqi11IsaSNoqDRK8D8u+5yVUQgJxVctL5fRwTMbEOcWBDIkXWcrSow3Mrh+3b0DMneBPed6mVtHAsOWLXaflV9vD9WD6Kos7+hi6DmGTl0uir7m/BB++T2m92eg2Ppv2kiCN59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165492; c=relaxed/simple;
	bh=7SOFGRAIgoDsNaQJM0HxvTUx+ax9KaKHr/RqsShnp9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIbOCyhoQnVnnj08In2Q9OPIejbKH+Pyl2Nl8JPtThgs6liCyQeidQN35bA3husaxpYLxc3n6KkweoTXOES69LkgH25/68/57JVEvm/margVBmOtgvzykqeIHhz1IHLm6l55Ay1J73TV0r2HX/igxfkRd48YAoDtesT+sR99340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRpNMRzg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso548116666b.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 17:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737165489; x=1737770289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AqK5PWDZ5qZg5raaBW9bm/fk8lexvPRX3BbaFhyngc=;
        b=FRpNMRzgqfKIPCB6mO/O8WTe/wlUwuKvEEWTDXaXEt42ODFWKaMjt5TOZ1c1aJYDlM
         puWUXG4hNxbD0ODyEHDATkwWYNaQT9ICQZHwZxPmUwFeBkDDoJbXFgKF94xlCvtMCcfq
         29LG6rlrsbo658Io/4vA33j1Wc+IMJuJxQ2K9NZgES0Xvm+qt/GF0rdTQB4fyMrPd9UQ
         zNs7VPNDUIBU8s42awwTOJdQVuP9PRZQtMdv1RYMq+8W7pxGGMoWcGPhK8/ey8ZEzxVb
         /Jj7ik+of0pOtsKU54Fje5Fn1kjiWBVmvHDBDiwJUGlzpxAN2cLqi3NPVCZDK4Ipgj45
         Xn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737165489; x=1737770289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AqK5PWDZ5qZg5raaBW9bm/fk8lexvPRX3BbaFhyngc=;
        b=sQ3XvWsOAFWU8IkNTCIhFFsnZzW4w5tuQgk2PeVog5qUPUZlG6OWjsOrKHMiI4B/vJ
         GZ2BfZPbvzY1sXMORltd83OiXKX6siWufIY7ftaZJWIkGEVCxSvo0FWHQzSKbGsnkAIr
         1u2AQv64H/PRfk0AhK426PyxcuErUVQdY+4CDqUi7632XCzLnY95mRHL/DoapNzo0YLR
         ut/Yb9uTW9A3aVKhjDnfPlrcbvUgJlKnRFV/VUDvlLVUqBNlDVxHj9/di+hYcnVOsqQ6
         YmKhx6PBbveAgaSjADy+XbJtX0xCR+eP/5ymolfLxZO8sX9R58RKnxM7aZksyNLTkPKu
         7UMA==
X-Forwarded-Encrypted: i=1; AJvYcCXJNXYw3Ckfa8MtbgyWA+GJdtLU8Fd2jY/zRYblhTfMYLd8TTn1uERBV5FKWJHnVeksO8pqxCfHEvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuXUirDuEOo8u+hWLrglwAA2jOyJmRu7kWl5zDIZBSHHFXB1B/
	51NvqFoObro1DId/cbCmEWUCqWZG/SaewyGokU7LpiyC+NIeMGLvsIr2q9DLg2Ugsqo/LaIYhi5
	Lif+HOku4dHoQkff95Pg7Cq3If1rBfIzxkni3oFaA7yN/OcNDbg==
X-Gm-Gg: ASbGncv8y1dhs2Sxqxlg8Wz3wxbIiNNWbfU/MgC/wVGmLNrkk+oqRAm+curQhnKhNEx
	3v4Kh+GBSFFSIvkTTT8aWf03DarG4pejVDBLzdTloe+LzI9n++Qz8ETBjphM7QZqVWpV293nshr
	h02VGplA==
X-Google-Smtp-Source: AGHT+IEylzsG7V/4W4ORPM/dO8qZbuFqOfHmootNbP6QXeFJyQIqes3nkbf5P0xbSOwwEfq3adhAYQKI+7AFsUlE1x4=
X-Received: by 2002:a17:907:1b05:b0:ab2:b936:f110 with SMTP id
 a640c23a62f3a-ab38b27a470mr410310966b.20.1737165488797; Fri, 17 Jan 2025
 17:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-2-pandoh@google.com>
 <f9ccc68c-216d-4cb5-9e0d-d2b49854f06c@oracle.com>
In-Reply-To: <f9ccc68c-216d-4cb5-9e0d-d2b49854f06c@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 17 Jan 2025 17:57:57 -0800
X-Gm-Features: AbW1kvYw_TVLlavuMQ9t11oUX64stdimx305OAFXZG7iXV8rS0SuctEV6HiaBKc
Message-ID: <CAMC_AXU2TtkO0cn3Yh4CVpaQC-D6eWo-yZmPKkLZJcAhnFA7iA@mail.gmail.com>
Subject: Re: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:27=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> On 15/01/2025 08:42, Jon Pan-Doh wrote:
> > aer_print_port_info():
> > [   21.596150] pcieport 0000:00:04.0: Correctable error message receive=
d
> > from 0000:01:00.0
>
> I agree that the bus, device and function info is repeated later, but
> isn't this line also about the fact we deal with one or multiple errors
> in a message? The question is how valuable this information, in itself, i=
s.

I think whether or not there are multiple errors can be gleaned from
__aer_print_error(). It prints out all fields of the status register
(as well as denotes the first error).

Thanks,
Jon

