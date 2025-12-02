Return-Path: <linux-pci+bounces-42501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E06DC9C265
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756533ACC4F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA8C279DA2;
	Tue,  2 Dec 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1q6Iedy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629B28DB46;
	Tue,  2 Dec 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691682; cv=none; b=u2fc5L3BywgqvHmiBtJIziIk7gjDI4MIkSng3ywVbMxl/pbEOZnJiQb3XbCjw3clHRWfGzdzvzMK8ckxoddxWX0em5LkM3zyd8+q59drLmXOxMRma4hcK6xpdhYoPtHFA22/6VwDUYm43tBNliumSl6Bv68ATYXGnfRR8RvYiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691682; c=relaxed/simple;
	bh=e0Hd01k/1qjQoTWF6wGiJJTFyXYOU855mVYCenLh45o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QhubWP1cH2556Ttum68xArIawl8Lk+V2WhGZaxQQzYPXH1/PipEABicmwea7XIxbx5MTozIN/a+0Iud7iPv+lFHf55TwtvMFb3mnoxEkMvCxWovU7bxZZ3ZiYO4MyGWIvBpHwodMgpgxXCIA5JuJLANf9mJSWe5ulJXsbw8ibms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1q6Iedy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764691680; x=1796227680;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e0Hd01k/1qjQoTWF6wGiJJTFyXYOU855mVYCenLh45o=;
  b=D1q6IedyigoOSTyOBkT1kIHGoAAz0r92mIy1EgdRe6X821itLcZXsi0r
   ymtgI3UVnYC10KzDLreNUAIRiKMQWhldXSViaiVF+FBXpL5Kp8bif0hqp
   ezw9B8+g8D0Yd86cR3ZTESjNZsCBbxnd0AZWMzFSuhqCrD4iPvoCjNwKk
   5Yl3MCuMNM4aGevQRd/ETv0VxjVwWQEUuUho1wcwQzNbWt/dSJQNYC64z
   RwG5lVn9ePfm2KgkFpDA0oUSH49J2oTXwCSmqvRtz+CWB/yNtetD2Vo+p
   CItNWH5yVRavIeO3lVXuwo5He/tB8Ul5vJW2g0KP1H1PRvORMuukcE7gG
   A==;
X-CSE-ConnectionGUID: QRTgNHkRRCOCGNQ4UhcFlQ==
X-CSE-MsgGUID: 9F3G4Is4QYyFHx0ckoxGDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="76984829"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="76984829"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 08:08:00 -0800
X-CSE-ConnectionGUID: XZ30udE2SRWu1KSizfarVw==
X-CSE-MsgGUID: 3xCSDNsqRx6meh9cE05a8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194639944"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 08:07:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Dec 2025 18:07:50 +0200 (EET)
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, ashishk@purestorage.com, 
    bamstadt@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, Jiwei <jiwei.sun.bj@qq.com>, 
    guojinhui.liam@bytedance.com, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] : [PATCH] PCI: Always lift 2.5GT/s restriction in
 PCIe failed link retraining
In-Reply-To: <3be03057-2a83-46e5-b120-bb041208c694@oracle.com>
Message-ID: <b92ab615-75f6-8606-cb3b-75fe03a1d9a9@linux.intel.com>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk> <3be03057-2a83-46e5-b120-bb041208c694@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Dec 2025, ALOK TIWARI wrote:
> On 12/1/2025 9:22 AM, Maciej W. Rozycki wrote:
> > Discard Vendor:Device ID matching in the PCIe failed link retraining
> > quirk and ignore the link status for the removal of the 2.5GT/s speed
> > clamp, whether applied by the quirk itself or the firmware earlier on.
> > Revert to the original target link speed if this final link retraining
> > has failed.
> > 
> > This is so that link training noise in hot-plug scenarios does not make
> > a link remain clamped to the 2.5GT/s speed where an event race has led
> > the quirk to apply the speed clamp for one device, only to leave it in
> > place for a subsequent device to be plugged in.
> > 
> > Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> > Signed-off-by: Maciej W. Rozycki<macro@orcam.me.uk>
> > Cc:<stable@vger.kernel.org> # v6.5+
> > ---
> >   drivers/pci/quirks.c |   50
> > ++++++++++++++++++--------------------------------
> >   1 file changed, 18 insertions(+), 32 deletions(-)
> > 
> > linux-pcie-failed-link-retrain-unclamp-always.diff
> > Index: linux-macro/drivers/pci/quirks.c
> > ===================================================================
> > --- linux-macro.orig/drivers/pci/quirks.c
> > +++ linux-macro/drivers/pci/quirks.c
> 
> Thanks a lot for your patch.
> The patch works, and the issue has been resolved in our testing.
> 
> However, this patch does not cleanly apply to the 6.12 LTS kernel.
> To apply the fix cleanly, a series of patches is required.
> 
> PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
> 2389d8dc38fee PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag
> 15b8968dcb90f PCI/bwctrl: Fix NULL pointer deref on unbind and bind
> e3f30d563a388 PCI: Make pci_destroy_dev() concurrent safe
> 667f053b05f00 PCI/bwctrl: Fix NULL pointer dereference on bus number
> exhaustion
> e93d9fcfd7dc6 PCI: Refactor pcie_update_link_speed()
> 9989e0ca7462c PCI: Fix link speed calculation on retrain failure
> b85af48de3ece PCI: Adjust the position of reading the Link Control 2 register
> 026e4bffb0af9 PCI/bwctrl: Fix pcie_bwctrl_select_speed() return type
> d278b098282d1 thermal: Add PCIe cooling driver
> de9a6c8d5dbfe PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed
> 665745f274870 PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller
> 3491f50966686 PCI: Abstract LBMS seen check into pcie_lbms_seen()
> 
> Could you please provide a version of this patch that can be
> cleanly cherry-picked for the 6.12 LTS (6.12.y) branch?
> 
> Alternatively, is it okay to back-port the above patch series to 6.12.y?
> 
> 
> Tested-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks for testing.

As the change has a Fixes tag, stable maintainers will eventually get to 
it (after the change has progressed into Linus' tree).

As per usual, if the patch won't apply to some old kernel version cleanly, 
stable maintainers will decide themselves whether they end up taking some
extra changes or ask for a backport from the submitter of the original 
change.

-- 
 i.


