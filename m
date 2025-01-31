Return-Path: <linux-pci+bounces-20598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27514A24000
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4933A4794
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3841CEAA3;
	Fri, 31 Jan 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqC03omq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2E1AAC4;
	Fri, 31 Jan 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738339437; cv=none; b=dwgnDqerSygF+M6VNLjwXMM7+Kr/vhGYxJN5X+ojClL+liIZ4BymfAS7qQ0KY8VJ+7EZUSlgqXQNqQhQsIOWhJ8k7xaw/XbHfv5NUZq9n11Et+7LigUZyzAF+LzhcBcuuJDblyrfdoYEpJacXdWuoN7F7MWZtuHwyiTmhrlDZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738339437; c=relaxed/simple;
	bh=ux+gB73rSCKrfeyxBw+k1sCb4qCht1gOxxonKumtdYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hygkqj7g9+beE1NpC5xQhg8jFVsoJ1Ud7WBpTF9J/bzZrzRePR8GRy146kxe6dCchfGmI7rhUbR6VFu/zT1UNPQ2irJvEGayJcqQ5WQsEk1WoEyWH1Ynlc/gF3xZMPzHQEPUPTx7VqXfq6+cEy4fK9t/QumJQbuvRFegzxzhHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqC03omq; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-860f0e91121so1717515241.0;
        Fri, 31 Jan 2025 08:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738339435; x=1738944235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAyBmC8BK8RqSQxjO0l92eUElKo+PkN36EJuLz3uhtk=;
        b=SqC03omqCcCupy7eFTkYjRyuW9Zs8I01zUCI/mjlg0uzql4e2OQrTnAsCQdmWX7p5l
         G2yCpcCK8CXhWI+RtoeRMe/S5rNK7uP/EBoDWbyp2SRRb+oaJmJtB1Az3/DlXQcFIqtE
         TEHdQj/CT/0SkZ7OjmphualYEuUxJsaQZBZXU+zHkrD3azm4Onjp3Y2EsTqVndVtpW2c
         2ARuJWmcoHCw3PjhVLjrg6yWMg6vPAB95GeTdQC/clhDRVZv3qb9Eexl/sdFnhBM7e18
         FoBszL/ymQ46KIQu45OBnkkIvIagN2tILdn0X5uIyiGKjX8cqXCBp/D/0gPTUY1znfV7
         +h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738339435; x=1738944235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAyBmC8BK8RqSQxjO0l92eUElKo+PkN36EJuLz3uhtk=;
        b=pVN6quRKiuj68UxVvpwM7iqYUbCohlhsC2jYbht63YGMIqnzz02IOW/S04SfSST969
         +3/fPeCk+V05Ip1GwEAwX11gUuA19dghbzeXq9WQZM0/947mfmHo+P3i2V5v1DB4ne74
         0BvvYCPJVdDc2IEDXT7mTsSNY2e0zHuc8sy+0nXnFPFwCxrz7MUwGx+ucFT60yw/uqTq
         iIzG/Sp548RULfK8JXRhNOJCzmMQR5UzhU+S+VFuS96Cx5otebEmgt4evNJUvZHOSlX+
         uxdcvqNB1RYBbD3KiHnGf4IeQruB622ADVpMDqRAFVmO1t+6hblD5mnyYspOUxcFL477
         uihg==
X-Forwarded-Encrypted: i=1; AJvYcCUEzAAa8JU7MrPYdYxMOgBJDTg2ExXfAHn5JJCJzl5ZfWpOMCqAAImSfjMVdT/i7/ZEvQqVrBFZDed+@vger.kernel.org, AJvYcCVEKoscJ+5utV9OENw+TsVEsx+yV7K8/iriYT2wAZGIBjmKwR3LkLFbO2Qh8GcoNodV35mtqFrVVapI@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4xAxyfCvEbwOUq4E4S3lqKvKuis0UAToWCf30sITIiv83fYA
	OdK11oHViNAgTXze3VxcUUfWfK1nNxDKnO2/H2DEjIBUQ6mG1QS0OnWgUpOYi+6pjwNOUvEKoaa
	o5bTvU8dmBI7uOdMytr8nsRG52Rw=
X-Gm-Gg: ASbGnct5yzcVcgZ5g/nDLj8bihBCWPpAsZfdctzZDIZkXl3KIb6hum8F/e83iQMK8sX
	fhnOyWM7jw+4hMT0u4kknEP+A8gtm/956G7HKgaQfgDQflJ+81Kq4Gq+w/jHPC4bJQ6SHGM/rxQ
	==
X-Google-Smtp-Source: AGHT+IGVYpJEqeRGvHRVFOu+mqGM1cy9fp5OorflsRPh0dKlcs/2Fk1DjrNBh82WBXeKvz6ZGvvqQhpFan+we0SyLFI=
X-Received: by 2002:a05:6122:2bd2:b0:517:e7b7:d04b with SMTP id
 71dfb90a1353d-51ebe66645fmr1897860e0c.5.1738339434912; Fri, 31 Jan 2025
 08:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120130119.671119-1-svarbanov@suse.de> <20250120130119.671119-6-svarbanov@suse.de>
In-Reply-To: <20250120130119.671119-6-svarbanov@suse.de>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Fri, 31 Jan 2025 11:03:43 -0500
X-Gm-Features: AWEUYZli7pQbCxCkE2FzhKEzWWUvoQ8-B0Rzl4WvtuTu72KdBjpfuztyPC_Spuo
Message-ID: <CANCKTBvy=eqEbBjGTB9_=1J1dv3LP1pr48cTA3e=x4p_DTnVOQ@mail.gmail.com>
Subject: Re: [PATCH v5 -next 05/11] PCI: brcmstb: Expand inbound window size
 up to 64GB
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:01=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> BCM2712 memory map can support up to 64GB of system memory, thus expand
> the inbound window size in calculation helper function.
>
> The change is save for the currently supported SoCs that has smaller
> inbound window sizes.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Jim Quinlan <james.quinlan@broadcom.com>

> ---
> v4 -> v5:
>  - No changes.
>
>  drivers/pci/controller/pcie-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 48b2747d8c98..59190d8be0fb 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -304,8 +304,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
>         if (log2_in >=3D 12 && log2_in <=3D 15)
>                 /* Covers 4KB to 32KB (inclusive) */
>                 return (log2_in - 12) + 0x1c;
> -       else if (log2_in >=3D 16 && log2_in <=3D 35)
> -               /* Covers 64KB to 32GB, (inclusive) */
> +       else if (log2_in >=3D 16 && log2_in <=3D 36)
> +               /* Covers 64KB to 64GB, (inclusive) */
>                 return log2_in - 15;
>         /* Something is awry so disable */
>         return 0;
> --
> 2.47.0
>

