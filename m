Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE534D6866
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 19:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbiCKSYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 13:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiCKSYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 13:24:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6839C6812;
        Fri, 11 Mar 2022 10:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6179661E88;
        Fri, 11 Mar 2022 18:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AFFC340E9;
        Fri, 11 Mar 2022 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647022988;
        bh=fZ47RO3FWjQg0fkPbefYcV7U3D5vHA7T+eWND8FfqNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TY9T+WxPlnqPsJlkwlrFU08Z5Re9291zXUcwuq+sUIecJhSjvn0JowCYJb1s25+Ch
         zI3I3eyL4f0+lv1pYxjgarf1Gjn6mkweAJEJlFYlmYQQr11ZduxWrdv8dLkqA9UicW
         ly1h9XWp9qVYJLz8J3XUE6zPKqOJ35SD7uC/USypPS5afXNW5OzfCloyTss3T8Kr6j
         SroUUMOqSoyZyE9oh9JBhLjvw++Zen6JPYXg8APn4zu2q4NwnYuj+Bqj1mmnfgrDHh
         TG6cwpdZsC9U6cVmhtYM8QbjkglmeDlSdAw/FjYFIcgzCI75OFKfVZVxBeG+5ClRxo
         ygLvVrhgE8ADQ==
Date:   Fri, 11 Mar 2022 12:23:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sanju.Mehta@amd.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Message-ID: <20220311182305.GA311200@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310175832.1259-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subject convention in drivers/pci would be "PCI/ACPI:"

But more importantly, please turn the subject from a non-specific
negative ("Don't blindly trust") into a more specific *positive*,
e.g.,

  PCI/ACPI: Assume HotPlugSupportInD3 only if device can wake from D3

On Thu, Mar 10, 2022 at 11:58:32AM -0600, Mario Limonciello wrote:
> The `_DSD` `HotPlugSupportInD3` is supposed to indicate the ability for a
> bridge to be able to wakeup from D3.

Thanks for the Microsoft URL.  To make this commit log self-contained
and guard against the link becoming stale, can you quote the relevant
text here, since it's not long:

  This ACPI object [HotPlugSupportInD3] enables the operating system
  to identify and power manage PCIe Root Ports that are capable of
  handling hot plug events while in D3 state.

> This however is static information in the ACPI table at BIOS compilation
> time and on some platforms it's possible to configure the firmware at boot
> up such that `_S0W` will not return "0" indicating the inability to wake
> up the device from D3.

Please include the spec reference (ACPI v6.4, sec 7.3.20) in case the
URL below becomes stale, and again, the relevant text is barely longer
than the URL and could be included:

  7.3.20 _S0W (S0 Device Wake State)

  This object evaluates to an integer that conveys to OSPM the deepest
  D-state supported by this device in the S0 system sleeping state
  where the device can wake itself.

I guess the argument is that we can put a Root Port into D3 only if
_S0W indicates that it can wake from D3 *and* it has the
HotPlugSupportInD3 property?

I'm naive about ACPI sleep/wake, but that does sound plausible.

But the patch doesn't say anything about _S0W, so we need to somehow
connect the dots there.

> To fix these situations explicitly check that the ACPI device has a GPE
> allowing the device to generate wakeup signals handled by the platform
> in `acpi_pci_bridge_d3`.

acpi_pci_bridge_d3()

Would be good to say what "these situations" are.  I guess this fixes
a bug, so let's outline what that bug is, what the symptoms are, who
reported and tested it, etc.

> This changes aligns the handling of the situation the same as Windows 10
> and Windows 11 both do as well.

s/changes/change/

Sentence also needs a little polishing: "aligns ... both do as well"
doesn't quite flow.

Does this make things work like Windows 10/11 from a user's point of
view, or have you somehow confirmed that Windows actually checks _S0W
and HotPlugSupportInD3 in the same way?

> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Add Mika's tag
>  * Update commit message for Rafael's suggestions
>  drivers/pci/pci-acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..9f8f55ed09d9 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	if (!adev)
>  		return false;
>  
> +	if (!adev->wakeup.flags.valid)
> +		return false;
> +
>  	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>  				   ACPI_TYPE_INTEGER, &obj) < 0)
>  		return false;
> -- 
> 2.34.1
> 
