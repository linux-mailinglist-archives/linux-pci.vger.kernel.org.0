Return-Path: <linux-pci+bounces-44487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF4D11C05
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 11:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB2A301A71B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676228DB76;
	Mon, 12 Jan 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRanc8tu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVO+Uwz3"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0C28CF77
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212608; cv=none; b=YsY1AHs2j12enDjQNkHRpNtG0VXZO/z/Hv48A6jqxPVn1BdWTrTrh+4/BKgCoSzeuuEiFbh6Bybqely77YIlOG0cSC5DuamnWPnyaglFLMmgTZ83xX108yjgs3ysr6EtqcplRI0DRoLW5nlcr1PUIbUuvtQ+dNOprAiy7sMDR5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212608; c=relaxed/simple;
	bh=iDFXfwWSoRhROG/Vq0Ji69eB6IojPN4EMOINzPWp4nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzYe6aMa6orQoZ6TNLpQmHG9Zoaf1u+A4wp7X2BLhbygUm/UjUgEV+S1gqm8AiqvOqO7uQwOHCuSldgQS5z8YjIRH93Cb5odvaYHvmwwLvQcp7l03utLQ2eB5yTAVVbxQ73vNCOO8I3ijGcXXzi8kZesMgVYk6nfcFXQj8fWbcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRanc8tu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVO+Uwz3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768212606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
	b=ZRanc8tuDBUSAZkvZjkf8D9ZvqxL3jJLQhtfzULfDVhn7GUUR4Lo2VdVWK+aYD59Lg+aMb
	arsphN80FsJldLDsZ6WpStUfPh9pumxZfGkW/7R83riVAU2vGz7OSYN9SXNBWIsSeA5DqE
	jU8tP/QyWguos9dm+vQ2KycCbUTgcH4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-rawJ2G16PGyNRdLGGIh99g-1; Mon, 12 Jan 2026 05:10:04 -0500
X-MC-Unique: rawJ2G16PGyNRdLGGIh99g-1
X-Mimecast-MFC-AGG-ID: rawJ2G16PGyNRdLGGIh99g_1768212603
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so58314525e9.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768212603; x=1768817403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
        b=DVO+Uwz3KQoGJMRrvhMReupkOeciWpQhBLtfQSbbK7anl1+oZMq2g7J6emo/51H1X9
         9DeI9eNjGYUC/3GpIPup7MKzKwq1mgmKkBmgfEdyG0ei2f2ZtQXq+oOfxQtN70Eu4NQv
         MCkwBTe4iPWV/BMt7yguYZU7oAuxYCy0seQ6oQwqMG/80vhqtmIuch/xpDPDKRmbWYzr
         CEQgk3pEh+6fNAfMutG5EOQm3UUvNk4W1DGlr7Tgy1eRvUcjMqwU/W6Vo3CMjRcY8A3I
         8bptRGqubjZQFN+uDFnRPaa0tMyQJ2D6rAaZqZLM0J2CdUJqbVQrVKvKmeUdLxYNw+N6
         I5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212603; x=1768817403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
        b=YK9dtiuLMzgyt3A2BohKcYYcA+UmVyuIBkJ0yPr/ih0H83QItflGJo1N8Smeg78BDz
         uTkbinZX24TfpoQ6R0MncECm1BaLm2j/Ur1mDIn2r2DC8ZYx27R0Wng43qJkROEIalMk
         prev9sMpfY879u8aLGosjf/GZ6OrPC8UCTtC3SOO2ZEZ2NnfHvn56Z72nE5O6vTSmfQW
         XFNNm9Ch1UyZhvo8W66oA9/qqBGY+DtvW/zWVn9yj7fsJa6QyFgGlX9Mnm36WW9ekelq
         Rruhx7Thk0U0b1+S7b3SClQilj1Av6BWU27qWh+fdBg9q2l4o2WYREG4h6hEhBGs32ZR
         A0AA==
X-Forwarded-Encrypted: i=1; AJvYcCVS4BtWvzy1aIDeKn3btCkUGTBArcPO7dAPmA2B+6/DxidfoH1cIcTnnNzm3oHFIAyJVVrc9JeSnzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOiFMbZ/pfCzzhaKhO9HDghvB+Xi62H7tQgHD3HIUmzgTVgwBH
	AkHC7AgpO9vecLi/NhZIR6PB4pz78kIMUKjLLzHLsC6HLu2gmDsYvH6b+IKmOc8aKXnGO4rNemk
	zx8wgSU+VqoMOqvbHvBHRnrC47XptE+Kdhtv+JzDDY+1ftIt34W1L088Et6rGVQ==
X-Gm-Gg: AY/fxX6JU8pVePgDjESW+7q+718alcx5fALYui8edJWncnO9kCeBxKZAD/nP7YtITff
	QWD6i8xpNWb64STYDnVlX1UuuF3foJnWWq57UDlj7FmCKmBR6JSPmTalWkR5YD350AgTJDAcDso
	jqtHm8l7n2pL4gLpJH2tG8KsbxCsWRwOAUV9VFF4m06NAd/9X0Wm0JwIDzj2wfmDzKvDlMJX6x9
	5TG6qGUm0YAGA3TKEITtug+YYt7WsG7vyuNQFarvJGcCZ3zngBfl9dbkxjYM6xXhL+K5Fu/YFh0
	Op5/Zimys5vUmQLjZ1kWF3qMmu3eq0fP4g5vDNNW4+EstnPAuprP9L/5fuh0AMaw22mbk6IW3n5
	dP4dqtewRQzKZmWYc+JVYN6G5KYSyUXpcRUCeBP01
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr193390585e9.21.1768212603459;
        Mon, 12 Jan 2026 02:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHxXn/UA4trykZ5T+SQc9F6yA7v1dNyRS4eMXq4oY/fXdGhX4AlgW2jGMNsGOSw5qPOxfWew==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr193390185e9.21.1768212603022;
        Mon, 12 Jan 2026 02:10:03 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm17906870f8f.27.2026.01.12.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:10:02 -0800 (PST)
Date: Mon, 12 Jan 2026 11:10:00 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VIII edition (OSPM-summit 2026)
Message-ID: <aWTIeLbQXalZtOGc@jlelli-thinkpadt14gen4.remote.csb>
References: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>

Hi All!

Happy new year. :-)

On 17/12/25 15:52, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII
> edition
> 
> April 14-16, 2026 - Arm, Cambridge (UK)
> 
> .:: FOCUS
> 
> The VIII edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. The summit will be held at Arm in
> Cambridge (UK) on April 14-16, 2026.
> 
> We welcome anybody interested in having discussions on the broad scope
> of scheduler techniques for reducing energy consumption while meeting
> performance and latency requirements, real-time systems, real-time and
> non-real-time scheduling, tooling, debugging and tracing.
> 

...

> Presentations (50 min) can cover recently developed technologies,
> ongoing work and new ideas. Please understand that this workshop is not
> intended for presenting sales and marketing pitches.
> 
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation use the form available at
> https://forms.gle/dR5FuzQRFNXZEQBb8.
> 
> Or, if you prefer, simply reply (only to me, please :) to this email
> specifying:
> 
> - name/surname
> - affiliation
> - short bio
> - email address
> - title
> - abstract
> 
> The deadline for submitting topics/presentations is January 30, 2026.
> Notifications for accepted topics/presentations will be sent out
> February 6, 2026.

Quick reminder that the deadline for submitting topics is approaching!

Also, I'd like to mention that the proper event website address is

https://retis.santannapisa.it/ospm-summit/

Don't hesitate to reach out if you need any help.

Best,
Juri


