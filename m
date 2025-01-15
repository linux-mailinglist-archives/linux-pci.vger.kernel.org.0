Return-Path: <linux-pci+bounces-19895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE05A12507
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B301886441
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D715224A7CA;
	Wed, 15 Jan 2025 13:40:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003C24A7C5;
	Wed, 15 Jan 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948448; cv=none; b=KUffXqfaFU6+Ubx3oAYVzqXT1UwDSoeEHVJmZs2yaeebUCCjlkr1IUxg3meFCDJe6daxhKBnkR9x7T81RgthIeETkmzb2xpus1sxWeUeAqS3QV0EHdUWMzhMjGIt61IFWM7dVf+oiJ2Zo0f3QKfKUpufOUDVU1RxAFutVy8e+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948448; c=relaxed/simple;
	bh=ISRDE4tD8KT2AQ2Zab4eqiKfiW9C+Hfm8FDKxGol9EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNgqIs7HVTDZ+P95X0+DicJpsbRCtJOXuoNy378yy3WWjCDKkdA5vuukqV326gqJ77ebU0OkaWQD4g5uCKBC3XiC6hIpxABh3ZUvOnqVoGyC5/23BH39i8BZraDfZIdrlMMYEhe/8YHxMcDh8c8+Cundh8smWNKzxnpel3g5t2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21644aca3a0so148844275ad.3;
        Wed, 15 Jan 2025 05:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948446; x=1737553246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjRxHp95fgWw/A/HfteiujvMA9qxAfC7IB/XFcENGNQ=;
        b=MTqPT71CIuSHJbGTvk+8CdZRX4rx1KYzNp8BSPKitpw7H9ysh277f5NHhQjHj/IUYC
         ILRmHq4ccX/ZgV75dgi+FZKz6Xte7CiVyUemk7m7/7udTnr2DsEwtFi6S85eXJFlnPfl
         1o0i0UAamEbquqeALJC/k/YA6BUlmLzpra13F35OoCVdvK30LvfpMGNNjhZszjgbHIBI
         dMdXpMdtJK2ix+Brg3HoWGMgRMpQwT/XS3PAss/Ep23gLoLhTiYtKBs72dVpL1XzM40a
         8X00N4+CXuFYHtaHtjIYc/36pLi/txBrtoA98Y8AI2+/XQpNoSmHM8ogZ/HtqwjMSmpW
         Dflw==
X-Forwarded-Encrypted: i=1; AJvYcCU4IHkahsn681PmVzBaZQUytsPmxnfqmCQtwmX7YrQX4AfPcLD3/2FzDDAvXxXK+uWyUenEdXdIcnjm@vger.kernel.org, AJvYcCUtWbJQerRU9iEp+Sw36pgQgf6MPmlCodjX0Nog3nkznPtGQJWuJD/yt3mDCtzvwwsRvOq4os9A2SHsdgwP@vger.kernel.org, AJvYcCWhevd9DqC3ANtZEIUTfXzl/zPEOdaDg+pFPkWSk3742X2tb77U+tFcH0FIktxtzGheXY1gYOIonXKs@vger.kernel.org
X-Gm-Message-State: AOJu0YzISucblrBNlCBlLFOJbk3fQLDIBH04qLnDIe9YUDNIV8sbSp9n
	dhvlGw4QhHXsSLj/VoNOvgiTmQa2EPZi5XiNx/nC95Io8KgbpI+X
X-Gm-Gg: ASbGnctf1UuFindSlGZiwwnpqmayFwtXPug6nWC5zU9x9yEMAKuSdPTOdhUqnNBYi9I
	6j1GwhWaxO8UC9QVYTrGl2LMUKMqFbkf7boGkNG0zGU/pJOy8ImYGa3Hqa8CHgb39bkLhtMHoDV
	/T/K1zBfF+PG1428RP4CQK3xViCwUo6VTyyRh8J5sYt5t6gXRil0MKCF3GKfdpb6joViD11G8P1
	z5ZaZPPS/Z7+QbsZUWatUR8MWeoLY1nu30y6NpmJgVsBSyptggb9QiRycSeZtSdihzZLuTdohuR
	dtWOBVnOarnOo2M=
X-Google-Smtp-Source: AGHT+IFBc9u2m9CIKKe0EemdS8o4PhYCZliHYxexP/9pM9Xw1hjCmQoL6ghLKLnHjOXUvJ+g6cNyvQ==
X-Received: by 2002:a17:902:cec3:b0:211:ce91:63ea with SMTP id d9443c01a7336-21a83f56f9emr450296855ad.15.1736948446445;
        Wed, 15 Jan 2025 05:40:46 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12f919sm82767655ad.69.2025.01.15.05.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:40:45 -0800 (PST)
Date: Wed, 15 Jan 2025 22:40:43 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	frank.li@nxp.com, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/10] A bunch of changes to refine i.MX PCIe driver
Message-ID: <20250115134043.GA1049031@rocinante>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20250115130406.GS4176564@rocinante>
 <20250115130609.GT4176564@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115130609.GT4176564@rocinante>

Hello,

> > > A bunch of changes to refine i.MX PCIe driver.
> > > - Add ref clock gate for i.MX95 PCIe.
> > >   The changes of clock part are here [1], and had been applied by Abel.
> > >   [1] https://lkml.org/lkml/2024/10/15/390
> > > - Clean i.MX PCIe driver by removing useless codes.
> > >   Patch #3 depends on dts changes. And the dts changes had been applied
> > >   by Shawn, there is no dependecy now.
> > > - Make core reset and enable_ref_clk symmetric for i.MX PCIe driver.
> > > - Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
> > >   i.MX95 PCIe PM supports.
> > 
> > Applied to controller/imx6 for v6.14, thank you!
> 
> Richard and Frank, please have a look at the code to make sure that
> everything looks fine to you.  There were some conflicts while I applied
> the series, and I want to make sure that nothing is broken.
> 
> Thank you!

I moved this series to the controller/dwc branch as we have changes there
on which this series depends.  Hopefully, this will solve the build failure
we've seen on our next.

	Krzysztof

