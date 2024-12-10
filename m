Return-Path: <linux-pci+bounces-18036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156A9EB76B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E7B162342
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8B231C8E;
	Tue, 10 Dec 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4oOHC2m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D01BC09F;
	Tue, 10 Dec 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850464; cv=none; b=I7T6TzAay0cqg/s0+yeKDcEqS7jsfCUR4oSyH98+3k/F8reyGJ3WGdYDgo5arbWVI3aFnzNm/eIKq/d7px5OLWmyVYrG8nYjpizeM8jvfIYcRkaYqaK3te+eiT2CDBIwLzTAn+KGc2sfeDVmKLaO3wH6yOSVz4aU/wSYDXMdSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850464; c=relaxed/simple;
	bh=u9MJnetCOSpg5jWrnFsACw5xHTd2nsYW5Ji4QQkhZs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SAA4wuM6WakIbL1CPn9+a+iv1SDbME+n6JTqVUwxRFT0S5391ZZdup4NAqnKb0o6Tqi7i59dZMRlRCnQk54IFLRjGuPTABGk6Lz92s6valETkO+Yzo/gaRsMTySrJ3AtTt7w822R8LuEnRua4NDNWHYROIoeE3REn5meLD4zrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4oOHC2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB9CC4CED6;
	Tue, 10 Dec 2024 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733850463;
	bh=u9MJnetCOSpg5jWrnFsACw5xHTd2nsYW5Ji4QQkhZs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C4oOHC2mJoNupUtyKgwAgarXGxPlEzvVxUQxnQID33dd26OB0GklIFttJc2Db6Tbo
	 b/h2xIl1nuv4XUazzr2imkbXUpKfEB9OYjIqHZWn6yN3TL0NCKPv7qS/+M6KcaEIn8
	 VQaimdPX+3BMWxiF5pKr0JOoLsffc3MfvEwUwBY0OJZtWmoU1mqDbhd67d85ttjUuA
	 TQHvv1Y/aw16SlhfmgaAAYcszFNNYZjipRJEcKyg0hYm0Ui9IRCHM6tqW0bSzmTx6o
	 mJdsvQBFYlMwEQ5xMaA0msBrinb31jDzbBtDcMuG0McZZ13klO/gGv3cwN8QMKqe3B
	 jhVe+StiaIYIQ==
Date: Tue, 10 Dec 2024 11:07:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Frank <Li@nxp.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: PCI: mobiveil: convert
 mobiveil-pcie.txt to yaml format
Message-ID: <20241210170742.GA3246646@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4v7ma5bkczhrc4syzahsr2kxg5ulxgmnsfktdrlztjobpdkcra@yppf5e4s5vay>

On Tue, Dec 10, 2024 at 09:42:31AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Dec 09, 2024 at 05:51:21PM -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 06, 2024 at 05:25:27PM -0500, Frank Li wrote:
> > > Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
> > > layerscape-pcie-gen4.txt into this file.
> > > 
> > > Additional change:
> > > - interrupt-names: "aer", "pme", "intr", which align order in examples.
> > > - reg-names: csr_axi_slave, config_axi_slave, which align existed dts file.
> > 
> > Is there any way to split this into two patches:
> > 
> >   - Convert to yaml and update MAINTAINERS
> >   - Update interrupt-names, reg-names
> > 
> > It's hard to review the interrupt-names, reg-names when they're mixed
> > in with the yaml conversion.
> 
> The conversion should result in a correct binding, so if original
> binding had some issues (and TXT bindings often have: missing or
> stale/not-udpated properties), then we expect any fixes in the same
> commit.  New things, not supported by existing in-kernel upstream users
> or bindings, should be of course in separate patch.

Maybe they could be added to the original TXT binding first in one
patch, and then converted to yaml in a second patch?

