Return-Path: <linux-pci+bounces-34909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA08B37F9F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601187AED16
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A560834DCEA;
	Wed, 27 Aug 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEiDTNgn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFF34DCCF;
	Wed, 27 Aug 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289739; cv=none; b=HpjtSpZSbKmW9M54pEDkVX/BYcAVH/15q4ux+pD19hI/pph5J6v2GITA39JJkj81WwY3sPSh3oGwwD9YDdn9ofZ4e70lMErl9gULnsL8eOxle7nY/6gEVPSinKtl3HZvzzrVPun1UHPvP/WQfNcrtw3MCJelpbLqHD61ae9Oopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289739; c=relaxed/simple;
	bh=iv+p3I7e2JvK+dU0SvUd+rGBQx5JLjN/WdIMRDxNPAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL4CK5hx0tHgoSZTRrDsE62X9THaFp+Yj8mCFV8do1611YooUNd3FvyJb6T7exGhE/SrriHj2sao8HB8CgM3ZRcGOWY+RoDioXSukPuqdZ/sqhAdc01rbohKcS3vLDqWeBCzUZuUCm0e1JnAUwd+5FbwC80j0M6uL/K6AYMmSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEiDTNgn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2489c65330aso4642035ad.0;
        Wed, 27 Aug 2025 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756289737; x=1756894537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ESKmXBZ/dMy2/5D5Fxfaulbnmlo3JO70rbWOitB30=;
        b=FEiDTNgnVoYwwXg9iEIlrQrOVT2xG3HQ0OIZs5D3zgorHbybOjLgW02hALhh6L1ziR
         aZ9Tobougz9Q7jUfYLxz+W9kjEzr4wYhFF4WYATjsWHP5YCqdy8j3kbi2fkpIRpFtJsr
         SLpYJMfFK42KVdHNNBJHZmFfZ7/NzLsdCjGu0RZFUwyEZok/tiC3Js6onIjEcoNwH3bX
         QjZHTrZVaexlMsRu7hWUZjRe8EQndytE9cX1OW+f71bLNio0emhJwR8/9Gi8AnajmORH
         Cp6ydOH1nL1pnC3fFh9QP3N2maLOusk18/7flDx9KjjC9sGR+vHMbk5KX3OsH5p2DF+B
         3kVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289737; x=1756894537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+ESKmXBZ/dMy2/5D5Fxfaulbnmlo3JO70rbWOitB30=;
        b=tKPonBbdhVU25DrXv758CNAV/MlMMLB3on3R6YQocBYL747rOkQ25czhv/T5kyVt2n
         ra6+UIaEw128w3X7W1XqjBGSDFmVDct8xmE5+XPfEaN4az2JZZxZmUGWFsYv/LxXwShx
         2Hc3jJj5Lj6HAGrUhJXHVzXP1QOBe3K1AwmOTZ2FhSEF5n3dN1rUnN+FKlRQLErEo5OM
         iy1Nhl57FW7qkg9DArUBLyqyj+Wykhi+SlFEjyqRNyPuFaOLDanIgt45koMRgNAOoFvg
         Oahp7+YAm6Fr3IjIT6aq/OUzwdV8rdXBKW09KRYouFoHKV9jZ6zZa18UcLV9V2AOJGa8
         A8eA==
X-Forwarded-Encrypted: i=1; AJvYcCWOJZovJsiBlz7JLM1X1ONNISfd5HPGFpXURI0qntxztyh6WbFQEdGrlJDS7TzZtfYJghjTFgGsklneRRs=@vger.kernel.org, AJvYcCX5eUbKlomOc37HKI7zDCR7pyHZKGyKIH8cFdws6ymVdoUY84vXKcwfMtNSRAfre9NXpSycb0/XgKXy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf196mWxwedSw5cpFO8JCO20HZBRjkKJdJSS7+qqBfq9TiyTcV
	0Uj5Dt+MFXiYwDLpRdqJA6kfbZIs5RUfo6XndPxj7KxK0v9J36Snm1I5
X-Gm-Gg: ASbGncsS/1irj9nkm3ZUQ56GKTdgxoAej7NZJYGXIFoL67Y0MgpbPIha6MrcanTXzP7
	Py0Ke4JKGoUsUv48gmxmPNjx0sHZwg9d7WqBwQE2bvMTW2ewYXEvgvCPjiTTkuXYrsXSEpOAb2d
	LcMBOEz96gd+Gzfsvsa1IPSiBfqtZF1S4XA5CIkS5dhTouGmroQAhUs0fTqaT3odWRqJYWoU16S
	lOmCZqrweOkGY5KObGFa5GpgaSQDJ1pGDzEMjXCczdc1MPD/+bcIYcbD+3tbo0CJ5UV7UTTeHJ3
	zx6DrI+kC6SPdNbuPfQHE9H+sg0oY1fpBuEyRBzhn9Uqo1UqRwN69DOy5K7Gmqde77cXuni9+4O
	QQnfCGKGsjCx9B1MXSkVhpg==
X-Google-Smtp-Source: AGHT+IFp0UnVPcvhI3+HYpUJDkibQ8r3PH4jGBwBIhuIOnqo1Ru2+thWMHAehAzx+X6Qoa9cgVzsjg==
X-Received: by 2002:a17:903:8c6:b0:240:92f9:7b85 with SMTP id d9443c01a7336-2462eb19bc8mr247480385ad.0.1756289737031;
        Wed, 27 Aug 2025 03:15:37 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466877a058sm117857945ad.32.2025.08.27.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:15:36 -0700 (PDT)
Date: Wed, 27 Aug 2025 18:14:30 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Wei Fang <wei.fang@nxp.com>, inochiama@gmail.com
Cc: Jonathan.Cameron@huwei.com, bhelgaas@google.com, dlan@gentoo.org, 
	haiyangz@microsoft.com, jgg@ziepe.ca, jgross@suse.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, looong.bin@gmail.com, lpieralisi@kernel.org, maz@kernel.org, 
	nicolinc@nvidia.com, shradhagupta@linux.microsoft.com, tglx@linutronix.de, 
	unicorn_wang@outlook.com
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
Message-ID: <zxtgpccewso6evf6zpchy62oyfjasxyszf7exqnd374ax6ufis@y4fiyftxauop>
References: <20250813232835.43458-3-inochiama@gmail.com>
 <20250827093911.1218640-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827093911.1218640-1-wei.fang@nxp.com>

On Wed, Aug 27, 2025 at 05:39:11PM +0800, Wei Fang wrote:
> We found an issue that the ENETC network port of our i.MX95 platform
> (arm64) does not work based the latest linux-next tree. According to
> my observation, the MSI-X interrupts statistics from
> "cat /proc/interrupts" are all 0.
> 
> root@imx95evk:~# cat /proc/interrupts | grep eth0
> 123:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   1 Edge      eth0-rxtx0
> 124:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   2 Edge      eth0-rxtx1
> 125:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   3 Edge      eth0-rxtx2
> 126:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   4 Edge      eth0-rxtx3
> 127:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   5 Edge      eth0-rxtx4
> 128:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   6 Edge      eth0-rxtx5
> 
> 
> So I reverted this patch and then the MSI-X interrupts return to normal. 
> 
> root@imx95evk:~# cat /proc/interrupts | grep eth0
> 123:       4365          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   1 Edge      eth0-rxtx0
> 124:          0        194          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   2 Edge      eth0-rxtx1
> 125:          0          0        227          0          0          0 ITS-PCI-MSIX-0002:00:00.0   3 Edge      eth0-rxtx2
> 126:          0          0          0        219          0          0 ITS-PCI-MSIX-0002:00:00.0   4 Edge      eth0-rxtx3
> 127:          0          0          0          0        176          0 ITS-PCI-MSIX-0002:00:00.0   5 Edge      eth0-rxtx4
> 128:          0          0          0          0          0        233 ITS-PCI-MSIX-0002:00:00.0   6 Edge      eth0-rxtx5
> 
> It looks like that this patch causes this issue, but I don't know about
> the PCI MSI driver, so please help investigate this issue, thanks.
> 

Can you try the following patch?

https://lore.kernel.org/all/20250827062911.203106-1-inochiama@gmail.com/

Regards,
Inochi

