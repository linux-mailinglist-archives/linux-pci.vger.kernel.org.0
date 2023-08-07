Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F10773057
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjHGUd4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGUdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 16:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8316210F6
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 13:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E3462208
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 20:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE89C433C7;
        Mon,  7 Aug 2023 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691440433;
        bh=y38hN5EEclw0PUar5Ep4X7eyWkPruUr/IdGCGlqUoIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y9C8mW+xhR59eCV+WBOs36X6h43LmCogopSONWvzb60lW0qtKfmiLifxzhAREeOJh
         7GLlI4qkn8kXlOWcxrs1IjZM/VtuKoaU2QK0n9hoDdasL4OxVKu9PRwMo4ZkJDn2sU
         iXSsr3VJ5GgVBPYdyfLxGmTYI2YZ57jC5euTqXW0nVsF5o6JhuerJwOYzqxQHO2HLU
         DLX+xtLrDcJEVrB/Q96oZQ32sHqKffPPCwJh1wxdV4QVSMoLCLIJXRxWaFu+BcfbTd
         OzVAhN8DN1Naj2n5peAKL9Vp2TYTQ9/uTS8bY4avnQ4V/tsB3ZNXW39iNd0PMjc+RH
         iZxsD7it+czqQ==
Date:   Mon, 7 Aug 2023 15:33:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bhelgaas@google.com, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, gregkh@linuxfoundation.org, ben.widawsky@intel.com,
        linux-pci@vger.kernel.org, yangyingliang@huawei.com,
        linuxppc-dev@lists.ozlabs.org, jonathan.cameron@huawei.com,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Add pci_find_next_dvsec_capability to find next
 designated VSEC
Message-ID: <20230807203351.GA269717@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807031846.77348-2-wangxiongfeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc David since drivers/platform/x86/intel/vsec.c does some similar
things, although it seems to iterate over all Intel DVSEC IDs at once]

In subject:

  PCI: Add pci_find_next_dvsec_capability() to find next Designated VSEC

On Mon, Aug 07, 2023 at 11:18:45AM +0800, Xiongfeng Wang wrote:
> Some devices may have several DVSEC(Designated Vendor-Specific Extended
> Capability) entries with the same DVSEC ID. Add
> pci_find_next_dvsec_capability() to find them all.

Add space between "DVSEC" and "(Designated ...)".

> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

so you can merge this along with the ocxl patch that uses it.

> ---
>  drivers/pci/pci.c   | 37 +++++++++++++++++++++++++------------
>  include/linux/pci.h |  2 ++
>  2 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..3455ca7306ae 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -749,35 +749,48 @@ u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
>  EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
>  
>  /**
> - * pci_find_dvsec_capability - Find DVSEC for vendor
> + * pci_find_next_dvsec_capability - Find next DVSEC for vendor
>   * @dev: PCI device to query
> + * @start: address at which to start looking (0 to start at beginning of list)

s/address/Address/ to match other parameters

>   * @vendor: Vendor ID to match for the DVSEC
>   * @dvsec: Designated Vendor-specific capability ID

There are a lot of IDs floating around here, so to better match the
spec language:

  @dvsec: Vendor-defined DVSEC ID

> - * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
> - * offset in config space; otherwise return 0.
> + * Returns the address of the next DVSEC if the DVSEC has Vendor ID @vendor and
> + * DVSEC ID @dvsec; otherwise return 0. DVSEC can occur several times with the
> + * same DVSEC ID for some devices, and this provides a way to find them all.
>   */
> -u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> +u16 pci_find_next_dvsec_capability(struct pci_dev *dev, u16 start, u16 vendor,
> +				   u16 dvsec)
>  {
> -	int pos;
> +	u16 pos = start;
>  
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
> -	if (!pos)
> -		return 0;
> -
> -	while (pos) {
> +	while ((pos = pci_find_next_ext_capability(dev, pos,
> +						  PCI_EXT_CAP_ID_DVSEC))) {
>  		u16 v, id;
>  
>  		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &v);
>  		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &id);
>  		if (vendor == v && dvsec == id)
>  			return pos;
> -
> -		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
>  	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(pci_find_next_dvsec_capability);
> +
> +/**
> + * pci_find_dvsec_capability - Find DVSEC for vendor
> + * @dev: PCI device to query
> + * @vendor: Vendor ID to match for the DVSEC
> + * @dvsec: Designated Vendor-specific capability ID
> + *
> + * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
> + * offset in config space; otherwise return 0.
> + */
> +u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> +{
> +	return pci_find_next_dvsec_capability(dev, 0, vendor, dvsec);
> +}
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c69a2cc1f412..82bb905daf72 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1168,6 +1168,8 @@ u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
>  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>  u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
>  u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
> +u16 pci_find_next_dvsec_capability(struct pci_dev *dev, u16 start, u16 vendor,
> +				   u16 dvsec);
>  
>  u64 pci_get_dsn(struct pci_dev *dev);
>  
> -- 
> 2.20.1
> 
