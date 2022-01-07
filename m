Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3738B486FF3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 02:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbiAGBym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 20:54:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:36250 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344533AbiAGBym (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 20:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641520482; x=1673056482;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Jt8G5RvicmESM2ejSPAMQP973KFNwwweQUosaDpYZ+Y=;
  b=icHVwR+Bx3qfGy28JP7zxYLqxQK75AAZipFoinDX4WewSRCoHtWRV4W0
   6i4it/3shDLcHYtn59uz/vWvgV2vOqCBuB4zbHSzSFAJOMjESQu3fr5W1
   I7bg33PJjTmryfnmLgE+zcTp4QbIOmYvpM6wfHG/MPbpb2UopJN/Bvsm/
   aaJh1zYKYmBXeRjvzoe6rarbLSAkeqo/tskdhv2Y8hIF79S81OphlEGWA
   Fuq9CNwsgKuNkUNhEuMpNsknUvGRI7zbxyuUErqiz3mIU6d6a0150sJda
   tSyIIpBbIH7tXlmeeBANak3Omt/6SX6ZtWE1GiuLC1uDhw3fgA8ad8EXj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="329131118"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="329131118"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 17:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="527209969"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 17:54:34 -0800
Cc:     baolu.lu@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/14] PCI: portdrv: Suppress kernel DMA ownership
 auto-claiming
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20220106183224.GA298861@bhelgaas>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1545319f-130e-3750-ea00-082a12b73852@linux.intel.com>
Date:   Fri, 7 Jan 2022 09:53:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106183224.GA298861@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/7/22 2:32 AM, Bjorn Helgaas wrote:
> On Thu, Jan 06, 2022 at 12:12:35PM +0800, Lu Baolu wrote:
>> On 1/5/22 1:06 AM, Bjorn Helgaas wrote:
>>> On Tue, Jan 04, 2022 at 09:56:39AM +0800, Lu Baolu wrote:
>>>> If a switch lacks ACS P2P Request Redirect, a device below the switch can
>>>> bypass the IOMMU and DMA directly to other devices below the switch, so
>>>> all the downstream devices must be in the same IOMMU group as the switch
>>>> itself.
>>> Help me think through what's going on here.  IIUC, we put devices in
>>> the same IOMMU group when they can interfere with each other in any
>>> way (DMA, config access, etc).
>>>
>>> (We said "DMA" above, but I guess this would also apply to config
>>> requests, right?)
>>
>> I am not sure whether devices could interfere each other through config
>> space access. The IOMMU hardware only protects and isolates DMA
>> accesses, so that userspace could control DMA directly. The config
>> accesses will always be intercepted by VFIO. Hence, I don't see a
>> problem.
> 
> I was wondering about config accesses generated by an endpoint, e.g.,
> an endpoint doing config writes to a peer or the upstream bridge.
> 
> But I think that is prohibited by spec - PCIe r5.0, sec 7.3.3, says
> "Propagation of Configuration Requests from Downstream to Upstream as
> well as peer-to-peer are not supported" and "Configuration Requests
> are initiated only by the Host Bridge, including those passed through
> the SFI CAM mechanism."

That's clear. Thank you for the clarification.

> 
> Bjorn
> 

Best regards,
baolu
