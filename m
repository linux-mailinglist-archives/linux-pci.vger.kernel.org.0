Return-Path: <linux-pci+bounces-37929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440DBD55DE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08705435E0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ADF1EF36E;
	Mon, 13 Oct 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG4lmLNh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56D2AD32
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371157; cv=none; b=nOmfq2ZNzZ9O3IdKg6GVEYlyUX3h8UhGlqm295zoDQh5zGEzFIM0430Uw58PS52xVL0Iidy2dTMyTCbdNkUMabv9/eXFFKIUmJb/00yF+8L9ozEAWGUzK9W+nPH4V5Gc3qV05gVL/6xnyy2l+quVZEzCD6+nRnzI8zCazVHCqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371157; c=relaxed/simple;
	bh=YzPXSc9lA79Qdx1+RbYOvpF5Hc02Jrnk2byrQTnsdio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2CHGemWV1gV8g7f+H1njjEdbc3BAgOPo94TRNE32dKZPBgmUVJZ4/4QYS4vnQEGS0h3Na06s+Rb/cQoYJzWLiLWjUjqAT4PnwR/iEB36dTxi/K7sQyTNQ2WJ+K48J0dQevZ2yzMBZFgUvuyXG/GMwewd42oWJVMY2TjQlp4S/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG4lmLNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58933C4CEE7;
	Mon, 13 Oct 2025 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760371155;
	bh=YzPXSc9lA79Qdx1+RbYOvpF5Hc02Jrnk2byrQTnsdio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CG4lmLNhQezyFadt+TIyiILI5E62iaE76Osv8KyQODyiT6ndsgdZTFdqmksAHRI4q
	 WG94uqN2xbCFr8pejgVrQTz9tsOaFf3ELTbUUngJBoXdNbX7qFy+WDdAr/OaNWpN93
	 498pQvp0uetu6l7gOx0vBl3/TFERJ1AQt1Jy4Hi9v2m1YW3Zt0aD8tJlQRQJVsPlCk
	 XfDDeomHGVteG9e+QEpwFsemnjomC1GHRDehPGQihr51Iw/5FErSCHNNnm3qveEoe8
	 WgG7eRXhoVnlJKDlgf8LStK62bOxQf9WcyOMwbTHF+UdjMLRyKOsCllacgvVXhQKc/
	 MMi+lL3+eeFyQ==
Date: Mon, 13 Oct 2025 21:28:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <mg2ahzgcwgm6h5mtgs4tsel3yrphrfqgfcjydfxgzgxq5h7kot@jtealdt6vvcz>
References: <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>
 <7FB0AB81-AD0F-420D-B2CB-F81C5E47ADF3@xenosoft.de>
 <3fba6283-c8e8-48aa-9f84-0217c4835fb8@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fba6283-c8e8-48aa-9f84-0217c4835fb8@xenosoft.de>

On Mon, Oct 13, 2025 at 04:50:31PM +0200, Christian Zigotzky wrote:
> On 13 October 2025 at 07:23 am, Christian Zigotzky wrote:
> > Better for testing (All AMD graphics cards):
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..e006b0560b39 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > */
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > 
> > +
> > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > +{
> > +       pci_info(dev, "Disabling ASPM\n");
> > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> > +}
> > +
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID, quirk_disable_aspm_all);
> > +
> > /*
> > * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> > * Link bit cleared after starting the link retrain process to allow this
> This patch has solved the boot issue but I get the following error messages
> again and again:
> 
> [  186.765644] pcieport 0001:00:00.0: AER: Correctable error message
> received from 0001:00:00.0 (no details found
> [  187.789034] pcieport 0001:00:00.0: AER: Correctable error message
> received from 0001:00:00.0
> [  187.789052] pcieport 0001:00:00.0: PCIe Bus Error: severity=Correctable,
> type=Data Link Layer, (Transmitter ID)
> [  187.789058] pcieport 0001:00:00.0:   device [1957:0451] error
> status/mask=00001000/00002000
> [  187.789066] pcieport 0001:00:00.0:    [12] Timeout
> [  187.789120] pcieport 0001:00:00.0: AER: Correctable error message
> received from 0001:00:00.0 (no details found
> [  187.789169] pcieport 0001:00:00.0: AER: Correctable error message
> received from 0001:00:00.0 (no details found
> [  187.789218] pcieport 0001:00:00.0: AER: Correctable error message
> received from 0001:00:00.0 (no details found
> [  188.812514] pcieport 0001:00:00.0: AER: Correctable error message
> received from 0001:00:00.0
> 
> I don't get these messages with the revert patch. [1]
> 

Either the Root Port could be triggering these AER messages due to ASPM issue or
due to the endpoint connected downstream.

If possible, please share the whole dmesg log instead of the snippet so that we
can be sure from where the AER messages are coming from.

You can also add the below quirk and check:

DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FSL, 0x0451, quirk_disable_aspm_all);

But it would be better to get the whole dmesg.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

