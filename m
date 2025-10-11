Return-Path: <linux-pci+bounces-37843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B37BCF7D2
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D0D1898D5C
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C427BF6C;
	Sat, 11 Oct 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2x5znN7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C925394C
	for <linux-pci@vger.kernel.org>; Sat, 11 Oct 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760195506; cv=none; b=S8tqkun15WZTPZupPrlTpeobl3dndzFI/IMQcuTagB00Kw+EejeHoBXXuI1owqzuZAZsir+E9V1V0c6bs27h86/sphHdafrFycXAnm/y7gI5cNjf/Kw7H3qG9YfE4OEPJns2l1oQISBABLa6jvb9oXBRD3EwqMy8jcrgTnQmLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760195506; c=relaxed/simple;
	bh=f6EzabMMXoOQsotr0KWsqDyZLbL9AhyRLF7+49XQgs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMGH7idIVsC7ISCwme5/s3uuGsJy2OctSr3/D95AX6Phz3ay1rsazMXdO/SteZhealuMbivx47fYswkIdwgnNKpqVbD0MlfnuTgRn2ZiYaF7XVQyUPIa/7+90JrGW7Kf9BKRIUD48tae4kpgaGvrQdPk/cdIvRleR4yOir1unso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2x5znN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7C5C4CEF4;
	Sat, 11 Oct 2025 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760195506;
	bh=f6EzabMMXoOQsotr0KWsqDyZLbL9AhyRLF7+49XQgs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2x5znN7lQkr7UUmqoiMyPby0FQ/F18J+FG5unYVX+jja6AQIB7MLOQil1BjxurJy
	 6+vweowkwJPMW/bHnqhJUFQDsqcqiW+bNRZfWakZNvwkLB5Jw//Pc80PGgwshpbPMW
	 U9FKKrx0zeuSiJFyK53pa+wfvBQa3ZVYskO8LdW2UKSLQQO1kyuOqIH84Lw7pbcpTI
	 aCjEdsuEqnMBjUp3il3KyTZER4Ra5zqWkk9rBljCvttzGtRR6/pA0ZaCxeURnSuNts
	 c3I0XtwxOdXN09yRTWSKAvt29jfBY/2fzvXfo912pch1/5rXwwhBYUJ1/nk6adN9lu
	 cqtAkd4Ii1zEg==
Date: Sat, 11 Oct 2025 08:11:42 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, 
	Christian Zigotzky <info@xenosoft.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <iv63quznjowwaib5pispl47gibevmmbbhl67ow2abl6s7lziuw@23koanb5uy22>
References: <20251008195136.GA634732@bhelgaas>
 <bf9ca58b-b54a-42fc-99f7-4edaa7e561f3@xenosoft.de>
 <aOdKAp8P0WwVfjbv@wunner.de>
 <d89576ac-c34c-4832-b51b-cf6f60c5c85c@xenosoft.de>
 <aOnqRqmHfaguJqyS@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOnqRqmHfaguJqyS@wunner.de>

On Sat, Oct 11, 2025 at 07:25:26AM +0200, Lukas Wunner wrote:
> [cc += Mani]
> 
> On Sat, Oct 11, 2025 at 07:12:49AM +0200, Christian Zigotzky wrote:
> > On 09 October 2025 at 07:37 am, Lukas Wunner wrote:
> > > On Thu, Oct 09, 2025 at 06:54:58AM +0200, Christian Zigotzky wrote:
> > > > On 08 October 2025 at 09:51 pm, Bjorn Helgaas wrote:
> > > > > On Wed, Oct 08, 2025 at 06:35:42PM +0200, Christian Zigotzky wrote:
> > > > > > Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
> > > > > > 
> > > > > > Without the pci-v6.18-changes, the PPC boards boot without any problems.
> > > > > > 
> > > > > > Boot log with error messages:
> > > > > > https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
> > > > > > 
> > > > > > Further information: https://github.com/chzigotzky/kernels/issues/17
> > > > > Do you happen to have a similar log from a recent working kernel,
> > > > > e.g., v6.17, that we could compare with?
> > > > Thanks for your answer. Here is a similar log from the kernel 6.17.0:
> > > > https://github.com/user-attachments/files/22789946/Kernel_6.17.0_Cyrus_Plus_board_P5040.log
> > > These lines are added in v6.18:
> > > 
> > >    pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> > >    pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
> > >    pci 0001:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> > >    pci 0001:01:00.0: ASPM: DT platform, enabling ClockPM
> > >    pci 0001:03:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> > >    pci 0001:03:00.0: ASPM: DT platform, enabling ClockPM
> > > 
> > > Possible candidate:
> > > 
> > > f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> > 
> > After reverting the commit f3ac2ff14834, the kernel boots without any
> > problems.
> > 
> > f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> > platforms") is the bad commit.
> 
> Hi Mani, your commit f3ac2ff14834 is causing a regression on certain
> powerpc machines.  Any ideas?
> 

Hi Lukas,

Thanks for looping me in. The referenced commit forcefully enables ASPM on all
DT platforms as we decided to bite the bullet finally.

Looks like the device (0000:01:00.0) doesn't play nice with ASPM even though it
advertises ASPM capability.

Christian, could you please test the below change and see if it fixes the issue?

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..e006b0560b39 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
 
+
+static void quirk_disable_aspm_all(struct pci_dev *dev)
+{
+       pci_info(dev, "Disabling ASPM\n");
+       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6738, quirk_disable_aspm_all);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this


Going forward, we should be quirking the devices if they behave erratically.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

