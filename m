Return-Path: <linux-pci+bounces-3273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9997984F173
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC31F235FA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFD4176F;
	Fri,  9 Feb 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRFHQVwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967B657B6
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467887; cv=none; b=j8UBwRq7v8M6tY3KWPuLzkmjKH/Sv6y+jES1NzAdf+/AKYXbXbXWY7K0DmYKkC626oSILNrcxIg77daIkFQMF1hOEKLq+S1IpYyEvDvA8vf1kmyJjl+j89gvZkfFu6bT5CwiP8EfJ5jdMJ4+IOB+o6RS3+bzxPL8eTs5is1vBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467887; c=relaxed/simple;
	bh=bezPoTkHC1H2YMQ1mO45uvUNa2QzGrdZ9eCwUcVzE/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbL615Hcat4zlM+C579ec+JqjtzaKiZ4L2YyfS6d+kvoeREG4+H2QkPgZxtxymM6sH4dxNv43Jd65QK/8pbMygvHt8dPvRqbdukvc6QPsrt3crovGzXW189qeYWlQoQ1McUWkeczAZDJt6ZhlEvU8vxRj1VPYiqmy98U0wIpw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dRFHQVwO; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59883168a83so308786eaf.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 00:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707467885; x=1708072685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HK7KKNNaeziKdVieObnrTYbRmBNZmVx/SFzcrE9Jijo=;
        b=dRFHQVwO8id9Cce3X1vadETH97rSfnEzdcIT6Wx5HTbkRHp5nHpdk6hlnnhA5+1M93
         HyClAA3Iz9PA45cuFGc/OgF9D1Alv3Q84sLv6KwLVLdcagOj5xujEIYxpdKxv1gfaiSj
         +ttKz9//XBJdzU/KHVRcdxldAlGsOVkP1sNTGruTyrLyz/NDBAlbmhc3DQvnrWNt/EeN
         CxL+fd2rr6TtS6yf71d6aIj6d8Oqf9kG5mIrYTsJER9l7SgTsTUzgPkNKSFJbIBSNQpy
         12aBsAyor70UI9aFt0ao/2wwUTGgAPqk6vvpItYH2nwQr4QNPmVOpvsU2hy9QtEHtPyI
         fI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467885; x=1708072685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HK7KKNNaeziKdVieObnrTYbRmBNZmVx/SFzcrE9Jijo=;
        b=QgRJehPXruULWXRvYeWdN7yXz9QoqBlOwIp8i3ZZ+gnYOSox1OyzsA//NNyEzxhqZj
         NJRufzxrnP+BZr0t68JfMWNwdpAR6MnfScgaCWP1GLRewLekYppmiMdScoO9KjGq6zoE
         F5E/I+W3L02cYUALq+qd9/XEnlPrgXkJd9+ib7f3Rspy+nwbBeQixyai33oJbK2TYVHy
         E1KPAcL/ovkh7vtLVrIKhcR6QYDKyXyHZ/OHz/lv4bNIDKB8i880pCIfUQqe7exscgOb
         0W2eByCphRoaipRbCcWSAYapRSB3XWF7yzHFuVo77zXyjgqznFwwUwukGzhzIe5Paj3o
         YSeA==
X-Gm-Message-State: AOJu0YxmlrAJH0SnXjnSkEKl/D6RnaF417mpZukW7QCgLQBk9UxyLLuU
	EMcGkTaxqiG9JdvDdYgyNINJbPQB5NLnISClkeu1UmUAoWKAyEcrgzG/jz0ULw==
X-Google-Smtp-Source: AGHT+IFkIlIsv7RAF9Gt4A7tvenzOvMtedm1teLxL0aipo4L0/dcpfA75zfhqWlnPfA/df6VUDF0yw==
X-Received: by 2002:a05:6870:d112:b0:218:f302:f74b with SMTP id e18-20020a056870d11200b00218f302f74bmr914975oac.33.1707467885172;
        Fri, 09 Feb 2024 00:38:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLhooGdeZzsqwUklMlNWO6ZC105sHFhC0g1hSJqzJEZDOzeZXpeFqmGTWoHylFYioPPdqrwqGCUuQRLKRjRwRbh5sKyHHUcJDY3XrC7Jv4UpSlStukb3cjVyNCu1Q4+G3tWCTe9ypeKE9SnCRzkLBVEDUZX1H1ez4/SVK9gbVtA4OFcy/Vx/3sS9VdPlc7AYbSqmx8iMteu9KczZX2yPtoA8lt0aI=
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id k190-20020a6384c7000000b005dc3fc53f19sm1201314pgd.7.2024.02.09.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:38:04 -0800 (PST)
Date: Fri, 9 Feb 2024 14:08:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: endpoint: pci-epf-test: remove superfluous
 checks
Message-ID: <20240209083800.GD12035@thinkpad>
References: <20240207213922.1796533-1-cassel@kernel.org>
 <20240207213922.1796533-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207213922.1796533-4-cassel@kernel.org>

On Wed, Feb 07, 2024 at 10:39:16PM +0100, Niklas Cassel wrote:
> Remove superfluous alignment checks, these checks are already done by
> pci_epf_alloc_space().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 --------
>  1 file changed, 8 deletions(-)
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
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

