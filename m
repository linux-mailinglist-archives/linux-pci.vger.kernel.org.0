Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CD5142125
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 01:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgATAzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jan 2020 19:55:32 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:47144 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgATAzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jan 2020 19:55:32 -0500
Received: from localhost (unknown [192.168.167.8])
        by lucky1.263xmail.com (Postfix) with ESMTP id CBF458C0D5;
        Mon, 20 Jan 2020 08:55:26 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26539T139797855188736S1579481725716441_;
        Mon, 20 Jan 2020 08:55:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <72906c28600ff790cba1475d38f3f6b2>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: wulf@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
        Simon Xue <xxm@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>
Subject: Re: [PATCH 5/6] PCI: rockchip: add DesignWare based PCIe controller
To:     Francesco Lavra <francescolavra.fl@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
 <1578986701-72072-1-git-send-email-shawn.lin@rock-chips.com>
 <0975b4e4-4bee-3f8e-5276-2bc78e6dabc0@gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <9458895c-9e1a-ad97-ba5d-e1c4e56dad2b@rock-chips.com>
Date:   Mon, 20 Jan 2020 08:55:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0975b4e4-4bee-3f8e-5276-2bc78e6dabc0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2020/1/19 0:36, Francesco Lavra wrote:
> On 1/14/20 8:25 AM, Shawn Lin wrote:
>> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie 
>> *rockchip)
>> +{
>> +    struct device *dev = rockchip->pci->dev;
>> +    struct property *prop;
>> +    const char *name;
>> +    int ret, count, i = 0;
>> +
>> +    count = of_property_count_strings(dev->of_node, "reset-names");
>> +    if (count < 1)
>> +        return -ENODEV;
>> +
>> +    rockchip->rsts = devm_kcalloc(dev, count,
>> +                     sizeof(struct reset_bulk_data),
>> +                     GFP_KERNEL);
>> +    if (!rockchip->rsts)
>> +        return -ENOMEM;
>> +
>> +    of_property_for_each_string(dev->of_node, "reset-names",
>> +                    prop, name) {
>> +        rockchip->rsts[i].id = name;
>> +        if (!rockchip->rsts[i].id)
>> +            return -ENOMEM;
>> +        i++;
>> +    }
>> +
>> +    for (i = 0; i < count; i++) {
>> +        rockchip->rsts[i].rst = devm_reset_control_get_exclusive(dev,
>> +                        rockchip->rsts[i].id);
>> +        if (IS_ERR_OR_NULL(rockchip->rsts[i].rst)) {
>> +            dev_err(dev, "failed to get %s\n",
>> +                rockchip->clks[i].id);
>> +            return -PTR_ERR(rockchip->rsts[i].rst);
> 
> IS_ERR_OR_NULL() should be replaced with IS_ERR(), because 
> devm_reset_control_get_exclusive() never returns a NULL value.
> Also, in case of error you should return the value from PTR_ERR(), 
> without the minus sign.

Thanks, Francesco. Will fix in v2.

> 
> 


