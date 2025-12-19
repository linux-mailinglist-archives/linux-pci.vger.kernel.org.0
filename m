Return-Path: <linux-pci+bounces-43409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8BACD11C8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08BF9300C8FC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A859329E49;
	Fri, 19 Dec 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="G22Njx/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9C32B992
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164893; cv=none; b=g3QEyK16Gzj6GAcIhztN4qT2WbfSsaKi3p66Y4nsh07W9DH+a0yHo+G0MSqCXDWVGMXxKXPrRkUNoS2pDBIvEcirSwi3TPRLJ4jCH9CPlppjYD19ykwCDnBauyACzP7VyhDfoPzZ250aeovqVlt4ofinfEO28y54YwF5Xzv7iAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164893; c=relaxed/simple;
	bh=Eu7fYQUBOXyG224eItn2cWpfYezwnojs51HJPGnoyso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKggECJgN+jk/yFmr5rblT0KkKSq9vsqnC386XkL749DAUZ90olMLjX+iTdJVTSAfrscVAaPFoQomp9vv0gzRt6jvzgzoOwDaF+dBkzwMJkrFiDuEaCkwH8XVDCs/tr+WfOkUDKSrq+r4FvS0SFxnz+QoigTAj57OXWgDDN2KeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=G22Njx/w; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so3131918a12.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766164890; x=1766769690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nzQHHF/S+BccOb8wa9qfv3IuOW99jPcII0xzfB0+Go=;
        b=G22Njx/w/A+tk6D2UIpMxyoLxg+FQc8iliWhVyb03p5QUZ+uclrlQoU97nW0oLhWKk
         sAa+kajIYmnum6p/TDC7POEtlalIJabwXKOukAPd9y/u3zLf1KE35JS6nSNmHXvu9tuo
         wIRbyvE9CnI2tMi2Qk7y/3BDPzCE6qkL70enasONG34gohbMQQ3XWOJGYrCwvOYtZ4Im
         t5L5WRa4EeCEX8eD4ZT6ls2lxFVXjzGNMnDIGlk22QOYZggCyK8x3VaX2Yj3jTxWbzrU
         Q09QNqXgiJ+5XS7dAur/jG7JBjPpuILeJhAkIS8gcZzc7UMb2kdRTEhFK1ODJ19r7mjL
         8FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766164890; x=1766769690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nzQHHF/S+BccOb8wa9qfv3IuOW99jPcII0xzfB0+Go=;
        b=TZ2dB9G4e80+HutoUaJ4bRFrPfSWvaf6Zp0eJOsaotUK0g9SdciSUnVeVtLsV8IUY9
         HVcCsHHbbytc/Ak6nZjuZfOZtKg9B09mEHPC2+UZ45x8MfzVTfyJ0KSjv7DLiBVy65bp
         TAW5RhgXMm/8sIoYBc2XYiwJIk6oO3MCRau3NLRQd59wwkkNUJJV/fUUmp9rLN1PUX8d
         W3lfdU2ObQnw9DxM83pfCPZ3o8/BzsX72fDd/gv50VYt7SwOPaSS/vQ3wcfYL12Ph0IM
         hAu4UuqaMwLitDk9aLYKZP31TdE91SE/yrqgDahJ2TZM9anRz/GRkKvf0r/AsPV/SXsZ
         PeKw==
X-Forwarded-Encrypted: i=1; AJvYcCW0606+0Y/w2mjvbsfeVUIxt9ChkL4BqUhHV1NpEG7n022bXZkXbktO1vUcbBbosyZzkKlh37QW4aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcNrBm8vZGog6MMhjetfYpkhUQiDC6iGV51ZSBZwYhBZjLS5X
	i0AdV6YHyKTsYVnzVC25qNb4YR2XxCNLP1oeacAFg0+p/D+ADho9x+yNph3I95W19oE=
X-Gm-Gg: AY/fxX6CBUniIo044QzLSTrbzKoqCrXj9W4BgPKpbi3cOMQYiLCEyGNmXsP+7+U74f9
	3KKBm/+Rtqats0rUUVvn7t93OGJYFLyS8eFLvvJHcCcVk8hsxyQ6ZPD+0svtKSWr8qLTKMLIvZE
	OZnsrdGpbKFoNLGoqJAJf+HCBzy+Mx3cAhWR9D7tq4J3UK3vD99GNrO23Z5sjxvAarj0PclFurx
	1GgETz51rA37rLLxzaljxafse4BclX6i3peTv11wAGsZiaa0hvhdeYmfPgTN2GOunNTsWT3/B4Y
	3brVgWTwsfEahqellOYy63PQXEgMAITZfZBnbqOqNW8MyPQsbEiYtWj0rqTx99m26OALozsNKBd
	1JRPTIgd1UtTpc//Y067kXAjcDz0Z3hG4KDTT2n7WwrnwDc63c1+6QrAzRxQK9FKByndpf6XHq9
	prBcw+fiQhWfcUXprHXA==
X-Google-Smtp-Source: AGHT+IE6v83ThLR84HAPweCtmBhiOxhwyezgVI3gOrK46YZQBm9NnevJEXxrckISudnh+58Tk5217w==
X-Received: by 2002:a05:6402:35c1:b0:64b:6c8f:f99f with SMTP id 4fb4d7f45d1cf-64b8ea4b9dfmr3263450a12.12.1766164889674;
        Fri, 19 Dec 2025 09:21:29 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494c0esm2667948a12.20.2025.12.19.09.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 09:21:28 -0800 (PST)
Message-ID: <d1a9a430-ac14-4d19-879b-57287b434cc6@tuxon.dev>
Date: Fri, 19 Dec 2025 19:21:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: rzg3s-host: Cleanups
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
 <aUU6J5anuzNgSeBr@shikoro>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aUU6J5anuzNgSeBr@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 12/19/25 13:42, Wolfram Sang wrote:
> Hi Claudiu,
> 
>> Series adds cleanups for the Renesas RZ/G3S host controller driver
>> as discussed in [1].
> 
> Is there a branch for testing somewhere? DT parts seem to be not
> upstream yet and I don't know all the dependencies probably.
I pushed it here: 
https://github.com/claudiubeznea/linux/commits/claudiu/pcie/follow-up-v2/

Thank you for checking it,
Claudiu

