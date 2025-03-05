Return-Path: <linux-pci+bounces-22961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8DFA4FD91
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 12:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE3A1886469
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96546230BD9;
	Wed,  5 Mar 2025 11:25:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45D226D05
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173957; cv=none; b=CQUIRhaA7NTw8D83VxFphF2ZxaToOYT0X1Xhy0AHMYSo37CX40ahtCS79LJyfEXluC9m0YhT/SBYtYOgHKEkBzbXd848tRCM1UHR8Ugrt2uQlEGmsNqWZJBBJxCg2DZLQ0czIyuQxzq7sIC9M8JHZSOy8z+qabHq22ljczfUvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173957; c=relaxed/simple;
	bh=dGA5wr12QHsoFi8cZt6zfWDA4X3zOybeuZsXoBtj1hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mswjRGrgMLNdTyfsUc5UGMpngBh/0hb6xIKLHKEicEeXJBRIXLcRYq+v1Zkvl6TIuhPAJ2LSxapz0gN5OmEV1XrUO1orpt/biNxp59P6I8I5VIuGhoYM/EIlEAGOB0RGANGwY2B/kLKkCogWkFGz1wVBZFlwZ9eSABa83qeYFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235908a30aso118793245ad.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 03:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173955; x=1741778755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/+btQZ2ibvWZ2PrDyemX/Cak0sdAy4xGkgjSA38rnA=;
        b=aJYi1ZgiP9PTmhQ9S1XattV0uBHu0eSjsW/fdPitOAZmtD+x3ATcefCIumjyLKRsXa
         8DGp+xo+sdMGgyTqjz2e30bRhYBnx0aQexLO16UeIBQLloGd405RFfUbd8FtngJwtH6l
         Da2V/06H4ewB2aft/c3BJ+mBuuxlPnyfKbGGzDcqpyipdORsPmydE9TDdXyi1dKegGRp
         BFShBKv4gJs7xP88bh1qc/u4r0GZCkZqwq5b4fJCf0TTePi2qX5xkkl/katrsHchWWe4
         pJPKeiItjvzG1KpcywAz6pyTrJONea9+RwkQVyOg2XXeLUtvLXIgN1n9aF+wSUiY2mgH
         p2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDUQIewAqBupcOHVkPY6Adw3GuDDmas0KLjQCo2wu4x4n9maVtE6+LymIyLfuSFm7QT2n/LMdOxBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqX2YMCy9aQ9X73TmSnAPe3zOa6Ti3Y2XkGW5aBELZcz2Flpo
	JOfKL1NpL/pKowXZYOB8aQkKM7tk9PbKX1rtd6P7Ot03Oij7uyuF
X-Gm-Gg: ASbGnctbRX2EZ0CNx47jJYp4zFnf9UeF8fXDpL+NQEFZnUmm1FHdpdxnZFQBuM7N2Sw
	XBzhZ8JHbQIDqlf3eg77U+qs+2SRcntrvpn3wHvc/gDmvVhsXm2z1oTN7ccdE0hp/kYpm3mi6Vu
	WzgWB85YcDdGOE0ht+dLBD/+9akggn3jNWQ89c1YRi+RPH79Nd+HNRBgsU3puY9mN13exqDQomr
	XvE/tnD3g+lJDChOEichWNxNgSZVcR2pCYk8dwxU4Lc1sjEORv5Ruk9+GICpoIS4Jsxo80yugq/
	z8QGZZEQwx0CNz2vWD/dE7/eNMEJrun5yj4OACETwRBTV35Ea4y2uMuDZk+napBouJbPvaDPpoN
	xdrs=
X-Google-Smtp-Source: AGHT+IETo55c6yEP6iG0j+lAkUONpWoPpzpq7kWHLgIoNN5Of9N+1KvutjFJp1sKgk2bFTD+NYYIhw==
X-Received: by 2002:a17:902:cec1:b0:215:5625:885b with SMTP id d9443c01a7336-223f1d20336mr43522675ad.52.1741173955364;
        Wed, 05 Mar 2025 03:25:55 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501d29d6sm111280725ad.24.2025.03.05.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:25:54 -0800 (PST)
Date: Wed, 5 Mar 2025 20:25:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	sergio.paracuellos@gmail.com,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	alyssa@rosenzweig.io, maz@kernel.org, thierry.reding@gmail.com,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v3 0/6] Simplify code with _scoped() helper functions
Message-ID: <20250305112553.GG847772@rocinante>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20250302183205.GA3374376@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302183205.GA3374376@rocinante>

> > Use _scoped() functions to iterate through the child node, and we don't
> > need to call of_node_put() manually. This can simplify the code a bit.
> 
> Applied to scoped-cleanup, thank you!

Updated with "Reviewed-by" tags Mani offered recently.

	Krzysztof

