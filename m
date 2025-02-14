Return-Path: <linux-pci+bounces-21491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2761AA36472
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CCE1895B07
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2667268682;
	Fri, 14 Feb 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7QfDX8G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E742267F78
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553705; cv=none; b=WSAkEX1YLAa0aHJMi63Is8TVMvYsnf1/aJQ3oc0MEEUiqBfuEZfd4Rk/vXZqlqFdr0SvXVnWops2r9YASbOLW7SO3k6+2SRWkOGX3iJj2A+5xezP3Q7WRTFYDrW9A08jhk/WG3qBp00xpeTTw7WnB2iyQZF/pB7+bdgROwwEOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553705; c=relaxed/simple;
	bh=q7gQgr616uVOQTMZ77imFQirud5OxtnWyayh475uip0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pteqpK5unlzMdif23ykvTjEsvIJK8suiW7oJDhc2IHKpduRF7Oywiikc3D2Ru3KoUqlZazlt1QmIZ9w2Cq2Q5D7oILg2f9oXIoRbooi21F7ek3haMtrdBiPY96126ZpjgKXfQwDmC9btpKe1tTinDnCrZpjm+P9Nx9OyTu5Bu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I7QfDX8G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22101839807so8042315ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739553703; x=1740158503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/PVsVZnYuQ/wni7IvzfZedmUg/Flzek4tKSKCxL8mts=;
        b=I7QfDX8GYTv0bYvHmRotwx156koiyCrZsSmMz9c9f4HZITTuCZ5CYG4JfsM7i0ljBR
         qHelGRtKwnkAMgTq6NSwMkq+On67JleQo2V40YQkMe42mplnQxHdkMbIvUAiT+dzM2tJ
         kjN5P4wQbGEYffaogdMjAdpikWi2rowIFGIow4g3uXMaXINjv/5M6vYKLY6pOfGScOsG
         AlnRa/xeKdBD0Wpgo0PAVPhHWm1tDma7e79WiN/eZXq24Wc2DVRJel+dqbdh7c7W/qIb
         vKmc26gz60XyVX61c9rsH4znNMZe+Ft5wb2zFxdhdJqdrSppQoPZrWHMggZ3HkeXbaeU
         CxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553703; x=1740158503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PVsVZnYuQ/wni7IvzfZedmUg/Flzek4tKSKCxL8mts=;
        b=mG56nT9S0HOyWRZS7KIxpEjY5ebCTTmCDGQsbCgAsb4tN3srAVDMahqZwNVvusd3gX
         UucPl1kdDfls6gnfCB0s1S9YmMiONxdpWj2sGO4Dd5pdSy2b72x/78BM05dagzMw/rbh
         g75Hs2Za0Jv9zhmGmTR3hhSauqt0v67MxJBgVyfUel/KtUAOX9ddFg9Nu1zhxLOUdyF2
         QVJBtsVZ8/+lrY+Wtb7W5Vdt1hRBf+ukFHQ8x2cIA9FPL6SYktS47c5QUHmA+aQl/wSk
         5XG+Y1qea2dRU++do9XKjMGKQWXxQJk6wEQy3UA5OJM7nauVK/Jd35SloQ3Jvl86lQ+v
         NdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXu6tw+7bVHMWlJgSf99tYITVFZ2Dfi8QfKmzFlvSkzgEwUSxxANUTNt/HhjKOkAxf6Kh5kkUEE9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUh3L61HIwQWojqHutKu7gxlTX5CXEPPmuSFZYImo5vL9rbTvv
	PdupeMdaby7tibgDjswLX6C/naSSq1ZT1sLjgXpi8h7Z6XNUybA1bHX4FZDgrw==
X-Gm-Gg: ASbGncsFF9cdRQtYzh6lNpgfnptgaXwDJP6e+0nqfF0vDIsVoNXj9QPu/kJQeXFDuNy
	Fhgafy4dmoOEVdghqGgN4Ue9Nu/k/bPpScAJohS41q53jcPZJwUoblS5Ad7aU6OwEc7ABU0uGbv
	fnII8wTo4Qj6o2oEyt+6252ZxtwKl/EX/iLvAfsZux0MY/ci/mbocjMUqD1Y3nG4b7VyXxeYl4G
	JWuWrNGx7WngQTOGNvOpRtp+Zctbbwgy0+2/LT4iOLyVxbi7ysxmBWesFCjsf3EArxsrCJVDrET
	kJAyOyYzub1W95vhEl+55FN6tzk=
X-Google-Smtp-Source: AGHT+IGcRo+nLJC59NjoyRCElAIfb+jisUP5T3miAi6A+0NQw62kcP9lRVYfGrAftSB0L9zhfWHPdQ==
X-Received: by 2002:a05:6a00:2eaa:b0:732:5164:3bb with SMTP id d2e1a72fcca58-732617b7772mr183432b3a.9.1739553703494;
        Fri, 14 Feb 2025 09:21:43 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e4e2sm3375480b3a.116.2025.02.14.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:21:43 -0800 (PST)
Date: Fri, 14 Feb 2025 22:51:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] misc: pci_endpoint_test: Avoid issue of
 interrupts remaining after request_irq error
Message-ID: <20250214172138.setswcgqz3dbf65t@thinkpad>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-2-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210075812.3900646-2-hayashi.kunihiko@socionext.com>

On Mon, Feb 10, 2025 at 04:58:08PM +0900, Kunihiko Hayashi wrote:
> After devm_request_irq() fails with error in
> pci_endpoint_test_request_irq(), pci_endpoint_test_free_irq_vectors() is
> called assuming that all IRQs have been released.
> 
> However some requested IRQs remain unreleased, so there are still
> /proc/irq/* entries remaining and we encounters WARN() with the following

s/we encounters/this results in WARN()

> message:
> 
>     remove_proc_entry: removing non-empty directory 'irq/30', leaking at
>     least 'pci-endpoint-test.0'
>     WARNING: CPU: 0 PID: 202 at fs/proc/generic.c:719 remove_proc_entry
>     +0x190/0x19c
> 
> And show the call trace that led to this issue:

You can remove this backtrace.

> 
>     [   12.050005] Call trace:
>     [   12.051226]  remove_proc_entry+0x190/0x19c (P)
>     [   12.053448]  unregister_irq_proc+0xd0/0x104
>     [   12.055541]  free_desc+0x4c/0xd0
>     [   12.057155]  irq_free_descs+0x68/0x90
>     [   12.058984]  irq_domain_free_irqs+0x15c/0x1bc
>     [   12.061161]  msi_domain_free_locked.part.0+0x184/0x1d4
>     [   12.063728]  msi_domain_free_irqs_all_locked+0x64/0x8c
>     [   12.066296]  pci_msi_teardown_msi_irqs+0x48/0x54
>     [   12.068604]  pci_free_msi_irqs+0x18/0x38
>     [   12.070564]  pci_free_irq_vectors+0x64/0x8c
>     [   12.072654]  pci_endpoint_test_ioctl+0x870/0x1068
>     [   12.075006]  __arm64_sys_ioctl+0xb0/0xe8
>     [   12.076967]  invoke_syscall+0x48/0x110
>     [   12.078841]  el0_svc_common.constprop.0+0x40/0xe8
>     [   12.081192]  do_el0_svc+0x20/0x2c
>     [   12.082848]  el0_svc+0x30/0xd0
>     [   12.084376]  el0t_64_sync_handler+0x144/0x168
>     [   12.086553]  el0t_64_sync+0x198/0x19c
>     [   12.088383] ---[ end trace 0000000000000000 ]---
> 
> To solve this issue, set the number of remaining IRQs to test->num_irqs
> and release IRQs in advance by calling pci_endpoint_test_release_irq().
> 
> Cc: stable@vger.kernel.org
> Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..bbcccd425700 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -259,6 +259,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  		break;
>  	}
>  
> +	test->num_irqs = i;
> +	pci_endpoint_test_release_irq(test);
> +
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

