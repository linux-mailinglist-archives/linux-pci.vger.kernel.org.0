Return-Path: <linux-pci+bounces-10836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA2B93D249
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F7B20DB8
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8C17921D;
	Fri, 26 Jul 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+jLGIaP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944113C83D
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993417; cv=none; b=Gs5yA3RnS+6/w4LhY0Dg3DOtL+fACiaW22aHQ2LlhLOLRLZ2OkiesR4hveu895T/xLKWkH1Z7SrsAJp8A5PI4zQ2JnTk81wMQ0t7U6eGJtwWi9g9Yk1wGs7BkVKuQMreYGZBMG4NEgTIA6kdidvuDLsxu6bXUqKZzJxGapyZMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993417; c=relaxed/simple;
	bh=jZuNH5YnduOs+NIh2LBMhH5sOy0j2IdcWl0ioAMAS+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc4eD6OaKC4yGGxh8S8XMlJG7rhCLgPfajqQj49efkmrqgiSI+rzlvMy3BswMBV9iOvq/sI5XNIMqKSYoRrJRfMA6c6FAcntFtGtTQbKdhHhGiFDfCPFWCYL434/p7/HRk9UTYjR25YN4OfEclKsKd1hrmrYWU60YWKvgv0Fwmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y+jLGIaP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc658b6b2eso4726825ad.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721993415; x=1722598215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RndSCR9HYmtlUSyMNNv/4RT5OOPlZlJZmp3kOybopPY=;
        b=y+jLGIaPGo3jJz+CFukGsgTrdho4ZkiAJFB73bDSdMAeNLyfwB4mDJwJOX7WI03yKu
         p8M0MQ47VfWcxMPfBoBIRQuJSPDMsTD1HGN26ScLnHqr7b6JpqNwAhMunuMTxk4VHqkQ
         Qh2S5b/qyDiQWUMm9UWXRT+ab6Pl1uqCN9j42HhcIIE8yW8kl2ai8fUaHMneoCjpnz+a
         3nGO1NFgHE3LtlcuBbjbgyr3WgsTiuzJ/LM01mPM+Mnc1utGMSp3RCdybl32XPcGBfIN
         oytLKxWMD7SQ71WP/KFJsEyqbfj/82XImg+UefvkxTuUZmJblsutnDalx79qD9MXqy+N
         JJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721993415; x=1722598215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RndSCR9HYmtlUSyMNNv/4RT5OOPlZlJZmp3kOybopPY=;
        b=mDcmRLSxGicrI8oqpkF5zMMmHZ4Jl3LWO7+6Hc2Da7P8pNW8FAW0mvA0KECcPlwInW
         HVy9ifFCaqDpKNcR0ieyFbU09XcLPQLLI/sgCPlPQLOLJ8FVOzIFhALt8L3P/fiHfxR3
         I52MimXovsoLifIsUzdCOdik5q17LuTFwvLligRKt5S/FJUg6YnPw/XPNOyKZDgOYCbu
         WCrgjkBZ5robJTj9gSbaLOK+gQdPtsyT89WkC7l/uJcrSQ+89l6v8t87JCc7UuMrB33B
         pHIZuE+nl7kaopaaVbpxHmV4nKWMWDKpsVw1ODt2WDexAZPT7rL2WNPTPVCFDDxnBWVY
         xTNA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+EFm/5faqGz9jjsyKE5M7i8Zkvgs3fZD+U5dU5JHdBDtXlEtjUE1CDLw2DGolTlyCRnSskE1VDM/LH//08hlRgE8VhbpxVAs
X-Gm-Message-State: AOJu0YzbXDZvVizHW27Zvrr3eaJbRvaWQDoGXs4j/TarpEEQ9kKsHK5k
	cuaKjJYk13BQycLY/K0B3AqVVTWM2FU05G+kCUz6If/JkYKNy+lknCo9/v5C3A==
X-Google-Smtp-Source: AGHT+IFFDs1pJ4blYTtGgWC7JM93sHxQ90BWTwmCih/f3uvHFvkKnEUdPrSg7Zp1i2/tvUTdJ3f9cw==
X-Received: by 2002:a17:902:dacb:b0:1fd:9d0c:9996 with SMTP id d9443c01a7336-1fed38c7af8mr61791785ad.35.1721993415136;
        Fri, 26 Jul 2024 04:30:15 -0700 (PDT)
Received: from thinkpad ([2409:40f4:201d:928a:9e8:14a5:7572:42b6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fda4sm29979565ad.22.2024.07.26.04.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:30:14 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:00:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240726113008.GE2628@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <69f8c45c-29b4-4090-8034-8c5a19efa4f8@ti.com>
 <20240725074708.GB2770@thinkpad>
 <5f7328f8-eabc-4a8c-87a3-b27e2f6c0c1f@ti.com>
 <4cb79826-5945-40d5-b52c-22959a5df41a@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cb79826-5945-40d5-b52c-22959a5df41a@ti.com>

On Fri, Jul 26, 2024 at 03:54:17PM +0530, Siddharth Vadapalli wrote:
> On Thu, Jul 25, 2024 at 02:01:48PM +0530, Siddharth Vadapalli wrote:
> > On Thu, Jul 25, 2024 at 01:17:08PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Jul 25, 2024 at 10:50:13AM +0530, Siddharth Vadapalli wrote:
> > > > On Wed, Jul 24, 2024 at 09:49:16PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > > > > > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > > > > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> > > > > >   of_irq_parse_pci: failed with rc=-22
> > > > > > due to the absence of Legacy Interrupts in the device-tree.
> > > > > > 
> > > > > 
> > > > > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> > > > > if 'map_irq' is set to NULL.
> > > > 
> > > > While 'swizzle_irq' won't be invoked if 'map_irq' is NULL, having a
> > > > non-NULL 'swizzle_irq' (pci_common_swizzle in this case) with a NULL
> > > > 'map_irq' seems inconsistent to me though the code-path may never invoke
> > > > it. Wouldn't a non-NULL 'swizzle_irq' imply that Legacy Interrupts are
> > > > supported, while a NULL 'map_irq' indicates that they aren't? Since they
> > > > are always described in pairs, whether it is in the initial commit that
> > > > added support for the Cadence PCIe Host controller (used by pci-j721e.c):
> > > > https://github.com/torvalds/linux/commit/1b79c5284439
> > > > OR the commit which moved the shared 'map_irq' and 'swizzle_irq' defaults
> > > > from all the host drivers into the common 'devm_of_pci_bridge_init()'
> > > > function:
> > > > https://github.com/torvalds/linux/commit/b64aa11eb2dd
> > > > I have set both of them to NULL for the sake of consistency.
> > > > 
> > > 
> > > Since both callbacks are populated in the pci/of driver, this consistency won't
> > > be visible in the controller drivers. From the functionality pov, setting both
> > > callbacks to NULL is *not* required to disable INTx, right?
> > 
> > Yes, setting 'swizzle_irq' to NULL isn't required. The execution sequence
> > with 'swizzle_irq' set to 'pci_common_swizzle()' is as follows:
> > 
> > pci_assign_irq()
> >   if (pin) {
> >     if (hbrg->swizzle_irq)
> >       slot = (*(hbrg->swizzle_irq))(dev, &pin);
> >         pci_common_swizzle()
> > 	  while (!pci_is_root_bus(dev->bus)) <= NOT entered
> > 	..continue execution similar to 'swizzle_irq' being NULL.
> > 
> > Having 'swizzle_irq' set to 'pci_common_swizzle()' will only result
> > in a no-op which could have been avoided by setting it to NULL. So there
> > is no difference w.r.t. functionality.
> 
> Mani,
> 
> I prefer setting 'swizzle_irq' to NULL as well unless you have an objection
> to it. Kindly let me know. I plan to post the v2 for this patch addressing
> Bjorn's feedback and collecting Andrew's "Tested-by" tag as well.
> 

Ok, fine with me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

