Return-Path: <linux-pci+bounces-16144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E59BF12F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6C81C218AB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613CD1D2B0E;
	Wed,  6 Nov 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8P9A9nV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5A537FF;
	Wed,  6 Nov 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905637; cv=none; b=X6kfm/efIP002ZnNuf2qIJPtlGeQskQls1w2j9RPg4aNJpuOWEAhk7qqT7W8GfsslYmQVubUWh3XIXoAEES5gix4Yxo8tdM1q+8YXvtBAsUZzeLI68/XmoQIP3eI32E70a93sagLASOL2ML52t17Mh2MGsCNVsOn463vFhjEY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905637; c=relaxed/simple;
	bh=gDInCR0wfp7AiDJEzpDPeD8yUHQFH5BwUzUUeMJA2ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7e5DXnif+UUJ7c0CHBXkgXQgk9I6xVrZ6eTdnn937fKUpvwjc/5pyAGYNkVp5kgRAZYX3M/fb4F0cA/5nkjzzPrkpvbTPAXokYvUEEYCDt9goSDxLd7SJymQDmNvap5j74A86wWQHzYjOz0ZTVszicM6ntAi0Wp2L47Ly4A9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8P9A9nV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E28C4CEC6;
	Wed,  6 Nov 2024 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905637;
	bh=gDInCR0wfp7AiDJEzpDPeD8yUHQFH5BwUzUUeMJA2ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8P9A9nVE3+QQ3SCXAqR1BYNeWAHYwHmOkCS1zvzrVj4/6BFIUVP568kUgQjKxgGs
	 rrnSSoA5BdM1UfyRAAmANhUDdQujfQsK75rWy7tEqYx8GR9GQDVgctb45G4mUKALHK
	 QXuSavbKCJ2xdtqHboZuY83779Kdbq8qOWJKL4CXxypZGW62Ch5rDfNG0OuWlxYflq
	 qKeOqk10guCxuYlVro04IMM/JaPBWq1KD8iSvWpMOfSbY8JZfyJTGveNuHORBu0BMZ
	 fAC66Nx3aBtaW4ICC6+2OCXL+6BUEurt1vFQrvRUJtCqTsUuS73lxlWIQvHPIIEFn0
	 TXeQd++ApHfmw==
Date: Thu, 7 Nov 2024 00:07:15 +0900
From: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kwilczynski@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	Frank Li <frank.li@nxp.com>, "mani@kernel.org" <mani@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Message-ID: <20241106150715.GC2745640@rocinante>
References: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>
 <20241103205659.GI237624@rocinante>
 <AS8PR04MB8676B83C73ABBA45A34C58DB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676B83C73ABBA45A34C58DB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>

Hello,

> > Applied to controller/dwc, thank you!
> >
> > [01/01] PCI: dwc: Fix resume failure if no EP is connected at some platforms
> 
> Hi Krzysztof:
> Thanks for your pick up.
> I combine this dwc bug fix with the other one.
> Can you help to replace this commit by the following series?
> https://lkml.org/lkml/2024/10/10/240

Sure thing. So, the following:

  - https://lore.kernel.org/linux-pci/1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com

has been replaced with the following:

  - https://lore.kernel.org/linux-pci/1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com

I took the entire series (consists of two patches).  But let me know if you
want me to drop the following, which is the second patch:

  PCI: dwc: Always stop link in the dw_pcie_suspend_noirq()
  https://git.kernel.org/pci/pci/c/f40d59f309db

Also, have a look at the changes to see if everything looks correct.

Thank you!

	Krzysztof

