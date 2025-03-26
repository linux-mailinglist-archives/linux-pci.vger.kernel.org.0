Return-Path: <linux-pci+bounces-24725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF65A7107F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 07:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342A23AA946
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF017578;
	Wed, 26 Mar 2025 06:23:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1228EED6
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970201; cv=none; b=ocAHZakOxKAFu9gtY+0cpysyWM8ThUEog3FcTnGyXvZ5i1limbLiMcJRabrGUwtGxwLrYQ+aCPnh52I5GEdxslCZQxkFwebjAgHEpQ68q/3DVo+Ue7LY7mTeDLc0nxsT5ZaD/4SBf3AGzDSxoX0MxghWPQeP4JMvuknuOaQX4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970201; c=relaxed/simple;
	bh=PSDXhhzuXR/xH0TvOMl/kYF/+rL3Is5BPXFbV/miFo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhLXH5mDvDiRXeMC78J8+CznMp2dMwrFpZmSevbabjM0ITWuoKnDCiYYbke0uwDVO77NWAu2HcQ08gHkPob+a/BE0XK/taqmLBtiBXKkKZuqnqgD7Y4WYKgklH3OC/pRO1tHEqPwLsbEtc9vJke4ZXEJ8MvFvgQMXAdH0nY+0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso135011665ad.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 23:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742970198; x=1743574998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxbCGfbET7tMwVdtBVJHFPw1fyoq/wBtkgG2yRueals=;
        b=MI6uI6yNBF2sdx8JDhO9oPQc0VSvuDzpuZCdy5Nzi5YTelx7toMwqXAnQHMYh5ElKf
         F8c2fXG/7J+OSEEibF8VjwCuiNYUFzLNn2bo1FnGx1JNcgVexhQ9bh/ismP8Mw9Ny4se
         pnYz7Rmf4Di05Th6AJMmZtSSj1QDo71DNBSPw4qtcG/fK4iImb8Wv3rgB9QSAaa83J+C
         qTQgDE+bIS7JDHikyttm7ygkNb7BUG9AvKJTJt6RLTQpZNX3/ux3avh44w/AN4rTOu1+
         E8TS0SJWlaYBd6EkYyPy0oH4UHsGgSlA8tRti+8RqzX870dJHOUv3Y68wuVMli/0eIgi
         QEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7xiteQgSE2ZSvRd90HCd50L6HkuYN/41ef8jYOU54aAikXgG748KTbDide5MEOnHTCNGR9SW4UPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOuvEaWSn/VySx0c+DWYOm9PwZO6a7EfxtKxhii/1D1TT7wF7
	gvFYWY0chLvf+c1U8x5c7s31Yo00a8YhuNUKtMeeuWEkLQQRMQDk
X-Gm-Gg: ASbGncvytEErPpnh1d9vsUNQnoBZ7JM0J2/ceR1ThyWUhNhsSb1n3Zi/rTGCePi31cc
	KiPExr1KyfRr5jMVR8kco9p0G08PyKHiRX3e6+6EqX2lRMOue314EhulbNcXsDwP1nNy1fADqR5
	7sS/sx4pWOGitMQ/K2BKRq+mOVRE/o60flM4nXZH6drz7LetrRJwiw8KtRCKSGEGe0mukWAuCfY
	rN1nSakxK5T9wRJTqycO+8YS7r2KQhRoiVnxnN2hRXXDUCPeSHPC6mjJw1vRjEStN25v6JpwOBk
	uat2DLwNtogQ05yiiXES3xrfHszrDEZWLSWriulPYdM0T9Jw2RcxFATa14RPYxIgsZRRhCI+a21
	HXMQ=
X-Google-Smtp-Source: AGHT+IGptOPnKFX6d235UPumfX8YCOJK2HRzCQrO/fuzybZIAOON7+/Z0yrD6Y0egJdLvi6Q57bHpw==
X-Received: by 2002:a17:902:d484:b0:223:3ef1:a30a with SMTP id d9443c01a7336-22780e239e1mr283290975ad.45.1742970198021;
        Tue, 25 Mar 2025 23:23:18 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227e452ec6fsm24847815ad.175.2025.03.25.23.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 23:23:17 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:23:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <20250326062315.GA2822343@rocinante>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad>
 <Z91pRhf50ErRt5jD@x1-carbon>
 <20250322022450.jn2ea4dastonv36v@thinkpad>
 <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
 <20250323113449.GB1902347@rocinante>
 <Z+Giej6/jpSHSV3H@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+Giej6/jpSHSV3H@x1-carbon>

Hello,

[...]
> > > I still need to send a patch that fixes the kdoc.
> > 
> > Feel free to let me know what kernel-doc you want added there.  I will, in
> > the mean time, go ahead and add something.
> 
> We already have:
> 
>  * @msi_capable: indicate if the endpoint function has MSI capability          
>  * @msix_capable: indicate if the endpoint function has MSI-X capability
> 
> How about:
> 
> intx_capable: indicate if the endpoint can raise INTx interrupts

Sounds good.  Thank you!

	Krzysztof

