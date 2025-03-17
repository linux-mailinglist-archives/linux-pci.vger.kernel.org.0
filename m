Return-Path: <linux-pci+bounces-23970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7035A65ACE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 18:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1751893B88
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F291ABEA5;
	Mon, 17 Mar 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9PMCKWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E911A00F0;
	Mon, 17 Mar 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232610; cv=none; b=lJuYB1Hrbd4unSIrNF4T+6rBKr6WnIG8OcD9z2YqkFP32r9R85OA4xLb+vON6WO47usbHn+TDk1+Fmsx1gwcBoP39sTAnCeVlCzcEM4K2TGym58FFHiRynQtEj7c6W5NdIOLTGRSQs6d9eDqpX2CWkC1jUdvNOpVbVBcb2KgJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232610; c=relaxed/simple;
	bh=srOc0Uaub0/6YRvw1cYQN4PBXQGkUPQK1F4bq+yDgG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mpuWtM9A+B8pUmwVCLp5KxJtvRxkLL+N7gBAs6pLLdXdIGMLZGshzM9lX5/Pcm8g0MHRv1d6KyT0LZiK77qnOXmG+LIOYg10TASAL8eKw6D3/EuZUDdvV32XRFM+ROTHD3s+YCwXsEGBZaMDiNC45ulMUIa0thRnF+VBpDLgnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9PMCKWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD60C4CEE3;
	Mon, 17 Mar 2025 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232609;
	bh=srOc0Uaub0/6YRvw1cYQN4PBXQGkUPQK1F4bq+yDgG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M9PMCKWa0bj+/nVaCIFk0FoMJUZXz5fwtB08nGvANg8fa+tSb/Ui2IPjY/nYC53QS
	 9LeFzkfiX0lRYjdvjLwxnErliWj5zXn/A8puoJwJ+86QqeGn8dn9YfOXu8wk/BZYVM
	 +oL0FLW3uHGXVApJZKpCPgLRzIF4Chld9ncJVtPoilruw6RyTTwBx7+FMtXfa+J+79
	 nmBcAwHoEP8VzAyKpT7bi52exvbI+Qgdh1rBrVUo2pD4K4XL47rb6BFuK8rO5P1F1S
	 ryNweBX/Kr3+ht+twGVZsqzfJMQ5ez6Bq/26XLYdPdbYeenBf8pP9KmwBQvOCXQ29y
	 QagecCswBBEzQ==
Date: Mon, 17 Mar 2025 12:30:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: dra7xx: Try to clean up
 dra7xx_pcie_cpu_addr_fixup()
Message-ID: <20250317173008.GA933389@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313060521.kjue4la47xd7g4te@thinkpad>

On Thu, Mar 13, 2025 at 11:35:21AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 05, 2025 at 11:20:21AM -0500, Frank Li wrote:
> > This patches basic on
> > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> > 
> > I have not hardware to test.
> > 
> > Look for driver owner, who help test this and start move forward to remove
> > cpu_addr_fixup() work.
> 
> If you remove cpu_addr_fixup() callback, it will break backwards
> compatibility with old DTs.

Do you have any pointers to DTs that will be broken?  Or to commits
where they were fixed?

> You should fix the existing DTs and continue carrying the callback
> for a while.

Any insight into where these existing DTs are used and how long
they're likely to live?

Bjorn

