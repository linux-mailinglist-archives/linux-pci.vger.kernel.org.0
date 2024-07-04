Return-Path: <linux-pci+bounces-9812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D2927832
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EA1289253
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B21B0107;
	Thu,  4 Jul 2024 14:22:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866921AEFF4;
	Thu,  4 Jul 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102944; cv=none; b=C4cUsEdx65m5+34/Zu0COK1gpmabdgQLAI4KGii7+gwQwXp0vCV7Oo89pdCrvO33U+TTYsUKZjHc4KR5HpOUwqs0Q5XGA7e6QCbu+JAGduPNuhux8zvxyzJrD3WwEVP4W3v79p6P1sGId0g0qCYTmsZzxeltbcu/1abUsasCT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102944; c=relaxed/simple;
	bh=rtRIqivIqwgqgxcexiDnn5d9T+Mgi2409CINqU2lHNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC/sq4EyiiL8TDuY++31dY2pAPGLvR2HXVHoKxUy2ygftuXnygm5CsetE/Rj/Nz2KiiV8bv7NToHzLaWfCQ4F1zw8TBbkSCG5RYvYRwkJFl0JN19ZyztHcinE1c812xx/Hdc6BqI952RHXBzmm1/epRaVK79gqSVxM7wXkVvmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f64ecb1766so4299615ad.1;
        Thu, 04 Jul 2024 07:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102943; x=1720707743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb463/1zLZ6EMw5aoaHqMLO2WnZ13xVjIE3ZwNa1CCk=;
        b=a2MfEplKq9jyaRdBP9HqkKs54Fq+8DrYGc2J8iE5b+SdZp3NO60Z/OBSfKyVCjgbUt
         raHqILgTsYnzQTB83UlQ4rqprnfFGsYnxcWuSEWo6mRmXtZWSUiHQmaVt+zHBPN3yQ6Y
         syug0xHVS20R6hGwO7iw8vhCEYuUJ+fT6HU4eCJ1lEq1fu96czoTPiWISc0IMRC+Rq7Q
         aqsMoEF6NXJTp5DQogcaMCGgPMFQyDLRDALil6utJMZRYru0SwIjpIaHOS+DDzHrXwRl
         DTnlk3NOZQpR+0K9G/ezFMGlPFNOm2bXtF7XLfRAvXE7SiX+qdxAdu647kLYlmofB+I1
         BllQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0rWEl14/mBoYIFi37XsP2pckr/94In5hDuK5Edg2qAZbKhqX/5MwbU/yakcGpM6W8E2vx23mFRofMkzXp22y3039hmLQGz+HFRFJQ+vhQ9a05sVIZ4/ZH6DXUMvlntmYWGKGj3g4A
X-Gm-Message-State: AOJu0Yz1dMj4i4vV9rh+EigoWHEBIbPWM2r1xRxM0XRFCx8h1SOaH8tu
	ZJnGRyO4XJZTmEtKgjh2XZ/EbUtLAKXqVaIkYn4qO/FXAz3KMweqVsXySPAV
X-Google-Smtp-Source: AGHT+IFPQjidJSq3HzDjn28ehr405u1wuaxWWGtbQ+679tVWw79YwmZZBgBDn8sd2j1rwO3txpBwrQ==
X-Received: by 2002:a17:903:1212:b0:1fb:2bce:4322 with SMTP id d9443c01a7336-1fb33e0a368mr14238915ad.11.1720102942773;
        Thu, 04 Jul 2024 07:22:22 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf80219c9sm53420605ad.142.2024.07.04.07.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:22:22 -0700 (PDT)
Date: Thu, 4 Jul 2024 23:22:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: abaci@linux.alibaba.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	jiapeng.chong@linux.alibaba.com, kishon@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org
Subject: Re: Re: [PATCH -next v2] misc: pci_endpoint_test: Remove some unused
 functions
Message-ID: <20240704142220.GB1215610@rocinante>
References: <20240704071406.GA2735079@rocinante>
 <20240704134953.2360738-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704134953.2360738-1-rick.wertenbroek@gmail.com>

Hello,

> > > These functions are defined in the pci_endpoint_test.c file, but not
> > > called elsewhere, so delete these unused functions.
> > > 
> > > drivers/misc/pci_endpoint_test.c:144:19: warning: unused function 'pci_endpoint_test_bar_readl'.
> > > drivers/misc/pci_endpoint_test.c:150:20: warning: unused function 'pci_endpoint_test_bar_writel'.
> > 
> > Have you see my question to the first version of this patch?
[...]
> The functions were removed in this patch : https://lore.kernel.org/linux-pci/20240322164139.678228-1-cassel@kernel.org/
> So in linux-next they are indeed not used anymore.
> 
> You applied it to misc : https://lore.kernel.org/linux-pci/20240517100929.GB202520@rocinante/

Ahh, it was sometime in May...  I assumed we already got this into the
mainline, hence my confusion.  Hard to remember what went out when.

Also, I looked only at our head branch first, as I always do, before
I noticed the updated tag.

Thank you for getting back to me.  Appreciated.

I will get this applied against our pending "misc" branch, should sort
out the warnings on next.

	Krzysztof

