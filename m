Return-Path: <linux-pci+bounces-40533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D63C3D11A
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 19:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79A8426032
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5D8348895;
	Thu,  6 Nov 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXaCgMPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857A303A2F;
	Thu,  6 Nov 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453508; cv=none; b=jYuT4fqezHTM8DjP7iNZM5BysJQ3DCUQ74MlGLn3mCTeuzIT8AuZxj3XXpEj/UyfK/+18ZuQfUkvSudcuNDt1XGJ+zcXxlcYStjbCtBdTj+eYQYL7OSCbVqMePsJeOXipj0JOHNJqoZ5pNA65lPmarxZIBDhau2m37jikLaIZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453508; c=relaxed/simple;
	bh=IO6Ln6PxVJkvupdXH1DzGpt9VjwkaVOtfdDxUcDva38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BEhAMo3xXBdwVZLGxEOKQ89ERMHpKcZafICuU+/IWduyUq4DolCn8LKrgqIn3clFNP9G8o1IX0TzdBO8U8JWJunto4bT8bPWh5gJvyG5FkfaQEVWUHnyRIJ51J9ajtjYiNowEa+/2mSgSbI8SK8Ibz8+Gqm4hGAGfOOH/iihgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXaCgMPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FB9C4CEF7;
	Thu,  6 Nov 2025 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762453506;
	bh=IO6Ln6PxVJkvupdXH1DzGpt9VjwkaVOtfdDxUcDva38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZXaCgMPHUTgCLcoPL1VLHH2zvP1kf6yjh44zuxcuMdBkdMCa8WghRBtj5MJrCqXBW
	 IAQuQnbUD6UdMgzdBvqrQJauNmmEvn+5rD6qJlOiqnUuIA6UVpSlqCrgXmdxrHZXU5
	 rzXQUw4PzL3fhldQJmoBvY2AfKTfrduZ2a5iWHdzQyr2yQDPzrXgo2+pDTm+nIlaMB
	 MbF+q2IixPQD/F6Xc+kEip6PmOBHTSF5aa3jTiOutj/RIP/5UkSWpbTqRVO0Xj+evJ
	 0VvMp/lgE2a3CDnE8Q8Cya8gAglUbWd6Ao4uLa6c7ZUcvo+VVZWdrSQ5HdlpcfSzDy
	 Oac/hnAuWG2tw==
Date: Thu, 6 Nov 2025 12:25:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"hypexed@yahoo.com.au" <hypexed@yahoo.com.au>,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251106182505.GA1962607@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8833068EEAD864886D2C8AA88CC2A@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Thu, Nov 06, 2025 at 08:48:16AM +0000, Hongxing Zhu wrote:
> ...

> I tested these patches on i.MX95 EVK board with NVME storage device.
> Because that i.MX95 PCIe RC failed enter into L2 when one NVME
> device is connected to the port if ASPM L1 is enabled in default.
> 
> These patches work as expected, the l0s and l1 can be disabled after
> adding the following quirk.
> 
> "DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PHILIPS, PCI_ANY_ID,
> quirk_disable_aspm_l0s_l1_cap);"

Thanks for trying this out.

So if I understand correctly, the i.MX95 Root Port has
PCI_VENDOR_ID_PHILIPS, and if ASPM L1 is enabled on its link, the link
doesn't go to L2 when suspending?  But it *does* go to L2 on suspend
if L1 is disabled?

I wonder if the issue is with the RC or with the NVMe device.  The
comments in dw_pcie_suspend_noirq() and qcom_pcie_suspend_noirq() make
me wonder if there's something weird about NVMe and L2.

I assume you don't want to disable L0s and L1 for *all* devices with
PCI_VENDOR_ID_PHILIPS though.  Aren't there endpoints with that ID
that can use L0s and L1?

And I suppose the best thing would be if we could enable L0s and L1,
but turn them off before suspending?  That would require something
different, like something in imx_pcie_suspend_noirq() or a
DECLARE_PCI_FIXUP_SUSPEND() quirk.

