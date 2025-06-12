Return-Path: <linux-pci+bounces-29509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FCAD64BF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 02:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C743ACB9E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 00:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71F2AD02;
	Thu, 12 Jun 2025 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzr4UFaQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CAB8BE8;
	Thu, 12 Jun 2025 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689324; cv=none; b=fTcEXSSgA2jbVJaOR3+CNAtDHnyCTu/27XrKnHQqrH5/MPAmxIDr4LUtjlM1kgKeOFu8DtKEEzkR2z7CWyvG4wU4uay2ZjTwgTYc8ZJhCROvQ6fFSv1ljUMFp4CigQccb/PlBN+7Ylj7Hf01upEN4zCs15oAm/lbaLb2K0Xv4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689324; c=relaxed/simple;
	bh=ht1gA/ZPteEMrTAwGuxbLshnWpppVntQPyraSN5yQj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTOMxw9yuasYTN1GTtB9zmVg9C/3SS243Omq/jeVrbjl76RZ6GsTUSEUDCWvkqs8R/ytVoif4ap6ZuijYd8ZS/PvyQS1FCwLZtNIO0tprHS6MJueZrjRsTjmSETK9A8/pS9+DGfjwxXeUJ1SgD430bsiBZqbnkgHpcbhhuvCizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pzr4UFaQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74264d1832eso535610b3a.0;
        Wed, 11 Jun 2025 17:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749689322; x=1750294122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqINRbhBXUv8DDvAKfwGN3D5A5fdVAfIH4y8gA4/FgQ=;
        b=Pzr4UFaQ0c1V5WpJDKxZFd2vMJJXhK1YF13MjlU876scY6FM3HpCDPp0Rjak8OEyq3
         UGJJzD/xvCvDpneSYHLO5tSP05OQuW84phZ8IU5l+yTT/mOIeWjk6cU70sNV1iXwCRlt
         x+G4XMqXyqaDPuUxR7fYGDlCz49PQzMJABBIZJ5F2JiXkVwRa/HAezjFSe2NrtV0jVuC
         /mt8YJ3iDlh25VlazkMh9vWwZCsVq/l07UEuM4lrkTd11pCwPSqTzZ7JGMZuRVtwhGNB
         DPdQdqUqSejH1LtO3HPPeeIzXBm9xugMl1h0fXdtbTVp6nVH/jhajRK1CMv2Ht2cL7P9
         ynBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749689322; x=1750294122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqINRbhBXUv8DDvAKfwGN3D5A5fdVAfIH4y8gA4/FgQ=;
        b=DBfL9W0KY+8NCYyw9O/1hdGlCYY9cunz/wYtFhzKbh5PKX8p1175znNqKDQUc2goeG
         3eTBQi5SnqMR6jTW7hmHsvbuLkhXN2/BbLLHQsTW6kOy5CDCNoSl8H4lsLEeNY6ffdAc
         +rmOvy26K6OBVZ8y6LOkIwj97IHegNVsEmwkJg4oocbdqxUYC0SvQoH//TqY2whhnYpS
         +1Np5HVg0Oon6TYdCCTGwPen4b51y/RNziI81901/GjHUcq7aN2RvyuVDGtuLQ6IOQt1
         I6EmyojX0hvpkFI+3o5m6pRCJcLzNkCj2UlDfiE4ydX5KfsoEwq6IO7+2ZTF2XorkEME
         HiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV74YxXFIN0iXZTkkVbUcKsTohGyCQk/nXvp9LoD1t6fERaMJnobir2ITW1wRMR3EKs4ryoUvwdeVLY@vger.kernel.org, AJvYcCVoR1PQpJt12phcap/7qApSU86nhkTr83hX4sCdK84JMCxyyWy63r/LzfGJgePSSzdb8AMNBsqdeGdk2rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIibJ6laaD42TVmRMB6AI62VxV3uyBiB4CFk7QncksOdCe1W7U
	ad6n3PY/zQA8/M+xnsloc8Bp10MIUNjeXwgHdGU76INYTFpW3ZAJ4fBJ
X-Gm-Gg: ASbGnctVipjhIcv2bLwXruwA6Lw957DldTB65d/NIVW94wps9DZNplxZ3wFITkITS9X
	StIkQlWN4j8Ccki6lcWTk+XCdNXKg7Vu26pqKg3mzm90bEUKMsrHSM9xrUi9XHesIXztQbi3mcW
	8Xpfpd2YHsEUkuL0gzyshFpZVd8M96/2sHDZKve4u62Jf5E6Z95pc4mbkVxQA+luk0t+0pvo2di
	CoiaqqR2VhKINoz5auXRY7UggVfIOplNlnQdyAXfQulRjnVkpFi3luWN63eZG15t7nzhUgsWC9u
	eYtkz8MUXzhOaPtQp0Dor09bEKFy0Z++eh7bpkeLNt1RqtJLlg==
X-Google-Smtp-Source: AGHT+IH/jwJJdwYkzPE0y591nja7/GMlqARzj1ko2DlwznP5A+rVIrdUR5MsMWEBoz/8q6p4qz3Sng==
X-Received: by 2002:a05:6a21:6d88:b0:215:dee4:4808 with SMTP id adf61e73a8af0-21f9b720273mr1173711637.18.1749689321805;
        Wed, 11 Jun 2025 17:48:41 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5f6a::dead:c001])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd611e32dsm221034a12.9.2025.06.11.17.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 17:48:41 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:48:31 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] PCI: pcie-rockchip: add Link Control and
 Status Register 2
Message-ID: <aEoj385BMtLvNuKL@geday>
References: <28ae3286f3217881ae6ea3aecad47ae4567d6ec7.1749588810.git.geraldogabriel@gmail.com>
 <20250611194259.GA825364@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611194259.GA825364@bhelgaas>

On Wed, Jun 11, 2025 at 02:42:59PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 06:19:49PM -0300, Geraldo Nascimento wrote:
> > +#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP)
> 
> I would really like to see PCI_EXP_DEVCAP referenced in the source
> where we currently use PCIE_RC_CONFIG_DCR.  That way, cscope/tags/grep
> will find the actual uses of PCI_EXP_DEVCAP, not just this #define of
> PCIE_RC_CONFIG_DCR.
> 
> Something like this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?id=v6.15#n265
>

Hi Bjorn,

Yes, thank you for the code snippet, it makes things more clear.

> >  #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
> >  #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
> >  #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
> 
> Also use PCI_EXP_DEVCAP_PWR_VAL and PCI_EXP_DEVCAP_PWR_SCL here if
> possible.  And FIELD_GET()/FIELD_PREP(), which avoid the need to
> define _SHIFT values.
> 
> I would do a pure conversion patch of the existing #defines.  Then I
> suspect you wouldn't need a patch to add the Link 2 registers at all
> because you could just use the #defines from pci_regs.h.
>

Got it!

Thanks!
Geraldo Nascimento

