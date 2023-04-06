Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79DB6DA46C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjDFVIA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbjDFVHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 17:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12E07683;
        Thu,  6 Apr 2023 14:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B8C064CB6;
        Thu,  6 Apr 2023 21:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71EBC433D2;
        Thu,  6 Apr 2023 21:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680815243;
        bh=8o09ePc36Ij55cMUJKfcEw4yEArsEF1zRPWn37E0t4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V7eOYvv+KF/5rTFMKF7zuUFsCyJcROELAP1MFStTnS9t8HPv0KJKl/flsDeMEH+zR
         +l15xKbGdIJRY6up+rp6YMGN0LFavYC1t1D23c+LMAvc1Ts0uQZLOwiJPFoppsx/aR
         /C/bHulCIOrlvS1Ogdt2WOeBFJOYKmJ4TXj6BBghZXQKI3xG2QfM8i6jm1BD5VM7vo
         0VdbSltR2WEHpWUp6s3BjeWMLIUa7Xyq5bC5wo02w64u9DMQp0K1y5yACMu/bhPXY9
         84LZfMmXWYUuRNdJcKICCTIYniFSkBrqETJIZHojDbsW0ylESUAaQnyGO3nfZGM+8i
         wopze1cT975Ew==
Date:   Thu, 6 Apr 2023 16:07:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230406210722.GA3735581@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315235449.1279209-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> OS owns AER") adds support to clear error status in the Device Status
> Register(DEVSTA) only if OS owns the AER support. But this change
> breaks the requirement of the EDR feature which requires OS to cleanup
> the error registers even if firmware owns the control of AER support.
> 
> More details about this requirement can be found in PCIe Firmware
> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
> If the OS supports the Error Disconnect Recover (EDR) feature and
> firmware sends the EDR event, then during the EDR recovery window, OS
> is responsible for the device error recovery and holds the ownership of
> the following error registers.
> 
> • Device Status Register
> • Uncorrectable Error Status Register
> • Correctable Error Status Register
> • Root Error Status Register
> • RP PIO Status Register
> 
> So call pcie_clear_device_status() in edr_handle_event() if the error
> recovery is successful.
> 
> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v1:
>  * Rebased on top of v6.3-rc1.
>  * Fixed a typo in pcie_clear_device_status().
> 
>  drivers/pci/pcie/edr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index a6b9b479b97a..87734e4c3c20 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  	 */
>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>  		pci_dbg(edev, "DPC port successfully recovered\n");
> +		pcie_clear_device_status(edev);
>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);

The implementation note in PCI Firmware r3.3, sec 4.6.12, shows the OS
clearing error status *after* _OST is evaluated.

On the other hand, the _OSC DPC control bit in table 4-6 says that if
the OS does not have DPC control, it can only write the Device Status
error bits between the EDR Notify and invoking _OST.

Is one of those wrong, or am I missing something?

Bjorn
