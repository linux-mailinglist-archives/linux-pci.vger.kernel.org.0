Return-Path: <linux-pci+bounces-4699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10C1877269
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 18:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F217E1C210E1
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129E922F13;
	Sat,  9 Mar 2024 17:13:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E220B12
	for <linux-pci@vger.kernel.org>; Sat,  9 Mar 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710004410; cv=none; b=X0do9rnXm6VgxedcMBvcHrF2ZfAJU7SMnrTy86VXmRtNcL1WKum5H3KZBYI0HAIV/XFv1yKqIvf7Y4Cs0Ah9JoJrRPYeyI8lxrIrQXBTEE/wLV11GpPDLXfG/Yw92eBJjL/K+HiwCuJY9e33Q8dgcY6AJcOkYNpt4lJY+wZOKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710004410; c=relaxed/simple;
	bh=RVuCbAKHabyWvwutgdn4/n0lo9LuRE+A8/HjYvzyUto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiodWafI/kpAeFbWrBZVaj8L+D+K4LgXGlGnJAZjVwPEBJp0jzAQDtvTjKW5YpIdinnWhcPUsMjFXWosN4tEyqLjyjcU7V04uLbchowUu6GWcExOJSuoQEerLoy0AC4gKpS9Ps8CL1KlQFhKNP5Z3fj1sKEBsYol6pMTezVoNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-413175397f0so12280415e9.1
        for <linux-pci@vger.kernel.org>; Sat, 09 Mar 2024 09:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710004408; x=1710609208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgjMK6Cy7XhY+WI61jeztpBIXWtY7auWS7GBD0jkGcc=;
        b=mHtO3iz3AcE7eklKmk/2PNBfRV/gvxPaKjRmsXkLNgAIsQuKGI+tO21pvmtIdxjFkg
         0rp+R1IMYBRwSiX15ocdwFsZve6NqOdKRtrXiQka+W0EpQ0AUPCGOUwT7EjPjooYXtr9
         W3cnHRlwvNgQX12L75L7Ep/1pGGYQzk7IpIE9xoIXeHUuu+46ii1/2imnm4l/U0qbnFe
         8sVY0guOyejaIfSfiVf7i+jNLc2Gl1mgKW+yGfEhKV6NKN0MxmbixE7A+jdzijPeLc9x
         eK0trWmDKSBT4RG7Q7CZVbwoPzcAuVtElVXQTyIOp92gQhTdjbCw5e7lJUlldV7WP26B
         ruxw==
X-Forwarded-Encrypted: i=1; AJvYcCXuRTAsAFsv1cCPQQzkZkEve+5RVWQudzNN/jyLdYpzEQLgBPyA+mrjJUhHb2tqon59nk/Ai96CFsel2vX//OyNFViK59K5M6bv
X-Gm-Message-State: AOJu0YzK6GyyJPkKMb/TWUPlD7Pqh600U5+lGGNHdM+DEmBYAYW3+HWi
	aEi4Bw3hsuxvt8b012hk+ZHadySOX7GJisJ2WCwY5QwQY2uIxepf
X-Google-Smtp-Source: AGHT+IGC5zG8Q3srbgVReytaO4n0JYjXCBwYa/egL4HTe1XETzuoDswce+Vygc+KnZFby1SbAxhXNQ==
X-Received: by 2002:a05:600c:4e45:b0:413:1921:8698 with SMTP id e5-20020a05600c4e4500b0041319218698mr2197766wmq.41.1710004407704;
        Sat, 09 Mar 2024 09:13:27 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c450a00b004131388d948sm7490672wmo.0.2024.03.09.09.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 09:13:27 -0800 (PST)
Date: Sun, 10 Mar 2024 02:13:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] PCI: brcmstb: fix broken brcm_pcie_mdio_write() polling
Message-ID: <20240309171324.GE229940@rocinante>
References: <20240217133722.14391-1-wahrenst@gmx.net>
 <ba9fa05c-0a3d-4d68-bdb1-d9e6e2c59c78@broadcom.com>
 <0553c39b-4f64-4761-9e56-a991333f7fb3@gmx.net>
 <e9991fc7-4626-4797-9694-12d45ef1c2b3@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9991fc7-4626-4797-9694-12d45ef1c2b3@gmx.net>

Hello,

[...]
> > is there anything what prevents this patch from being applied?
> ping

Everything looks good!  Apologies for the delay.

	Krzysztof

