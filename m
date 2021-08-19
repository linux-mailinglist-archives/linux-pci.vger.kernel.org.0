Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342D23F1B67
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 16:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbhHSOP5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 10:15:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37406 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbhHSOP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 10:15:57 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17JEFFYW017327;
        Thu, 19 Aug 2021 09:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629382515;
        bh=2mUjW55USsJN+YfaDxBGx//8TCbkDH83tw3JPy5h0aI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JW4hOis7JLQE4kxk6u2y3tCqI4MSMPPbjqKWow+lZ6Jqzq0jqqrWDv2vShTO/VNmf
         KRbLWpW9iteRtpTbBSKZb9RZYSYGsIhY23WxHQNx5eAomtg1FCTvEVQIz9Heh4wc+g
         sZa2oO2UpmWeK/7FhPnm6ofu9q1zzAOf3iWcNs6g=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17JEFF8t107802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 09:15:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 09:15:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 09:15:15 -0500
Received: from [10.250.233.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17JEFCUK093455;
        Thu, 19 Aug 2021 09:15:12 -0500
Subject: Re: [PATCH 0/5] PCI: endpoint: Add support for additional notifiers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <hemantk@codeaurora.org>,
        <smohanad@codeaurora.org>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ef957b1e-9350-c244-6cd7-fbb81ffc0f56@ti.com>
Date:   Thu, 19 Aug 2021 19:45:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Manivannan,

On 16/06/21 5:29 pm, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds support for additional notifiers in the PCI endpoint
> framework. The notifiers LINK_DOWN, BME, PME, and D_STATE are generic
> for all PCI endpoints but there is also a custom notifier (CUSTOM) added
> to pass the device/vendor specific events to EPF from EPC.
> 
> The example usage of all notifiers is provided in the commit description.

In my earlier comment I didn't mean you to provide example usage in
commit description. Rather to be used in a existing endpoint controller
driver and handled in endpoint function drivers. Otherwise no point in
adding them to the upstream kernel.

Thanks
Kishon

> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (5):
>   PCI: endpoint: Add linkdown notifier support
>   PCI: endpoint: Add BME notifier support
>   PCI: endpoint: Add PME notifier support
>   PCI: endpoint: Add D_STATE notifier support
>   PCI: endpoint: Add custom notifier support
> 
>  drivers/pci/endpoint/pci-epc-core.c | 89 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  5 ++
>  include/linux/pci-epf.h             |  5 ++
>  3 files changed, 99 insertions(+)
> 
