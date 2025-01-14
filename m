Return-Path: <linux-pci+bounces-19711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F40A1025D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 09:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CD4163A62
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0177B28EC6B;
	Tue, 14 Jan 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaqgT+oY"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DB234964
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844603; cv=none; b=ukCLpGwF0kTfK3cueOjd0P3/ROOf1EeWcz1oKuNHc1lPf42XaeQOr/RV6zZI4jvaHcQNFsIs4oLyQKtsY6aoAys9FQ0yjTKTFACaFvoY9r3vo8HyEwAdnRrMKcauz4vM+FdIC4hf3ORXJyxsQMyCwDnDC+4HPASFGimYIYfBVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844603; c=relaxed/simple;
	bh=yjI73KXE1o0v24JdQTFtJedB3AghlGDfi+/rsDjpB3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVmxk0cyDshWV9f9prrVkvvOO0mFW/whLNuKSkQI7FEpTL99aTWXWVxGCnz46ySYmwP8hCMjJ9oZ3p8fQI8Eih0/v9+qGMbXwNf1D7vJWWnIoNFan4TsOLeGDQWq5iP6YiL4UR+wkw/5uEqJ2u4RTcZZTF2IOdnppD0Vbv25oG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaqgT+oY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736844600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPh+lL8fM1azGe99o+jyyb0ZHEVF7xd0MdY/zPEIluA=;
	b=LaqgT+oYd+QgksEA0MozlPU+Z+s4Q5jFCQOYk4PvSV3GQm6aDOcKBqJID+NkWul/D55LY8
	Dck1yZHUYNpx/SCl8g+Km+UsO/9+KLwtmcSmztcLKLmWXPmuUFpRtPOcDRO76pHEZ18cFB
	hRAo+Yz3UOmFrtobkSDi+Dp6DJJkFOA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Ar4TZdKcMd-5ZXyNeFwawg-1; Tue, 14 Jan 2025 03:49:58 -0500
X-MC-Unique: Ar4TZdKcMd-5ZXyNeFwawg-1
X-Mimecast-MFC-AGG-ID: Ar4TZdKcMd-5ZXyNeFwawg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so41922485e9.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 00:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736844597; x=1737449397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPh+lL8fM1azGe99o+jyyb0ZHEVF7xd0MdY/zPEIluA=;
        b=kaB3qrOWAOVZEzd9bvYGIRws+94uEr7rJDt0HNrMtquFaFINT2ZFkK+ZR4R4Vhvwgp
         Q4GECIk/jeTNOZDvTk17zuOhJ6k1P9MNyJQjuHHlnexzPxVC/cEsG5XnMDAtBJ93em4I
         hOhVdVFdxbeHTZ9Lhu5IeV5AfiAwHe0reKI6xOciKoAuTEFou0MaWi4ApIGmkXYg0Q6l
         K6Jh7OL9KZFtr84mBmxKaJ7Rx6s0kYGphB2QmLdwY0uCfpEKgdgmPH3dO3QQ7sn1utCn
         HHJq4mxmd8Vt1grJYv9MpqomYGHlD3VCh7ShywZOF+mjUopeiB+yTOQYAOj0uDOW+2X1
         AIBA==
X-Forwarded-Encrypted: i=1; AJvYcCWT/IOliH7m1yNJStPYctHbnzovs3Vljit3jjvEWyt2QDTSjUFD0Hp1JcshZ6+BiybY7saH+u3Phl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx19bq23ua1n3EXyJJhsVM3va8fjlPli0iFdhCLYpQykQae0kak
	IBTQHu8RjbkEODmsyvc9ceogv9GuH76olxzbv1FEQ9JSWS2/aLkEePU8nRAwe06/oWIBkOzwbE/
	Ifgb9tO/Iq72r+DXmwrcB43M6hLICBnTNXwqnYDfqzCdO0jXNktwLeDDBiA==
X-Gm-Gg: ASbGncsEdr/FEpsySMc764ceRb/o9Njmw9lOSPiyCtrh200wsYdnuqO1LoloYSHCafc
	C3LXK08xwQHPPyggjIzeAMbF5m2mcp3TxE4QucROdZWy57+GIeq3vhVl8OaBCOeDZsABOzuSxqB
	42u+xveBRTX03G+DFPUAolsERAWQJo9HfgcegET/FBu++ecLyoxbZenj2T9sXJvTTFNB0L02xC7
	OK8R2BAfspG2nzU+GJZ0wtuHlonjxKTYNzgE0wKOWDXT8ucvE9cCTOfXf2mHMoOk6c+TGTrKjfN
	51LRkmBRoeA=
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr223306495e9.7.1736844597268;
        Tue, 14 Jan 2025 00:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOIBNjAnXgPwJtVjORPvgQ1GVBYC46pvFjgixl6aysLuqBaKkmhOPJs5mJt9C7n+7EkBny7A==
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr223306125e9.7.1736844596920;
        Tue, 14 Jan 2025 00:49:56 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62116sm166347825e9.35.2025.01.14.00.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 00:49:56 -0800 (PST)
Message-ID: <44a21765-1283-4e79-b24a-fb672399250d@redhat.com>
Date: Tue, 14 Jan 2025 09:49:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 M Chetan Kumar <m.chetan.kumar@intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 12:33 AM, Maciej S. Szmigiero wrote:
 @@ -530,3 +531,56 @@ void ipc_pcie_kfree_skb(struct iosm_pcie
*ipc_pcie, struct sk_buff *skb)
>  	IPC_CB(skb)->mapping = 0;
>  	dev_kfree_skb(skb);
>  }
> +
> +static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
> +{
> +	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
> +		if (pci_registered) {

Out of sheer ignorance on my side, why 'mode == PM_RESTORE_PREPARE' is
required above? Isn't the driver already unregistered by the previous
PM_HIBERNATION_PREPARE call?

Thanks,

Paolo


