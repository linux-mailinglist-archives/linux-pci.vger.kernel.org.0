Return-Path: <linux-pci+bounces-44039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75963CF4E6A
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 18:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B6931C7FAE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB086337B8E;
	Mon,  5 Jan 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DVq+T/ao"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25B337688
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631756; cv=none; b=XvtxzcQWN1E1gIiEMvKSJExhd7ffykEvglRcm/GsHsjaHZxv0JqcHoNmtt5l5GYKX5PXrOxQiQqKcGDqgbf/HeJ2/nzRAHI15FN0uTcU3AahZ+krHKBHv98S0pYPR1ZCk6nhvWIQrTGYOmSFu9LOdauLIcFTkl136BYCpqJqm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631756; c=relaxed/simple;
	bh=OpE212T/F9BXcXkqoV8tRgvykPW9UH3BnbLCVGJJS38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKPar6mWXH7r5WbGWzjKGcLfEa5UyQBrDGuFfKBlWJ2ocIQZ2S+t1GTmy+veOyOwaybviBUkhEJRd6+g69nkyYm3qG2LR8TyIyEPcD0t0W7in6gmxoelqqW8UDFqDuSbz6KdsAx8hKfpwcY9D+hLoTGVcdvuU/zt9ABCLd/fxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DVq+T/ao; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0fe77d141so1114475ad.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767631752; x=1768236552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p5G3xJb8go3voJ/ska7MmknNqjaKO20ee89C7s96SI=;
        b=DVq+T/aogTwlSdL7kfYlA8KAh+bRlYW8BnFj2yi2KWBTyHSrh2gXj0EcxueVFa+rwo
         9P2Q4I7ZNaRZKtEOOVr6WJzlEOPF75gQD+0HOvvVbTrqeLKXd8HmWZJBcYoeHDy4/mcD
         ReS+RmaYBBUZHd43YtUUP1qiuXB0ec5ZfRpw8C1MgK6blFNhbiPRQx1ZPdiXzZXS8pXR
         /UELTIhBEGjUxdejk5XmJ8nkd1zFE61+KXIXtUBlAt28r2KcERhzO82T4FdYoo0BObJg
         SZw/bMia81j15V0nCOGTLYOyLd5TR1SIrtWnDBcj9lz2h+noNmrr+V2SsR6F99gr6PbY
         sGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631752; x=1768236552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1p5G3xJb8go3voJ/ska7MmknNqjaKO20ee89C7s96SI=;
        b=vwYpAe98QEWv61wYPUZpkvjw+udWcJbIjuCduSe2Bz0oy+6WiiW+rQCvi1488F0Pt1
         2CUBbqzcezcIWK4BkIII7Qv7BdkoaE63rB5SEtJc1cwf7to+I21Wry4tnA4dJXfib0Sl
         KKyrGqJuovQ9fnPzhqvIVX5laHxX7SZYp1eikcsrnC9K8+8gycQLkqor7Y8OQcqh1Dsr
         YzSyFWAWhG71+FrfVvAgMKCznzjWw+Wolamdg1xrsV31Cdwdgw+PG2XBlkSAzpp+zEvH
         ND10U/ufCUyFEsGoOWGElF3o946GLUKS6De1iE+VTGCUYs71rYCx16NOR4Bw9/9Xba+g
         J9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWbvsh2WKiYzOPigzHg4H5n0v0vJrbpyG+tNHHZCSqTdAel02IqgtL9PGLa+8mw8sn9SdP3pFuSPZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmn3MIpUOnwn9p3Pe70H+O4M06tWW9H/EwpqiOkgj3lgSz5Md6
	a2/OPXIrbQpn7f7myXElDCW1icMwW7P2HB+rSBVWocPDcQXhUARafVSOlE7J5Yfy9MzEHkkmzTZ
	jE7dGR60DxGhDve2Rcq07iStCirlrXGM=
X-Gm-Gg: AY/fxX69lgeGn/DMTRvm43x2IjvwmLNavjebgZ+fB0p8djxeb6VoxDEAWHeRRz0f9fw
	PafpBfzsxMPRN2tH20yYdT/qvoIv3OKEovor++VQKg+YkcmzPur+7zxWBUduWjmEN7u7KPosg3I
	v131i91seYGz1nKj1maeIFj6cVJF2mPmiMIlHADAcdaLkDirE0oleHF7FcdsgAofUiG5QdkJ+Ar
	FIsho//oKejOw3tiRsfFptYrMVoe3UAxX3hVRd/RpZ7NyK5+/6DXApba4T5/6uZzWe24+FC4KV6
	01YmRztSqRPczabPCSf5ksqdIRoW
X-Google-Smtp-Source: AGHT+IGDtOegmT/WubwoP9uhYGjEyI36HrbbD+HDLKKzlp50hnIAwbFpuvZJAMWfwWQ5Fu7mo4QOpgsR9wCZJW3kUe4=
X-Received: by 2002:a17:903:28f:b0:29f:5f5:fa91 with SMTP id
 d9443c01a7336-2a3e2cb39ffmr2973425ad.27.1767631752099; Mon, 05 Jan 2026
 08:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103221930.1831376-1-helgaas@kernel.org> <176603796183.17581.9416209133990924154.b4-ty@kernel.org>
In-Reply-To: <176603796183.17581.9416209133990924154.b4-ty@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 5 Jan 2026 17:49:00 +0100
X-Gm-Features: AQt7F2rVWmf5Npt8HCJJTiZdHZlTavXt7hjPiasOfQo5l2lbIUvVpU46LHb_LE8
Message-ID: <CAFBinCAPpiq=M00ZQXAB4Pu2Myjo8gpXC7DByKkGN6Z_Ahqafg@mail.gmail.com>
Subject: Re: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout, message,
 speed check
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Yue Wang <yue.wang@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Linnaea Lavia <linnaea-von-lavia@live.com>, 
	FUKAUMI Naoki <naoki@radxa.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org, 
	Ricardo Pardini <ricardo@pardini.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

On Thu, Dec 18, 2025 at 7:06=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
>
> On Mon, 03 Nov 2025 16:19:26 -0600, Bjorn Helgaas wrote:
> > Previously meson_pcie_link_up() only returned true if the link was in t=
he
> > L0 state.  This was incorrect because hardware autonomously manages
> > transitions between L0, L0s, and L1 while both components on the link s=
tay
> > in D0.  Those states should all be treated as "link is active".
> >
> > Returning false when the device was in L0s or L1 broke config accesses
> > because dw_pcie_other_conf_map_bus() fails if the link is down, which
> > caused errors like this:
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] PCI: meson: Remove meson_pcie_link_up() timeout, message, speed che=
ck
>       commit: 11647fc772e977c981259a63c4a2b7e2c312ea22
My understanding is that this is queued for -next.
Ricardo (Cc'ed) reported that this patch fixes PCI link up on his Odroid-HC=
4.
Is there a chance to get this patch into -fixes, so it can be pulled
by Linus for one of the next -rc?


Best regards,
Martin

