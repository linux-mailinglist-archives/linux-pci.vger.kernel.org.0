Return-Path: <linux-pci+bounces-16544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F29C5A7A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C861F2379B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618281FEFA1;
	Tue, 12 Nov 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PThhpsVR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3581FCF55;
	Tue, 12 Nov 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422159; cv=none; b=LUYMBPLBZY2AF3FlPVDbCemVzOjtctYP+Rq2T6QDtMLQLPqhv178zRPrApwjzlNagvcu/ermn9CBSd3ldNkdAsnbRwhZeQ5GpUWT1cQytiskbnkoAyKpjjOXdBqu2ZXheWyf1xCcxEu1N7I5NFv7oxNpdpOCSJHiL6dHbLgfPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422159; c=relaxed/simple;
	bh=Z2NJKOZ80m23Hs6ZpODlXPTw2PK6JAxwWTKiu7L1XNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmztT1WSQb6YZrAmMWSx3vthmvvBKN9GJ7jATir9mie8wQixOzYQA/nABkffZByDgvmKPtuIQ5Mz0+AAJtJkAraqT+A/gYhEL1xFOi1aVACeoqUA1jz6ZuNw9ucNCzyBQFog5z2gqpOnTGtQXIq/3IvbInpwsNpwYx9ra4w8298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PThhpsVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0157AC4CED0;
	Tue, 12 Nov 2024 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422159;
	bh=Z2NJKOZ80m23Hs6ZpODlXPTw2PK6JAxwWTKiu7L1XNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PThhpsVRXNp9m1870inWzUgadxqlcDbDb2l5xeQ/CvLQJec9dbfmnqbuUa7RLoVC3
	 bouFA1eMND7HmoShFhH/6BuNj2ZSQ6D5+SFeqDZ6qZ1U63ZtEpJ4gmQmSXvKSzehhR
	 puAVV+GUuFwbp4fgUSZveLUT6kmXtR+JQHg6edVtwqYp1RwtR9uGgzKeObYoSgskDm
	 wbqECTvloNFv6vKxXaJ1vJdNFjRpHc7fbiUgTexSCcbh+W5vlAlwEKgBocsUEyyA/P
	 9pzD2D90SiXvqbDUdfi+7X19gx+6cIr3AjaulUJjmO0lk5fraCM9Cuz6ZoFlF+CD3Y
	 aSb7mTvr/JJnQ==
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e33a8c84b9aso2075964276.0;
        Tue, 12 Nov 2024 06:35:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBGsKzVDa7yY5C7hU6o1OAheV1i14RgBtjD0rQGN/I4oLe+Bu4UdezI1nOkFsh7cFuTgZ5j9gyOHVSMhsv@vger.kernel.org, AJvYcCVNBICYNR0n9LG78tezWYHR1quJTf/t0ywuThzBb9yCRqkwRZkOR/6NaIAFwjZLAVNqzBOd43YAYbFa@vger.kernel.org, AJvYcCXlvJXxtzMlA3DyxLjwzb/FIjOo/DhJb8Xd2UyWk02MazMrZC3I2R6A/GArHeJm6etlNFiSCc6OI6zI@vger.kernel.org
X-Gm-Message-State: AOJu0YwIugYKYFRF1Qyp4xFipcBNlImdr1iF+IQGjDJCA65ig03wvEFe
	MKuSGJ2vAZ0NSqf8LJBdmnMFdHxitmlKG1IW98pwd5RfNg/6bIKJE8v70/ZtE3e03sZZfka9n19
	SSsXpTwUfjKfFd/Ecukl+UmNEzg==
X-Google-Smtp-Source: AGHT+IFI5tDoN6E7Kqk7Gw+xDL7rKQexAuiQ6Yq/THb9/Zw6ePjvaoIFxIHVn5lbaA5+r4C6IEYEi87Hkak2D5U5HD8=
X-Received: by 2002:a05:6902:3401:b0:e30:b345:9a09 with SMTP id
 3f1490d57ef6-e337f9054f4mr12761822276.50.1731422158152; Tue, 12 Nov 2024
 06:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112072704.767569-1-jpatel2@marvell.com>
In-Reply-To: <20241112072704.767569-1-jpatel2@marvell.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Nov 2024 08:35:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8JVhWNC4qefysLm+4uHYmR2Arwq3wTumS3XV=ncgU3g@mail.gmail.com>
Message-ID: <CAL_JsqL8JVhWNC4qefysLm+4uHYmR2Arwq3wTumS3XV=ncgU3g@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: pci: change reset to reset controller phandle
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: thomas.petazzoni@bootlin.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, salee@marvell.com, dingwei@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:27=E2=80=AFAM Jenishkumar Maheshbhai Patel
<jpatel2@marvell.com> wrote:
>
> replace reset bit mask and system controller
> with reset controller and reset bit phandle

The diff tells us "what" already. The commit msg needs to answer "why".

The DT is an ABI. You can't just replace property(ies) with a new
property. There's exceptions if there are no platforms in use or
similar.

This binding needs to be converted to dtschema before adding to it.

>
> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-armada8k.txt | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Doc=
umentation/devicetree/bindings/pci/pci-armada8k.txt
> index a177b971a9a0..a9a71d77b261 100644
> --- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> @@ -24,10 +24,9 @@ Optional properties:
>  - phy-names: names of the PHYs corresponding to the number of lanes.
>         Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
>         2 PHYs.
> -- marvell,system-controller: address of system controller needed
> -       in order to reset MAC used by link-down handle
> -- marvell,mac-reset-bit-mask: MAC reset bit of system controller
> -       needed in order to reset MAC used by link-down handle
> +- resets: phandle reset controller with int reset controller bit.
> +         needed in order to reset MAC used by link-down handle.
> +
>
>  Example:
>
> @@ -49,6 +48,5 @@ Example:
>                 interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>                 num-lanes =3D <1>;
>                 clocks =3D <&cpm_syscon0 1 13>;
> -               marvell,system-controller =3D <&CP11X_LABEL(syscon0)>;
> -               marvell,mac-reset-bit-mask =3D <CP11X_PCIEx_MAC_RESET_BIT=
_MASK(1)>;
> +               resets =3D <&CP11X_LABEL(pcie_mac_reset) CP11X_PCIEx_MAC_=
RESET_BIT(0)>;
>         };
> --
> 2.25.1
>

