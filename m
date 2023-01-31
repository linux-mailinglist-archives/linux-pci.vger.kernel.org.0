Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6A682C82
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 13:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjAaMZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 07:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAaMZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 07:25:13 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00CD49437;
        Tue, 31 Jan 2023 04:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675167910; x=1706703910;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xwpytf7n2WVkp5REBbivE5cf38oXPNvYW56xA7xKr2k=;
  b=lCrGO3LI3Aj0itywazpmJE80skLzQauTMtQjU43Ph2SIIAYasqOer9h2
   xk/KceaYTqv7j+9S0xis+EGKDVQHBo7L49vHSUV7k24vqIviniFqymG65
   2yLqJUBSp48EjmGD3UoQefqkLgdAKhJMdTy6IZG1lvwT4a9gUIc3dUbzE
   Jl1CEDOmnVSRjiX+Efgiydp0L/wwmu0vcZUNDpgJuKkuigVTgMgmaRUjj
   KArWtMdsyPVlfwRa30YWQmNkJUPGAJRkYSeWcQabak6wmiSOIQPRQjc/w
   JDvOGF1YB0pw3UAEO2u9QJ7nCrDZGtSQq4kyed7c1wzO7bjuzsGcf18oJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390188361"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390188361"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:25:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657853563"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657853563"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.172.41]) ([10.249.172.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:25:07 -0800
Message-ID: <8cb478bf-db44-0a8f-8521-771529ca0706@linux.intel.com>
Date:   Tue, 31 Jan 2023 20:25:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230130183810.GA1692786@bhelgaas>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230130183810.GA1692786@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/31 2:38, Bjorn Helgaas wrote:
> PCIe r6.0, sec 6.20.1:
> 
>    A Function is not permitted to generate Requests using Translated
>    Addresses and a PASID unless both PASID Enable and Translated
>    Requests with PASID Enable are Set.
> 
> You want AMD graphics devices to do DMA with translated addresses and
> PASID, right?  pci_enable_pasid() sets PASID Enable
> (PCI_PASID_CTRL_ENABLE), but I don't see where "Translated Requests
> with PASID Enable" is set.  We don't even have a #define for it.
> 
> I would think we should check "Translated Requests with PASID
> Supported" before setting "Translated Requests with PASID Enable",
> too?

This seems to be an ECN for PCIe 5.x:

https://members.pcisig.com/wg/PCI-SIG/document/14929

What I read from this ECN is that,

With this ECN, translated memory requests for PASIDs are not allowed to
carry a PASID prefix if "Translated Requests with PASID Enabled" is not
set. It does not mean whether the device can generate translated memory
requests for PASID, but whether the memory request can carry a PASID
prefix.

Best regards,
baolu
