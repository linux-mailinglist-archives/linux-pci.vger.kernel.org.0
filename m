Return-Path: <linux-pci+bounces-25122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E360A788EF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67C216C026
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB02233707;
	Wed,  2 Apr 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFP8xE5s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D102232369;
	Wed,  2 Apr 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579635; cv=none; b=S02iYUAbBebMZXIJOA+6JPldySE0ID+fdec5/EJKErDodTzIgmXDWgJW6VhwJoELwCK3/nTPLB2IYugG7GTW+TN0KDqHHi0HwupSjWh058Qh23GjImhv5elnNI0jX2Hbz0QpextAkF6pqYBgKtOp9YrR71FHjhOTR1OACRvkbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579635; c=relaxed/simple;
	bh=J+RvU3wX0VFdI/UQd4qZoKaSThykHQ0KDt8WJTfTLeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=J+NAxPhf4R6cWp3Pj5oAMeilvRt8GsYk9IIaBEAIWoZtH53f+/gvoMDVRIo1gg3qm5EDWqKYE3WR5A6QBiNwwmJEFn4h8TX6RZ03MXArNWKPqOFJNcMIC7DgO7bIcPyHukdeJod1fxWz8mJxU9M//51H2mLyRNpsFWHl7NApT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFP8xE5s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac339f53df9so1119880966b.1;
        Wed, 02 Apr 2025 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743579632; x=1744184432; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Nx9Z4HEjoLpFGUkIChiVxJxCCULCiEbsXTWfBGStzA=;
        b=iFP8xE5siwmUF7FDIvbCl+RrguLydwxROfCHLHIbDsjWC0iDyjVa8DnPMlww1/ASNz
         WRb6W11tAvAQdkQ5BhFwA7FUuR8c9UecTVI0JTxEZzYS/YPe2j0+RksNN7JG12ZKsfkV
         En7TA5NOL1+tWi528tZtsns2/nVQylhWFXsO1pqnkGLKvDe6615yW+ji0WpeSjnHHYUH
         RtoeBAkgWXt0ZTduidmcVQD07WDo3dZH1Gygqq2K83Jo3siyKaZQjiUcgRN76VHSKpiv
         12slAybSGZrWtsbQjAahClW1/J9VN4lKqs3xhjYBHhaOTzDlv838fHKdp9Eq8ItA8/RA
         1YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743579632; x=1744184432;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nx9Z4HEjoLpFGUkIChiVxJxCCULCiEbsXTWfBGStzA=;
        b=CK+Mg67xYgDCCHeiGjdTXeIF4ZYfEX20uEUaAWPEncyoBmYoIl3dXSvJcnWHhjBCwO
         20jmdb6Ym4rOg301oZbJYw5p4w97mf+zAdUYbC6T76dW4vnfTZ/iwKV/a0WKbR8ngZ6v
         pgy6aGXZDiqMVofIX7eSC8j+fcTYL4Kv/N+Gxq3CigDhU8g0y2qpW9X+wVtvi3COBUbd
         FhvpnX7bGNT6X3QkKw9+qwcOz1tlPYq9MbqM2OhWE09KubLyVagVo7efZ1V7nccoFufm
         AyCvixMN/ScHsWZ69C65xcRUv67sdlvsqRoA89NKcs7hWD8wDoWxmhBj241AQTHAfWc2
         EZBw==
X-Forwarded-Encrypted: i=1; AJvYcCV54PWZ8RE1ZyrWDAzTMfOFwc3vwE5z377/bP1QxiTQ11GEeeQ0m1woaLx5HP36xmBOIP8NAB7jFtcW@vger.kernel.org, AJvYcCWC5NQI1gGezt16tqWpUTpcDbr66mz4Bf6YC9ViM5S3cAuWd1s8sc2J8D58NpRbF7dAey1LbHh3bzBsWRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnXehzVrBneMFwxrkappb8F08/lAGBYboDm9Icw0Qc3T94748
	TEW8/3KXfrouS1LdRIBHWjkLEygZSPW+ZUZKWd5QhjFZwy2sRCeZISwsCYBfYz60w98OZs8iYnO
	NLhX+ZwUSCWH1KwCt3vggTjLZhPw=
X-Gm-Gg: ASbGncs+KshPFU9hnE6xphAm82c7tkacALOhdaZMP01KK1FcEFBHdyycoEguKFbokRL
	U62t2jrCipTnontsTAFM5ol1KICMe96OKx8xY7tg5zvcDGLziAcwnNSQWtAQbsejnA93QkGpwrd
	HickTOCzNNj8QRoRn6zlVUZAWftA==
X-Google-Smtp-Source: AGHT+IGeIzl68D0VR6YeqUcZhecR7N7D5/2qlA3+yEn0RqlVnTvFseLLc9TKhTUHwWOp3m4xNVMC0zD5ui5yTOC6THQ=
X-Received: by 2002:a17:907:7b87:b0:ac7:9712:d11a with SMTP id
 a640c23a62f3a-ac79712e145mr273062866b.32.1743579631286; Wed, 02 Apr 2025
 00:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316171250.5901-1-linux.amoon@gmail.com>
In-Reply-To: <20250316171250.5901-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 2 Apr 2025 13:10:15 +0530
X-Gm-Features: AQ5f1Jqoxz1w3qlI-ig6R4W59esPeDdLzQJUjHjpV6-E9MuzfFZzueNEcxXET9U
Message-ID: <CANAwSgQ_db2yV6UxZ2vaQVe=zxZCOyas+SQ_dhQs_0zXT=jsrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: plda: Remove unused IRQ handler and simplify
 IRQ request logic
To: Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Minda Chen <minda.chen@starfivetech.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Mason Huo <mason.huo@starfivetech.com>, 
	"open list:PCI DRIVER FOR PLDA PCIE IP" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Sun, 16 Mar 2025 at 22:43, Anand Moon <linux.amoon@gmail.com> wrote:
>
> The plda_event_handler() function has been removed since it only returned
> IRQ_HANDLED without performing any processing. Additionally, the IRQ
> request logic in plda_init_interrupts() has been streamlined by removing
> the redundant devm_request_irq() call when the request_event_irq()
> callback is not defined.
>
> Change ensures that interrupts are requested exclusively through the
> request_event_irq() callback when available, enhancing code clarity
> and maintainability.
>
> Changes help fix kmemleak reported following debug log.
>
> $ sudo cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffffffd6c47c2600 (size 128):
>   comm "kworker/u16:2", pid 38, jiffies 4294942263
>   hex dump (first 32 bytes):
>     cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 4f07ff07):
>     __create_object+0x2a/0xfc
>     kmemleak_alloc+0x38/0x98
>     __kmalloc_cache_noprof+0x296/0x444
>     request_threaded_irq+0x168/0x284
>     devm_request_threaded_irq+0xa8/0x13c
>     plda_init_interrupts+0x46e/0x858
>     plda_pcie_host_init+0x356/0x468
>     starfive_pcie_probe+0x2f6/0x398
>     platform_probe+0x106/0x150
>     really_probe+0x30e/0x746
>     __driver_probe_device+0x11c/0x2c2
>     driver_probe_device+0x5e/0x316
>     __device_attach_driver+0x296/0x3a4
>     bus_for_each_drv+0x1d0/0x260
>     __device_attach+0x1fa/0x2d6
>     device_initial_probe+0x14/0x28
> unreferenced object 0xffffffd6c47c2900 (size 128):
>   comm "kworker/u16:2", pid 38, jiffies 4294942281
>
> Fixes: 4602c370bdf6 ("PCI: microchip: Move IRQ functions to pcie-plda-host.c")
> Cc: Minda Chen <minda.chen@starfivetech.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: drop the dummy IRQ handler used in previous version
>    [0] https://lore.kernel.org/linux-pci/20250224144155.omzrmls7hpjqw6yl@thinkpad/T/
> ---
Gentle ping?

Thanks
-Anand

