Return-Path: <linux-pci+bounces-11525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641D94CAD4
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 08:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC69C1F22FF6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A216D32D;
	Fri,  9 Aug 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLcxYlAX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC417BA0;
	Fri,  9 Aug 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186629; cv=none; b=QfgLub+Ysk6EfLFt4mZq1YqjnV+ebsyv6qDKQdsksM3U1xylSFCSnugh83CjVOQhxC/nWaujfjTc3gjSHPrCHUwJY1PAFUAoGLq8fztVOeZ9HkE0AfqPgtOnTQy0LlniDRoiINK9rPYMuNfKJ1FY5gneRR16+tLngXiRhC6LgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186629; c=relaxed/simple;
	bh=4BYMtvrFkWft4VF3qOA2EAHmHrcZvd3X8JPCiCXIIT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijqStvhSXtEmZ/Yy0l43WkpFpvLnIHiONcdmAbb/6GiKW6Hi7BrTavYbe+WWpP5BFgdEd2ZACe6M+EWXxbWnVb4a3ojTSyw1iIR3Ooggq6BlFiC+XhImQnz9A5+dV0jLZ73SzPo0dLm4E08b2NAMIYohry/3LAkHoYR8O11wm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLcxYlAX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-69483a97848so17518817b3.2;
        Thu, 08 Aug 2024 23:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723186627; x=1723791427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jmfk+N8lnkJ31s/xtnjyZBy7/TmtAb8EqeBk3hSGJk=;
        b=PLcxYlAXfZt2wesloCumDDyIXpcB3iSvJEx4HwcKwO/tOIFldbwmP8+rLceLddCwcA
         gpwIXegHUGflRkMitZRBiAlj0jWDyQ4Z+HtnRn6E1Rb81K1liQ51D34HafP8EVNmhNG2
         DpWznotr0we9mfKLLe9iqKbedcjdFj5MrUil2InwS70COC7MpQcuszu2c2VgjfrhM4dm
         Tt1s/qmASYPss2f6cY0NEj9Kj9kpzCaL9w3YcOK4b9ot+DL17b++EYeR3j2NkHwjLVoe
         8aghriMk7oCdWdYkk9DPfNeUY0uPXpD8fX+nmX5HJpWRVUNc5NnMRAzXgSWn61vteTEB
         VYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723186627; x=1723791427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jmfk+N8lnkJ31s/xtnjyZBy7/TmtAb8EqeBk3hSGJk=;
        b=LNpUTwAStccYP95xQHBVH0Sywd2oAUb/q2t506slgUQ6dgesjscGumSToYvEukNF4J
         S1Mof2GfeoVLOFzQKDd2drfOVfZ5lITeSDC9dRTOJ9AifwQNni57Cb/Nt/Jv0aVl0+VI
         x6Hg2YAs6mJRAwJQjqixFq09k/0kfjC8Wr/3IlquoaTNo8DFSLjFluWBrCaHTWIIdb1l
         5JTkvBbPw8trtj9fsHxWFfZafNME0yTW0HN26SIBBPwq7imPl0oMrN+29iY6041fkxtE
         K9GYupfxWHIC9e1drlrM3nK2Y2Cjvq3mHTGOh113OfsvPYInPw35rktovhlccWWaT5Ca
         tvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi/o4mZkuEiIa4Kt1fWDCZULQ1XCOCxwzCq6Lnav/KFpmdgc+5avPMK53RRFJoRfsdjDLmzUthLfg4PSyJ45nOcllsZmbGwQIQ0VgtL4SiTOmwlZiAsU1O5ntb4YKkyrMIrdsO3VIh
X-Gm-Message-State: AOJu0Yz5u7l15eYVuoZKzH3Hw19Om/cKox2G+RicRz6DsRTDWliZg1pk
	vz86CcGwUO5ZnghSY0u4JqW1TckB4ivvzLpkqRC3D6mtY4GnQ7blgxIveea1YK6I98V5OPk8m+6
	9o/5xAJ0oOAgu6XRsAJHT+5T1p6s=
X-Google-Smtp-Source: AGHT+IFG0LtAc7u/qVux14X9MtoXA0Qoi0exqz+CEOrr2KAWwbKJzOlKJZFp+lxKjI43LLTKBfXKNEg8L7pIX8bsFQY=
X-Received: by 2002:a05:6902:983:b0:e0b:ba20:7f87 with SMTP id
 3f1490d57ef6-e0eb99807bamr761791276.25.1723186627120; Thu, 08 Aug 2024
 23:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806162756.607002-1-rick.wertenbroek@gmail.com> <20240806191541.GA73196@bhelgaas>
In-Reply-To: <20240806191541.GA73196@bhelgaas>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Fri, 9 Aug 2024 08:56:29 +0200
Message-ID: <CAAEEuhp2Cm3ujGB_C3Z7XwQh1whP9BcdT+WOT3w+sa-CK9p3fA@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Move DMA check into
 read/write/copy functions
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:15=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, Aug 06, 2024 at 06:27:54PM +0200, Rick Wertenbroek wrote:
> > The test for a DMA transfer was done in pci_epf_test_cmd_handler, which
> > if not supported would lead to the endpoint function just printing an
> > error message and waiting for further commands. This would leave the
>
> I guess it's the *test* that prints the error message?  Is this the
> "Cannot transfer data using DMA" message?

That is the error message, the error message is printed by the
endpoint function, on the endpoint device. On the host side, nothing
happens; the test program just hangs because the driver waits
indefinitely. With the change I proposed, the test program completes
the test and will display "NOT OKAY" as normal when a test fails.

>
> > host side PCI driver waiting for an interrupt because the call to
> > pci_epf_test_raise_irq is skipped. The host side driver
> > drivers/misc/pci_endpoint_test.c would hang indefinitely when sending
> > a transfer request with DMA if the endpoint does not support it.
> > This is because wait_for_completion() is used in the host side driver.
> >
> > Move the DMA check into the read/write/copy functions so that they
> > report a transfer (IO) error so that pci_epf_test_raise_irq() is
> > called when a transfer with DMA is requested, even if unsupported.
>
> Add "()" after function names above, as you did for
> pci_epf_test_raise_irq().

I will add this.

>
> > The host side driver will still report an error on transfer thanks
> > to the checksum, because no data was moved, but will not hang anymore
> > waiting for an interrupt that will never arrive.

Thanks.
Regards,
Rick

