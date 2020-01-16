Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82B13D0EF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 01:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAPAPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 19:15:01 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:54420 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAPAPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 19:15:00 -0500
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5B2AC4FCF9;
        Thu, 16 Jan 2020 08:14:57 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P20733T140093645911808S1579133695560712_;
        Thu, 16 Jan 2020 08:14:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4477a7a0a00c9b10bfd531bf21275836>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 5/6] PCI: rockchip: add DesignWare based PCIe controller
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200115172430.GA180494@google.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <2facd747-2b42-c500-9c04-7fd06471415a@rock-chips.com>
Date:   Thu, 16 Jan 2020 08:14:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115172430.GA180494@google.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2020/1/16 1:24, Bjorn Helgaas wrote:
> Follow subject line convention.
> 
> On Tue, Jan 14, 2020 at 03:25:01PM +0800, Shawn Lin wrote:
>> From: Simon Xue <xxm@rock-chips.com>
> 
> Needs a commit log.  Please describe the relationship with the
> existing drivers/pci/controller/pcie-rockchip-host.c.  Are they for
> different devices?  Does this supercede the other?

Yes, this PCIe controller is based on dwc IP, however pcie-rockchip* in
drivers/pcie/controller is another IP. They are two different
controllers totally. pcie-rockchip-host is end-of-life due to some
defects, so AFAICT, it's *only* for RK3399 SoC. All the other follow-up
SoCs should use this controller.

> 
>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/controller/dwc/Kconfig            |   9 +
>>   drivers/pci/controller/dwc/Makefile           |   1 +
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 441 ++++++++++++++++++++++++++
>>   3 files changed, 451 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 0830dfc..9160264 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -82,6 +82,15 @@ config PCIE_DW_PLAT_EP
>>   	  order to enable device-specific features PCI_DW_PLAT_EP must be
>>   	  selected.
>>   
>> +config PCIE_DW_ROCKCHIP
>> +	bool "Rockchip DesignWare PCIe controller"
>> +	select PCIE_DW
>> +	select PCIE_DW_HOST
>> +	depends on ARCH_ROCKCHIP
>> +	depends on OF
>> +	help
>> +	  Enables support for the DW PCIe controller in the Rockchip SoC.
> 
> A user needs to be able to tell whether to enable
> CONFIG_PCIE_ROCKCHIP_HOST or CONFIG_PCIE_DW_ROCKCHIP.  Is there an
> endpoint driver coming?  Should this be named PCIE_DW_ROCKCHIP_HOST?

Will add a description to tell users CONFIG_PCIE_ROCKCHIP_HOST is only
for RK3399, so all other Rockchip platforms should use
CONFIG_PCIE_DW_ROCKCHIP.

There is no plan to develop endponit driver recently, but
PCIE_DW_ROCKCHIP_HOST looks sane.


> 
>> +	ret = rockchip_pcie_reset_grant_ctrl(rockchip, true);
>> +	if (ret)
>> +		goto deinit_clk;
>> +
>> +//	if (rockchip->mode == DW_PCIE_RC_TYPE)
>> +//		ret = rk_add_pcie_port(rockchip);
> 
> Remove commented-out code.  I do like an "if" statement better than
> the complicated assignment/ternary thing below, though.
> 

My bad. Will fix it in V2.

>> +	ret = rockchip->mode == DW_PCIE_RC_TYPE ?
>> +		rk_add_pcie_port(rockchip) : -EINVAL;
>> +
>> +	if (ret)
>> +		goto deinit_clk;
> 
> 


