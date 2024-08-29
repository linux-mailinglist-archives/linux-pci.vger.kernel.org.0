Return-Path: <linux-pci+bounces-12461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70BC965285
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 00:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE891F23CEA
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DBC189F5A;
	Thu, 29 Aug 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB2QPmFX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D71BA88A
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968808; cv=none; b=ACXmQ8g46X6uiPS++kKKcHVOFH2n9rL1NiRFA6yAC5AVqlvgO9A13t5vO7Ot1k8jIkt+7fekPgduXrduE1vHEtyyFWa/Koz+mFDmw/7+Jyu2n3z0vV1/60DSrgIuGQrbyVa5nPH4AgY9m+ezGnzc8noCzbQFJOUyRbRIdT4791g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968808; c=relaxed/simple;
	bh=RTPquxCeVcldP0kpJCII9mG/YEP/cKMoCEHAcw9aoZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UHxU4mHvat8wqP74WibmOM5tVVhpF5jOGT9cWw7lhBEUMDh1F95qlSzHiohNFn5k1UD15PsXS4XjiD/E4nCdxFhYsZE6TH9mKisN0piiFH2VqQZvEZ+YFfVHY/Qkeryn/PLLLWuCcVKcLvBRGuim70MRxv+BZUaQ6qN86I0MaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB2QPmFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560BAC4CEC2;
	Thu, 29 Aug 2024 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724968807;
	bh=RTPquxCeVcldP0kpJCII9mG/YEP/cKMoCEHAcw9aoZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MB2QPmFXowkYSkLNmrA3CCVPDO2W4IOxj9T7vXZgQYJVG+rZiiwJlV5zz1LBq/Q2R
	 AB+1L2Wo8MHZQRaZJCcabGDsNglkU/1SLyxpeqDUJLw8x27NXlipwvUa6xa0ds/d/b
	 Nt9KrvYnxtQCH2y4x6UhlY7SZzYdlj0vODJETXbF5mZZWNPHjwlS9acJMPxK/mQKRG
	 hdsDRa1HT/u2RWmkuf3cDgHi+AyaLDJKbqDjXpIVBR+BzkWcC5l+t/xeOcxb9vmEZN
	 1cxZnJ2yF1baw03/Gg5oJzn6vrWSeAn0rmd+J4gjk8mcoqQL8ddp5JeSzQgQUtDoxN
	 LD8A4XQFqOMYg==
Date: Thu, 29 Aug 2024 17:00:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <20240829220005.GA81596@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtDrjl3b8yhumk+A@lizhi-Precision-Tower-5810>

On Thu, Aug 29, 2024 at 05:43:42PM -0400, Frank Li wrote:
> On Thu, Aug 29, 2024 at 04:22:35PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > Greetings,
> > >
> > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > > device and the device is not getting a valid interrupt.
> >
> > Does pci-imx6.c support INTx at all?
> 
> Yes, dwc controller map INTx message to 4 irq lines, which connect to GIC.
> we tested it by add nomsi in kernel command line.

Thanks, Frank.  Can you point me to the dwc code where this happens?
Maybe I can remember this for next time or add a comment to help
people find it.

Bjorn

