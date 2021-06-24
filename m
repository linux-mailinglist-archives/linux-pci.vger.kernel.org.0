Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136A53B2ADB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 10:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFXJBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 05:01:08 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:60602 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhFXJBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 05:01:07 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id A0540947;
        Thu, 24 Jun 2021 16:58:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12341T139824069605120S1624525102528264_;
        Thu, 24 Jun 2021 16:58:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6673199c70e8076af34458f12813a3c3>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: shawn.lin@rock-chips.com
X-RCPT-COUNT: 13
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v9 2/2] PCI: rockchip: Add Rockchip RK356X host controller
 driver
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        kernel test robot <lkp@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20210506023448.169146-1-xxm@rock-chips.com>
 <20210506023544.169196-1-xxm@rock-chips.com>
 <20210623143333.GA15104@lpieralisi>
 <46b3f277-2bde-321d-b616-3f3b41259e4d@rock-chips.com>
 <20210624082314.mw3ilcufswmb635m@pali>
From:   xxm <xxm@rock-chips.com>
Message-ID: <64de9d9c-1cc9-bf6f-00c5-2360ddfa4b24@rock-chips.com>
Date:   Thu, 24 Jun 2021 16:58:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624082314.mw3ilcufswmb635m@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

在 2021/6/24 16:23, Pali Rohár 写道:
> On Thursday 24 June 2021 10:08:54 xxm wrote:
>> 在 2021/6/23 22:33, Lorenzo Pieralisi 写道:
>>> On Thu, May 06, 2021 at 10:35:44AM +0800, Simon Xue wrote:
>>>> +static int rockchip_pcie_start_link(struct dw_pcie *pci)
>>>> +{
>>>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>>>> +
>>>> +	/* Reset device */
>>>> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
>>>> +
>>>> +	rockchip_pcie_enable_ltssm(rockchip);
>>>> +
>>>> +	/*
>>>> +	 * PCIe requires the refclk to be stable for 100µs prior to releasing
>>>> +	 * PERST. See table 2-4 in section 2.6.2 AC Specifications of the PCI
>>>> +	 * Express Card Electromechanical Specification, 1.1. However, we don't
>>>> +	 * know if the refclk is coming from RC's PHY or external OSC. If it's
>>>> +	 * from RC, so enabling LTSSM is the just right place to release #PERST.
>>>> +	 * We need more extra time as before, rather than setting just
>>>> +	 * 100us as we don't know how long should the device need to reset.
>>>> +	 */
>>>> +	msleep(100);
>>> Any rationale behind the time chosen ?
>> We found some device need about 30ms, so 100ms here just leave more room for
>> other devices.
> Can you share information which PCIe card needs 30ms?
>
> Last year I did tests with more WiFi AC cards and "the slowest" one was
> Compex WLE1216 which needed about 11ms (more than 10ms). All other cards
> were happy with just 1-2ms.

Sorry, it was about 5 years ago, I can't find the specific card now.

By the way, we also take other's upstream code "msleep(100)" as a reference.

>
>


