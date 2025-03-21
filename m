Return-Path: <linux-pci+bounces-24417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E2BA6C5A7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 23:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04ADC17FA96
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF561F153D;
	Fri, 21 Mar 2025 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qovOw5Gd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3951E9B34
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595090; cv=none; b=aVqetqSq2msxH8zKVcq5LHIR5jO+TtUNi4qFrJYgJQS50SGc+ADt9jhdCSs8jw8HlUjjfwxWCwnTdXz0I1u25PGH2d9EaD5Gw29Ha84ULdtS4JphL6VZNl2dUOa96EOmd4yrqqJIVLfptiU+MPzOVzFNnBKjmalL+B1LUn9MCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595090; c=relaxed/simple;
	bh=25J1oRlBF+GRkSzO9CmN3dxX0U81/261LJN3BK9i0Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMLSLgbj4p9BWcuRGYApJ2krrYLA/ylfKV46IaxOszj5GaV4JgufnD1pi0BGiqF3u2iOXTjfmVPYA4+NSAtGArCUxsV++sMJrTJ4lig3hO3y843AydF+nGDmAbyca14VUpZJ/Hlp99xx99lLB8/1C9b3ihran9xjCeUHKknAJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qovOw5Gd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso4327713a12.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595087; x=1743199887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25J1oRlBF+GRkSzO9CmN3dxX0U81/261LJN3BK9i0Oc=;
        b=qovOw5Gdr//uRnrJZiscwH5MeDvDV5RZRpHqgCiAXNQh3dkQ3zfSSsOTxO/M8hfbG3
         +dyCHlLyOKlhEWcUac1W7sacJW9AnBDdrNmZbmjt5Cu3GUT5Dfmq+y3AYlrO3LgEPSZe
         LriGU6liv1cXdjlAfN+IY+nBoaYAnyg815SbnkIF7IX4aoq2VC69940SfnRx5+zvgasB
         nuOu7STERnlIEp8F+39oFe60nbhYmWtVQvCQHcvv7zwhA30XevpTeXHpyy1xyWLOgds8
         Q6Lnu4RGvDpVB9cmis/J3Wp/4rMPJUpwBDYscLA2LGj2rOKuitGQXHK/V66Teed2aw7f
         1ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595087; x=1743199887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25J1oRlBF+GRkSzO9CmN3dxX0U81/261LJN3BK9i0Oc=;
        b=Qn1z4omDJghVFvYCf+LCCVLaqUPw4TjndMZa2NWRxIbJtGPCHKZJZdR/7bKv4SCAJQ
         I5Sj3sQccK4i3pcO/2TX9cvr4mFJLY2mVl5IPq7CDz2wPb6GBXrf4cIJL7e/k+F9cJyQ
         wEXjhRTXvLXG95lwvySmR6N9bmSdYXW+fZwyBzYld3jnkNNSUkqB3/JBNzMFPVi92VEw
         N6cmuWdq5kvjkA2qeUV5mQG+wTOHd7LFTx1tJ+Nr/UDCCOwq4Ybl0O/S3xjKpuzEuTGS
         ubR6c4UtfYWC0MBn8b9FBhsgKx7IJM7MaQOqal0o1h6HTJEySvoUpwXOulo009iLrvd8
         40aA==
X-Forwarded-Encrypted: i=1; AJvYcCWeq5kTb/pqx7GaAwwDVkzVMydPy3akZvo7w9Qi2/mA2vBLsLt9aFmhFTUf6b3mZAS+mNBIkut8qX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51VkkX5chZuqwpjb1KzKxgQT+yGkf8kdlEzMYUq67dOUUrwiR
	HY2vBxPQyd9wamwT5rxlVYe9ojLK3V8MbvqZ70PbCroEb032THzLZ02uKFILjHyJMOGBBFpJ3/m
	HF91nRt4RiL0X+6ZX8L4KNzQq6n4SjFvTCXRQ
X-Gm-Gg: ASbGncu5NgyQBeqzNJ3D+M/3RKF1JhOjspAYVhwBWIYp1ta6dimww9CWIhnOW5Awvn/
	9Ftx4L/ATpioJGmD8x3f/JVZEhvxNOCK4Ofbgku2owbMlTpYywyKhWOB8OJdPaG/9SSO6UwLlNt
	PGk5IRqj8qWWDwWOd/FLoYYO0p+V2S8n0Fizakf0xA//1lPk+qTpg/ZjtN
X-Google-Smtp-Source: AGHT+IETbGIFhXZeTLZUSV0LN0UpChUrD/RcXVfmG0RVp56OjanuNWEvLGROphoRS8FKouehKWYi/TDG0bKNi3ygMG4=
X-Received: by 2002:a05:6402:5cd:b0:5e7:b081:d6e0 with SMTP id
 4fb4d7f45d1cf-5ebcd4695afmr3675219a12.19.1742595086640; Fri, 21 Mar 2025
 15:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com> <20250320082057.622983-6-pandoh@google.com>
 <85bd0cd9-c09f-464d-9397-ced829df27d7@linux.intel.com> <CAMC_AXW6QgDV9bSiYR5UpgSAii+YSPLk_xCdYHZGjudDZpGstQ@mail.gmail.com>
 <bfd75767-7743-47d7-939e-f0c5204ee647@linux.intel.com>
In-Reply-To: <bfd75767-7743-47d7-939e-f0c5204ee647@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 21 Mar 2025 15:11:15 -0700
X-Gm-Features: AQ5f1JpoCMsGgNg_U3DEourq4zEnU0kzRvEd8jgzl5CoqukipeFXKkvMVqp2Ih0
Message-ID: <CAMC_AXXXvJz1GzxsE0pA3yGzFgEjJgcpsEfzCG=xjBeO8KB6vA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 2:47=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> I am fine with deferring. IIUC, if needed, through sysfs user can
> skip rate-limit for uncorrectable errors, right?

Yes.

> But, is the required change to do this complex? Won't skipping the
> rate limit check for fatal errors solve the problem?

No, it's not complex. I was trying to minimize extra changes in an
attempt to get this in for 6.15. However, we're right against the
merge window so that may not be possible.

Thanks,
Jon

