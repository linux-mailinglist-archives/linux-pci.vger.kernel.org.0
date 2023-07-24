Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307F775EBD5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGXGlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGXGky (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 02:40:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2819AC;
        Sun, 23 Jul 2023 23:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690180826; x=1721716826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qK2V9u8FVB2OzLWYxccOO3cuqL/7jSveVNmw59rP1qc=;
  b=eczFvOwaDOjkm5S1gpG9N3HesD5H2o0RPR5YGmVB8meJyO8am6xJmO7j
   hL74OmesT3x8+8NUiNW2CwPj5JRTzHot3h0Vyulu8cr4an/He2n0DR7Ch
   xYc/DccLH/hhyw9odusCh75zh6hfaxfGeVHOhoVrQxaf+fYBws7Q3LM0V
   pKrI9w2XxQ2ffz0djSJKKEl1ml2nQA2bOcSkepcdEtnh5X4TyYy3qsMHA
   8YLFl+/ard/+7Sa28siBvGxVZkCP2fsaeZXY1UWNq7sMZM9e9+naOwyGA
   f2iu0ha/mw4nKi1d6boqq0Fb6RZit/zmxM2ngFdEY0+EPrT3ZcKyAY2f6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366253802"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366253802"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 23:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815714991"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815714991"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.238.9.84]) ([10.238.9.84])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 23:40:00 -0700
Message-ID: <77d86059-e8ad-88a6-f2b1-6b4f3aeb24be@linux.intel.com>
Date:   Mon, 24 Jul 2023 14:39:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
 <20230720102859.2985655-3-jiaqing.zhao@linux.intel.com>
 <20230720-document-tingle-e5d555714021-mkl@pengutronix.de>
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <20230720-document-tingle-e5d555714021-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-07-20 18:40, Marc Kleine-Budde wrote:
> On 20.07.2023 10:28:59, Jiaqing Zhao wrote:
>> Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
>> Controller to pci_ids.h for its serial and parallel port driver
>> support in subsequent patches.
> 
> Sorry, I haven't noticed the change in "include/linux/pci_ids.h", that
> the other patches depend on. How to coordinate among the subsystems?
> 
> I don't mind taking the entire (v1) series with the Acks from the
> tty/serial and parport maintainers, or give my Acked-by to upstream
> via their trees.

Since in ems_pci there are only definition changes, I think having your
Acked-by and upstream via the serial/parallel tree might be better.

>> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/net/can/sja1000/ems_pci.c | 6 +-----
>>  include/linux/pci_ids.h           | 4 ++++
>>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Marc
> 
