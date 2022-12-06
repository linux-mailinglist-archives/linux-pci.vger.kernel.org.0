Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D58B644E67
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 23:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLFWNm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 17:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLFWNl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 17:13:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E946C2C124;
        Tue,  6 Dec 2022 14:13:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A950B81B3B;
        Tue,  6 Dec 2022 22:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB50C433D7;
        Tue,  6 Dec 2022 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670364817;
        bh=aaEuMflWG3h9lGdqzzs38XODN98pr4Rxd/gte/nw7TI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Cyf1Huo8bUIvhPTTxdlAnMIoObwq8hm8lFH2xRlU+32//CwMWZoj0N+zd5sa6NwDv
         3Wq3H0x6TCtNEnXCJONRinvp16pjnlgj6qc1/B0rT9b73MwJwl97YbZgIq359Wl72V
         XlQH/pu7lDqBjUfTDqHlKDTond8AQy82ghJG5MdF8FLlN9C7x6w98HZGg1oWGgjzS6
         H2zt7DhAjGDWqAI/vckpY4bDJlfGqQGWhaVCZ7FKsLsEFgQKVOb5tyKa8jxgYaJCiB
         QH5JUi6AJF6o7qoZ39xzM4QeSa9mKLpufnMdk1KrSZqUajZB2x0AnxT3CuAUy6LlKL
         dUlHI/RmVZCjg==
Date:   Tue, 6 Dec 2022 16:13:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/9] scsi: lpfc: Change to use
 pci_aer_clear_uncorrect_error_status()
Message-ID: <20221206221335.GA1363005@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928105946.12469-5-chenzhuo.1@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[moved James, Dick, LPFC supporters to "to"]

On Wed, Sep 28, 2022 at 06:59:41PM +0800, Zhuo Chen wrote:
> lpfc_aer_cleanup_state() requires clearing both fatal and non-fatal
> uncorrectable error status.

I don't know what the point of lpfc_aer_cleanup_state() is.  AER
errors should be handled and cleared by the PCI core, not by
individual drivers.  Only lpfc, liquidio, and sky2 touch
PCI_ERR_UNCOR_STATUS.

But lpfc_aer_cleanup_state() is visible in the
"lpfc_aer_state_cleanup" sysfs file, so removing it would break any
userspace that uses it.

If we can rely on the PCI core to clean up AER errors itself
(admittedly, that might be a big "if"), maybe lpfc_aer_cleanup_state()
could just become a no-op?

Any comment from the LPFC folks?

Ideally, I would rather not export pci_aer_clear_nonfatal_status() or
pci_aer_clear_uncorrect_error_status() outside the PCI core at all.

> But using pci_aer_clear_nonfatal_status()
> will only clear non-fatal error status. To clear both fatal and
> non-fatal error status, use pci_aer_clear_uncorrect_error_status().
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/scsi/lpfc/lpfc_attr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index 09cf2cd0ae60..d835cc0ba153 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -4689,7 +4689,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
>   * Description:
>   * If the @buf contains 1 and the device currently has the AER support
>   * enabled, then invokes the kernel AER helper routine
> - * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
> + * pci_aer_clear_uncorrect_error_status() to clean up the uncorrectable
>   * error status register.
>   *
>   * Notes:
> @@ -4715,7 +4715,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	if (phba->hba_flag & HBA_AER_ENABLED)
> -		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
> +		rc = pci_aer_clear_uncorrect_error_status(phba->pcidev);
>  
>  	if (rc == 0)
>  		return strlen(buf);
> -- 
> 2.30.1 (Apple Git-130)
> 
