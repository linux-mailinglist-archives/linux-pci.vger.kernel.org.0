Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A065A4EB631
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 00:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiC2Wt4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 18:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiC2Wt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 18:49:56 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9960B11E
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648594091; x=1680130091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=34tgiB6n+RNUTw7P9CWJ4baO4naZ5smc6iaeQuIKAwQ=;
  b=kSmuNE2D9jeJvh0hgoaCcpNxeDqbkLp4yjLC8Ot+WY5VbfjZIivfHRtE
   CmnGHw7d5WPGJaAiqZLLT3jyc0rgPimb1Zzxs2EDTM7h6mn2VicjIzraE
   YnGw/rw2JRZqDFtSHWLDIPl6HHKWmTIMLVQHVE04BpHKizp3w8geAEA0S
   jqunqpCqSb5NS2zDnr/dmsOFYtk29fZQDQ7Hw4MjGodENHWi3OaNr7WF1
   ew7i6UytDTaZ8Ov0quY0zZ4GEJE/crLTFc7ZpyBfDfepzk23LHDPwNKd2
   URVNp/8gHOhA3m+i/JJZnHe0pOM7oBEfsDJhgEzd6s1WHASF1vKOseAFy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="320091276"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="320091276"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:47:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="521642509"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.64.125]) ([10.212.64.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:47:46 -0700
Message-ID: <6b2b0c52-4b01-db11-1c89-ab291ae633b3@linux.intel.com>
Date:   Tue, 29 Mar 2022 15:47:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Content-Language: en-US
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@intel.com>
References: <20220316155103.8415-1-nirmal.patel@intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20220316155103.8415-1-nirmal.patel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/16/2022 8:51 AM, Nirmal Patel wrote:
> From: Nirmal Patel <nirmal.patel@linux.intel.com>
>
> VMD creates and assigns a separate IRQ domain only when MSI remapping is
> enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
> MSI remapping is disabled resulting child devices getting default
> PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
> intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
> including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
> when VMD create a root bus and configures child devices.
>
> As a result DMAR errors were observed when interrupt remapping was
> enabled on Intel Icelake CPUs. For instance:
>
>   DMAR: DRHD: handling fault status reg 2
>   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cc166c683638..3a6570e5b765 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -853,6 +853,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> +	else
> +		dev_set_msi_domain(&vmd->bus->dev, dev_get_msi_domain(&vmd->dev->dev));
>  
>  	vmd_acpi_begin();
>  

Gentle ping!

Thanks
nirmal

