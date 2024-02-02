Return-Path: <linux-pci+bounces-2986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B802846AE4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E667028B2A1
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F4182BF;
	Fri,  2 Feb 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kb42Dkfs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C685FBAA
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863231; cv=none; b=VvF3I66fTjGQPC8CmxN0IMwZ4GGVLTjgmCVJs48/NmdCmnQDnYUC33ttE7tr7sN7hxrA9/ffYsbu+oKn4OYMaN5WHvnHf2MqkET3aIEUd/ogBoRFQdczXUOo1sIkFUoWiZc8V0wkMSv0jDqgqPh37Pp9ciM6X23oVK2dArYiJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863231; c=relaxed/simple;
	bh=Ss4p0n2scyMaNxXjz8JzqPJ0JnCH60ItwUeWs8ItInc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCL8NCKUPXAJ55CNMdj7ZtI8l2TbmdeaHLHJ3/0jEyh3RyENBsD2KQmO+/OmYeKjruVjuNxJitl6hBOdELrrbj6yndDcKPm4aGsPMzeOGNZwk+aegkgWE5gtYp5zv4ZZjmL93jX1TpMWZL/Mm25D2yoJtXZ9yDzubOu5MMkE6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kb42Dkfs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ddc5faeb7fso1517737b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 00:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863229; x=1707468029; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MpmrlXYQ6eBYaDHgq2ste5bM6+LJxyBq+30kivDO0iQ=;
        b=kb42DkfsNwoEvEDFcbjoUYsnrHJg3V5BG8XjkcI1lNoSxjBi+6T30ODtJySWUpjaNz
         eze7b4BLfdTLHzfj7njMwQYiOuKwKkHj3nbmyR/QOqNA6bjr2nO+B2QggoLbSuKo/9em
         8FGG2GrtlVosqsggTYsmLcZDY+GrXsU0OrGq/bPUkB+ko+S/HWUgQOPqt2IJwqZY3fDi
         PFbSO4ZO8H/o4GtLUqPQSh6Iq7rsDNR69Bhv5QgrtVuhOiy1Y3Fau7WLGUVoZNRvYTxe
         ScKvQTXthO8odKnG9VM7CsmODPMG914Sopy3avBGGtSLX1KXyrn1pY0XrVz2iV/TZZxX
         t+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863229; x=1707468029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpmrlXYQ6eBYaDHgq2ste5bM6+LJxyBq+30kivDO0iQ=;
        b=RNiLakiS+lSiBKnKzQOJbQlNDt12H3zcNIM3D6xqGVcOMybmugaFnAgb5F/+GeFiXy
         tFKl+bkL8TgBhzQiZ7DOyqp1MF8G8juS3Pb4Np+ZqIp4rLiFof9QA8TKuR4583toPg2l
         iNwR/5c27rxI3yU3pMHHBCS2S9qGNr18aQeAsaLKcx+kJMDtEzChaqN7qKP8A7iJ1End
         EOitWW6iGKT04o3bDgRUYomyk/vg+YtSEaVsP13bp6/dlcec/sZaTXjD/hr4FHbqYzzL
         xIQl/UwMAL2+iXG4xEukP1ylCCaI1W6XOYpqQxKFbHjbuCpAP5iQOEr/56cCAd1FM05d
         VFnw==
X-Gm-Message-State: AOJu0Yw54xFV6Tl1h7Ja/twBdLsZRv6uacxTae3iDv04LNMNhtfvlq+f
	zpg+Z28Ci0hC457DxlWh2lxrYkCIN39cnTNIoWiOT6/Y3+sWLAZyuxpGsvTw/A==
X-Google-Smtp-Source: AGHT+IGatm+vcm+M7C1qQTaA/NuSCMvd1Hg96TRx3NveqtO0BeAJYry4UIKqIUDEMljvlegf8dLhOQ==
X-Received: by 2002:a05:6a21:998c:b0:19c:6cee:fc33 with SMTP id ve12-20020a056a21998c00b0019c6ceefc33mr9297632pzb.18.1706863228774;
        Fri, 02 Feb 2024 00:40:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUkFoDvp5qBuB1qrZHagNi6TFaIV21xYCdNMVhquIHSpkhtXXlCcs85zDPJsJHiPi2kd6kyfe61rR4Y1lQqjk2F+i58zhvHVNHblEGmWVUWm5kmZ8Vm3SIRvLDzQlSY6HZtuJZdHRNf0+iXXFQJ5Rs1/Hvc36vgIAW+IPlM9u0y23zfI9CkqUZRZL2WPcuwONZ+Lfk=
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e20400b001d90a67e10bsm1093152plb.109.2024.02.02.00.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:40:28 -0800 (PST)
Date: Fri, 2 Feb 2024 14:10:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: improve pci_epf_alloc_space()
Message-ID: <20240202084023.GD2961@thinkpad>
References: <20240130193214.713739-1-cassel@kernel.org>
 <20240130193214.713739-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130193214.713739-3-cassel@kernel.org>

On Tue, Jan 30, 2024 at 08:32:10PM +0100, Niklas Cassel wrote:
> pci_epf_alloc_space() already performs checks on the requested BAR size,
> and will allocate and set epf_bar->size to a size higher than the
> requested BAR size if some constraint deems it necessary.
> 
> However, other than pci_epf_alloc_space() performing these roundups,
> there are checks and roundups in two different places in pci-epf-test.c.
> 
> And further checks are proposed to other endpoint function drivers, see:
> https://lore.kernel.org/linux-pci/20240108151015.2030469-1-Frank.Li@nxp.com/
> 
> Having these checks spread out at different places in the EPF driver
> (and potentially in multiple EPF drivers) is not maintainable and makes
> the code hard to follow.
> 
> Since pci_epf_alloc_space() already performs roundups, move the checks and
> roundups performed by pci-epf-test.c to pci_epf_alloc_space().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Please move the epf-test change to patch 2. Rest LGTM.

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 --------
>  drivers/pci/endpoint/pci-epf-core.c           | 10 +++++++++-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 15bfa7d83489..981894e40681 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -841,12 +841,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	}
>  	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
>  
> -	if (epc_features->bar_fixed_size[test_reg_bar]) {
> -		if (test_reg_size > bar_size[test_reg_bar])
> -			return -ENOMEM;
> -		test_reg_size = bar_size[test_reg_bar];
> -	}
> -
>  	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
>  				   epc_features, PRIMARY_INTERFACE);
>  	if (!base) {
> @@ -888,8 +882,6 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
>  		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
>  		if (bar_fixed_64bit)
>  			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> -		if (epc_features->bar_fixed_size[i])
> -			bar_size[i] = epc_features->bar_fixed_size[i];
>  	}
>  }
>  
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index e44f4078fe8b..37d9651d2026 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -260,6 +260,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  const struct pci_epc_features *epc_features,
>  			  enum pci_epc_interface_type type)
>  {
> +	u64 bar_fixed_size = epc_features->bar_fixed_size[bar];
>  	size_t align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
> @@ -270,7 +271,14 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	if (size < 128)
>  		size = 128;
>  
> -	if (align)
> +	if (bar_fixed_size && size > bar_fixed_size) {
> +		dev_err(dev, "requested BAR size is larger than fixed size\n");
> +		return NULL;
> +	}
> +
> +	if (bar_fixed_size)
> +		size = bar_fixed_size;
> +	else if (align)
>  		size = ALIGN(size, align);
>  	else
>  		size = roundup_pow_of_two(size);
> -- 
> 2.43.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

