Return-Path: <linux-pci+bounces-27522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A1EAB1C9F
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 20:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949857ABF25
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F323F403;
	Fri,  9 May 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWlpSlQD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181222CBF6;
	Fri,  9 May 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816521; cv=none; b=RtGFKEoJnd2xR5WWnvmmsOX9PTY6wWmUcOYv+k6d/d2dksQ79vTnZJ4ra4zsk8MmJJHSM1HJutWU/8mq8hEukXHcuD0E9EYSLUfEGQ508znwfcWzFxA3729YIAjUEVQiYrL2RPZeZgdg2Kw9Rh2uasd/UNEI3632m94jX4jbivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816521; c=relaxed/simple;
	bh=My1+3MQih7+ZGs+koEY7B2zh1yjPSCZ9rBsJe5PRIIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMdKhu6gzfJZ/Bh8OGWYBJXamQBQRkRFlyK35IeeEcBKYowFWAedAKl1fEo7O4nvYSv9iHd6YIpUw1TMs7ZI5cG5tqDrKXMKUsywo/bRL4XyrHqg2gmMD1aTDwrbNyJ5YfkybNrZIpb7f1PqcADKZ/4iqfDYo8XQjBvVbjyx86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWlpSlQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D950C4CEE4;
	Fri,  9 May 2025 18:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746816520;
	bh=My1+3MQih7+ZGs+koEY7B2zh1yjPSCZ9rBsJe5PRIIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uWlpSlQDvXdtvrGbuhSNYL7jBwpKW334EuH5bySmAq8bVBJTxhwubEU1o0Ys3zqOf
	 by2synHLNe8b8FO6fOf2oA6VKjpQwBqp43e3SEhUTKZAmkHdDbHU+7GGvpbebdrqeO
	 UUG1eTolTMUAtDcK1+WouZrzyh7hb9tngvqPKCoCeodWMKU6Yk46a1AX3Uh9T5IftT
	 vsqcxD3iBNVSJUoXw2V9Xz3Cfik8cKU/ufRrWABA6SPpa7Wf23vs5xQY8YgAqxJ3Gv
	 EhbFuYFX2Vy0cmfJyenylwmT81Mk4+7tBgZ18CxHeW7t6iwCP7nrchgXXtc5BvFBnQ
	 ZucIbswQorUDQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-604ad0347f5so617445eaf.2;
        Fri, 09 May 2025 11:48:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4Hpgt8LNx9xs1+hTlgfUdH/w04ahJ+i+wlI0RIR+6bnqMkVcUlxLxMmA13tuhLBQPF9Aew6iFmBSo@vger.kernel.org, AJvYcCWnLuneq8nx/ql1MNA3lgRpjTHL7A+gGht2AZs9doTR4XGzEgVW8ahORzKvr+ctfAKRLhMiLnv/ZgFg@vger.kernel.org, AJvYcCXmKo5eSQEICMZ2YCL5u4M77e4wHSYpt7HXN0hDTCRhbVMufYpQQay9/269Xx+bS2/vQoT23egVoNHvtbpF@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiIJ+JnbFVi/xPWXpLzYPAurTJFiQRp/nwcqmfE5NSSy2FZQ4
	2sWiSXb0+OfI3SCQO1oU3Qq0PUJMnn6mza72EiOPAVeqqCM/T8TOagGEu+qCw/n257jZcCBkpER
	zFozeHd2ot0yd8VxLH4O2O37GkaE=
X-Google-Smtp-Source: AGHT+IEFE8/BnJZlxUAgWsL1amhNwc7r5riPys75kcshhW3sZ05Bo9lzZ6yPYfueEH7ZKd0hIVMQrBznvLXd2XsSH8c=
X-Received: by 2002:a05:6870:a48b:b0:2d5:230f:b34d with SMTP id
 586e51a60fabf-2dba41fe6e7mr2783019fac.1.1746816519829; Fri, 09 May 2025
 11:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ae7866ab8b897253703ecee44c688b6832d49a3.1745552799.git.xiaopei01@kylinos.cn>
In-Reply-To: <7ae7866ab8b897253703ecee44c688b6832d49a3.1745552799.git.xiaopei01@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 20:48:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iqu82HP4bd0Ne2AkjSt6_EDa43Qt5jAWhAGHcdq5ePUw@mail.gmail.com>
X-Gm-Features: ATxdqUFbxBo0M0IYDtlWkZecAYcoPXiPlDtjaPpY-AvEt_JIptg9XIk2TngiCbY
Message-ID: <CAJZ5v0iqu82HP4bd0Ne2AkjSt6_EDa43Qt5jAWhAGHcdq5ePUw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pci_root: Constify fwnode_handle in acpi_pci_root_remap_iospace
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: bhelgaas@google.com, rafael@kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:48=E2=80=AFAM Pei Xiao <xiaopei01@kylinos.cn> wro=
te:
>
> The fwnode_handle passed into pci_register_io_range is not modified,
> so make it const.
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/acpi/pci_root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d0b6a024daae..74ade4160314 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -858,7 +858,7 @@ static void acpi_pci_root_validate_resources(struct d=
evice *dev,
>         }
>  }
>
> -static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
> +static void acpi_pci_root_remap_iospace(const struct fwnode_handle *fwno=
de,
>                         struct resource_entry *entry)
>  {
>  #ifdef PCI_IOBASE
> --

Applied as 6.16 material, thanks!

