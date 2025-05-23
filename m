Return-Path: <linux-pci+bounces-28332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2615AC26CC
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 17:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00443544FCC
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738F21B9F5;
	Fri, 23 May 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jde2vxeS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2A1459F7
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015387; cv=none; b=BfxAjjmLdOXRmcqTis8asYS3VNKORqnNe0td51v18JmTeh720R0f8EIrAoKkzrj7s3mNZvwMmvIt3SFquKe4Ya2M28yQgFOfL2IFD7r1TeiPsq6w80FwRvyZPQib67apoC6x8cUoOOjI+BAY/wJxdUnPl+Gyqn4uaf+Ww/QuiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015387; c=relaxed/simple;
	bh=PAwGAdx4TLlnXQfcPOqYt7VsAze7iB217rhPSLNhAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqgjUyO6ehlKvfhMwDrd8xe2H+eObo4BvKJYmXy6NrvB1vIQT5yILwRi2UAr1oPweZopTmsqHu5wjZXAevgZwwh48sImZSzscTiY7XXRA2IKlB0YpVICUpmx9oR24hgkMhWYVTLCi8QcQU+s0yJpo37qaRSuTTnBZy/Dx1TJoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jde2vxeS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso10023718a12.2
        for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748015383; x=1748620183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BK2SL4fyGhYeTW40ulCmzXggN5IcqhObBba5FPSD9io=;
        b=jde2vxeSqsqWmzIlYYkJk4vK2tlmzuOZFrMfqDCmGH+snE18HMkOkrPXOtZcWdRGkK
         JGFY2MtIp3gzj/gZh5xJKN/b1jArwkWcZxRVxvu1huDzRjvNclfasEtvaHUN8r4axKt+
         RfDr6GDM5Hi8hv8jhHbH1co4oSVtosxc+DrC4GzSXdHWcQxUUdMfJ+HqPAQgkXWDqfdg
         tg8BksO2Ov9v3W6i0Y+gxoXqwUGHm0wTo5G5GQiqkLRiwgp1YWsyF5biniaN9t21g8/F
         /02vUjeBi5R06Zgsjlub17RavuOQYhgT06LwEN3ttIhw8EgL2wjKM5+NYXkYrakMXgU9
         yFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015383; x=1748620183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BK2SL4fyGhYeTW40ulCmzXggN5IcqhObBba5FPSD9io=;
        b=Qb5TZqLjCwdryCDDgkmQRr25s5eMITy6Tu3gC6V0NlwqSE7nq2FDhMX06NCgD+OBBf
         yvoHudPYrafsSD65qHPOA9xLHBC2gDqOHkkQR1l6NyZViFgvSWGnlHV6h9eJIfKp4RWm
         W6va9kzQHKVSYHolvQttov6+fwBzhNSE7mt/IZEIMxaBKCwVYlxzjoYFaaVT9IcbzS72
         ZSBOXngQF2ldrqkAA8ih565ljydxeRyInRoNZC90VlTlPzaQU3LUh5Z6nikdJ7EOYMAX
         0sbh75xIeemY7Ar1yr6nRiQaxj4rDa3ZYUl/xfoKBMrzWlvtYnq+XkZ2h7bYWqXcU95D
         e6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvIhv8i9BSH6jWRguBj7n4IoVAY5MYz82URIY3B7vZbiqNVvc5GnJ9eVYz0JweuScuu2eQpZYSFE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0RgLAneB5pj2m7gVn5Nxx+SmKmhacSnDnqldyqs3cRgkNhwU
	xjHxsPW+i6adXqbeTj813PG+xvcnqYMRshfkMqF24iGJEbFN2ls8wISU+Cfo2IU3rQ==
X-Gm-Gg: ASbGncvg66kVqSzFsZfKIPEi+tLFW5PeTUOX37csTAAoal+2v3DLVidKXxk/EIXcLx7
	lAU0X5IKO8GG3hBXPwm1DI69WlVNKim4NN6mWBDwmosZ4G+6Pm5o2YE9wqWsoZtgo9D2+q2xJ0h
	8veh+ylcMhA9snVrmINi6LrBDy9b+fcEAg8i4biw2KdNGf5ZlDxG2xMLDwwUMFh5ZxYZViP9dmQ
	bl0l9YnF9UxKa8wJyJt0/yLeNL+ItdMeu+bgivgD1qTcRfYSSzEicQgqwEGg6v2OkzfoLNsBDxR
	PTXwa4ssL+Jec1OZdZ9jREGP5Riuvyg2licFyuixY2MB11byd2riCCLXJYXL6OY=
X-Google-Smtp-Source: AGHT+IGDfKRPeH5csKtLWhQo1ThHp7CL7vsgZO+iI+kJ4lty87nL71AWZVYrcvPlx9oOeUwEswIw0A==
X-Received: by 2002:a17:90b:1dc2:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-30e8322593dmr43184352a91.27.1748015383366;
        Fri, 23 May 2025 08:49:43 -0700 (PDT)
Received: from thinkpad ([120.56.203.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36368bb0sm7481466a91.10.2025.05.23.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:49:42 -0700 (PDT)
Date: Fri, 23 May 2025 21:19:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <6p3jwneiuf4e7reh7ggh6hdqlsdkkmaxkunkil37bmyfhor4mp@lqb2eueh34ej>
References: <aC9OrPAfpzB_A4K2@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aC9OrPAfpzB_A4K2@ryzen>

On Thu, May 22, 2025 at 06:19:56PM +0200, Niklas Cassel wrote:
> Hello there,
> 
> 
> As you know the reset_slot() callback patches were merged recently.
> 
> Wilfred and I (mostly Wilfred), have been debugging DMA issues after the
> reset_slot() callback has been invoked. The issue is reproduced when MPS
> configuration is set to performance, but might be applicable for other
> MPS configurations as well. The problem appears to be that reset_slot()
> feature does not respect/restore the MPS configuration.
> 
> 
> When having two Rock 5Bs, one in RC mode, one in EP mode:
> 
> # Boot with MPS bus performance
> pci=pcie_bus_perf on kernel command line
> 
> # lspci RC
> lspci -vvvs 0000:00:00.0 | grep -E MaxPayload
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>                 DevCtl: MaxPayload 256 bytes, MaxReadReq 256 bytes
> 
> # Run pcitests
> All tests pass
> 
> # Perform hot reset of EP
> echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset
> 
> # lspci RC
> lspci -vvvs 0000:00:00.0 | grep -E MaxPayload
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>                 DevCtl: MaxPayload 128 bytes, MaxReadReq 512 bytes
> 
> # Run pcitests
> FAIL  pci_ep_data_transfer.dma.READ_TEST
> Compared to before, DMA read test now fails.
> 
> Wilfred has been able to track this down to being because MPS in the RC
> is different before/after a ->reset_slot(), and simply re-storing MPS using
> a dirty hack, the DMA read issues go away.
> 
> 
> 
> My first thinking was that pci_configure_device() (and thus pci_configure_mps())
> was not called,
> so I added some prints in pci_configure_mps().
> pci_configure_mps() was not called for RC nor EP during ->reset_slot()
> (I did not check if pcie_bus_configure_settings() was called.)
> 
> 
> I tried Mani's earlier patch instead of what is queued up:
> https://lore.kernel.org/linux-pci/20250221172309.120009-2-manivannan.sadhasivam@linaro.org/
> 
> And in this version pci_configure_mps() does get called,
> for both the RC and EP during ->retrain_link()
> (I did not check if pcie_bus_configure_settings() was called.)
> 
> But... MaxPayload was still incorrectly set after retrain_link().
> 
> 
> I think the solution is to add a call to add a pcie_bus_configure_settings()
> call in pcie_do_recovery() / pci_host_recover_slots() / pci_host_reset_slot() /
> pcibios_reset_secondary_bus().
> 
> 
> Or possibly a:
>         list_for_each_entry(child, &bus->children, node)
>                 pcie_bus_configure_settings(child);
> 
> as done in pci_host_probe().
> 
> I'm not sure if we need to make sure that pci_configure_device() /
> pci_configure_mps() gets called as well. Since we did reset the endpoint,
> it seems that calling pci_configure_mps() does make sense.
> 
> 
> Normally, I would wait for Wilfred and myself to come up with a nice fix,
> and test it, but, considering that the ->reset_slot() patches are queued
> up already, and the merge window is opening soon, I'm sharing our findings
> on the list, as it might take some time to come up with a nice solution.
> 

Thanks Niklas for reporting and Wilfred for debugging!

I will submit the patches for fixing this issue along with couple of other
comments raised by Lukas.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

