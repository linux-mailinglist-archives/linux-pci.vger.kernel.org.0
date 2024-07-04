Return-Path: <linux-pci+bounces-9808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2166D927798
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511D81C2315A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA803DDAB;
	Thu,  4 Jul 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQTXxXQ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E572F37;
	Thu,  4 Jul 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101638; cv=none; b=jKPD47XxPg6pLxCx3Pt82PJIEJMRDjvCkCsxc5dD3jimcV7+AyxbVYlpRrSrhxJZT3L12nWlW1z+RvEk2PDwHsafh/sTql73gwqucR8qUKOM9+YW+o4HCwvgtMFFB1KxhHgT6zPcITqyCiBtSLMbPyo3LgUI4Z1SnHWAgFAIIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101638; c=relaxed/simple;
	bh=BI3K9B4fHdsqsHWD9vA0RUdsadmFzyQ94cYJLOtuDUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNLF3WycQVlnM88M6txw/Qp6J1H13CgZv9GoWwVEHkoHTbvRww1+4EFBuPp8MGbKrbU1zwS6oC46G9HVhGj5vaW8jII9DLmpS5SoGSoMy00ACL4VRvGcpEzBFVZe8Gp0t73mra0YinnQmxuY/OO8DHWBYbkDWhO+UHNY2RLjFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQTXxXQ1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so1003156a12.1;
        Thu, 04 Jul 2024 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720101635; x=1720706435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI3K9B4fHdsqsHWD9vA0RUdsadmFzyQ94cYJLOtuDUw=;
        b=VQTXxXQ1x64rzqNcU3ulfo3ndw6OP1/a9OFyN1vuSdb81kMuqPBfwpL/mZc2TBu7YR
         /T3fjBwE9R+WvX9aReCJG9y6d/4UIIelAFkXG2traAo808Qse62wzD/+a5BpJvxwuAVc
         a+rIwLSgI2ZndZmgHvRXEMSxNLihF7xkdoHRwTzGWmCqZ7WoVFjosMf7WrGhehyIbByV
         +UnSJhjSQDRBJ31TEdjjXuLMre41X6DGe5DGoghOHadawlkHWPkrs2KHw3CYxW+j5sju
         nVPFpGwkg9wsCGN1zo8WFG0BfnLaJw5c2LGaScfbAxUKGWpHE7Nnp4XV5Qbb/azAiDQc
         L/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101635; x=1720706435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI3K9B4fHdsqsHWD9vA0RUdsadmFzyQ94cYJLOtuDUw=;
        b=KsTIbpCF72Edi5dpdQVf+3ofzFv0w6rxLSmysgVwahShHoA/FiP1cYyDHiEL/A93B5
         92TprEqgbmXEFFHr+tlj2PmbBYxrCUZQ8suzi7CCr+0yNt1yG+gq9Javn++19RnlNtEt
         443o8czMyhzc4TiS3SCl/SmVr17qVm7xIfbozwUpJHOKTTKMdvufz4mwRuJISU65m6ij
         pECbAZMEV6/CKJG3JCbPemgMq9M1taSfPDNIBVLDKthaAvPyGf1Ufw9V5Z41v35F3ktc
         DMCSDSdFQnILBWULv3aWd4/h50CTpgjL9WD8tZQLXFS6vDNBHYxmoWUHMdEbYwShyDqR
         1MtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkZMuJT3oz0F+So8m/04x1TOd9d0jK9ywNOt1NregJMZLBFsmKx5x53dtlFgfweO/V1bJAPIoXTK1ClP0tPEu3/GvRGQVRptUCVKvNDdcA6xvZkixzv2Ajo8CMXZAQJODXEYzPA1OL
X-Gm-Message-State: AOJu0YwR+xacPwMg8fNVhkmYf2x1sKmR7jEe7o9Jr0spIYnc3c18sOPf
	2QPUkE7W5hTqMqYLQYKR1//5MR03AzvFUMk+XrkCcPPTdH5y2PtV
X-Google-Smtp-Source: AGHT+IEQxWoQEdIqpOkEDDklRMrrllojJRx4vtnOba5QfkjeMPJhS52NS3hiUZx/2dMDFf8CR3JUxg==
X-Received: by 2002:a17:906:cb8b:b0:a72:7bd6:7e4a with SMTP id a640c23a62f3a-a77ba478995mr122294366b.24.1720101635396;
        Thu, 04 Jul 2024 07:00:35 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a77b8195453sm55100866b.1.2024.07.04.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:00:34 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: gregkh@linuxfoundation.org
Cc: abaci@linux.alibaba.com,
	arnd@arndb.de,
	jiapeng.chong@linux.alibaba.com,
	kishon@kernel.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: Re: [PATCH -next v2] misc: pci_endpoint_test: Remove some unused functions
Date: Thu,  4 Jul 2024 16:00:21 +0200
Message-Id: <20240704140021.2363403-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024070442-garden-visa-a7d0@gregkh>
References: <2024070442-garden-visa-a7d0@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jul 04, 2024 at 02:58:10PM +0200, Greg KH wrote:
> On Thu, Jul 04, 2024 at 04:14:06PM +0900, Krzysztof Wilczyński wrote:
> > Hello,
> >
> > > These functions are defined in the pci_endpoint_test.c file, but not
> > > called elsewhere, so delete these unused functions.
> > >
> > > drivers/misc/pci_endpoint_test.c:144:19: warning: unused function 'pci_endpoint_test_bar_readl'.
> > > drivers/misc/pci_endpoint_test.c:150:20: warning: unused function 'pci_endpoint_test_bar_writel'.
> >
> > Have you see my question to the first version of this patch?
>
> Yeah, I don't understand this at all, how is this patch even building?
>
> What tree/branch is it made against?
>
> thanks,
>
> greg k-h

Hi,
I can confirm in linux-next tag next-20240703 the functions are indeed removed.
See commit 0ace3d3b70ed6a474d52fc44ee9b0b1f16ca3724
misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR tests

Regards,
Rick

