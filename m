Return-Path: <linux-pci+bounces-14536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C999EADA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A97F282EB9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC021C07D4;
	Tue, 15 Oct 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqUsw6Ts"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8E1C07C2
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997193; cv=none; b=JZ9vPDjgoVw3OBWTuZRcn1JzZsbSsf0ud5R8CIpGFRnCZI+5BaAIpqcYEoVW27JMAvWe2O8w9vnzD74yobkE1GvCmzvj8UuPRFlmtnEMMa9+NFAS62ylyn7AqZdM9BUEoNCcEhfrlLTD4Z6zq98JZrYj5gejNKVdKE924uG4Ylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997193; c=relaxed/simple;
	bh=TUTwAcc5h3DiOx2Hm6YmzHVNMrPJb9caBuTCMkTQTA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGIDG3zVF8QnHFosdD2qy9QaG8Ng1eaHtg0rbFqt46+bF3BjhSYxmY1XClKJkXa0PKVsVJwhtpwsFiTlBw5IGozphwyvx3jkeyMM053OO6vvzOQL0tUNIWon6r2DPjTUOl3QB60qnSBavO0ApEvVqqEfdcabUKzdZZH2Bax58zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BqUsw6Ts; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb7088cbcso27659935ad.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728997191; x=1729601991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQ2ExxafYH8pysjVtyTxWl0xH3aoVpQcW06brvyTYc4=;
        b=BqUsw6TsbXVm2woacayqtMOqcA1ZH2QDiYcSHh1+ZmG+2045DUCcNIO2hRuuukP35k
         1JDX4JxwbrUVszvw3VlA1+krQCXP92MeK01PB1T1wo22f0THEULlj2v68vsegtxZKEN1
         JXhyNG1bmTQ1O2FuWRZ/o4PqgqdsACyDzyaoHgL1T68yTh1Thw4Mz06tbJvtshMyLv/S
         tGkN1f92/h1nz3+OAEi8FOuP2TEH6fQFBTbzheBjBO3JalaOtwjCNGl+UmXTIRNKUPZn
         hnmS/VbWMBWVBlDLATLFAdLYv18utJKx0ADuWqUMPVfKLRi9IoM028jxi8cNFw0epppL
         VMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728997191; x=1729601991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ2ExxafYH8pysjVtyTxWl0xH3aoVpQcW06brvyTYc4=;
        b=WfprhFAK5kzyTsOnVBVmIS6zyTBn1vH+8PsASEo45N0sgr3TNmtWrLWbgx5mvhs2LN
         3uC/E8Dszpv1hBYRn6kwSU8qU2Xx6Yn+aVuEVaPILTngwdVCYNf1fyNSSDBDAbIBIS7+
         F0tpQwfXoYP4rORqXq8ZgkwixQiz3b8GJfHXyyxNwdjK6zzOqtshA2JJqW+XfknPpQ07
         9BU/1ry5srI/wBudPMoo4x4y7idjjE+xlTKAn3wF72ziwEq1OEr3X93UYT+2XEiTSeb6
         sGNcfhXD9CEwxhF/WeE6I8CVYrE/zaNB57X4BkKR+6euGQyXqgfOMu7Kt6hGj3EtsZh3
         Bw2g==
X-Forwarded-Encrypted: i=1; AJvYcCW26yCE0IPhMk/H9OsjrXP8ZUldM7i/vjWVqR6OL1AI97kj9KFHuxL620wpOCv/EVTchwikEUnBn0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRYpKgfdudENgmZHuvu/VCx77qrKadRUx2w2KLnfR+/2UBwnO
	THxN7z3gNqPz2huwrTOXhXcgFXyXkM/rCZB9rPnjhsKwRCXynlAmbu4HOCxmFg==
X-Google-Smtp-Source: AGHT+IHkGuzbGfZUwoftrk6pBddGB0A/KcBGkupentXwPJMsPJLg9KJR/+RBkXTL5DL7BPN+340c5w==
X-Received: by 2002:a17:903:2301:b0:20b:7e1f:bff2 with SMTP id d9443c01a7336-20ca145921fmr210209595ad.17.1728997190673;
        Tue, 15 Oct 2024 05:59:50 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84f5bsm11534205ad.7.2024.10.15.05.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:59:50 -0700 (PDT)
Date: Tue, 15 Oct 2024 18:29:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <20241015125945.llbyg6w7viucw5rh@thinkpad>
References: <20241014135210.224913-1-linux.amoon@gmail.com>
 <20241014135210.224913-3-linux.amoon@gmail.com>
 <20241015051141.g6fh222zrkvnn4l6@thinkpad>
 <CANAwSgSEkFtY6-i3TOPZbwB5EuD4BHboh_jsTwByQw7NLLrstQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgSEkFtY6-i3TOPZbwB5EuD4BHboh_jsTwByQw7NLLrstQ@mail.gmail.com>

On Tue, Oct 15, 2024 at 02:30:23PM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> Thanks for your review comments.
> 
> On Tue, 15 Oct 2024 at 10:41, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Oct 14, 2024 at 07:22:03PM +0530, Anand Moon wrote:
> > > Refactor the reset control handling in the Rockchip PCIe driver,
> > > introduce a more robust and efficient method for assert and
> > > deassert reset controller using reset_control_bulk*() API. Using the
> > > reset_control_bulk APIs, the reset handling for the core clocks reset
> > > unit becomes much simpler.
> > >
> > > Spilt the reset controller in two groups as per the
> > >  RK3399 TM  17.5.8.1 PCIe Initialization Sequence
> > >     17.5.8.1.1 PCIe as Root Complex.
> > >
> > > 6. De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> > >    simultaneously.
> > >
> >
> > I'd reword it slightly:
> >
> > Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> >
> > 1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
> > as Root Complex'.
> >
> > 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per section
> > '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> > reset_control_bulk APIs.
> >
> > > - devm_reset_control_bulk_get_exclusive(): Allows the driver to get all
> > >   resets defined in the DT thereby removing the hardcoded reset names
> > >   in the driver.
> > > - reset_control_bulk_assert(): Allows the driver to assert the resets
> > >   defined in the driver.
> > > - reset_control_bulk_deassert(): Allows the driver to deassert the resets
> > >   defined in the driver.
> > >
> >
> > No need to list out the APIs. Just add them to the first paragraph itself to
> > explain how they are used.
> >
> 
> Here is a short version of the commit message.
> 
> Introduce a more robust and efficient method for assert and deassert
> the reset controller using the reset_control_bulk*() API.
> Simplify reset handling for the core clocks reset unit with the
> reset_control_bulk APIs.
> 
> devm_reset_control_bulk_get_exclusive(): Obtain all resets from the
>             device tree, removing hardcoded names.
> reset_control_bulk_assert(): assert the resets defined in the driver.
> reset_control_bulk_deassert(): deassert the resets defined in the driver..
> 

How about,

"Currently, the driver acquires and asserts/deasserts the resets individually
thereby making the driver complex to read. But this can be simplified by using
the reset_control_bulk APIs. Use devm_reset_control_bulk_get_exclusive() API to
acquire all the resets and use reset_control_bulk_{assert/deassert}() APIs to
assert/deassert them in bulk.

Also follow the recommendations provided in 'Rockchip RK3399 TRM v1.3 Part2':
..."

- Mani

> Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> 
> 1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
> as Root Complex'.
> 
> 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per section
> '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> reset_control_bulk APIs.
> 
> Does this look good to you? Let me know if you need any further adjustments!
> 
> I will fix this for CLK bulk as well.
> 
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >
> > Some nitpicks below. Rest looks good.
> 
> I will fix these in the next version.
> 
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> 
> Thanks
> -Anand

-- 
மணிவண்ணன் சதாசிவம்

