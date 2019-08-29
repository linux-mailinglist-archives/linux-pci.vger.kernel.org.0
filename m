Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68322A0F9E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfH2CkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 22:40:04 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:48560 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfH2CkE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 22:40:04 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 22:40:02 EDT
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.158])
        by lucky1.263xmail.com (Postfix) with ESMTP id DB5303DE17;
        Thu, 29 Aug 2019 10:31:11 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1611T140153748326144S1567045863028376_;
        Thu, 29 Aug 2019 10:31:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b3c576a24e41d32ebb6ea575d2616e43>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        linux-rockchip@lists.infradead.org,
        Andrew Murray <andrew.murray@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_PCI=3a_rockchip=3a_Properly_handle_opti?=
 =?UTF-8?B?b25hbCByZWd1bGF0b3Jz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtcm9j?=
 =?UTF-8?Q?kchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfradead?=
 =?UTF-8?B?Lm9yZ+S7o+WPkeOAkQ==?=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20190828150737.30285-1-thierry.reding@gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <c435244d-34e5-3ab8-d4df-5e08e7951e6f@rock-chips.com>
Date:   Thu, 29 Aug 2019 10:31:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828150737.30285-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/8/28 23:07, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> regulator_get_optional() can fail for a number of reasons besides probe
> deferral. It can for example return -ENOMEM if it runs out of memory as
> it tries to allocate data structures. Propagating only -EPROBE_DEFER is
> problematic because it results in these legitimately fatal errors being
> treated as "regulator not specified in DT".
> 
> What we really want is to ignore the optional regulators only if they
> have not been specified in DT. regulator_get_optional() returns -ENODEV
> in this case, so that's the special case that we need to handle. So we
> propagate all errors, except -ENODEV, so that real failures will still
> cause the driver to fail probe.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

LGTM,
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>   drivers/pci/controller/pcie-rockchip-host.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 8d20f1793a61..ef8e677ce9d1 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -608,29 +608,29 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
>   
>   	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
>   	if (IS_ERR(rockchip->vpcie12v)) {
> -		if (PTR_ERR(rockchip->vpcie12v) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
> +			return PTR_ERR(rockchip->vpcie12v);
>   		dev_info(dev, "no vpcie12v regulator found\n");
>   	}
>   
>   	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>   	if (IS_ERR(rockchip->vpcie3v3)) {
> -		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
> +			return PTR_ERR(rockchip->vpcie3v3);
>   		dev_info(dev, "no vpcie3v3 regulator found\n");
>   	}
>   
>   	rockchip->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
>   	if (IS_ERR(rockchip->vpcie1v8)) {
> -		if (PTR_ERR(rockchip->vpcie1v8) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (PTR_ERR(rockchip->vpcie1v8) != -ENODEV)
> +			return PTR_ERR(rockchip->vpcie1v8);
>   		dev_info(dev, "no vpcie1v8 regulator found\n");
>   	}
>   
>   	rockchip->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
>   	if (IS_ERR(rockchip->vpcie0v9)) {
> -		if (PTR_ERR(rockchip->vpcie0v9) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (PTR_ERR(rockchip->vpcie0v9) != -ENODEV)
> +			return PTR_ERR(rockchip->vpcie0v9);
>   		dev_info(dev, "no vpcie0v9 regulator found\n");
>   	}
>   
> 


