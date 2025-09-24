Return-Path: <linux-pci+bounces-36853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D90B99F06
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 14:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B8C327CB1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565D22FD7BA;
	Wed, 24 Sep 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kkn6onVP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27EB2FB98F
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718560; cv=none; b=myRsjaTLYEmGOM9429/HGnt9w95mjFsIh5JZNiCdY8VInxwxXx2LRbeE65Ku2O6G/SwvoGT5f5nldrcFMde3J0cfgpjjS/JDS7ygjG/WIfTD9eeiZmLAXJzGX995MFwjnh3+8UnL8lBoMuSutDWT4rdYMeo7ARvSsDoT0Ou/f5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718560; c=relaxed/simple;
	bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfufm3Rbsq/kcf+snd4yFKBn9bmTPrRYmowaS3lxMf7hENxRvebTeB/4dFTiwudZxfMkwhOXfCNU71JwX8gkCV3KWgNB0XySON6bu/bVECPgMecP39aMnFLr1RA5R32Pw97EojnmZdRvTU8nUwOxgKypvM/QYJM7gqekiB9tKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Kkn6onVP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74382048b8cso5352908a34.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758718558; x=1759323358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
        b=Kkn6onVPAMSNNklmFFZI3aNKbFGXU6nBTzblm3E/Pqfzu0p10WCUO6yPajm/5VwuAM
         0R/CuTowYLBmljyJC/Kn5QN5Wdco/tdBRn5ekpqnGP38SrN+Ac0292QFuzXolu4Ur2ly
         nMR4TkZHt1hXvq1/mclPrqQIzGGal2GIP/5UvgAk/Mdh0Y0kr2haii3hP91cObbCQxQO
         TXW0yvCQfwfgC0aETgt+VkrOzjRw8DVOxHJKZ7J67EtCgL7I4b5l0Qgvqt8gtTaq90iZ
         SZ+0Z7skuhxl+n3wGdTfN6yE1HSJh0h4Qq/SfGrjta4rO8mi9X8xjGNQPxika3XSUOJm
         Ns3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718558; x=1759323358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
        b=iIM4Plfw4nSigC02fs64fdf1RctV4IviBJvxSleFdU+Q00sK1L9kWPcvFFaxrk3gUr
         rXTP/aKlkz4dL7bAiHYzl+UEf7J3Tq5Yf2OIyXOS9gjCfGn3mZlzB50AfIrxuL+WP9qV
         echexdYUZ3CovVvGp0Vn90Zw06MgpY6wfhcr2t+9gk03pK0lMzQvC3iMz9gUuTHvZJf1
         z/rhtwCsnCvd5bJyma6M4aOd/xs+Rv3tFiMgzPzqWd/k+FhoMLAGovJF3xjc2Cnr0L7F
         mPX0UlTI6H6gzJYL19iS6O6sSa3c7F6sedLv2JWNmrZ71QLzVyc8ENSMhOLZ2cUN9xbS
         KyPg==
X-Forwarded-Encrypted: i=1; AJvYcCVjuOUmqzLlR5xnCNBj8eI/CSm5Jf/YPcqxPdirsHLUXjt85dAzokLniHOONCD97EgiSCCf8TlKT98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCy/9IPfqdBFCupogqaTuPUSyS7Xqll5dVGUjgaFxN7wQyevc5
	ZG+83AvLoy+F944+9VOhJ40XfJ9FcILImp5chUVuPKofecMxVJ6GTLoWsFxc1Q4ZQ1s=
X-Gm-Gg: ASbGncscW+O0PWk98v7/U6Lz0CyIKSZIcE9vFCvB3BqK82JGaogbByCC4GXWQLyn+64
	RyK32WyE1tx80lPvS1JwZ1pkw4OC7/HO/PzXkZBAdgx84DJ+8Y9ZHCR4lx27uJ17vi4iC0/n76l
	Xu/4B8XcsvVyckgMjL5w3hH0M9xGEl8E9RfZSYDRML89HNJqB49vNzJ6v6lwVlfh4LZAm84yAVy
	KL/dJM4xOnPAXcOE5y5JKpjI3Do29IW+2gbLrA1A+qHA2fX5ah8znwJIb+lYE/Yrnua5Ms17dss
	qh4ff9fp4CMRpSzSk+LazRZYtAlGMAGYI9lOlWyBK4Gelm2B2qUGSzMMg/Ul0i4yXhn+cfsk
X-Google-Smtp-Source: AGHT+IHQ1WFwERflWPT6pleBXcoHSBQbFQS1yTbSrGY2yC7WZRjb2FbqLBgkt00nf34cnENXHwUiCg==
X-Received: by 2002:a05:6830:65c3:10b0:746:dc05:8604 with SMTP id 46e09a7af769-79153cba081mr2694566a34.20.1758718557920;
        Wed, 24 Sep 2025 05:55:57 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692af2f9desm7576308a34.31.2025.09.24.05.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:55:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v1P2J-0000000B800-3i6s;
	Wed, 24 Sep 2025 09:55:55 -0300
Date: Wed, 24 Sep 2025 09:55:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <20250924125555.GJ2547959@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
 <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
 <20250923162139.GC2547959@ziepe.ca>
 <oig5w7dnrdpgvzuqu4johs526qe57x7dkurd2abllqyvpavvti@s3pwtoduusfr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oig5w7dnrdpgvzuqu4johs526qe57x7dkurd2abllqyvpavvti@s3pwtoduusfr>

On Wed, Sep 24, 2025 at 01:51:23PM +0530, Manivannan Sadhasivam wrote:

> This device is not spec conformant in many areas tbh. But my
> suggestion would be to follow the vendor suggested erratum until any
> reported issues.

I mean the ethernet chip retaining it's SBR after a FLR or link up/down
is probably not a spec requirement..

Jason

