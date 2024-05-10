Return-Path: <linux-pci+bounces-7338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294818C21F6
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A3F285B4B
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9146168AE6;
	Fri, 10 May 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DvxkZq/1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC8165FDB
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336509; cv=none; b=i24m44bDSdr1FWIfIsCbQYYF8Zlc8Mvpnzdar+y3gmB4lNB0A+a238jbPKyKk4fQV4cY8nA9F4/9jhf5S+Yp2aIzq3+FIXTlT1aKky9U32H6WlEhRGhL9D8kSbbuf7ER4oagHzgSoa8lMOLI15ugcS7cd+n3WpP02W8fvsbVhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336509; c=relaxed/simple;
	bh=gB3+mueVJC6rTSgQyDulrWqT4OQyPBK4CkJ9nqNOnDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMbBSPmdYtjEGeUPySm1ysuWUc2Vn3sDQCcEIJYftlWV9BEhavOAuQrOJL4zA1OK2sUYl2gcJOp8Wto3gwoyNa+5EX5QG0SW0vTYtQW+h6Qa3vZHgjJ7H/E5GCDq4N9f+k8n/6lqK453+dpIaOiqKIM4d6smro7RjGTI4CmgfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DvxkZq/1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b097b202so426344566b.0
        for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715336506; x=1715941306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gB3+mueVJC6rTSgQyDulrWqT4OQyPBK4CkJ9nqNOnDg=;
        b=DvxkZq/17/W9rupy1Hfln/8kNK6uwz2R/TXTT1RAt7ZPsoIMzc320aWKuTs5/3nHn+
         i4r3/I0xbJJ5J6tntEanAVxr6WCQ7/vSiKSQMMeThKl+6XqXiYfbp0Bl676VwWuVhj2B
         +LteVG4Lv67BImrMV8DaR9Lf6JVOl1wuzTQhfgzL6Sf04w8CuOy/NImxRZWoKSc9TzkW
         e5MLAlDUb7umCXUTSIC+FtOYxCGqDgF7/8Sa3bWakljkSPCEe0GMthF9ZfcbE0SesrBC
         XhdLjz5n8wMOPfyE8Yg1cHNCdooHZ7QInQd384eT8BqYfoc/k4jOdQq9yvc+zLx6XdL1
         xczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715336506; x=1715941306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gB3+mueVJC6rTSgQyDulrWqT4OQyPBK4CkJ9nqNOnDg=;
        b=MIHp8Ah6LbJwBFY+3UrJ+eTgzUYG466qPR/pnUFfDZUIsOK0kOUnBboFg9ylT8MBwI
         81GpI0wescMtcp94LcQQLYRWHcLzaPpSFWneMv5XJ93bEie9iI55IFK1LSir9x5DbUCy
         RM9CN4PZAuELcjOlAf2slP6x4QGJEpwXCWtkuR3iBm83/HIspTqVBco+g47L+PKWTaSv
         ZqTxKY1gG6fRUCglf1cEO7kwWlTxSmYQyBDWxJTt2fij3vnBu0OPgKmeKzJeq9dV9WzD
         alW6Rhvp3AGXsciFn9IRsQyU7funttBPGrRbydYpkwGOPdAKCQTV3cmy6f8XCBZwqmwu
         2PdA==
X-Forwarded-Encrypted: i=1; AJvYcCWqPDWRHDcEtLJUiPGJkHKxSq2K0mgBRJju1eQ3iibpn8L3j75PaIQJl6mJ4gdMxL8us8rGfHP8YQstPpFWtEPx6r/XapCMgSsR
X-Gm-Message-State: AOJu0YwSoyYFhRcIj2esoppETDPGl8/ugny+j14GzGMPPAbyg0Tp222N
	HsFsUThPxrf018HFcPpbzMetkkJMEnvWdhCSPUWAcvP+1CbZRJAXySIjWzD4ons=
X-Google-Smtp-Source: AGHT+IGm0ShzWqxUTz6WdBSaEzgp1Qnpb/3O6/pweXuPBaR9LwjAUlSsib161KD3DVm9rCH0vGd4qA==
X-Received: by 2002:a17:906:cc84:b0:a59:c28a:d350 with SMTP id a640c23a62f3a-a5a2d55ab1fmr161431566b.24.1715336506363;
        Fri, 10 May 2024 03:21:46 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d342sm168537766b.6.2024.05.10.03.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 03:21:45 -0700 (PDT)
Message-ID: <d0b5e7d5-3503-49be-9fa3-4b79c62059ca@suse.com>
Date: Fri, 10 May 2024 12:21:45 +0200
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
 <c30ebad2-1ad3-4b58-afaf-e6dc32c091fc@suse.com>
 <BL1PR12MB58491D2210091DF9607A354AE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <BL1PR12MB58491D2210091DF9607A354AE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.05.24 12:13, Chen, Jiqian wrote:
> On 2024/5/10 17:53, Jürgen Groß wrote:
>> On 10.05.24 11:06, Chen, Jiqian wrote:
>>> Hi,
>>>
>>> On 2024/5/10 14:46, Jürgen Groß wrote:
>>>> On 19.04.24 05:36, Jiqian Chen wrote:
>>>>> +
>>>>> +    info->type = IRQT_PIRQ;
>>> I am considering whether I need to use a new type(like IRQT_GSI) here to distinguish with IRQT_PIRQ, because function restore_pirqs will process all IRQT_PIRQ.
>>
>> restore_pirqs() already considers gsi == 0 to be not GSI related. Isn't this
>> enough?
> No, it is not enough.
> xen_pvh_add_gsi_irq_map adds the mapping of gsi and irq, but the value of gsi is not 0,
> once restore_pirqs is called, it will do PHYSDEVOP_map_pirq for that gsi, but in pvh dom0, we shouldn't do PHYSDEVOP_map_pirq.

Okay, then add a new flag to info->u.pirq.flags for that purpose?


Juergen


