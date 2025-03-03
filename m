Return-Path: <linux-pci+bounces-22747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B92A4BB71
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053BB1602F4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 09:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368671F12E8;
	Mon,  3 Mar 2025 09:58:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFF1F0E51;
	Mon,  3 Mar 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995884; cv=none; b=Aaes6+GryAT9WNizHM8XtGZjNY3mPX7G77AMcMsS8lz4db2AweYsR2BGkCoG3ZOSELPkWfB1LNzcQKUSxZ0qCNAeZpkJtRKKxu4J8dlh1BBkVJ1BdDjfDZTtq99+e6u6qNtNKC3lyWzx+dy+ly78+w8OKN/kXTDM15DGZxg/6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995884; c=relaxed/simple;
	bh=TZLG/R8bGC8pJs6/i0iV/BOlb/PBnn3wUcBmOH1Zj2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUQV8D5sOVxfBJlZGab08GfYyKgr0HjqxumeS7JyTOV/a0rdwUvBfFoVx0wjCFY0knopwvFn8HfVy0OqwU5Qjk4iF4tOlCi/5cI2kPH/9uT2wnq7gymE3bgI1tH7u+gOFq7Z78ypJZbSxt14j0Z1D8IpHrOf4hK1bAUT6rjk0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2238d965199so20862245ad.2;
        Mon, 03 Mar 2025 01:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740995882; x=1741600682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Lit5pOCGG3QItR5zE1LQ2pbl2xqPND2IQxLjzVPDw=;
        b=t5ASFc+UZ3NRevbJAbuaDFSG5fcFv2NvLcFbWJGSRXIy40W1h07IadPcQU8CgJZ1uU
         ptJOLNPcJrixn5nrAxTQ8P2ZMUfc5qHuVFM+q6r0Ygwm3wHudyqp2uVWjo51zTUpPnCU
         Vb+PiZazoj0i376j73GEFWKu4fwU4pLw+BBVA603t7nvnw805SqMzgWoOlb5LQHbAl20
         yu9bagr1wfLWJ1fj3fQoe0/WnaaSiDRjamWNhxZVyGTk+Z+c0q+HjHaFzW2O2l6SUQh+
         WUkGu29Xt1t7rnlBU79EaH80Z1olcf2rICmzyllwUUga96Z1mjm4j+aFqq12KvpEgO6N
         8Pqg==
X-Forwarded-Encrypted: i=1; AJvYcCV3wh92Wia1ZFOvE0tUVRHv7GxFU9Ul+ZYUwHkxPkMuexY8E8uk5FQlwFI+bNyugMSFCXNoBtAYmGLf@vger.kernel.org, AJvYcCVHHij//WY58pMBnxvmHtuqS+1rHiaV0DPDhnV/zKynGWYAsQZSrOzYfjUqpz/hTseBjvacTYfPEFfvUb+G@vger.kernel.org, AJvYcCVs0Hc/gyfEURyy5sQB1/N6X+QyWIK1SM+qnNcJRsjq2QwGkpW5htvG9Wgxdr1GzWPsufj5fxqDTgLx@vger.kernel.org
X-Gm-Message-State: AOJu0YxozdKt13BhXkUZABkxODw+BUcPDaK98p9PwiNIZxU4hdnq6xzM
	FgXAXzkBcQMszYTV9cLMfbsQQJ4xdtky8hk7LOAoEi1Z7roaG6NV
X-Gm-Gg: ASbGnctIoJb4CPendjBtI4zgQtMZf+jR6Om40C3WOCuFYJxft1WAgGZDNQEyvElpGAl
	B08sIrMjJf4N39uFN70qn6w/cu4Kidih/A9L4ZFgWFiTQOBeeT6HNvn6fOTAXyWm+3A8+cLRcKj
	BWvC/SC8Tg1L29FT5KpcjfK4yoElUxoOwg6wdJ2jd2T2c7vdYNgoduZmEQmXs4bdgnmYsKGtb4u
	7WJf3R8ES2Pm2nywvx8Q6fPoWmuChWHGr89zAsf69giVt2mH+MvPL+IfVrnxq6DpGAxwGyoALtJ
	tPdFDdThopPK4yuCAj7XlD2a6ELFdCw4gyMRUMyt2W6qpumjYFgIC1JZ8ji2TgfdxtbIZW+KS/n
	zbSY=
X-Google-Smtp-Source: AGHT+IGWSAIDCC0xaqtS7Ex77F/Miw148JL0f7j6rhJtrFrKkae4GeKC5Pc3phsRqp/mOzIOw7p+Ow==
X-Received: by 2002:a05:6a00:4650:b0:736:450c:fa56 with SMTP id d2e1a72fcca58-736450cffadmr5417450b3a.5.1740995881981;
        Mon, 03 Mar 2025 01:58:01 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe2a668sm8468422b3a.30.2025.03.03.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:58:01 -0800 (PST)
Date: Mon, 3 Mar 2025 18:58:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	jingoohan1@gmail.com
Subject: Re: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250303095800.GC1065658@rocinante>
References: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
 <20250228093351.923615-4-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228093351.923615-4-thippeswamy.havalige@amd.com>

Hello,

[...]
> +		err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
> +				       IRQF_NO_THREAD, intr_cause[i].sym, pcie);
> +		if (err) {
> +			dev_err(dev, "Failed to request IRQ %d\n", irq);
> +			return err;
> +		}
> +	}

Out of curiosity: would exposing error values be of any benefit to the
users of the driver?  So, perhaps:

  if (err) {
  	dev_err(dev, "Failed to request IRQ %d, err=%d\n", irq, err);
  	return err;
  }

Thoughts?

	Krzysztof

