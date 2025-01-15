Return-Path: <linux-pci+bounces-19880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE652A122A8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182341887087
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DC01ADC81;
	Wed, 15 Jan 2025 11:36:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF41E9907;
	Wed, 15 Jan 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940980; cv=none; b=Ujw0RF0DXtKYLOCCPo+ts4KKYWeeVVGkqdwuSjhLyugNw/4gwxmJOk6zdl5EUMVuQY9rBsO4dbTj6jDpCvO0kkyFR+bBnArIkpGkbxSh1lsnMGFAlhnsPQ+tUzvcqBsbiu8io4/ErzbxFmLTbgB/de5VFnDJ0tdEcdESgufa5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940980; c=relaxed/simple;
	bh=A5yd9D1gOMuTE2YOkqmGc1BQL9EVN7yFGtjLhuThj7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUGq/oRhV6FTpY/zL/mOuzO/7IOGSyRPbTc3zBin57rKsuxgumNX5dzvToWhdntCTKjUxsEoW8kayMKXxHnU7Ubu3fgTUDxR8506wlOGC9RHckys9PR2tvtXygVNEhUZiBMKHfcinfxO1iTdUHInajLq/mWiy7MdE7n7uB9W5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso8999070a91.1;
        Wed, 15 Jan 2025 03:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940978; x=1737545778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIFFbsZqBieutliFbyp3ypX+HbF3+a3W4330zsjDEE8=;
        b=WKZy/R9dea/ge20Y8CPPrmQx12BeVXzn9yeTKxCl1oDVGT1Wzup1liNh0lPRSIhHyB
         iYO0qk2LuHLpbu0teng8gYaTSRN3Xw1DiOdEimPt9hUkMcEug/jYAwFIy9qZxpHEwRwm
         1Ih2ugSOIXf7f+8NWvfpS1jQo7Tp4gRp32XmaJ0lFImeF9yFj0bchWkuIipspq/WhTbW
         5iHoIeVAhgMBFLqy/UZvYERx5JDIebOZsiaK8A90bjR+wBYdCwf5jd5E9PSSBOwUwsNr
         a9N/Ox9cGQC33UYxdbsFUPeUWO28F2gxPa5de19zI7y6PuDOIwOtn2E6xI4+9ZLETgvL
         7s/A==
X-Forwarded-Encrypted: i=1; AJvYcCUlAguVqvrU0eyepwcgsQ1MjP7eWpEePGP2FBi4rzrPSNqfbPU9GJ8QrYES594QT/2xvg3C0ToKx3+90c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4iC6jxLhINAQTCRZfk51kGaqAZKkGbh/lcSxOgCRgDQBOlXX+
	3zXB+MhLDdFi1aGyy8BA/s/QYLBqLvO2+XZ058yDEOnMTG1bWHzE
X-Gm-Gg: ASbGnctPIpTaVmcPsLijCn+av6nS4ucYgykkNtfR0MvEgBfSVzLn1CqJaT9nUNUmphe
	m69ZszF40+6PV3xy1nPTwMUJnJIe6gofkOjJNuiHd6mTDWMD/flcepBI5sev4c9/YheBg7m9luE
	AsTUJ34SAojiQpERq4aFun8/vzTgCLwmAbxh30zqUehwy2TZCNTjbwTS5qQiX0ODejK/AhnyeH+
	hj3Qf84GhRL6J84dfxy3UehRAMFFYrhwVkyTrYxSCmOE3KU+gIYKWOXysZA+XrX9W7VTfPk0A6z
	1smgeY4lZZaXmB8=
X-Google-Smtp-Source: AGHT+IEK7rjz6qhNuQ7rx/oNkUrYfXzEvsadphYiOodj3nx68Y1BB3k9zcVYeASzuI2b92b2inf6tg==
X-Received: by 2002:a17:90b:3a08:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2f548ead814mr48440823a91.12.1736940978148;
        Wed, 15 Jan 2025 03:36:18 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c20abc4sm1176691a91.34.2025.01.15.03.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:36:17 -0800 (PST)
Date: Wed, 15 Jan 2025 20:36:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	pali@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH -next] PCI: mvebu: Enable module autoloading
Message-ID: <20250115113615.GN4176564@rocinante>
References: <20240903132311.961646-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903132311.961646-1-liaochen4@huawei.com>

Hello,

> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.

Applied to controller/mvebu for v6.14, thank you!

	Krzysztof

