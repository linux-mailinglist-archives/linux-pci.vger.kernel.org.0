Return-Path: <linux-pci+bounces-3130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FA84AE19
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 06:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C7F1C23513
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 05:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5877F460;
	Tue,  6 Feb 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVrHILVe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06878B78
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707197585; cv=none; b=EkSj9N+7MZYF5D7QX6QXa81mVc4SlGRVbzqf+Yy+JPKS6FgCKVP+VeUNLfgAPvYZWAJvIR/RKVvyu9c3KMlBQNmIHMaNAS9RYgs8h3X9uhis6DnbnpPnqD+T5U/AQDMgPHDJmkrivbOXTxgJ2NDh+jd27nZXQ1P24HOrarxLBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707197585; c=relaxed/simple;
	bh=Ui+JUqgpTROVByU1PNqr7sknWrjQ+hS/sSnSZVf0fhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzBMUIINJEzbL7UzIO7Pz3NvzbAkstNwJgKz/zBZyGYc6HY4dlBQsx5kaMj03uAEBR6gUh7uMTqISK1S6kYqxnKMo4j85yBE0a0Mw7Lq/w+PmFRsloVsAV2McPDsypqtHYakWJe2h3haODaKTBQD1ux9GUyT1pxMWxujHh7/3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVrHILVe; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbb4806f67so4153312b6e.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Feb 2024 21:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707197582; x=1707802382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ydU6BbxwzhKtYby2dXMvJri2N0Iv1xyu+D32zjFW9Fo=;
        b=hVrHILVeJ+JF1zUONEv6gQu+YgcRtL5Dy/sMogpI3zMzmAjoPAVGvQnCr7Zt8XGMJd
         ctF8OSa5wcvP6cYEOU6ujcQX3Fu731eeJEtbDmMcXzcRm2l8nBYSMZMu4SOYIT0BGss6
         MpK1/IOg2hXglbQcOl39uJsBzyqVhXKCNKpFjK+/4UBK/2gfrFwIF6JJ6gD5LGXwbtRH
         OL86u3w625T/+eRBPSfcakxDtVmUJNPDp3peESL7qORRYHv343ZIY8fwZ1uclwQi9oVY
         csoB5GIuMAgGwXLJEsdEIsn8quZjnRjn3/d7Lrb51VEhAmwa3aeRdcfBMxnE1GEQhvaI
         G7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707197582; x=1707802382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydU6BbxwzhKtYby2dXMvJri2N0Iv1xyu+D32zjFW9Fo=;
        b=uBc4pmVJRD1R3cNg2vvEX7SAzIV9XrHDXlutupOSpV/kxnYDzBys6ZB2QXEM6niMO8
         DQUnYewP3/MWxWHnNFBG//7YD0O9XKS4HMIU4TatOkCnaPl3v5Gx5+lnpnStfdjM7wkQ
         oewMJuK7bS0rOBAFoiJizRaYJeiQ8seiFS3Dn5yLcxoOmNgton7BBEnCEBSj4ySoBglb
         PG18jjhuxv7L7baN6kAd+cYqa+zg3Zq1YofLrHFKK+WyZLvzUJ6q1wxRorG3MxQgNb3v
         8DKkdfiZyA+352WYhirnGQ8sgobARC3TsMA+VvdwMjZJP5O7JyA6KKQzEY1mgG/VwFDW
         QBLA==
X-Gm-Message-State: AOJu0YypFS6vDKi44/OjPEC5SxxvBH51sr3Hb7aq4UmPYPssfA1/CxMr
	yhw2UVzJnHZv2r/U40Y1hdOUHRdSSaVdewYiAvgnmOfinLoYupX0bHOte9u2tA==
X-Google-Smtp-Source: AGHT+IG3C0afHDBZwdkrvhFt478xwoB+XQ/Bi2elhj/RlkQqEjBD3zrZSRKNEhbEZ38Dzl5IL9OEpA==
X-Received: by 2002:a05:6808:f8e:b0:3bf:e451:2c05 with SMTP id o14-20020a0568080f8e00b003bfe4512c05mr1077265oiw.43.1707197582466;
        Mon, 05 Feb 2024 21:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/IZHrFGLasi2jG1XOdy47tNQMPT7dhgSZibT+eZ1lfXCBvG5rp9H+wgyZ9f2ektNGqOKGC//wkDZHQaTO38vku+DRl6MiTuwXcgm3ngsTmM/MPUGjv24nx7KJ64g/E3KvwooCKI2pN57wgf0X5szf6L/A3EiNimTiseA7ptYJVpxpw0M7k1zjEYXU3v3+wmSUSnssVvht49WlkiRb6mHMIrBtf7heBv/Y4/rgOsNGHRaqP/Ofjv133g==
Received: from thinkpad ([120.138.12.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a62ae0e000000b006e0472fd7d1sm863952pff.130.2024.02.05.21.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:33:02 -0800 (PST)
Date: Tue, 6 Feb 2024 11:02:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pci: endpoint: make pci_epf_bus_type const
Message-ID: <20240206053258.GA3644@thinkpad>
References: <20240204-bus_cleanup-pci-v1-1-300267a1e99e@marliere.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204-bus_cleanup-pci-v1-1-300267a1e99e@marliere.net>

On Sun, Feb 04, 2024 at 05:28:58PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pci_epf_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied to pci/endpoint!

- Mani

> ---
>  drivers/pci/endpoint/pci-epf-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 2c32de667937..bf655383e5ed 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -17,7 +17,7 @@
>  
>  static DEFINE_MUTEX(pci_epf_mutex);
>  
> -static struct bus_type pci_epf_bus_type;
> +static const struct bus_type pci_epf_bus_type;
>  static const struct device_type pci_epf_type;
>  
>  /**
> @@ -507,7 +507,7 @@ static void pci_epf_device_remove(struct device *dev)
>  	epf->driver = NULL;
>  }
>  
> -static struct bus_type pci_epf_bus_type = {
> +static const struct bus_type pci_epf_bus_type = {
>  	.name		= "pci-epf",
>  	.match		= pci_epf_device_match,
>  	.probe		= pci_epf_device_probe,
> 
> ---
> base-commit: 1281aa073d3701b03cc6e716dc128df5ba47509d
> change-id: 20240204-bus_cleanup-pci-f70b6d5a5bcf
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

-- 
மணிவண்ணன் சதாசிவம்

