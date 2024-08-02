Return-Path: <linux-pci+bounces-11158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3594575C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E86F28783A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 05:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7566F2E646;
	Fri,  2 Aug 2024 05:18:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC51C2BD;
	Fri,  2 Aug 2024 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575894; cv=none; b=i0cisxMM0G+WCnrNAZcGBI8CULO2Zdk2SijNYooJfG94V75FYajF+gg6HAka2X9WSQiW/nULBlBBQh2WpjAp9MNtXmajvPW4/YvJQuo2MpmMeReTG1T52R+raT27QQL42BG+8JzUuOverj3Vb/mVPyqalkCHCZoszn8AHVr6ns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575894; c=relaxed/simple;
	bh=KBnywWN7spBgCoWrsqgsxLIdipGHzAll/sCSzpFWEyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6PBJPxYyNRdpa1+QI++EP6Uaj7Ic5N8lDlBxOu750aV1vb6PsDB47NO+e0mQo4YtIKeKw2RQItkK2r/RaM1R9qAHykyabTKAH45GKCGCdlV4Vg/RLPBe38ZYQ1CqKDho4vDlh1vTJpKogqow00pnlBCOIlEgmKPAwT+uH9qfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso8253832a12.3;
        Thu, 01 Aug 2024 22:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722575890; x=1723180690;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj9j6buMhufweuDFvVlwLCMoSOMtU4O0dz381mpjwf4=;
        b=fVC1DIR94NNYU3OwicWAq7JuTqBx2Slfqvu6fwMkG8PwRgxv4CiPqxov0qZLZyKnmX
         hcLZvsOorqA6AjkylJR1YDQH9nkHh/b+7lLgqFbyIHQsWEEenZutANysa4UUZARWqsxk
         TnfNDs4KkPNuYEp3RBsAqfzldshqJ4dlVkZ8khly7oTQ7YjRHXmujA8IV7I1AK5jReq0
         gzaB6WeULr6x+cbi2ZKUgcSsL3QV1GRruU/ya+ZoUzrvTOVxc4UEs465WYUnsmcHi95V
         pWqq5bnTu0XakZD46LhCVUo8WScHBjUbCsTIaqRh+jDBnCE05Jth8S70ArFvHlHLjz02
         vmbg==
X-Forwarded-Encrypted: i=1; AJvYcCVGOGiU24XCawof6ZBCwgDO0Vixg/XrgM1HQoguOAZnK+mbu2T10DLf05qW/MWgGy2vEu2DSKiyoM0vC0aFz5Rr4SqnxrDv8DomDbk9k9H7P7WJi+oS3fJl9F8fvcVkmuMsVWinNM9AuquMOCFHbkw2/iuQG2YC+W6cQBlNlFH1u2V0NikEAp2aHJ46wnn/PVc9j4JOHtp6K7Q7HA1VsZvNGupo/8wQFLFZfn9K3T1/83IBsXUluqnu9BYuAD2G0bT4wa1s4kuxz98uzfKJi/TZ/YHXen+Knuf2jjPn9jVcnQ7fUT5DhzhuIPTYeatViFCZECfwvDFc6zthqQ==
X-Gm-Message-State: AOJu0Yxv3c+Y2kf+tnE1FMjI5e0we43oIRLvW5bv0K7Nhgs3BCc91Eqh
	z488b60G4LoXJzNSHl+tpB8+bxLSG4k1dKgNyIIwkdoM9BpksYpdWKmCaadQ
X-Google-Smtp-Source: AGHT+IEh5xEcJZskqc4PliKP+yyJGP+S6jENM5xVY36nf+NI5thZLVuR/7sYo+93sVyNAhnzwAgWVg==
X-Received: by 2002:a17:907:7e92:b0:a7a:929f:c0c2 with SMTP id a640c23a62f3a-a7dc509f3a9mr168123766b.51.1722575890007;
        Thu, 01 Aug 2024 22:18:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecb085sm52827166b.212.2024.08.01.22.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 22:18:09 -0700 (PDT)
Message-ID: <8d2e03ac-2a08-4a25-9929-dad375afb738@kernel.org>
Date: Fri, 2 Aug 2024 07:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] serial: rp2: Remove deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Boris Brezillon <bbrezillon@kernel.org>, Arnaud Ebalard <arno@natisbad.org>,
 Srujana Challa <schalla@marvell.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
 Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jie Wang <jie.wang@intel.com>, Adam Guerin <adam.guerin@intel.com>,
 Shashank Gupta <shashank.gupta@intel.com>,
 Damian Muszynski <damian.muszynski@intel.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
 Breno Leitao <leitao@debian.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
References: <20240801174608.50592-1-pstanner@redhat.com>
 <20240801174608.50592-9-pstanner@redhat.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240801174608.50592-9-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01. 08. 24, 19:46, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions()

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>   drivers/tty/serial/rp2.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

thanks,
-- 
js
suse labs


