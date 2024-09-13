Return-Path: <linux-pci+bounces-13184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE8C978590
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9580EB21932
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136C762DF;
	Fri, 13 Sep 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAVRaohn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325F75804
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244106; cv=none; b=W+61bDxrC79S9R7rJM6/9ntiEAZbI3s8+lAAjrKSNnZ2SQqDIMnzXJIFlZzL9oxSOpZShcTW3QDDsI2MXE0Ofxogqh8OnxagoudbBAY0to2AOGVNPrYWX2K5jwMQO4eE1EI8g5AHmryRIddCdBkEJIb4gpKNP1JmIyJW32z9iWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244106; c=relaxed/simple;
	bh=yytH1KipTgbze8DRExTuEigobgRlnMDSS8cq2mPHifM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCdW19PqcCIRXjkASD2eSQCbmBLLpKUguGQ2xclqu0hlx/A5SlT156lDIRDCE9qZrIIIPSZ2yvnK7lKbn9QxUijZ6zeZ6PQ3hdTBjRg4nhgsnbjeQePMGDOT8b56egZArkf8UJuflTMg8w0BDZ9p5v7ljE8DYC92GlYOl/WZWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vAVRaohn; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d3872e542so8315625ab.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726244104; x=1726848904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DqPL1nI9MUKpcMwl9P4Qbq1rH47HzlP2pIVx9c2yi5k=;
        b=vAVRaohn8gyWe4ual1vL2M+Q+WBCXkGjvjYTRybsFOs/xaH8UkwrMCSWmqHILOqLGq
         S5/jWSdMmNMd+MKHP2bZ1joBW43Z+5VU96/iEQceXdkPpM7s/Z/n41lcCtnXcuOoxT/P
         SFtxcR0CE6usKYg4XOKJLvp7mMEJrbJkA94RjCKW/UmwGZn3O70QMG3PETmZ+DLpLvJo
         SmP5JxZCD/8XsMr7m0agAzo+b/yxlFSr+ylz+tJHYwOHS63jh2xUqC6ttH68nhJarPS6
         DjtpffBikqONngi4rxE7tPXCieieLwAYh5ZIhmhcg/obGkQqudnMSceX4mc1Ate+PbdV
         WrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726244104; x=1726848904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqPL1nI9MUKpcMwl9P4Qbq1rH47HzlP2pIVx9c2yi5k=;
        b=ifXDqdVKJQXeGQ4exUoColJys21c5HkL9HEldb1ppzW73BC0qEfN3NOj7X5eHdpkoF
         tAWMEynJL2LKo4qq+5FNWdnLa4YBlU72eUb8KICBEcZUckszhlDjuXacoFdZ9+atgyYV
         wF/HxJG5Bc7hXGMJfbt9tpyYVl96Vu0LHKMsWTTr95YiZTA98OrLSQ3YE/PKnKs5+Z3V
         TL9e0STvxjAbSb2DYBVOHRGZSN0UlVyEJYFiV3yqe0+qpYWEqU7/KbTEfhO4AGjAodRw
         P5AbsIy2rARfjANFCe5YUPifLCfZeZCSC7q9AzWi87uHVscwX6VfuWYeoJLnWug7aZne
         dUig==
X-Forwarded-Encrypted: i=1; AJvYcCU8JlpUYQ+Y3WWzTtkWvBV2R7w2mOMkwfyyZat3WejsFLRnbX2iSjPQfdAIxu3JsF1IowpwKKvQ0o8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywldya5UgW71zOvU98TOSBBktC2e3nIoHbBTPp5co0aFeqDvevw
	pg7ys/wIml0AijLVt+PesEyqtchn6Oxhy1eyvBT21kXKjzhsW77leXbosv6Q0w==
X-Google-Smtp-Source: AGHT+IF0LOJn+lUJQx5zRALA1A8tYQm2NXX/ZiERs27eNgMfGz4PKkP2xKtbDtzfZ3G3bX2NUNZ2Yg==
X-Received: by 2002:a05:6e02:2168:b0:39d:4ef6:b36d with SMTP id e9e14a558f8ab-3a0848c9f58mr72096645ab.7.1726244104147;
        Fri, 13 Sep 2024 09:15:04 -0700 (PDT)
Received: from thinkpad ([120.60.66.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbc0992sm3607889a12.51.2024.09.13.09.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:15:03 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:44:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	jonathan.derrick@linux.dev, acelan.kao@canonical.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <20240913161447.7irp2p5a2sjpobf3@thinkpad>
References: <20240903042852.v7ootuenihi5wjpn@thinkpad>
 <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp>
 <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
 <20240904062219.x7kft2l3gq4qsojc@thinkpad>
 <CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
 <20240912104547.00005865@linux.intel.com>
 <CAAd53p698eNQdZqPFHCmpPQ7pkDoyT4_C9ERXJ4X=V_8QFO8pQ@mail.gmail.com>
 <20240913111142.4cgrmirofhhgrbqm@thinkpad>
 <ZuRZLRFrCjXlrd4w@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuRZLRFrCjXlrd4w@kbusch-mbp>

On Fri, Sep 13, 2024 at 09:24:29AM -0600, Keith Busch wrote:
> On Fri, Sep 13, 2024 at 04:41:42PM +0530, Manivannan Sadhasivam wrote:
> > I'm not able to understand the bug properly. The erratum indicates that the MSI
> > from device reaches the VMD before other writes to the registers. So this is an
> > ordering issue as MSI takes precedence over other writes from the device.
> > 
> > So the workaround is to read the device register in the MSI handler to make sure
> > the previous writes from the device are flushed. IIUC, once the MSI reaches the
> > VMD, it will trigger the IRQ handler in the NVMe driver and in the handler, CQE
> > status register is read first up. This flow matches with the workaround
> > suggested.
> > 
> > Is any write being performed to the NVMe device before reading any register in
> > the MSI handler? Or the current CQE read is not able to satisfy the workaround?
> > Please clarify.
> 
> The CQE is not a device register. It exists in host memory, so reading
> that from the driver isn't going to flush writes from IO devices.

Ah okay, it makes sense now. Thanks for clarifying.

For the workaround, does it make sense to have a platform specific quirk in the
NVMe driver? Because, reading the NVMe device register from VMD driver doesn't
look plausible to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

