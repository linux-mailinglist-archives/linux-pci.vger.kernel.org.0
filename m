Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53011C128
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 01:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLLANB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 19:13:01 -0500
Received: from foss.arm.com ([217.140.110.172]:53048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfLLANA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 19:13:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E121FB;
        Wed, 11 Dec 2019 16:12:59 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 025913F52E;
        Wed, 11 Dec 2019 16:12:56 -0800 (PST)
Subject: Re: [REGRESSION] PCI v5.5-rc1 breaks google kevin
To:     Vicente Bergas <vicencb@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Murray <andrew.murray@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Stefan_M=c3=a4tje?= <stefan.maetje@esd.eu>,
        linux-arm-kernel@lists.infradead.org
References: <58ce5534-64bd-4b4b-bd60-ed4e0c71b20f@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <166f0016-7061-be5c-660d-0499f74e8697@arm.com>
Date:   Thu, 12 Dec 2019 00:12:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <58ce5534-64bd-4b4b-bd60-ed4e0c71b20f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vicente,

On 2019-12-11 11:38 pm, Vicente Bergas wrote:
> Hi,
> since v5.5-rc1 the google kevin chromebook does not boot.
> Git bisect reports 5e0c21c75e8c PCI/ASPM: Remove pcie_aspm_enabled() 
> unnecessary locking
> as the first bad commit.
> 
> In order to revert it from v5.5-rc1 i had to also revert some dependencies:
> 5e0c21c75e8c08375a69710527e4a921b897cb7e
> aff5d0552da4055da3faa27ee4252e48bb1f5821
> 35efea32b26f9aacc99bf07e0d2cdfba2028b099
> 687aaf386aeb551130f31705ce40d1341047a936
> 72ea91afbfb08619696ccde610ee4d0d29cf4a1d
> 87e90283c94c76ee11d379ab5a0973382bbd0baf
> After reverting all of this, still no luck.
> So, either the results of git bisect are not to be trusted, or
> there are more bad commits.
> 
> By "does not boot" i mean that the display fails to start and
> the display is the only output device, so debugging is quite difficult.

Assuming it's a manifestation of the same PCI breakage that Enric and 
Lorenzo figured out, there's a proposed fix here: 
https://lkml.org/lkml/2019/12/11/199

Robin.

> v5.5-rc1 as is (reverting no commits at all) works fine when disabling PCI:
> # CONFIG_PCI is not set
> 
> Regards,
>   Vicente.
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
