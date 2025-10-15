Return-Path: <linux-pci+bounces-38126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B63BDCC58
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B6F4008C1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 06:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE083126AD;
	Wed, 15 Oct 2025 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJJt/ILK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF53126A6
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510490; cv=none; b=nGefjCqEjUF2YJDbbjNkTSAXaMrRKwosXkjd3ul1aH3brxheP22ssRyW9nktFdL+iesciCtp9xLa1o2IVpL1R+bGHgQrH+y/9MaJADC7RHjldBFPch+XToSUyBQ/woxQxhUfJdlIMn3uOBwmnwWZp65xEcETaqWaVxw9V/WvdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510490; c=relaxed/simple;
	bh=m/Rd3ahVy6pnBD+xeaNqsODPEiInTFOFb5f8DzKRI+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqJyI5mXV5qIzMKHsmvdXHEtM3+RnVhcD4aC+CExTCRuMIOt25BtTQ+UxOyDYxUb/KRynMxVBNEn7n/muPefbqWVkPTUdnTkwyf5kHbrDLE295kledzlhSiZ7uRl86o8WJOl6jBJX97Bl7ZHSmCCwKW9K9DHbOLdAOMsaNA9s/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJJt/ILK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD38C4CEFE;
	Wed, 15 Oct 2025 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760510490;
	bh=m/Rd3ahVy6pnBD+xeaNqsODPEiInTFOFb5f8DzKRI+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJJt/ILK3ju+7jPsBaqQBz3NPG7iFqr8o2lpTr4cXgFZxoRkgdMgfbva/T02t6U23
	 /etET6p2GGcAh8IE0q7sfmd0hxvI+hk5M0ECqVgSHea08Sq2Ds0fH8rwb1uRWXRpEA
	 B7WK+uNLFT11n/1+sbGup7eFozI/EO+IlvUOaqeY05bndwttgVZ/OG0QyZsVlJsqhM
	 jrE/2OffDpT8HgZpSvo6OHklBnH83Vx5ZICg4KntrQ1qdY7KVaM8gm+7hLPDZ3RDiB
	 /pqyxb//+V/KPzuiZPV6HT7qrQ3/XgBc/DnuktqcHic3K0JrTa4PL7SvmpkBsJHhZH
	 KMk/T42Va6Zrg==
Date: Wed, 15 Oct 2025 12:11:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <6avz6bsxu6uyvhk4tfvdaofxt7qptfq22un2geet5rd6pvt77c@sojadc7hp26n>
References: <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>
 <7FB0AB81-AD0F-420D-B2CB-F81C5E47ADF3@xenosoft.de>
 <3fba6283-c8e8-48aa-9f84-0217c4835fb8@xenosoft.de>
 <mg2ahzgcwgm6h5mtgs4tsel3yrphrfqgfcjydfxgzgxq5h7kot@jtealdt6vvcz>
 <a2ee06b1-28a5-4cb1-9940-b225f9e6d6ee@xenosoft.de>
 <00fe408b-db39-4a9f-b996-0fad73724759@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00fe408b-db39-4a9f-b996-0fad73724759@xenosoft.de>

On Tue, Oct 14, 2025 at 06:55:07AM +0200, Christian Zigotzky wrote:
> On 13 October 2025 at 05:58 pm, Manivannan Sadhasivam wrote:
> > Either the Root Port could be triggering these AER messages due to ASPM
> issue or
> > due to the endpoint connected downstream.
> >
> > If possible, please share the whole dmesg log instead of the snippet so
> that we
> > can be sure from where the AER messages are coming from.
> >
> > You can also add the below quirk and check:
> >
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FSL, 0x0451,
> quirk_disable_aspm_all);
> >
> > But it would be better to get the whole dmesg.
> >
> > - Mani
> 
> Hello Mani,
> 
> Thanks for your help.
> 
> The kernel doesn't compile with PCI_VENDOR_ID_FSL but it compiles with
> PCI_VENDOR_ID_FREESCALE.
> 
> I tried it with the following patch:
> 
> diff -rupN a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c    2025-10-12 22:42:36.000000000 +0200
> +++ b/drivers/pci/quirks.c    2025-10-13 17:59:51.473097708 +0200
> @@ -2525,6 +2525,16 @@ static void quirk_disable_aspm_l0s_l1(st
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080,
> quirk_disable_aspm_l0s_l1);
> 
> +
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
> quirk_disable_aspm_all);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
> quirk_disable_aspm_all);
> +
>  /*
>   * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>   * Link bit cleared after starting the link retrain process to allow this
> 
> ---
> 
> Unfortunately it doesn't solve the issue with pcieport 0001:00:00.0.
> 

That's unfortunate indeed. Could you please share the 'sudo lspci -vv' output?

That will allow us to see the topology and AER status.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

