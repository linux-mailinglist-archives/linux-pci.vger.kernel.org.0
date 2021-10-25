Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863F14391CF
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 10:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhJYI7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 04:59:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42664 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhJYI73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 04:59:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19P8ukbE109334;
        Mon, 25 Oct 2021 03:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635152206;
        bh=r4fDR2q9W8VbL9No75Rv5RRZ+ZkwNCxRKt2G5ngXxHY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i87sLChGv1QEnJbSDjSltLMJQ7xwbebZmFgNoWk683NWWcGIPZTRJ1X3Wzy2fA2f9
         tpLWys4iDFO4jgFLrwo/90d1ZlOixgkQ7IBKFiGtUPpZ20Y7iqM1XVjIYGxoUEGQ/9
         5Lk6q/3wvyeAri95cvcDJ7dAbZb2rNvdUisBwTDo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19P8uk7E084125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Oct 2021 03:56:46 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Oct 2021 03:56:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Oct 2021 03:56:45 -0500
Received: from [10.250.233.112] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19P8uf45085408;
        Mon, 25 Oct 2021 03:56:42 -0500
Subject: Re: [PATCH v15 02/13] PCI: kirin: Add support for a PHY layer
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
 <f38361df2e9d0dc5a38ff942b631f7fef64cdc12.1634812676.git.mchehab+huawei@kernel.org>
 <3919b668-cf6a-ffda-0115-c2a94750e56a@ti.com>
 <20211025095254.522c1da6@sal.lan>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7c3848c4-afd7-8a97-d782-68dc38b81f28@ti.com>
Date:   Mon, 25 Oct 2021 14:26:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211025095254.522c1da6@sal.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mauro,

On 25/10/21 2:22 pm, Mauro Carvalho Chehab wrote:
> Hi Kishon,
> 
> Em Mon, 25 Oct 2021 13:44:57 +0530
> Kishon Vijay Abraham I <kishon@ti.com> escreveu:
> 
>> Hi Mauro,
> 
>>> +
>>> +static const struct of_device_id kirin_pcie_match[] = {
>>> +	{
>>> +		.compatible = "hisilicon,kirin960-pcie",
>>> +		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
>>> +	},  
>>
>> Where is PCIE_KIRIN_EXTERNAL_PHY used?
> 
> See:
> 	[PATCH v15 06/13] PCI: kirin: Add Kirin 970 compatible
> 
> 	https://lore.kernel.org/all/ac8c730c0300b90d96bdaaf387d458d8949241a9.1634812676.git.mchehab+huawei@kernel.org/
> 
> Basically, Kirin 970 (and any other devices that would use the same
> driver) should also use PCIE_KIRIN_EXTERNAL_PHY and place the PHY 
> driver inside drivers/phy, instead of hardcoding it at the driver.
> 
> The Kirin 970 PHY driver was already merged at linux-next:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/phy/hisilicon/phy-hi3670-pcie.c

Thanks for clarifying.


Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>


Regards,
Kishon
