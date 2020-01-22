Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AAE144AD8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 05:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAVEjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 23:39:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:23482 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgAVEjD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jan 2020 23:39:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 20:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="215779176"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138]) ([10.239.159.138])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2020 20:39:01 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v5 4/7] iommu/vt-d: Use pci_real_dma_dev() for mapping
To:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1579613871-301529-1-git-send-email-jonathan.derrick@intel.com>
 <1579613871-301529-5-git-send-email-jonathan.derrick@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f9eb8cc8-e0d8-60db-78c0-55366daaa434@linux.intel.com>
Date:   Wed, 22 Jan 2020 12:37:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579613871-301529-5-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/21/20 9:37 PM, Jon Derrick wrote:
> The PCI device may have a DMA requester on another bus, such as VMD
> subdevices needing to use the VMD endpoint. This case requires the real
> DMA device when mapping to IOMMU.
> 
> Signed-off-by: Jon Derrick<jonathan.derrick@intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
