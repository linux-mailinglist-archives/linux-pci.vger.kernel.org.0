Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914A85A6880
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiH3Qg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 12:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiH3Qg1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 12:36:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41753A9C24;
        Tue, 30 Aug 2022 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661877386; x=1693413386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JQcuXMXfnMd8wurcg9NxfmRdRvyNP0uZVbqes8AUE34=;
  b=UfFfzEYmFNND2ohydjDAyLhZHIx334fOj6ktvvU45+XSIWhMK7XZ7Cad
   u2AkUwZMyAKEbltb9rwoKn+GTyQ86Nv633Gp5/cQgpphDHQ+NAfTORdWc
   M6GYjqTk2JV1Y2zif1CjE9oFrzlC3Fv+lMbMMIQZELABAwgbaTAjigPt0
   7PHShfKGAxOcWMhjjuw1B5jDsH5FxPR7lDKR8r2s9IgwUJ48l0Q3PMaFC
   Bm9JpSMpoyEUsq0SoFRaOTEaWGqNIifv2bdukwhtjX/cKF5+j/7Map/Nt
   Y4yLY4r8wh4I9dTr3C4SYbjwW7judGHlQOKsB8/Qd0zUoL69xvAFOKW5O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278251872"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="278251872"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:30:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="588678249"
Received: from lzaino-mobl1.amr.corp.intel.com (HELO [10.212.130.115]) ([10.212.130.115])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:30:32 -0700
Message-ID: <1edc5cf3-c629-a7ed-4531-3c814367c004@linux.intel.com>
Date:   Tue, 30 Aug 2022 09:30:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI: Disable PTM on Upstream Ports during suspend
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220830155224.103907-1-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220830155224.103907-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/30/22 8:52 AM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> During suspend, we want to disable PTM on Root Ports because that allows
> some chips, e.g., Intel mobile chips since Coffee Lake, to enter a
> lower-power PM state.
> 
> Previously we only disabled PTM for Root Ports, but PCIe r6.0, sec 2.2.8,
> strongly recommends that functions support generation of Messages in non-D0
> states, so we must assume that Switch Upstream Ports or Endpoints may send
> PTM Request Messages while in D1, D2, and D3hot.
> 
> A PTM Message received by a Downstream Port, e.g., a Root Port, with PTM
> disabled must be treated as an Unsupported Request (sec 6.21.3).
> 
> With this topology:
> 
>   0000:00:1d.0 Root Port              to [bus 08-71]
>   0000:08:00.0 Switch Upstream Port   to [bus 09-71]
> 
> Kai-Heng reported errors like this:
> 
>   pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
>   pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
>   pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
>   pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
>   pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> 
> Decoding this (from PCIe r6.0, sec 2.2.1.1, 2.2.8.10) shows that 00:1d.0
> logged an Unsupported Request error when it received a PTM Request with
> Requester ID 08:00.0.
> 
> To prevent this error, disable PTM when suspending Upstream Ports
> (including those on Endpoints), not just Root Ports.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
> Based-on: https://lore.kernel.org/r/20220706123244.18056-1-kai.heng.feng@canonical.com
> Based-on-patch-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---

Looks good to me

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pci.c      | 30 ++++++++++++++----------------
>  drivers/pci/pcie/ptm.c |  8 +++++++-
>  2 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..96487a9ce5bf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2707,14 +2707,19 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>  		return -EIO;
>  
>  	/*
> -	 * There are systems (for example, Intel mobile chips since Coffee
> -	 * Lake) where the power drawn while suspended can be significantly
> -	 * reduced by disabling PTM on PCIe root ports as this allows the
> -	 * port to enter a lower-power PM state and the SoC to reach a
> -	 * lower-power idle state as a whole.
> +	 * We want to disable PTM on Root Ports because that allows some
> +	 * chips, e.g., Intel mobile chips since Coffee Lake, to enter a
> +	 * lower-power PM state.
> +	 *
> +	 * PCIe r6.0, sec 2.2.8, strongly recommends that functions support
> +	 * generation of messages in non-D0 states, so we assume Switch
> +	 * Upstream Ports or Endpoints may send PTM Requests while in D1,
> +	 * D2, and D3hot.  A PTM message received by a Downstream Port
> +	 * (including a Root Port) with PTM disabled must be treated as an
> +	 * Unsupported Request (sec 6.21.3).  To prevent this error,
> +	 * disable PTM in *all* devices, not just Root Ports.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> +	pci_disable_ptm(dev);
>  
>  	pci_enable_wake(dev, target_state, wakeup);
>  
> @@ -2764,15 +2769,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>  	if (target_state == PCI_POWER_ERROR)
>  		return -EIO;
>  
> -	/*
> -	 * There are systems (for example, Intel mobile chips since Coffee
> -	 * Lake) where the power drawn while suspended can be significantly
> -	 * reduced by disabling PTM on PCIe root ports as this allows the
> -	 * port to enter a lower-power PM state and the SoC to reach a
> -	 * lower-power idle state as a whole.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> +	/* See rationale above for disabling PTM */
> +	pci_disable_ptm(dev);
>  
>  	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>  
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 368a254e3124..ec338470d13f 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -31,12 +31,18 @@ static void pci_ptm_info(struct pci_dev *dev)
>  
>  void pci_disable_ptm(struct pci_dev *dev)
>  {
> -	int ptm;
> +	int type, ptm;
>  	u16 ctrl;
>  
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	type = pci_pcie_type(dev);
> +	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
> +	      type == PCI_EXP_TYPE_UPSTREAM ||
> +	      type == PCI_EXP_TYPE_ENDPOINT))
> +		return;
> +
>  	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
>  	if (!ptm)
>  		return;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
