Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F296272B961
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjFLH6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjFLH56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 03:57:58 -0400
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:101:465::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76E173C
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2023 00:56:47 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Qfk374QD2z9sQx;
        Mon, 12 Jun 2023 09:34:27 +0200 (CEST)
Message-ID: <801f2422-0e79-65dc-154f-6b656e249753@denx.de>
Date:   Mon, 12 Jun 2023 09:34:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] PCI: Unexport pci_save_aer_state()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230609222500.1267795-1-helgaas@kernel.org>
 <20230609222500.1267795-2-helgaas@kernel.org>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20230609222500.1267795-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/10/23 00:24, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_save_aer_state() and pci_restore_aer_state() are only used in
> drivers/pci, so don't expose them to the rest of the kernel.  No functional
> change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/pci/pci.h   | 4 ++++
>   include/linux/aer.h | 4 ----
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2475098f6518..a97a735e6623 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -686,6 +686,8 @@ extern const struct attribute_group aer_stats_attr_group;
>   void pci_aer_clear_fatal_status(struct pci_dev *dev);
>   int pci_aer_clear_status(struct pci_dev *dev);
>   int pci_aer_raw_clear_status(struct pci_dev *dev);
> +void pci_save_aer_state(struct pci_dev *dev);
> +void pci_restore_aer_state(struct pci_dev *dev);
>   #else
>   static inline void pci_no_aer(void) { }
>   static inline void pci_aer_init(struct pci_dev *d) { }
> @@ -693,6 +695,8 @@ static inline void pci_aer_exit(struct pci_dev *d) { }
>   static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>   static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>   static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
> +static inline void pci_save_aer_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>   #endif
>   
>   #ifdef CONFIG_ACPI
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 97f64ba1b34a..3a3ab05e13fd 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -45,8 +45,6 @@ struct aer_capability_regs {
>   int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>   int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> -void pci_save_aer_state(struct pci_dev *dev);
> -void pci_restore_aer_state(struct pci_dev *dev);
>   #else
>   static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>   {
> @@ -60,8 +58,6 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>   {
>   	return -EINVAL;
>   }
> -static inline void pci_save_aer_state(struct pci_dev *dev) {}
> -static inline void pci_restore_aer_state(struct pci_dev *dev) {}
>   #endif
>   
>   void cper_print_aer(struct pci_dev *dev, int aer_severity,

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
