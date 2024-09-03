Return-Path: <linux-pci+bounces-12664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D18F969FB5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A3A1C20FC2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FDC3A1DB;
	Tue,  3 Sep 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9bLFB2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51B2B9A5
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372177; cv=none; b=H4WucqBb7qKSJ87daUQF/YMsO3oKCwOQ5dai6FRi11mJpR2CKDiJJCLia25NhYowFikh28CNQNLPPHSFkMsEeEDS2FqSshRkBok/sqVPQHRdKHrMCiXol2BFFcs/60+LjUOOBsePII2iMfYAUZe4Qj6Ox/61bvPYN4t6X7G6PQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372177; c=relaxed/simple;
	bh=KbVX5/WJLt/Z0+uhwnKhCH5C1tCBFTeakpeppFQXWBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOE4aSr5ibJe61dghr8dTS8kjDl/jwWO7Ig1LBf3WtmHosi9ncosbscMUVcLIlR442Se0ZuyJOpJV6nW6ye1OBIexJbKr95bummLEJ+Xjhoj/85LM2XzxkkmWZwS5DkAx07cqAlMm/8XsvWyla4fMmQRjw5sTCDA1M0RMD88MRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9bLFB2z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725372174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
	b=h9bLFB2zU55P1m3SVixy57/JwmVb74HIAJn1WQqum1VFzOuBmDbkUMW6ZpYpgsBm+JX2JI
	+czbRD8cir/hFmazmtE+OTb1K0VJmHCu+bJ2NoB/L0oxePFuRcxPixRICF/ROzkLVWGwhF
	Kwj6XvnyhnxDkF7JGSwHjOccmh/rpHc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-7qYNf20QNHWKYdkGzlrObA-1; Tue, 03 Sep 2024 10:02:51 -0400
X-MC-Unique: 7qYNf20QNHWKYdkGzlrObA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb68e16b0so60997295e9.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 07:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372164; x=1725976964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
        b=Vyr3ycWgbD1ARptjCgKOxAJaeV3Kc8lUT4gi21ZE2us5/zOdvtp+vbE12huGkm8pq3
         +R9JIh1Rru+lb2M5Zzhj95vJqkCOjndDvNDrYh+V86Y621Bt4KPDBcJYCI8xSdrqBJuN
         ALi3w/ivBdmBh0hPioTv160upHNPzyDt62kbrjtwmxAqgeoFDxeFg1qkomtgLseVqzgN
         DeEvgPsyHoKReu6mJ+A5mC0p9NyBcVhVAtXl+kf34qdeDFt+qohxRBIkkGHf7uabJFCC
         4U9Ao55IikprmGKBUscXSS8aMaSILkEaC8FUiGloNoSgomAS58c7qiA/cPb+mrNsSzIm
         XDrA==
X-Forwarded-Encrypted: i=1; AJvYcCWDDosGpd4S8fFvc7Gs3BITGZXnR0SpcDczYXVv7qD08q43dvSYsSBOtKL5pZzwredUoebVS5A6iOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmD9xqX+7SZ82mZJBSwGSSmrkMdkP6k2bqETrG7In4z1j6GAZK
	ssXBUZbEfwUoWV1pFxLXBqXdDbRYxk2wJ4PdG7HyEj69jOfXQDw+rAz8GQOXKIPqqJrr5dm19oe
	SrJrmNzDDz5Cm7EE3Uk07BGNEyIp410oXZUI+QXzLk1ttdsCx+ifDVGrYYg==
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013557f8f.24.1725372164316;
        Tue, 03 Sep 2024 07:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+gCA4emCQ8lN+v2r+4PD0Xf7gtP5260Hobybyq26ysa18Yk2eN574I3dEkpcvY9bhrHY7Q==
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013434f8f.24.1725372163170;
        Tue, 03 Sep 2024 07:02:43 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm14372770f8f.50.2024.09.03.07.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:02:42 -0700 (PDT)
Message-ID: <c5658b79-f0bc-4b34-b113-825f40a57677@redhat.com>
Date: Tue, 3 Sep 2024 16:02:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240902062342.10446-2-pstanner@redhat.com>
 <20240902062342.10446-7-pstanner@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240902062342.10446-7-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 08:23, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Furthermore, the driver contains an unneeded call to
> pcim_iounmap_regions() in its probe() function's error unwind path.
> 
> Replace the deprecated PCI functions with pcim_iomap_region().
> 
> Remove the unnecessary call to pcim_iounmap_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


