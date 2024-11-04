Return-Path: <linux-pci+bounces-15953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD709BB5D8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CAAB2386C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11578C6C;
	Mon,  4 Nov 2024 13:22:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB747083F;
	Mon,  4 Nov 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726545; cv=none; b=p0yc7OTKj7cPQ3fhE2mmgKU5XoE4XzH70tAe518zZGuJLt8NrBOaUkcyCkWXyXGMc5KQVpjQhmqaadppBowOhL/F7Y0iaS9zTN9lNe0IIz+rh0GBKBTkanlObV3UCRbh98a9qWJqW7HBDT0EQTpgGE47pUW0SF5gu8ddzw2aP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726545; c=relaxed/simple;
	bh=dVzhkYwajzOcp/k61L3BTjdvz62YtWheav4zFKEnZAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixM1hu+L7Qq0s2+O3i7x/M1Hkzv0EWaaqkPPRX+yCOg40YUFKXVvuT1gkaiTp2F7tlwcIrXtG9G7zeZR/hwZTR/FA+mQbwq8NNMaFIdNmvEJNw0S5XXcXx5IS850e9Rtx+5ZJgWiZQ4VaD7t+iS8BjyhS33jY4yxFoDm2rg8VSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2110a622d76so31727775ad.3;
        Mon, 04 Nov 2024 05:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726543; x=1731331343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiVWnP7kdfguO3vKrywHszcKuT/ax89aUHhWpqrDlzU=;
        b=ZHJ8FQr7rPQgMwo3jvx6htS35KBdjsJCKia4jjaCUONhR+y9PJ09oFdu5C2W2yqnwA
         2P90UBpoVljN9Qe8Kh91McHrni3gCUr/JAFKGQCz1Zaq9vGEE261NcFm4+cp5RBME9MO
         PU62nVhw9sFs1thR1/uLWlZzlEZhPJe1SzQBTy16dfgWIdwd4IUZU0PA78KMEckXEw8v
         jP9iYQC+lHRUElc+Hn77NPSqmlULgj1jp7KZiWinHwfC5XxtvUSIgQysijlpAxiUXDOI
         SX71hXgkdBLI7YwciS/cCDVq933y4sJrdGL7t+sar0OZhZSO+oFtjE7+4iHjX2MCqBp/
         mYQA==
X-Forwarded-Encrypted: i=1; AJvYcCVxVmjcLJmzrVmDIak/j36DMqHkyz0/bYSKITM90k6a+Wcy1grqPUNfUFOPsSRUOzP8C3AMggvWt1XlK8Q=@vger.kernel.org, AJvYcCWr+9BoELMbKmQyzV1YZUpGnWJLSbzb7ctbdbT2CpzeMBXq7KkVPjeUn/5DImilRU/joUV32cAcNnIddg==@vger.kernel.org, AJvYcCXqOTVREsgHR2UVuXaE/uTnC7ld5lewHgDnSuxdFPAvbo6szTaPzL5MKiDe+S/gYB0WILnj9gFeorqf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uMMfcoAqvc+iWHnMvy6cuk9BhjKBUZMazMt7Xnv+sjOFXa0z
	BkkciUxgQ+sw1YRWSMsfYVtSqR0r3J1Bmru7S3Zs/TUK+ytrWfsS
X-Google-Smtp-Source: AGHT+IHpDIGv2RScWEaNKHsryqx6v1lrXJOztR/qFFp197CdN99mxwH5uovMf6w+lDn72OzEgzUsUA==
X-Received: by 2002:a17:903:2bce:b0:20c:f27f:fbf with SMTP id d9443c01a7336-210c6ae7f15mr465977105ad.25.1730726543312;
        Mon, 04 Nov 2024 05:22:23 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057f3dd1sm60195775ad.308.2024.11.04.05.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:22:22 -0800 (PST)
Date: Mon, 4 Nov 2024 22:22:21 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
	kishon@kernel.org, thomas.richard@bootlin.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v2] PCI: j721e: Deassert PERST# after a delay of
 PCIE_T_PVPERL_MS ms
Message-ID: <20241104132221.GB2504924@rocinante>
References: <20241104074420.1862932-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104074420.1862932-1-s-vadapalli@ti.com>

Hello,

> According to Section 2.2 of the PCI Express Card Electromechanical
> Specification (Revision 5.1), in order to ensure that the power and the
> reference clock are stable, PERST# has to be deasserted after a delay of
> 100 milliseconds (TPVPERL). Currently, it is being assumed that the power
> is already stable, which is not necessarily true. Hence, change the delay
> to PCIE_T_PVPERL_MS to guarantee that power and reference clock are stable.

Applied to controller/j721e, thank you!

[01/01] PCI: j721e: Deassert PERST# after a delay of PCIE_T_PVPERL_MS milliseconds
        https://git.kernel.org/pci/pci/c/22a9120479a4

	Krzysztof

