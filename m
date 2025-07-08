Return-Path: <linux-pci+bounces-31691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E83AFCF9B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC6F1BC7E28
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE972E1C78;
	Tue,  8 Jul 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqXXvbp0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC72E175E;
	Tue,  8 Jul 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989692; cv=none; b=gvrugipCgxEAKlEzXbl7ic79rPC9PrlfaiPyfmN36EdFWh2OX4V6zuUUtoLRYHR51bW2NLfqOdxio1UbL/BRKNt7pJmJoGO5Mp4KuFCT/41oEBEJcHVyxcAjba8CSjvXxWvKoeinN68lGrjBRIFhaPPNB+3MTZcddPN1li4wQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989692; c=relaxed/simple;
	bh=tWWxXLhF9k7Gu3NnvmZwkqT4bKHY1QLga2J8AkBZ/3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RFM4xd2H04RSq8Z6HW9LOz9Bf/N4NslWG8yBvSbRBBU33xH7kEGwN+2UsZ67R8vxywOIcekQqTfzuhnJw1yPkB+E/N4OMWnKMQyasVeH5+PjGnxq4DHAHu6pQTBT+ZexkDb6CKopZYXEYEpudMo2wkQbPVgEYZcBL0Kdz+Np80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqXXvbp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E8CC4CEEF;
	Tue,  8 Jul 2025 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989692;
	bh=tWWxXLhF9k7Gu3NnvmZwkqT4bKHY1QLga2J8AkBZ/3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tqXXvbp0KH/w5rcpoNORi5g5+PyEHhFyUHHZP8tDIPYN1h9/SGeJ8I5Yaom8l/T2A
	 y05ApmDsitoAxyNH4XqRnH2Bs/teWZbQBYhm4rCX2GJZhcvR0ZtRuC3N8dVsFH6COw
	 vlpD9IvbSlg6YBD8FOcYEhBSEJtwknVxKDPoafk0Qj3OXy/8G87lTO3eofRHdtMKZH
	 akMURjHkH0Nsiy4hzJ8pC93lHDT0HgI6IH/+vvGUL4d0GHTjYqP6JHANdsUXb9s2ly
	 WVo0jLOC9Z9fRYLoh18Me/oKsQxk1Q7k5N7Q20as7CDTYas48NrGzB2Xos1ZkdzWyF
	 +gIUGMSE1qMUA==
Date: Tue, 8 Jul 2025 10:48:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "mani@kernel.org" <mani@kernel.org>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Message-ID: <20250708154810.GA2146917@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676B8D14A5C54E8C32025BD8C4EA@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Tue, Jul 08, 2025 at 07:34:57AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> ...
> > On Tue, Jun 17, 2025 at 03:34:41PM +0800, Richard Zhu wrote:
> > > i.MX8MQ PCIes have three 64-bit BAR0/2/4 capable and
> > > programmable BARs.  But i.MX8MM and i.MX8MP PCIes only have
> > > BAR0/BAR2 64bit programmable BARs, and one 256 bytes size fixed
> > > BAR4.
> > >
> > > Correct the epc_features for i.MX8MM and i.MX8MP PCIes here.
> > > i.MX8MQ is the same as i.MX8QXP, so set i.MX8MQ's epc_features
> > > to imx8q_pcie_epc_features.
> > >
> > > Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > 
> > "Correct the epc_features" doesn't include any specific
> > information, and it's hard to extract the changes for a device
> > from the commit log.
> > 
> > This is really two fixes that should be separated so the commit
> > logs can be specific:
>
> Yes, it's right.
> Since it's just one line change for i.MX8MQ. So, I combine the changes into
> this commit for i.MX8M chips.

I want to split them to make it easy for users to understand which
changes are relevant to them.  E.g., I have an i.MX8MQ system; do I
need this change and what does it mean for me?  Is it going to fix a
problem I've been seeing?

> >   - For IMX8MQ_EP, use imx8q_pcie_epc_features (64-bit BARs 0, 2, 4)
> >     instead of imx8m_pcie_epc_features (64-bit BARs 0, 2).
> > 
> >   - For IMX8MM_EP and IMX8MP_EP, add fixed 256-byte BAR 4 in
> >     imx8m_pcie_epc_features.

