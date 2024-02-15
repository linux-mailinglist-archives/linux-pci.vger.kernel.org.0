Return-Path: <linux-pci+bounces-3481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935CB855E56
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 10:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D2C28125E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A2179B5;
	Thu, 15 Feb 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OIVuXf7L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320CC1798C
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989841; cv=none; b=dVe7chHB89U4xBpXmuIXgH167kQtcxUS9XN6OR705GKfPHpMio113Okzp+dUIyPoUYXUo0VOqpe9TBBqnPZrSkBuSgklxxay4KZWA31SROCshzEoTZkNKxfFWO1piio7cK87D6nie+l6C1xmYxkxU9LTkOi5dGs0Et7LUhqu8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989841; c=relaxed/simple;
	bh=Xvdta8H07qjeWe6JNeSDdGXR9ZFWRP14rZI9S+E8iUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LEe0qkWm1xyPA+RJY7FnGKpSs94ZKYDzmSkA11reMrL4q978xoKHihOvD7V3IrBl2hhxD8epokcdEfSlprLouSr50c+nsn9oEBqc2BwcLkyj/uCgeX7Ag6CdRGLSPSJE0UZ4olLfHAiQosQuxouzqisGrQpfOMjlRJWK/Equro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OIVuXf7L; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so8270801fa.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 01:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707989837; x=1708594637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G++Q//UTKWBjyGn3NpAbaYl4jCEX4Qya2uPC/VP/bV8=;
        b=OIVuXf7LmyhcaFqL73L3D0qiSvI1oiHil11WPvstGfbwN5Ckk8jQhhS6V1cy/5XXIt
         CtAePAg4AFWBlzlPQFISQn7c9BuXRRVaCu0/kjCM7m7Bg8J7n0CUtKp+ZLMOKctfluJ0
         G0BOSU1UKiVTRkDsUw/rBhvLTIYiiSlbOoAP8AxEp0hD7fGCSfE29L0RK8jDrPwn6V1a
         XeVN+SWlpD30y7Q8MBwsD6GZlyLTIZf/hJRwE7VdSxHMfVo324KRJasUgZCNhCoqskla
         CuR6zMcn92iSZrN3WsAxwrsll741PW/ewpmtNuh0s7WnMQtmuXN+F5gbx+HtwnjgWsB3
         PJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989837; x=1708594637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G++Q//UTKWBjyGn3NpAbaYl4jCEX4Qya2uPC/VP/bV8=;
        b=gz6X0a9/E4+5mJ2Ec3+62uC3OiAAyyV3olWA8enY65mP+vef7cRAX4zAA2x/0zM18f
         TELM5oWm/g2yyAxHI1RcgmiXbPszQN8ZbxtjNGYbXvW1irI0tUA+Wq0sG+PaCMIlLI1g
         kjGDXatU9vUpX4x30LFChAQjTd02nDFlCAEVmL2UV0+1OH9ikx5jKDjEF5yWBQssfWMS
         MoErLKZlVoNTpW9giiFyetD2pZEl47za4d5lJY4mktAqU1rwxeWOcSVUpKNkkZgbbTo4
         mNtJa49xds6ggMPPsJFaZvINxwYWwGMF5uuDXuoUzLm/SGU19BwvBtKQLSjlqw1eRpfg
         3J2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe7PG/WkF+zibm5i00fAHFJ2q06xif7tOnGClek/My4bT4mOmAvJ58SdyOGTbVEs2PDznVlQD9a0hJUQuIYZczZTL+5yTA7hGK
X-Gm-Message-State: AOJu0YyN/Bn+ADUKMLG9Esz7ncZ2EG91w0V1vpMyi7AywUyW8+FqZcdZ
	y8+v1gvUJVROgEEiKMcb6QnCdHKBFXWgjANrSBuUdbWMOilPc4D5nGKUYqnMR+59PS2ULitR9W5
	q
X-Google-Smtp-Source: AGHT+IH32l4NfBD+qboCs97erWXFSsqVtx/MGVcvJcLtl3DKbyT5liFC3zjMMfRlHX4MasSql3Uvdw==
X-Received: by 2002:a2e:86d1:0:b0:2d0:afc1:ffb2 with SMTP id n17-20020a2e86d1000000b002d0afc1ffb2mr893456ljj.21.1707989837217;
        Thu, 15 Feb 2024 01:37:17 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id w11-20020adfec4b000000b0033b7ce8b496sm1182058wrn.108.2024.02.15.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:37:17 -0800 (PST)
Message-ID: <d3d7b101-eb19-4169-94ce-25e6f969f035@suse.com>
Date: Thu, 15 Feb 2024 10:37:16 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug reporting on Raydium touchscreen
To: Vanja Pogacic <vanja@pogacic.net>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240215085953.Horde.oa0RoVvzrHmYsnVs_gHNkTT@cloud.pogacic.net>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240215085953.Horde.oa0RoVvzrHmYsnVs_gHNkTT@cloud.pogacic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 09:59, Vanja Pogacic wrote:
> Hello,
> I am trying to find the best way to submit a kernel bug for a raydium touchscreen driver (raydium_i2c_ts) which stops working after waking up from sleep.
> The hardware in question is a converted Chromebook (Acer Spin 512) with coreboot uefi bios.
> 
> You can find more details and logs about the issue here:
> bbs.archlinux.org/viewtopic.php
> 
> Since I observed the same behavior under Fedora, Ubuntu and Arch, I concluded it would be best to contact the upstream people :)
> 
> Any guidance will be highly appreciated.

Hi,

in your specific case I would suggest making a bug report on bugzilla.kernel.org
to collect your logs in one place. Then based on your logs, decide whether your issue is rather
input or power management and make a bug report to the appropriate list.

	HTH
		Oliver


