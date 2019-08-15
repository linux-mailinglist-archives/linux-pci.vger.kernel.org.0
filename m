Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB78E482
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfHOFmn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 01:42:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:36134 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbfHOFmm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 01:42:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 22:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; 
   d="scan'208";a="352145415"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2019 22:42:42 -0700
Received: from [10.226.39.52] (ekotax-mobl.gar.corp.intel.com [10.226.39.52])
        by linux.intel.com (Postfix) with ESMTP id B729F580238;
        Wed, 14 Aug 2019 22:42:40 -0700 (PDT)
Subject: Re: [PATCH] PCI: dwc: Add map irq callback
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
References: <333e87c8ea92cd7442fbe874fc8c9eccabc62f58.1565763869.git.eswara.kota@linux.intel.com>
 <20190814073605.GA31526@infradead.org>
 <fe722a89-37e7-9ef6-042b-a9584f234740@linux.intel.com>
 <20190814105922.GA11568@infradead.org>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <65eec679-5781-a444-3951-97f3bd6fcd81@linux.intel.com>
Date:   Thu, 15 Aug 2019 13:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190814105922.GA11568@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/14/2019 6:59 PM, Christoph Hellwig wrote:
> On Wed, Aug 14, 2019 at 04:31:14PM +0800, Dilip Kota wrote:
>>> callback.
>> pp->map_irq() must assign the callback along with the platform specific
>> configuration.
>> In Intel PCIe driver pp->map_irq() does the same. (Driver is not yet present
>> in mainline, i will submit for review once this change is approved).
> And that's what I meant.  The standard procedure is to submit your
> core changes together with the user, not separately.
Sure, will submit the driver change along with this change. Sorry for 
missing it.

Thanks,
Dilip

