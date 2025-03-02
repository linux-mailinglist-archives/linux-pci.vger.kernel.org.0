Return-Path: <linux-pci+bounces-22722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948B4A4B415
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 19:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7FA16CE63
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6912B93;
	Sun,  2 Mar 2025 18:32:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859141C8FB5
	for <linux-pci@vger.kernel.org>; Sun,  2 Mar 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740940330; cv=none; b=CQLZAjWwjDxWqq1UZ8TzeH+qoSBUeNKAdcNXgiYTnC4vuhBybGnWcAXW5GWLzrLWZfzrfGE7oWelOQdNyUrQrb+2DiKnRI/6ecy2N9K61OwZLMWZYrGPEqpSIcLBwNU9TIfh9xbjFxeGwaqyHna4f4DLkgYR0gjtOzbtRZ6x4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740940330; c=relaxed/simple;
	bh=/BQCObDWyZdSj6u2kmmZmHWBD3PwJEecAnAC9b6fZPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbDwTD2K8SXXt0pR6MYyxgtKOc9Nst0e1BAIhZsS3gK1FOCdOJgGPEu03sWUfALEz9Bph5KJF8lDZdQOHgovFDEdLX3xYU7umo2egN2HalRSy7iBBZZPUYmra+7tZvT0ri/K0DmsYz0pfmFxTnBOZiyR1DMAIaGkxWqVUJF8AEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22328dca22fso55988425ad.1
        for <linux-pci@vger.kernel.org>; Sun, 02 Mar 2025 10:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740940328; x=1741545128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5MqLjNvCTNhKVILXY0Ywfwl/h8zGiL3IHF1PQ0o/2c=;
        b=CEyxOy6HhywgWeWuLzla1WCAEYTqvz+oS95mN+lIDqGY9YUmLfFQwD4UxM/srODWhM
         amoUXjhOJyEQJlGLcsUSDKysVmjTVbiAZRIURRYDXpdjE9Q0/UCLPvVwTLltQUV5P8dq
         5vSLJxPX8m9EHb5sK7+ypkK/Wv048j2XgVVlKQLN5rMjTZ+GyDSeNKL89LUrReX9f6Jt
         PRspY7NaiBaNxA9f8EWIbPZLWdD7p0cupEgL5oViT2dlV8PeVfQTUPGqUrsy0mHxhZxz
         podzQT8K5AcvdTwT9zk/oRUyen1BzpiFPPoLxVDQj35KKeYgVCEun1gSDu2oi/uhCM+6
         DyKg==
X-Forwarded-Encrypted: i=1; AJvYcCXXq5eozZh8DWAIGv4PLeQfUcorlXXfwaxDpVfnipiFPOSZ0thapHje1GdEAWttGb93GeFK+7aZkhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuInQElLEx9WwZIsJUXszCsja4lNVFEAFANBo7I5XHtQiPqss
	UvKQ+hjAP+B7MclNlHumTFgA3LASxbERgVPt1aZYFH+I/Jyvm2Pz
X-Gm-Gg: ASbGnctcNOelV5QXzc0FDokLk3pSYWdjAVp9iR3ZV1WkgQ9bjR9oOf817Ni5NtMNzW6
	l0IdERK3AO3kFgpcjB8r4k7kgk92x3uVjpv3y24VSzALXeM1l/roIRselDgj01no/Hyu9zqqI73
	v/eJJSebJfU+lV0RKtPoqI+HtgGAPJyAS1pxOXj/YGi8Bo4Q3rF4Ef4gRJ7JW8vJigVEe4H/FTG
	DhPe5Ab+vrE6+7oPB5SjTdBgBmnrWUufHrbxtvMWtMOaaRRu+n8tbFfq21vnzcEZQuUiT/HA73H
	fp1pSrDHBNLq94gWGE71xKPBoJ3HBt5qB4jN4P4xidwQ1xLhVu3v2aTrKBO4PY7HOXFJQAtkiq0
	2BtU=
X-Google-Smtp-Source: AGHT+IHC5hAyiX+irC+SfeQoVAdvTbMLAx5+65XZHdRtWUaP0ja3rB8oBJxdb31oNsq1xhx6UdjghA==
X-Received: by 2002:a17:903:41c9:b0:223:66a1:37f3 with SMTP id d9443c01a7336-22368fa6d3bmr179068335ad.22.1740940327687;
        Sun, 02 Mar 2025 10:32:07 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2235050f3c6sm63561425ad.210.2025.03.02.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:32:07 -0800 (PST)
Date: Mon, 3 Mar 2025 03:32:05 +0900
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
Message-ID: <20250302183205.GA3374376@rocinante>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831040413.126417-1-zhangzekun11@huawei.com>

Hello,

> Use _scoped() functions to iterate through the child node, and we don't
> need to call of_node_put() manually. This can simplify the code a bit.

Applied to scoped-cleanup, thank you!

	Krzysztof

