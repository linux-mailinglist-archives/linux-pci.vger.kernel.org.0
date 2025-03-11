Return-Path: <linux-pci+bounces-23440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81559A5C7E9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 16:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF1A188CED3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B893325E83D;
	Tue, 11 Mar 2025 15:34:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70825E805;
	Tue, 11 Mar 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707267; cv=none; b=T34jPu2MxiWhsxyJkJPtA0oCpdVrPDV1gBxnYxhwWPtCp95Cd8n/dIYVQbenQ7wDZKhKOtz/nwaDSfPGESEmrlmzfrxkhPvWAqXjpOzBI5pghc4DQAYDVlz3gyTjgbH2ROSxYakuZ5jB25tD8BenoPLScVAn2HWC7a9yzs3AtSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707267; c=relaxed/simple;
	bh=d5LHK8UgcwvGOl2UNFuhIPiUyyKpmlJZzTYBqs8A1Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTdkTL8PvqynRBUBvfF6HtP1I/c2NSXWDPW420dRNyltD6c4lCUJkZ2lhozTtV0kS6perlwBwilCYNTDsdp6SvyH47AhfxBmJXuOQnGQQYj9YRI4HlTUB9UpkU/BZCe+wTqX3EI3W3spJdjhTNcuvXSxwG7qFsE/USiEFwqyEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22548a28d0cso18612055ad.3;
        Tue, 11 Mar 2025 08:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707265; x=1742312065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnmgUREpEZzHIqf+ZGbEOfCKGLjHhsT93+h47gc6MEc=;
        b=Xjd9bsGogbb9YGBumwhlmLj8LrpfRSEbMQ2oF50AiNkljjHU2awOFRfkeGPd5xCs1E
         h5ism8jxEiJKOpPgTABhjWs4fxOIckhZH/xDp2nJ8Nbq1tTHLFM1q2AlqQg4jzGFvhgM
         c2+avpAL8srBOws4poaKBWgHTXp4hzmzNZ6Ir6xYVl4E4OPNUOOXjBwYUL6dgQZPnwIC
         tEir/n+uN4feXRuyfHBJ8HXmMgqV/5IrKdYcVCgwIdAa/7DQa76d7IxEE8dyR9/nXYVa
         7tV6dtG4jpw0UHazmMTFUrZ0BxDkzF6GM//ZSJ+7SWo5CiYDQF/tpV6Fa58OvIIFIzRN
         v3gA==
X-Forwarded-Encrypted: i=1; AJvYcCU9kqb2pT8crWqSgK3f/4Woa0VptYNtmv2pkL0y9ELX2QWKqPpLOBpAPFnIgZFnMTwKtLxpEVzs@vger.kernel.org, AJvYcCUQzHXNNgf4eZnWtRaEJNpNB1hDtyGrNPF0pwaVbq3f6SQbCU2/LTaHG5AIKfpDkI1JxQvwCzT+X9Ff@vger.kernel.org, AJvYcCV7v6nKgOcl6uyRUAl8bcuJSE271CHREHfQwyTK6z1wDsRZYvkl7yHSwMffXeXI2joSvYoTd0udJMSPAQ==@vger.kernel.org, AJvYcCXseIvVna+WZKqZ6CrhqPuCixYxoYNyvU0GBoxhADj3+F57cieCsyDO/Yn62xabeUimoRtRSYl5dIVVqpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVaUqbsLqhVnHn+7Y6kQ8FJdAvTTyDhUzUQ+7mmSzcF5nxRiI3
	AmDRp5+BvbdzjFRGRD+zp9AdUxoy0jrPiaBuFXPgAmn7ywVYzn41
X-Gm-Gg: ASbGncvUJxXcl+WdJVSEXVYWBS3r3dThjKgrgAWPoVGwRnInVYOgKNFHKz1XFLBZiML
	/Vpa0rvV3Ktz314kkhkcLn81EaB6qxhD+nrFgL5+oRk0s5MRBDgdO2ztjZSgdAIIZ8t6NLCzAkz
	oxTMcIOTN6LFIG/qA5TPTylwmWUE3Iv3m47Q4qD4Zb81rYIXmwsf8WVqYvivayX0ld14KnYEcyW
	RvwI8cWJiIftIiAU3Bej+MvSbE4V7eDQ5ulQbSd0hM9Dh1grJn1zZ5ROh0bPXHp3rPMxFPxHtn9
	WPpBoLudOjcDmru4qWEt+DjbEqC/KdG9ulWTzeszVSlHT+wtn+UnOzqu0asQ+JntkramgjZWBvo
	C6gg=
X-Google-Smtp-Source: AGHT+IEp15FNyX/Zw521mFQHT8du6CWvUWJLD3C+Me9OYF9D/bY261KLnGwCsIfgZX7kcU0kGdCDpw==
X-Received: by 2002:a17:902:cf07:b0:223:58ea:6fdf with SMTP id d9443c01a7336-22428a8d325mr352593315ad.28.1741707265450;
        Tue, 11 Mar 2025 08:34:25 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e944csm99547085ad.74.2025.03.11.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:34:25 -0700 (PDT)
Date: Wed, 12 Mar 2025 00:34:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250311153423.GD1381004@rocinante>
References: <20250305132018.2260771-1-s-vadapalli@ti.com>
 <20250310210746.GA2377483@rocinante>
 <20250311051806.smcu4o4dxpngimth@uda0492258>
 <20250311072546.GA277060@rocinante>
 <20250311073216.ynw7rzmu36dwywij@uda0492258>
 <20250311152133.GC1381004@rocinante>
 <20250311152921.cwb7obw5bmlrhvsi@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311152921.cwb7obw5bmlrhvsi@uda0492258>

Hello,

[...]
> > > > No need to send a new version.
> > > > 
> > > > I will update the branch directly when I pull the patch.  Not to worry.
> > > 
> > > Thank you Krzysztof :)
> > 
> > Done.  Have a look at:
> > 
> >   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/j721e&id=01d04dcd6e80f63ca5e97324ec17c20553947e35
> > 
> > Let me know if there is anything else to update.
> 
> The changes look good to me. There seems to be a minor typo in the
> commit message:
> [kwilczynski: add a issing .linkdown_irq_regfield member set to
> 
> You probably meant "missing".

Oops... Fixed. :)  Thank you!

> Thank you once again for fixing it without the need for a new patch.

No worries.

	Krzysztof

