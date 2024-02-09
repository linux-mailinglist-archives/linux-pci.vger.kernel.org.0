Return-Path: <linux-pci+bounces-3275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D2384F1B1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC791289AE5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A07664D0;
	Fri,  9 Feb 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDKbPPmy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B6664CB
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468704; cv=none; b=id4Tw5jhCi6RcGjbT78xriifIELdZAzAnKy9SmXPGoHDRrhqJDVyCDO/GR8k2RuThU7m40xsfQeY8+gA7GEeyiaHewKqv7++r2QLdewRt7Eo1Pp1ZZdtiuN1bFT5bQMYpzl3Ue2wX4GZ4sAU7HRm9yIsj6QHYTCwbvY2if2DR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468704; c=relaxed/simple;
	bh=9AzuDP0VLLPHn50Ebfzikmud3iPeTb7vb4a+4caxsEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=np08UyGXlVgWup102Dv0z9BxZu7o/Sn1hil4le+PkYzCyrhBNXBxpN7K2mtPhUzBOMKCoIG0F+WCB51dM7mpBAggaC/xTqrrgGmAODv/NCXGJRHgBQWeKCiZx/DVbiUEPf14OLA7MeUtqgG4s2A7RXDNR4xBr4lr91YSzOHtsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SDKbPPmy; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3be6ff4f660so342844b6e.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 00:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707468701; x=1708073501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TOxpM7+/7Mt2MJMv3CN+dNjLs92Ols1j+m9/bnLdB7M=;
        b=SDKbPPmyH7TngHSc8Dr1Bf87ZWTfpyRe0rqynQ1bK18RO/B6sayXO2pEV8hIDQBbmX
         R5Lu9RjDZ4yHuqT0ZgnMsSWZyifVNj0AAlWC6kcnzE1aUoqihWA0Y8YfTrwG/uM8NIob
         rBziLFhbeFGpCH86pippe1m3kLXguW9TwzvIp3w+mFg4HtEVpcs6VUcFEcLQlVpRavRu
         PeVBq4zzfQCgYdn1PKdX6yPccY3k65Womk2YeR6cjHXCz1MiQ4EI8wKUsweGBtlsCOgO
         jKG/8tZ/fK+QXHlKeLaSC7Dl6IKD2+pLPq2MmmaN2fpivIg2PgYzUSyih83voCkx6IUh
         2/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468701; x=1708073501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOxpM7+/7Mt2MJMv3CN+dNjLs92Ols1j+m9/bnLdB7M=;
        b=KHyqUBGrBUTKFmDh3BPjpBFfF9PjVWJqi/haomxWFMK71E3FTMJxjjbRmVX5wmi5na
         mPe3CEBHidIqwLt5iS3gihM4glzjBPbsLV0zkKeG7RJZCH08oqSGi3DWypeXiYJYwtDl
         IT6wstzDhrsSodVDVtRyXcKQy570xgvw8s6NNo93uJBfvRa3TH2tu75BdorQXaqweE5L
         lQwED/WWpaI7/tfrKVdIjwJfWgfq2T311maC14olec2ljPfgts42HlZNDt9k7Nijvlt/
         ZfAxN5DO4m620YZ+i7QSt+ypmjozQVnxrFjJAgnXQgd4LrYde8jU50bxh2s50Z7MTMB/
         +AwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJS8d7YLxl2IRZhIMeoFzUZ9ldLKoNNBoy1qiBAqgxsyVlkrrHLNJBKWEoVPxxJUnn/ST3IBGFfuhpnqLrs9OVlt6DhBLFeYVe
X-Gm-Message-State: AOJu0YwvSRV7HxtFKH/ws/19t5c0fIkU/jE/PwoeHKUjtaurjsOIssT9
	ihK+GL7WIO5HiVWb0OGcYpqsUSUl4vmsqrdjnNRS4eMpQWU/1kI77GnAo1fGeA==
X-Google-Smtp-Source: AGHT+IEYaUKX1eNiYZimTKIJepWhK9ExPj0lALVcLY8cYe2ie+LUQ6nIeISX1ni9nsnnlgv0X0vSEA==
X-Received: by 2002:a05:6808:e85:b0:3bf:e050:9128 with SMTP id k5-20020a0568080e8500b003bfe0509128mr1188012oil.22.1707468701490;
        Fri, 09 Feb 2024 00:51:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlG7nORhDRjlWa4C4rWmhk8Uh+JuDDNEx6j+DKxXnlANj82rRFvluT6Zm5B7FdO29D6+2Yp3K12sTZYWOAYXbpMypGNAxrzMtTrmtJbC1U27cJSsBwKxY8113H0O7iCp3NBWjeBPXzYeiHFLzbCYU2oNWfiyAvQFjA7L3txpjYPQ7awC7Ok6byNjntTKDwMkowgGYoZn8CV3y6abPWiJ3MfqnG9raVRXWoR/6jHwHOjDvOUzHJJ1v1oaHphXn01zHvhejHP2pjtWaNJ9nvNMMdfSt0YBVzQ6h0Vcv7DpD+HlEr9n0zesJMtuFVikiWnUcVKGbilljUwS52
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id z123-20020a626581000000b006e08d628e2asm702399pfb.19.2024.02.09.00.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:51:41 -0800 (PST)
Date: Fri, 9 Feb 2024 14:21:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/4] pci_epf_alloc_space() cleanups
Message-ID: <20240209085136.GF12035@thinkpad>
References: <20240207213922.1796533-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207213922.1796533-1-cassel@kernel.org>

On Wed, Feb 07, 2024 at 10:39:13PM +0100, Niklas Cassel wrote:
> Hello all,
> 
> Here comes some cleanups related to pci_epf_alloc_space().
> 

Applied to pci/endpoint!

- Mani

> Changes since v1:
> -Picked up Reviewed-by tags.
> -Fixed kdoc param name to match the actual param name in patch 1/4.
> -Split patch "improve pci_epf_alloc_space()" into one patch changing
>  pci-epf-core.c (patch 2/4 in V2) and pci-epf-test (patch 3/4 in V2).
> -Perform the alignment even for fixed size BARs. We need this since:
>  1) Some platforms have fixed_size_bars that are smaller than the
>     iATU MIN REGION.
>  2) No longer doing so would be a functional change and not a cleanup.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Niklas Cassel (4):
>   PCI: endpoint: refactor pci_epf_alloc_space()
>   PCI: endpoint: improve pci_epf_alloc_space()
>   PCI: endpoint: pci-epf-test: remove superfluous checks
>   PCI: endpoint: pci-epf-vntb: remove superfluous checks
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++-----------
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 ++-------------
>  drivers/pci/endpoint/pci-epf-core.c           | 15 +++++++++++++--
>  include/linux/pci-epf.h                       |  4 +++-
>  5 files changed, 21 insertions(+), 28 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

