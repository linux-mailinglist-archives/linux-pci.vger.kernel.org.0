Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7926D52F7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDCVAi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjDCVAh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 17:00:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B708272C;
        Mon,  3 Apr 2023 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680555637; x=1712091637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2IBeB1/NTZwixNIbp5DUT4plrbHOehsVTzweYkMJMxY=;
  b=m4+QY4N2maXKnJckpx59lyTDwvZtq3qDILt69qdvK6Xq04yZHhHUJgBe
   Bm/LKA8Zj2D723m8DH/21FcOqQsxxbZi9yWO1etNyA6EaGyToHjzH8kBf
   KSu5AJqKGv2IRoF6/Z3djFiHCn/bOYwRy82SvMmDe3SRCcp0THL3iTNGG
   GIY2TrbQvAf6u27Ux3F7l5HRDpc1YR2/UC6JgGrSwZH3yqh/g3jhLpQ3z
   RNgEj9C/IU7qOvrHJY3OQ5ILvb4qkPWFD7pm+1yEFTL9vFHsd2B0eCp2c
   TwXdfBrjPUvSXpTDxF6UxbLVLNDa1U7gDPafuOQrZdx2r0C4pQ9S54CZc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428302116"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="428302116"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="686119359"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="686119359"
Received: from jbgonzal-mobl4.amr.corp.intel.com (HELO [10.209.186.66]) ([10.209.186.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:00:13 -0700
Message-ID: <a5f51ed8-b7b0-8f28-0e17-8f16ccb9abe1@linux.intel.com>
Date:   Mon, 3 Apr 2023 14:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
Content-Language: en-US
To:     Xinghui Li <korantwork@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
References: <20230329163107.GA3061927@bhelgaas>
 <0603c75d-82d3-01d5-ffe7-b648c1f02f0e@linux.intel.com>
 <CAEm4hYXwGuuZiKb9psXPyau+zKq-w=VboJEuYbS0FbY-iT-EmA@mail.gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <CAEm4hYXwGuuZiKb9psXPyau+zKq-w=VboJEuYbS0FbY-iT-EmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/2/2023 7:34 AM, Xinghui Li wrote:
> On Thu, Mar 30, 2023 at 2:49 PM Patel, Nirmal
> <nirmal.patel@linux.intel.com> wrote:
>> How about adding a boolean flag by comparing user input for module
>> parameter msi_remap? and add the flag at
>>
>>     - if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) || msi_flag
>>         || offset[0] || offset[1])
>>
>> Correct if I am wrong, but in this way we can cover all the cases.
>> If user adds msi_remap=on, msi_flag=true and enables remapping.
>> If user adds msi_remap=off, msi_flag=false and disables remapping.
>> If user doesn't add anything, msi_flag=false and decision will be
>> made same as current implementation. This will cover guest OS case
>> as well.
>>
> Sorry, I don't quite get your point. How is msi_flag assigned?
> Do you mean when msi_remap=no, the msi_flag is assigned as true?
> And msi_remap=off, the msi_flag is assigned as false?
>
> Thanks~

if msi_remap=on, then msi_flag=true;
if msi_remap=off, then msi_flag=false.

