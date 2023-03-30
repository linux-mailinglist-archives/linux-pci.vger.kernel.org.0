Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8AC6CFBE2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjC3GtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 02:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjC3GtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 02:49:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F97F46AA;
        Wed, 29 Mar 2023 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680158950; x=1711694950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2EfB9pEn20VLq0RT9Dtq7CDpILcOhuOIHAZko6wRz0c=;
  b=XwqTlh8Srge06rA9M7G9Wb4sEVcrChJZaLeIYKXtqVIw7rUExK8axris
   C6L6QxzBvw1WzTw7rBSWYZo6GKN4N6NVM/aMeH2C2os3BW16J6LcmPAD6
   dBODU7KmeHYjp5DiN+OfWsDR6B0nW6DNynIvSnkJE5Kjq5VDVtlCMaT40
   R2LmCzzHnqXFEZfuELA02i4W3vHB5Pu/yqOcgIcIBSGqq19ZYDv33AC0b
   1Tvj29btr8cwN+Xs1hZo0K7N47ZOyyMVckfkA+LdmFffB1KR+tthhKkOB
   f6VDWP3TxJSEsdJCYbaJcNcpw5OQnFipQzcEMHPfugW6/P4R9boYsXOPb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="329578259"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="329578259"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:49:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795553129"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="795553129"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.69.10]) ([10.212.69.10])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:49:08 -0700
Message-ID: <0603c75d-82d3-01d5-ffe7-b648c1f02f0e@linux.intel.com>
Date:   Wed, 29 Mar 2023 23:49:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Xinghui Li <korantwork@gmail.com>
Cc:     kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
References: <20230329163107.GA3061927@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230329163107.GA3061927@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/29/2023 9:31 AM, Bjorn Helgaas wrote:
> On Wed, Mar 29, 2023 at 04:57:08PM +0800, Xinghui Li wrote:
>> On Wed, Mar 29, 2023 at 5:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> It would also be nice to include a hint about why a user would choose
>>> "on" or "off".  What is the performance effect?  What sort of I/O
>>> scenario would lead you to choose "on" vs "off"?
>>>
>> Before this patch, I sent the patch named :
>> PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
>> (patchwork link:
>> https://patchwork.kernel.org/project/linux-pci/patch/20221222072603.1175248-1-korantwork@gmail.com/)
>> We found the 4k rand read's iops could drop 50% if 4 NVMEs were
>> mounted in one PCIE port with VMD MSI bypass.
>> I suppose this is because the VMD Controller can aggregate interrupts.
>> But those test result is so long that I didn't add them to this patch
>> commit log.
>> If you believe it is necessary, I will try to add some simple instructions
> I don't think we need detailed performance numbers, but we need
> something like:
>
>   - "msi_remap=off" improves interrupt handling performance by
>     avoiding the VMD MSI-X domain interrupt handler
>
>   - But "msi_remap=on" is needed when ...?
>
>>> ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
>>> suggests that MSI-X remapping (I assume the "msi_remap=on" case):
>>>
>>>   - Limits the number MSI-X vectors available to child devices to the
>>>     number of VMD MSI-X vectors.
>>>
>>>   - Reduces interrupt handling performance because child device
>>>     interrupts have to go through the VMD MSI-X domain interrupt
>>>     handler.
>>>
>>> So I assume "msi_remap=off" would remove that MSI-X vector limit and
>>> improve interrupt handling performance?
>>>
>>> But obviously there's more to consider because those are both good
>>> things and if we could do that all the time, we would.  So there must
>>> be cases where we *have* to remap.  ee81ee84f873 suggests that not all
>>> VMD devices support disabling remap.  There's also a hint that some
>>> virt configs require it.
>>>
>> I used to just want to disable 28C0's VMD MSI bypass by default.
>> But Nirmal suggested the current method by adjusting the param.
>> Because he and other reviewers worry there are some other scenarios we
>> didn't consider.
>> Adding a method to adjust VMD'S MSI-X mode is better.
> This commit log doesn't outline any of those other scenarios, and it
> doesn't say anything about when "msi_remap=on" or "msi_remap=off"
> would be necessary or desired, so I have no idea how users are
> supposed to figure out whether or not to use this parameter.
>
>>> This patch doesn't enforce either of those things.  What happens if
>>> the user gets it wrong?
>> If I am wrong, please feel free to correct me at any time.
>> I place the "vmd_config_msi_remap_param" that is VMD MSI-X's mode
>> param configuring helper front
>> "vmd_enable_domain". So, It will not change the logic disabling
>> remapping from ee81ee84f873, such as
>> "Currently MSI remapping must be enabled in guest passthrough mode".
>> So, if the user config the wrong type, it will not work, and they can
>> find it by dmesg.
> That's kind of a problem.  I'm not in favor of something failing and
> the user having to debug it via dmesg.  That causes user frustration
> and problem reports.
>
> I don't know what "guest passthrough mode" is.  Can you detect that
> automatically?
>
> Bjorn

How about adding a boolean flag by comparing user input for module
parameter msi_remap? and add the flag at

    - if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) || msi_flag
        || offset[0] || offset[1])

Correct if I am wrong, but in this way we can cover all the cases.
If user adds msi_remap=on, msi_flag=true and enables remapping.
If user adds msi_remap=off, msi_flag=false and disables remapping.
If user doesn't add anything, msi_flag=false and decision will be
made same as current implementation. This will cover guest OS case
as well.

