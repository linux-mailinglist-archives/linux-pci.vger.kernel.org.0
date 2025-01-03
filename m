Return-Path: <linux-pci+bounces-19235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866DA00B6D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653533A3293
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D61FBCBA;
	Fri,  3 Jan 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf563o1i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187519342B;
	Fri,  3 Jan 2025 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918213; cv=none; b=d+Z5y1F4tQ5CeI5nvdjmusT0wKq64rUyvP0gHb7MxADopyOuNuGdwmjO92cHNE4nKeuOQkqlKBXbAC6zbgwayNb2SBESalcd+J9sDLEdPIAKz3ndocsb3A5xn/5NVLgsufnkWQ3qfp/KcarBNsWrLlreHBOX6lxJ2UxxK+UJBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918213; c=relaxed/simple;
	bh=BxHhQidADsZYijaS3zKgdvU9SQtnlays+edgk6k/XtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diECZAvNjhe0jFU+oaZ4bqEsuVP3qb9579kWyfMhoZ+hgp4zHB1vga4ZELdE/sOf3RIYClrHHFR58XBnUmI7WbnJ1APM0eDWn+tr/gr4VdfodoJ0+zgnhNP+6zEjLmq7WgZumUloQvLNYu8S3zaj/ixv6g2KD2NlfzMYjEhwe7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf563o1i; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso23523031a12.2;
        Fri, 03 Jan 2025 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735918209; x=1736523009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxHhQidADsZYijaS3zKgdvU9SQtnlays+edgk6k/XtM=;
        b=Tf563o1iiC82FPerslYcqht0jNWScoExaHVtl2P48xIIYbkmCyGAwpuVu7MoVC72dZ
         11MdI6wsweq0Sa6iuwzONhr+5gvoH2jnIs3Os0FIwL6sw6lPfMSUok9kZLFGOn6bwB/2
         E9WIdIWzpWupcASxNm3YgDUUgPyKkwyBE0Lccn+fvmI7ryzBcsndt6h0PotmYhzdLNP0
         MBxUwD8UV4yVaP/+JBMiPzr7WisfR/cCx94SNO8fPS3arCI6QHy5iy392wg9NfZ+tzUr
         4uXVzW62crHGqgFmN85THJgDEOy0ayhjm8TJKJBHS4CojSYp8a/3JB8jLbwdQIHGSn9y
         E0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735918209; x=1736523009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxHhQidADsZYijaS3zKgdvU9SQtnlays+edgk6k/XtM=;
        b=kteUDH+VtM7Tvuw3mTqRbklNjB3z1ooE2unL7Wg9JGKBYXhAgrz0AyVeXTp40B99Qm
         D3zzkWVTFsijwcCgt9ga8Rama1Pu/40JJ3/to3FhS2l8/JWf9yG8+x6VGdoJemF+H2lh
         Q+LP8kj+LavTm9/1B5fIPPmNmb6TnORC9jwN8TQShSyXOfrx0b+ssOStAZY0+RYWS4tO
         rwyGiIaoc7DMV0M8Tp+iRclHIDZHT1mcC4x2XfLXdBHnb4DSldKGmqbpHRWE/tpSsc7g
         jeHI2O+GGuI4Z/xUlJSgxiEODJejYgYyJplWwlQxQUmBfQpTcjhVxDbY+9TS2RfOxqZb
         +maw==
X-Forwarded-Encrypted: i=1; AJvYcCVItgbXQd+XS7xsAMDe5mZ3YW/0GSCjvXQaZApRXx16uL0wNSFqiuhkrW810FDdUfolvjG2GAty5YVU@vger.kernel.org, AJvYcCWw9r06eMqRBGdQFe/gd1RxgxU5GUJepdyFYHXpkbqcT53fQwGBcqCYHAzsiTXR45VCIeuIAeCzIi6LAmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvQKgFrUAUak65Eqr5hamDOOYb8o+NgYYRetS7eG0lipFbvFD
	++JMxuatkt6untWlQHokzabbxJcbgyrPq9KMdDGdOddvN0TdRcAP5TFe4PNYKTmBT44mKDr/FFv
	3cCB1yGp58CX+LSXzwFro+1QyZ2Y=
X-Gm-Gg: ASbGncsYHvinIDOpAVu4xX2I6CmHaFb1DQN+D6sGGf53j2efGlCuQZqngKpweU8pSl+
	2MyRAkXg33DTLWB2lmPHctEceWOi+VP+G+2+3eg==
X-Google-Smtp-Source: AGHT+IEPhcS9BPyqvGIlQM2qXRZWsDDIi6z7TAAUpcov+fr9Fgzy4hHGMc+y4Zxj9EpJBFID0GYe0Wlb3V6uYMu3fCI=
X-Received: by 2002:a05:6402:401b:b0:5d0:c098:69 with SMTP id
 4fb4d7f45d1cf-5d81dde75a3mr47865343a12.16.1735918208507; Fri, 03 Jan 2025
 07:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <Z3fzad51PIxccDGX@ryzen> <CANAwSgQEunirUf3O3FJJAUsQu9mQYD_Y40uJ_zMYDZYVy5J=wQ@mail.gmail.com>
 <Z3f4JQZ6yYV1BJ-b@ryzen> <CANAwSgRTcHuDNLvPJAs7ZaV-NnepeOkHj_kVc5OAJtP03hd6pQ@mail.gmail.com>
 <Z3f95RXj7GhZZHEP@ryzen>
In-Reply-To: <Z3f95RXj7GhZZHEP@ryzen>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 3 Jan 2025 20:59:51 +0530
Message-ID: <CANAwSgQEb7rWFaeEO3Mb8LAwK6A5mrCyQFEysmSpeVdhoRWrtw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas

On Fri, 3 Jan 2025 at 20:40, Niklas Cassel <cassel@kernel.org> wrote:
>
> On Fri, Jan 03, 2025 at 08:36:18PM +0530, Anand Moon wrote:
> > > >
> > > > We need to enable the GMAC PHY and reset it using the proper GPIO pin
> > > > (PCIE_PERST_L).
> > > > Please refer to the schematic for more details.
> > >
> > > The PERST# GPIO is already asserted + deasserted from the PCIe Root Complex
> > > (host) driver:
> > > https://github.com/torvalds/linux/blob/v6.13-rc5/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L191-L206
> > >
> > > which will cause the endpoint device (a RTL8125 NIC in this case)
> > > to be reset during bootup.
> > >
> > Thanks for letting me know. It seems like a workaround.
> > I'll try to disable this and test it again.
> >
> > My point is that we haven't enabled the GMAC PHY (device nodes)
> > and must properly reset the GMAC.
> >
> > We're relying on the code above hack to do that job.
>
> I do not think it is a hack.
>
> If you look in most PCIe controller drivers, they toggle PERST before
> enumerating the bus:
> $ git grep gpiod_set_value drivers/pci/controller/
>

Ok, understood. However, we have multiple reset lines per controller,
so the PCIe driver will reset these lines using gpiod_set_value.

PCIE30X4_PERSTn_M1_L
PCIE30x1_0_PERSTn_M1_L
PCIE_PERST_L
>
> Kind regards,
> Niklas

Thanks
-Anand

