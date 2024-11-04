Return-Path: <linux-pci+bounces-16006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3FF9BC05C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D7F1C20F29
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B2F1D54C0;
	Mon,  4 Nov 2024 21:53:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAE14B94F
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757217; cv=none; b=d36ImFyc1gy1D1mY87IJuzXbWkFud5HpiwMoLObiUpyVH5/pTWV31SC8wijc3ZZJuKBhjBPa9JdBlZHqcOSk8/hvvlNHlsbCjgxkFwSDtyr6IJDkdxNIRr35nYQ5PgXpvEqM/3L5r3Cn7CzUCiJZJjjtmArI7e4JdcREW7AvFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757217; c=relaxed/simple;
	bh=K0jj8DhChWu7UlnoLN0PkqZdQ8nPnGgDmWiB9GjV+VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFXtRWA2UCAbPgOmDyLsdVA3c0RjaMwDR5thDQbSV8YuBfu72BNQamg2uGEdqy8Ygd0rwelbEyIuCjynF6mIHGyxJXJ5fNZuaJxCzWXTFDskfqF3uOGXwQwX2+boTL8lYKyfvKAuUqfFG9AP3ZaHR8j9ScbwyZbdOmxjHMSidQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e681bc315so3375999b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 13:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757215; x=1731362015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDQDDQg/7MiOtnKmHr/jcbpFulk12AB+/nhzcMtNks0=;
        b=Ytu5ULvujT9qSN/h3L1SHzzR+RwK3Ov3RSTSlcIDEK5g0/Q4worj5bgMaVLE943r0J
         lROJDoc2/BwVhRONVGtuBasmJCEV1ESdPzPUwQs1Ur/5K6rxIYhQWBT7jPwPpEW2W8w0
         k5wlOHLMutz3ChNa7cniJioq2miZy40hlpzRq42B4Qb4v85y9My9jKW6RSm+Dhkm8PoP
         wBNGrFESfjdjD1tZZp7dJllN66N/mg1JyoKYcdN0bUpsY3mtkxS88gdXYxLuI5kFNzCz
         1pPe/Ngf+vJiOj7r6YBL2ejMyX4Hceh1zw8YtOCWZWjcra80z8wG+HXhJnVb0RzNBD6+
         cUXw==
X-Forwarded-Encrypted: i=1; AJvYcCXpQ3tlHbx2lj2H0crxCCsMYm9QILon0R9/a5Azvimm6tzcvHpxtOAuWUNIfbsPdkEU6CqgbyS0LhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAWfiCgpwkQQI4tklzWGapDCQby6QUGJ6yaRGAYfqDasRXdE/
	itLnNM0SWK42RhMSG485sZidIT6qxSxXcuBLLX1Fj/JFQsG1WHseUnsbJc5k
X-Google-Smtp-Source: AGHT+IE08UmHPFYIC1nDXzZFEKSA57ly74zbYlnQ0vVVRxGUVGqnugUr493kyxk6ac1EWSU+UtagCg==
X-Received: by 2002:aa7:8fb1:0:b0:71e:4798:8753 with SMTP id d2e1a72fcca58-720c96602d8mr18921984b3a.6.1730757215080;
        Mon, 04 Nov 2024 13:53:35 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8d2fsm8136451b3a.9.2024.11.04.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:53:34 -0800 (PST)
Date: Tue, 5 Nov 2024 06:53:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	ameynarkhede03@gmail.com, raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <20241104215332.GA1268882@rocinante>
References: <20241025222755.3756162-1-kbusch@meta.com>
 <Zyk8bvQZou-stmrW@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyk8bvQZou-stmrW@kbusch-mbp.dhcp.thefacebook.com>

Hello,

> > Resetting a bus from an end device only works if it's the only function
> > on or below that bus.
> > 
> > Provide an attribute on the pci_dev bridge device that can perform the
> > secondary bus reset. This makes it possible for a user to safely reset
> > multiple devices in a single command using the secondary bus reset
> > action.
> 
> Hi Bjorn, just want to check in. Do you have concerns remaining for this
> feature? 

Would you have anything against if we put this new bus reset sysfs object
access behind the following test?

  if (!capable(CAP_SYS_ADMIN))
  	return -EPERM;

This is irregardless of what the permissions on the sysfs objects from the
DAC point of view are set to.

Checking CAP_SYS_ADMIN capability, to improve our default security stance,
on a number of important sysfs objects (e.g., reset, remove, etc.) we have
was something I discussed in the past with Bjorn, but never got around to
sending a patch to add this check.

Thoughts?

	Krzysztof

