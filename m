Return-Path: <linux-pci+bounces-1133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE3E81644C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 03:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA942B21966
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 02:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFFC23BE;
	Mon, 18 Dec 2023 02:23:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DA23A7;
	Mon, 18 Dec 2023 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6da579e6858so1791157a34.3;
        Sun, 17 Dec 2023 18:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702866201; x=1703471001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUh8R+nscKiO1LQ6m0AM82k3aN4ql71rUMxjIgccdr8=;
        b=LMzNVJRhAZEWIY4Whv84jVGADHgMaE0EY/ljHWFBbR3Y5Etf/GzY2MvhhX47Dg/aFH
         HTJgOymDvNeeiH62Z2UWFloiNa+i6tdfktLVMH7Y400DenfJS63O6lW7G43brqlk3RVv
         LR1N/fk9qe1mk2PcJbk7p/V80o5rjpDNMNuhC+6DduLx/vmC8PKeCVOifAsndM71Pm2B
         iKH4kXpHT9N+dWfg1oTXZvF/orirK1aqVrzuoiNsw18WUVte7T5Y0K1KLRwIahN0rpzl
         z+DQhegU7oBuiF+mCHiBG0vA3brKWLErHCRfoWFywb8MQttuhi6A0CLx9hoO2J9A1Mpm
         94rg==
X-Gm-Message-State: AOJu0Yy6FEspAFnpBaAYJnnbbvzqEXz4maIz5g/iv4dpuxGKx/+5EFbk
	YOs5qkCBHfM93fkfDiR1uYo=
X-Google-Smtp-Source: AGHT+IG7l7NST7Kn9f3sLGp2h7mChkuDh/xWs1QvXERaxEiq+3xoxgLsb1E4JkSVVfl6qQmllcIHwg==
X-Received: by 2002:a05:6358:2608:b0:172:cf9c:882a with SMTP id l8-20020a056358260800b00172cf9c882amr1348802rwc.32.1702866201513;
        Sun, 17 Dec 2023 18:23:21 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id ms16-20020a17090b235000b0028b06464b62sm1959293pjb.15.2023.12.17.18.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 18:23:20 -0800 (PST)
Date: Mon, 18 Dec 2023 11:23:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	michal.simek@amd.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] PCI: xilinx-xdma: Remove redundant dev_err()
Message-ID: <20231218022319.GC88933@rocinante>
References: <20231030061242.51475-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030061242.51475-1-yang.lee@linux.alibaba.com>

Hello,

> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> ./drivers/pci/controller/pcie-xilinx-dma-pl.c:688:2-9: line 688 is redundant because platform_get_irq() already prints an error
> ./drivers/pci/controller/pcie-xilinx-dma-pl.c:702:2-9: line 702 is redundant because platform_get_irq() already prints an error

Applied to controller/xilinx, thank you!

[1/1] PCI: xilinx-xdma: Remove redundant dev_err()
      https://git.kernel.org/pci/pci/c/b642e081f46c

	Krzysztof

