Return-Path: <linux-pci+bounces-4091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C2868C69
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B971C22D50
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04813698B;
	Tue, 27 Feb 2024 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjBbFQb4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B76137C38
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026806; cv=none; b=n4L/aXQT66AbvHlIcm9XmNLVnOd7BOi4UkbYr88gDaUryNB8VOJ1np9MMtBL7xbLV9+Hu8ocDosgpzrtQIgsKmLCd/YbadownUVFtKqhc4jFtRvSYRwi01H7ZifEU9G+VpOI5+omLjCUSSByxte8SbNMJcm1qQXPFNGkGjnUcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026806; c=relaxed/simple;
	bh=3+ZNtgHQRUoNosFfdwCa3xn6CEyWkN2rQFg4cSs0icI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHsoF+xlKkqqr8zcKGdYD9jRdzlKO+3FaMJO0xwx6TbmOCUo8LYrKbE45dU/uYdCfqG0TCOddNH6Y9fkoD4I3xVLUemHs6IGAOs09ByluICngXG8sC4r0606I1MvTEMbVjcOmcCJeaSx/0ciw2+BgRF+sDeeQ9VYPr71ChXzHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YjBbFQb4; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21e9589d4ffso2496911fac.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 01:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709026803; x=1709631603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J0Uzq3zCfOPNhBIU+WNniQqVjPv2rLyWO3+rGzwIeeY=;
        b=YjBbFQb4w3pZ3ORYphiMBNWdoMXXczahiPwLHXSvdfKYk1z5Lr3PC3SxarR223mmjw
         51tAVJbPWUuxHWbPV1A3hFZKzvBoaA/TMGtxyXuCj+/KCIVRC2zv3JWq4RbOFbEQzs7n
         N7Npo0L4078stBQEtU6tXg7GJHX+FkAaigHnLjOoeNnvnbGigzGO62uALqhtDVUT9FSO
         joMJOYYieDBUsEXu0UNw1qG745AGAT1BE6oaPxT7EjliTlDx67Qw72tFOR5+vXuwicQ1
         PAlm/CvEgmUVk72TNguFGJClZ90pWpoQA8P/kaIL1i5Q1JMTMKxdQE/EByXj6lGRxPjO
         9Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026803; x=1709631603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Uzq3zCfOPNhBIU+WNniQqVjPv2rLyWO3+rGzwIeeY=;
        b=jttZvluvlLj79Ug/EIpJJ9BhWV/7HdNPfCPPJKAAStNoZjViEBNz+/fRsfYi0+O/Go
         4baYBSptlvNDMlxPJ/WxygNzWt63mYNtUEU+/KTHjEMdFIFbtw7P6l8trfZjJfY1NQY/
         dTF8UzAad+lxVCrkCpg4iEXLZHTWURhqc1e2sq1jOEUJSD0q1R3LdVgevEY43pvSDGBp
         utQwz29JR7wOSgcbi7HHg40yL4lRWrzY4b5z+3hb54iuLe38s1pyR/wCaHU9mkB6xWYM
         I5ysfwmo7Un22kOMFxxz7j47PqPeBbOg1RQZYUl8gxomS52SoEr01/YKjQfC6+YWlJnD
         DBPA==
X-Gm-Message-State: AOJu0YxPYRh6mm679oUFORgNGSNdd7auVwIPhYUWaJsif8CRueYgzDln
	xAcmBAHkMTA/uTWjUjAYhkNzVry5ICgaZ9+dpHiq713EIJb9pfjxhFjrjFeRNM05WolOTDD+Jh0
	=
X-Google-Smtp-Source: AGHT+IFKYfYpHuIXnzY+7RUWDbztwmYbKDzHIn2fEabMbrtBqW4me9hFxoAkVavfJMVt7hgnhuD0rQ==
X-Received: by 2002:a05:6871:788a:b0:220:195b:8633 with SMTP id oz10-20020a056871788a00b00220195b8633mr4866772oac.5.1709026803579;
        Tue, 27 Feb 2024 01:40:03 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id k25-20020a635619000000b005bdbe9a597fsm5312115pgb.57.2024.02.27.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:40:03 -0800 (PST)
Date: Tue, 27 Feb 2024 15:09:57 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: =?iso-8859-1?Q?Ing=2E_Radom=EDr_Pol=E1ch?= <mail@radomirpolach.cz>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI-e endpoint GPU implementation
Message-ID: <20240227093957.GJ2587@thinkpad>
References: <11bRGBmeRj22pJZUyP2a-6-cKdYhSVPGtHAdWNpCQ--bqhWb4d0n81xlSQtDdQc21UD1zKAvqVwH45gcemleu8bk2aJtcBZ9ElPqkfvVsxQ=@radomirpolach.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11bRGBmeRj22pJZUyP2a-6-cKdYhSVPGtHAdWNpCQ--bqhWb4d0n81xlSQtDdQc21UD1zKAvqVwH45gcemleu8bk2aJtcBZ9ElPqkfvVsxQ=@radomirpolach.cz>

+ linux-pci

On Mon, Feb 26, 2024 at 08:05:06PM +0000, Ing. Radomír Polách wrote:
> Hello,
> 
> I have seen your presentation on kernel PCI-e endpoint drivers:
> https://www.youtube.com/watch?v=L0HktbuTX5o
> 
> And I would like to ask if you know of any PCI-e endpoint GPU implementation or related source.
> 
> What I would like to do is to emulate GPU by writing endpoint driver and offload the GPU rendering to GPU integrated in the SoC. Basically take SBC that has SoC with PCI-e endpoint support and use it as GPU.
> 
> I have found several sources for PCI-e endpoint NVMe drivers, but I have not found anything about GPUs.
> 

Please look into virtio-gpu implementation. We are planning to implement the
virtio support for the endpoint subsystem in the coming days, so adding the
virtio-gpu driver on top of that would be the way to go.

- Mani

> Sincerely,
> 
> Ing. Radomír Polách

-- 
மணிவண்ணன் சதாசிவம்

