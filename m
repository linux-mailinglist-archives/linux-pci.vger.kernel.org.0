Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4F1B1429
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 20:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDTSQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 14:16:17 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3207 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDTSQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 14:16:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9de6b30000>; Mon, 20 Apr 2020 11:15:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 11:16:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Apr 2020 11:16:17 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 18:16:16 +0000
Received: from [10.40.201.138] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 18:16:13 +0000
Subject: Re: [RFC] PCI: tegra: Revert raw_violation_fixup for tegra124
To:     Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20200420164304.28810-1-kwizart@gmail.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <680b456a-b1ed-45f6-aa38-6ec49783af6d@nvidia.com>
Date:   Mon, 20 Apr 2020 23:45:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200420164304.28810-1-kwizart@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587406515; bh=mk4/X0kpcHr2vQLqbvGk0i7UeUGHxMoWKKryqukkcBg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=or5X30sLiVj/fafzH2skTxZk75hoPbdGqWfH8ByaWpRaC4DGBP1FfXQ8ba/wRvexj
         Xzc4JnBaNRoUc2QYyVmRoB4NJzwx28MnOfkAqzQGw+dNGkD1Ptljc0VL6w8bk6OdKs
         q2j4jWYAE2p4qCmtLg4OpoxVVuSoeSkGpZ47AH566xqkivDpRCY9UcwmJQCRimWuDP
         L+IY9ILKHCykczuY1voSaPmpdQQ9anFRkT7naFgJ3F4uTjZOMIsRVeHEkrFnAeXEah
         69mGeLXvylDs+ula+E2KQA1n9Ta0Pg5jPQhYBJh0fO5OZ2ZvDEs1veilUgJaKFI016
         ydVYSt2tUxePA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you Nicolas for identifying the patch which caused the CmpltTO.

Little background on the fixup,
 In the internal testing with dGPU on Tegra124, CmplTO is reported by
dGPU. This happened because FIFO queue in AFI(AXI to PCIe) module
get full by upstream posted writes. Back to back upstream writes 
interleaved with infrequent reads, triggers RAW violation and CmpltTO.
This is fixed by reducing the posted write credits and by changing
updateFC timer frequency. These settings are fixed after stress test.

In the current case, RTL NIC is also reporting CmplTO. These settings
seems to be aggravating the issue instead of fixing it.


On 20-Apr-20 10:13 PM, Nicolas Chauvet wrote:
> External email: Use caution opening links or attachments
>
>
> As reported in https://bugzilla.kernel.org/206217 , raw_violation_fixup
> is causing more harm than good in some common use-cases.
>
> This patch as RFC is a partial revert of the 191cd6fb5 commit:
>  "PCI: tegra: Add SW fixup for RAW violations"
> that was first introduced in 5.3 kernel.
> This fix the following regression since then.
>
>
> When using both the network NIC and I/O on MMC this can lead to the
> following message on jetson-tk1:
>
>  NETDEV WATCHDOG: enp1s0 (r8169): transmit queue 0 timed out
>
> and
>
>  pcieport 0000:00:02.0: AER: Uncorrected (Non-Fatal) error received: 0000:01:00.0
>  r8169 0000:01:00.0: AER: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
>  r8169 0000:01:00.0: AER:   device [10ec:8168] error status/mask=00004000/00400000
>  r8169 0000:01:00.0: AER:    [14] CmpltTO                (First)
>  r8169 0000:01:00.0: AER: can't recover (no error_detected callback)
>  pcieport 0000:00:02.0: AER: device recovery failed
>
>
> After that, the ethernet NIC isn't functional anymore even after reloading
> the module.
> After a reboot, this is reproducible by copying a large file over the
> ethernet NIC to the MMC.
> For some reasons this cannot be reproduced when the same file is copied
> to a tmpfs.
>
>
> This patch is RFC because it requires more understanding from Nvidia.
>  - Is the fixup (available in l4t downstrem) still needed for upstream ?
>  - Is there a need to update the fixup values for upstream ?
>  - If the fixup is reverted, does the hw bug can still be seen with
>    upstream ?

Downstream patch is created after multiple stress tests. I am not sure
why these settings are aggravating the issue instead of fixing it.
I need to reproduce the issue and check if upstream driver is missing
anything else for this issue.
Jetson-TK1 is the only embedded product with Tegra124, it has only
RTL NIC PCIe endpoint soldered on board. I think this revert should
be merged to fix this issue until we find exact root cause.

>
> Others can also provides more understanding:
>  - Conditions to reproduce the bug (or not)...
>
>
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 3e64ba6a36a8..4027e074094a 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2470,7 +2470,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>         .program_uphy = true,
>         .update_clamp_threshold = true,
>         .program_deskew_time = false,
> -       .raw_violation_fixup = true,
> +       .raw_violation_fixup = false,
>         .update_fc_timer = false,
>         .has_cache_bars = false,
>         .ectl.enable = false,
> --
> 2.25.2
>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

