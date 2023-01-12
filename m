Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF0366731E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 14:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjALNZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 08:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjALNZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 08:25:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1240939FA6;
        Thu, 12 Jan 2023 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673529932; x=1705065932;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p3rPgr2Z9Xd9luHOtsHA73LO8wGYECs1QllgzqWXlik=;
  b=luuMTLvaAh7c3FJUoso2VUDq9Eb00pI97fLO7ML7cmRtc3eyyGncsvC+
   kJ8b5MjhtblDZApGI5heI5yDWU2kSdNLADT1nYHKOsKAS+pKaghj5I+EX
   YSa35gNdojh2Ce56Ju1TchI2QIATJpd5VxF7MdjGSkQygM45IanZmSV6z
   BvltqA1I7OsoY9Et0hcIhyJP1wMrI7dB0LhAkeXq5alHolLsLBkeqpKhh
   CtwJqXs7DXBg/PHpbVY04WSUo8ufMCm/mhs4wibvRBrujJkMqfJuhnade
   whc3qXu0ZYFQb6LExsj81fc6nGLjnSG/n2+IpQoF/YnYXhEHMSeYsGpKk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="323763800"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="323763800"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:25:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="903191592"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="903191592"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.188.101]) ([10.252.188.101])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:25:28 -0800
Message-ID: <78a15f05-29d7-9dd3-175a-3915e7357c11@linux.intel.com>
Date:   Thu, 12 Jan 2023 21:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH 1/1] PCI: Add translated request only opt-in for
 pci_enable_pasid()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230112084629.737653-1-baolu.lu@linux.intel.com>
 <Y7//SDtnfXGHfior@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y7//SDtnfXGHfior@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/12 20:38, Jason Gunthorpe wrote:
> On Thu, Jan 12, 2023 at 04:46:29PM +0800, Lu Baolu wrote:
> 
>> -int pci_enable_pasid(struct pci_dev *pdev, int features);
>> +int pci_enable_pasid(struct pci_dev *pdev, int features, bool
>> transled_only);
> 
> Please use a named flag so we can grep for it..

Sure. What do you think of this naming?

+ * @flags: device-specific flags
+ *   - PCI_PASID_TRANSLED_REQ_ONLY: The PCI device only issues PASID
+ *                                  memory requests of translated type.

> Discuss in the commit message that this is a temporary step and that
> pci_enable_pasid() needs to be moved to the drivers

I will add below in commit message:

At present, it is a common practice to enable/disable PCI PASID in the
iommu drivers. Considering that the device driver knows more about the
specific device, we will follow up by moving pci_enable_pasid() into
the specific device drivers.

--
Best regards,
baolu
