Return-Path: <linux-pci+bounces-16057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F99BD1B8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 17:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3983CB24FB2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA85D16DC01;
	Tue,  5 Nov 2024 16:07:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378ED13AD0F;
	Tue,  5 Nov 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822847; cv=none; b=mRy98GPQlAvTQpbV+sfBFtLDxLj8ztmq7r6hgdeb/s/6empstuZBjJjslTX74+lNZ/hICFzbx2fxE7t7yDUJd1RsFDzQqxTS5cbgklk+j1PbGgZkwz6GRjeuIVjYRriiKpXOL0RRNDCOJVhLdzV2k0tk3K2Jg7nkrqBn0xtUaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822847; c=relaxed/simple;
	bh=VOFgJkIl2yKGWNfdb8bTJ6DOkAjPvxkFk3z/mhG/aTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXb4SQp/wDwXfN0u7FNA+kp3ThSOJTlTdihJcO2xtFwClDTk1giBHV+ao6i8LdExBJ4eotQsVixrxBaKWkth8MWh3MqBqWOXshaSd7WKDBTKfsDaEJQJtbk2w1aXtvj7PPW11nch5+9so30bSxTt+8QbQEGLlpiLkDse41d5rGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so4583074b3a.2;
        Tue, 05 Nov 2024 08:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822845; x=1731427645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogf0K/Q34hA3Cxoo6TgX4WGjXQUWYD7sZ9PLkWwfk60=;
        b=e3QkcgVRRlsla5j/t2pLx5ckmSFcb/OiVJkpCEIYZiORPp8ItGc0+zDTjRbO63Q+mA
         VzEHi0BftS1BBF/nJnCIN2QGgvxM+Uzgf1/FK+WSM2bUjzX69FY3+BClVmqJYSHpBePq
         8OrW9QfS/CcwvTXVsINvU9GCgCcYPhtgyv6fzmmo4dhoRvnrnPcon94WYSRTAZNReeHA
         I/PXOAMCv+C4uDRk6h/4LeFJHGNcbUN58umz9zkVMo6v4FsR+r/5d/zwCG5+csX1H+PD
         fFUyEnT83ptZmLM9b/6TbCPlPkth7iIraoX6ymHtV5ClcEDmiSQtvbnFV4bNVmcIw5TH
         TVCw==
X-Forwarded-Encrypted: i=1; AJvYcCX+WPmuomtm1rUg4T9u3RNLmjtbbH8jibzAl/Od83ZTBmbTqroNjCoSjQ4/c1+F9++Dl2RtLpuPJSzlc6U7@vger.kernel.org, AJvYcCXMROGKR8dvQVEWBZ6Vc25OP919ut1dztYI77qfmsGDLlexuHvQpkIodlF1FPpvVB+HJbldotFw6sEx@vger.kernel.org, AJvYcCXdJlKnjLJmqPw4/38QUxpbiNl5cVTYr/LPOcpzRztfpN85w423P7Ay3hLrKD0vpJbVEcDrF0d2I5wGTgWm@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkjluD+4Iob9lB/vf+YysATHTdUr0bZFtdv2wpk9fh7JECajy
	JlJfCoJ676jYjBfwTB984YukUY0NlvvzBiQPCGEo1O99It7MwOWo
X-Google-Smtp-Source: AGHT+IEnlS+/GQcAHPve3vyaQ7sB9wUbUDXU8ulNK8i1FEUHfJF4hri3CQgbF697cHOdDs7H4fpD4g==
X-Received: by 2002:a05:6a00:b86:b0:71e:7c92:a192 with SMTP id d2e1a72fcca58-72063093594mr47302502b3a.24.1730822845521;
        Tue, 05 Nov 2024 08:07:25 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2057f2sm9877889b3a.87.2024.11.05.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:07:24 -0800 (PST)
Date: Wed, 6 Nov 2024 01:07:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>,
	manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, dlemoal@kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: epf-mhi: Fix potential NULL dereference in
 pci_epf_mhi_bind()
Message-ID: <20241105160722.GA448500@rocinante>
References: <20241105120735.1240728-1-quic_zhonhan@quicinc.com>
 <ZyofRAZoAE5IgCVi@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyofRAZoAE5IgCVi@ryzen>

Hello,

[...]
> >  	/* Get MMIO base address from Endpoint controller */
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmio");
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get MMIO base address\n");
> 
> dev_err(&epf->dev, "Failed to get mmio resource\n");
> or
> dev_err(&epf->dev, "Failed to get \"mmio\" resource\n");
> 
> Note: &epf->dev instead of &pdev->dev in order to be consistent with other
> EPF ->bind() functions.
> 
> With that, feel free to add:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Thank you Niklas!

No need to send a new version of this patch.  I will update it on the
branch when applying.  Thank you!

	Krzysztof

