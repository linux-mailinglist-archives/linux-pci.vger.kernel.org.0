Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCB6665B2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 22:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjAKVmY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 16:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjAKVmX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 16:42:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E0D1EC56;
        Wed, 11 Jan 2023 13:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673473342; x=1705009342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bcAWwGCMXT32qahjM/225JG23YMKXua4UF2lHbC3gRc=;
  b=Pi2lRVAxQhhi1/9nbxnzA1cd0x7bzYeOn2jVa5nTa+6BYUe+DPMiP7zV
   kJw0LE+hxskTeIP7yEnfTzY663wlxagtx+FJgMGTdgvdSTHE0THkU5nH1
   xzutiwK40MxFm9kRNZADLAO8EYTd9uwEMmKB83VyLlHOf+ibx3RZUiAJC
   dpBMvfizL/eLWEIyuEiR/uPOhXOZTixA49xZaOQqmgRiWGo7fT0VMGFSu
   ttEfVbYiYQ/hJiLXTzkOY1lePMZcC76uib6vWRHaxs87oi3jlroBxSpO0
   fxxScGdlc9YbY+TlCVePEMubB+TGvUxEp7i2cr4+6n6FOtfP6DDk1EW1V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303238993"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303238993"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 13:42:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="689903563"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="689903563"
Received: from jguerber-mobl1.amr.corp.intel.com (HELO [10.209.5.105]) ([10.209.5.105])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 13:42:21 -0800
Message-ID: <a9126d49-6e98-956c-f4a3-699cc86d8b11@linux.intel.com>
Date:   Wed, 11 Jan 2023 13:42:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V1] PCI/AER: Configure ECRC only AER is native
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, treding@nvidia.com,
        jonathanh@nvidia.com
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, vsethi@nvidia.com, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230111203116.4896-1-vidyas@nvidia.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230111203116.4896-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/11/23 12:31 PM, Vidya Sagar wrote:
> As the ECRC configuration bits are part of AER registers, configure
> ECRC only if AER is natively owned by the kernel.

ecrc command line option takes "bios/on/off" as possible options. It
does not clarify whether "on/off" choices can only be used if AER is
owned by OS or it can override the ownership of ECRC configuration 
similar to pcie_ports=native option. Maybe that needs to be clarified.

> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/pcie/aer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e2d8a74f83c3..730b47bdcdef 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -184,6 +184,9 @@ static int disable_ecrc_checking(struct pci_dev *dev)
>   */
>  void pcie_set_ecrc_checking(struct pci_dev *dev)
>  {
> +	if (!pcie_aer_is_native(dev))
> +		return;
> +
>  	switch (ecrc_policy) {
>  	case ECRC_POLICY_DEFAULT:
>  		return;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
