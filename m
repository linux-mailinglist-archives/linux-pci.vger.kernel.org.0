Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2BE6CFEE7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC3Iqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC3Iqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:46:42 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D17698;
        Thu, 30 Mar 2023 01:46:20 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U8k2hx128796;
        Thu, 30 Mar 2023 03:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680165962;
        bh=gHxjIKl4oyyMkToEWxKrUHS6Z36cqDfCTKpEDqhw0eQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=s17lsP88wDQ0i2g8rFSCy1/+IrT3hWS+1MnAxCbcg7q5KAtRehi/Epn5WMdM63fyo
         PFR+lkuQk0lUGzleVnE9qqxxtLlF50f6XJQl4Djm3gmkZ47jkFmmULNmF7Wm2LoG1X
         jy/xl+GKDoz9Srdo+K0FqcYiubHAGsGgfgYpbcs0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U8k2eB057547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 03:46:02 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 03:46:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 03:46:01 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U8juFC047389;
        Thu, 30 Mar 2023 03:45:57 -0500
Message-ID: <628458fb-a5d1-c846-1f73-c4b3eab0f543@ti.com>
Date:   Thu, 30 Mar 2023 14:15:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Siddharth Vadapalli <s-vadapalli@ti.com>, <tjoseph@cadence.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <nadeem@cadence.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <nm@ti.com>
References: <20230329170814.GA3067800@bhelgaas>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230329170814.GA3067800@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 29/03/23 22:38, Bjorn Helgaas wrote:
> On Wed, Mar 29, 2023 at 08:11:25PM +0530, Raghavendra, Vignesh wrote:
>> Hi Lorenzo, Bjorn,
>>
>> On 3/15/2023 12:38 PM, Siddharth Vadapalli wrote:
>>> The Link Retraining process is initiated to account for the Gen2 defect in
>>> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
>>> is i2085, documented at:
>>> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
>>>
>>> The existing workaround implemented for the errata waits for the Data Link
>>> initialization to complete and assumes that the link retraining process
>>> at the Physical Layer has completed. However, it is possible that the
>>> Physical Layer training might be ongoing as indicated by the
>>> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
>>>
>>> Fix the existing workaround, to ensure that the Physical Layer training
>>> has also completed, in addition to the Data Link initialization.
>>>
>>> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> ---
>>> Changes from v1:
>>> 1. Collect Reviewed-by tag from Vignesh Raghavendra.
>>> 2. Rebase on next-20230315.
>>>
>>> v1:
>>> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
>>>
>>>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>
>> Wondering do one of you be pulling this patch in? This patch was never
>> picked for 6.3-rc1 merge cycle... Just want to make sure
>> pcie-cadence*.c and pci-j721e.c patches have a path to reach pci tree.
> 
> Yes, Lorenzo or Krzysztof will likely pick this up.  I think Lorenzo
> is out of the office this week.
> 

Thanks for clearing this up!

> Drive-by comment: the current patch doesn't seem to give any
> indication to the user when cdns_pcie_host_training_complete() times
> out.  Is that timeout potentially of interest to a user?  Should there
> be a log message there?
> 

Siddharth will follow up on this comment as a separate response

-- 
Regards
Vignesh
