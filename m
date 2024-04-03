Return-Path: <linux-pci+bounces-5623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D01D89731F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 16:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F41B23D4D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393D3148FE8;
	Wed,  3 Apr 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/kbJZsf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A313EA73;
	Wed,  3 Apr 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156148; cv=none; b=sKhup6/rJ9sr0NXBxdNQ6lnBUnyriY7bGiiTDN14cN4oaf6YtIuzvTj1/iUszO7IDmYmm+TvYaOirH9QUJPix6mL8x86VnUxJTeAkaPASYseEA32R6WOyXG0UBIwQvLfe5+MAXTIPwQIyo9eZ/6mseAHRt7enibzqgsdSK7u/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156148; c=relaxed/simple;
	bh=PY+qnmhD6tmkUpKmIUF5fPyAGpZ93M12JetWWTIsDWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUaYPce7hynoweHHaA/+0v6Txn/YRmxQLCPFQ+2WXIsF+R2JcgMJd0ZUEVBSDCeuXieUS6MyK//3aIQCV83UCOPjzoOHCkC/3j7rfuQ9yyM33Xu7Isg05wSRk6ACBArwhuOevVVIHPzN9HCenk3pq/ltsong2BB4k5pduZ8zrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/kbJZsf; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso6440635276.3;
        Wed, 03 Apr 2024 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712156145; x=1712760945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdppnCiN5tX2a4wbdOB3yr5PBMxRl9CK0no4lPed/pU=;
        b=J/kbJZsfJuFwHFK/sFASUShpHd/UnDdV/Zbfj4UdiLPFNdU1BEsJpOwpB/e/vwf0AG
         C3amxxpshoKAmX3dCVTWgbci5RB9Vzjzk3vWFzpB1D8j2e1nEE2mH4fJcNYoSAgsgGkh
         YQMy8K8KMTeHGfRVij4FdFMLcVG0iH5t2jYFGFsTqaA1rsxIPA7kmyodakkgKivkjmEq
         e72xImoTyyP9fYo17z+QDolQfua5JTB33afgspayi5sUhe6KRMjy/ZO5iHTjSSTypsj2
         sufzJxT68u0QwVJsMpnmfh7k7bbuke0gKr0nU6mZNVB0DJfYnQ0Uv3yMcA5ZKOFsjd6c
         ICwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156145; x=1712760945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdppnCiN5tX2a4wbdOB3yr5PBMxRl9CK0no4lPed/pU=;
        b=sMoufK+ZbyK/O4DfakCpQTOgUu8wPkmnsKOyp4HsDedYHoNZPdrWhxqAIStrE92T7f
         vRv9LKtTKsymWWoOCg0i7uKL2xSvs5PCGa/nq3LAMCKkogBy9FPfXEMIeRxolggKL6ZJ
         fAmsNIXmQLrnFdro1ZUUFQsMeZy/h8fBE9nXrbjD/H02J5e78C6RKQVDMFng/ZXzcg8X
         NWKwTcJKZWBhjmAv9HbN42k8oKEEzqk64+mt5TQYM2wUCrpvjgW072BYqEpduQtcidRE
         lsSG5dWEQzkhq+jRSY/E9yb024gUQrLQqTps0DxOPzb/x/1o5MMNuneurp5yViQ4uN5D
         /1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWeDGCZSSEAYe9FbpzjQATSuQ2xFHYmAD65p3DZjxu+kT9QWGcpvUO+jxhvMTDSjPI04pKm5a1+cqnT6/mKLp4JBqI2SDVcHScWm5PfJdW8N5Rqe8EUsN7NJ2/ur21nYMyqXiUgEINdjzP94uNzbYPuilgQMQPLhpF2KTLgArGz
X-Gm-Message-State: AOJu0Yw4TFXq+Bsx40Us2kxls5w3QJLV+u+HrLnQkDIZ6FBAAHzrk2xQ
	rEpdvlBpnYz35VutAJjQTdL37nMQ1KNEfNceHyRgCEMvDDUJY3iKMi3ElOyB0/jpO4+65dKNTya
	pG9qPQXPQzJLmxPkVz3iyN/eVK6M=
X-Google-Smtp-Source: AGHT+IF93HYpJit0b2L+Msi+ZX3Cwa21oRLYpjSf+q3irAbdFS+IP1VQ1uP65LDf6uGuqjsAhRKQMgMDICSnHpjbQiU=
X-Received: by 2002:a25:b793:0:b0:dcf:ad31:57c9 with SMTP id
 n19-20020a25b793000000b00dcfad3157c9mr13287436ybh.0.1712156145597; Wed, 03
 Apr 2024 07:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403144508.489835-1-rick.wertenbroek@gmail.com>
In-Reply-To: <20240403144508.489835-1-rick.wertenbroek@gmail.com>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Wed, 3 Apr 2024 16:55:10 +0200
Message-ID: <CAAEEuhpBWRm4ODQf1eHYUvncZrDC5WUGe0sMMaCFJaUM0dn_1Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id
To: rick.wertenbroek@heig-vd.ch
Cc: dlemoal@kernel.org, stable@vger.kernel.org, 
	Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:45=E2=80=AFPM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> Remove wrong mask on subsys_vendor_id. Both the Vendor ID and Subsystem
> Vendor ID are u16 variables and are written to a u32 register of the
> controller. The Subsystem Vendor ID was always 0 because the u16 value
> was masked incorrectly with GENMASK(31,16) resulting in all lower 16
> bits being set to 0 prior to the shift.
>
> Remove both masks as they are unnecessary and set the register correctly
> i.e., the lower 16-bits are the Vendor ID and the upper 16-bits are the
> Subsystem Vendor ID.
>
> This is documented in the RK3399 TRM section 17.6.7.1.17
>
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe cont=
roller")
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/cont=
roller/pcie-rockchip-ep.c
> index c9046e97a1d2..37d4bcb8bd5b 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -98,10 +98,9 @@ static int rockchip_pcie_ep_write_header(struct pci_ep=
c *epc, u8 fn, u8 vfn,
>
>         /* All functions share the same vendor ID with function 0 */
>         if (fn =3D=3D 0) {
> -               u32 vid_regs =3D (hdr->vendorid & GENMASK(15, 0)) |
> -                              (hdr->subsys_vendor_id & GENMASK(31, 16)) =
<< 16;
> -
> -               rockchip_pcie_write(rockchip, vid_regs,
> +               rockchip_pcie_write(rockchip,
> +                                   hdr->vendorid |
> +                                   hdr->subsys_vendor_id << 16,
>                                     PCIE_CORE_CONFIG_VENDOR);
>         }
>
> --
> 2.25.1
>

This patch was tested on linux next-20240403.

The PCI endpoint test function was used and an arbitrary value e.g., 0x1234
was written to /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_tes=
t.0/subsys_vendor_id

This value was then verified with lspci -x / lspci -v on a host
computer acting as PCI root complex.

Cheers,
Rick

