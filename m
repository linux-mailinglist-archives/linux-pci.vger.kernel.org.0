Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D96DB5EA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 23:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDGVvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 17:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjDGVvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 17:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC54C679;
        Fri,  7 Apr 2023 14:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F0A64465;
        Fri,  7 Apr 2023 21:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AEEC433D2;
        Fri,  7 Apr 2023 21:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680904304;
        bh=KKX2qukbqARKziXpZ5Z77M5yQRvkEtvdiQIqFTYCZsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TmvDC25psL77z4S32BHtlD52ALcXUQU7psLxZkr5GV0/1iiTvsnGI9O9E+ck5bgAh
         ktNAF0oGPXsSk0A880Ejp3W/uD9Fuq9TD3GYJkxNn2s3W2I0aWsdk3Kq4LxIqWCnNP
         SFV+MFsfr6DZYVwYftXClzshWRAbpW/1uS5paeq7GGJl7VcnmotJ0yvoQ38RJ0Yru2
         eDrf0LizhpEHB6cZ2azrbbGPVGaKjILcGcn8lyshCvUHCrNExe2oABhOBqvraFfMPr
         caWL0GZdjaS3mrrGB2q4gI838qrdSBTkr7VN68Z321xRgAvPtRy+1DbJZ5QIDJkdUo
         xTC6ZbmhlnI/Q==
Date:   Fri, 7 Apr 2023 16:51:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230407215142.GA3825302@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315235449.1279209-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jonathan, Mahesh]

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

Sorry I spent so much time on this, but I finally applied it to
pci/aer for v6.4.

I added the "Fixes: 068c29a248b6" line.  It's not that 068c29a248b6 is
a bug, just that EDR relied on behavior that 068c29a248b6 legitimately
removed, so this patch should go where 068c29a248b6 goes.

I wordsmithed the commit log to add hints about things I stumbled
over.  I'll post a follow-up patch to add a couple comments there,
too.

Thanks for your patience in educating me through all this.

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
>  	} else {
>  		pci_dbg(edev, "DPC port recovery failed\n");
> -- 
> 2.34.1
> 
