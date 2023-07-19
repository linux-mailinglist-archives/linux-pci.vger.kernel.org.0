Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3FD759FE8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 22:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGSUgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 16:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGSUgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 16:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2792112;
        Wed, 19 Jul 2023 13:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FE061827;
        Wed, 19 Jul 2023 20:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1345C433C7;
        Wed, 19 Jul 2023 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798963;
        bh=XrQ/pPRSHvXh7lxVqpPGBAZ3IM9RShfrP9G5GJYGNpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DNI2J6H+YnMEsoWAuadSAWPeYD7tM3mWfNvpmrOqbG1twEQ6KZveIJI5Rz/s3zJKU
         6XonmkQXwNQly5B4kySr9PK279KtmwSNiUufvrkBIjVw9HoQxtZlOuy/QoAIOUnmWN
         lNvuHwtCTcL5705avEj+eL1IjBlhUCnMsc+RN8T7kh9ESH5xNQ1lAOw7a3KwkKugzt
         uHZojok/KrXl6Q0Cp925GujyX3nbsf+BQWMvTT6bklPboEyCZbvrjwFkWR7oMyOpu9
         Tfb1h4EbTIhIoUbp5tFYjnPZIoPwXL/4bf4oviI2vOna7wSUhi/p79rBkjx8WZ+xT+
         i7SEgldqHzc4g==
Date:   Wed, 19 Jul 2023 15:36:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        oohall@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH 1/2] PCI, AER: Export and make pcie_aer_is_native() global
Message-ID: <20230719203600.GA514279@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719192313.38591-2-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 07:23:12PM +0000, Smita Koralahalli wrote:
> Export and move the declaration of pcie_aer_is_native() to a common header
> file to be reused by cxl/pci module.

Run "git log --oneline drivers/pci/pcie/aer.c" and format your subject
line to match.

"Exporting" pretty much means making it global, so "Export
pcie_aer_is_native()" is probably enough.

> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

With the above,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/aer.c     | 1 +
>  drivers/pci/pcie/portdrv.h | 2 --
>  include/linux/aer.h        | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..87d90dbda023 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -229,6 +229,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  
>  	return pcie_ports_native || host->native_aer;
>  }
> +EXPORT_SYMBOL_GPL(pcie_aer_is_native);
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 58a2b1a1cae4..1f3803bde7ee 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -29,10 +29,8 @@ extern bool pcie_ports_dpc_native;
>  
>  #ifdef CONFIG_PCIEAER
>  int pcie_aer_init(void);
> -int pcie_aer_is_native(struct pci_dev *dev);
>  #else
>  static inline int pcie_aer_init(void) { return 0; }
> -static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
>  #ifdef CONFIG_HOTPLUG_PCI_PCIE
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 3a3ab05e13fd..94ce49a5f8d5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -45,6 +45,7 @@ struct aer_capability_regs {
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +int pcie_aer_is_native(struct pci_dev *dev);
>  #else
>  static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> @@ -58,6 +59,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
>  void cper_print_aer(struct pci_dev *dev, int aer_severity,
> -- 
> 2.17.1
> 
