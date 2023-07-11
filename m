Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10874E366
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 03:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGKBUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 21:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjGKBUY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 21:20:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB41702;
        Mon, 10 Jul 2023 18:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689038390; x=1720574390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Jk3aIBS+9PB9JIDXm4r6oO/JZ67Qw3aGXU4GHLUXdk=;
  b=kO+TmFE3eEMKcalTv7QQI8FenJQy6RFjvu39MfNCI3iuh4gNfMfTDteP
   9dA71zlGL7riSqnz5UYpS0VWE2KnCbJsymUVCH3nZyiMu4IyDYu0/DYqK
   iD9kbw4cuAVnioj9A6QsS0ZxsRwfzcqg6/kr4slY/Nz+5LG4YA5lmJ79O
   5kExgSV/MPNLp+xyXzAaJSiHo1Rd2dztHpIsz0MMtwlgt0wwra9J+6nyJ
   vE/TU1ePedVbKQwPHHPEAbvTlRNN5s6Rp4UHPm0d7HrJ+aWs9A5O44Sal
   FxMZ5ecxfX1p2Q/oGXkMQqaltetg9QsF7iBlt4MhTJnnj9sRInCzWReNm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364536237"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364536237"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714997660"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="714997660"
Received: from csalvo-mobl1.amr.corp.intel.com (HELO [10.209.61.210]) ([10.209.61.210])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:18:25 -0700
Message-ID: <6bf0dfc7-b865-343b-4f2a-7624f3178541@linux.intel.com>
Date:   Mon, 10 Jul 2023 18:18:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] PCI/AER: Remove/unexport error reporting
 enable/disable
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230710232136.233034-1-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230710232136.233034-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/10/23 4:21 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_disable_pcie_error_reporting() is unused; remove it.
> pci_enable_pcie_error_reporting() is used only inside aer.c; make it
> static.

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Bjorn Helgaas (2):
>   PCI/AER: Drop unused pci_disable_pcie_error_reporting()
>   PCI/AER: Unexport pci_enable_pcie_error_reporting()
> 
>  drivers/pci/pcie/aer.c | 15 +--------------
>  include/linux/aer.h    | 11 -----------
>  2 files changed, 1 insertion(+), 25 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
