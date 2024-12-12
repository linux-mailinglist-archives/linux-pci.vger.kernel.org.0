Return-Path: <linux-pci+bounces-18231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5329EE1D2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0071284038
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 08:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43AF20CCF7;
	Thu, 12 Dec 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOh7GoPJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77320C499
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993394; cv=none; b=ML8QrXxM+cqAmDuzqRdJt/UPkhKGeBh8KALM8APsOo5B1rZrxCkNqGrM6x0Y/kVCr+nzZvIsBxsTREVhx5Z4zeSS0gjG7A7eieeZCWm/7KRk3gD5lt7cRpLEm1+GVqccDFWqjlrq1X81OdD6S/E/O0opbfZLV02sjx/uofWMEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993394; c=relaxed/simple;
	bh=wfqN2YWObJo04YVuY2Y/ZCDx4YrFc+7UszZLtLbhAf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGPspnmK0QL6TxevDzBMMnFyBilSuxB+njpUB15KFMspzme0iTOyIU6DtiiClfBtvehZTUFnhlcetX3FF14fIlsvaeuD65ALiJ1S+Mny78/kxfXCdeVjVVWpg8+yqnXolWSn3ipaYQXVtcUj4gOuGpDd10en8LtaRvuEF4vrGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOh7GoPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15C6C4CED1;
	Thu, 12 Dec 2024 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993393;
	bh=wfqN2YWObJo04YVuY2Y/ZCDx4YrFc+7UszZLtLbhAf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOh7GoPJ4LIiKtioglL+wFxQTUH31Gc4iaVp8WwgPKe61Y398MDBMd7JdpvXI+f4S
	 SIB7pp0fFTZDwp54bugaWjdJwxv0cdy1LcfJabYH4qlJPzYZkqSDFEjPNVkUrOOWbn
	 G1KSCedcnZ9CC/7l3ICnjY56qvY5D5q/CIQkVvEjCmYiSkG/4uHd64tOsPoQaaEMDO
	 QODzuvF7W/wpOcpC5q5zCuhwfuePnHN+4RDd+1/wLdd2iz7IZbQKzags9kSrXl53hY
	 vShN0X9+xuhW4hABzaQ5yZ1wjh8rEK4DRoFRr86jNYoqL8i4lwIXgUHnQE1sZkremK
	 wFHYcQAwVOs4Q==
Date: Thu, 12 Dec 2024 09:49:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <Z1qjrG2vRh8rZDv-@ryzen>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-5-cassel@kernel.org>
 <20241130081245.2gjrw26d5cbbsde5@thinkpad>
 <Z06MXj2K4dcWMZff@x1-carbon>
 <20241208124208.wopm6jprp4cjs4ob@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208124208.wopm6jprp4cjs4ob@thinkpad>

On Sun, Dec 08, 2024 at 06:12:08PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 03, 2024 at 05:43:10AM +0100, Niklas Cassel wrote:
> > Hello Mani,
> > 
> > On Sat, Nov 30, 2024 at 01:42:45PM +0530, Manivannan Sadhasivam wrote:
> > > >  
> > > >  struct pci_epf_test {
> > > > @@ -74,6 +76,7 @@ struct pci_epf_test_reg {
> > > >  	u32	irq_type;
> > > >  	u32	irq_number;
> > > >  	u32	flags;
> > > > +	u32	caps;
> > > 
> > > Can we rename the 'magic' register? It is not used since the beginning and I
> > > don't know if we will ever have a usecase for it.
> > 
> > It is actually used!
> > 
> > When doing PCITEST_BAR (pci_endpoint_test_bar()),
> > and barno == test->test_reg_bar, we are only filling the first 4 bytes,
> > rather than filling the whole BAR:
> > https://github.com/torvalds/linux/blob/v6.13-rc1/drivers/misc/pci_endpoint_test.c#L293-L294
> > 
> > These first 4 bytes are stored in the magic register.
> > 
> 
> heh, not so evident... thanks anyway.
> 
> > I do agree that the magic register name is slightly misleading, but that
> > seems completely unrelated to this patch.
> > 
> > If you can come up with a better name, send a patch and you shall have
> > my Reviewed-by tag :)
> > 
> 
> How about 'scratchpad'?

Sounds good to me.

When sending a patch, don't forget to update:

Documentation/PCI/endpoint/pci-test-function.rst:       1) PCI_ENDPOINT_TEST_MAGIC
Documentation/PCI/endpoint/pci-test-function.rst:* PCI_ENDPOINT_TEST_MAGIC
drivers/misc/pci_endpoint_test.c:#define PCI_ENDPOINT_TEST_MAGIC

in addition to renaming the struct member in struct pci_epf_test_reg.


Kind regards,
Niklas

