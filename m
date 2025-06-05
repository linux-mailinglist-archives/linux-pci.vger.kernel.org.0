Return-Path: <linux-pci+bounces-29030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53743ACF047
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 15:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228E31640B9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C221D018;
	Thu,  5 Jun 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrtwCG/c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815DA1EB5DB
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129751; cv=none; b=bGDEuPLG+9q1w8iOoJHworKtMG2VylsBgRNnSG4E121BANHeP15Od/vX3SNea1qqzL1iXnI9cv5+Lu5MOXOVoTvQ+SdufiYjMISmlX4110Y10f2Sqau5uo3PSozR+IvMdq9BJMGm6rTUWIYIidDjhQwr5d13kBFDUwY7znxNkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129751; c=relaxed/simple;
	bh=aQ8/q8tcWuOSFfCRO1TLmC72YK9TkiiLnPr6X1Ht6hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3YwzF2pIdJ124vrth3R+cZxDaFeHyR6qCbSLbQ24+19HMG+Y82pt5wRVYMMyxIdqm3pxDN+Sf6FnOheogV76SgSA1mWz46lxE8EmB8/nyYkMlxy4QzwdXF+2EplflQzgf/DAP1+anJGvH/iY+9AOFWrkc7oH0VneqmB+ErMJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JrtwCG/c; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d366e5f2so12189135ad.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749129749; x=1749734549; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LV3SY2EwFIN9MVVGnq1S2+QMD2WUzdffJmfnCXZtj9k=;
        b=JrtwCG/cKrHvnOTPc7i2ddxzVtVph3xxJArFouIo4ZW4IhNj1b5Almk661zKueMmKl
         NzaFeju9361XipNvspyNjIqvOc4zekxkiQfm0yfN7LluxS2REgSpG+efYK01x5yIH9J3
         8Tf2igKZhKlOSTkvd5k65EnObbSq7HvYCPCI36fV7wnzaUH8RfEyfjl55xslz/1OQQAr
         8Dm/yfyjZ3CuCxn4onquycUkmKSH3xamSUeNxdqTZxLHe4plLyBB5dmbd9+FgB/YTshq
         IK1kE+614nXP+k2dDqbv8999wO6dxZH6cwCpa/lt6qZn1Kp24U45jtKRVTPNyQQezrbM
         Eupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749129749; x=1749734549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LV3SY2EwFIN9MVVGnq1S2+QMD2WUzdffJmfnCXZtj9k=;
        b=rdCsvFVDqaFB1j7XNjnxvOAVFQXsIB9UWWO+VqooCoNpsEByvXZktlxAd3dd+YWkeT
         qm8iksfsenogeIuOBi4UWWYZwlaCIzRJTpduqATuBkKgowyV0OePTW3GYGjracB42NXq
         B0E61c7KmV3OJd3Bxe6QvBaRDSRl9EiqNWO8F9U5Wkd+MhBoYjwGGa9MSY632LTy/31m
         b4C0DQ1wmv/sM5ZOUA6/69B7yOpEvxkpFKXGR4nFeXxAW31hJqelgwHyT078okrBVkxN
         uRfdUrE7tc7ftEgyr4q/56wznbZwQ1AJEX4zng+B/ykoFg+BtfCLC314/uTyRTvv3Jau
         ybzw==
X-Forwarded-Encrypted: i=1; AJvYcCWuZn7i6tVdqJySPou8eWsHaNTiRbwonxGmNcs9e1L9dlYvUXH2t0Tg6s0D9Ak/XOWi51seoghDstY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuXQqxNKwpaFSKKrLE8FuDm6wGNdZkTuU2gacGnn3r3e74bCW
	4SilRwZVks7f3T5YqtwplBMG8TLmclsZg2bE59jLqu8UjNjc6oDN3fk6DPjKoueWeg==
X-Gm-Gg: ASbGncuIW3QzmfdDFwCfJe2heDFLcmBhY/6yX7Gnae5przSjjVVIXUHslSmdwYRgXyE
	m5nqryZ4KzdfXer5nzboOhVASh+i7CyFzw4j6+R5SPE8x8OVPiM5TtnLVqzdFHKz0z+A9fRKnAZ
	VQIH3nfnxl5+sibZWqPKoLig6zSzWT2tTEPBJaOX6xdDOoJtC+v3u2orr4zfCTDfAmFsIF8UcFe
	nOfBiT7BbOBCXM8n0/bf5VagBjeZYxc9DN8+8TRkJ4YNsnnqvGGMllCyu1MOrdWU/igPk/1KGQI
	EIw1QxZzHpYA/AlwYWda9RC6s20HiWl2sdj+Vn4KBV0+Io7FbnITA5fcOCvWBQHnSV7USGjpZgc
	uD0sO5A==
X-Google-Smtp-Source: AGHT+IFEBRSheUsMgn6DbcDEdV5Hlv1VHBEQineqLpLn6Kld/K5JudvAtaK8XUU4yswu66c9Km4KIw==
X-Received: by 2002:a17:902:d48c:b0:234:d292:be83 with SMTP id d9443c01a7336-235e1016969mr104503775ad.10.1749129748735;
        Thu, 05 Jun 2025 06:22:28 -0700 (PDT)
Received: from thinkpad ([120.60.50.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd8e2dsm119379115ad.56.2025.06.05.06.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:22:28 -0700 (PDT)
Date: Thu, 5 Jun 2025 18:52:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <fgd5dlxthuvjfszidyvcxn4wb37k5hgixvar4wbgofee6knkpi@4xldvqn6x6tr>
References: <rrtrcwajj4vjvbqzosskdnroqnijzaafncgckoh2dlk3c4njvs@twop3vyidmh7>
 <20250604184445.GA567382@bhelgaas>
 <aEGNefEgf56P-mBM@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEGNefEgf56P-mBM@ryzen>

On Thu, Jun 05, 2025 at 02:28:41PM +0200, Niklas Cassel wrote:
> On Wed, Jun 04, 2025 at 01:44:45PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jun 04, 2025 at 10:40:09PM +0530, Manivannan Sadhasivam wrote:
> > 
> > > > If we add a 100 ms sleep after wait_for_link(), then I suggest that we
> > > > also reduce LINK_WAIT_SLEEP_MS to something shorter.
> > > 
> > > No. The 900ms sleep is to make sure that we wait 1s before erroring out
> > > assuming that the device is not present. This is mandated by the spec. So
> > > irrespective of the delay we add *after* link up, we should try to detect the
> > > link up for ~1s.
> > 
> > I think it would be sensible for dw_pcie_wait_for_link() to check for
> > link up more frequently, i.e., reduce LINK_WAIT_SLEEP_MS and increase
> > LINK_WAIT_MAX_RETRIES.
> > 
> > If LINK_WAIT_SLEEP_MS * LINK_WAIT_MAX_RETRIES is for the 1.0s
> > mentioned in sec 6.6.1, seems like maybe we should make a generic
> > #define for it so we could include the spec reference and use it
> > across all drivers.  And resolve the question of 900ms vs 1000ms.
> 
> Like Bjorn mentioned, when I wrote reduce LINK_WAIT_SLEEP_MS,
> I simply meant that we should poll for link up more frequently.
> 

Sorry, I couldn't decipher it.

> But yes, if we reduce LINK_WAIT_SLEEP_MS we should bump
> LINK_WAIT_MAX_RETRIES to not change the current max wait time.
> 

I agree. And I like the idea of having a generic define which Bjorn suggested
for the wait delay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

