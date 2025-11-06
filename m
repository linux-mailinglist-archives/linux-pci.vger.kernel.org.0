Return-Path: <linux-pci+bounces-40528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8148C3CE0A
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 18:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 176924E87C2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC934E759;
	Thu,  6 Nov 2025 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cT49hAf9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A662E542A
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450456; cv=none; b=YTl+si+e+z8q6Cyik0xemlwTtSitWtaDYH3zMx7kshENheh8B13vyRSIWu53hT1t6AIO7bIl9tSN0MgobGMNsUBamar909XTnfuWqhGm912HOwE6ShzrsGX1cn3UIGmGJPgGw4JJtHS9Xf2Zwu1Z9o9RFTzaIIGveVq6FGMxvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450456; c=relaxed/simple;
	bh=xC5jpduGSYvNExHOxUniHoKwme79jjzk7c0JLPQ4BHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqNG7DnxifpIV5AxGEBqaR5i2lM4Sj3Jj3f7hvZBGZr3ISquB+SvuAlr3Q8b/QteYmW92QbHUSvo3jcpOM1opr6HiSUJy8Nhb3ptgOWJ0j45si5fjo1WXsDcafcvKSBfTBdtIxtzs8skN+BoPm+FnRjnbwnLAvmEdqD9mHs0dhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cT49hAf9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so1589245a12.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 09:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762450450; x=1763055250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVFA7b5QNQKKgbY4Sgbk0fAZQJ8jQ8t0W8uUVANJyQ0=;
        b=cT49hAf9OsKChazElePsEHJdxLafiAKnO3sIjrgG2uAZ6zG0QHHn2dceIli1N6jOxY
         AhyqskzfAUTwWzLb6iEcjpvwCevjyaaGcVBEgTIyzVjDQCjOWYoKr5VsyUvf8TM7qPKk
         9SzeRIzoFqqy9jh1VM9mOsVLtBT16iObKdEJdqClkcGPMhE71Y4Rpi8vvmZe6T78F1A5
         Gwi21+LYrextTTugG+qIZkcfLlJQoNrUExdsDFOuF2HWiV6zeQn/tDZTDRcnTHFwfgLp
         vSnHhpjLG02FgdJYnWYDuzhNyVL/b+/2SLf0INoX+exTOOR3ChpuNucRIzJ6UG/QS04j
         tI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762450450; x=1763055250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVFA7b5QNQKKgbY4Sgbk0fAZQJ8jQ8t0W8uUVANJyQ0=;
        b=XoN+vN3VVpiSA59P22dkLjwFPji6pyxzEYg8+MYxT8IyM001oH9ebM4GVMDcubR1KO
         VzxzVbc+xLGuJtbDaovbyT7ZUQzWs1NfBcscAxSvywdZy80Vh/pDELwVvwFrNXC6Gu/g
         2pT9/JKB+XuEpXI3Lr8sZzpiJZc5fH3KB9vI5eaLct4AG1LQ6otoxOsYaMHcpIro033E
         kNo1+YtFex0CeA3ZTZzwV7OUQe9HqL4bYGlOj7rwujF96Cl52xDGW9bKrgmnhR6DOLhI
         T0FfVNBCPJniccALhSIKa7PindrhOWqLuhudvku2dtCa4/Oth6GEyws01hlqMi6pLggQ
         HOLA==
X-Forwarded-Encrypted: i=1; AJvYcCXF69LroUwkS6rb8VTXiZivq7fl7vQ5xomSaCprtmqfnuTAdjqxtlfnldKGkFvRc2lHvBq3yFSGhho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsl6b43qqmJWXiIgqze/RYVQwyKQhkn3gqO/CHF7zvCYyPY3Ki
	45cJHucOH89zFiATqIiSLaV5sfFj7h5n/6iijTYk0SPqmA1wOHhVQqtPXI8nwDU0PNadceaE7zS
	pxq12mEFY7b2dA00ucb9jFr++Dlaakg2hxzONFHNM4g==
X-Gm-Gg: ASbGncsanSZ+WEkKnXxcrnF82hZDpzKNdxcvc6aMAVuv+Jc+eKaKCuSuHgkPLFoseqI
	93J0VHWdgGz/v5sIW0HQ8vW0vBgJuI4R1HeWnPU0qfbwARPFN2Tka32RPfrDtsT3j7AM/V3SLF8
	tPaXAqdbYvLls99aJ5zGLst9c5s5FHVYX511pM8UvYBIcU5NB4+MiEN0PbG/kuoqXboaiCeRBo8
	RIQsJwewmjJbSWOaOJaBvUHZqTc1FMwcdernXO0X7zrNJtcgFgguYEPi6ZnFQ==
X-Google-Smtp-Source: AGHT+IHa3dttDqTITgV3tGTkp6TSuSmsFY+1K88280Yqh8YjVvfMj6OJH0DKtk3h1bhQap8rFtBGhpjoLqExb/O6Ijo=
X-Received: by 2002:a05:6402:35c3:b0:641:3090:cba3 with SMTP id
 4fb4d7f45d1cf-6413f094b4amr145941a12.37.1762450450078; Thu, 06 Nov 2025
 09:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022174309.1180931-4-vincent.guittot@linaro.org> <20251106172312.GA1931285@bhelgaas>
In-Reply-To: <20251106172312.GA1931285@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 6 Nov 2025 18:33:58 +0100
X-Gm-Features: AWmQ_bnxeRp9L3wzoigXubjMbIkUdPeZ-SXfzJV0HZAKsvwmODUh-S8pANI5ZcY
Message-ID: <CAKfTPtDn8r-YfgspLscd=4oE0GukFg6tORpsUqd7fUs7DJqnLA@mail.gmail.com>
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 18:23, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> > Add initial support of the PCIe controller for S32G Soc family. Only
> > host mode is supported.
>
> > +config PCIE_NXP_S32G
> > +     tristate "NXP S32G PCIe controller (host mode)"
> > +     depends on ARCH_S32 || COMPILE_TEST
> > +     select PCIE_DW_HOST
> > +     help
> > +       Enable support for the PCIe controller in NXP S32G based boards to
> > +       work in Host mode. The controller is based on DesignWare IP and
> > +       can work either as RC or EP. In order to enable host-specific
> > +       features PCIE_S32G must be selected.
>
> Did you mean PCIE_NXP_S32G here?
>
> PCIE_S32G itself doesn't appear in this series.

Yes I failed to rename this one.

