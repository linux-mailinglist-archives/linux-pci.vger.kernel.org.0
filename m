Return-Path: <linux-pci+bounces-22982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2993A503DF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E513AEE29
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D0924EA94;
	Wed,  5 Mar 2025 15:53:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78924F5A5;
	Wed,  5 Mar 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189994; cv=none; b=Z8CUVq1c7tmAW4ed+J5a1E2gL66/ZJ3R4Pwz6wmIwV7ydm2qNdvBpFqrKA5DLW6QRcTJk4cLErWJDXpO1yeina9f3+3KFXim5U/wmFijY7qCuCr86xR9Einj34fRNV3wxTcDPKWPYRxfsg1ZY2wI10pLmMeJimtv3LQoHFkOSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189994; c=relaxed/simple;
	bh=ppZQlzfaKB/X4mxJWRT1PkAJjs2HSRd6l+gBVbjxM7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSrN98EwvQ7L27BGsqcbATj3wIlXWpevIlKO7qobMAMDe7vAPR3p9mTiK4M0w9nC0eJVRXzsjjXE8gkOeLmdmv7zjTgREqsTGQvHI2kT6Eto5yHP+1BRVqk4HVgkLia5aoGjptLghTHUVT+vqEdCQ1R2Mv61ox5TbnIkoJq4Ouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2235189adaeso19466725ad.0;
        Wed, 05 Mar 2025 07:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741189992; x=1741794792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coCinc3sJhA0k0wF2b7abKlgXemlBKbg8/eDdOfqRJ0=;
        b=FQVDWOc27Dn1V04qmpNMnaMYQMz2o8USd58htK1Gj+yRPkvRBxrIjPRLBk9VCc1+Tx
         4t8IUos0jaknNlP6WrCdWR2E0lPK8jdsI7SVsGhka1DP788Z1EztZ9N4ilsZie/rGwtM
         HR6bavO67w3aPXhwJco7FcOCB/OrwvJdl9kYxRf+v9iiXL37BX/bva9hM/lyBPMR3kE9
         J5Z+AQs5wMoE2Um+mxp5da9uql6sv2pKBzShhHYjn37OrAMumYmTT8Zg/UT8NkFwNkoc
         87/5/+TsH4ZraWchO7gr0sCHwK8ySfu8l6+/iJuBjyfwo0N+1UJLxjI/clBUQPPSA93n
         e5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA9SX6E3efJqejWTFwasLbHrKFp7a5CDiTwD+lAwDYeuxhCY0K1285Elj6OoPd4c/OfITvH+8kQ++9GyxSqmQ=@vger.kernel.org, AJvYcCVftmNYOAdzyi4ntuJMlRZF0cLB54hn/I+93wcj4ehS0sEYHuslK0rvQUOQKeg8hXtz6TIzciaUTPv2op1e@vger.kernel.org, AJvYcCXvem+7l4qe3nLdVcpDh4sYLJNwdsXq8EvvPcGYGcUEHGtDhvwa/Vl4H+595VPIUH0+HWKvfTNZY0Qt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdo0ddMErl/f9KTR/mLKy9EMeC7iiKMWZ6oSfIGgA4AZqiz9Os
	wWg3OiOKXCNwE/Rsed7aEhEURqsAXSMidq/yBIZY5AH+AEXG6FsY
X-Gm-Gg: ASbGncuo+At9avjQPM1ycn2tkRzXjaRIms7pc3XDZWF5juGfulTi6NuXiCT+z54hL4U
	l1eGu2p5aL0xK+dUXH5Vq0Ckupg9FGTlMC03SshTvUvMRyvybtN1ACiM1Gb3yXI5jYaZGV8J3Bj
	Fw1BV6MhevSlM2bLdIHLv/OtKn4toybvde2mgMJDl97XIs+OYg+f1VcbaAnpFpcQeiF50qdpESA
	tlDdzggnpXHhSQPLIUtMJSnHTqdqhHwiE07nwO+s6HEASgl5o0RhUjHOjLxXLAM+ypKXQEfh8zy
	s3+1ME/KaO+T2Sjt3gs5u8npXDE1wtQdssw9w+Od+XwIZOV3PgQ6JY1tOS3PT+Ukg0qHw+SusD9
	LVQY=
X-Google-Smtp-Source: AGHT+IHm3pCCuGfdEnUWjyWaHdgQ/lVnz80Qp+Z3x7kMtg+uofWAN2w8A7InbEh1tbA8ZUzXfJ0sgg==
X-Received: by 2002:a17:903:2407:b0:223:517a:d4ed with SMTP id d9443c01a7336-223f1d6a9e4mr60879475ad.15.1741189991761;
        Wed, 05 Mar 2025 07:53:11 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2240725fc74sm1944895ad.60.2025.03.05.07.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:53:11 -0800 (PST)
Date: Thu, 6 Mar 2025 00:53:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Return -ENOMEM for allocation failures
Message-ID: <20250305155309.GH847772@rocinante>
References: <36dcb6fc-f292-4dd5-bd45-a8c6f9dc3df7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36dcb6fc-f292-4dd5-bd45-a8c6f9dc3df7@stanley.mountain>

Hello,

> If the bitmap allocations fail then dw_pcie_ep_init_registers() currently
> returns success.  Return -ENOMEM instead.
[...]
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -908,6 +908,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ret)
>  		return ret;
>  
> +	ret = -ENOMEM;
>  	if (!ep->ib_window_map) {
>  		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
>  						       GFP_KERNEL);

Nice catch!

This will cover subsequent calls to devm_bitmap_zalloc() and devm_kcalloc().

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Thank you!

	Krzysztof

