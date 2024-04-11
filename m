Return-Path: <linux-pci+bounces-6111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9CB8A087F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 08:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A791F23557
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB613D880;
	Thu, 11 Apr 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fM+Ni03i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CD13C3F4
	for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817101; cv=none; b=Q8wDIDhoE2ovDV4/riE4rNtN/gzwb53wS+mMSqJqN0/FarzdYJMd0t72E9WoV8OQ+2tN7zG08AFrpbSpLP32UGQ5se7yBbBeOiZEet2BKl2wJ+M/BuIP8i/GbetKkSMN8k8IOnSKKSde6rQyuQFFB+NcKvhC6sOmPkVYC4kQMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817101; c=relaxed/simple;
	bh=NHx5XeHZAZ/9NbPe72pkNPdyNGbgu3+xBWUs35f7cDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIbZVIxpvUfo9yljxI0aRfRZMlex8Os63DoZOmLtIHIuXZx4TFqA5qlAxFtIFIUvsZBjbRgNZ2sVzx5C9LlaAVZZzRV9DnDXLeSY1bz0MOx7hjFbIiWRrbZQBbW0BtsJnp7A7xuHHMt78kNzY2GzhGY9WBaGSSP44B2DDb4JfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fM+Ni03i; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56fead80bacso164241a12.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712817098; x=1713421898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=316jZ3HKhdB/ZZPBrGBRDD5OyP3QLeoYzLEaFs5avdk=;
        b=fM+Ni03iyNlTve+oS5KxEXEYdTKWppqmPMZIXn6qliXI3a+ceezQp2KkVP4WlnUC5T
         SOm9HWY0QZu3aB0kEo+CPlqXhjehCMrHVIldXejhvkyrLVvKrfierHUecTC9vyI0b//A
         P9BrfylQHAtXVhZt39HgawigSAkXBLxclZXj87Y5sMNrzEAXdUW+AxaYxt5Pyp+v2f8Q
         2EPWx0RTHNGdTNEvh0V13OX8X3Gyqrg/HNW20Gph0APUC+1g7GVV6+F8/c0Q/poxxhxX
         YNiIfdg/euuwrlYvcrSe6EgKX1dVgR3VcmfiqOsrDoXVj3+Puc10qzkXmM3fyf+VzY//
         CuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712817098; x=1713421898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=316jZ3HKhdB/ZZPBrGBRDD5OyP3QLeoYzLEaFs5avdk=;
        b=rAb9tuwwwi2Tu6mgOoVYfqC8b0mBsXFCz8SQGobwp8XPOv2eH8TAd3BYlIT/Sz34Ze
         doGqHcha8kAUsYPVJ8Zg+//riCivReZMtLPK7pNT+PgOkqHkoY/GtSdr+N+C26W5tIkW
         CxMu6TVme2PNn/mKGG7EPZLKyfSyA4oGu4fMIIqoK3xy4frwK2G+iwRLPEAteX6m9ECD
         W3Z5AdCaTEOcppeFbOZ+KodIPqYNc3c0yMOHy8Vx/zmA7Pgjh4Bo5WtrA6ybJzWjOowX
         GsZzIje/RnDmKmZ4POp+O9y60jKtoXknjKPMVp+GG7x0PXbp5HGBioc2++/LoqDdZwc1
         2tpw==
X-Forwarded-Encrypted: i=1; AJvYcCXjJRyDrxUZpH02+w9eaeG5PH//vZRzmumXx571soWHolYh/0joIdwbkKAgd46wqvPxoZ9aUQafAeVRJDTiSlwa3OODlJvigPME
X-Gm-Message-State: AOJu0YwbY7OBEknBEOm52T2CkX0CZxu9DE4MuLpEV1Gf4KIzm5w9JcK1
	Nz0QsbRvvBSycyGWvm1b7NbaOYAepzRIRQ6wFiT/hmW7xWkt700RC3xAqgBQk+s=
X-Google-Smtp-Source: AGHT+IEo1+ZhW0NMdQx2Wuc+yTwbVQs7AB9yZ9+xqYZ4jpJ8BtrvbfKhIrQpT2FMjA8ZtMJSImDdxA==
X-Received: by 2002:a17:906:4a55:b0:a46:da28:992e with SMTP id a21-20020a1709064a5500b00a46da28992emr3025514ejv.71.1712817098089;
        Wed, 10 Apr 2024 23:31:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709060d5100b00a46da83f7fdsm435382ejh.145.2024.04.10.23.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:31:37 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:31:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, pabeni@redhat.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZheDyIRWPggbSB_r@nanopsycho>
References: <ZhZC1kKMCKRvgIhd@nanopsycho>
 <20240410064611.553c22e9@kernel.org>
 <ZhasUvIMdewdM3KI@nanopsycho>
 <20240410103531.46437def@kernel.org>
 <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
 <20240410105619.3c19d189@kernel.org>
 <CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>
 <21c3855b-69e7-44a2-9622-b35f218fecbf@gmail.com>
 <20240410125802.2a1a1aeb@kernel.org>
 <7dcdd0ba-e7f8-4aa8-a551-8c0ab4c51cd9@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dcdd0ba-e7f8-4aa8-a551-8c0ab4c51cd9@intel.com>

Thu, Apr 11, 2024 at 12:03:54AM CEST, jacob.e.keller@intel.com wrote:
>
>
>On 4/10/2024 12:58 PM, Jakub Kicinski wrote:
>> On Wed, 10 Apr 2024 11:29:57 -0700 Florian Fainelli wrote:
>>>> If we are going to be trying to come up with some special status maybe
>>>> it makes sense to have some status in the MAINTAINERS file that would
>>>> indicate that this driver is exclusive to some organization and not
>>>> publicly available so any maintenance would have to be proprietary.  
>>>
>>> I like that idea.
>> 
>> +1, also first idea that came to mind but I was too afraid 
>> of bike shedding to mention it :) Fingers crossed? :)
>> 
>
>+1, I think putting it in MAINTAINERS makes a lot of sense.

Well, how exactly you imagine to do this? I have no problem using
MAINTAINERS for this, I was thinking about that too, but I could not
figure out the way it would work. Having driver directory is much more
obvious, person cooking up a patch sees that immediatelly. Do you look
at MAINTAINTERS file when you do some driver API changing patch/ any
patch? I certainly don't (not counting get_maintainers sctipt).

