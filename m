Return-Path: <linux-pci+bounces-37271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D15BADFC3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C791926AC9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9493093B2;
	Tue, 30 Sep 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="V/kvH7od"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354553090D2
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247857; cv=none; b=UjNIcz9CfA7enFGwY781iiaLwt+0o5yNnvDt4gyzHrSdNVzhM9g9Sj6X9fP7TNDNrWFQIi/+In2OTYiYKPw2hrUu9RFw3MRfPTqN9mlQV3V8hZGEPgutYvq8dJejlglQoiEPdLFEVUHkF07b4GiSzH30xJxCQtVreTz8vOd3Zkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247857; c=relaxed/simple;
	bh=B6IblnG/MuGwdljxYSZ5Hog2wlH0TIZoRDin8Y01b1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEnwKizkLkBVJmZFx8HwSb99VvxyXfzdQWmTgH8HIIud7KG0Z/VO4fly3ong40FbPb9JXW+sPWZ/U4DHn3iaGv83b/sZ0YEDvAzk+JwbtqBaNPsKxHQQJMKTf0E5bkRUdWDHMoZoGUB/83d3cT4A37RfodPaLC9UxtsWDAlcRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=V/kvH7od; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-816ac9f9507so1197285a.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759247855; x=1759852655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHJepidzCbOi7utNTLa4sXRDkqkBu/gMK+/6xNAn25I=;
        b=V/kvH7odyEI/dGqdGP3TFp8AT4QPlPDhz2kaiwZ+gvXh0ZuOaEt5kHCDhp/KBQC+5S
         I+RsIfd9eJGE5SQcFSnkfjdDdrIoCx7kBheLoLvIaQpiZQowDv2HQqM5Tg9QWSDQ9dA4
         PtQZ/XwsjtZIwUOBBH9HvQl2g6flor4BRYK/pGp5/q2SwVZ55/v3pNZ1oAGrvXMniG01
         f0J+vR0NDrb/XKuEY4ZKE7a0mznEy8oNJfshMaw5n8O8VUATeHTDkkZPKy6WMfn8xe83
         1vNxOfjE+2WEG+yqUp8sWh6BYbu+c1Qmu19SeEzRARMxuGnOTf7PjMvgj2AwMcSsKWn6
         fEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247855; x=1759852655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHJepidzCbOi7utNTLa4sXRDkqkBu/gMK+/6xNAn25I=;
        b=mABh/EI3IybRhFfOGCC8aC9o3raaz1WdbJwNzKj2sWh3NG6imDwYhsRmUTNQwQ7mfc
         hLMiqa1XeCFKAHBUyC038oS0QhCgN36PE7DF4bExyyiILQsNk5eXfkCR1tvY7zXvzH+m
         piW6WHndsuAwLzynYCVhJKRb3gQTV/I7rtPZxTLQxcp1lMQi55CzohbLTlffXOAEAUCy
         XP1+Sw/C+5OHm4bciMMII5yddnZPJ7mqXrjnHssIizOK7siObrrufvlCM91mqI7CZ2S+
         zRFCp3PG4vMOcP/hQXNeNh6I5mXRhLdeTAG1twcC9BLkMEvhhvH7hEmCjeJvL/B6E8RZ
         sV6w==
X-Forwarded-Encrypted: i=1; AJvYcCWi4YoshGO/oeJAfr0ldYojJ+NLMEsfb/gVw/1JOC0naYiAlwM5svPLtrpWt0lPWvoypWNOF6tFCgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzufBmChD7HGY5cy03wm1l7X6V+3jxQhvXqmbvH7bGrS0obmww/
	wQHhTi143QtpkgWvjjjoNLMV+opw7mRZiqJCPSRGWZpjG0TSaUuknMSG3e/iiRp/JTy3abuGtoK
	S8PbPDRPwJ/7oITXsKQa5HX0QeaghNzb+3oEw3nPY6A==
X-Gm-Gg: ASbGnctzyzZxE/Ha6zCIJcS0ccxjMOSPJ9DwEcnzEV7J/a51skrfLrq3l8pkXmT1zd7
	JTYDYhA1/94PzgCAsYh9JpnjZeFA4fod9BuAlv890VzXoTKggbSF9p16MBIfwclM6OalJSBKa7k
	JYgaJptB1VG2blSclIDBHl214tAzRGNL8rlAcklw2ec6TbNupE4nSq5Af0QLqujqCG7teraVISX
	qTmzf47CY7tzyGC+BNuZXnEy8fj
X-Google-Smtp-Source: AGHT+IE7WCqMW1fSLIrerjKiAvUKyXXisIfzM7mki8QeLnI8zBm3PcXEhU/qnT9KNwTUSb+prxtGZqv5NgHyFA8q4H4=
X-Received: by 2002:a05:620a:17a7:b0:7e8:8086:cb83 with SMTP id
 af79cd13be357-86ee0f481bdmr792664285a.28.1759247854941; Tue, 30 Sep 2025
 08:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh> <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
 <2025093052-resupply-unmixable-e9bb@gregkh>
In-Reply-To: <2025093052-resupply-unmixable-e9bb@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 11:56:58 -0400
X-Gm-Features: AS18NWDk81gPmO8jdYOvQy6qk9PYN6n2gt1XQ1-52Coxf1yRAsL01O0lrYTm39w
Message-ID: <CA+CK2bCBFZDsaEywbfCzDJrH3oXyMmSffV-x7bOs8qC7NT7nAg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > A driver that preserves state across a reboot already has an implicit
> > contract with its future self about that data's format. The GUID
> > simply makes that contract explicit and machine-checkable. It does not
> > have to be GUID, but nevertheless there has to be a specific contract.
>
> So how are you going to "version" these GUID?  I see you use "schema Vx"

Driver developer who changes a driver to support live-update.

> above, but how is that really going to work in the end?  Lots of data
> structures change underneath the base driver that it knows nothing
> about, not to mention basic things like compiler flags and the like
> (think about how we have changed things for spectre issues over the
> years...)

We are working on versioning protocol, the GUID I am suggesting is not
to protect "struct" coherency, but just to identify which driver to
bind to which device compatability.

>
> And when can you delete an old "schema"?  This feels like you are
> forcing future developers to maintain things "for forever"...

This won't be an issue because of how live update support is planned.
The support model will be phased and limited:

Initially, and for a while there will be no stability guarantees
between different kernel versions.
Eventually, we will support specific, narrow upgrade paths (e.g.,
minor-to-minor, or stable-A to stable-A+1).
Downgrades and arbitrary version jumps ("any-to-any") will not be
supported upstream. Since we only ever need to handle a well-defined
forward path, the code for old, irrelevant schemas can always be
removed. There is no "forever".

Pasha

