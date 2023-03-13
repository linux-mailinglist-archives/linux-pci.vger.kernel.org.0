Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61836B84C8
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 23:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCMWa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 18:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCMWa6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 18:30:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181166BC0E;
        Mon, 13 Mar 2023 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678746656; x=1710282656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wy8waehC/z5moRguHZkcu1bzEjQegrqBjVJFWKVXeM8=;
  b=mXjLZdfQsoo3YXSIyayARLah4kkAxIXtJPq0RYCUne4o5WPx0iAUfqzL
   6KpvUeK529DYHxCFImLYRUQywvqrlrRxUhu3aQP1C4Hbq/slTHnc7xK4u
   K6WgWAzTQ4fTGTNV3wGKyc7uddKfzF1nkeellTh4zhT9CHFZOA+mR7rTl
   hNDHlgm6hBAzgWmEwGEyyp+zXcOi4J13fcbcF33itxsCTC588WpK4YG87
   zManp2+7L4Cjgxd21/sK9QonIlI3DCMLJDycC0b54h4a+F3huBtUDy/8Q
   bPcTZx0tLpTwCm8aOv/Cn+XoolEfIzi5BiNY/pN8vNAFbXqzLeyLQW+nu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337299616"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="337299616"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="1008169871"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="1008169871"
Received: from prasadjo-mobl.amr.corp.intel.com (HELO [10.212.247.133]) ([10.212.247.133])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:30:31 -0700
Message-ID: <6339c50a-8dfe-f3a2-63d7-504abd4e62f0@linux.intel.com>
Date:   Mon, 13 Mar 2023 15:30:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230313211201.GA1540091@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230313211201.GA1540091@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kulkarni,

On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
>> As per PCI specification (PCI Express Base Specification Revision
>> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
>> independently for ATS capability, however the STU(Smallest Translation
>> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
>> the associated PF's value applies to VFs.
>>
>> In the current code, the STU is being configured while enabling the PF ATS.
>> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
>> associated PF already.
>>
>> Adding a function pci_ats_stu_configure(), which can be called to
>> configure the STU during PF enumeration.
>> Latter enumerations of VFs can successfully enable ATS independently.
> 
> s/STU(Smallest/STU (Smallest/ (add space before paren)
> s/Adding a function pci_ats_stu_configure()/Add pci_ats_stu_configure()/
> s/Latter/Subsequent/
> 
> Add blank line between paragraphs (it looks like "Latter enumerations"
> is intended to start a new paragraph).
> 
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Given an ack for the IOMMU patch, I'd be happy to merge both (and I
> can do the commit log tweaks); just let me know.
> 
> One comment/question below.
> 
>> ---
>>  drivers/pci/ats.c       | 33 +++++++++++++++++++++++++++++++--
>>  include/linux/pci-ats.h |  3 +++
>>  2 files changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index f9cc2e10b676..1611bfa1d5da 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(pci_ats_supported);
>>  
>> +/**
>> + * pci_ats_stu_configure - Configure STU of a PF.
>> + * @dev: the PCI device
>> + * @ps: the IOMMU page shift
>> + *
>> + * Returns 0 on success, or negative on failure.
>> + */
>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>> +{
>> +	u16 ctrl;
>> +
>> +	if (dev->ats_enabled || dev->is_virtfn)
>> +		return 0;
> 
> I might return an error for the VF case on the assumption that it's
> likely an error in the caller.  I guess one could argue that it
> simplifies the caller if it doesn't have to check for PF vs VF.  But
> the fact that STU is shared between PF and VFs is an important part of
> understanding how ATS works, so the caller should be aware of the
> distinction anyway.

I have already asked this question. But let me repeat it.

We don't have any checks for the PF case here. That means you can re-configure
the STU as many times as you want until ATS is enabled in PF. So, if there are
active VFs which uses this STU, can PF re-configure the STU at will?

> 
>> +
>> +	if (!pci_ats_supported(dev))
>> +		return -EINVAL;
>> +
>> +	if (ps < PCI_ATS_MIN_STU)
>> +		return -EINVAL;
>> +
>> +	dev->ats_stu = ps;
>> +	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>> +	ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>> +	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>> +
>>  /**
>>   * pci_enable_ats - enable the ATS capability
>>   * @dev: the PCI device
>> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>  		return -EINVAL;
>>  
>>  	/*
>> -	 * Note that enabling ATS on a VF fails unless it's already enabled
>> -	 * with the same STU on the PF.
>> +	 * Note that enabling ATS on a VF fails unless it's already
>> +	 * configured with the same STU on the PF.
>>  	 */
>>  	ctrl = PCI_ATS_CTRL_ENABLE;
>>  	if (dev->is_virtfn) {
>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>> index df54cd5b15db..7d62a92aaf23 100644
>> --- a/include/linux/pci-ats.h
>> +++ b/include/linux/pci-ats.h
>> @@ -8,6 +8,7 @@
>>  /* Address Translation Service */
>>  bool pci_ats_supported(struct pci_dev *dev);
>>  int pci_enable_ats(struct pci_dev *dev, int ps);
>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>  void pci_disable_ats(struct pci_dev *dev);
>>  int pci_ats_queue_depth(struct pci_dev *dev);
>>  int pci_ats_page_aligned(struct pci_dev *dev);
>> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>>  { return false; }
>>  static inline int pci_enable_ats(struct pci_dev *d, int ps)
>>  { return -ENODEV; }
>> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
>> +{ return -ENODEV; }
>>  static inline void pci_disable_ats(struct pci_dev *d) { }
>>  static inline int pci_ats_queue_depth(struct pci_dev *d)
>>  { return -ENODEV; }
>> -- 
>> 2.38.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
