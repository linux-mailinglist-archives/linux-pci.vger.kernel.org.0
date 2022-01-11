Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8DC48AB84
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiAKKfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 05:35:53 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:47234 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349296AbiAKKfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 05:35:52 -0500
Received: from [77.244.183.192] (port=64540 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1n7EVK-000DqX-8N; Tue, 11 Jan 2022 11:35:50 +0100
Subject: Re: [PATCH 1/2] PCI: dra7xx: Fix link removal on probe error
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Rob Herring <robh@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>
References: <20211214221450.589884-1-luca@lucaceresoli.net>
 <CAL_Jsq+GQTcx1EGKHug2ZcDZufrKM-4k6PB0vQeTCTG42MHzvA@mail.gmail.com>
 <59a23c89-0810-eb28-acd9-7051ac34d438@lucaceresoli.net>
Message-ID: <4579940c-27dc-733e-4022-ebea4671c839@lucaceresoli.net>
Date:   Tue, 11 Jan 2022 11:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <59a23c89-0810-eb28-acd9-7051ac34d438@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 16/12/21 10:08, Luca Ceresoli wrote:
> Hi Rob,
> 
> thanks for the quick feedback!
> 
> On 14/12/21 23:42, Rob Herring wrote:
>> On Tue, Dec 14, 2021 at 4:15 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>>
>>> If a devm_phy_get() calls fails with phy_count==N (N > 0), then N links
>>> have already been added by device_link_add() and won't be deleted by
>>> device_link_del() because the code calls 'return' and not 'goto err_link'.
>>>
>>> Fix in a very simple way by doing all the devm_phy_get() calls before all
>>> the device_link_add() calls.
>>>
>>> Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>> ---
>>>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>>> index f7f1490e7beb..2ccc53869e13 100644
>>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>>> @@ -757,7 +757,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>>>                 phy[i] = devm_phy_get(dev, name);
>>>                 if (IS_ERR(phy[i]))
>>>                         return PTR_ERR(phy[i]);
>>> +       }
>>>
>>> +       for (i = 0; i < phy_count; i++) {
>>>                 link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
>>
>> I think this should happen automatically now with fw_devlink being
>> enabled by default. Can you try?
> 
> Do you mean removal should be done automatically? I think they are not
> due to the DL_FLAG_STATELESS flag.

I would love to have feedback because, as said, I think my patch is
correct, but if I'm wrong (which might well be) I have to drop patch 1
and rewrite patch 2 in a slightly more complex form.

About your request to try: I only have hardware with phy_count==1, and
anyway I cannot access it at the moment. :(

Regards.
-- 
Luca
