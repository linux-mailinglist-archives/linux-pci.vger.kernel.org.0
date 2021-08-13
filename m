Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0753EB63C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbhHMNrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 09:47:51 -0400
Received: from foss.arm.com ([217.140.110.172]:53690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239428AbhHMNrv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 09:47:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10B301042;
        Fri, 13 Aug 2021 06:47:24 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3EF43F718;
        Fri, 13 Aug 2021 06:47:21 -0700 (PDT)
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference in
 probe
To:     Rob Herring <robh@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel-janitors@vger.kernel.org
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
 <CAL_JsqJ4Dadf00pJxEDd14zbWyN99s1A2L4fxZSkZddeg2pV6g@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <81b9a25d-f12f-90e0-0b05-b5e396f14c08@arm.com>
Date:   Fri, 13 Aug 2021 14:47:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ4Dadf00pJxEDd14zbWyN99s1A2L4fxZSkZddeg2pV6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-13 14:34, Rob Herring wrote:
> On Fri, Aug 13, 2021 at 7:55 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-08-13 12:33, Dan Carpenter wrote:
>>> If devm_regulator_get_optional() returns an error pointer, then we
>>> should return it to the user.  The current code makes an exception
>>> for -ENODEV that will result in an error pointer dereference on the
>>> next line when it calls regulator_enable().  Remove the exception.
>>
>> Doesn't this break the apparent intent of the regulator being optional,
>> though?
> 
> I'm pretty sure 'optional' means ENODEV is never returned. So there
> wasn't any real problem, but the check was unnecessary.

In fact it's the other way round - "optional" in this case is for when 
the supply may legitimately not exist so the driver may or may not need 
to handle it, so it can return -ENODEV if a regulator isn't described by 
firmware. A non-optional regulator is assumed to represent a necessary 
supply, so if there's nothing described by firmware you get the (valid) 
dummy regulator back.

Robin.

>>> Fixes: e1229e884e19 ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> index 20cef2e06f66..2d0ffd3c4e16 100644
>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> @@ -225,9 +225,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>>        /* DON'T MOVE ME: must be enable before PHY init */
>>>        rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>>>        if (IS_ERR(rockchip->vpcie3v3))
>>> -             if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
>>> -                     return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
>>> -                                     "failed to get vpcie3v3 regulator\n");
>>> +             return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
>>> +                                  "failed to get vpcie3v3 regulator\n");
>>>
>>>        ret = regulator_enable(rockchip->vpcie3v3);
>>>        if (ret) {
>>>
