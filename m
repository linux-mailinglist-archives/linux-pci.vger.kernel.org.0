Return-Path: <linux-pci+bounces-12882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7D96EAF5
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C494D285997
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C914265F;
	Fri,  6 Sep 2024 06:48:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8732C8E;
	Fri,  6 Sep 2024 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605326; cv=none; b=tU0EAFXa5dwZ0BmX1g/qInfCL7CkNcsLIwBbceT8MaD1UttDCSnrlnlWBXarMFckYvXkJMF6AB5ku3VNhkNTK/ym9h8R2Jw1CLi+SVKU0Vejcbs5+awwIJ9eT02WT0/xQ+C6P548tbChug3NC5QyZ5neNVz5eO5e/Krf2RqjHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605326; c=relaxed/simple;
	bh=NXS5ZK0lqzOULgd1LCTYCrHVS9wA1Kpya+DiHw60DTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq3Jw9GQqOOv7LXnP3r/zMs1rTeCDeDUCMzK6mhevuJQAmy6Rlxkd6jvRGV2NvuTM+9TVdSQaCK48CNSPE4+Sj0LDO+h5PERXayGV+7CrKH0BZzLsKmsvKH4yxVB6w8cwzNYqOl58ncc5zSW8PF7M8uWNMH9pHfJuWsllVmvGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718d704704aso364004b3a.3;
        Thu, 05 Sep 2024 23:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605324; x=1726210124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjecQQXVxyphlazk9yR1DSS1IxHXeEWdJ2bGDGBfqVo=;
        b=nIzUmRF5jhnRX7PzIb50PlhNuMN059XiWw3usZ4VH6ynd/kr5Z/3gMvDZRaWAiGzfc
         vspPriH/B8Lci6pg5fkMW9GvLKizAyEq9fDbeHv2TNSwKfNJwS/VPgk4u+m5LmqqU6CH
         GXyXmWW2pzbyTwtw+wjNDqgz7Wt2IDmbSaECi44Po791zVN9svmO9tgeAwqJ9t6OVJ5Y
         HihZ5SN0kdSAAZWZWLOa6msDrLv9DFxiC4l1BbbjtxzlEuBCM0VOdzAIVEe7mlR5osjs
         j+baElp09IwCZNxtjCjMJvyykAZGaDSwLXTBekcpFTbF8CNg9qjyiy4ELWgYyYcz2reF
         yRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLSzj7U4EULZjz4GboQBFqdmCl2AxnEoa/FefWrssSK7iI3bnAXTM3Exx8A92ni1g842iyY6vUWsi7@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJ7w6hVn8jqi/T6+rzLpboaKWXVBOYDip2qXEaUu1Q36XuA4g
	GCi+DCcdH7fBwUg9E2C+Q8AEVthfGcUXIOtif5mRPU4bl6rSf1VT
X-Google-Smtp-Source: AGHT+IELHxEdT89rx+3aTx8bL3glmh7h9vtNWzgc7Z1akYjjecDGsRdR9tgUtmBEmdzIPJUyypOvxg==
X-Received: by 2002:a05:6a00:198f:b0:714:2533:1b82 with SMTP id d2e1a72fcca58-715dfccab85mr32451515b3a.23.1725605324381;
        Thu, 05 Sep 2024 23:48:44 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177859968csm4340081b3a.146.2024.09.05.23.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:48:43 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:48:42 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-leds@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED management
Message-ID: <20240906064842.GE679795@rocinante>
References: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
 <20240904104848.23480-4-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904104848.23480-4-mariusz.tkaczyk@linux.intel.com>

Hello,

Very nice series!

[...]
> +static const struct npem_ops dsm_ops = {
> +	.get_active_indications = dsm_get_active_indications,
> +	.set_active_indications = dsm_set_active_indications,
> +	.name =  "_DSM PCIe SSD Status LED Management",

A small nit: extra space.

Bjorn, we can mend this on the branch, if are OK with that.

	Krzysztof

