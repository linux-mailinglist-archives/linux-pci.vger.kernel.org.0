Return-Path: <linux-pci+bounces-21322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7AA33343
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CF2188AFB6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9620011F;
	Wed, 12 Feb 2025 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="US1kSo8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAE1FF1D6
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402417; cv=none; b=GvTnn8kZ1DvSWcJs3O+KfV0DED59iTvSpLM8RHlxjGm5HR5Sie1K0Fp/d6l5unDgs1UfQBlQrHUfCo4cave2VeYx7T/AZtfBeB/xhB+LyReybqyHya7eOVDPKb7dHiyyx8i5H/KkSuEcFBOFJyXc3Mrz1fDoZYhvnkXlzcofvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402417; c=relaxed/simple;
	bh=YldA1BRIrqqV8e5LTgFZndKplhISMza32gQE7+gUJcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbDl/0SVHw88c3rB2cJI6Rh9VNMljuRfiYUNIEj1jDsmAZuIYMPYnQZj9YH9lNaUZQEeSuCENlNgevu6jj68Ci0dL5fQrcXTB4/ImCH5YljdFKE8+cqOY7b6liRPuXH1G78CHdZ87g1T53L2MRUEk3PNgbWXOeCeTGAvHHOd6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=US1kSo8T; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7f2b3d563so58090266b.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739402414; x=1740007214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YldA1BRIrqqV8e5LTgFZndKplhISMza32gQE7+gUJcA=;
        b=US1kSo8TPCTmNwHl7iV2CMF5IQCosxDU4Zix1uApj33nIihUU4vaYj6ztvwolArcfV
         p0CTEc1sDHgmPm2kuf7sCvSrxg+bVQsZjZFoVlPf4Xo88Iw1/FdSeYs+uXgTilx4RiJD
         RfNp5VutB+HTtqGCo0QgpBhAJzkMujVdOwJ5fBkiT49LtQTt58iC24QhJ8J8kjma3yQb
         oLxLWyAfl1WbN0DJ8hCANIcR/usmOlGjFZF0Aa9r0dOyxi8USUZqwLVi9s8EfEiuQ/A7
         Z+2vOsfp5MW5oNFS8penp1t7abCqLgJHHDJ/KVQoi+RtQw9IHtSLxeDW8F3XhkXtXzdx
         UOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402414; x=1740007214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YldA1BRIrqqV8e5LTgFZndKplhISMza32gQE7+gUJcA=;
        b=robXqQsZKyiPny8JI6H5qnP6TK7QjJEFlMqNUdk0tMGa/snZnBoKGLnd5XL15Eu+8+
         rtt5H1Xr0uJUwlhTvqo2oxulx9j1IiLBXamSEddl5igJZfheg87UOY+BZMaOnuu5VzLh
         G4i1BIhlNsf1Ar0tncPMhmAEgwNUyR/2DBWgG6rK+F49QznNcNw9MPlIUd3Lwb/BsL/n
         VWAAadLsAPeeI18RsgMPCq5FsNEqHjEiWBffpx+jTHL/Q/aSVvckSIdtKAYzbHpxxPeE
         csQAfUgDsdsJkKCeknG3sT1GFI34VlAEocHsgvGJIi68mAlYs/G9PW3o8aN++nFBNYg/
         Ennw==
X-Forwarded-Encrypted: i=1; AJvYcCVKQwmYydWQdyx1ONDej2fmNwEdGmSwSnLTgZT7HEE/ALVfXC5s5Loz45e0PEEvtv077d+gqgB3gYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGLxxW2MZ473mDEy7xB3woreXlPS++qkS4OPoDRZjQJ6MAWEhT
	hOt67KNfKOBslDsWIgb+lW4LSpiG+4Uv3+SrKAgjaZNHr4Kcf/rWmbSUsEzhI7j34zhT96VjXZ+
	LmMT21GQMJtCKbWDjs60VHTACcr8G0AEIxmik
X-Gm-Gg: ASbGncuUhqJZ00iU65GRLoxHG5KScceyTVbRj0QLOdllrc2LscY8trd1uVzvo6LpDCq
	Sa2GSK+seAxEwRl6pC8L/sCpBb8oAL1ZqB6z7Gui4IUPJiQLwLp3Lg80SFwm4i3O8CDMK+05bQL
	bLTTIwkqQQWx5/38ECA1z7GQbA8e8=
X-Google-Smtp-Source: AGHT+IH3NTP7MJqWrNdQn+EQ+W2j/bf3ud0oMlYHIdK13RiN0a5fIb/IYLDel8ZRlO1NVZocqn4gdQ5Jiq3cds5vvX4=
X-Received: by 2002:a17:907:7f86:b0:ab7:bcf1:264 with SMTP id
 a640c23a62f3a-aba4eb9b433mr88952166b.5.1739402414058; Wed, 12 Feb 2025
 15:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-3-pandoh@google.com>
 <a41ccd31-5d0f-40e2-863d-5a4548d98064@linux.intel.com>
In-Reply-To: <a41ccd31-5d0f-40e2-863d-5a4548d98064@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 12 Feb 2025 15:20:03 -0800
X-Gm-Features: AWEUYZlBlhX_t9XNo8hwEDqTf-ginzZ61FUkroFpT5-qFEWwYGRxQkkqDqhsgUA
Message-ID: <CAMC_AXVVNUV2+A39JA10=AAwd3Dexe0TnMYuNWhEQRcdXBf_HQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] PCI/AER: Move AER stat collection out of __aer_print_error
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 8:37=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Isn't pci_print_ear() internally calls __aer_print_error()? So the stat
> collection
> should work fine even now. Can you give more info on why you want to
> decouple here.

Sure. From a readability perspective, I think that it is better to not
have stat collection buried in print functions. This allows the print
functions to be side-effect free as well (more or less).

One of the outstanding items is to unify the {aer, pci)_print_error()
paths, which may alter where we do the stat collection. However, I
think the general idea stands.

Thanks,
Jon

