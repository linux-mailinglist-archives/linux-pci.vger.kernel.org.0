Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B278521B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjHWH4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjHWH4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 03:56:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B50CF1
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692777413; x=1724313413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jm0B5WPijalEIr5WwlHC8LtuIzY6ui0xwi/KzjmaziA=;
  b=BNEBrhTVo8g3IqOIC27Him9F9vC8rIaOyaBYlQ9/k2K8aG238MM498FY
   MB2b9tgtDrGd7bCKcqYoJI7bW5ueHZwm3aXZ0mQtOtK8alUFQC3SANn57
   uz4lfyrO8loRAzblrff+lsIncorzY1gQAJkmXFDCJyueMKPbx4+UiICap
   Xu08hpLAdZILFwxRSla9mADE8bulrR6Lie+Q50xP4XEBiIcRAfEHTYOMh
   fcTkKnoQZ9tmq2WJGb3s8kGIw+NSvTdWp3K6RdVifQCKZVTF9knrXdnSq
   W/MLXUgAOFKD52XtdedKdMdWWmhPcgOn/8JsHIFKvtcCtGE/TxkofxziY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="353647415"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="353647415"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="983185156"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="983185156"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Aug 2023 00:56:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D0187379; Wed, 23 Aug 2023 10:56:49 +0300 (EEST)
Date:   Wed, 23 Aug 2023 10:56:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kamil Paral <kparal@redhat.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230823075649.GS3465@black.fi.intel.com>
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com>
 <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com>
 <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
 <20230823074447.GR3465@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823074447.GR3465@black.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 10:44:47AM +0300, Mika Westerberg wrote:
> I guess even without the 60s delay you see in the logs that the PCIe
> link is down and Linux starts tearing the device stack towards the dock
> on resume?

Okay this is what happens (from your log):

srp 22 18:19:50 fenix kernel: pcieport 0000:05:01.0: Data Link Layer Link Active not set in 1000 msec
srp 22 18:19:50 fenix kernel: pcieport 0000:07:00.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: pcieport 0000:08:00.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: pcieport 0000:08:04.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: pcieport 0000:08:01.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: pcieport 0000:08:03.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: pcieport 0000:08:02.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: not ready 1023ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: not ready 1023ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: not ready 2047ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: not ready 2047ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: not ready 4095ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: not ready 4095ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: not ready 8191ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: not ready 8191ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: not ready 16383ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: not ready 16383ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: not ready 32767ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: not ready 32767ms after resume; waiting
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: not ready 65535ms after resume; giving up
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: not ready 65535ms after resume; giving up
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: ACPI: EC: event unblocked
srp 22 18:19:50 fenix kernel: i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A] is disabled/in DSI mode with an ungated DDI clock, gate it
srp 22 18:19:50 fenix kernel: i915 0000:00:02.0: [drm] [ENCODER:102:DDI B/PHY B] is disabled/in DSI mode with an ungated DDI clock, gate it
srp 22 18:19:50 fenix kernel: i915 0000:00:02.0: [drm] [ENCODER:118:DDI C/PHY C] is disabled/in DSI mode with an ungated DDI clock, gate it
srp 22 18:19:50 fenix kernel: pcieport 0000:05:01.0: pciehp: Slot(1): Card not present
srp 22 18:19:50 fenix kernel: pcieport 0000:08:04.0: pciehp: pcie_do_write_cmd: no response from device
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: Unable to change power state from D3cold to D0, device inaccessible
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: Controller not ready at resume -19
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: PCI post-resume error -19!
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: HC died; cleaning up
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: Controller not ready at resume -19
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: PCI post-resume error -19!
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: HC died; cleaning up
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: PM: dpm_run_callback(): pci_pm_resume+0x0/0xf0 returns -19
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: PM: dpm_run_callback(): pci_pm_resume+0x0/0xf0 returns -19
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:09:00.0: PM: failed to resume async: error -19
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:0b:00.0: PM: failed to resume async: error -19
srp 22 18:19:50 fenix kernel: xhci_hcd 0000:3c:00.0: xHC error in resume, USBSTS 0x401, Reinit

So directly after resume the PCIe link (tunnel) from the Thunderbolt host router
PCIe downstream port does not get re-established and this brings down
the whole device hierarchy behind that port. The delay just made it take
longer but the actual problem is not the delay but why the tunnel is not
re-established properly.

Next question is that what's the Thunderbolt firmware version? You can
check it throughs sysfs: /sys/bus/thunderbolt/devices/0-0/nvm_version. I
see the BIOS you have seems to be quite recent (06/12/2023) so that
probably should be good enough.

@Chris Chiu, have you guys run Linux on that particular Lenovo system?
