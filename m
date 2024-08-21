Return-Path: <linux-pci+bounces-11927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF09596C0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0739B1C20A9F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A327F1A4B94;
	Wed, 21 Aug 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC3e5rfE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4305158D8F;
	Wed, 21 Aug 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228101; cv=none; b=aHL1FI7RMayoTO0CM/3SyITYFOCjpDPYHo/oDHsTOtF+Axgxfq8fmLV+O8MdK4m1o9iZC/9RIb6SW2AqEWjU6mcGBGR7MtdRXMUIyaf3aDl1PAxe/bazrfpwgWZ65447mjq7gFfDgsdwQ+lSxmicAFn+XdtlDmQCZCLcmSsGCb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228101; c=relaxed/simple;
	bh=kMSf+iw07WfE6MO+gcL/KBxzg692lQ/LMRuhXYnUPvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgXCERYVKkoUFcqD+IlmR+babFqBfNszsxeYMjsr411GByrFlQpRSt+2gGHdc087ePkHWM1lhy+J8xVqSocMgYGOo+vTe2o9lkvJLjZ+1KOiSB6VRvjmqKfQLAhnApgphGM1xCdmRJ/7kx78qsCXPYzYg7x5kIUNC72Ph2JTNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC3e5rfE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a94478a4eso93314966b.1;
        Wed, 21 Aug 2024 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228098; x=1724832898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/bwSEYo5Qt1Y4vdeeF4jF0uVtsiIk4nNlCmcuIeMvU=;
        b=AC3e5rfEQLUn65M6ZGm2EryJ2KYDXhPFMNIFe+xVRwBFuFoimuFuDIqy509XPMt9wG
         V0DsGksVapuLHQUdRoFSsVlb9oWg3+M8XSCVteWYnxKmm3BpR1qM2ugqZqqW4mWLJB6U
         LfoY61P4O5LO+SeOvL+y/paeBC/2ipvH/srC6pqJgtX7KEuyncrfwrE8OyEPXcYlkj02
         yaudSOy0izTjPuoaeogpg0ndk0ERLUhVTcW9ISsyQOQ+NT9l/B31XGA3eyyicYFwyjpM
         b2ovZKkfAXKwoG7483EhJcppuProVjHxH8zBBXNG87Dvf/yYhwFeLrT/T/pZSmNauPSj
         uqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228098; x=1724832898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/bwSEYo5Qt1Y4vdeeF4jF0uVtsiIk4nNlCmcuIeMvU=;
        b=KD+em2ugLrirnG+jRh6bLCs+btGV3s27HolLa1xcznOLHLl8gJVhkTaQoxn/RCR8Ld
         ng5JoyncSH2O7Y2+ApPT4PzDGsoSG0uWzhSTy7ryUO1wC0CO4eflnYjoLUfGEDwUp2A6
         FlVPUx6rTaABwepqdcPAcmJkhZ8Wvvf98EQdJVRb2KGk9EidsQC9ZIWcLZu+czkx4NgA
         xgMJ3tTiSspWxwCkvTiD0T1Sars1cTIbqvz7ZPQ0f3ugOh/DECBOkhH5eRhVocthqd89
         hKgedLZePjwb7kurZxte2/uleVEMMFOZCYbD/hj+BceSbmtE+2aVvwYVa6FHTra7jR3+
         z0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6gD27JQqxwo3CTjWK28o07NCw1mdkRl0PwkKsXrA82mfNaVs02xon8V3GagtFRTaflhNQ9mLqDBh62u9f@vger.kernel.org, AJvYcCWUcBPFEsjacyDg/alxpR4zU2cbd31wiRM0hhcKHUyBy+7LVNr6amnob+MESCYgVwdLcgNzHHl3MS0Q2g==@vger.kernel.org, AJvYcCXX8KKOgoI8GwQw7peoz9ol25OctcGkA1YsYnTkcjy8QGkDkGwLnb1ptBab8sLNXKnsNor87jBP3vTaIw==@vger.kernel.org, AJvYcCXl1WScUAYKf22T7KEv2BYvso+DhAiXFB0tsV4eCvcNhwFsFB+vuW4OZgXddh7763oh9HM6e2esMh2Thw==@vger.kernel.org, AJvYcCXlJEGbV3JhrVPCtAIJGlKs7WuJlu0HBb/oMlxOdlkkwHhrDywfVi1ZGKctlhAA78XrkN1sLxz33JNP@vger.kernel.org, AJvYcCXpsqQ5dvS2owwdirDxocrzSDsoYKu1V5ZUj/SfjWDbIJWyKbYmVS+0wBg4BuMY9vUr5ITPbBlc@vger.kernel.org, AJvYcCXxvYXXjzjq8COzHyxdYKw/1+wKI72IxBAipK1OKb6siW8bPcazaNo+btvBej4HmzApRcweNK5kzPsU@vger.kernel.org
X-Gm-Message-State: AOJu0YxpemufWcEfdBr+BwsOotEbOXif5/KEv5FBekKOt8/N7nxEAXP5
	WVAtNcQVqihGDdWnVCjw/juIiSYeV2CaLNTTcWXfRJyFOXK8ctl9QCLQ0kMlEfu9m0nSbgiNDk3
	8iV1vxwo723S9X8nrrsXIZN8mzdg=
X-Google-Smtp-Source: AGHT+IHXeDFRnTQE0pLZlEZNONDmr3JlN5sqQBHhtFZ2nKA4GnNGhGlYKiud1j1pywVXDIqvTC/jKaVR2p6DxNez5+c=
X-Received: by 2002:a17:907:1b1e:b0:a80:f616:5cf9 with SMTP id
 a640c23a62f3a-a866fbfda68mr155136066b.0.1724228097818; Wed, 21 Aug 2024
 01:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821071842.8591-2-pstanner@redhat.com> <20240821071842.8591-8-pstanner@redhat.com>
In-Reply-To: <20240821071842.8591-8-pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Aug 2024 11:14:21 +0300
Message-ID: <CAHp75VduuT=VLtXS+zha4ZNe3ZvBV-jgZpn2oP4WkzDdt6Pnog@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] ethernet: stmicro: Simplify PCI devres usage
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:19=E2=80=AFAM Philipp Stanner <pstanner@redhat.c=
om> wrote:
>
> stmicro uses PCI devres in the wrong way. Resources requested
> through pcim_* functions don't need to be cleaned up manually in the
> remove() callback or in the error unwind path of a probe() function.

> Moreover, there is an unnecessary loop which only requests and ioremaps
> BAR 0, but iterates over all BARs nevertheless.

Seems like loongson was cargo-culted a lot without a clear
understanding of this code in the main driver...

> Furthermore, pcim_iomap_regions() and pcim_iomap_table() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> Replace these functions with pcim_iomap_region().
>
> Remove the unnecessary manual pcim_* cleanup calls.
>
> Remove the unnecessary loop over all BARs.

...

> -       for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> -               if (pci_resource_len(pdev, i) =3D=3D 0)
> -                       continue;
> -               pcim_iounmap_regions(pdev, BIT(i));

Here is the BARx, which contradicts the probe :-)

> -               break;
> -       }

--=20
With Best Regards,
Andy Shevchenko

