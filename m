Return-Path: <linux-pci+bounces-25010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98AEA768D3
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030441890F2C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97856219A97;
	Mon, 31 Mar 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BzEI8m5B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B8219A93
	for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431978; cv=none; b=UGEp3xuB6m0wPatzAGmPkEDpF7apufDuRnnISinIbyZQzuAE6FslDY4KSheKhJLMiTZrfsoVld10xTwY9wOCOCmuQys5S9CmWKZf0SMU3DyL054ebRsYCdMU4erCnqzfQTtIyx+LTIYixZrQx1yGtBFdNTnsWaT9AdhRHKji1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431978; c=relaxed/simple;
	bh=ibQs+2z/9wxImQljXJmUepINT8PM9pQOCQn3UePZQE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hi1VTRfTVOUx8PyOY8OAitVFrHrJw0tNwnNUYfShR6qWXqlG7iLnQLz4Bpr3ANwMc4p01nFZWAPgssLQrNcyHXSjRV0wRNUlrKuiPSHGCrmt43pYu5Vudiq8b/FIW4YznVRvByhY4SL0Y7PCidxHITFsdshIkWTkr8kBdficq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BzEI8m5B; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914a5def6bso2546443f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2025 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743431974; x=1744036774; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aH1MmO7i2EM9dG0Zv4KTfxBqqxe5CAwWZFTr2eT74Go=;
        b=BzEI8m5BQntZAzZFPxHnumOh3BXc8a+JgY1ZZ+upLKvtad7mKJu5NBZpu3XlVxMwNB
         /og/8oUR646h2iuBovc9LyqWJdPor+a91w5tH+wYKbJc2TjawQzT9B2e57CJ7EvM5Tko
         uLysYOe0cvEuRAWF9J+C5Cxf282yrjBF+KRAKov/z1xUMQWsX72I1IuPwHGSzsdBpeMZ
         OHHSmgQoXm/RTGFXMFdJMpTmggXe8zkO6jEupLg+VELMrJaCo02QjgISZnUtctoa3sBh
         NgyU9vMrmeIySDJv7b6YqE+ip8tUQgxFtsqixxgO/V+RqUtj8yj/20WcwsoJ9L452ZSI
         sfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431974; x=1744036774;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH1MmO7i2EM9dG0Zv4KTfxBqqxe5CAwWZFTr2eT74Go=;
        b=Za920aSCoHaZdWVBcbBsWGpahmoqF+7VOhp/CDNt9FL6Mu0vRersaXfCLVSebKR9Vn
         OhboegcZCh4Amh4hMWyE6voM8G7mcYU/tyEoIrdOrbC1vn5i0Nj2E0Cx1I2v6Kng5A5I
         O2orJ8GD/yUq/gLd9MWEygFtwVnomxR2dx2X4ZXWVofu9kYA3LPJIb1XkZcgomrJikCN
         6YFRsCPXQ1DqxoXcTC4ch/btrJAdXTJ2Yrxb8BkvFzSIWp1nGXrlIGZGi0oPCDIHAG5u
         iSaqEsHiEtb1NPiRQAP4fewqDN+l6oASV42jXU9rt/r5D+2nEPidX9MX9q5QHHi0zpKx
         C+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUCNaVFpL3zFSDlAtNpp/yd+8T+elcTz7gZvGK/I01d2nHS3udnHuo9XnNXMte9lHvtfUKd/N2CeLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4s3NflFOwhMElFYH95g1UGxmTPGlxohT1/zr2sTgVESx/VJg
	ta4PQ4wsjgvXQJieEx7rT2xTG9O5Zi4AA1+QJtWeF7fV4bQk8IHUFKE/xC+LET0=
X-Gm-Gg: ASbGncvyg7+fIK1ay+Rz5cql8Bah5sU6P7nQHg74UsqFTWFsp5A77fXSNuWftFUqju1
	PW4YasLw5BTorSvvS6ExtahTSco27yv04miw+FY5ZrhIiyekyECr3lovhpLSoCnLU48VRX6YEOO
	tOaKB81+7lQGbKb9PAfKhwmAqgYcEVA7PKWKrhG+iYpeMf005VYw5lROOAdKnczsycJS0WdYJgs
	BvdRIoWPRgr8fP+aALwSpu4wjbFa49EdaVhx/X06P0oZ0nzWRrDuN8EWW+jRiNGGLfDWS3A5bj8
	3i7FgTNP2roTsrqQNzDdgwU3iiu3AzbuUbBdFjCaJLvQ
X-Google-Smtp-Source: AGHT+IEQ/uIqH9TixYrcpDyssxC9uv+FPOAFMaFbCicsPzmrZZQcMc04/p5NwViA6XXeBDzftKYg8w==
X-Received: by 2002:a5d:6d8d:0:b0:39a:ca04:3dff with SMTP id ffacd0b85a97d-39c1211805dmr6850731f8f.40.1743431974481;
        Mon, 31 Mar 2025 07:39:34 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:93ce:f27b:6168:641b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b658b7bsm11306445f8f.20.2025.03.31.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:39:33 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,
  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Jon Mason <jdmason@kudzu.us>,  Dave Jiang
 <dave.jiang@intel.com>,  Allen Hubbe <allenbh@gmail.com>,  Marek Vasut
 <marek.vasut+renesas@gmail.com>,  Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>,  Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org,  ntb@lists.linux.dev,  dlemoal@kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: strictly apply bar fixed size to
 allocate space
In-Reply-To: <Z-pO_c2zXxDqvIsU@ryzen> (Niklas Cassel's message of "Mon, 31 Mar
	2025 10:14:53 +0200")
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
	<20250328-pci-ep-size-alignment-v1-1-ee5b78b15a9a@baylibre.com>
	<Z-pO_c2zXxDqvIsU@ryzen>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 31 Mar 2025 16:39:33 +0200
Message-ID: <1jwmc5tgbe.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 31 Mar 2025 at 10:14, Niklas Cassel <cassel@kernel.org> wrote:

> Hello Jerome,
>
> On Fri, Mar 28, 2025 at 03:53:42PM +0100, Jerome Brunet wrote:
>> When trying to allocate space for an endpoint function on a BAR with a
>> fixed size, that size should be used regardless of the alignment.
>
> Why?
>
>
>> 
>> Some controller may have specified an alignment, but do have a BAR with a
>> fixed size smaller that alignment. In such case, pci_epf_alloc_space()
>> tries to allocate a space that matches the alignment and it won't work.
>
> Could you please elaborate "won't work".
>

As I explained in the cover letter, I'm trying to enable vNTB on the
renesas platform. It started off with different Oopses, apparently
accessing unmapped area, so I started digging in the code for anything
that looked fishy. There was several problems leading to this but it
ended with errors in pci_epc_set_bar() as you are pointing out bellow.

>
>> 
>> When the BAR size is fixed, pci_epf_alloc_space() should not deviate
>> from this fixed size.
>
> I think that this commit is wrong.
>
> In your specific SoC:
>  	.msix_capable = false,
>  	.bar[BAR_1] = { .type = BAR_RESERVED, },
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
> 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
>  	.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	.align = SZ_1M,
>
> fixed_size is 256B, inbound iATU alignment is 1 MB, which means that the
> smallest area that the iATU can map is 1 MB.
>
> I do think that it makes sense to have backing memory for the whole area
> that the iATU will have mapped.
>
> The reason why the the ALIGN() is done, is so that the size sent in to
> dma_alloc_coherent() will return addresses that are aligned to the inbound
> iATU alignment requirement.
>

Makes sense and thanks a lot for the detailed explanation. Much appreciated.

>
> I guess the problem is that your driver has a fixed size BAR that is smaller
> than the inbound iATU alignment requirement, something that has never been a
> problem before, because no SoC has previously defined such a fixed size BAR.
>

There is always a first I guess ;)

> I doubt the problem is allocating such a BAR, so where is it you actually
> encounter a problem? My guess is in .set_bar().

pci_epc_set_bar() indeed. It seems the underlying dwc-ep driver does not
care too much what it is given for a fixed bar:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-ep.c#n409

>
> Perhaps the solution is to add another struct member to struct pci_epf_bar,
> size (meaning actual BAR size, which will be written to the BAR mask register)
> and backing_mem_size.
>
> Or.. we modify pci_epf_alloc_space() to allocate an aligned size, but the
> size that we store in (struct pci_epf_bar).size is the unaligned size.

I tried this and it works. As pointed above, as long as pci_epc_set_bar() is
happy, it will work for me since the dwc-ep driver does not really care for
the size given with fixed BARs.

However, when doing so, it gets a bit trick to properly call
dma_free_coherent() as we don't have the size actually allocated
anymore. It is possible to compute it again but it is rather ugly.

It would probably be best to add a parameter indeed, to track the size
allocated with dma_alloc_coherent(). What about .aligned_size ? Keeping
.size to track the actual bar size requires less modification I think.

>
>
> Kind regards,
> Niklas

-- 
Jerome

