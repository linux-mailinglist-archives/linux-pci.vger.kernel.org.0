Return-Path: <linux-pci+bounces-15959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBE89BB64B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB181C21FD6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AA84A35;
	Mon,  4 Nov 2024 13:35:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8A339A1
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727304; cv=none; b=GtR3dec9ncfHZTgueF/7JlbRRlOW9EF1igWj6ZSvcAojjhtbju/hmYSG66M0jC79Nz+DNiI2oLvCWmjhHtSY15Wz5av5X0LcS8jDkkEPo4PvQO1En/cp4FfZFqv5ti9oncq58zDevF+BEQ4Mwn8Dn6P4XeGrU0qtRdxZqiqgYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727304; c=relaxed/simple;
	bh=GHcxejL+YcCFkWijcW1sI2rfNWMMRIP3vFDNbnOkZpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5AfzLgEtX/1DAnUbPTKfNclQRw81nwK92zZb4nPCA1TRRA7VsWLZcW2uzsdjCKZsyZfDZold4fdjHlvyTx6DqPJefifMf8CmmmPRSOUpS7/9N/0AMqZQ4NDdX7BF/PNAa1SeVcYBMST9PuMyCUldaUBVJWbKHVyTggWvUf2N9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so3289032b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 05:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727303; x=1731332103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2SiXv3K7xgP3AzZ5AJCpHYIKr2/F2II4LPIdIdEm5I=;
        b=IRyfRYge9VctAEbuMyPrWh23mkWCtyeNFIcJ2zG/Zs0UXSlMS3SidjwDZc1l9a8DN4
         uv+GrrKeOZOgG9Fd1zCEIO6BsPQxeInvDgfDoPe6hAWQCq3bn40kdiD6atxxGLyFu6T8
         zaGyJELqzhgAO8FTmZUJY5nOpQGSnYN78XpI3JFSkQC0tOUsTjGLLscjYhhFsy6gKuAr
         T+zA3PAQA08zNBnxs4IbuPhpMxR0OzlQpIXwWYTdF7RbWxT/hyjcXxqEZEpN2zA97OzL
         MqLCS701e81OVZGBR8d6xXjI+8B1zijFviD7YiO8iOAMFU+EwIqNHOJiLCmUgsO/u9ib
         loZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRDaK/RoQW2HK14htSxj8sPcYh3QcUpd0QCSS1eUQr4BfXe+JQre5dA9XFgAhS/1igfvwGZOpFiHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzooJXsn1KBjRbHBZRsw+qc5TfVsBKfz66iluCeN5rM6aUFOH3
	WymjgdhremqqSlU7nHne+OmRKiMzEB8fAxT4z8LkG5fLD+mXK5iu
X-Google-Smtp-Source: AGHT+IFQBKUa18oPkPUMMtV+ITE+N0uRv25fltJtpMQgiB82QJrsflT7Jd+nt6fE/H57ZoxPSvFXMQ==
X-Received: by 2002:a05:6a00:39a8:b0:720:2e44:8781 with SMTP id d2e1a72fcca58-72062fb82bcmr42513842b3a.11.1730727302643;
        Mon, 04 Nov 2024 05:35:02 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2ecb8esm7698045b3a.177.2024.11.04.05.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:35:02 -0800 (PST)
Date: Mon, 4 Nov 2024 22:35:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: 2564278112@qq.com
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, jiangwang@kylinos.cn, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci:endpoint Remove redundant returns
Message-ID: <20241104133500.GD2504924@rocinante>
References: <tencent_1039A1784512AF88CA1844804F7DEC059407@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1039A1784512AF88CA1844804F7DEC059407@qq.com>

Hello,

[+Cc linux-pci mailing list]

> In fact, void function return statements are not generally useful.

... unless used within the code for control flow. :)

>  	dma_release_channel(epf_test->dma_chan_rx);
>  	epf_test->dma_chan_rx = NULL;
> -
> -	return;

Makes sense.

For reference, this surplus return statement was added in the commit
8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA
capabilities").

	Krzysztof

