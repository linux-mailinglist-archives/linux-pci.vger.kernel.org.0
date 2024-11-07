Return-Path: <linux-pci+bounces-16257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90A99C0A83
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C77C2827EF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197962144CD;
	Thu,  7 Nov 2024 15:56:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC02144C6
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994962; cv=none; b=NvlDYx0alxx1fHpVl3YbNUQfQZ4NzfaYvIVJjkTJKEowK/RG5ED7+l0woYmw/Sers79Ewinga11lS6XsuAy4/ovsoSg1Y1GDL8N/LAHhP480wWtVp6nAiT92fcDyhuUfAa98P5O3yLCNusDNczAc1TNBEMopjByw2zCMdb8p8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994962; c=relaxed/simple;
	bh=nbcBYhrouVHNSl/xQv7ZeM1wvzejIJBUFUArRL8PRz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+7V+ybBf4YPgP/zA645hsDtNTVdFt0OaSCbEhAAhVDmvz9s7pB6XvODIBiKOZ0hCFgKaRBW4QSItn3DGzAXLXMziBR1o0oju3bM1yJjkUzEJRoyi2cbYq55SFOVtwFJdMZ/gnLVfNKwK/JZh9tycpDSfv1GPq1uJCHTrOUPYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso886595b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2024 07:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994960; x=1731599760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMqePYMz3QKtUK1mA1YGP8NO47W40BzsFQKsk+ayoxc=;
        b=PuR/9JJFKhzdUBlZ8gfCOrBcT9RwWBwUXvdDZY+ywV2aoFNppS5i8wfQGsFCnrKOO/
         eReQcpAMNExPHLPYwuBC/dtb8Ig8zz4qQ/VA/rOx3xKnyb6aa/zwB6/nfg+sFtn47CHn
         PI4QXxhwaGXuiYKhRS6ggruKT+G0RUJ8xvHFn+LS321gKshc926pCa/MNtS5O5gaxyv2
         5RY+rCJTBp8fob+lqeKLFp3K/2pBULUtqYnHMaO/lJD0aJd+dG3HRKWnbisJfKb2Zcse
         cUOIdVc1h/MsavkZ26FttebGGW3AtnFAac+wq6fDaTR+C5ItWJT4+ofiIjOz1/9eIeW/
         v8pA==
X-Forwarded-Encrypted: i=1; AJvYcCV2WWxgCNqgeRRATqYpCRfPc4aPy6/lb0CzqZ7baYZTJfbIedyT0E1I7Vi6IB9L3bs/DxnUTstFxi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLe0nXl/hkd3kxp8/afNAfTzuAgu57cjvQEfXmSIoHV6dAFxSg
	GAvcSOaCpANip7nTh6dir5Z5aSWESXk6DTYYjqARhY9NaMBH/7fg
X-Google-Smtp-Source: AGHT+IF8o1Mutw3voEYEdoYMnJF4UgOqA3A4A1j9I7FBtpB66MhUi9qysswt8V9EKdfHW6SbzwwX+Q==
X-Received: by 2002:a17:903:187:b0:211:31ac:89eb with SMTP id d9443c01a7336-21131ac8e59mr228031495ad.11.1730994959873;
        Thu, 07 Nov 2024 07:55:59 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59df0sm13763085ad.189.2024.11.07.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:55:59 -0800 (PST)
Date: Fri, 8 Nov 2024 00:55:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
Cc: 'Jonathan Cameron' <Jonathan.Cameron@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4] Export PBEC Data register into sysfs
Message-ID: <20241107155558.GC1297107@rocinante>
References: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
 <20241101110425.00005582@Huawei.com>
 <OSAPR01MB7182C8F253B9FC6044ECEA8EBA532@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSAPR01MB7182C8F253B9FC6044ECEA8EBA532@OSAPR01MB7182.jpnprd01.prod.outlook.com>

Hello,

[...]
> We will modify the implementation to follow that "one thing per sysfs file" rules.

A favour to ask of you: if possible, when sending another version of this
patch, if you could include a changelog as the comment, then it would be
great.  This way it would be easy to follow-up on what changes were made
since last version.

Thank you!

	Krzysztof

