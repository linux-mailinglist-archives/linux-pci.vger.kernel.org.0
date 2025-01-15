Return-Path: <linux-pci+bounces-19889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1933A1236A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB40C1885B42
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA1B2475EF;
	Wed, 15 Jan 2025 12:03:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00712475E5;
	Wed, 15 Jan 2025 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942636; cv=none; b=gP63IkrLW3oW8AGLZzQerYL/8Ce1nySCSOMF3Zzu4FDaIpXm94fOIwQwO9EDR4pV0TuhKlU7hT1c09CxWfkA8RJDowFqibGCXTL0ZBdDAHv50TMO4mAuvmUSuJyrIoDsAA+wPcjJE0c7iJ+ynBT2AHzeIe1ITVwj1jbWpt441X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942636; c=relaxed/simple;
	bh=rYv21w1TNpX166jyKbxCBTg2z1ftliDbp6nskXQ9CbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1fPLwSrcOXCJn+dn5/nf6tYzgq2TOmynhcs4C5YI8FmrhPxNssS5oZ/pTiLvYcLqDqwZz/4s3LtqQfgkjOw1oWg6Nbeb0nkamJ5jgnEf080n1YgK3sJS80LVj3ix4u4sXRG0oWjHAZqKzyMMVRmPa7eOepho06qGw+ABZLC9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21bc1512a63so53806565ad.1;
        Wed, 15 Jan 2025 04:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736942634; x=1737547434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn2m3YvPKxsHqucofUHRKBClV54hrr7dyawjs31YpmM=;
        b=JETC3Wn0cGVGuqdyVkr4uOGheYxkwXyQRlUFleA47ma3pR2laeZnuEOymktNkceMGV
         Tsvcc0mmo25k2lSt8i11A5I2826U2e1i2NCkJC8/rXBQgx3H1oIpdKBQHH04dql/rWUN
         e42kHQrhQvaDpqUSPM44XYBXCIWRrvnH5ilzzbCohFMuDpOYTKJlgHqgYmcSTNUjN4je
         rLpivBYDJ2qajt1+Smgi1G2T8ouWgNv+eadI6Mcw2AltRiWj1KiJIEB9NPS5bYrpcKhX
         a/F++Rr4kOWivweaA87v5gbGMz0IJu3iKFNi1aH2VyIXNZJojztFB4rgq8/nFJkOp3Yq
         02tw==
X-Forwarded-Encrypted: i=1; AJvYcCVS4XohB4b9QvVgjxLmO8VKF6dJ2lgeDy4HXyB+o+SEauh9M78so52IDdBI+qmSwPFE2WOQuCmQkqTnz00=@vger.kernel.org, AJvYcCW14Ry/wtbn6xAqZQkPpthDWHDlHER8AH2SfOKJCVrVNEc0R3qzxC5W/ObuqRfU66MZgOPRoxDyNDU8Dw==@vger.kernel.org, AJvYcCX0Vv8p8Gt10B24FmLPF/0b7m38UMlPzZBk3eFhcaknWy5y225Bo46zVk1mD651lUnAfZmfhpu5GhnG@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeJiZnhy8VoH7IRSHaobnaHioPsqUxtZgl+9hHrN1gvQiw170
	i7cp0hc1xKalnZeYfmvtxuoieTjrGacxqDp6o+NCbOjs5SwyEyI4
X-Gm-Gg: ASbGncvHm93Yb7IVXC20aOCuYaeJie25vuNFyRaKVVQLvNQCSISBirdQLW5HQlRrLoA
	gDUlk46QhVh8RHQR7tLR2adgDKXgml+8HokvyASyCQp3i12Cy4yoMsaWhVt2R/pKhzwpF9CxO73
	3fj/TGX0tWyy1XkNzBVbzTOAcu2LIwvsWRV7YJchrjiqKtgzbVBRNa4k7A2XPXzXJp/G98ADyyY
	B6sdDNADm9Q+n138Om3aqJBP/vx0Q4p3pCkyofQWVf0TRCS4sfabPpNZKE+HpYJpbBIWraJlztU
	Ghwunu5ix8A7JIk=
X-Google-Smtp-Source: AGHT+IEYVToacHIhaLiuPZMNMw8ey/7WGb5On7+yKJ58yY4usQG65tLlT774MHHUh//xwlxvNtx6eA==
X-Received: by 2002:a17:902:e888:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21a83fc3886mr482072125ad.40.1736942634229;
        Wed, 15 Jan 2025 04:03:54 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f520sm81190325ad.7.2025.01.15.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 04:03:53 -0800 (PST)
Date: Wed, 15 Jan 2025 21:03:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev
Subject: Re: [PATCH 0/2] PCI: Simplify few things
Message-ID: <20250115120352.GR4176564@rocinante>
References: <20250112-syscon-phandle-args-pci-v1-0-fcb6ebcc0afc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112-syscon-phandle-args-pci-v1-0-fcb6ebcc0afc@linaro.org>

Hello,

> Few code simplifications without functional impact.  Not tested on
> hardware.

Applied to controller/dwc for v6.14, thank you!

	Krzysztof

