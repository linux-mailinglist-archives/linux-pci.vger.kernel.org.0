Return-Path: <linux-pci+bounces-19065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02FE9FCC85
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DF91882A0A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAEC381B9;
	Thu, 26 Dec 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtqCVWk2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C318E1F;
	Thu, 26 Dec 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735235501; cv=none; b=jL22Wi3r2zUVTNsgi5v3hm+soarYADipl22FDmw1enutIgDNBOfhKW+pH+GVgvZJ4X3b6PsXUc1JOCUUPVPeEtQ2UcidYoaSn0g6ROD4JXtH2bFrNQ67lNnR4lq9iv6L57YMxwhruWfRHo6fHl+qGxkowxacjBDuYGnDftWkpjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735235501; c=relaxed/simple;
	bh=qPqHnag37+TCNGuCZZSbgS+FXiNt8o9Nx9S935iW16w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrRMPf5Mz1+EuDjTTTZQKZjtWWr8b3ot5j+/SE6KEl90y7Oa+D7d48o6OwNnvZllcQz2ysVNAymK05o6tLMsytJsr58LfB+b3J/erXQazO6osAV6ucbBOxiWknHN1FPO6jn9b2uNKyfyvVphOovUtwd+iTCybNc1fMd/hj7IKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtqCVWk2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2167141dfa1so75280295ad.1;
        Thu, 26 Dec 2024 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735235499; x=1735840299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGbpmtoF+ZjCEGlBPD37U4e9zzFbKW/oBM63iGWSujY=;
        b=dtqCVWk2voh2Igq+t6XyYeTPBNWUKbf5VvXDGR23x5AYRgONcCJJ8TTbQt3PIp2cAj
         i5Idm7Ks7K19ZP6W+J2eY00XLP7hCej3vnnvhhtBl0ZrnJkqYMO8b+a9AhXG4fruEENT
         2dJURJJS8ez6UjmFWPCqxVrITb/0CumFlR5pDKqUJBrYRnJ/dmWHato26GuyKLKFTiY0
         +qV2ioNI2JnzyElON8xyol5lSOEkVk7l9CCD3kPwQhKZRmgcsKRV21X8xNdrHzf7gi8Y
         vh5iK6t1ojrROma7MhXlBkqT3qdN4kxM0Qtv0DoUjsuEfVSi8lcDCYoEWG4H1E3oKwHM
         yFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735235499; x=1735840299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGbpmtoF+ZjCEGlBPD37U4e9zzFbKW/oBM63iGWSujY=;
        b=S5fuJrFywO+xbB/OBv27ec8NWXXUnWr2IMQCDrM2LbrAHeb6Lm4Ovs4ZxHTB8VznGn
         UbJfqGAeblNUgtgcprhAfk46cchxbGBfn7IByJyXhkNRzk9+/U7qRXsvLWDjwAOsLnHL
         5g9diM3Z7s62WhldABdTfhe6jXzfQneoEqqJH1I3kDUqCJWJ2sv7zaj7YVqpSUmgL8j6
         iqEQRX4ZWbuUBI4Ztpf9zu9/Uss0SrmvpNns9YIaSZCLBhz5p0zU1qLlqTNWt5l+WtZ0
         MQyJ2pa5oaLL3wSNeopVaAX96DybNCjtk7wfTLSG+QzYSakXJBz6wsFLxsUKJkVbxKeY
         mFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgxhscbPPY5VEM/pOkR5T7wi6QBgx+ncnQUvFVVGT4E2SYNIIVwrdJGvDjXy6eF+38ocpkySA8OouI9uY=@vger.kernel.org, AJvYcCX5j0W5ObY16mkDAiI0onEBafumJOjupw8h1CJrbrgQf947DR0NIprs98uinnp6c/VyI6H25WIWq1qc@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHTDIBisga/CeiJ0GfHAahF7Q8ZbUOVvhcNCAREKDXKbefmlw
	OFaLgFmu/P7YW4M85Mu1Jl92vdqvWxuKnvfI6fKlGDaS+1gwsxQw
X-Gm-Gg: ASbGncvA70naW0rrHyP+09BheTYFftqfyVpyDtareQrTfv25QlPbx7KQ6kKlNghgEfH
	VOjf0TyEhyUoCk8wPq6BtxeRM0bIbLE7f95Tke762yr4Wo4MBeavz8pSio7o6pCtuP4qlVrCocn
	bPGd3tL+rg3kDF5tvLkApB40YAotuioU9y08I3YzQpx2+TZDrnzpzxoWPmhxTQARZ6NxUxD4IpO
	GJS4DLW1JDbqQflt2SXlA1szaobtzuu89QpTXerofTFFVgEl9Llm3eGv7wYZFdC8Qt1j5ER3YRK
	6LsmdYEU5AUexzxkV5CUySkQ
X-Google-Smtp-Source: AGHT+IFRXajoRmTVbqcKFnMtOXCbfSrrUfTxCw8ALmJ27YmYEvZlJvAGbrvgWpFBx8Uacg9ksuMVPw==
X-Received: by 2002:a17:902:e88d:b0:215:b18d:ca with SMTP id d9443c01a7336-219da7ef978mr402104745ad.18.1735235499323;
        Thu, 26 Dec 2024 09:51:39 -0800 (PST)
Received: from medusa.lab.kspace.sh (c-24-7-117-60.hsd1.ca.comcast.net. [24.7.117.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde5bsm122598685ad.116.2024.12.26.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 09:51:38 -0800 (PST)
Date: Thu, 26 Dec 2024 09:51:37 -0800
From: Mohamed Khalfella <khalfella@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: Set RX DMA channel to NULL after
 freeing it
Message-ID: <Z22XqedgvDYsc-QR@ceto>
References: <Z2Z7Ru9bEhCEFqmc@ryzen>
 <20241221173453.1625232-1-khalfella@gmail.com>
 <20241226163121.n2itccd4glm6vum4@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226163121.n2itccd4glm6vum4@thinkpad>

On 2024-12-26 22:01:21 +0530, Manivannan Sadhasivam wrote:
> On Sat, Dec 21, 2024 at 09:34:42AM -0800, Mohamed Khalfella wrote:
> > Fix a small bug in pci-epf-test driver. When requesting TX DMA channel
> > fails, free already allocated RX channel and set it to NULL.
> > 
> 
> Patch description should accurately describe what the patch does. Here, the
> patch is fixing the NULL ptr assignment to dma_chan_rx pointer and that's it.
> 
> Reword it as such.

PCI: endpoint: pci-epf-test: Fix NULL ptr assignment to dma_chan_rx

When allocating dma_chan_tx fails set dma_chan_rx to NULL after it is
freed.

How about the updated subject line and commit message above?

