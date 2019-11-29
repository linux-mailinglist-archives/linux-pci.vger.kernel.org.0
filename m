Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531A910D72D
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK2OkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 09:40:17 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6800 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfK2OkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2019 09:40:17 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de12dc90001>; Fri, 29 Nov 2019 06:40:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 29 Nov 2019 06:40:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 29 Nov 2019 06:40:16 -0800
Received: from [10.25.75.74] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Nov
 2019 14:40:12 +0000
Subject: Re: [PATCH 1/4] PCI: dwc: Add new feature to skip core initialization
To:     Christoph Hellwig <hch@infradead.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-2-vidyas@nvidia.com>
 <20191127094844.GA21122@infradead.org>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <80d610bf-71d8-d2c1-9c75-b0a58cb5c8ed@nvidia.com>
Date:   Fri, 29 Nov 2019 20:10:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127094844.GA21122@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575038409; bh=W1g4yb1nwFCRPWtunZjYcWYRD6VujotHZoWosLFA+4U=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WJXqnLVYmPwJXJVqtF/4ONttVGwYAUXWGztnYEHo6MuhziQxDJWOxCXDKx+dPX8dU
         q3OvqXR3BX5g0UtaXTZQKDmq+RNgum6amISuF7DjpoLZ8QxexAcPOtfyQs01AaJEBm
         fCULKI3wPWy5aHt3a1nRweASFloJZQQfVEJ8lAqt9Ezl/O8N+JhH/wvBH6LHCrK6wG
         z52cQn5sgQoTnDTcQQIEl1f4LACt9NXVy5T5ruJzkivXD6hPXdNUVeq6vlxQznd3m2
         R9j9JG5J6zLBvO2er/+Khj8OOk+8b5INNHilOVvhKFq2Izkzg3TliuWcjT/iCBglyh
         b+ogYPF7B2AkQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/27/2019 3:18 PM, Christoph Hellwig wrote:
> On Wed, Nov 13, 2019 at 02:38:48PM +0530, Vidya Sagar wrote:
>> +	if (ep->ops->get_features) {
>> +		epc_features = ep->ops->get_features(ep);
>> +		if (epc_features->skip_core_init)
>> +			return 0;
>>   	}
>>   
>> +	return dw_pcie_ep_init_complete(ep);
> 
> This calling convention is strange.  Just split the early part of
> dw_pcie_ep_init into an dw_pcie_ep_early and either add a tiny
> wrapper like:
> 
> int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> {
> 	int error;
> 
> 	error = dw_pcie_ep_init_early(ep);
> 	if (error)
> 		return error;
> 	return dw_pcie_ep_init_late(ep);
> }
> 
> or just open code that in the few callers.  That keeps the calling
> conventions much simpler and avoids relying on a callback and flag.
I'm not sure if I got this right. I think in any case, code that is going to be
part of dw_pcie_ep_init_late() needs to depend on callback and flag right?
I mean, unless it is confirmed (by calling the get_features() callback and
checking whether or not the core is available for programming) dw_pcie_ep_init_late()
can't be called right?
Please let me know if I'm missing something here.

- Vidya Sagar
> 

