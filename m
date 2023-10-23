Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D547D3403
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 13:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjJWLgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjJWLgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 07:36:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514310D1;
        Mon, 23 Oct 2023 04:35:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39NBZZfc005820;
        Mon, 23 Oct 2023 06:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698060935;
        bh=418p3wK0SpkcYv49S+TAS6nQDO9VkD5aPf1J/n950C4=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=l6J5EpfmDgYrDEMpriG4zSyuYa3BbbDv26OXNsKOC4d5zdSYJSMA1iLPmeNgb+mYa
         MO41Yb3zFmB7O9lJaTRBj2cqzt8yg/L0dEc04/EF0EI6tTeVmuqqOrZjkkQqywnCrO
         By0Z0NlQe7n7HDUqVLwj2YgzYqCC2gHjMKUs4C60=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39NBZZdw040541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Oct 2023 06:35:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 06:35:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 06:35:35 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39NBZU6Y032367;
        Mon, 23 Oct 2023 06:35:31 -0500
Message-ID: <499a2f6c-3104-492c-be34-3ad286cdf069@ti.com>
Date:   Mon, 23 Oct 2023 17:05:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
References: <nw5myorissautj3uzhe2h32imu5v7bycjo3studma7v7dt37g6@tffgtog7x3j5>
 <20231019220847.GA1413474@bhelgaas>
 <7itgyqntgmjcqh4yk2j76af5h6i6lwpcita7syxxtyi4dhb6up@2qix56u3g4kg>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <7itgyqntgmjcqh4yk2j76af5h6i6lwpcita7syxxtyi4dhb6up@2qix56u3g4kg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Serge,

On 23/10/23 16:12, Serge Semin wrote:

...

> Siddharth, if it won't be that much bother and you have an access to
> the v3.65-based Keystone PCIe device, could you please have a look
> whether it's possible to implement what Bjorn suggested? *

Unfortunately I don't have any SoC/Device with me that has the v3.65 PCIe
controller, so I will not be able to test Bjorn's suggestion.

> 
> * it's irrespective to this patch. This fix looks good. If Bjorn
> and/or Mani are ok with it, I guess it can be already merged in.
> 
> -Serge(y)
> 
>>
>> Bjorn

-- 
Regards,
Siddharth.
