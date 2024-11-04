Return-Path: <linux-pci+bounces-15962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE339BB6CC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C4AB21D37
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E373501;
	Mon,  4 Nov 2024 13:53:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F437082A
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728427; cv=none; b=JEasxaZdoyhV/TYU7S7qO52A64hyK/tJUhEf8mbYDO5iuPRUznQ200VGJCVJThWiUi2EF6Z1xmYlBVNupIiRMCEfQUdiirLSAtyYIjgpUiIi+4S+GNvPodxEYcoC72O59TKIgyh+6vipT2CnkMfESPI5GpLhVVCicCGyIFyXO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728427; c=relaxed/simple;
	bh=VtrBLrNDlbSTLYJ8/C9ol7yOAMhoRNxIzGJljUIykNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEOMF0GG9putJHFHpRqWM4Xf+6qpCQrG+EATisixAf3+yjlz9expU0GkScrE3Ms68qhy3FORx0NuKFs14HCqBGE/LzgHdHkOYW8FeWNzrTiaSBOyDa/DFJzmxPjHdVxobID9LwfJ6qmFghkRoS5mXFt9EyMCGX9x8znK1QjF03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720d01caa66so2493988b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 05:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730728425; x=1731333225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFPm1wKiGz/g6qOuYkyPYOKHC2EtJQ4kI+UbAy4vxFE=;
        b=tUlCgQ9roBnZRMZGJmPaxN65fjMvTNFnj3gfWm2TISFYn59L9UXpJ/LMbUP5V7jNvM
         S2fR5rqdlkTTMcAt58j0/ynv/SmaTnua8D0jh970Y39S9J6sRz/9IYn46buQa0nyk6CY
         uy3NSWlbZHX0l1lYZJsjh6YKpVSXHVzBNtLDkRb/hGyxeXAzv2xls4Oxx5FFh6g+YjYl
         MV6b0h9d/tdmDyGbW0bOuwSuO2lpVR5n2MY2UhXq1helTeGN8NBTK1D9xuaIUy0gZrSR
         DeXdq4w//cjohL014ObSHXKlwA1rzVGn6x5qGOlNOxXO3xOQiv4sF2XDuPO/DZFxANrC
         Lzgw==
X-Forwarded-Encrypted: i=1; AJvYcCXxnzlHs7klcV7v3BTZofuyVkh9OYReGII0h+LbyYOyFNVK0PW8dr7mcb1TC3o1eHvjpu/Cbc8rgzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEb8e9PF41KTBM4qRpudk72JJKEk9w5bu0dlYxfx2GcBVH24s2
	C6xv3QlDGVTeqPymrHTg+oS+tH02ws+cR9LYDZkuXwW3Jhv5xMn9
X-Google-Smtp-Source: AGHT+IEBtjW6CLpX8+zvq2ZP6m+Zxa2snYutrlTzMtMoNld+hzvMdtQt58ZfXjRwOLXuDN06k1kwPQ==
X-Received: by 2002:a05:6a20:341b:b0:1d9:4837:ada2 with SMTP id adf61e73a8af0-1db91e694bcmr19885123637.35.1730728424755;
        Mon, 04 Nov 2024 05:53:44 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a5ff1sm61234275ad.123.2024.11.04.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:53:44 -0800 (PST)
Date: Mon, 4 Nov 2024 22:53:42 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: 2564278112@qq.com
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, jiangwang@kylinos.cn, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci:endpoint Remove redundant returns
Message-ID: <20241104135342.GA2804960@rocinante>
References: <tencent_1039A1784512AF88CA1844804F7DEC059407@qq.com>
 <20241104133500.GD2504924@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104133500.GD2504924@rocinante>

Hello,

> [+Cc linux-pci mailing list]
> 
> > In fact, void function return statements are not generally useful.
> 
> ... unless used within the code for control flow. :)
> 
> >  	dma_release_channel(epf_test->dma_chan_rx);
> >  	epf_test->dma_chan_rx = NULL;
> > -
> > -	return;
> 
> Makes sense.
> 
> For reference, this surplus return statement was added in the commit
> 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA
> capabilities").

Applied to endpoint, thank you!

[01/01] PCI: endpoint: Remove surplus return statement from pci_epf_test_clean_dma_chan()
        https://git.kernel.org/pci/pci/c/3fdf564b21d3

	Krzysztof

