Return-Path: <linux-pci+bounces-32400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8339B08E85
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA58A3A5B91
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79E2F5C3C;
	Thu, 17 Jul 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWm4oQjK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAD2E717F;
	Thu, 17 Jul 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760267; cv=none; b=b/NZ3GDaQ9CP6+ifCZvA9MvwkI2IiuVctM3Z88165oA198WcmRYfGpuWR/KQD4Ke6ZqLshKEwHcoifjlM4GNnnbDvQ5w0fYKmay0pxrr0TYxPo0amXOh0llbdABrqsjY8TwEIAUimUBUEH0LG22ZyTr3QkPqPhzx0PfXoN8w5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760267; c=relaxed/simple;
	bh=19aZVShZ6HFtYfeUxh4qhpz2sGVEMtS5ltBy75+3rio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4JoJRs/UivXY0zmNADhDCP26Qs2Ze5sSlEgRWFqJYoivFAnlgltjLBxJBFn7ZIUnjSrmerSKs6bclKJhiBxm2RHsq7C9cMkvKDw3JGfbILQKL5SLjibfYBBU2EaPlrhb9VSkU1tn/Uz5dSpQytUqrJmeaQIGcSVXmTIe/rC8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWm4oQjK; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87f2aed4092so514198241.2;
        Thu, 17 Jul 2025 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752760265; x=1753365065; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OFoZFsmVBgIgOnRb6v56ZyJVL3iVN9nED2Us643BX3E=;
        b=FWm4oQjKgn7CbQ0eCwi8zVgoX/Wvwx3oGkyH/FvP6n+QgyYL84gPgCOggJwjadK8q/
         Xn09BPdgr40B+rUVwv0AWY9ztJl/qQLTff75DAeyOe82xfjTB1p13TnOQLGaURfx3c6L
         AO7fmMW3ajskuuT1ufa46DpFNaIwTKYzxatbgLT/R/bkOOTgzW3flHpdEU9Ukabd9qvx
         AXEha5bBZ25dgiTSGO0y2PQ8wH+THws7vHFnyLg1BsRS/+r/1YVRiEebiK9iolT5Ktp0
         wZiTazai3rTHEBmjM2kiuMTPBYWCVAQGwYSCimQE/v8DMd1CMcf4O8vTFkviyZWGKcAE
         c7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760265; x=1753365065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFoZFsmVBgIgOnRb6v56ZyJVL3iVN9nED2Us643BX3E=;
        b=l9sAvldPrtaRz4eRABH94k2i+Dzuun1KbWGofFhJpWl/gSiNtXS431iJ3VqAzHd3KO
         2Q3sFfzISyWtnFixWtpliyoWfIrbf4eV9RfXhFFXHH/HxdnJX1+ET+7QprCSN9mdgHN2
         kKiyQFRguOM7lXQSbQsvyPiQozi+nxiW345GjhR7dERmVhUBUOznwtAYollBtGPa3/4z
         3ZffM0VqnXwYVKGLn/faCagZZkNTVsnQqGu2uoXCVy2+1tvpao0idhS5+Whhd2WBlMaE
         iW3j/J95TgQrhjx3U5B6tAPQMzqJWfRGJWLy+c2XKeOHJ2BhnfQn/8n9J3MeXPkwJ/K/
         IExw==
X-Forwarded-Encrypted: i=1; AJvYcCWIaUSMcphI22AE/gKVyOrYqhHwWnNx4Ec6w5OJLTZZirGMMq8aISuK/sHqG0CTD+uI9wFF8OKg3VDkxVE=@vger.kernel.org, AJvYcCXZoOBAxihN4pMiC31WIrspscpiGUb5z9K/lssn7LTwoH/a+FuPvznPZ+uL1iTUh/QqBmSEIqGW+YRS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhkyi6oy9I/894+2SCC7Sj1t0t2NFouGsC44Px/jE3oe/8K4PE
	0D/9kWhc9G4g4WoLY9S5HnPTlg+0nfzFEIMcmlk3+gOkzFnACfBwh20R
X-Gm-Gg: ASbGncvF5qQAlewQ9IRh9trbDFaieeDsTtKDKocU+kmcQ+8uWey54W8o4TsLQubNQ/U
	O7L/VoxWGxMkVL8AtiXvwZAYG9F6mr3Vfvyy8zK2QNLQ2tKWEI5hMIGGP+Vk8o3/+lNwrCFBYgD
	w8OzNff3FN8o5FKBfMok/ELiFHz83O93/3yiMicaRosSWfCgaRjGNF1csCw6EZEUKhAys8zRshM
	439wS301lygTLCepwWFb1wd8WWNlaUqBI8iClymaLMWgR8P3AZHGHJiLBD7BSe+C4WA03UScGoL
	RzoqZQgHl934BT4cTaUF+6SY/Q68gQhRw6UkDR8NPNp/NVj1/sbJ+Jz/X8dR6c+VP3F0QlRydNp
	1wc5IA8CQSw==
X-Google-Smtp-Source: AGHT+IGzgyrDUgDH08RDqZ3hkrbd5Lom3WMZY7KIBjhCX4qRVfQkKF54K0pt01hz0j8j+3pC5nv9qg==
X-Received: by 2002:a05:6102:4421:b0:4e7:dbd2:4604 with SMTP id ada2fe7eead31-4f8999bcbeamr4068557137.17.1752760264477;
        Thu, 17 Jul 2025 06:51:04 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2246::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f62faf5ec1sm2853884137.23.2025.07.17.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:51:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 10:50:49 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aHj_ue-eFQu_NgHd@geday>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
 <zuiq3b2rsixymtjr3xzrb26clikvlja62wgj65umnse4kuk75c@x5qan73ispxe>
 <aFk-MeIWFcBiGBPr@geday>
 <djbhz7qfyzrn7mdqmvqhyh6yjsjyigjly7py4f7aj5f4qbabou@67gk3qdnvzws>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <djbhz7qfyzrn7mdqmvqhyh6yjsjyigjly7py4f7aj5f4qbabou@67gk3qdnvzws>

On Thu, Jul 17, 2025 at 05:59:32PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 23, 2025 at 08:44:49AM GMT, Geraldo Nascimento wrote:
> > On Mon, Jun 23, 2025 at 05:29:46AM -0600, Manivannan Sadhasivam wrote:
> > > On Tue, Jun 10, 2025 at 04:05:40PM -0300, Geraldo Nascimento wrote:
> > > > +reinit:
> > > 
> > > So this reinit part only skips the PERST# assert, but calls
> > > rockchip_pcie_init_port() which resets the Root Port including PHY. I don't
> > > think it is safe to do it if PERST# is wired.
> > 
> > I don't understand, could you be a bit more verbose on why do you
> > think this is dangerous?
> > 
> 
> When the Root Port and PHY gets reset, there is a good chance that the refclk
> would also be cutoff. So if that happens without PERST# assert, then the device
> has no chance to clean its state machine. If the device gets its own refclk,
> then it is a different story, but we should not make assumptions.

Hi Mani, thank you for your time spent looking into this!

I'm not sure if the following information helps, but patch 2 of this
series disables the PCIe 3.3V always-on/boot-on through DT. That was
not incidental, and in fact it is required for patch 1 to work.

Then, if you follow the proposed code change, you will see that power
is effectively cut via disabling the power regulators, even before
disabling the clocks. So there's effectively zero chance of corrupting
the endpoint device state machine, since the device is power-cycled.

While I understand we should not make assumptions on kernel work, and
that the patch is unmergeable on its current form (it's a goddamn hack),
it does empirically alleviate a very real report, that of known-good
working devices refusing to cooperate with Rockchip-IP PCIe.

I agree we should wait on Shawn Lin's feedback.

Thank you,
Geraldo Nascimento

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

