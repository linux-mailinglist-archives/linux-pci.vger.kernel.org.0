Return-Path: <linux-pci+bounces-37930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB18BD4DE2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C301886491
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093530C610;
	Mon, 13 Oct 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkkiw79w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13D30C605
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371323; cv=none; b=iwf94llptLQXlqcZdCV2Peu8AGKJbDQiOetPQW8Wckxzgn2XMNM26xV2PFsZdeSFaXmWJsZGxQE0IWBWVTbUDHM+St94qC96nCTZz+08XylwJ7XQBmHfzDJYzRYwJuRXe3T1S3/l/Un2wKfTmR59L2gJa10SwxGRGz0H8DpAcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371323; c=relaxed/simple;
	bh=zmWs4tyPdA4WSf506TonoWwzqbFwMzD2ey7AUqVphrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmY+frwJsEz+/I6UpCJBaHxspGza1tdohp3DFIjHHv8mFpfJHniDMnTbU0dhNZb3MmgNoShDv78KVzYMifKf1up96yUnUC7rp7+mHLXYsPiZ71ImpSDmXPzlQvN2rhUWr4HFZrMag9Zm7OOgvMxysnsojvkgiRKdb/HxNpJQNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkkiw79w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B548DC4CEE7;
	Mon, 13 Oct 2025 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760371322;
	bh=zmWs4tyPdA4WSf506TonoWwzqbFwMzD2ey7AUqVphrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkkiw79wL7Hof/AILG3pyTbRsVPGf1cs703PPmyV0W7PsPP+ptpwEo7RZpZXBZ3Pb
	 2BGDoaDCWx1H4lgm/h5JCR5oExPfQLwWzFx0QiA5GnlJd5eDQJXjYWSPemDe5u0ymJ
	 YdKnQYUNVLsXYNch3R5eh9y8T1isFqieT/LsIqkdLS+VviZyvHKoYP84wO0g349LxI
	 TdHODQT2CmgmeH2hkYIy8LpJqu85XrytPHLD6MhDstMEEfo5jgDfcXA82vqrYYbxAN
	 UJ+Fw0wK/9inL5MM4f/DUA6O1no7TX9lKMeWy4fRYgD5aZ6gpIacYLgs+SBThvSmEd
	 jPJahPvBexD4Q==
Date: Mon, 13 Oct 2025 21:31:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <rmczfftmndkj7vofbol6i3enl26dbqv4mbbqsxyiruif6xjfd3@3yotxa4j2com>
References: <0BE6C5AD-8DFD-4126-9B18-C012B522B442@xenosoft.de>
 <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>

On Mon, Oct 13, 2025 at 07:02:19AM +0200, Christian Zigotzky wrote:
> 
> 
> > On 13 October 2025 at 06:47 am, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> > 
> > ﻿
> >> On 11 October 2025 at 07:36 pm, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >> 
> >> Hi Lukas,
> >> 
> >> Thanks for looping me in. The referenced commit forcefully enables ASPM on all
> >> DT platforms as we decided to bite the bullet finally.
> >> 
> >> Looks like the device (0000:01:00.0) doesn't play nice with ASPM even though it
> >> advertises ASPM capability.
> >> 
> >> Christian, could you please test the below change and see if it fixes the issue?
> >> 
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 214ed060ca1b..e006b0560b39 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >> */
> >> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> >> 
> >> +
> >> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> >> +{
> >> +       pci_info(dev, "Disabling ASPM\n");
> >> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> >> +}
> >> +
> >> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_all);
> >> +
> >> /*
> >> * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> >> * Link bit cleared after starting the link retrain process to allow this
> >> 
> >> 
> >> Going forward, we should be quirking the devices if they behave erratically.
> >> 
> >> - Mani
> >> 
> >> --
> >> மணிவண்ணன் சதாசிவம்
> > 
> > Hello Mani,
> > 
> >> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_all);
> > 
> > Is this only for my AMD Radeon HD6870?
> > 
> > My AMD Radeon HD5870 is also affected.
> > 
> > And I tested it with my AMD Radeon HD5870.
> > 
> > What would the line be for all AMD graphics cards?
> > 
> > Thanks,
> > Christian
> 
> I see. 0x6738 is for the AMD Radeon HD 6800 series.
> 
> It could be, that your patch works because I tested it with an AMD Radeon HD5870 instead of an AMD Radeon HD6870. Sorry 
> 
> This could be the correct line for the HD5870:
> 
> >> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6898, quirk_disable_aspm_all);
> 
> There are some more id numbers for the HD5870.
> 
> Correct:
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..e006b0560b39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> */
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> 
> +
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_all);

As you've figured out, we need to add the quirks for individual devices. Btw, I
just used PCIE_LINK_STATE_ALL to make sure the patch works. But for properly
fixing the issue, we need to try disabling L0s, L1 separately and check which
one (or both) is causing issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

