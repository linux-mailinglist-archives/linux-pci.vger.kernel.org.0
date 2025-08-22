Return-Path: <linux-pci+bounces-34528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D1B310B2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D94E0F07
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28732E8E1C;
	Fri, 22 Aug 2025 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEAf/wWt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD32E7BB1
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848691; cv=none; b=FhkFqcoDY3Ui7mERccXjaGDJpO6tY14FwvOTxOTpewKOHcyXKI4IouIxEQWgZ7NturHSydChwTE2b8enVwGObXPisH0CbqAXulKgvdT1Ed3510dCO+ASLjmXEQTdjACssvEjl+ng7TDQsvQCr6nUXpgBM5Nc7XZlrsCoTPZgsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848691; c=relaxed/simple;
	bh=faSEfiTpREL/ys4OdLzvhf7bAeARCS9tt3rUMIAif24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3jUdHnEGkF/FlMLk2hkpAVZ7EPNROdsk/1R5XQwi77FrK5ohHWcTT0xypCBxlQO73eiwAFjTjt6oiwL5fKCx9fhiEkTqzuDFjWE/9UFxhLHmgyteW4EyOgPww4r1cH3//Zeji5sWtXqT06RFGINWoVIvl8oMfG9kbJ0wADiReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEAf/wWt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e413a219so1255166f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755848688; x=1756453488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2G2vICsXO8f0ArDyQQPFAnFMYMmrHOiPk4MQY+POTA=;
        b=gEAf/wWta32pNHA4IE8oJ00dAqxUG/ZYX8oqYITQ/rJmDtVfB+/QzVWStHoch1KGLL
         c4MuTqszr8Zim4FHilnzmT/TpoclBVb9a+MJ1LHPhZ4fQ/ijNPo3DcnjBvK9SjKYQ4FF
         5UeTKO+Eae8qMyHnERnqlRxouJRYjPUt16z2TOWVWHFzTspCKGeeF86ZT9OW9MK9Pql1
         BcfwrdnwcEfX2xz0rQKvkt5OMQVW2pKfE0DcdCBnES+VVRUGO17SV8TDXL/aqdS7NXWD
         GUWjvLU8XNgSl42EL26SU4cNgwBv2aUk+sMh9CCePrTVaBcMIyk9LETgPVAf108Mr722
         9EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848688; x=1756453488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2G2vICsXO8f0ArDyQQPFAnFMYMmrHOiPk4MQY+POTA=;
        b=tyvQyT289QADnNM1TSvbWVsZJcMvQYKWMPql4ieGlaG3/Izy3ucEE76hUDTjG0+G8u
         gokBu2IgbXn3FVNoHXgiufD4+qhNFY1BD6E/kWl6I6qaq8UTaCPVnkWKMRug3Aa4Xixh
         jnvupgWNGAH7Znge103pdNcDg2zmcPtWRVRZfOTfgOC84k6O+QGLV4m11XWIGaeIrfIi
         Hr3dlGHKcoXmevC+wZFdDtSbwtemUwYiHM2yk0TqsB9D5f3KlnbfsjISHXOGxQAIgqYL
         X+OfCxZkL3hi02IbWnGCQk4nMZyPPDCbz6yp4R9glFQa3F4+LLlw/LiJdZwOCr/v7BxW
         3wWw==
X-Forwarded-Encrypted: i=1; AJvYcCWTfNG84XQtEuNfjVpW9pjA30tiaWKubdTQ9vdgwYLLpTNSTIrlSUjrt9Xitr9utCntHc3VDSKFRYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOVda7IHrTdVrslmuFdiWLiHWh0X3n3As0T4nL4VgyplIl/S2
	SGw8Df1sYT2GGNb7owHObEFL9+Uhu0kGq3OcBvKAzUJzzU98ATwZWqZvuVNL9u3/B2l1SdHGOhC
	BHUXiGr2b3dTersMg96HkDDtPkOfp7w3rPX3zRQ5t
X-Gm-Gg: ASbGncuXAqt3bB0lo0c8msF3q/opyH32krCGfUBFAVF2eBYHKRWmrtXazuC2FBAQ2vn
	u0fp0vpC1Hz2Hn2j8mSt61cje75cYfuQYWYFYL2dbz19IkucIf/NvcHlSKjuNHaCz8pQ5ACNsZe
	ac8ILzK79hdQf38TyEpahqi09tKtxOpLFR9jAVSOVXvPdKKPTnDrVFNSWMYc7aZ8FWqrPKm2rNh
	FxQA/XKQiuA4IZCtq2ud5lYApHNEBStbDx5A3z3x84hgX5mzVsjkrSCI5MKzmIvasqywQCPirkL
X-Google-Smtp-Source: AGHT+IEoadB/lkuSJqNlo/SILQdpicC+7QYyIGD5rL1L8rNRHfY2sXck2SdaIgLT0kyeAavUOWBzZ7civMIWG5FymAw=
X-Received: by 2002:a05:6000:420f:b0:3b7:8c98:2f4c with SMTP id
 ffacd0b85a97d-3c5dcdfd718mr1520148f8f.33.1755848688089; Fri, 22 Aug 2025
 00:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041313.1410510-1-apopple@nvidia.com>
In-Reply-To: <20250822041313.1410510-1-apopple@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Aug 2025 09:44:36 +0200
X-Gm-Features: Ac12FXz0SxebOQqcLm-97q0sd3X8rsVm5aDZCUPIyZPEj1aHLk_XWZ8qmb8qzgM
Message-ID: <CAH5fLgiYy-9DfjL+0NoYzwD=8tTSBrFMhJveZktRncJE9czkrA@mail.gmail.com>
Subject: Re: [PATCH] rust: Update PCI resource_start()/len() to return ResourceSize
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:13=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> It's nicer to return native Rust types rather than the FFI bindings to a
> type so update the PCI resource bindings to return ResourceSize.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/pci.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index cae4e274f7766..ef949ff10a10a 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -10,7 +10,7 @@
>      devres::Devres,
>      driver,
>      error::{from_result, to_result, Result},
> -    io::{Io, IoRaw},
> +    io::{resource::ResourceSize, Io, IoRaw},

Maybe we want ResourceSize re-exported from kernel::io to make this simpler=
?

Alice

