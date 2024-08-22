Return-Path: <linux-pci+bounces-12011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C45F95B7A8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C17E1C23D3F
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BEB1CBE9D;
	Thu, 22 Aug 2024 13:51:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37141CC169;
	Thu, 22 Aug 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334698; cv=none; b=GU+TiYINQSWijbibMqqu9V3wSZXErOcJeY9Pv194KQjrSKi4NHBnoS1f4LO4K+yJlYMqT9wdvqDsb6AvgC3u2lNRyFSjzHrlDiQpj27HrCkL09bCbzKXk6HZP7Z4fiqNEiYyOIfIsGQpgB0xZ7An8hYzyJJLcXwy1Ptina21Uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334698; c=relaxed/simple;
	bh=k2mXmw+4DYFVuI6Er1fgGFjlK1NjTkNiRJX1JDo7mbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqIJTYechlXIDwA4SjKG9toOiEPPDI7XQ3VFnL7LN9zpQe8fePiZYR5J6VuLfLYF2b9Ca5zVzQjr299mEGE9YUpUF+f5z8Qry56BX8Pb4C+MmWLLb8WplEkh3lDAbUYt1dsZL2VkDd5REv409eZrXFOacnWAgDJEFjLMV3KN0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e179c28d5e8so283014276.1;
        Thu, 22 Aug 2024 06:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334694; x=1724939494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV8EWkFNIUpLmBqUV71d651RsWP2XTAy1mb2AlQo5ho=;
        b=P7OZh8f2dMryVVhPKdijKmkAFz5NgHNogiSXEIFbru7e7O16386vzBSwwsaRgDVVlB
         kkamy8ZPkkvx9JG3g3n/TRD7AQul97lMPDsk0byhknGSGb/DmRkVG8SM2lrhCYx9s7fR
         BhWtfUjajQczxRjBVo/s8bGlGxhJlobeA+/ZtrxWNlIEa8DxBpIX6JyqxMqUYDXFy1lm
         O3iMIG/brsT2vtVyTacFT2e0ruCvalUFBDsKq4qt25QGU+ouTRP3zo6+/ACv4T4ra/Oe
         xX4Xflyh2A0OeZIgxK39WjKWBwvIWau+jlWxb6SkFh6pEFr7BbJ5OxB5L6fcac2yo6Es
         fgsA==
X-Forwarded-Encrypted: i=1; AJvYcCV09MUczQOJmMrMm2KlDjdRjg1d7g+CE1KrDHBEBQeCn33FJ2QLxQ8zvasaqrO/QxGJy2WKTFgLsMgI@vger.kernel.org, AJvYcCWK8i1NIiEyYk39KhOWdfeuknI+1GEeIOLc1+pSM+365DeOwCo9do1leQg2lE9fdN3/AMoWkI9u6Gv1@vger.kernel.org, AJvYcCX+OT2gn/hrOZ9ZVaNFPOXU9aqN2HTA0XHxdGUdkqJA6zIddIv24CBwnCADBaboWtrG80eu9WF/fm0OKYK5i/82ano=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85TZxe+CfSF6UEGQi52e+5CrBGHAfALb9hc5AwdTQ8GBe90QW
	SQxQIQk+fJFddJBw32NNFqWbHG6eRJdC4ZwQUd9rWG/dpnoYmFbiuBzyGeUP
X-Google-Smtp-Source: AGHT+IG/SN/CqMGnxN5tXyQHR6wsgtt54VO2aV1bpbSe1S84g7XaN9QLmOJKU4p4+78yFLKJRZYzag==
X-Received: by 2002:a05:6902:dc9:b0:e11:6c6d:8c1a with SMTP id 3f1490d57ef6-e166542a809mr6510759276.8.1724334694327;
        Thu, 22 Aug 2024 06:51:34 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c3948031basm2249887b3.0.2024.08.22.06.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 06:51:33 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6c49c9018ebso3971107b3.3;
        Thu, 22 Aug 2024 06:51:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbpqUxRWuVCcCunCFATnW9011NuGePM+oHEuwKlhVQesAV9KVwMPCwiZeal/S0vNzRyoTms3ZJcHp7@vger.kernel.org, AJvYcCWXfDSlhu3h4WDniaqkqXpsvBfCnrGo1SM3Y2ldpHa4Y331A5W25m8ktrg9p8df1Vgv+vS0Pg/WR7lU@vger.kernel.org, AJvYcCX0UnoPHjPEMCW3ZPtK8/f+StHmv6c1TfN3GndTkQKjJPNbwWskB9FNaHcf57Hn7dSkEWrWvRKLJsilYr9qta9v0vk=@vger.kernel.org
X-Received: by 2002:a05:690c:4984:b0:647:88ba:f91b with SMTP id
 00721157ae682-6c09c7866e4mr74089327b3.11.1724334693117; Thu, 22 Aug 2024
 06:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com> <20240822064459.1133748-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20240822064459.1133748-2-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Aug 2024 15:51:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU22Taja19GoNsLkjeHiQGz88UMbV9rVjakaJ=DrOx55Q@mail.gmail.com>
Message-ID: <CAMuHMdU22Taja19GoNsLkjeHiQGz88UMbV9rVjakaJ=DrOx55Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4M compatible
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: marek.vasut+renesas@gmail.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:45=E2=80=AFAM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document bindings for R-Car V4M (R8A779H0) PCIe host module.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

