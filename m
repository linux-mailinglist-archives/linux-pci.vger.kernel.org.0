Return-Path: <linux-pci+bounces-16854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA129CDBC5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7171C281C6D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74418FC91;
	Fri, 15 Nov 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTF0sIEE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DE189F39;
	Fri, 15 Nov 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663810; cv=none; b=PsQYj26e9nveBlDqKm3s51mt1HV5DB2A3pJun0uIBnGV1vQWkUdxEad4clYq0uIxdXO2ZHQgHyUavnLsA8H22ZdYSoxizcOmgOfRODpey8MkFVOietX3yvN2v59B3Dwk1NYui0FBc4DxiBE7THqXiIc6I15rTr3i+a3x1ViqCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663810; c=relaxed/simple;
	bh=TIZ1sA0O089g/5b3tPIPhS+G4xKmf9BVHAy634nMTf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afd2DAzSlZtvT2uXyBv2x1PJbepK3dWv3r93Il0cuXhOaHXRE3Gt1F38oTJF1yWsQJaDQcHkXVZUgjMG+P3XVqcQ50mI5DijMyaRsFjuOx2eFL8XY5E6wtOf30i0Prw/v7UDhocv55Jd+D61BD7LLbVhtfNPY/1u1pGH58/WeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTF0sIEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54694C4CECF;
	Fri, 15 Nov 2024 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731663810;
	bh=TIZ1sA0O089g/5b3tPIPhS+G4xKmf9BVHAy634nMTf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTF0sIEEkiwN+SWOc3KPKgreUCP9DogNGbhcYrALCbA5tV/sKB49xkHgOX9dVTSfF
	 Chi4u7I1fyHm2jHcs7EgPfz+SB2SHpmOkwtTF8ug9HwluoSPWLB41mz9Y4HnwS8obv
	 GhOAFSIiu5AJnO71ozfi6H2nqqjDc+OZf1e/XI3CKKwBUZ/hBD/BhRPioiqL77dCjY
	 mOBojYC+QPbWy91DOEpW6lFiZqNVEruGNeMFl9brwjQ9Hs5ApB9LSfoZY/G6qQokDt
	 sRgfZTqQ9A0TXDp5Kt1EAJhkqXe9oYupNWRxIO3FPFnU5yd/Ll3C9B2top7PGAG0eJ
	 c6wtd5ykGgH/g==
Date: Fri, 15 Nov 2024 10:43:24 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v7 0/6] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Message-ID: <ZzcXvPGYrzFhOzIN@ryzen>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>

On Thu, Nov 14, 2024 at 05:52:36PM -0500, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 
> This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> 
> Original patch only target to vntb driver. But actually it is common
> method.
> 
> This patches add new API to pci-epf-core, so any EP driver can use it.
> 
> Previous v2 discussion here.
> https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/
> 
> Changes in v7:
> - Add helper function pci_epf_align_addr();
> - Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

V7 looks very nice!

Tested-by: Niklas Cassel <cassel@kernel.org>

