Return-Path: <linux-pci+bounces-44002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A1CF3948
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39F523007906
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8694933A00C;
	Mon,  5 Jan 2026 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZTKOOrl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F38633A007;
	Mon,  5 Jan 2026 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613942; cv=none; b=p5p24P31I8QbLvdoDfSoKbFnbEejyZ07MpvhlzXo9dExKJPSIif10CgzMFUCntkqdXtf8imi5F2kcXneEMEM0hduZ19s7ocp+VqO5/1aMyfU1vHF1/Fdw5GwXMsUzePMOKzekIj3nwhYnepSKkdLn7FpRcfe5gwGozzR2hr9+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613942; c=relaxed/simple;
	bh=yFYXpAwHxha/oaTLnwKRcHWeNGhF/R24VXJdwrPHgb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNf+bNLJ0QCJ2C1MBkde0TgSMxko+SaUsASeaf4Km2Ep4TxVQoy556yQsqxBztGkUmK5zDeVLF+YPDJtcjq75To4m/PA7qe+bH6YsBZUFcbFbt3yEJcPe090YDOZ29l5O274RRD/qqqiEgCe8P1Y04Sok9UjF9RwbaQ7yUbqS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZTKOOrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD71C116D0;
	Mon,  5 Jan 2026 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767613942;
	bh=yFYXpAwHxha/oaTLnwKRcHWeNGhF/R24VXJdwrPHgb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZTKOOrlvay3tbRE+NeqQl03AbneT44AlhVPK2uK9aA5WgrbXY7pTgNHtaPRGKMYA
	 9XJC1mr6W2ZLXKQTh1ASxWPBAk+eASXg/2oiHuGlyHW0EjAn+a0T2/ZYhB5BW5UGeH
	 4xEK4nf0rO5Dkx8OjOHMiikq+LbMTe04zfIBOBKIS+69lk7y9iZiyW1e63rG/L9K9z
	 fEB6wVF3H++mUGa8bhSY7UQ7UvW+iWInJFYG9IA3Zo7QpngmHmhqieuTs2p2hf5tAH
	 CndqI+h9WAqtncHMDZi6snGa7kDh7yUV7JZ/6iuY1RtxQQbAE7ik23WnP7oaAEwh1O
	 7RWc6mbqkxZjg==
Date: Mon, 5 Jan 2026 17:22:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangsenchuan@eswincomputing.com, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <2qdc5ktljfacdilitkxe3phlsv4imzqxquvbsqcbzec37clbpw@d4grbnvs6xsn>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <CAKfTPtDgbkH57bahUAee8_N3QYWNuu6-jZFrJH1GW32aMiZ+og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtDgbkH57bahUAee8_N3QYWNuu6-jZFrJH1GW32aMiZ+og@mail.gmail.com>

On Mon, Jan 05, 2026 at 11:04:21AM +0100, Vincent Guittot wrote:
> On Tue, 30 Dec 2025 at 16:07, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > Hi,
> >
> > This series reworks the dw_pcie_wait_for_link() API to allow the callers to
> > detect the absence of the device on the bus and skip the failure.
> >
> > Compared to v2, I've reworked the patch 2 to improve the API further and
> > dropped the patch 1 that got applied (hence changed the subject). I've also
> > modified the error code based on the feedback in v2 to return -ENODEV if device
> > is not detected on the bus and -ETIMEDOUT otherwise. This allows the callers to
> > skip the failure if device is not detected and handle error for other failure.
> >
> > Testing
> > =======
> >
> > Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
> > dw_pcie_wait_for_link() API prints:
> >
> >         qcom-pcie 1c08000.pcie: Device not found
> >
> > Instead of the previous log:
> >
> >         qcom-pcie 1c08000.pcie: Phy link never came up
> 
> I tested the patchset with s32g399a-rdb3 and during the resume, I have:
> 
> [  460.255927] s32g-pcie 44100000.pcie: Device not found
> [  460.256021] s32g-pcie 44100000.pcie: PM: dpm_run_callback():
> s32g_pcie_resume_noirq returns -19
> [  460.256278] s32g-pcie 44100000.pcie: PM: failed to resume noirq: error -19
> 
> I was not expecting more lines than the 1st line: Device not found,
> like the init
> 
> [    2.668921] s32g-pcie 44100000.pcie: Device not found
> [    2.675342] s32g-pcie 44100000.pcie: PCI host bridge to bus 0001:00
> 
> where with skip the -ENODEV case if dw_pcie_wait_for_link() fails
> 
> Should we skip the -ENODEV case in dw_pcie_resume_noirq() too ?
> 

I proposed it initially, but then there were concerns raised that there is a
possibility that the device could be removed during suspend and we would fail to
detect it.

But I think that could be handled by checking for 'pci_bus::devices' list. If
this list is empty, then we for sure know that there was no device connected to
the bus before suspend. So if dw_pcie_wait_for_link() returns -ENODEV, and then
this list is also empty, we can safely ignore the failure.

I'll do it in v4.

- Mani

> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> > Changes in v3:
> > - Dropped patch 1 that got appplied
> > - Reworked the error handling of dw_pcie_wait_for_link() API further
> > - Link to v2: https://lore.kernel.org/r/20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com
> >
> > Changes in v2:
> > - Changed the logic to check for Detect.Quiet/Active states
> > - Collected tags and rebased on top of v6.19-rc1
> > - Link to v1: https://lore.kernel.org/r/20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com
> >
> > ---
> > Manivannan Sadhasivam (4):
> >       PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
> >       PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
> >       PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
> >       PCI: dwc: Only skip the dw_pcie_wait_for_link() failure if it returns -ENODEV
> >
> >  .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------
> >  drivers/pci/controller/dwc/pcie-designware-host.c  |  6 +-
> >  drivers/pci/controller/dwc/pcie-designware.c       | 75 +++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h       |  2 +
> >  4 files changed, 80 insertions(+), 57 deletions(-)
> > ---
> > base-commit: 68ac85fb42cfeb081cf029acdd8aace55ed375a2
> > change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679
> >
> > Best regards,
> > --
> > Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> >

-- 
மணிவண்ணன் சதாசிவம்

