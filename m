Return-Path: <linux-pci+bounces-39451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789CC0F620
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95BC1898BF3
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B82D3733;
	Mon, 27 Oct 2025 16:36:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E930AAC8
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582969; cv=none; b=nO358XfewGOwEv9mAXKEmFueE4o29izEd6xDAUNrfo0arbfGEsmzk9EcQccxJOtQxuF8aOIF+7B1qZCQiK2A5tbA4OSDSogrhzKawn/naZ846G4pIgB2/OzAQBQpj0HsjnGJIrxlSOSK7Xk6YGicW1Kw7PQDvtq/OtbVWbmcGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582969; c=relaxed/simple;
	bh=SQivHcMNzHK9+oAN6EscabpUgy4g0lSxLUmswuuPmJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg1HytCR30YjdqyxBSKu5I7xo7brIpT7IktG+itmhucKpYklguk3ZIjes2RzyvRLFKRV9rqjFkxH/3ULEXE7DZjPsQXxwRU7zXOE3iPGisMIbF3230MJUwS2gguQ0u3Cu3avwXMKP4SwgjUrzpmRQXSzqNCteeTmbFx3YAIMIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4770e0b0b7dso890295e9.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 09:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582965; x=1762187765;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k32sxT1kGp4e54c/OGW8PVJk5ZqsIMXt+4kbl+LaSy8=;
        b=bgrL4e3TEJOBIwznsWAhzJQ6hKf55ZEf+pqledXGTiRVmdQc2JJZ7Tx+CA6w36F2NF
         abIZD5mYb7XJFqulWs+xi30mhfbsboBv+a9ZZp/oJyvxvcCuxLyQ7Kc3OR8kbZgoJN8A
         dLVa1Oe70X4oPf0L8+yCKjyVRJeKAgSZMlMFJScIPQguTA+Jwoxqq4Jz2BhFZ8aPgkKa
         5cnGAmcdxm0yL2jcjRgoxm1kTjJUV6CrXa7vNqfIvnJyI96NfXGY5O8RJ1qhXGu9wzd9
         iycL0Ix4MdrHR0fFhBgDvIuMFFsOPofWR08HTSkElfunAYHGV1Lz1m7um9EfDNNfY/vt
         HRCg==
X-Forwarded-Encrypted: i=1; AJvYcCWbWC0J0R2uSgXsmn+0UG7p5gBt5mYzYR3SulHSh/RNiqvm0TZjW5T2o4MEtRU9wFj4W+Mf/sodA2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeo4Bf/gfSzZ79qpb1QKLd8a9zqTOxhJa+Aj9bUXAV9zLx3nh
	EqMS84Iy51zWCjwMAItYQwKjd4OO16UnfvjgC7DevtSPl5pM9oM2sQlf
X-Gm-Gg: ASbGncvf8ehzj8BBXiVgHCZIm9Vzy3IszVKkOnugwvVXuOrRcdCG3rxylYYuQxM65yZ
	tj++kvJaKCWM9e3uVZAveGMfKdwRHP0GLybXoIWwlgyjyGtWULIztgYFPDsMkIG8plLCSoPvtdb
	bagu9jV5qPs2FQjbsYE4THSw3BVtApn4/z8TO0MM9AhDmNncvNpliyPmF0n7i/eSWHWUAK+XkCs
	6piK8H3nf92qnIWmIXRIuqCbuoOyaziDRSAj3U5Fz7sRUGH56B1zs5Mixrc1+GdIZbV6V4NraNr
	pfMmIc9IEhBRt2KUcXqq7MgKuzCFURn/MPwER4gZcMciNUBGPyOXftdVc3vP6AnFQIIxSmTF2pH
	ylHi0lxEsUEXaPmsdUasqW0ETFgJbMTLLbJIRLs655i7zrxAGNsnrb8IuwnFcfw2DpDPjCe4/9K
	LsRzKsqienr8/kcjvcLMVq4EMFt1KXzhpitw==
X-Google-Smtp-Source: AGHT+IERea5ccVK/c9QtDIaqZ84IicwNUcsWHZZ5WAz7ft1R6EzSMQqv7ngKFW/AyLzb21fQJ2137g==
X-Received: by 2002:a05:6000:2382:b0:425:86cf:43bb with SMTP id ffacd0b85a97d-429a7e7212fmr175929f8f.5.1761582965256;
        Mon, 27 Oct 2025 09:36:05 -0700 (PDT)
Received: from pixelbook (181.red-83-42-91.dynamicip.rima-tde.net. [83.42.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm15211419f8f.38.2025.10.27.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:36:04 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:36:02 +0100
From: =?utf-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <fez2defptc57azalrjf5urjwvihnfsn6imxmkflm7evq4wye5l@6p5pqp4ofgyl>
References: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <20251020232510.GA1167305@bhelgaas>
 <aPc4JpVyhCY1Oqd-@wunner.de>
 <zmkurgnjb4zw7zcg6uucbtvuratxlaau5lvhkgknidpjz7vnb7@dnsyjbrqtvqw>
 <aPj4kUglHgBm4uAt@wunner.de>
 <aPkD-cECjlXx3kJP@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkD-cECjlXx3kJP@wunner.de>
User-Agent: NeoMutt/20250905-dirty

> Below is a completely untested patch to force ASPM to the
> intersection of the two link partners, thus fixing incongruent
> BIOS settings.  Does it help on a kernel with 4d4c10f763d7?

Unfortunately it doesn't help--the WiFi controller is still not detected
at bootup and S3-suspending fixes this. I've attached the output of
dmesg with a compilation that includes the patch you emailed us here in
Bugzilla:
https://bugzilla.kernel.org/attachment.cgi?id=308849&action=edit.

I haven't had time to test the variant of the patch you shared here:
https://github.com/MrChromebox/firmware/issues/786#issuecomment-3446469391.
But I will do it later today (Europe/Madrid time).

