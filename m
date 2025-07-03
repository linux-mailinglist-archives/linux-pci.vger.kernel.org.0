Return-Path: <linux-pci+bounces-31331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF876AF6A67
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 08:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C82248108E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3682018B47C;
	Thu,  3 Jul 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aaoehm5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63157462
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751524562; cv=none; b=bcBayye2+u41H9EGBKwDW04jsPqIx8VSc+pcL3a/qbJt80CqiT7uHKECei0hZ2vGiVkS/hhgXwyNz7W37H9g2+ci7fD1xoz49A5QVafU/EiGjcHhjCgRcEZlQhsWfEIKiBiwBbavOFEqQoekBllZIgDOleS19yDDyWr6ClrmLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751524562; c=relaxed/simple;
	bh=YTVVnVJ6PdWC/AKl489gZ/2Sl6Au8Ca1tG/ODoK6oOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHI/L48pPjZlz/bgX/TgYsDUupsQyhmMHOf+sbiZ+2Ba23Ti35D9H1xg2GALD4nw8icB0b/1CphBNe5KusqTeycND+DAcra0YtzWRfMPY+S63sBt/D8ldEh5QAb01DZXgsBSfS6Ig/8aBcIL6Mxgyyd3EyNUrOX+uAecNXq5hZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aaoehm5M; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33677183so66904965ad.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 23:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751524560; x=1752129360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIKd4XyqKz0WFU05jsmNNatyFr3GWpnfNcV6WEt42xQ=;
        b=aaoehm5MJbBnlpjv9TaIa4TtSQnEdpiCcbI9jpOm/5BZQdWSofSDMXiURwceOFu3bl
         SqcbOPXY55pqqA6akly7udwdEjsVf+o5oFKcxs7QWjNIxeEFl2wCFjiPg9F/b/gIA9BQ
         5otTV4xzaUaNeCR6bqZntfnPn4Muxg7WgV2uGn0iS1JklOvSxmuYZqBpNSNLH5QmI7mX
         itnq4R0nBW3TTv58Zh8uEgoCRg263PTXXGk2lIFDrRGCWZo7qsfVH74MwmeqXKNTyElU
         0BnQiDXWVOLMpLAEHQrFJHAogCh2sAOvOX2kXl5/9esgUTpjEsEZm27vqodouyMVusVS
         b8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751524560; x=1752129360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIKd4XyqKz0WFU05jsmNNatyFr3GWpnfNcV6WEt42xQ=;
        b=WDw25JKyjiAfsKziY10L4NMWsZ1uR1QcK4w8hegSc+pILd+n2D6M2xCBv11OJnm1uK
         dppPypH2EBDu5nKVf1XIhDiW37Z9308ctrdGqsMrzOXzjt8abLe0SXdIkk6VpiBfvZKu
         SpzJTONtyKH529jzWeBddwt9G/ZaMF56LFFLSe/Og12iSOibEfI4M/mFx8S5fVxlBL3u
         GYgOvs5tBixlB5xOBHoC6j1P9t6lrkcbnNvajADbxctiXzcxIjDsIiG7OI2b6W92Rbir
         m5YsgcmCdO1skD2mDSlk5DCa20vLIVthjwa4ducga6rFkNBJpOE7EfrvilwenM1oLSbd
         wPZA==
X-Forwarded-Encrypted: i=1; AJvYcCW0BMiGCr5b8WI9lUY6FYQQd7JuJpZ3hZtm/YkhWiRFlPQUtU2sLObqmtCDuWqfQ17z7x9kkv0vVGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvteXe9f30xGyFe6BW857ysSLF95x7sNoKQ8OvWMayg/6UYl6
	/VejGkxdEtmtir9BPt189FYCWxoyEFamF4PN8NgHc1936WQRdsXorCfMa+f8784MoD1SQ06F9gB
	Q8H4hDLo=
X-Gm-Gg: ASbGncu25/H7UmrmYosDa4U1ljNTFBwa/wSDaO91xtrGBfI5kvVwKIAigS1cgGtuslh
	salbEKkdj+oYlXyhgtM8IvkS3bIm3tRBg5H3g996SFGkNBkGFHUMIC+qMMYseipEwGnPSckIdnr
	rWha/aIkpkR8UvGIOuKOJYneipzslf2PGu+L3gKv/KhTTxZ3OE2jci+owpGMiwLa8ZfwG0tyKEa
	oW9juOGbpD3ygq4lS+FH84Vpi79xy9LHIqlAInxGEWxe70rdK5V3RjSc9dhJwbXC0q9CMJryx24
	Rgrq96BT9FbGCJyBvH1LHzTQk71tiBdIDvA72Wlp0d2ojHCZuqn10FR5IPKeUYEioWxhuA==
X-Google-Smtp-Source: AGHT+IFVznHzewXkRwXl+jlpU+/jlWH9G3uXJOnEyYhJffoLUHYr+wecCaP0uvRb31laWEgyZwnmrw==
X-Received: by 2002:a17:902:da91:b0:234:bfcb:5c21 with SMTP id d9443c01a7336-23c797b28efmr33182915ad.19.1751524559978;
        Wed, 02 Jul 2025 23:35:59 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ba5bdsm139341455ad.186.2025.07.02.23.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 23:35:59 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:05:51 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Shuan He <heshuan@bytedance.com>
Cc: bhelgaas@google.com, cuiyunhui@bytedance.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] PCI: Fix pci devices double register WARNING in the
 kernel starting process
Message-ID: <aGYkx4a4eJUJorYp@sunil-laptop>
References: <20250702155112.40124-1-heshuan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702155112.40124-1-heshuan@bytedance.com>

On Wed, Jul 02, 2025 at 11:51:11PM +0800, Shuan He wrote:
> Hi All.
> I encountered a WARNING printed out during the kernel starting process
> on my developing environment.
> (with RISC-V arch, 6.12 kernel, and Debian 13 OS).
> 
> WARN Trace:
> [    0.518993] proc_dir_entry '000c:00/00.0' already registered
> [    0.519187] WARNING: CPU: 2 PID: 179 at fs/proc/generic.c:375 proc_register+0xf6/0x180
> [    0.519214] [<ffffffff804055a6>] proc_register+0xf6/0x180
> [    0.519217] [<ffffffff80405a9e>] proc_create_data+0x3e/0x60
> [    0.519220] [<ffffffff80616e44>] pci_proc_attach_device+0x74/0x130
> [    0.509991] [<ffffffff805f1af2>] pci_bus_add_device+0x42/0x100
> [    0.509997] [<ffffffff805f1c76>] pci_bus_add_devices+0xc6/0x110
> [    0.519230] [<ffffffff8066763c>] acpi_pci_root_add+0x54c/0x810
> [    0.519233] [<ffffffff8065d206>] acpi_bus_attach+0x196/0x2f0
> [    0.519234] [<ffffffff8065d390>] acpi_scan_clear_dep_fn+0x30/0x70
> [    0.519236] [<ffffffff800468fa>] process_one_work+0x19a/0x390
> [    0.519239] [<ffffffff80047a6e>] worker_thread+0x2be/0x420
> [    0.519241] [<ffffffff80050dc4>] kthread+0xc4/0xf0
> [    0.519243] [<ffffffff80ad6ad2>] ret_from_fork+0xe/0x1c
> 
This should not happen. I suspect some issue in ACPI namespace/_PRT. Can
you reproduce this on qemu virt machine?

Regards
Sunil


