Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536975B1C5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjGTOyJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 10:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGTOyI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 10:54:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B11E60;
        Thu, 20 Jul 2023 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689864846; x=1721400846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sHKUqdVr24phow31YhtFZABiwRr2DFpKSY1jczZqZxk=;
  b=R3CLeoNxR1pWeGZ6lhUUnlD0wpf1aH2Kl3PINQJyKYJsQWxW7z7/BZsU
   7O8FIFR/69VBjNshhWXDlWT9vwFquJC3bp7YxB9YhDMb0yD5ef0klpZyF
   JbvQwejeUmrhrb2Y2yrycvF9rXcQ56BYf/Q7Z8LeZkpjA4GRE1gGD+eqh
   CMd0LwJgHNvuUrkpceV6iFsHyjmDlW474AhVJoKpJcJGik6VpuPI8F35y
   siqmAVxcDYDuGg5429Smk7k5nhYSHydvyDOo6oQ0iwoTo4YzE0kPkXr5o
   bRiM5C/453tz0AUqMxEwXm3ia3Kyr8ot/ZSjmllNMDKiFZLto07ZXXp06
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369433469"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="369433469"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 07:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718430688"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="718430688"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.93.4.236]) ([10.93.4.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 07:54:03 -0700
Message-ID: <61bbb2e6-8c18-d2fc-ce1e-78d462ac1bba@linux.intel.com>
Date:   Thu, 20 Jul 2023 22:54:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
 <20230720102859.2985655-3-jiaqing.zhao@linux.intel.com>
 <20230720-document-tingle-e5d555714021-mkl@pengutronix.de>
Content-Language: en-US
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <20230720-document-tingle-e5d555714021-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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

Add tty and parport maintainers to this thread.

I'd like to ask other maintainers' opinion as I'm not sure which option
is better and I had no similar experience before. 
 
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
