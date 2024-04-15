Return-Path: <linux-pci+bounces-6254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F28F8A562C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142D41F23019
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43676C76;
	Mon, 15 Apr 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGfC6N3S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E26996E;
	Mon, 15 Apr 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194336; cv=none; b=CCs0Mq46teEBz3pmbQaumUiFM2RFKqRjCDbx6rE94kNq5lFGg3Rx1oCh+xxMAT46PKilpCD1/yEtKYBH9Yi/q3/XqeDm246LavSPuF+4jy8B+kFlxFmmT43ICKqCwqDGJMQ7CLyDSco0v1kHotbXh4zP9/LTlIGqX2dHBnk7KVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194336; c=relaxed/simple;
	bh=agH1QFbrpHLd4P7Yhw6r5jXXFiQAUi7FPPp4+GhP0bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpRJS4A8BsyFtnKxbeOck/eHYnxrxuVN7qnxZ+Tm/BFOfBfJLXIonHJ70aHwVRRb4wrxCuiW5peKrZA/Tx8Hjg0+ifD9mWS1DgyuwvlgZdN9jYztNNcp18zfNEEtt613qgUjHtuiY7kSx//QdfQJyHt95GeZYkUbgH1lvvddEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGfC6N3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E78C4AF0C;
	Mon, 15 Apr 2024 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713194336;
	bh=agH1QFbrpHLd4P7Yhw6r5jXXFiQAUi7FPPp4+GhP0bY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QGfC6N3SYFSbnGqKjM/F/NrHKVL3+hcf4L6CY4wRfCDmQ28r2aIc7mmfGHoFP/+P1
	 EkKEUdRxqedskTPuJDR1oHw3lN0h9nuYXg39yxGKEkjutzP8SBT3C9VJ17PJhRkteG
	 kkGTQjLvCujpe4zTC9Fv61NjEIfQ/3xZ1qe2KX5p2Ku1yIdNUGJNezZcZgBgkwyINg
	 tI4UOnZhTOSJr/ubsejRZkRLxFz62H90aqgrliZYqOfkLjNhj4T2g/ofKFbnQhVjm3
	 MZPkHTFmBt/fQ/r/7e1xFnheG66198vhBvw4KFJt+vT5S7h56b/YKYQ+LP82iXIfhI
	 87x1KZEA1E8hQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ea26ea8c4bso239643a34.0;
        Mon, 15 Apr 2024 08:18:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnUaOqkwCcdRCf/+tLNI9Zu+faAmfcu2RlA1/Ssi4gY4YVnwv1BvIJYr0H0n3iZl82+TWrVJyuHl7dflVNwilBu7miUTfM18vRvXeBkWZYSPb1W8n+Azpileq8Re8ifzi6PFCeFML/MKRBPsns4WJkTMNSefh5px5mg8O/xoo4zY/pLg==
X-Gm-Message-State: AOJu0YycqyZWL+u7AphJrnjn5LvtpIXkU+7R8YlBWDwTYRqbVcpVjBwg
	ttZbfVyxhGJtzFONTA16dmmNcNtM0BmYv8aeWXJwlwGQlrnUrVcSQDgq7ofFRNUSmrGb1yNf7oY
	ApDZkEp7ah8ebRhCbDnqFmOnnCF4=
X-Google-Smtp-Source: AGHT+IHNTzq4Yb0TKkeCmMYOKrAxQ+jbCXApmkiq1lJmh5rmpBwPeGhF5p/B9EzrmQ4sIfC+uclrpB01Ll6n/qIAs6g=
X-Received: by 2002:a05:6871:460a:b0:22e:d06b:5d8f with SMTP id
 nf10-20020a056871460a00b0022ed06b5d8fmr11682662oab.3.1713194335221; Mon, 15
 Apr 2024 08:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
 <CAJZ5v0j6Veze8xDFKTbVZ5=WAfmLdeJ8NXRnh9kwCZgyaDdgew@mail.gmail.com>
 <ZbiQ/tO/odnJCBD1@sunil-laptop> <CAJZ5v0gnH0uPEM0q9VzJOg2Z_7bOP9XdQbOttpRtnkLGej45Sw@mail.gmail.com>
 <Zh1DP8YnjPlie4+S@sunil-laptop>
In-Reply-To: <Zh1DP8YnjPlie4+S@sunil-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 17:18:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icHu1hv_DQDRFh54nD8gde8CfQUERAO=dyasnfp5qO-g@mail.gmail.com>
Message-ID: <CAJZ5v0icHu1hv_DQDRFh54nD8gde8CfQUERAO=dyasnfp5qO-g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] RISC-V: ACPI: Add external interrupt
 controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

[cut]

> >
> Hi Rafael,
>
> I found that _DEP is better than fw_devlink for ACPI since it works
> during scan itself. For ex: the way PCI host bridges are scanned in
> ACPI, PNP device handling. While some hacky solution could be done like
> I did in v3 (pnp_irq() changes), _DEP way seems much better.
>
> So, we decided to go with your suggested approach and defined namespace
> devices for PLIC and APLIC required to create dependency mechanism.
> However, there are concerns that every device will have to add _DEP now
> and whether it is intended for this use case. Also, actually the
> dependency is already available in the form of GSI number mapping.
> Hence, instead of explicit dependency, we would like to create implicit
> dependency. So, I will send RFC v4 series with those changes. Please
> help us with feedback. If you could provide quick high level go/no-go,
> that will help us a lot since we need to finalize the spec whether to
> mandate _DEP or not.
>
> I request you to provide some high level feedback in the RFC v4 I am
> going to send.

I will, thank you!

