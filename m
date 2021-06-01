Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751DE3973A1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 14:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhFAMyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 08:54:14 -0400
Received: from foss.arm.com ([217.140.110.172]:49266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232965AbhFAMyN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 08:54:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61F926D;
        Tue,  1 Jun 2021 05:52:32 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6CDB3F719;
        Tue,  1 Jun 2021 05:52:30 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] PCI: of: Improvements to handle 64-bit attribute
 for non-prefetchable ranges
To:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wqu@suse.com, robin.murphy@arm.com, pgwipeout@gmail.com,
        ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org
References: <20210531221057.3406958-1-punitagrawal@gmail.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <75da0524-7588-4ace-a135-69236f2d1d5e@arm.com>
Date:   Tue, 1 Jun 2021 13:53:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531221057.3406958-1-punitagrawal@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Punit,

On 5/31/21 11:10 PM, Punit Agrawal wrote:
> Hi,
>
> Here's an updated version of changes to improve handling of the 64-bit
> attribute on non-prefetchable host bridge ranges. Previous version can
> be found at [0].
>
> The series addresses Rob and Bjorn's comments on the previous version
> and updates the checks for 32-bit non-prefetchable window size to only
> apply to non 64-bit ranges.

Many thanks for the series. I've tested it on my rockpro64, and the NVME works as
expected:

Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

>
> Thanks,
> Punit
>
> Changes:
> v2:
> * Check ranges PCI / bus addresses rather than CPU addresses
> * (new) Restrict 32-bit size warnings on ranges that don't have the 64-bit attribute set
> * Refactor the 32-bit size warning to the range parsing loop. This
>   change also prints the warnings right after the window mappings are
>   logged.
>
>
> [0] https://lore.kernel.org/linux-arm-kernel/20210527150541.3130505-1-punitagrawal@gmail.com/
>
> Punit Agrawal (4):
>   PCI: of: Override 64-bit flag for non-prefetchable memory below 4GB
>   PCI: of: Relax the condition for warning about non-prefetchable memory
>     aperture size
>   PCI: of: Refactor the check for non-prefetchable 32-bit window
>   arm64: dts: rockchip: Update PCI host bridge window to 32-bit address
>     memory
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi |  2 +-
>  drivers/pci/of.c                         | 17 ++++++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
