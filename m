Return-Path: <linux-pci+bounces-28386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968EAC32DE
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8DD17381B
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DDA4315E;
	Sun, 25 May 2025 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxXNfsiI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66A2BB13
	for <linux-pci@vger.kernel.org>; Sun, 25 May 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748159975; cv=none; b=b2MUjd6iupBVgvkKONKhupfjZElyFOuMIwBbtBexowuQqk7n7iGS1rHUvrI5VUyDdwOp3RXenbFr2giBqzbYNy5savH0G2y3nCPD/xKzFn1FTB5UebmS/SOFq+DVVm3eG7ZUj6VKk/5+mzuUC80AZ4RaScNDA4VgldHJMcrr2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748159975; c=relaxed/simple;
	bh=w+giIiLFG6tsdv3u/JAi7I8sAZi/tewoh+Q3Nb/k7JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jtgw94/AWCp1RDmgpk+YEZAxG4zVEos/EDAv9ZjJtGzBqgp2u4sejxMmGZTZAJ6JqGvZYaZV3cdmrjCPZTLJrVb8l+FYRHd3EjYVCOsp+ZoYOLY5NK4b2HEJKP4fd9ePB0UbxbgueuIUrKjsljEwMsMa+e7c3AP/8y5DsPA4D8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxXNfsiI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c3d06de3so1336355b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 25 May 2025 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748159973; x=1748764773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/zvLKqtAfPfj+meyEvxFMBGG/uoHhAlIpi2hY07UkPg=;
        b=dxXNfsiIC0n3FjOR5qv1l9GzjwZjSz+y81Lj2G8EJnbrbWLxAQjiUkeWVxHe+D6ezP
         W7NjnSSumeV1Kn1dgPrR5GTrjw7BCmsFV6VhOqETHgieVVUMh+AKI8nhuTaQkW7M4Vj/
         luVM8+PhBKOELe0XNmtmUDiH783Sty0MEgCinzSl2vmTgVKhmChwrwbljvWMDJuR+S8n
         tzI5gL9W9896VwJSQkHqM4N/NYf1inhj7EH/egP4q1cUaFyhJl9bXJ+AGygPkumtQGBG
         4zHlYSLSosILW6VJZ5PSlya72zSPAMB524ZfwqhTFmTKs6EmVE+UxJjzTUp5bMejy+uc
         Tg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748159973; x=1748764773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zvLKqtAfPfj+meyEvxFMBGG/uoHhAlIpi2hY07UkPg=;
        b=SIYmADZGxnXP+r/e8JjsqtxPc/z/IErhwYGhHo7SzxzGbqTvKqe1H9NqGnQwZBTSi2
         oy1HgO+w+Vvv2lQYC3z3cJOuuP0A4BeOjkuU3kgmKyRrX0YHHgCUD3brlnZyb+vxV4PS
         bAq+6tld7yiZVA2XazwaQR9OKuIzGqw8XDNBcMfDct7+iDFqboNG9DCYk4qoWu+2KfeY
         NdCjbhu3sUWb3f6C/lAs7IoK9If4SxAXdFVwoBCngG3fWv0m5LdnJObm5FHTP8Qu0xIt
         f84zHW1oFIWEmMXiNztpSjzlCWLjdFydJTyxGNPv9U50LVCDg3/UkghShmUeHkYNnhvE
         coGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3CtYRq9A3EUBGs39nM5lCl04utPMQX9uN7JJSzThLVHZjgA48/ny08kKP/nsqi2NSgKm+nStwdSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpS3+GF4AwMZ1Ixs3s3h3QkuYJ1W5gjQOzSEtpVkw0TOJkU/My
	vwNFs+SWSjvk883QmKT8mjKa19/HR7PRGdlcO1ZdusHlUSo06N/vb+q7sCR4IqmaFw==
X-Gm-Gg: ASbGnctgoEPey3kJJsFTnONmJJK6AhMfZTowSJEHaGzxak8zmNvrFiquEdKn6/2VHPw
	QDW5p3E7OUsvmJ2nbAVfm41PLpYkb+4msIDQOns1RU5uXLEGEYMU5ThJh89LcQF3XEbGO6f2TQM
	oSMEJtpe8q9+aZ1LaJluAraZRX7COyq7I0G1Yjb46AiIYIFfP5kYvgiBc+pvhxbKQb9QhLV1sso
	6Va4k9T4WMiZvqnFP7AKFkcVoIEAFI5gq+N5DjrLmR6+YNDDuWJos2qH9J0aFqNIt6utksMpuYj
	+aVuNQwvcrfS30ZBDxJ2gPMFnvQUTVJk67FQuWIfwkSA+nKLtZMghyFPb3nhXkI=
X-Google-Smtp-Source: AGHT+IHQ9pl075joeeVM1gptl3UdrdvoXOghGj26j+ff4DJOCFvA16VCyVGRaxk2/uo55lAurkiY7A==
X-Received: by 2002:a05:6a21:329a:b0:215:d611:5d9b with SMTP id adf61e73a8af0-2188c240698mr8143808637.12.1748159972982;
        Sun, 25 May 2025 00:59:32 -0700 (PDT)
Received: from thinkpad ([120.56.207.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a95b2b19sm15104473b3a.0.2025.05.25.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 00:59:32 -0700 (PDT)
Date: Sun, 25 May 2025 13:29:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <zxwkdz5udwvtqmhfbfbvugnuplkhq6uyzpsqx3gubyv6zkv6oi@o42zsj2mt73w>
References: <aC9OrPAfpzB_A4K2@ryzen>
 <aDAInK0F0Qh7QTiw@wunner.de>
 <hqdp64mksr6whmncm5dhrjima32v5oyng4ov6hdklcamqtm4ib@prsatdutb5oj>
 <aDCLYl3y-4ktQrjH@wunner.de>
 <6jslic5nfxz3ywllriiw7uw6jwc6iz362nwuane6xam66kbv6a@x6krddl53mkg>
 <aDG-NzeW0fdIwall@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDG-NzeW0fdIwall@wunner.de>

On Sat, May 24, 2025 at 02:40:23PM +0200, Lukas Wunner wrote:
> On Fri, May 23, 2025 at 09:00:27PM +0530, Manivannan Sadhasivam wrote:
> > I thought that it *might* be possible to reset individual ports,
> > so that's why I passed the root port 'pci_dev' to the callback
> > in a hope that the controller drivers could use it to identify
> > the root port they are resetting.
> 
> Makes sense.
> 
> > You are right. We should check if the parent bus of the bridge
> > is a root bus or not.
> 
> Okay, that's simple enough:  pci_is_root_bus(dev->bus)
> 
> > Yes, pretty much so. I could rename it to reset_root_port(),
> > since I still believe that multi root port setups may be able
> > to reset them separately.
> 
> Conceivably, a PCIe host controller might also possess RCiEPs
> in addition to Root Ports.  Those are allowed to be FLR-capable,
> but could also be reset through a platform-specific means.
> 
> PCIe r6.3 page 121 defines the term "Root Complex Component",
> which encompasses Root Ports but also RCiEPs.  So if you want to
> be super generic, you could use that term in lieu of Root Port,
> though it consumes more characters.
> 

We don't have any PCI controller driver incorporating RCiEPs afaik. So I'll
stick to 'reset_root_port' for now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

