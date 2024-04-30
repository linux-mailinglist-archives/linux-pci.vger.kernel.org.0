Return-Path: <linux-pci+bounces-6868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE238B74BC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4251C226E5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9613D25D;
	Tue, 30 Apr 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwR7P75X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85413D25F;
	Tue, 30 Apr 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477368; cv=none; b=jqNF8j2huYBwz94X3gGJxWq6O15gGPBKUWN+VIosTjTTlryA57b3b4GoHY0VTNDar7Nhlr6AmyVT17xrxwruIKh9RQzitJbn2oBsXnzhJoZ3iCSJCY7k0AUoi3phY4V+gMzgWejEgY7NOgLp3QqTylzSssD8yHykGAEezN9f2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477368; c=relaxed/simple;
	bh=VaIaxDUSfC9tPdxaV5FO7mC+kHCogNIyqCj6cKrFrh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wtw17ciU1V5SamYs7dvoblTxWmP80lS6myV6cATyHKdVnKuPNQM8K1vRN4td0TSxN0PLtDHSCrITKhz8u/0imA7woTABT5j28vDoBgz0uPEGqF7ZZkzACaUk8qP4QxYHRsIkqMIe91OtxYI9AzPeV8OXL1CScn2Vtvv2Ao076yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwR7P75X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03162C2BBFC;
	Tue, 30 Apr 2024 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714477368;
	bh=VaIaxDUSfC9tPdxaV5FO7mC+kHCogNIyqCj6cKrFrh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwR7P75X0Imgr4j4coJaR0fUmXMk/XWFhO9g6AXVFZkyPKGnVVwCwSKPznhae0Otj
	 XK3c/7KB2r44y8q46Ees4Q542PhrivwpcN6ldjEM+8MFFkbjQO2SQflhZl2RojCWQc
	 NHPQ6DmHoH9Ou95U7Gaud6fu88w1Teo0vy7OZx+k5j7HSNxm9q9ll/nuYAD5bmMGEl
	 J0o8DQDXoKp8I4vTY/BThCITEPfci1rEr0NdKeNiriMZuOUdL5uAcTVncE33qEcbRn
	 nUoracT6+q2Fv8tPLFZXx2N90gH7YD+6cdqKZ93qSJSBz/DcuW91J3K5nlU1g+1ZqY
	 gqoZ2aJMwJeVA==
Date: Tue, 30 Apr 2024 13:42:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 10/12] misc: pci_endpoint_test: Add support for rockchip
 rk3588
Message-ID: <ZjDZMeNGPA6rCr7O@ryzen.lan>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
 <20240424-rockchip-pcie-ep-v1-v1-10-b1a02ddad650@kernel.org>
 <ZiqsJZh5SV6q33Fz@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiqsJZh5SV6q33Fz@lizhi-Precision-Tower-5810>

On Thu, Apr 25, 2024 at 03:16:53PM -0400, Frank Li wrote:
> On Wed, Apr 24, 2024 at 05:16:28PM +0200, Niklas Cassel wrote:
> > Rockchip rk3588 requires 64k alignment.
> > While there is an existing device_id:vendor_id in the driver with 64k
> > alignment, that device_id:vendor_id is am654, which uses BAR2 instead of
> > BAR0 as the test_reg_bar, and also has special is_am654_pci_dev() checks
> > in the driver to disallow BAR0. In order to allow testing all BARs, add a
> > new rk3588 entry in the driver.
> > 
> > We intentionally do not add the vendor id to pci_ids.h, since the policy
> > for that file is that the vendor id has to be used by multiple drivers.
> > 
> > Hopefully, this new entry will be short-lived, as there is a series on the
> > mailing list which intends to move the address alignment restrictions from
> > this driver to the endpoint side.
> > 
> > Add a new entry for rk3588 in order to allow us to test all BARs.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index c38a6083f0a7..a7f593b4e3b3 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -84,6 +84,9 @@
> >  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
> >  #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
> >  
> > +#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
> > +#define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
> > +
> 
> Did you make sure 0x3588 will not used by other production with vendor id
> 0x1d87?

Hello Frank,

I do not fully understand your question.

Vendor ID 0x1d87 is rockchip:
https://admin.pci-ids.ucw.cz/read/PC/1d87

https://admin.pci-ids.ucw.cz/read/PC/1d87/3588
is RK3588.

This is the PCI device ID and the vendor ID that the device will have on
reset. So since rockchip has put these values as the reset values, and
they appear in the PCI IDE repository, I assume that they should be fine
to use.

I could not find any other Linux device driver using this PCI device and
vendor ID, if that was what you meant.


Kind regards,
Niklas

