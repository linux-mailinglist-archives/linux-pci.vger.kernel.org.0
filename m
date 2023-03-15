Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FDF6BBF73
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 22:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjCOVv1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCOVvV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 17:51:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49979A401B
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678917070; x=1710453070;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=rqZ03QYxLa+NCSwXRSvBPbAsQ0PDRi1NPYXSMPNLZuw=;
  b=dd2mEhentdslLSe195e0j/inS/HMIss7Ls1sP7lAXEa4My7ViOqKJ+MW
   O9bS4ZpYqCMKYseicTWPtpfaOzYlUf9gRQfxL2YTAPRJIyJ4VUI4FRj/P
   QeRSmG8kVlcWUUUTA6msOCgPoST5/a4fquztZSofPqa/2aIEZDAN3Gs3j
   gaSYkbFLtZsLUxkW/C9nfhviUw1Xemz9qmIDRqXvoowij6KYhYuSc6Xmz
   BxOqi3z4Y+ucMBvfcMIGw9yIaKbPc/5gaRLomVYxA50XwYsKNgdmPF5fG
   Rr7sJxSt8uIdGM2A2Goz5Zxyp8yIxXp1LxSZP4f4O9O5QQLN13Ac6GWxR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321670105"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321670105"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 14:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="629611010"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="629611010"
Received: from dtfrankl-mobl1.amr.corp.intel.com (HELO [10.212.10.122]) ([10.212.10.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 14:51:09 -0700
Message-ID: <8b5e6130-13c2-8142-6e70-075ba735fe60@linux.intel.com>
Date:   Wed, 15 Mar 2023 14:51:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] PCI: vmd: Reset VMD config register between soft reboots
Content-Language: en-US
To:     linux-pci@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>
References: <20230224202811.644370-1-nirmal.patel@linux.intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230224202811.644370-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/24/2023 1:28 PM, Nirmal Patel wrote:
> VMD driver can disable or enable MSI remapping by changing
> VMCONFIG_MSI_REMAP register. This register needs to be set to the
> default value during soft reboots. Drives failed to enumerate
> when Windows boots after performing a soft reboot from Linux.
> Windows doesn't support MSI remapping disable feature and stale
> register value hinders Windows VMD driver initialization process.
> Adding vmd_shutdown function to make sure to set the VMCONFIG
> register to the default value.
>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Fixes: ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
> ---
>  drivers/pci/controller/vmd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..50a187a29a1d 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -979,6 +979,13 @@ static void vmd_remove(struct pci_dev *dev)
>  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
>  }
>  
> +static void vmd_shutdown(struct pci_dev *dev)
> +{
> +        struct vmd_dev *vmd = pci_get_drvdata(dev);
> +
> +        vmd_remove_irq_domain(vmd);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int vmd_suspend(struct device *dev)
>  {
> @@ -1056,6 +1063,7 @@ static struct pci_driver vmd_drv = {
>  	.id_table	= vmd_ids,
>  	.probe		= vmd_probe,
>  	.remove		= vmd_remove,
> +	.shutdown	= vmd_shutdown,
>  	.driver		= {
>  		.pm	= &vmd_dev_pm_ops,
>  	},

Gentle ping.

Thanks

