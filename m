Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756FD13846D
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2020 02:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgALBiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jan 2020 20:38:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:33938 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbgALBiS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Jan 2020 20:38:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 17:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,423,1571727600"; 
   d="scan'208";a="247388749"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jan 2020 17:38:14 -0800
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC 2/5] iommu/vt-d: Unlink device if failed to add to group
To:     Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
 <1577823863-3303-3-git-send-email-jonathan.derrick@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e45b00d9-579b-e141-e704-7084fe05bd29@linux.intel.com>
Date:   Sun, 12 Jan 2020 09:36:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577823863-3303-3-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/1/20 4:24 AM, Jon Derrick wrote:
> If the device fails to be added to the group, make sure to unlink the
> reference before returning.
> 
> Signed-off-by: Jon Derrick<jonathan.derrick@intel.com>

Queued for v5.6.

Best regards,
baolu
