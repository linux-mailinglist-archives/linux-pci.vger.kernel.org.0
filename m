Return-Path: <linux-pci+bounces-10835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CB93D243
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 13:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB7C1C2095E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804FE17A594;
	Fri, 26 Jul 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmJSg2fq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448D17A592
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993358; cv=none; b=RMtohHlCR+iVh7DCK+VDL56vzESts2K/ryRSEVqby1qAvYPUm4AsmSd+s6qGo4qjPBcYUMD82W9i9YUJ33GXKoZZwc6XYUnZqtOJ+oVPHU0Gkwoa3ILhGnXQIvjMLW2enaVE/DP9Xft7dh6kT/JM8CBIz0tFSp0sek55Rago4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993358; c=relaxed/simple;
	bh=RxOOkJcZAL4WsVg/ghRNc/HVKUmmoDMilPCG5LFbDXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbui3d64X5+25JoTuR+9WepwYLzHXPqj+vvTa1Nrzi+aE39JXJsK85IskYs0UD9DTdewzrjPj/4YR8toD+addzq+Y3UpFDxDkSLFuaPJJbmH2WjYGRHgUH66UMGSfltLWsu0nTbaMciNAKPBikJnVP3tRjwK92QTQogagr41gCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DmJSg2fq; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260fed6c380so617303fac.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721993356; x=1722598156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pMo9hnCsfCWC5yCW0LsA7qSwE8GBkpBYaL6nIMUWJw=;
        b=DmJSg2fqRdY7AkBwn35nGx3JgLvVKJfQmWQwNRn5DLAIQsdPfAxMQcXaIhNgxuL8Wl
         GiMv3rWsZ+mYjpVLv8y2JWZ0dtz4CVXkRJMOHxZrAgUeMvDtB/hVcQZkSigkDcZKkKT5
         FJqq8eoBTYsLoyKXErx8L6713NjIJIn/sVf9cpgAjNAkB8gK9B9OehSP/Oi1KzHhePEb
         NV10y8/uJklb1es56hENK07zy/TQnhpwzdfcb/AFqmPerHG9sZSM44AqkEg093JtXVxq
         Wkyxfm/CYdmjd0iQyomeFdWLg5vVbhA/BhTnGg0EZjNujdxcM4jYPGFABOtYqbS14H0H
         XLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721993356; x=1722598156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pMo9hnCsfCWC5yCW0LsA7qSwE8GBkpBYaL6nIMUWJw=;
        b=Mc9UZvvP0NOfqrXQ+TNvllw5tr8h6BJzWUUFKqWhEGTGIOpm78qLD/2wJMSP5x6S7o
         mTXlXrC1bZ/3gIwXkAwx+2y3hwJIM3o5hqXD2MIIbRlBgLvMDPj3uM+PQrwUtaS7UnhK
         BVU83w61WuVKZBKqwdqLjjc9tpGVzGKtclDq+HPOAArQza5N6l5XD3OLXEXw6s2Mulej
         WcMljmpUegz5eregSppPFyKBFhgImTLI3R5dN5d9/cLtBCRZ1LdJFBR+JrHcjA71/caj
         tZfXzPFSWt3AFcd09PjsWH8UCJJmpbiCf9cJt6x7rXhBj34uzL0Uba3SaYFGSpP2nwAA
         kLcw==
X-Gm-Message-State: AOJu0YzwdFjovsT4IpMp2BFVOH+2la8VVX9VG9sPeQokkedflJEQq6Wi
	TPHxgqnYMukd7JDG43vHUUJBj6BCztHGVc7GGhOVoxJNb+Wf9gHaXk1ym8qJbQ==
X-Google-Smtp-Source: AGHT+IHlT3OKls4LvpPPy8CgLAdDtpss7juy+jjswU+eANQFxUOYsClbebRinrzw6khsoRCjIBzBOA==
X-Received: by 2002:a05:6870:71d2:b0:261:17e7:59b3 with SMTP id 586e51a60fabf-266cc2e479cmr6205616fac.3.1721993355965;
        Fri, 26 Jul 2024 04:29:15 -0700 (PDT)
Received: from thinkpad ([2409:40f4:201d:928a:9e8:14a5:7572:42b6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8834b1sm2581413b3a.178.2024.07.26.04.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:29:15 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:59:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/12] PCI: brcmstb: Change field name from 'type' to
 'model'
Message-ID: <20240726112907.GD2628@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-12-james.quinlan@broadcom.com>
 <20240725045810.GK2317@thinkpad>
 <CA+-6iNxWz1aJr2rHJKSpXaD1raUij-P_Xo9a6MvWJLae1_m7oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNxWz1aJr2rHJKSpXaD1raUij-P_Xo9a6MvWJLae1_m7oQ@mail.gmail.com>

On Thu, Jul 25, 2024 at 04:38:12PM -0400, Jim Quinlan wrote:
> On Thu, Jul 25, 2024 at 12:58 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jul 16, 2024 at 05:31:26PM -0400, Jim Quinlan wrote:
> > > The 'type' field used in the driver to discern SoC differences is confusing
> > > so change it to the more apt 'model'.  We considered using 'family' but
> > > this conflicts with Broadcom's conception of a family; for example, 7216a0
> > > and 7216b0 chips are both considered separate families as each has multiple
> > > derivative product chips based on the original design.
> > >
> >
> > TBH, 'model' is also confusing :) Why can't you just use 'soc' as you are
> > referrring to the SoC name.
> 
> Hello,
> 
> Well, the "model" we assign is not necessarily the same as the SoC.
> If a new SoC has the same characteristics as a previous "model", we
> will not create a new model but rather use the existing one.   For example,
> the bcm7216_cfg structure, which is for the 7216 SoC uses the model "BCM7278".
> 
> I agree that this is not crystal clear but using SoC could be
> considered misleading.
> 

Ok, thanks for clarifying. Still I think you can use 'soc' prefix.

For naming, how about 'soc_base'? This specifies the SoC baseline used by *this*
Soc.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

