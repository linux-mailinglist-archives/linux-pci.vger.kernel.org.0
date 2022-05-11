Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50886524121
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349389AbiEKXjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 19:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349382AbiEKXjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 19:39:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6B6D951;
        Wed, 11 May 2022 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652312353; x=1683848353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DHCdBsPB20Xiig5HcLQMEK/s5Y3wvRIIRVn7Np5YH4g=;
  b=LVakchHQihewWbJ97HCfwY3jW40qfEQTBq7CYLBoAyalYixV9KRHf34F
   T8hKQIW0vSu6Ctdf6A1LlNcvE7th0U3JW+KfH7NI5/drVd3Ok00VNRikk
   DJj22NcFxdVDw2xH+73jDWxuueEkheue8C8XEC9JExHwYF+T/KiWu+pso
   PIPwA3umZpN/9/Axk5T2Kha6FOzXTEVePMCdOkcawEUL3vKla4gJ86R7h
   cYr+29mZKIMw+N0hdhgz485NDZbo8XP02hOoT/gBOVJ71xbLBuCnJ84wA
   2jbwNqoQ4hhbPKgs+gwIZuyOnySdF5ma6GcJiMIbFWySy12dQkafkjSEn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269778528"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269778528"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 16:39:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="572290902"
Received: from wancheny-mobl.amr.corp.intel.com (HELO [10.209.114.21]) ([10.209.114.21])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 16:39:11 -0700
Message-ID: <2b3ab214-0bcd-070a-f80a-5e0cf10cb339@linux.intel.com>
Date:   Wed, 11 May 2022 16:39:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3] PCI/AER: Handle Multi UnCorrectable/Correctable errors
 properly
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220511232757.GA829078@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220511232757.GA829078@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/11/22 4:27 PM, Bjorn Helgaas wrote:
>> [Eric: proposed reproducing steps]
>> Fixes: 4696b828ca37 ("PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/")
> 4696b828ca37 only*moves*  drivers/pci/pcie/aer/aerdrv.c to
> drivers/pci/pcie/aer.c, so I don't think it's related.
> 
> I think the actual change of interest is e167bfcaa4cd ("PCI: aerdrv:
> remove magical ROOT_ERR_STATUS_MASKS") [1].  It looks like we did
> exactly what you propose before that commit.
> 
> I can update this unless you disagree.
> 
> [1]https://git.kernel.org/linus/e167bfcaa4cd
> 

Agree. Please update it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
