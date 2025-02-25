Return-Path: <linux-pci+bounces-22348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02E1A442EE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450F0188E2EE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341362690C9;
	Tue, 25 Feb 2025 14:33:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EEA2698A8;
	Tue, 25 Feb 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494010; cv=none; b=YZRhBb3aepPgIiOeqHdNHeDZlHjuEmBGDIJQev7z+3khG9jdj/tXqoD4xZislTm6jkVJJckPKUJzquzes8/PlhcKQJumXYKz/xiIKIo14IDfgpNmeqPdMY6TEqiME/vQbr1yySxglURYQj11yBsw+ladj75fdvkA3eCNUo5vJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494010; c=relaxed/simple;
	bh=2E/xivADWUmMltm294B490hpFTUkS2KD5I5zSos4jPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJj5B9HYgdmY5mz2+HwytO8Nde87NVlfY+3mkBRS2W040hAjq7unL9P7os3BtpC5ndcAgWkxAKK8dZo29zUrUIPxXW+nrIXOClM/fIaY3g8yEvEWnGENCMB6yWCpbwybLMVHDUjo0C3QR1kd1roauMyPlIVuC9PJPvvyt9L6SHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220f4dd756eso119740795ad.3;
        Tue, 25 Feb 2025 06:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740494008; x=1741098808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfjw1HKQVvRq0BsR7wxCvBaXgth/Ba/pzPz08eLvgdM=;
        b=wSAvAissHnZ1Y7bzHhOIl+ZcSR1lwMG6fEl8rOB+iXwvOKO4E4Csj8+eltaHBV6H+e
         ZzTz+I5T9vq1TjX8PKUmGjECer7CMBEBvpYiBM35H25LASHA0PpzU1CxNR8L620DsDYJ
         95R9jN8t9rjxgwkQFXHlp7o0L3+mbTG+ujk5UjJLlqyXozTMJyQ7liXUIZX+w7ZHq8//
         tKJ1fijgMYLG9H6tccRTdVscVRNysGSDuK4FiUlnyi4StfkO+96qafv36MmituI2Wega
         Ls7Bm9GT+sZ/b/g65agKvcwF/NtYm3+azCkbVmMTP9j79+UDDQrFa0cC6g+mc3G1mrB5
         pOGg==
X-Forwarded-Encrypted: i=1; AJvYcCU/5VdUtPEIdnnhdZ/2srnfiE1uw317Q/CsuZiyLVlqBQoYyNguae/9069GZIyyEcCyQVmEONNqCSMXiwo=@vger.kernel.org, AJvYcCUgP3nzIwFPhImsHtRiXg+QWEl1J6QdglUujgp7Yk8RkOY6F8IR44XGFHOwdfOKlp1Fs8llCN/Na3Y7@vger.kernel.org, AJvYcCUnfRQ0ggnBxJmw6dOltDq/SbFqjFoev3RKaJkbpAvmZIxftIGwdva72MbK3bjhKRO0AXpugmsOXzHCSGmOOBv/uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/W5VnS2SvAIaf3vGHmAXNoe4scbqP1GRC8ppJnMlGxvAez6Up
	IbfAunvbgPgWIt6RmtYYQQfW+OQCel8wSKH2H2KmsiFK0VKAHo9SKkhW9IPatKQ=
X-Gm-Gg: ASbGnct+roD2vZOMlHXBDllK8zmnIQZX3Ar8qOFrQly5UzSrZITGgCjdGqU9hQqPo+/
	pH0rApUWkfO/3CN1+Qo7H43Fbl26ucwsWqO1sTxkR40DrNwkoKuIXKz5UQHs5Jk9QfrXgwI3tXf
	nrPeNP/C9z4hGjldGE7hTrSDTZ1BGWbLUHXm6IidttD8mVPIPKmQNuIbrJZc4Sb6TJaepQWV6UH
	jm88jjO5jkoZLSZMGp8E2UC7UE4bioxxm3VHbZUt04SRCZXMt4kWwx/+wMAabNy/77IxYYL+TkQ
	cHDV3oyAFdGoS63Wk3SCK45WiuORD1Y+lB5PJybLUeOLyem/L+CD83rCoX/H
X-Google-Smtp-Source: AGHT+IFiIC1p2JsvGz1HBLa46/0n3Ly+kaAqBACASxC9/r77WzUjMbOSLV/Jfp7om7mV9KcQCdz2UQ==
X-Received: by 2002:a05:6a20:d492:b0:1f1:458:fe80 with SMTP id adf61e73a8af0-1f10458fe98mr2109104637.25.1740494007946;
        Tue, 25 Feb 2025 06:33:27 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aeda75a224esm1420946a12.15.2025.02.25.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:33:27 -0800 (PST)
Date: Tue, 25 Feb 2025 23:33:25 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Message-ID: <20250225143325.GB1556729@rocinante>
References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>
 <20250221131548.59616-1-shradha.t@samsung.com>
 <Z7yniizCTdBvUBI0@ryzen>
 <20250225082835.dl4yleybs3emyboq@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225082835.dl4yleybs3emyboq@thinkpad>

Hello,

[...]
> Yes, it would be appropriate to return -EOPNOTSUPP in that case. But I'd like to
> merge this series asap. So this patch can come on top of this series.

I pulled the series so that we can get some mileage out of the 0-day bot,
so to speak, and also get some testing via the linux-next tree.

That said, while looking at the code, there have been bits where I wanted
to get some clarification.  Nothing will be a blocker.

	Krzysztof

