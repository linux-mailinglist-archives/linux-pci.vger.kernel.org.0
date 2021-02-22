Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF1321001
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 05:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBVEZH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 23:25:07 -0500
Received: from regular1.263xmail.com ([211.150.70.195]:59108 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhBVEZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Feb 2021 23:25:07 -0500
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 981171C11;
        Mon, 22 Feb 2021 12:19:04 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32470T140679103641344S1613967544149545_;
        Mon, 22 Feb 2021 12:19:04 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4925c1eead27d0d36bf4c7d588184ee1>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v4_1/2=5d_dt-bindings=3a_rockchip=3a_Add_D?=
 =?UTF-8?B?ZXNpZ25XYXJlIGJhc2VkIFBDSWUgY29udHJvbGxlcuOAkOivt+azqOaEj++8jA==?=
 =?UTF-8?B?6YKu5Lu255Sxa3N3aWxjenluc2tpQGdtYWlsLmNvbeS7o+WPkeOAkQ==?=
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20210127022406.820975-1-xxm@rock-chips.com>
 <YDMZB94qMkpOx38Q@rocinante>
From:   xxm <xxm@rock-chips.com>
Message-ID: <01e5ef9b-aef1-64ed-88e6-de74ea3e3e5b@rock-chips.com>
Date:   Mon, 22 Feb 2021 12:19:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDMZB94qMkpOx38Q@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

在 2021/2/22 10:37, Krzysztof Wilczyński 写道:
> Hi Simon,
>
> [...]
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> The driver is only based on GPL v2.0, should this be the same, or is
> there a reason for dual-license?
Will remove BSD-2-Clause
> [...]
>> +title: DesignWare based PCIe RC controller on Rockchip SoCs
> [...]
>
> What does the "RC" here stands for?  Would it be "Rockchip"?  If so,
> then perhaps dropping it would be fine to do, as rest of the title
> mentions "Rockchip SoCs"."  What do you think?

RC = Root Complex, just to distinguish "EP"(End Point), but drop "RC" 
seems fine.

Simon

> Krzysztof
>
>
>


