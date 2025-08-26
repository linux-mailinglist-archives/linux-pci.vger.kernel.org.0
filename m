Return-Path: <linux-pci+bounces-34780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF47B371E0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 20:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953C5361372
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68412EB842;
	Tue, 26 Aug 2025 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1kuqozv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205072A1BF;
	Tue, 26 Aug 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231374; cv=none; b=R/TVkQ2cot8yohKIeTsswhW27Hu9dm9/hCXAufv5kKGbClPS87pbv/sWLiITkxzX5bFbWz5tWU8GxvasNL3sx8ZV6jN4NsDKFW3RXgQ2R7L30naWzN5ArfRsgNLoNPIhmavOsNcpiH4wq9zrSd+S2+NVDaDDZuSiWOY7ELIznfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231374; c=relaxed/simple;
	bh=nN+JXGtLv6FAmp7l5uUi9ay3zxxMghgbZJFTQ0VOnA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3YwlUH2mLWGiZmSgui1O686+fY7YW4+pn5W0RoYV0MNW1r5iKsjui6rwol7LFr1+crZl8Q3fe7QoU8p+Qt8wH2W5H14vmT2AQSeZfg/jMsl6ID3zYCMWAewUdNVSBMhlIRxAeupyISSQHflPSAIEvG9dI2d7FG0tmueiw3ew1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1kuqozv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c7942597fso325299a12.0;
        Tue, 26 Aug 2025 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756231371; x=1756836171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=frdIV1iQvKE8YoiaFFUhu1zx8g8gWtw5/3M5juOru80=;
        b=j1kuqozvd5rkEBYpZiD72zd74iXjzUoWDGvxUIAdOqOe7cRTtRTZTCObTnCYirZOUv
         OFBgj4WFFSO806BaCVOxq4LN3JU2vI86AltxX72q0Ppdk6hzFa4Xa4qRIWwB9d9mSbhu
         oZgayRH6HyxjptYmup8QawmjNDPPMJKuGaY15VfbEHrelXDaxBFEb5DgJsoKexNNxoKO
         Lvqomwi7dEiad18vLuCZWgeNxGv/p7CbiTTny5avU8zEg151KVaGRh/iFHzisjuVtNx6
         6Gq9CimmpmAcq2Tl7wu9JDvB+mEGsOnFvh3J9kaIM4UIzmAOkULDSdUio8vR8wQB+r3t
         d3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231371; x=1756836171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frdIV1iQvKE8YoiaFFUhu1zx8g8gWtw5/3M5juOru80=;
        b=B19BDNGZRga+9nauiN7nvHZYN09scQLlceW04VwDaH2YvB2chVIoudz1owbcxQaaVk
         Bj0cNVhnHPQDSfk7CrruAizB7cfdXiPnYDdfynBVSp2ILnVKpan6H5MNi5Ut/VJW53IK
         Hs6UoHj3IAOm4W1DEqY0VXuek+th0Yq6ZncEBU29Hd4ABRigozYzqGOir03lL55IqXmB
         /uCICXVZe5i3rM0LtDPl+U0Bctv33GhYaCAA/9i+MUq02EGA7ON93xooOIbbhNfQXEx2
         jJyoyhMqdCKgMTmaDLwlKQ1jfgo7kH8dyXmv/JkEylmOtB7c/xlFHIil9VUgAC7i3n0u
         bC3g==
X-Forwarded-Encrypted: i=1; AJvYcCVpQl2QGeH4YGTI2X5dMyql42gnMX3MSlF5618Oi6BO2r+Os+e2UwZThgiXTL5SeRuVSx9+7ggIqSmg37Q=@vger.kernel.org, AJvYcCVsmU5h4TnUVpBcUXHPBXaMtaATtzKS6X8kwwbgT4g5QRO8f8JRPhNI2aBphaIDbW7EWDoH2zuBO2f8@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLOFOKGSNtAVQDUtMT4il8bVzLPBeRpS+L1mPSYWfp8imryDz
	ofpzn/gboXYR7EaH9tbS8jEPhF5dSNj5x149eSPaJXkO8GSBtxn7L1eXPsFE9UrMmQC9NsD5ihx
	lWSDXPVi6yKlBKKQVowDnoV+GwA3R5QWwwQ==
X-Gm-Gg: ASbGncvqV/YY8s4mXwGRmEKYq05Z+GlBKd/oo5OQpIYiQayEvU4lslWbDQBBRRjprab
	/JKL5IisugZLW4lGorsDxULHUBxVl1th22V3gNVxY6SVQjzd2U0+chWuHprVbgTTxpJqevYdig9
	V6UamSuQKshFmuk14WZXm37A9VOpZFmxjIAFYjMq8UsuydVqBl/Pkay2mW9RJI/aRHJovkjf8YJ
	1q4Sg==
X-Google-Smtp-Source: AGHT+IEvDyteju1wmrBwKOW7zwP6gU8uRbga9lkT7PwM/wFZQpYDC2ejx+oehKqgA/VFrqduChNr1Jym6+elWGaqlqg=
X-Received: by 2002:a05:6402:1d31:b0:61c:b047:c2ef with SMTP id
 4fb4d7f45d1cf-61cb047c362mr94534a12.8.1756231371200; Tue, 26 Aug 2025
 11:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826114245.112472-2-linux.amoon@gmail.com> <20250826162522.GA838733@bhelgaas>
In-Reply-To: <20250826162522.GA838733@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 26 Aug 2025 23:32:34 +0530
X-Gm-Features: Ac12FXySIlLJCXOCO_Avwabf6hGll28sxAWglPGaz4lmIjznEhsDC34m8lSwvj8
Message-ID: <CANAwSgTLS+fNTUrx4F5G_5BrFwoq9vixDAFervqokDgJxPhP2Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI: dwc: histb: Simplify clock handling by using
 clk_bulk*() functions
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR HISILICON STB" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

Thanks for your review comments.
On Tue, 26 Aug 2025 at 21:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> In subject, remove "dwc: " to follow historical convention.  (See
> "git log --oneline")
>
Ok I will keep it as per the git history.

> On Tue, Aug 26, 2025 at 05:12:40PM +0530, Anand Moon wrote:
> > Currently, the driver acquires clocks and prepare/enable/disable/unprepare
> > the clocks individually thereby making the driver complex to read.
> >
> > The driver can be simplified by using the clk_bulk*() APIs.
> >
> > Use:
> >   - devm_clk_bulk_get_all() API to acquire all the clocks
> >   - clk_bulk_prepare_enable() to prepare/enable clocks
> >   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
>
> I assume this means the order in which we prepare/enable and
> disable/unprepare will now depend on the order the clocks appear in
> the device tree instead of the order in the code?  If so, please
> mention that here and verify that all upstream device trees have the
> correct order.
>
Following is the order in the device tree

       clocks = <&crg HISTB_PCIE_AUX_CLK>,
                                 <&crg HISTB_PCIE_PIPE_CLK>,
                                 <&crg HISTB_PCIE_SYS_CLK>,
                                 <&crg HISTB_PCIE_BUS_CLK>;
                        clock-names = "aux", "pipe", "sys", "bus";

Ok I will update this in the commit message.

Thanks
-Anand

