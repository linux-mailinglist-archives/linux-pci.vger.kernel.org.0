Return-Path: <linux-pci+bounces-42504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E6C9C362
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B09583431B3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265D212B0A;
	Tue,  2 Dec 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDDhsgxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E763FC2;
	Tue,  2 Dec 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693076; cv=none; b=J5Fsv2IIeGmr5h1eM4aWpejqr2uW0G3+UGfdHq0v2L9xhDf8gzX8BKkwTvBQIIFrOeD8gegZ1M7XBesIjwuDjtXRdFUdzsE7jmTJtNe0SUd6DH3xG8nyPvBYNvnuQqd41o2uHLwyPN17yRpPYOAaFnUJWMnsfkQA5CSDE7nr/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693076; c=relaxed/simple;
	bh=sYyyeu01r9nTnopkdoe3Q+H+YBGvXq9b3XEXUU2b3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WGYJSBluFzx1h30AibFf5lgmmo2izfRjnXB8RgvwI2ppy2m5m15k0mtfWur/E0Ih5Kgorp+l8Ba6arWezdFxdxGexevyNnkMsT22oITvNnjHyYhX1dwm3qgBfPNWPl0fZRud2CPISrb9bq9LcEBq8RJQZ+JBOCHDycHWQTU5haE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDDhsgxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFCBC4CEF1;
	Tue,  2 Dec 2025 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764693076;
	bh=sYyyeu01r9nTnopkdoe3Q+H+YBGvXq9b3XEXUU2b3LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eDDhsgxAJq/061wE/XBrP2wIWjI0YVdZXK3gcIEa2959edzNaO3yDn2i1k8guLIq4
	 mFsJv/HRIUue/z5UPcELnk4OQz9Fpee3kDyZfGC2lbeLCPc0uhjrgL82k2naFX2tYS
	 prt9gF4R4sz2KNKeUG2A/XZG1wSXNAjVCQf6fd44ZT2hgvfg5L0LrXKybTkVPtKnBK
	 R9rDH/T6n0dHHTVE+xptn54ucazdNbYMG9JAPTDbQEFg9aVuPmBob0FlUuVdwdLX6H
	 l7VXa1arMYc6jg6J4L6mjHBhXns42MfUlGL58lu+AUtHc+u8uopUlG/Wj1ywzZvNsw
	 DZTlHCc4QG82Q==
Date: Tue, 2 Dec 2025 10:31:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Message-ID: <20251202163114.GA3075889@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB09816DBC8A88CEC939C8968482D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>

On Tue, Dec 02, 2025 at 03:02:48AM +0000, Kevin Xie wrote:
> ...

> > > On Tue, Nov 25, 2025 at 03:55:59PM +0800, Hal Feng wrote:
> > > > The "enable-gpio" property is not documented in the dt-bindings and
> > > > using GPIO APIs is not a standard method to enable or disable PCIe
> > > > slot power, so use regulator APIs to replace them.
> > >
> > > I can't tell from this whether existing DTs will continue to work
> > > after this change.  It looks like previously we looked for an
> > > "enable-gpios" or "enable-gpio" property and now we'll look for a
> > > "vpcie3v3-supply" regulator property.
> > >
> > > I don't see "enable-gpios" or "enable-gpio" mentioned in any of the DT
> > > patches in this series, so maybe that property was never actually used
> > > before, and the code for pcie->power_gpio was actually dead?
> > 
> > pcie->power_gpio is used in the our JH7110 EVB, it share the same
> > pcie pcie->controller driver with VisionFive2 board. Although
> > JH7110 was not upstreamed, we still hope to maintain the
> > compatibility of the driver.
> 
> Sorry, I missed the background information regarding replacing
> enable_gpio with regulator APIs. I agree with this change.

OK, thanks.  I would still like to have something added to the commit
log to the effect that this change will break any DTs that use
"enable-gpios" or "enable-gpio", but that's not a problem because such
DTs were only internal to StarFive and we are OK with updating them
and dealing with the fact that the DT is rev-locked with the kernel
version (old kernels would require an old DT with "enable-gpio" and
new kernels require an updated DT with "vpcie3v3-supply").  Or DTs
using "enable-gpio" never existed in the first place.

Or whatever.  I just want the commit log to be clear that
"enable-gpio" is no longer supported and "vpcie3v3-supply" must be
included instead, AND that you are aware of the breaking nature of the
change and here is why that's not an issue.

We can't make kernel changes that require end users to upgrade the DT
when they update the kernel or downgrade the DT when rolling back.

Bjorn

