Return-Path: <linux-pci+bounces-39539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2FC152B8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F23C4E04F5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DB8338F5B;
	Tue, 28 Oct 2025 14:30:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20C339705
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661812; cv=none; b=WnXR0a7JFHGa/B0diHMQLCo8a5B7YSFks7SKdar/PwXhGKV7nYBinNoW8ENh2Aypt/xxjLgfG1dUDnsxXTijOpA0xnSJaf6mGg2jt3AZCJIliH4Jkf7iHPfEx+ThAnpAmrOu9dQWSyfukKGl51m/U9yS2/V1rQNhiKNN86cBSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661812; c=relaxed/simple;
	bh=qFZVzHoOay+Mo2Gdf50RAGT5PXBic9cGcqZoKVnp0C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QboXVN+19EMxgfTWk3sS/6QJbt1N/xoh+buDzfKPMgZMPa5qV13f8BTH7PJf42AO4ocUpDVZM3J8fROiVZqRIjXzdqFgaWltwpnW7rzSnayVJ2YIltr5qbtshVCCnO31Kda+ebOHGG/8m961thsd3OE/3nfImq0H1aLpzgGROv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471d83da4d1so3255255e9.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 07:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661808; x=1762266608;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFZVzHoOay+Mo2Gdf50RAGT5PXBic9cGcqZoKVnp0C8=;
        b=FfTH1jHu1FbbPuHMJShvb36YR7RiJhetb5lna5wy8MSbcFusV0MvJGhxmBA6eUfkiA
         UX9WWFJAo89F/zX6+YiJywsUgViBJL2nGOpS+/vGebMbL0AXDootdqY9GWiecAR9OwIv
         PZaRhX6EvnqhwfzQIYSXPC5Qm6wByrz9+omxuFUS2fRlDoamIRnLrVdIcN79AMzmX+s0
         z+FKjjAzhO5+0TJlJ5k1tdr/2U5lVHt2agv+bOuFcxbiJ/MxAtJexW1/AMGMzI/RyPIS
         nIm7W2dRbdWqR/SUmshVVZZgphzrOWbNiVCqDIntfJQ0pa5RdzYRyghnsh59OBuBTMCH
         vV9w==
X-Forwarded-Encrypted: i=1; AJvYcCXv5lHAOgiaULedVKIE8NVfp3oaE4lR1RMnCsLvhYay7I1qj/NltqQhItqGSxBX8HbAzKqhxJjLoXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6N5JeyoOFrX6W0dAI+Qfv+sncIZjQ3NSy1VQdLPVKiOq6ZSb
	mAyJYQGyx2FOQF1bKGoCl403RatXg5Z1CwqbsW9aIw/LW2CKITd/75oZ
X-Gm-Gg: ASbGnct0ENjoNiDcf2lSo8JqFe+QrLSgeBhVXYs7yWCnaTQQ/Ygc8l/23Hf98f/Cvr9
	ri3P/p+Y5/sOhQPts9d0HQxr8i93PeWtv7TnqMOfCyQj305fG5PvCA6s3U1cwR3t7HcT6CTTWEF
	sGV53aBq4fv+uDVv2colJwq/J7oVeAs/ODTXfzs4/FAe4v3qW39L5W2Es5U/dk26TpO3mouCS5L
	L4+Lasn7u/PUn1k/imxv5+/aAU6JhQkbeEyf5Qjv6HYmzHMh4x522OYPD7tVFVn0ROUczY6xQ5h
	SHk8YTFKScQZpgtFr9UHz42Ks0hb0vfNJh4XfKoMExlyOvz5fh2LCtBvikD0regkfA1eC0+hvbL
	6zsQD1pManSfPhwZ/1eJ1ogxEnsHrRODKElVfSP9fm9d9HaENosENhfNnoHIg1r2kcQfUxD09Ir
	q1yXHL1zuDrqFVNV0k4VnC9hEhs1ubowZ3Vg==
X-Google-Smtp-Source: AGHT+IEZ0uB45+BlWnU5Fw2yyD+WHZbQGeAd+aFypPjK3ZMmzMMygBuPZqEaL4Uhwd7jmikatF9Agw==
X-Received: by 2002:a05:600c:45c5:b0:46e:5cb5:8ca2 with SMTP id 5b1f17b1804b1-47717df54eemr18317145e9.2.1761661808264;
        Tue, 28 Oct 2025 07:30:08 -0700 (PDT)
Received: from pixelbook (181.red-83-42-91.dynamicip.rima-tde.net. [83.42.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca979sm21236630f8f.14.2025.10.28.07.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:30:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:30:05 +0100
From: =?utf-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <6qhbpyvzks5wvibjydjhqexh6ml6pmljkq4pbicfqt7l6vnmxw@4rvrunm34ylj>
References: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <20251020232510.GA1167305@bhelgaas>
 <aPc4JpVyhCY1Oqd-@wunner.de>
 <zmkurgnjb4zw7zcg6uucbtvuratxlaau5lvhkgknidpjz7vnb7@dnsyjbrqtvqw>
 <aPj4kUglHgBm4uAt@wunner.de>
 <aPkD-cECjlXx3kJP@wunner.de>
 <fez2defptc57azalrjf5urjwvihnfsn6imxmkflm7evq4wye5l@6p5pqp4ofgyl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fez2defptc57azalrjf5urjwvihnfsn6imxmkflm7evq4wye5l@6p5pqp4ofgyl>
User-Agent: NeoMutt/20250905-dirty

On Mon, Oct 27, 2025 at 05:36:02PM +0100, Adrià Vilanova Martínez wrote:
> I haven't had time to test the variant of the patch you shared here:
> https://github.com/MrChromebox/firmware/issues/786#issuecomment-3446469391.
> But I will do it later today (Europe/Madrid time).

I've left the results at
https://bugzilla.kernel.org/show_bug.cgi?id=220705#c6. Unfortunately I
got the same behavior :(

