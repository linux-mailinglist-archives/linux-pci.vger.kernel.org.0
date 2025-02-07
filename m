Return-Path: <linux-pci+bounces-20914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE642A2C9B0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2FF1887CAC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8818F2C3;
	Fri,  7 Feb 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blt/I/5X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D218DB3B
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947760; cv=none; b=RM/M3UgV0Z+etJl2fAWwJCGPizqLvWlhsdoaKPPaowizkkTf8De7AdvY4PEWWoyunzJjtQ8OIecfxDXYrBIDXBTLKTWquLz2ftYyzOBw1jXLaiY1z1us3pAYq9Eh/jY7ptJhbHOI2RvtIyWBKrHkZJInV+0csH4HFTlF4PoW0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947760; c=relaxed/simple;
	bh=M+O9C18J9TDsrtn9ygBQi2moURCD+M5fRkIKJLNmNxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZhQXmC6qgUkUDxFSBFGSpjawIVXDtuXflTNonWuLg5AsD+RwLrt8ZO2A4rOb/2TdfkxsQpwlCVUTOW2Polwt7FlVHrAfZ9MuWOgfvQOKCl7PKjsPvBHwhaZp/sJb2eX+Nm8V+dq533XuOyZNKoFra6bOvMfiyc+HbX81LCfNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blt/I/5X; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21670dce0a7so55842285ad.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738947759; x=1739552559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rywibxB4P0UxOm27bdG2YMzPN91p4Wq7QrOrZT5kceE=;
        b=blt/I/5X1OGUlyUvFAZKvF25NIe2vjiox/Egu+TipkSlES00Lv6pDpLnKjeRYjaszN
         sYCb3dselH7FljbEgaMpGVD6Q+lw9bAkZyG/6Z8/V3MtZUljS7vqKXzsR6Njs6O5Gsqm
         vo6NQa1c9ztY4kHphRMIGVl3FddO3LiB2cbIwmugraJN1DoXx67G5U8rvbxwPJtgkJRh
         Zm/HfkDgup4e62ki6IRUS8zgeAxysrZnMZccsXLNmK7P60lFE6qUP0gNa91opM+z/jLN
         0BaLkxGtLbfd7BrOihnOtJ2dnSFvtM0JJfuGJvDAWHH9fzav3YxkK6XnZ0fF7fWeB62s
         S2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947759; x=1739552559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rywibxB4P0UxOm27bdG2YMzPN91p4Wq7QrOrZT5kceE=;
        b=iSXoq55At0KBUlguNY3E7+W0+9WZm7s9if/GaVaUtu4wFKB0QrdizIpzRbx1RHO/03
         rwDBar3sb3ULXV4i/ALSXdoh2hw8m6YjMHUqu/tEUDm1IUzGDHDQpp5p5Dih+1w2d3b8
         WGZUfnkmoQtQbivYZJD8tjSqE3kM6IvWv/2dBQkAFUoxZwaBGFQC+gycwzBzLDGkpMe8
         mz2xV9GlYLT4mWAVaWrNQnXfxcbmJYwp34jmL8CWZld2nWTjq+IDWPipfoKIVFdINR44
         sKdL0NMh71/gcVZjgIPFhPDmlPh7p79PX0SjLEAU+3YUJLawnwgJuKoGFyx6eo+6i5Yi
         rkZA==
X-Forwarded-Encrypted: i=1; AJvYcCWxrVAPnJrI7PQIVx3hpIvLbtUdlOIQm3gj7miCDmhgbjhZ+sTPUm0/dJEIFICaROzLLG2yFdSokGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyijHUux/+B7BGmx4PyJudB9Qma9HEkcJyMfAYekbziz+OQQxy/
	jFNJL1CrraJE3+fK0U2qIcEHfjioQ9zzqkeQAFGe7fHk8GHWrRQLsWd6wHpKHKBupqGptBp4qj0
	=
X-Gm-Gg: ASbGnctb6s8j8Wxl2Rw6KCfTwZTVM46MbMhXFh48uLU4CY4GvO0DyGMX9oRTMQPFA1j
	znXdVk4uI8Ns4tvfoPpIRhd2tTj+Sr9Uxp3/eOLacjAiKQ9dWVy9L1u3OdLHc+o368sya1yT1Kb
	hhB+KabT4zPOddO0ehuwR/0iO5RKlIh1yKVbxbzBjR5SsRymzxbCNf48X3LjSx1M2rlBZj6GHD2
	DoRjc6rrEJmRs45fE8ByoL4LbA9CtOrP0SrWgv8x9qZhLqCFlxU67jZmPv4wjHYCzhB9dW7Uc8F
	QH705Er59jGvGWJQKdXLFWY6rw==
X-Google-Smtp-Source: AGHT+IF+5sAnHX5mqvTlJ9cr8EhXaxBIvoy2AbYyW6DPwIIxGnNU6p8DQD6XKoRE3E/2PxieJLgHVg==
X-Received: by 2002:a17:902:da87:b0:21f:3abc:b9e8 with SMTP id d9443c01a7336-21f4e7c6aa8mr55271435ad.43.1738947758661;
        Fri, 07 Feb 2025 09:02:38 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f365616ecsm33083075ad.100.2025.02.07.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:02:38 -0800 (PST)
Date: Fri, 7 Feb 2025 22:32:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Correct a comment
Message-ID: <20250207170231.kpwk2z2xoqr3czqy@thinkpad>
References: <20250128190141.69220-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250128190141.69220-1-eahariha@linux.microsoft.com>

On Tue, Jan 28, 2025 at 07:01:40PM +0000, Easwar Hariharan wrote:

Even though the patch description is not needed here, it is a good practice to
add one (even if it duplicates the subject).

- Mani

> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6084b38bdda17..3ae3a8a79dcf0 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1356,7 +1356,7 @@ static struct pci_ops hv_pcifront_ops = {
>   *
>   * If the PF driver wishes to initiate communication, it can "invalidate" one or
>   * more of the first 64 blocks.  This invalidation is delivered via a callback
> - * supplied by the VF driver by this driver.
> + * supplied to the VF driver by this driver.
>   *
>   * No protocol is implied, except that supplied by the PF and VF drivers.
>   */
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

