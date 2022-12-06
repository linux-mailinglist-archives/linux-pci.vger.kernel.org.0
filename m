Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB08644E1A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 22:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLFVmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 16:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFVmM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 16:42:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B374874A;
        Tue,  6 Dec 2022 13:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ADB7B81B8A;
        Tue,  6 Dec 2022 21:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC973C433D7;
        Tue,  6 Dec 2022 21:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670362928;
        bh=wxhUycLDzdhggpxStShb2U5NNeKt45tBmidI7CWLoqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iKbYxVGuNZ9Q8dCml8SpnNaWJnOFPHb4fBigyPNA1v+AL5jOfscJx8pwHUh2TivJZ
         AULQl7iQrHAcrZNUAsXXd2Wgg63QenYakcefYiePya7MeuuhvvVnwVHwKu7WN+imM1
         q5ykM/H6r0z6jN7a5DDfpJ2Ku29V+nYB59wAOekwvo5j5G0yzLZNYH9EvjzcrnoYT3
         jSkJyPOaeb2ABu/V+CWlE3hBrh8pb8yyaqUo1UZiNuQgOcpVyje2Lfj7A27V+PZrCG
         XOlXzUpQOEcaX21lCFMUemTMrWUQD0SRkhyy9RGwNUf5v/cZ3/MN/bVinjDfFVfo5r
         2vHT7nQCB1Kcg==
Date:   Tue, 6 Dec 2022 15:42:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 8/9] PCI/ERR: Clear fatal error status when
 pci_channel_io_frozen
Message-ID: <20221206214207.GA1368357@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928105946.12469-9-chenzhuo.1@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zhuo,

On Wed, Sep 28, 2022 at 06:59:45PM +0800, Zhuo Chen wrote:
> When state is pci_channel_io_frozen in pcie_do_recovery(), the
> severity is fatal and fatal error status should be cleared.
> So add pci_aer_clear_fatal_status().
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/pci/pcie/err.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index f80b21244ef1..b46f1d36c090 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -241,7 +241,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_walk_bridge(bridge, report_resume, &status);
>  
>  	pcie_clear_device_status(dev);
> -	pci_aer_clear_nonfatal_status(dev);
> +	if (state == pci_channel_io_frozen)
> +		pci_aer_clear_fatal_status(dev);
> +	else
> +		pci_aer_clear_nonfatal_status(dev);

I'm confused.  It seems like we certainly need to clear fatal errors
after they occur *somewhere*, and if we don't, surely this would be a
very obvious issue.  But you didn't mention this being a bug fix, so I
assume it's more of a cleanup.

If it *is* a bug fix, please say that and give a hint about what the
bug looks like, e.g., what sort of messages a user might see.

If it's not a bug fix, I don't understand how AER fatal errors get
cleared today.  The PCI_ERR_UNCOR_STATUS bits are sticky, so they're
not cleared by a reset.  In the current tree, these are the only
places I see that clear AER fatal errors:

  pci_init_capabilities
    pci_aer_init         # once at device enumeration
      pci_aer_clear_status
        pci_aer_raw_clear_status
          pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status)

  aer_probe
    aer_enable_rootport  # once at Root Port enumeration
      pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32)

  dpc_process_error      # after DPC triggered
    pci_aer_clear_fatal_status
      pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status)

  edr_handle_event       # after EDR event
    pci_aer_raw_clear_status
      pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status)

  pci_restore_state      # after reset or PM sleep/resume
    pci_aer_clear_status
      pci_aer_raw_clear_status
        pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status)

The only one that could clear errors after an AER error (not DPC or
EDR), would be the pci_restore_state() in the reset path.  If the
current code relies on that, I'd say that's a pretty non-obvious
dependency.

>  	pci_info(bridge, "device recovery successful\n");
>  	return status;
> -- 
> 2.30.1 (Apple Git-130)
> 
