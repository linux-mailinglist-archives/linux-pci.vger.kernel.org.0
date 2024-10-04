Return-Path: <linux-pci+bounces-13793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 444C098FCA6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 06:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E41B1F235C0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 04:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89794963C;
	Fri,  4 Oct 2024 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF3a7J9e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD943ABD;
	Fri,  4 Oct 2024 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728015090; cv=none; b=ESJmTMmKCaUV/y8/Gggfj3utp22fq2ZrYK+LLEHJSrMEs8eUyPv8tlYK1B3yR5pfIbeH/ki3KR1QVi2ZIjAT4fbakMZln6J2XzRxewzlGVLClJ/Myd8UvZerJgr04zpGivWUr/Z1tHlmNYgCVlA73467B1FeF+9rL55suumzhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728015090; c=relaxed/simple;
	bh=mWEOE9nswXDaTVB00jH1eq6MCyPSkMFdNPKlHkn8Yns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1aW+BUqlgKv5zXQbpTMwUjZCJ52GBfjVgekYvfeVIvg6NfBAJ2VxMah/1yiANtai+hvQdHCmpDBvrkMnFH7vkslheUvIIRin8f5Nz5muUV9VLG+uHx9fMHf29SE7bSvnLe1sAlDOkCv6PHGXtmJsMLE+BQVyCuJ85cLE6JYcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF3a7J9e; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27d045a73easo914583fac.0;
        Thu, 03 Oct 2024 21:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728015088; x=1728619888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KG5NyyXcoddyKNeeQDgE4xPxgRSIlRvqW3eOyOluoc=;
        b=jF3a7J9en/K+uzKbEHu2hHbWs9BqE75H1+EHEt/Lnz1svJC4PYq46C0C4lwZABQ/CZ
         AjTw4bSS/sEx9eLUb/VKGGp4YfoTTa+XzyRFqkw0OQ3AcdGbTD49LaJ2R8nnHWKR6J6x
         OSuVroCUfKWR/jLRdIC5pGl8yKNQ/iYXq2DsFf/obk709MRiJqw5d9IEnZVDUqqXkMoE
         OXUTLnqW5rvKFDf1Kbvx1hLsFUyaO5cVmu1enu78onGRMcwLU9OSYzw3yfGjW0u9iM2z
         BD6kHfs7fNn/XTHic5QDxskUDP26UyzSXuFfKlzFXTWdzvhPMRy91948dHCtTXnfi09Y
         7/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728015088; x=1728619888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KG5NyyXcoddyKNeeQDgE4xPxgRSIlRvqW3eOyOluoc=;
        b=Rnc6tDcuWaTsFq70bJW1O6T0xFftnvSnReYFb6U/2aKJnl/pNrAQSUYB1jsOByqfrM
         K1ef2zUkP2rlfRk1BAwu1QhP6b8xhKq14GSBTQkV9qTrqxAMF18qP7IXBCLfc0+JY4ov
         ux7W8FinJvu9d9JOkXjiFCQj+v2Fn+CW6kgqCT8CgluU4QJCnOY4Hco980DWNWwrKgyt
         44/lfFX2gbnfKE7D5DEqenDGDm84nMVr2V/2jlRCXXfdytJvfXVTxpYQ9IpUxPUDClXB
         lpoizsCJQoM2K/FbSazGo1y7Z1YN1boJssODTU2sw/8D9ZV/gbYyxxQkniWvPe/544QB
         /6rw==
X-Forwarded-Encrypted: i=1; AJvYcCVm/1+QqzCrz8LO/J8f+kCBTb571LFqTyksXepWH7tL0T//+llndG+sWqJS88zVDlyMn+JYjT02PDwP5k7JUBGQvDM=@vger.kernel.org, AJvYcCVr5KWmJoMEfnVIXdUI5xIJa8gw57doKFnV3+849bpsJ3/xHMynQ0wfgcJzX/A8rPEqvUw/n+5lesFM@vger.kernel.org, AJvYcCW7/7l6oBhVgQf5LYjv12SSc4rvdOqn/BANnlxRFejfX/eJl+TqA7wH6WqmKYnvYhnhDPm+JeOWduARrw==@vger.kernel.org, AJvYcCWXcl8Y92qeEKUuhOZ5q/GPw7vLEHa5CLN9VK2weOlX5MwCI5dN/T15sv/AqjIpmaa9aXc2co0MPf7nH5Y=@vger.kernel.org, AJvYcCWux2NQyF7KM9Tk3cCZAa5jaFF6vVdLDnPvkAqiMm2qkHhwyhlBy8/9XaoNTc/CafdiYPuoJsgLmdCpBJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6s5Eik8exAXCJJhKOpjVXnRq+g3fSRfQAYwF/HcftLGxgM3Hw
	IjbbuHVmkd0JFAuPSJNNkcxFJatWSuJKoO4xIOiu0FdDewq1oa7JvWgbgvbyP9k2iRPg30WizE1
	gYZi8M3wPSkEm5v/asAJLoFglJQM=
X-Google-Smtp-Source: AGHT+IH/oQQS/mnVkBMVZavu+1GJwds/AMzKCb97mcp7UAcOj1YhpcUbl3S8U4Ofo7beYWzVZu+XAyXSDZXvx8Nnsww=
X-Received: by 2002:a05:6870:2191:b0:261:1f7d:cf70 with SMTP id
 586e51a60fabf-287c2154afamr1028179fac.36.1728015088169; Thu, 03 Oct 2024
 21:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tdxrmmqyzcufupnwkdbg7lwgadizm7v3lxjirykijbml7x54ze@upbdzycdsilm> <20241003215217.GA326383@bhelgaas>
In-Reply-To: <20241003215217.GA326383@bhelgaas>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 4 Oct 2024 06:11:17 +0200
Message-ID: <CAMhs-H8q95jAvo65yQ5x0NxyU3Hzu0HeNQxZSa+5CHd7REgQuA@mail.gmail.com>
Subject: Re: [PATCH] PCI: controller: Switch back to struct platform_driver::remove()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pci@vger.kernel.org, vigneshr@ti.com, s-vadapalli@ti.com, 
	lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, krzk@kernel.org, 
	alim.akhtar@samsung.com, shawn.guo@linaro.org, songxiaowei@hisilicon.com, 
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, thomas.petazzoni@bootlin.com, 
	pali@kernel.org, florian.fainelli@broadcom.com, 
	angelogioacchino.delregno@collabora.com, ryder.lee@mediatek.com, 
	heiko@sntech.de, kevin.xie@starfivetech.com, kishon@kernel.org, 
	dlemoal@kernel.org, shawn.lin@rock-chips.com, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:52=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Oct 03, 2024 at 12:17:08PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >
> > I found this patch in next as 712359cb5e9d9553c1383fc5005593aa1988efc4.
> >
> > While rebasing my patches with the same purpose I found that this patch
> > handled the indention differently than I did for two files:
>
> Updated 712359cb5e9d ("PCI: controller: Switch back to struct
> platform_driver::remove()") to adopt your indentation changes and also
> convert drivers/pci/controller/pcie-xilinx-nwl.c, thank you very much
> for noticing this!

Thanks a lot for noticing and correcting this!

Best regards,
    Sergio Paracuellos

