Return-Path: <linux-pci+bounces-14813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEAC9A28FF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924E61C21C29
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5C1DF277;
	Thu, 17 Oct 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1zzQMbz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF31DEFDA;
	Thu, 17 Oct 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182890; cv=none; b=UVrIS2Cfu9ys64n7e9Anj2xkAD70T5yrEgMyZ9tLlo0SHblsZIWo/QZASUwRZiT0uK/ggN9R/N0vrJX1N5hGevfG4fInvlsgHUj3r5JNS1IRIBNTo4JbZH1TDqzec0fdxacOf0cyxC0Ft7lyBRA6kmOz8i8GdMiTvjbvLzmBYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182890; c=relaxed/simple;
	bh=AVebd7qah8QoBqQQs2NW2//l+cRwyNlFUWnp8SiLRb4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8Fb6Wrs1pp9vie021iDBt7PUesB6cIBZL0YqEDoZvAHvXQqlkAsYFH1OxqLyoGe33fiGLr0AqYQig24kvoxL7ZhlbMOGu5ekYc3sg4KPXvAiCpe1XiyPcyoAQM6gZkDFvjKJzT7g1nA40z2FKbAIY4XDVrrF7oySNCMU4roHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1zzQMbz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c714cd9c8so12448525ad.0;
        Thu, 17 Oct 2024 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729182885; x=1729787685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7azZRjBjM0rYf8Dvd4mI5u+wLb53xlXGjBTm5rdH+Tk=;
        b=Y1zzQMbzXHgRQF8KT7vi+/44VX3eH5OPlKxzqDCBpjiZo7UAB5dlwb8DC7CRhGA9Aw
         d0HlJE/KhJ7DjFwvIw+eT84RpbUussLFfqfSq81i5hHUyhNF7FolYLt+Xq+iOoTapnqq
         uN0mhWBNdMRt8WFhvx1C6aTFEnU3/gjUrC1OzaYlZ9Jr7j/Pnbz2IHhipt0ew9qiTmi2
         Z4SCceD5Oh0fHBocBXB1Ompq1qt7A6dCEh1Y2hrezUqh/ktfUZ6lrIYokz+Fjod3ZwYy
         IiLGH/MpeLF98rr/e30//Hvd0iAVH7pPENIUfNkZKGmqzbmAO9oWLHjo70kXwRqXQL9Q
         0IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182885; x=1729787685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7azZRjBjM0rYf8Dvd4mI5u+wLb53xlXGjBTm5rdH+Tk=;
        b=CzgfHkTJvPqvaM8e4ONxr60MYoV+ZStleahFeTvFTnLj2lJMhj8vmSwBdkKNqI2h1v
         s+cMpB3jhuVPBOipeIpwuAEKydTNIIY5eHOKcbHxSDZKJYDlTwY1+MnCmwOnvR6RNBvF
         bO4iCe2UJ0lpca/6QC0rInZd1VCM246gi6JpetKROWnlmhRUC64D76JLLyrC9H1tUrnE
         zZ5O5YWyFH/Lq5AqvvBzyMGY2QGUt4bcMunKlXuFL9HceM4MrfTPQ09ftDghLMiL0EnJ
         W6GwqBL1+1KYcKPGYueXH5kOBvV+RuN9GP8RKSmrD9UXmoteKCBkYahoDARpqPuTOlDK
         QIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/xnkaxsG4xwBkBvTbqjbNGpvNIe0FN1kz8kVUiXVmzIGY99JYYNhLDuT2LNzcO7kYtG4UfCKsx1If5kE@vger.kernel.org, AJvYcCWn5IPis2/qkpP+CFmmi1KwTjEiaQ0B8Y6uiwAoitda0i3jQ6/rBg8GFaqaGfPqwPbLgrhkW7j1YtjR@vger.kernel.org, AJvYcCXFFv7lsOIdjfAviVegrNHfTS3K/oaEmCYCryv67zSjUiw0SsPJXKnA0EUtrEM1cY6GD2zOofd4MP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUjSVyXroUV0hsGcR0QVxJjomTOUkWgt7+HlIg9oLfbgsc2xgs
	uU8cuYfwkw6Gpm3D/vFJ0y6UjzhZBQWUn4Rp3chGfWeSO06OyBuX
X-Google-Smtp-Source: AGHT+IEvSE7bcbW5iMeCar6RQ8E7bsc++y7hOdnobGC80HtcjwTt17/04ZvXNdGZyveXrCYeqajDdQ==
X-Received: by 2002:a17:902:ecc1:b0:20c:c482:1d62 with SMTP id d9443c01a7336-20cc4821f06mr224244025ad.61.1729182884692;
        Thu, 17 Oct 2024 09:34:44 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:f922:7a97:d87e:e588])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805b0d0sm46542655ad.253.2024.10.17.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:34:44 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 17 Oct 2024 09:34:22 -0700
To: Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Message-ID: <ZxE8jn9M7twa4v2u@fan>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>

On Tue, Oct 08, 2024 at 05:16:42PM -0500, Terry Bowman wrote:
> This is a continuation of the CXL port error handling RFC from earlier.[1]
> The RFC resulted in the decision to add CXL PCIe port error handling to
> the existing RCH downstream port handling. This patchset adds the CXL PCIe
> port handling and logging.
> 
> The first 7 patches update the existing AER service driver to support CXL
> PCIe port protocol error handling and reporting. This includes AER service
> driver changes for adding correctable and uncorrectable error support, CXL
> specific recovery handling, and addition of CXL driver callback handlers.
> 
> The following 8 patches address CXL driver support for CXL PCIe port
> protocol errors. This includes the following changes to the CXL drivers:
> mapping CXL port and downstream port RAS registers, interface updates for
> common RCH and VH, adding port specific error handlers, and protocol error
> logging.
> 
> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554
> -1-terry.bowman@amd.com/
> 
> Testing:
> 
> Below are test results for this patchset. This is using Qemu with a root
> port (0c:00.0), upstream switch port (0d:00.0),and downstream switch port
> (0e:00.0).
> 
> This was tested using aer-inject updated to support CE and UCE internal
> error injection. CXL RAS was set using a test patch (not upstreamed).

Hi Terry,
Can you share the aer-inject repo for the testing or the test patch?

Fan
> 
>     Root port UCE:
>     root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>     [   27.318920] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>     [   27.320164] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>     [   27.321518] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     [   27.322483] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>     [   27.323243] pcieport 0000:0c:00.0:    [22] UncorrIntErr
>     [   27.325584] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>     [   27.325584]
>     [   27.327171] cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error'
>     first_error: 'Memory Address Parity Error'
>     [   27.333277] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>     [   27.333872] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g1fb9097c3728 #3857
>     [   27.334761] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>     [   27.335716] Call Trace:
>     [   27.335985]  <TASK>
>     [   27.336226]  panic+0x2ed/0x320
>     [   27.336547]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>     [   27.337037]  ? __pfx_aer_root_reset+0x10/0x10
>     [   27.337453]  cxl_do_recovery+0x304/0x310
>     [   27.337833]  aer_isr+0x3fd/0x700
>     [   27.338154]  ? __pfx_irq_thread_fn+0x10/0x10
>     [   27.338572]  irq_thread_fn+0x1f/0x60
>     [   27.338923]  irq_thread+0x102/0x1b0
>     [   27.339267]  ? __pfx_irq_thread_dtor+0x10/0x10
>     [   27.339683]  ? __pfx_irq_thread+0x10/0x10
>     [   27.340059]  kthread+0xcd/0x100
>     [   27.340387]  ? __pfx_kthread+0x10/0x10
>     [   27.340748]  ret_from_fork+0x2f/0x50
>     [   27.341100]  ? __pfx_kthread+0x10/0x10
>     [   27.341466]  ret_from_fork_asm+0x1a/0x30
>     [   27.341842]  </TASK>
>     [   27.342281] Kernel Offset: 0x1ba00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>     [   27.343221] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
> 
>     Root port CE:
>     root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
>     [   19.444339] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
>     [   19.445530] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
>     [   19.446750] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     [   19.447742] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
>     [   19.448549] pcieport 0000:0c:00.0:    [14] CorrIntErr
>     [   19.449223] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>     [   19.449223]
>     [   19.451415] cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'
> 
>     Upstream switch port UCE:
>     root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
>     [   45.236853] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
>     [   45.238101] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
>     [   45.239416] pcieport 0000:0d:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     [   45.240412] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
>     [   45.241159] pcieport 0000:0d:00.0:    [22] UncorrIntErr
>     [   45.242448] aer_event: 0000:0d:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>     [   45.242448]
>     [   45.244008] cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error'
>     first_error: 'Memory Address Parity Error'
>     [   45.249129] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>     [   45.249800] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g1fb9097c3728 #3855
>     [   45.250795] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>     [   45.251907] Call Trace:
>     [   45.253284]  <TASK>
>     [   45.253564]  panic+0x2ed/0x320
>     [   45.253909]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>     [   45.255455]  ? __pfx_aer_root_reset+0x10/0x10
>     [   45.255915]  cxl_do_recovery+0x304/0x310
>     [   45.257219]  aer_isr+0x3fd/0x700
>     [   45.257572]  ? __pfx_irq_thread_fn+0x10/0x10
>     [   45.258006]  irq_thread_fn+0x1f/0x60
>     [   45.258383]  irq_thread+0x102/0x1b0
>     [   45.258748]  ? __pfx_irq_thread_dtor+0x10/0x10
>     [   45.259196]  ? __pfx_irq_thread+0x10/0x10
>     [   45.259605]  kthread+0xcd/0x100
>     [   45.259956]  ? __pfx_kthread+0x10/0x10
>     [   45.260386]  ret_from_fork+0x2f/0x50
>     [   45.260879]  ? __pfx_kthread+0x10/0x10
>     [   45.261418]  ret_from_fork_asm+0x1a/0x30
>     [   45.261936]  </TASK>
>     [   45.262451] Kernel Offset: 0xc600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>     [   45.263467] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
> 
>     Upstream switch port CE:
>     root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh 
>     [   37.504029] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
>     [   37.506076] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
>     [   37.507599] pcieport 0000:0d:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     [   37.508759] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
>     [   37.509574] pcieport 0000:0d:00.0:    [14] CorrIntErr            
>     [   37.510180] aer_event: 0000:0d:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>     [   37.510180] 
>     [   37.512057] cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'
> 
>     Downstream switch port UCE:
>     root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
>     [   29.421532] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
>     [   29.422812] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
>     [   29.424551] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     [   29.425670] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
>     [   29.426487] pcieport 0000:0e:00.0:    [22] UncorrIntErr
>     [   29.427111] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>     [   29.427111]
>     [   29.428688] cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error'
>     first_error: 'Memory Address Parity Error'
>     [   29.430173] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>     [   29.430862] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g844fd2319372 #3851
>     [   29.431874] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>     [   29.433031] Call Trace:
>     [   29.433354]  <TASK>
>     [   29.433631]  panic+0x2ed/0x320
>     [   29.434010]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>     [   29.434653]  ? __pfx_aer_root_reset+0x10/0x10
>     [   29.435179]  cxl_do_recovery+0x304/0x310
>     [   29.435626]  aer_isr+0x3fd/0x700
>     [   29.436027]  ? __pfx_irq_thread_fn+0x10/0x10
>     [   29.436507]  irq_thread_fn+0x1f/0x60
>     [   29.436898]  irq_thread+0x102/0x1b0
>     [   29.437293]  ? __pfx_irq_thread_dtor+0x10/0x10
>     [   29.437758]  ? __pfx_irq_thread+0x10/0x10
>     [   29.438189]  kthread+0xcd/0x100
>     [   29.438551]  ? __pfx_kthread+0x10/0x10
>     [   29.438959]  ret_from_fork+0x2f/0x50
>     [   29.439362]  ? __pfx_kthread+0x10/0x10
>     [   29.439771]  ret_from_fork_asm+0x1a/0x30
>     [   29.440221]  </TASK>
>     [   29.440738] Kernel Offset: 0x10a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>     [   29.441812] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
> 
>     Downstream switch port CE:
>     root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
>     [  177.114442] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
>     [  177.115602] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
>     [  177.116973] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     [  177.117985] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
>     [  177.118809] pcieport 0000:0e:00.0:    [14] CorrIntErr
>     [  177.119521] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>     [  177.119521]
>     [  177.122037] cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'
> 
> Changes RFC->v1:
>  [Dan] Rename cxl_rch_handle_error() becomes cxl_handle_error()
>  [Dan] Add cxl_do_recovery()
>  [Jonathan] Flatten cxl_setup_parent_uport()
>  [Jonathan] Use cxl_component_regs instead of struct cxl_regs regs
>  [Jonathan] Rename cxl_dev_is_pci_type()
>  [Ming] bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can
>  replace these find_cxl_port() and device_find_child().
>  [Jonathan] Compact call to cxl_port_map_regs() in cxl_setup_parent_uport()
>  [Ming] Dont use endpoint as host to cxl_map_component_regs()
>  [Bjorn] Use "PCIe UIR/CIE" instesad of "AER UI/CIE"
>  [TODO][Bjorn] Dont use Kconfig to enable/disable a CXL external interface
> 
> Terry Bowman (15):
>   cxl/aer/pci: Add CXL PCIe port error handler callbacks in AER service
>     driver
>   cxl/aer/pci: Update is_internal_error() to be callable w/o
>     CONFIG_PCIEAER_CXL
>   cxl/aer/pci: Refactor AER driver's existing interfaces to support CXL
>     PCIe ports
>   cxl/aer/pci: Add CXL PCIe port correctable error support in AER
>     service driver
>   cxl/aer/pci: Update AER driver to read UCE fatal status for all CXL
>     PCIe port devices
>   cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to pci_ers_result type
>   cxl/aer/pci: Add CXL PCIe port uncorrectable error recovery in AER
>     service driver
>   cxl/pci: Change find_cxl_ports() to be non-static
>   cxl/pci: Map CXL PCIe downstream port RAS registers
>   cxl/pci: Map CXL PCIe upstream port RAS registers
>   cxl/pci: Update RAS handler interfaces to support CXL PCIe ports
>   cxl/pci: Add error handler for CXL PCIe port RAS errors
>   cxl/pci: Add trace logging for CXL PCIe port RAS errors
>   cxl/aer/pci: Export pci_aer_unmask_internal_errors()
>   cxl/pci: Enable internal CE/UCE interrupts for CXL PCIe port devices
> 
>  drivers/cxl/core/core.h  |   3 +
>  drivers/cxl/core/pci.c   | 172 +++++++++++++++++++++++++++++++--------
>  drivers/cxl/core/port.c  |   4 +-
>  drivers/cxl/core/trace.h |  47 +++++++++++
>  drivers/cxl/cxl.h        |  14 +++-
>  drivers/cxl/mem.c        |  30 ++++++-
>  drivers/cxl/pci.c        |   8 ++
>  drivers/pci/pci.h        |   5 ++
>  drivers/pci/pcie/aer.c   | 123 ++++++++++++++++++++--------
>  drivers/pci/pcie/err.c   | 150 ++++++++++++++++++++++++++++++++++
>  include/linux/aer.h      |  16 ++++
>  include/linux/pci.h      |   3 +
>  12 files changed, 503 insertions(+), 72 deletions(-)
> 
> 
> base-commit: f7982d85e136ba7e26b31a725c1841373f81f84a
> -- 
> 2.34.1
> 

-- 
Fan Ni

