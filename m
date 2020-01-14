Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5256139F41
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 02:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgANB7z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 20:59:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:25773 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgANB7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 20:59:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 17:59:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="305011243"
Received: from unknown (HELO [10.239.159.138]) ([10.239.159.138])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2020 17:59:53 -0800
Cc:     baolu.lu@linux.intel.com, Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC 2/5] iommu/vt-d: Unlink device if failed to add to group
To:     Joerg Roedel <joro@8bytes.org>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
 <1577823863-3303-3-git-send-email-jonathan.derrick@intel.com>
 <e45b00d9-579b-e141-e704-7084fe05bd29@linux.intel.com>
 <20200113122045.GE28359@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ef5d2869-b334-b924-1796-836336f786e9@linux.intel.com>
Date:   Tue, 14 Jan 2020 09:58:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113122045.GE28359@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/13/20 8:20 PM, Joerg Roedel wrote:
> On Sun, Jan 12, 2020 at 09:36:56AM +0800, Lu Baolu wrote:
>> On 1/1/20 4:24 AM, Jon Derrick wrote:
>>> If the device fails to be added to the group, make sure to unlink the
>>> reference before returning.
>>>
>>> Signed-off-by: Jon Derrick<jonathan.derrick@intel.com>
>>
>> Queued for v5.6.
> 
> No need to do so, I sent it upstream with the last pile of iommu fixes.

Got it. Thank you!

Best regards,
baolu
