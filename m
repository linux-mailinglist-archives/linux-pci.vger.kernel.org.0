Return-Path: <linux-pci+bounces-12026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DF895BAAB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECF31C23B5C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E41CCB31;
	Thu, 22 Aug 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDKM1Ijh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75CD1CCB23
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341234; cv=none; b=DkqWiOU19+47jAZyJ2wgC8TIvWk1YSyh6COLl4ovY/czHVViNThpRIxTcY2shLvi1BTLVKtwUmJb0Lwgn/5n9qyjbwsVuWR0ev5LxosWoVdFQ14dviyJSzJbbrS0b3f3HONrDKR6016PWo4oqiBlMEAEX69GINC5fqeGtml4IiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341234; c=relaxed/simple;
	bh=gnMXHCyoDE9vbwim3cGbGNLNjI3qarrddxCiDj8YqDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqN7sUNt6DNi+EdYPUMXZScjXkOG1Z8mBdxfq1wO+XuRtdK+9XCOU+yBadYyMrioiPFXih9fUZrlEndprMPeeFGQjtEsZqoCE0lN07pmt+Ic0WW5c9VJvadnU0CnhQ9//Grv2G28UExk0PBWpOwbo0zaJA0ocGqdIOE5QSFRkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cDKM1Ijh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7142014d8dfso837488b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724341232; x=1724946032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rcgKP848ia1sT1sKBh7wuDzcHKmUYL/7jg4d8zl6Hms=;
        b=cDKM1IjhDVvHFpx6nEQNuaRTYt5xPn095zVhgkJ0UqEZqBLYMBymksDcQRqJ/UfLcx
         SaqCqlZFYuH8jNJsdVuCYpVDwRpBDml6fJsRHRzT7JTc7Q/H0hTLGfmtJoupxGywepXo
         dJT6IL0Mtx58ig2RBvxH74N7R8nrPKiD21+zbvt6naJIe53Ld8U5rLRVk7oyyozhjiI+
         +uAG5jzTNrGQFbcUa8v3kNk+a39wfoO9M/jqDjHgcBT4YxsiJLOKi6ECuWUqEr+GgOL6
         Up9g446TvQ4sIbqV7LeB2H0mHfw3a3y0DJp2LpZxVESUtdJHwo5hTJkdVI44bVquiZks
         QF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724341232; x=1724946032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcgKP848ia1sT1sKBh7wuDzcHKmUYL/7jg4d8zl6Hms=;
        b=u9ImrYZTEGsG4YzbqnDJwl3yVFT5u4KGCnXQreHcB8z/vqcp4NLxP2Ph09N3lrE8xO
         1GzPBRke2QG26nZhLzkerfpd3/1UCRCRTSDsAxhUUloVdcgrIf65qVkDBQTiMU++Zsrm
         /kpBVKH81xlaX5jK5KsC6ckDKeHNrZC8aK08e8GZXalRt5RTPgUPrafBhrDelbtiBBny
         nsmU0lgFRoUWCcOk9kJxJS/xBycHpDl06QAYS2ZkGAoGAAwAtXZsrpppYw4FK3g5Y2Yz
         NWB+x1PE5RHwq/BkayC6vdWv+hHjw91B9YrLcKRUX5lp5c2z4txCiZH71eFH6udXxdMT
         3HwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqC7S0rTbksQy8jF7Z7Wfui4COLUXCtWGORZb/jo4O/GaXx/L3rewVdP9ZU8uGnlae1OUwZm1Lx24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaS3N631//Kx0dld4M0WGYOpQBhozqwUa8r85mHAHu4hSDmd6
	M3j9fI570uOPrifsGxFgVxtpu7j1ShHUeNeBa9DwDDDH5/cgwxlULfnZ5RqdBA==
X-Google-Smtp-Source: AGHT+IE2G3Hs7GA0300yVurm4pOpFE7mOVKX/CIwEm6VxYXzrdlmjeMZBBsFwSh2A1fDefS4FryaVw==
X-Received: by 2002:a05:6a20:7f90:b0:1ca:da81:a3ef with SMTP id adf61e73a8af0-1caeb1808a9mr3093356637.3.1724341231993;
        Thu, 22 Aug 2024 08:40:31 -0700 (PDT)
Received: from thinkpad ([120.60.60.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335fe1sm1522247b3a.200.2024.08.22.08.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:40:31 -0700 (PDT)
Date: Thu, 22 Aug 2024 21:10:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240822154025.vfl6mippkz3duimg@thinkpad>
References: <20240822064823.x26bjqev6ye32v5j@thinkpad>
 <20240822151658.GA305162@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822151658.GA305162@bhelgaas>

On Thu, Aug 22, 2024 at 10:16:58AM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 22, 2024 at 12:18:23PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Aug 21, 2024 at 05:56:18PM -0500, Bjorn Helgaas wrote:
> > ...
> 
> > > Although I do have the question of what happens if the RC deasserts
> > > PERST# before qcom-ep is loaded.  We probably don't execute
> > > qcom_pcie_perst_deassert() in that case, so how does the init happen?
> > 
> > PERST# is a level trigger signal. So even if the host has asserted
> > it before EP booted, the level will stay low and ep will detect it
> > while booting.
> 
> The PERST# signal itself is definitely level oriented.
> 
> I'm still skeptical about the *interrupt* from the PCIe controller
> being level-triggered, as I mentioned here:
> https://lore.kernel.org/r/20240815224735.GA57931@bhelgaas
> 

Sorry, that comment got buried into my inbox. So didn't get a chance to respond.

> tegra194 is also dwc-based and has a similar PERST# interrupt but it's
> edge-triggered (tegra_pcie_ep_pex_rst_irq()), which I think is a
> cleaner implementation.  Then you don't have to remember the current
> state, switch between high and low trigger, worry about races and
> missing a pulse, etc.
> 

I did try to mimic what tegra194 did when I wrote the qcom-ep driver, but it
didn't work. If we use the level triggered interrupt as edge, the interrupt will
be missed if we do not listen at the right time (when PERST# goes from high to
low and vice versa).

I don't know how tegra194 interrupt controller is wired up, but IIUC they will
need to boot the endpoint first and then host to catch the PERST# interrupt.
Otherwise, the endpoint will never see the interrupt until host toggles it
again.

But there is no point in forcing this ordering and that was the reason why I
went with the level triggered approach.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

