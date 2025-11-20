Return-Path: <linux-pci+bounces-41809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E689C75417
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8770434925E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738E34DB4F;
	Thu, 20 Nov 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEv74yqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2733D6E6;
	Thu, 20 Nov 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654688; cv=none; b=by16FHgiwhOU/aHFu/Oi/Og7WikYwq6YHjPdRQ8oBfLAa9HEgG3Vp8P7FCqCzMnucc/HkO2ozkXmtFfG2wgm/y1zIyhfMQ28jbZdXhw1DWclUJapPlPjfvDyQTO7Jo9tZGbG6R10iLA7mAyE8+be6bsizVXLos2lzly+iTz/nVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654688; c=relaxed/simple;
	bh=EoPzFpnQX9X2ZePX6wZ2wloAQuc2jCrr0NmVo6kaYNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6aJLdHaB6a+8VA5KV5PMYVbqokXdUikbS8Ef1siiXIuIUI+EK40WzRIGpp5E/vc9YDLz5YG5t6pY6v0IZIgM79cJAOnQA7cKJMIevHhfymL8SW3HQEfmSxCeSQbPb5IME0aqxL+oOpXWZn++5PFfLJ8YD1vcP7RkmU/MGsxVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEv74yqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B90C4CEF1;
	Thu, 20 Nov 2025 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763654687;
	bh=EoPzFpnQX9X2ZePX6wZ2wloAQuc2jCrr0NmVo6kaYNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEv74yqUz+7AKBPhKVaqjkTwxQdCbYU1uR2ScFf66J1qprasXwX5zYiamIhNIr6pP
	 ZNEn0UrYPn1xnl4P1uZef6QC0DNln+ILIV50uCWzQnNJT0sHTHsUsZ00hpEQtdEId6
	 BwBDvfojpWhGMFatUueOQVwvD5gSp2+gLS0XKpdrUB6YZKB2VZBAkorQtSx2NXCbJl
	 J0P7pyYqydry9ST+rc3JylD5KCLNGtRq4fZCJFV/GtGrhc/N3WnsS3cfEAZ0r6EyCP
	 NLtd2dAK0s6QHmrEVB9PJOdubRXdcg1RZ5rjOttJfBTs4/oaA0Ux7IVpEXTSWGuele
	 p/pdet3BKNvig==
Date: Thu, 20 Nov 2025 21:34:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add quirk to disable ASPM L1 for Sandisk SN740 NVMe
 SSDs
Message-ID: <gmmdmujfrnenxuvuohlg3xfyicauvk42rhdoe2ojnlfaa4ljck@x4wqnlkyqulb>
References: <20251120154601.116806-1-mani@kernel.org>
 <88778660-18de-40a7-83af-41f60334c4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88778660-18de-40a7-83af-41f60334c4cc@oss.qualcomm.com>

On Thu, Nov 20, 2025 at 04:50:44PM +0100, Konrad Dybcio wrote:
> On 11/20/25 4:46 PM, Manivannan Sadhasivam wrote:
> > The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream Root
> > Port of PCIe controller in Lenovo Thinkpad T14s laptop when ASPM L1 is
> 
>                              ^ Microsoft Surface Laptop 7
> 

Err... Somehow I assumed that it was T14s ;)

@Bjorn: Let me know if I have to resend or you can fix it up while applying.

- Mani

> Konrad
> 
> > enabled:
> > 
> >   pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
> >   nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> >   nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
> >   nvme 0006:01:00.0:    [ 0] RxErr
> > 
> > Hence, add a quirk to disable L1 state for this SSD.
> > 
> > Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/pci/quirks.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..a6f88c5ba2f4 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >   */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> >  
> > +static void quirk_disable_aspm_l1(struct pci_dev *dev)
> > +{
> > +       pci_info(dev, "Disabling ASPM L1\n");
> > +       pci_disable_link_state(dev, PCIE_LINK_STATE_L1);
> > +}
> > +
> > +/*
> > + * Sandisk SN740 NVMe SSDs cause AER timeout errors on the upstream PCIe Root
> > + * Port when ASPM L1 is enabled.
> > + */
> > +DECLARE_PCI_FIXUP_FINAL(0x15b7, 0x5015, quirk_disable_aspm_l1);
> > +
> >  /*
> >   * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> >   * Link bit cleared after starting the link retrain process to allow this

-- 
மணிவண்ணன் சதாசிவம்

