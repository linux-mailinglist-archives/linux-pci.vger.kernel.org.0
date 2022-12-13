Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9443264B1C4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 10:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiLMJDL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 04:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiLMJCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 04:02:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D1101E3;
        Tue, 13 Dec 2022 01:01:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A07CFB80E74;
        Tue, 13 Dec 2022 09:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8E3C433D2;
        Tue, 13 Dec 2022 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670922111;
        bh=ugJ9EudNO8O4g9YDbaM5iL07R/ZNdyAX0iB+zThx96A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+ux9GFQo6LDGack0d4O96LGUd9s+3gZrjXgv/TaH4stFtzaV3PCVQK7kyDz49scY
         pB3GkHAm1rANpB5nuMHRlwgrdUjqB9a3ByIHEoM/3FPOWzaHeTQxC+VoxlOBv5aQIn
         v+iCRJJEE078K01h/0Dj9m12A0KcM3aUehXc0MUdYGhSu+FRHRxPsd3Q9d9fytko7m
         qY01OrNRsTfJgMhWu82IdVFMwCAsMWz5JFmps3+5UTgH6JRPgw9t/wtU5CnzQCha1y
         GVBLcvfGO6f0CrkwoqKwZFJS1wUaXOnO065t+wJuqrkR2tMJb2Tpo8I+UvaoPMaLg4
         Yb6rSh2z4zZRQ==
Date:   Tue, 13 Dec 2022 11:01:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Liming Wu <liming.wu@jaguarmicro.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        398776277@qq.com
Subject: Re: [PATCH] PCI/IOV: Expose error return to dmesg
Message-ID: <Y5g/eo3Z7xy3COzn@unreal>
References: <20221213081607.1641-1-liming.wu@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213081607.1641-1-liming.wu@jaguarmicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 13, 2022 at 04:16:07PM +0800, Liming Wu wrote:
> There are many errors returned during the initialization of sriov,
> such as -EIO/-ENOMEM, but they are not exposed to dmesg.
> Let's expose the real errors to the user.

Please provide motivation. It is pretty easy to see what went wrong
even without info print in dmesg.

> 
> In addition, -ENODEV doesn't make much sense and is not returned
> just like any other capabilities.
> 
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  drivers/pci/iov.c   | 9 ++++++---
>  drivers/pci/pci.h   | 2 --
>  drivers/pci/probe.c | 6 +++++-
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 952217572113..519aa2b48236 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -767,8 +767,11 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
>  
>  	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
> -	if (!total)
> +	if (!total) {
> +		pci_info(dev, "SR-IOV capability is enabled but has %d VFs)\n",
> +			total);

total is always 0 in this print.

>  		return 0;
> +	}
>  
>  	pci_read_config_dword(dev, pos + PCI_SRIOV_SUP_PGSIZE, &pgsz);
>  	i = PAGE_SHIFT > 12 ? PAGE_SHIFT - 12 : 0;
> @@ -899,13 +902,13 @@ int pci_iov_init(struct pci_dev *dev)
>  	int pos;
>  
>  	if (!pci_is_pcie(dev))
> -		return -ENODEV;
> +		return;

Please at least compile patches before you send them.

>  
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
>  	if (pos)
>  		return sriov_init(dev, pos);
>  
> -	return -ENODEV;
> +	return;
>  }
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b1ebb7ab8805..c4836104f697 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -485,10 +485,8 @@ extern const struct attribute_group sriov_vf_dev_attr_group;
>  #else
>  static inline int pci_iov_init(struct pci_dev *dev)
>  {
> -	return -ENODEV;
>  }
>  static inline void pci_iov_release(struct pci_dev *dev)
> -
>  {
>  }
>  static inline void pci_iov_remove(struct pci_dev *dev)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b66fa42c4b1f..c951e0a50388 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2449,6 +2449,7 @@ void pcie_report_downtraining(struct pci_dev *dev)
>  
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
> +	int ret;
>  	pci_ea_init(dev);		/* Enhanced Allocation */
>  	pci_msi_init(dev);		/* Disable MSI */
>  	pci_msix_init(dev);		/* Disable MSI-X */
> @@ -2459,7 +2460,10 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_pm_init(dev);		/* Power Management */
>  	pci_vpd_init(dev);		/* Vital Product Data */
>  	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
> -	pci_iov_init(dev);		/* Single Root I/O Virtualization */
> +	ret = pci_iov_init(dev);		/* Single Root I/O Virtualization */
> +	if (ret)
> +		pci_err(dev, "SR-IOV: init failed (%d)\n", ret);
> +
>  	pci_ats_init(dev);		/* Address Translation Services */
>  	pci_pri_init(dev);		/* Page Request Interface */
>  	pci_pasid_init(dev);		/* Process Address Space ID */
> -- 
> 2.25.1
> 
