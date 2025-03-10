Return-Path: <linux-pci+bounces-23318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84B6A596A3
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 14:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CEA1886EE5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF722248A8;
	Mon, 10 Mar 2025 13:47:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB21F956
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614444; cv=none; b=N+LQnxD2JE7PvLoInmDYxMA6J3d7OdRHkT6TqErC6LMAwFc0bmgR94JMBvix46oxRvGtl7wAzOqC0DSLq/vXub8+l/YX/cuuqOE69qX8sWjGUO+PfGmXFMSvYkTHDenehaDP2tLQjqVFBrLPYEAK+aX81uoLhSjPGBG1qsQ0/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614444; c=relaxed/simple;
	bh=CZdt5+tfQLk75gkcRI8kr9N6rK1uMhfyIkSfZLv+RBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8JbwbALx6vMLCEUJj9KqMWag6CtWn5k6oKSBRTT0zCYrOuOK7MVoPO18xhubbdgNrRBjSoubxX1GafHlaREFjvQozX+9x/PzmwO5W4MwhqkfCkS1AI8LWM8mA4eTbzhd24z5+LqL++uGMXjF0AUoIjBZsq03w5OPRa31IfrMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223594b3c6dso73959925ad.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 06:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614442; x=1742219242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4k6klsth6WCTEbTNpydY/KbXzS7JbkOSm0KrO5vZic=;
        b=Mt6j3iJ9jquCt5X1CtU0105dTCYqCb7MSqrf/tVEnRMWFHjyM1pFd//SnJIOAta3VM
         wxOT3EWyn+YTbkK1lQjPlnccSBjwA31uk6OiDnS4HrTXheK7kxFo3DrQJGJs8TEkvozE
         h7AnDAKNOTt0aOaZnRnR3z7ZBYDf28/dmoSHxBoD4VAy9hqksD9xE3G+DCMK8ISYHqeb
         h99hvgJFXDs6Z8yH4QwKQvA3WybJrO9jjKK+OJ7DsqflqqzbN6RnyYxqoGDrIER2mE3/
         RfLTglF14Rj3E0AvSYzhTEej1MJq89CY1ObwjFBLeVFjzAb5VlmymyvY75KprDincW4A
         Kl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV56PLbyhWxwgODe8TeV6wpr44mz4SlIS3wY0/uj6Ys7CAe0DdKoNl6piOIiHs07DgRwdpVzAh5BRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOnFBcud7aYrPikNnWxVgkFGGDPX/c+v3+PWA7XN396P4GLU8L
	Q3kAG5vU0kTjVMzTuziZWyh+NVpkK12SXEF37uY2VbtrgtcJahG0
X-Gm-Gg: ASbGncuqbzHyy+BnU0a12RnsHG6gYrpvVPBMfmPhcsRgvKxsMOvBAIZwfPljgpyizg/
	qeJhC53AFM6BdtfDjX5gyhLG2UZx+sRpC4f49/tsbjV5KjaKd4lnSRq+lu2jOry2VsqT4InUMtk
	2qAVJtbtP8ISoU3uUd9WGzRCGD2i9vp4KGCn1KeDOb+0vrPfpWRlkv1orx0KKWs1TnL07UdqxRL
	KjMCwh3AVNchhX/eM6h6y7Zc+KTVvtPLcM1OMbWG3sAk8bJLJS8OVimvtVcGN52znlILNY7pP+U
	k6AAdzxdrtcEmGa4u9cxmh07pUa7mPs8GdJU6VPnbPE3DRdFd1H72BU3QtjF8LBzeO5kVPrJ2RY
	2NrY=
X-Google-Smtp-Source: AGHT+IFeKHkY5vFQK1mPK5sfdOE87MsnmkyRgXtC0wn8i00IErmRJqzbRnoxbh7nNET4ndTWFLy2jg==
X-Received: by 2002:a05:6a21:7014:b0:1f5:7ba7:69d3 with SMTP id adf61e73a8af0-1f57ba76cadmr6227372637.15.1741614441762;
        Mon, 10 Mar 2025 06:47:21 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af45fbfa6e8sm6053104a12.32.2025.03.10.06.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:47:21 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:47:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 0/7] pci_endpoint_test: Add support for
 PCITEST_IRQ_TYPE_AUTO
Message-ID: <20250310134719.GA3334010@rocinante>
References: <20250310111016.859445-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310111016.859445-9-cassel@kernel.org>

Hello,

> For the PCITEST_WRITE, PCITEST_READ, and PCITEST_COPY test cases,
> tools/testing/selftests/pci_endpoint/pci_endpoint_test.c unconditionally
> uses MSIs, even for EPC drivers that do not support MSI.
> (E.g. an EPC could support only INTx, or only MSI-X.)
> 
> Thus, improve tools/testing/selftests/pci_endpoint/pci_endpoint_test.c to
> use any supported IRQ type (by introducing a new IRQ type
> PCITEST_IRQ_TYPE_AUTO).
> 
> Note that it is only the PCITEST_WRITE, PCITEST_READ, and PCITEST_COPY test
> cases that will use this new IRQ type. (PCITEST_MSI, PCITEST_MSIX, and
> PCITEST_LEGACY_IRQ actually test a specific IRQ type, so these test cases
> must still use a specific IRQ type.)

Applied to endpoint-test, thank you!

	Krzysztof

