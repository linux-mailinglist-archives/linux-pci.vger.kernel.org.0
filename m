Return-Path: <linux-pci+bounces-9449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1591CEDE
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 21:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB9F1F21B3C
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 19:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AE2CCA3;
	Sat, 29 Jun 2024 19:43:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370F139CEC;
	Sat, 29 Jun 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719690185; cv=none; b=dG3lEFL3XEwUzEfK6tD+offd3TtdZmLS+YCQHMzKJF7SdakGUneV7seK4PFTk9ohGzb4TNOkG0Muvb5q+KDst5WYCjdKTKoz6dI/K8q6VqHj3EzkkrhosNnD7Eqo2aMYozqDFNxZ0wfjsIMuFVTbMp4/x+qKGlWcmFwH3AK6OQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719690185; c=relaxed/simple;
	bh=nhwi4gcwgu0xtQrPsDRybNgtnem5yBaRC//rlzUdWeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg74igr/8gzW7TpVAKl672r495lwI2joF2B9zM8T+Q3ZfBUuMJkGU+zUGoStfrv4ugrjRhjYHKsSpw8KF89ZWUY+qV764HGwKvoCmM10i/i9fNhRBX/EGue6ZRTB1caCkRUNwqHJOqGRrTNhZWndqPssA8Ep/Mxyx7rvdpNJa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso1209007a91.2;
        Sat, 29 Jun 2024 12:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719690183; x=1720294983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WynQzZSUU/w8KPdCct9eOprbR5KvYk1+h2UcUDzuRmM=;
        b=bfR0CaiyTkQ31QW0fTSm8EAQHMlwHyadruBvnnWJxutXtRco011jraAYnR0wq/EHRN
         J220ONdqLZL1SxbpL8VhCuMuvKAagOUNnRaZ5esmhV4ap7dv3eMcM5S9V2dCqLrNvTOf
         1TU7s1pF0tcy6zIXgM/3wqmBg5CmZ4TItQeZwCbWtw3ZvMWUeaqqv8yT+DZXMgiDi8jh
         VU14U4LZb/lRi1rEUvEn/Jz9oCC3nyR+Sdk1ojz2LyFecLH21kZp8IcOvApKambM8FZH
         Zj6SNVHwVsP83bKFAlKyu5Om7syvmXBoYmYrPuBZBD4yn0RuWTqS1YOIHaZ0dZgrmxq8
         NAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiAlw3Vg2iKAbYcHSb0pTnY8axPHtxF1jFjOgQ0rCD+/tWzBoh38Rtt/Y99xzDLXyYO8olWMm6qARMeGobcM7+uD2jdrKmd8tH1KIbbBVgNRuXVtToF3rVB0F2t1D9fp1XIzDCnu+xj6DQOOs=
X-Gm-Message-State: AOJu0YwTM3OsifPa6Nc1pGYCxVDH1YIWFPQNE1XawSUpl0k6M2Yz4vvQ
	2ipSE3AllSROSdAfNSqXIN0GyP+kNasgnAIKtuvQK7aX4GOX2t+H
X-Google-Smtp-Source: AGHT+IGFYvXOzQWJBJdARPunDQ1IpecyTxzRllb76fgZvqeaQ5L0ODxRexX13mZzXu/UEjDeaLkgAA==
X-Received: by 2002:a17:90b:1bc5:b0:2bf:9566:7c58 with SMTP id 98e67ed59e1d1-2c93d78e1c6mr1217178a91.41.1719690182813;
        Sat, 29 Jun 2024 12:43:02 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17c26sm3727277a91.6.2024.06.29.12.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 12:43:02 -0700 (PDT)
Date: Sun, 30 Jun 2024 04:43:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v9 5/5] misc: pci_endpoint_test: Document a policy about
 adding pci_device_id
Message-ID: <20240629194300.GA2249818@rocinante>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-6-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611125057.1232873-6-yoshihiro.shimoda.uh@renesas.com>

Hello,

> Add a comment suggesting that if the endpoint controller Vendor and
> Device ID are programmable, an existing entry might be usable for
> testing without having to add an entry to pci_endpoint_test_tbl[].

Applied to endpoint, thank you!

[1/1] misc: pci_endpoint_test: Document a policy about adding pci_device_id
      https://git.kernel.org/pci/pci/c/1947ff399bb7

	Krzysztof

