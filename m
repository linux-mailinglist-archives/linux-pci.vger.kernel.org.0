Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7C338197
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 00:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCKXjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 18:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhCKXim (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 18:38:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17B6264F7C;
        Thu, 11 Mar 2021 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615505922;
        bh=WTNMtBzBosw4mswkjqGuY/L4ZDTEMd5IPp0xg3s3ZEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kW4Mmu2mVUaozEg26xo+zfSDjivbNSdbrLOC2cMCM/ihiZo3fRr9/X3iDbXEHJ6sQ
         2YHTpFy7QM2nOlxDz/tOUQzEvwWOefK+NptAbimUPoB/6/EIP8+E8DI3sUG9lGtDoq
         fjo67bCZh37uDVLIZMCmxMep4eR1K+CbYUmbGxUCbnkb4TAKo1imZRMA67mvpYX26q
         8sBHIhkkE5LbHd0BxqqOtURlWSDhOeLHAZb9a0kVlejRei0vEcQxcPyRW7tXYIjTW6
         InBCp4qLl7Pwb9qlj+Hqh+cnHgjoAigSC9ILXiugTv5QgHkr5g2k7dFlqUFzgWeMsh
         NNS5S0XTN5nCQ==
Date:   Thu, 11 Mar 2021 17:38:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jay Fang <f.fangjian@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/8] PCI: endpoint: Fix kernel-doc formatting and add
 missing documentation
Message-ID: <20210311233840.GA2188908@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210311001724.423356-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 12:17:17AM +0000, Krzysztof Wilczyński wrote:
> Add missing documentation for the parameters "ntb_epc", "type", "dev",
> and "group" of the following functions:
> 
>   - epf_ntb_add_cfs()
>   - epf_ntb_alloc_peer_mem()
>   - epf_ntb_config_sspad_bar_clear(),
>   - epf_ntb_config_sspad_bar_set()
>   - epf_ntb_peer_spad_bar_clear()
>   - epf_ntb_peer_spad_bar_set()
>   - pci_epc_remove_epf()
> 
> Remove surplus parameter from the epf_ntb_init_epc_bar() function.
> 
> Additionally, fix a non-compliant kernel-doc at the top of the files
> pci-epf-ntb.c and pci-epf-test.c, and resolve number of build time
> warnings related to kernel-doc:
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:1363: warning: Function
>  parameter or member 'dev' not described in 'epf_ntb_alloc_peer_mem'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:2046: warning: Function
>  parameter or member 'group' not described in 'epf_ntb_add_cfs'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:1670: warning: Excess
>  function parameter 'type' description in 'epf_ntb_init_epc_bar'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:45: warning: cannot
>  understand function prototype: 'struct workqueue_struct
>  *kpcintb_workqueue; '
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:727: warning: Excess
>  function parameter 'ntb' description in 'epf_ntb_peer_spad_bar_clear'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:727: warning: Function
>  parameter or member 'ntb_epc' not described in
>  'epf_ntb_peer_spad_bar_clear'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:771: warning: Function
>  parameter or member 'type' not described in 'epf_ntb_peer_spad_bar_set'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:839: warning: Excess
>  function parameter 'ntb' description in
>  'epf_ntb_config_sspad_bar_clear'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:839: warning: Function
>  parameter or member 'ntb_epc' not described in
>  'epf_ntb_config_sspad_bar_clear'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:882: warning: Excess
>  function parameter 'ntb' description in 'epf_ntb_config_sspad_bar_set'
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c:882: warning: Function
>  parameter or member 'ntb_epc' not described in
>  'epf_ntb_config_sspad_bar_set'
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c:22: warning: expecting
>  prototype for Test driver to test endpoint functionality(). Prototype
>  was for IRQ_TYPE_LEGACY() instead
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied all to pci/kernel-doc, thanks!  I squashed them into one patch
since these only change comments.

> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 16 +++++++++++-----
>  drivers/pci/endpoint/functions/pci-epf-test.c |  2 +-
>  drivers/pci/endpoint/pci-epc-core.c           |  2 ++
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 338148cf56f5..bce274d02dcf 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * Endpoint Function Driver to implement Non-Transparent Bridge functionality
>   *
>   * Copyright (C) 2020 Texas Instruments
> @@ -696,7 +696,8 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  /**
>   * epf_ntb_peer_spad_bar_clear() - Clear Peer Scratchpad BAR
> - * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> + * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
> + *	     address.
>   *
>   *+-----------------+------->+------------------+        +-----------------+
>   *|       BAR0      |        |  CONFIG REGION   |        |       BAR0      |
> @@ -740,6 +741,7 @@ static void epf_ntb_peer_spad_bar_clear(struct epf_ntb_epc *ntb_epc)
>  /**
>   * epf_ntb_peer_spad_bar_set() - Set peer scratchpad BAR
>   * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> + * @type: PRIMARY interface or SECONDARY interface
>   *
>   *+-----------------+------->+------------------+        +-----------------+
>   *|       BAR0      |        |  CONFIG REGION   |        |       BAR0      |
> @@ -808,7 +810,8 @@ static int epf_ntb_peer_spad_bar_set(struct epf_ntb *ntb,
>  
>  /**
>   * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
> - * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> + * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
> + *	     address.
>   *
>   * +-----------------+------->+------------------+        +-----------------+
>   * |       BAR0      |        |  CONFIG REGION   |        |       BAR0      |
> @@ -851,7 +854,8 @@ static void epf_ntb_config_sspad_bar_clear(struct epf_ntb_epc *ntb_epc)
>  
>  /**
>   * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
> - * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> + * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
> + *	     address.
>   *
>   * +-----------------+------->+------------------+        +-----------------+
>   * |       BAR0      |        |  CONFIG REGION   |        |       BAR0      |
> @@ -1312,6 +1316,7 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
>  
>  /**
>   * epf_ntb_alloc_peer_mem() - Allocate memory in peer's outbound address space
> + * @dev: The PCI device.
>   * @ntb_epc: EPC associated with one of the HOST whose BAR holds peer's outbound
>   *   address
>   * @bar: BAR of @ntb_epc in for which memory has to be allocated (could be
> @@ -1660,7 +1665,6 @@ static int epf_ntb_init_epc_bar_interface(struct epf_ntb *ntb,
>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
>   * constructs (scratchpad region, doorbell, memorywindow)
>   * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> - * @type: PRIMARY interface or SECONDARY interface
>   *
>   * Wrapper to epf_ntb_init_epc_bar_interface() to identify the free BARs
>   * to be used for each of BAR_CONFIG, BAR_PEER_SPAD, BAR_DB_MW1, BAR_MW2,
> @@ -2037,6 +2041,8 @@ static const struct config_item_type ntb_group_type = {
>  /**
>   * epf_ntb_add_cfs() - Add configfs directory specific to NTB
>   * @epf: NTB endpoint function device
> + * @group: A pointer to the config_group structure referencing a group of
> + *	   config_items of a specific type that belong to a specific sub-system.
>   *
>   * Add configfs directory specific to NTB. This directory will hold
>   * NTB specific properties like db_count, spad_count, num_mws etc.,
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index c0ac4e9cbe72..63d5f5c6e3e0 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * Test driver to test endpoint functionality
>   *
>   * Copyright (C) 2017 Texas Instruments
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index cc8f9eb2b177..adec9bee72cf 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -594,6 +594,8 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
>   * pci_epc_remove_epf() - remove PCI endpoint function from endpoint controller
>   * @epc: the EPC device from which the endpoint function should be removed
>   * @epf: the endpoint function to be removed
> + * @type: identifies if the EPC is connected to the primary or secondary
> + *        interface of EPF
>   *
>   * Invoke to remove PCI endpoint function from the endpoint controller.
>   */
> -- 
> 2.30.1
> 
