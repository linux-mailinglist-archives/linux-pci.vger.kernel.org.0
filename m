Return-Path: <linux-pci+bounces-32538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A33EB0A863
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454EC5A4315
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB82E336F;
	Fri, 18 Jul 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VitDl0P2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6C2DD608;
	Fri, 18 Jul 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855964; cv=none; b=LDHFAmx5/40t8jBEjqZw0f+PPGUo3ffZ4zFsGTyP7hRwdFAxFVppeNKRdG0sKropwH1bq7RyPw6nsIEZYOcuU7t+V2iW8LV/ZhsD0HQ8y3o1ewP1AvRoqcXSFNButEzg2jzY9zCidrnAT/TwYjUc/GB9IQ/KpfgA4oMlKg6Q4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855964; c=relaxed/simple;
	bh=aXCC6a0BRcLONBCEG+qLtT+Rm3FPzL7V91riur1H9Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jX2s6ufkFVap81Rv3ncfsGC06R37DQsAL8qq745DY7wrwqfsdyGZ/2/iXBoOJKIMT7Sw0IhNno+NBXOxb0N8vka24hkhFChAD2vyomBTIViFJ2uz6JxQefYEdOP9VLp2rBKrQmdVa7FOVOur79O3Jn3ZCO5mfWGpiPXlj20RqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VitDl0P2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812F3C4CEEB;
	Fri, 18 Jul 2025 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752855963;
	bh=aXCC6a0BRcLONBCEG+qLtT+Rm3FPzL7V91riur1H9Xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VitDl0P293UBhnBWTfwW9kVJK0g1L/RqqX2mGlwmW2JmETRPxtereKE2Vuq0LK+EG
	 bf8x/QDXwtgdesGEGkf9l3+tOv/u5eMPMLfDd5Jm8tmNgi/l9dkuuL+h79ov7lthlp
	 UFI2NSU7GD4fAKI/DAVKgV5+ZvEGjKu37s3kDh3BO2tZWRiDjhL2lKGk1Q0vG+z9uf
	 wI7zXsu3ola9AnO/2kZYI7KblB/WNrwX/y89x0GMfAWLCxdr3YZUcYLqkv2y4YdPhH
	 a+Wk/8evsszEwS9hOiOwuRm74mqj4lvhO6udfWVIb4fa6/y07B1q7rkveAwQJ6a9dO
	 Qcy/kMyM8zjbQ==
Date: Fri, 18 Jul 2025 11:26:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	manivannan.sadhasivam@oss.qualcomm.com,
	Jeff Johnson <jjohnson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	ath12k@lists.infradead.org, ath11k@lists.infradead.org,
	ath10k@lists.infradead.org, ilpo.jarvinen@linux.intel.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Message-ID: <20250718162600.GA2700538@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wkapzhyr6hzp5az4jae3y5c77c3fg4uwrmyyipbq4uosamcivq@z7nv6w7nbyrp>

On Fri, Jul 18, 2025 at 05:19:28PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 18, 2025 at 07:05:03PM GMT, Baochen Qiang wrote:
> > On 7/18/2025 6:20 PM, Manivannan Sadhasivam wrote:
> > > On Fri, Jul 18, 2025 at 01:27:27PM GMT, Manivannan Sadhasivam wrote:
> > >> On Fri, Jul 18, 2025 at 10:05:02AM GMT, Baochen Qiang wrote:
> > >>> On 7/17/2025 7:29 PM, Manivannan Sadhasivam wrote:
> > >>>> On Thu, Jul 17, 2025 at 06:46:12PM GMT, Baochen Qiang wrote:
> > >>>>> On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
> > >>>>>> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
> > >>>>>>
> > >>>>>> [...]
> > >>>>>>
> > >>>>>>>> @@ -16,6 +16,8 @@
> > >>>>>>>>  #include "mhi.h"
> > >>>>>>>>  #include "debug.h"
> > >>>>>>>>  
> > >>>>>>>> +#include "../ath.h"
> > >>>>>>>> +
> > >>>>>>>>  #define ATH12K_PCI_BAR_NUM		0
> > >>>>>>>>  #define ATH12K_PCI_DMA_MASK		36
> > >>>>>>>>  
> > >>>>>>>> @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
> > >>>>>>>>  		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
> > >>>>>>>>  
> > >>>>>>>>  	/* disable L0s and L1 */
> > >>>>>>>> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > >>>>>>>> -				   PCI_EXP_LNKCTL_ASPMC);
> > >>>>>>>> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
> > >>>>>>>
> > >>>>>>> Not always, but sometimes seems the 'disable' does not work:
> > >>>>>>>
> > >>>>>>> [  279.920507] ath12k_pci_power_up 1475: link_ctl 0x43 //before disable
> > >>>>>>> [  279.920539] ath12k_pci_power_up 1482: link_ctl 0x43 //after disable
> > >>>>>>>
> > >>>>>>>
> > >>>>>>>>  
> > >>>>>>>>  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
> > >>>>>>>>  }
> > >>>>>>>> @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
> > >>>>>>>>  {
> > >>>>>>>>  	if (ab_pci->ab->hw_params->supports_aspm &&
> > >>>>>>>>  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
> > >>>>>>>> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > >>>>>>>> -						   PCI_EXP_LNKCTL_ASPMC,
> > >>>>>>>> -						   ab_pci->link_ctl &
> > >>>>>>>> -						   PCI_EXP_LNKCTL_ASPMC);
> > >>>>>>>> +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
> > >>>>>>>
> > >>>>>>> always, the 'enable' is not working:
> > >>>>>>>
> > >>>>>>> [  280.561762] ath12k_pci_start 1180: link_ctl 0x43 //before restore
> > >>>>>>> [  280.561809] ath12k_pci_start 1185: link_ctl 0x42 //after restore
> > >>>>>>>
> > >>>>>>
> > >>>>>> Interesting! I applied your diff and I never see this issue so far (across 10+
> > >>>>>> reboots):
> > >>>>>
> > >>>>> I was not testing reboot. Here is what I am doing:
> > >>>>>
> > >>>>> step1: rmmod ath12k
> > >>>>> step2: force LinkCtrl using setpci (make sure it is 0x43, which seems more likely to see
> > >>>>> the issue)
> > >>>>>
> > >>>>> 	sudo setpci -s 02:00.0 0x80.B=0x43
> > >>>>>
> > >>>>> step3: insmod ath12k and check linkctrl
> > >>>>>
> > >>>>
> > >>>> So I did the same and got:
> > >>>>
> > >>>> [ 3283.363569] ath12k_pci_power_up 1475: link_ctl 0x43
> > >>>> [ 3283.363769] ath12k_pci_power_up 1480: link_ctl 0x40
> > >>>> [ 3284.007661] ath12k_pci_start 1180: link_ctl 0x40
> > >>>> [ 3284.007826] ath12k_pci_start 1185: link_ctl 0x42
> > >>>>
> > >>>> My host machine is Qcom based Thinkpad T14s and it doesn't
> > >>>> support L0s. So that's why the lnkctl value once enabled
> > >>>> becomes 0x42. This is exactly the reason why the drivers
> > >>>> should not muck around LNKCTL register manually.
> > >>>
> > >>> Thanks, then the 0x43 -> 0x40 -> 0x40 -> 0x42 sequence should
> > >>> not be a concern. But still the random 0x43 -> 0x43 -> 0x43 ->
> > >>> 0x42 sequence seems problematic.
> > >>>
> > >>> How many iterations have you done with above steps? From my
> > >>> side it seems random so better to do some stress test.
> > >>>
> > >>
> > >> So I ran the modprobe for about 50 times on the Intel NUC that
> > >> has QCA6390, but didn't spot the disparity. This is the script
> > >> I used:
> > >>
> > >> for i in {1..50} ;do echo "Loop $i"; sudo setpci -s 01:00.0 0x80.B=0x43;\
> > >> sudo modprobe -r ath11k_pci; sleep 1; sudo modprobe ath11k_pci; sleep 1;done
> > >>
> > >> And I always got:
> > >>
> > >> [ 5862.388083] ath11k_pci_aspm_disable: 609 lnkctrl: 0x43
> > >> [ 5862.388124] ath11k_pci_aspm_disable: 614 lnkctrl: 0x40
> > >> [ 5862.876291] ath11k_pci_start: 880 lnkctrl: 0x40
> > >> [ 5862.876346] ath11k_pci_start: 886 lnkctrl: 0x42
> > >>
> > >> Also no AER messages. TBH, I'm not sure how you were able to
> > >> see the random issues with these APIs. That looks like a race,
> > >> which is scary.
> > >>
> > >> I do not want to ignore your scenario, but would like to
> > >> reproduce and get to the bottom of it.
> > > 
> > > I synced with Baochen internally and able to repro the issue.
> > > Ths issue is due to hand modifying the LNKCTL register from
> > > userspace. The PCI core maintains the ASPM state internally and
> > > uses it to change the state when the
> > > pci_{enable/disable}_link_state*() APIs are called.
> > > 
> > > So if the userspace or a client driver modifies the LNKCTL
> > > register manually, it makes the PCI cached ASPM states invalid.
> > > So while this series fixes the driver from doing that, nothing
> > > prevents userspace from doing so using 'setpci' and other tools.
> > > Userspace should only use sysfs attributes to change the state
> > > and avoid modifying the PCI registers when the PCI core is
> > > controlling the device.  So this is the reason behind the
> > > errantic behavior of the API and it is not due to the issue with
> > > the API or the PCI core.
> > 
> > IMO we can not rely on userspace doing what or not doing what, or
> > on how it is doing, right? So can we fix PCI core to avoid this?
> 
> I'm not sure it is possible to *fix* the PCI core here. Since the
> PCI core gives userspace access to the entire config space of the
> device, the userspace reads/writes to any of the registers it want.
> So unless the config space access if forbidden if a driver is bound
> to the device, it is inevitable. And then there is also /dev/mem...
> 
> Interestingly, there is an API available for this purpose:
> pci_request_config_region_exclusive(), but it is used only by the
> AMD arch driver to prevent userspace from writing to the entire
> config space of the device.
> 
> Maybe it makes sense to use something like this to prevent the
> userspace access to the entire config space if the driver is bind to
> the device.

I'm not really a fan of pci_request_config_region_exclusive() because
it's such a singleton thing.  I don't like to be one of only a few
users of an interface.

Linux has a long tradition of allowing root users to shoot themselves
in the foot, and setpci is very useful as a debugging tool.  Maybe
tainting the kernel for config writes from userspace, and possibly
even a WARN_ONCE() at the time, would be a compromise.

Bjorn

