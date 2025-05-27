Return-Path: <linux-pci+bounces-28437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F6AC4745
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 06:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B022D16191D
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B3B136347;
	Tue, 27 May 2025 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwHMWEdg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8B1990A7
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 04:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748320951; cv=none; b=qVOJgKMhW5icLEKKKImxiHKLYDtINHjfWLQ6977iZoiDUSEM4w3+/JssG7TdLbwx1rGEp8HSa09SgFPpaeC+Yy0xXM7MxmiRaCzTQMl2UdykjCr+/1vSsQcNdh3nrVduKygeOqlrAdD6zbZxfYWOEz0K7Fhu3941CLinvtctdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748320951; c=relaxed/simple;
	bh=5yj2OT3VaMVjkx7Fz1StJClsrih/tgIjfFNsd1NAJKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4bl4WWZyF6K+CVO9lBstvPjHsi8uEmnVDRaPTVhdzjHHZBs+2ZRDP2lJVuwN9BPSyyeo8cXsruGbHaYQVnO+uGf2OwrsSKxCUN6MxbtVoGDmeyPDZqU9PFaSJDaxbhm6WiJea3x3OxbjrSKs/YuhuNKKVwS6bveMYXn/3zgd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwHMWEdg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c9563fafso1860661b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 21:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748320949; x=1748925749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBN3L4NT1Yd+HHEDXiGZQVx0LDNIwCtT3+ARKRN4y0U=;
        b=WwHMWEdglU2Iu76iyTWEI65QS/zV4wC5uG5lnzD6mV+QKb3QGh8g6KVNYbS/oMyEeZ
         u/SpOFuiIMM9DqCUi0EBQT4MBx4Y6lKf8+YkXFXq1d4Rro3E/piZFWD3IfhDVSM0HSda
         l8XodvzsSKrCtbTblwnZPOGS/cq5HBSaBZFX6p36IkSewFZH2GhLHawsjkqv+6QLG9Hx
         C9AmmHIpRkfSkjqiC2ONqSJzUHj32mOtZDv7JB5bU9ahwFnDgt8LqRbZYUsp98LWSs1T
         nbk63gxmre+ASVJEEQmGD/7AvWu68a0+Z7dHIY2gS24+haf2c9UkicRscReTRciQL4lR
         gOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748320949; x=1748925749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBN3L4NT1Yd+HHEDXiGZQVx0LDNIwCtT3+ARKRN4y0U=;
        b=iOdbPYg9qmMQL5riTmgRisLaF4bfzXUuiT1cWRCVNpHwefwYF6d/M6GlbOC9tQQ+OX
         KLkYOzoHToCDm8BTuEZHDGqrQHYQrBSTPrCl2NnUUqqP3tSQbN6Yqul63Hrgs5sDasJK
         rKVamPuE1nfxYP5je6Gd17LXBSRCUUbCFBqXU+ReHx6m5s7CGjRUzu34+oMrk0juwD0r
         uVndmydv0r2I/riIlB5dWtVG2VRKWMsALcKA7HKrOvIlg+CjudkmhSL/d1mqlXxCYKrC
         vCmAHyXtLUIW6mF8hykuV7N7vKwvvFwHfEQOLqVFHxXxhaTrwEG4RzENFPoMp5V2vnHC
         Sd5w==
X-Forwarded-Encrypted: i=1; AJvYcCXk9nF4TNkni7i81BLTJOjjUufl88dwyQeomfUWHsIdbIToIMFRQOc1X+PMyKr+vWgwDAjT9Jb0ycw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2c0ThBF3h99mTtB9Hkwe5AtcB7ywJNOoAoxZvjAv1o2AGFkxB
	/8FXB4wyoIwdpsDykjX2au5mhE0hspxGnxlemAh/vpjNZI31AWaIVJE0/IfqVZDLCw==
X-Gm-Gg: ASbGnct1ZuDO76JQJFMvq53pjxG5SriCYHFQ6KPIJi9TmBYE6s2S3bXQUAtcYM5Fgik
	pc+FjPDqRYaZ4CRtXntnQQECY1oOXq3l/BvUx7FWw91yAnCGlevowFXgZa92p9pidwfrnsepQJx
	OPOmg/jBgx42G6kVbUO0tWaY2JO3HU5gWiSM9IcmlObVmijMsFA8dcnhZUarbO5r5b0yzT59jig
	c0hwCQUqi9ozW/ibdq4JEjc7n+ckcanRbse6ltyohTivTYsQGW5/eIst2Y+t0rSuU39BxMj2K1g
	QZNw1lWGP/+GUQJNQQIBJXGcoAql0atDw3syYDkbI1XQ91VR5xfZ4DPEIsZRHvEiJj9FTreAKsP
	YBpcmGNrR0KZcu4zzgByDG2UcwXvis/pdNqLt6SFI
X-Google-Smtp-Source: AGHT+IHzFfStJnUlnH7EnNcqEdlIdJgu+ZlEgXINNBSj/bjWdJUofNqmt0m3ax9jlXUyHNm1RLFwrQ==
X-Received: by 2002:a05:6a00:3996:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-745fe06755fmr20481041b3a.18.1748320948511;
        Mon, 26 May 2025 21:42:28 -0700 (PDT)
Received: from google.com (243.106.81.34.bc.googleusercontent.com. [34.81.106.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829c10sm18447525b3a.96.2025.05.26.21.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 21:42:28 -0700 (PDT)
Date: Tue, 27 May 2025 04:42:22 +0000
From: Samiksha Garg <samikshagarg@google.com>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	ajayagarwal@google.com, maurora@google.com,
	linux-pci@vger.kernel.org, manugautam@google.com
Subject: Re: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
Message-ID: <aDVCronBm32GwF77@google.com>
References: <20250526104241.1676625-1-samikshagarg@google.com>
 <39743267-6a2c-4a5a-9581-05b03e25477f@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39743267-6a2c-4a5a-9581-05b03e25477f@163.com>

Hi,
Yes I understand that `pci-keystone` is currently built in,
which is why it can use `dw_pcie_allocate_domains` without
the need for symbol export.

My intent with the patch was to make this API accessible to
other out-of-tree drivers that rely on the Designware core
and might have similar want as `pci-keystone`.

Since `dw_pcie_allocate_domains` is already non-static,
exporting it could enable consistent reuse without requiring
duplication or workarounds.

Thanks,
Samiksha

On Tue, May 27, 2025 at 12:29:18AM +0800, Hans Zhang wrote:
> 
> 
> On 2025/5/26 18:42, Samiksha Garg wrote:
> > Hi Mani,
> > Thanks for your response. I can see that pci-keystone driver already calls this function.
> > Does it not mean that there is already an upstream user?
> > 
> 
> Hello,
> 
> pci-keystone is build-in.
> 
> Best regards,
> Hans
> 

