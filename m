Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6060DD46
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 10:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiJZIlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 04:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiJZIki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 04:40:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81561386BC;
        Wed, 26 Oct 2022 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666773620; x=1698309620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X2DMP8+EBgWpNYmY5Z4GpJwzp3M8y47xTwhwXFf8M3c=;
  b=mnVZIr7OmE3kefb7neH7bVM5osrOeJuj6CbzmXYizblm16qeFtEz8JFp
   fbwNNmD2MHxPY0CRModWFSH7D3SOtEs1RRA7RkIvFt4PUDIraWPOK+RbG
   XTMEpefRT5n3RUQ32zeihLAgfke0GrvsQgWq25Hxok/z7+TPNH93jydsO
   H8phQUpkkiNDlayWNW5YlqY155VnCp/qLGhpJcIM61JjFX1KX6H9Nx+DF
   OXGSFC8ZRm8kKVftgKQS7SM8GHrfHP4iTWwsUG62Qp8B+dsuKiX1ilrUd
   0Wzug0WImmObbtQdPxgdHJLwA5HzWZ5S2rdV1R5C6qkewZy9yhUqKSNA3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="334509523"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="334509523"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 01:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="877112584"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="877112584"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Oct 2022 01:40:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C7350291; Wed, 26 Oct 2022 11:40:38 +0300 (EEST)
Date:   Wed, 26 Oct 2022 11:40:38 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <Y1jyhsKG4/T7RRO9@black.fi.intel.com>
References: <20221025221054.12377-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221025221054.12377-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 05:10:54PM -0500, Mario Limonciello wrote:
> Firmware typically advertises that PCIe devices can support D3
> by a combination of the value returned by _S0W as well as the
> HotPlugSupportInD3 _DSD.
> 
> `acpi_pci_bridge_d3` looks for this combination but also contains
> an assumption that if a device contains power resources it can support
> D3.  This was introduced from commit c6e331312ebf ("PCI/ACPI: Whitelist
> hotplug ports for D3 if power managed by ACPI").
> 
> On some firmware configurations for "AMD Pink Sardine" D3 is not
> supported for wake in _S0W for the PCIe root port for tunneling.
> However the device will still be opted into runtime PM since
> `acpi_pci_bridge_d3` returns since the ACPI device contains power
> resources.
> 
> When the thunderbolt driver is loaded a device link between the USB4
> router and the PCIe root port for tunneling is created where the PCIe
> root port for tunneling is the consumer and the USB4 router is the
> supplier.  Here is a demonstration of this topology that occurs:
> 
> ├─ 0000:00:03.1
> |       | ACPI Path: \_SB_.PCI0.GP11 (Supports "0" in _S0W)
> |       | Device Links: supplier:pci:0000:c4:00.5
> |       └─ D0 (Runtime PM enabled)
> ├─ 0000:00:04.1
> |       | ACPI Path: \_SB_.PCI0.GP12 (Supports "0" in _S0W)
> |       | Device Links: supplier:pci:0000:c4:00.6
> |       └─ D0 (Runtime PM enabled)
> ├─ 0000:00:08.3
> |       | ACPI Path: \_SB_.PCI0.GP19
> |       ├─ D0 (Runtime PM disabled)
> |       ├─ 0000:c4:00.3
> |       |       | ACPI Path: \_SB_.PCI0.GP19.XHC3
> |       |       | Device Links: supplier:pci:0000:c4:00.5
> |       |       └─ D3cold (Runtime PM enabled)
> |       ├─ 0000:c4:00.4
> |       |       | ACPI Path: \_SB_.PCI0.GP19.XHC4
> |       |       | Device Links: supplier:pci:0000:c4:00.6
> |       |       └─ D3cold (Runtime PM enabled)
> |       ├─ 0000:c4:00.5
> |       |       | ACPI Path: \_SB_.PCI0.GP19.NHI0 (Supports "4" in _S0W)
> |       |       | Device Links: consumer:pci:0000:00:03.1 consumer:pci:0000:c4:00.3
> |       |       └─ D3cold (Runtime PM enabled)
> |       └─ 0000:c4:00.6
> |               | ACPI Path: \_SB_.PCI0.GP19.NHI1 (Supports "4" in _S0W)
> |               | Device Links: consumer:pci:0000:c4:00.4 consumer:pci:0000:00:04.1
> |               └─ D3cold (Runtime PM enabled)
> 
> Allowing the PCIe root port for tunneling to go into runtime PM (even if
> it doesn't support D3) allows the USB4 router to also go into runtime PM.
> The PCIe root port for tunneling stays in D0 but is in runtime PM. Due to
> the device link the USB4 router transitions to D3cold when this happens.
> 
> The expectation is the USB4 router should have also remained in D0 since
> the PCIe root port for tunneling remained in D0.
> 
> Instead of making this assertion from the power resources check
> immediately, move the check to later on, which will have validated
> that the device supports wake from D3hot or D3cold.
> 
> This fix prevents the USB4 router going into D3 when the firmware says that
> the PCIe root port for tunneling can't handle it while still allowing
> system that don't have the HotplugSupportInD3 _DSD to also enter D3 if they
> have power resources that can wake from D3.
> 
> Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
