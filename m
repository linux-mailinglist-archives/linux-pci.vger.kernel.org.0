Return-Path: <linux-pci+bounces-28077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57681ABD2AC
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F4D4A68EB
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A1263898;
	Tue, 20 May 2025 09:05:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0120D506;
	Tue, 20 May 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731916; cv=none; b=OajXh+LqmIEQ5/1etqx8rY/kB6BLf1PT1vuxa1K0flH9ozcU6d4/jcon3gttNfUy4zu33vD0jrlAcp7Li8/hlcY5mxXRQZRboUrc0sJY/Im76Au4Dl9OXpOkKPfAiqvTc2XlXtQF/QpDvXTSF3TgS5rpEHI0gLKKaKu1IanNBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731916; c=relaxed/simple;
	bh=dslqiiVnq1SOhLyyjEybB4KGFPRMGpZlVqR4W9BJhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed49JsdZRIiCucoq2llaUvkET1++Z6CMewj0HMgTQG5pTBosmdUr4hX6dmtJ+JSXMW1xUVrHOXZT/kMfONI6U0WcjdZaPUpgwLZ2mx7aRZAl5/f8Xr5QTH56e62CegVYbISnaA1+mf9URWU+WoUtcHSm0ACrg+sH+c3KrvPVTyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so3563103a12.0;
        Tue, 20 May 2025 02:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747731914; x=1748336714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPLD9IYUR0Y+5sJprRW/vuKK7RVWsVDEYp/o2Jak7lM=;
        b=FOTzOxc3SxtcuTzDJV0DkP3wQ8oA61TzUEXDF4VuYhJlVxry1uSvSaEf+hcu75kUDl
         86++PdH9a4AbhWnkiKIVWppsWBbsHbPewQchC6ZXEZI7pTDjZoiEGA36fDIweWq+Q+zp
         Y07JIpeaRThLXEZqhb667qzigWKhL41HxB0yJaAicrxcNeuqIIo/GLPAO9pXpihYFBxq
         XHCnnNpUCjilzDDji4lgbmMlcxblL+ge3b26M3fY3Z5vWIMGoZxwspkm4Fku8MSOH6tl
         L0lQaiKZqZ4VGBgt0t5xndklbKk9z6QgOc2X5T+sV4wj+7dh2pP+0FCkJLfWbMjwlrFp
         VvVg==
X-Forwarded-Encrypted: i=1; AJvYcCWD0YrxoY9+WxmXz0fpjlusXrM478gE7ZnW8t6umuXPDaEVtDyPIERwn0EWAx4ZBkrmADsf+AjGoAHfC8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3IPVPfmqlS1Hh6qH/b8C06r0WLjHmuGLikl5Rldc6Ml+wEKY
	gU//TmozYwjKq67ZWuKxOAkEfxTFDFjUMsuOfPFUqRCX+BgQVw3KN8z3
X-Gm-Gg: ASbGncvBcmZtfdc+XAt7vTDmt8ahcqY3jx06xqJFfGgB537E/ngtPEnChaJIBNTVZTB
	2wU7l/pfuuVZfLVJwta7/e0X4ZaUR1qf74Nbg6rbmfpxJYosfQIaMoAbhSOJz7JuVBj0mbti2nJ
	RVGxstRLKKRq2HoR/cTca+zMbpGMwJ+zvJR/+RlVHdCddRD91aQ8rbUVGw+11Pw8lnufkbEOhxy
	oPsGmh52Krdgzon35NaQuonasQHMALqQeH80Tje6yQoKvj1sHM3/t77AdBAsXEHWltqPEyN14Ba
	g9JTa2SioO0d91nHCwiyu8mgsX94VejLk45VU1lbRCbgtl/PkyfalEoR6FbfbEDc5BOcItssU1n
	OwMBhjYwKiA==
X-Google-Smtp-Source: AGHT+IF9SMS8koL5Y6RdygoaqjEc6b1s5T1eXmJSkB0oyvgy8zufe4IJynlSet98+P+t12+8WtOqgQ==
X-Received: by 2002:a17:902:f551:b0:22e:627f:ebc9 with SMTP id d9443c01a7336-231de3514e9mr164934925ad.3.1747731914152;
        Tue, 20 May 2025 02:05:14 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b26eaf8cc59sm7547070a12.40.2025.05.20.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:05:13 -0700 (PDT)
Date: Tue, 20 May 2025 18:05:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 00/16] Rate limit AER logs
Message-ID: <20250520090511.GC261485@rocinante>
References: <20250519213603.1257897-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250519213603.1257897-1-helgaas@kernel.org>

Hello,

> This work is mostly due to Jon Pan-Doh and Karolina Stolarek.  I rebased
> this to v6.15-rc1, factored out some of the trace and statistics updates,
> and added some minor cleanups.
> 
> Proposal
> ========
> 
> When using native AER, spammy devices can flood kernel logs with AER errors
> and slow/stall execution. Add per-device per-error-severity ratelimits for
> more robust error logging. Allow userspace to configure ratelimits via
> sysfs knobs.
> 
> Motivation
> ==========
> 
> Inconsistent PCIe error handling, exacerbated at datacenter scale (myriad
> of devices), affects repairabilitiy flows for fleet operators.
> 
> Exposing PCIe errors/debug info in-band for a userspace daemon (e.g.
> rasdaemon) to collect/pass on to repairability services will allow for more
> predictable repair flows and decrease machine downtime.
> 
> Background
> ==========
> 
> AER error spam has been observed many times, both publicly (e.g. [1], [2],
> [3]) and privately. While it usually occurs with correctable errors, it can
> happen with uncorrectable errors (e.g. during new HW bringup).
> 
> There have been previous attempts to add ratelimits to AER logs ([4], [5]).
> The most recent attempt[5] has many similarities with the proposed
> approach.

I have been testing this series locally with and without faults triggered
using the AER error injection facility.  No issues thus far.

And, as such...

Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof

