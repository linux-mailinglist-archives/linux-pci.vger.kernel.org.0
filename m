Return-Path: <linux-pci+bounces-2326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39569831F00
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA381F223C9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409D2D603;
	Thu, 18 Jan 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzKJUhA/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616872D607
	for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601770; cv=none; b=j7ekUEj09D2u6vKGGc4YAhVlRqbfk94Y5YPXWATLUPNtS9GmGGw1PFL6CJkkaWjF6mFW3iyIDrG3yxfxs9DlbM9fTcs4WmMEUY0IDVnuk17lb9M3mDuhFqEl/Lr5k0ky3uKOd0hQUAarAg0gwFAKWmiOtNhHRWu4No9/Mq5wgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601770; c=relaxed/simple;
	bh=TXOpEjx96JrYCmkAglfpPZeH5jckCiUKM8FXXziYghU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBOgBAtAgC7HHDEdxFWJjR1S9non1ekt2fkBJ/tEjr9zPqLZONKJ7d9jj2Pdgp+qsJDET7aO2h20cyqb05v86EahW+TJFJndSRts1xA27ylkR41gMkIv3bkmEsPJeVaGTqFADivVm5cMfpu+/8CaJNiUfykIuFVYW2pUbGGLHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzKJUhA/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d70a986c4aso5641925ad.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 10:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705601768; x=1706206568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXOpEjx96JrYCmkAglfpPZeH5jckCiUKM8FXXziYghU=;
        b=tzKJUhA/vsTSRF6HL5v5BeWsuRLd285udgDmZdRGHyjmfVMir+gvzKsGbeoriF4BVu
         rcSTZLQgog++o+xIhkAAGThNMIT0PZgY0jd4uIc+0L6SEaQzkkzlXpuCccoVRPFN+BRh
         UEp9O8f3XuahvDJNJbr/LH0G6FqSjFklkJmI5Y4gIDJO3mOA8ll61tMEth6oBdC+Dg7U
         RDvjlLUOiJXFW9eJJBnx4mVlSLmFer/3URRArYo66A+yznXHKHTHX9TaLwBpj3TmU1Ty
         tuQel6Rs186roDu51Ii3hyQ9ohXuiCmcz30YBISGytIwneUjVYNAnkEGAkZ6bDiCqIgb
         SmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601768; x=1706206568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXOpEjx96JrYCmkAglfpPZeH5jckCiUKM8FXXziYghU=;
        b=htL0ejGS0F0KcJqExneWGymQhOIsrlImOeoZUsR7gjoMLP/Y12Tgmr/DACQUbclrqf
         fnTaLVWOKVK6gg8qKFYlq5o+p+FIPahov2+FDwxyOKPFLXbzkhZWQE3v+S6HJrR1M5AR
         iCXIG8a5hXg1uBbKa7fwegXCYqdKoIHXxi59+k+A00UTQhiTGEmwIXHaVfNXxjrLMrXr
         USmasL3QmC58tHF8GEBGkGCzJnU1tQWx5sXv4izT6fIZPcAxVxYnO49ddWIy5gLuiDyD
         YZFkjigiKMtD8jnZu7JS6r/UKiKSIYD2837u8AdF74ChgRhMGDDizXZOmJ//fJ/WTOiF
         rdkw==
X-Gm-Message-State: AOJu0YxR/XiHCvVJrSBBl+D6s80qaiX8KVIAPAcbKgCBYz22jyp/Ix/u
	nFnkukyovhULCkUdumjWDPTj0ceDMaKKa4GfhyizgYn1o9DjmHu/xW+gYxRe/w==
X-Google-Smtp-Source: AGHT+IFTXj/zT6K/skVLbE1Na7l/O+UWmVq0I+/0d5YLsVSX6EuLw2ZP+Xor+A3eUJ27JQacqk/U3g==
X-Received: by 2002:a17:902:bb97:b0:1d5:c9d:11dc with SMTP id m23-20020a170902bb9700b001d50c9d11dcmr1147522pls.38.1705601768504;
        Thu, 18 Jan 2024 10:16:08 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001d5f58a75ebsm1685620plb.45.2024.01.18.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:16:08 -0800 (PST)
Date: Thu, 18 Jan 2024 23:45:59 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <Zalq3_yvfBJqDsQG@google.com>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112093006.2832105-1-ajayagarwal@google.com>

Hi Mani
A friendly reminder for your review.

