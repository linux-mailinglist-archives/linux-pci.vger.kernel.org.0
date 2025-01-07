Return-Path: <linux-pci+bounces-19443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA81EA04347
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209FA1883F33
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B31F237A;
	Tue,  7 Jan 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHFxlRYo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3B1F2360;
	Tue,  7 Jan 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261536; cv=none; b=UmLyaXYigBmGfY0fzapnEmZFxsG2pCE3XNAzFB0cAhEY5vj8yczc2+9c7TTqDP1M1ZijxdKC/FaCCyuNbWJYCF3VP0SO0PdWvhSlvV/i7ZIFJjiZVdCPorR4P3N9M97v2PwS5RP29o6ScPQVy/aoIMf8QkwPMI01Jny8i5NJQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261536; c=relaxed/simple;
	bh=n/g/LT0+EYxgBnaA8Q0Y3ihh51DKPMals4XQPA51fA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXbH8Zr0LyAC1gpcGHtNkKrrkY5Lui4W45EyFVn93rA8A/KToHmHocOmWW1VMTBP5HDvfaQXU50s3CrBExsF5ngy00Gi2p5TaIDtdtmSKWUXAVFdgOM6KTO3zWvyjSf41Sey3vkxoWor7LSsUAudIZDeF7x2M4obEJMNAx7mrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHFxlRYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5852BC4CEE1;
	Tue,  7 Jan 2025 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736261535;
	bh=n/g/LT0+EYxgBnaA8Q0Y3ihh51DKPMals4XQPA51fA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PHFxlRYoB4d8fAyELs+7yr9LwVKmQejIgwyRAb60gbpTSRKvRA3oT1OKkUsdI7I+J
	 gMxLkWE4lMOTxdUXDJO4KvVP2tIP+zgtnST6+W31Jb63OixButBlRJ04sCbUrCSCLD
	 21wEJ6+33+URAKU5qj9tD0l8CR1iLydvtifU2WDgAA4cCe4E31FLk0uTSeOxcpsvIG
	 Xbn04ZKnpqM77VU1vxgcUFeWLschN4KdgOjVwXNDnes+5ixwd0h0YTmvSTlCD5kTP7
	 5XYP9NpRK4xb6JC22Yna7zH0LspehLa92WidXNeaXFnPc6ETfvfEaPbl6sYjJ/TlwF
	 zJ133HRA6hS4Q==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e46ac799015so19451868276.0;
        Tue, 07 Jan 2025 06:52:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8nWO4+QHZ1zSByLLBb5FIM0TvMcFpiM3BsxYO5cKTZYizSXVSDotC91GNWmFjuzfo+PRGKpQskFmT@vger.kernel.org, AJvYcCWO37fMXA9ZqenXueCQs/DNZtVa/PWujA9RgzyTckyiNGK06OeZ08I6pU6ULLt6Ydz+Ek2TY9Edp8u2bQ==@vger.kernel.org, AJvYcCWXemdEtiondSl0gyHTDeGs85ag/3/GaKmbdRZ8r9LZC61krn7Dj/YsLhW1FA7wCDKGY+G55r47URV51Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PmIZlQnGrfnd93ps9UI/tR3DhHQCjFCUIZD9cJKF9Xdc8PFz
	yY5WPryEEWRClMOYE5xUl0BkukOGkWXiXcR27CCWoOaPjP/Vm1f3MRZa4X0MpaFpJ/F/pXBCb/n
	xmHXwGWv10rwMLOKORN2RJPQ8Iw==
X-Google-Smtp-Source: AGHT+IH8qHsiUkkhE1jBqDw2Y7C4UCsv7+Yrl4O6TN7qMNtI98+pa9YVs/utSqgaeOWLz23NECazuzjMwNM2CevcfpQ=
X-Received: by 2002:a05:690c:6188:b0:6ef:820c:a752 with SMTP id
 00721157ae682-6f3f814565fmr425497757b3.20.1736261534525; Tue, 07 Jan 2025
 06:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103213129.5182-1-helgaas@kernel.org> <20250103213129.5182-2-helgaas@kernel.org>
In-Reply-To: <20250103213129.5182-2-helgaas@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 7 Jan 2025 08:52:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+k0DpXkVFNP+3eUw=FHu2rqM4MaDu93tfNfU42OnJ0og@mail.gmail.com>
Message-ID: <CAL_Jsq+k0DpXkVFNP+3eUw=FHu2rqM4MaDu93tfNfU42OnJ0og@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Unexport of_pci_parse_bus_range()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 3:31=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> of_pci_parse_bus_range() is only used in drivers/pci/of.c, so make it
> static and unexport it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/of.c  | 4 ++--
>  drivers/pci/pci.h | 7 -------
>  2 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

