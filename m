Return-Path: <linux-pci+bounces-7328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64BA8C2151
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37EE282980
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8581635D6;
	Fri, 10 May 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H5KPqkoL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591715FCE1
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334829; cv=none; b=jOJT9dibJur/GIIPXP1UHAOqYSFM9BB+iNmkj/wNnfryP5ogCqIcltUZznG+ffkowHZbn8fCgTY6nAplg7QJSFRwKGDq1xos7OkqWatTuNixHZ7q27bO5fn6X0UVejC/iUaMzqQN30hlmMF49Rvi1vfRou+0ad4QCj+NBVP01PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334829; c=relaxed/simple;
	bh=TkEdq8r0+/swqUjCHG6c36VrHTwqIXDZ1QgHk6NLqPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlZRN6asOfIIcSgko3yePhHYnuOeeNPeTUGPk1S5XLq4y2wVdCGv1erNHf93lz1mjP9Gj4oUFGSn8XBcgO29wDuFO5xq4rdK12avtprvSPC7VVOTI3orEhdLfY8qEp/6x9j1YL1XfgdxGctxgRBJMWVE7xXYji5E1HVBE61hs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H5KPqkoL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59cf8140d0so442118366b.3
        for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715334826; x=1715939626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgDr/j3I45aVQZVCtriHh098OsnX9VLTCcgYdnyh5r0=;
        b=H5KPqkoLooNmNVNVzl9Sy8BA8PYeBQZTrvQrO4cID0CGS8Y7qHqeMvu+YnkID+2cQs
         GRtm3zH+0H/bZ0X3UDvNR5sf6ZujFwJO3213f8QlJ+VK86IdlH71DwuX/5/fg2kJZSOg
         b87gNL97392rVinS+mpesirADnXDGoGYCJwAzAqHlXap9xWMyBNUOmezh72tYQXXSyor
         lXxQWqpwrYEt/HRmlixGBExcB3iAbhvGAOb5Zude7IdIDPEXMAThNztbjf2H82iEB5sx
         kf0YJs4KTWcmLx3NxCXY1YEPdsJ76LLChJ0pR3h3kDDj4em8mTLFdFGm+fLlrV8Mk5Iq
         znQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715334826; x=1715939626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgDr/j3I45aVQZVCtriHh098OsnX9VLTCcgYdnyh5r0=;
        b=JEZVzrbA0hBBNieaODNCPOKFkONnqHY2n0V4Gg7caYZBGUBh5h/FWX801yQZQ3o2hc
         Hh4p8BEFqVP5IhEqB376Itfwt83wGJXpxeAuAXiBqvKyizY9MRw6nQD3WgLtw5izma/F
         G0knyrI6oij+FalImMb2A+rBAtdi+I+6V1Yl5TkZDK6AXN+tFLuTlOJG99BlOHKF/G7V
         w9QtbsMf1Y/Jyw4VkjcSzO9TpCztedGiWk++qlBvsIeAaNNJjxNwbjo+HR1zt2hCmVqh
         MuzbIljP1MkXjby5cyMIl0opHSAfScQ4KN2Ll9hNClLYcffwIfsA6mhcizmPpq3K4vHi
         wsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFPc8wzDV+p8eJBBJ6iSTh2iqPDGaqtPzvVihiCEGC+Lex3pxOt1QqkZStqGs2++KYVIp3IC6uh7GZxdX02wtNrVHnOOuQ/jTI
X-Gm-Message-State: AOJu0YzXcpP+vJs4NkhDEomskefbepV5gPVwb6FPKAU92sL6Z788qVTp
	Onbmx3WstLXumvR6IcAeBW08ri+/Xtu5MmAlY8lg+Jf6gXhxbfPsXrgYDrXA7ao=
X-Google-Smtp-Source: AGHT+IEKz31JvWqjAEmRomlfNgaF8EqP2HQK8r73XnIs3tomW69Tn3zJ4arHD6nbkZkJnphFIwRQPg==
X-Received: by 2002:a17:906:134d:b0:a59:9eab:162b with SMTP id a640c23a62f3a-a5a2d5d01abmr136503366b.35.1715334826351;
        Fri, 10 May 2024 02:53:46 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01968sm164814366b.166.2024.05.10.02.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 02:53:46 -0700 (PDT)
Message-ID: <c30ebad2-1ad3-4b58-afaf-e6dc32c091fc@suse.com>
Date: Fri, 10 May 2024 11:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi
 from irq
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-4-Jiqian.Chen@amd.com>
 <79666084-fc2f-4637-8f0b-3846285601b8@suse.com>
 <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.05.24 11:06, Chen, Jiqian wrote:
> Hi,
> 
> On 2024/5/10 14:46, Jürgen Groß wrote:
>> On 19.04.24 05:36, Jiqian Chen wrote:
>>> +
>>> +    info->type = IRQT_PIRQ;
> I am considering whether I need to use a new type(like IRQT_GSI) here to distinguish with IRQT_PIRQ, because function restore_pirqs will process all IRQT_PIRQ.

restore_pirqs() already considers gsi == 0 to be not GSI related. Isn't this
enough?


Juergen

