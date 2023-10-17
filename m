Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4D7CBEE7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjJQJUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjJQJTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 05:19:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7118D
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 02:19:31 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231017091925euoutp020f7d8c8a3f7fa34f429e62d9ff6a1651~O2oLrJnrh3105131051euoutp029
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 09:19:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231017091925euoutp020f7d8c8a3f7fa34f429e62d9ff6a1651~O2oLrJnrh3105131051euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697534365;
        bh=5J9Wde0Msm5xeT8zeaf/rGBe4mzHo5gKOj1z9flt18k=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=NsjYjkdDn+PPt6VLvgh12U5ZMBfhWHjYru08tf3EmB6qEV/bXsHUSNetA1YWeuUjQ
         m0O1DOUUuTOz/mOD3+99PRWlySJKwNNDwZjgI/amMs0ZlAK1aqO2JZda4MkpmG2kow
         sfIFTNmwoNVBzcKEIJLAk6ZJFF4zyX/95jIpLJls=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231017091924eucas1p1ddc7235e6017b7f9ac40a2f54a1d5759~O2oLNuWpE1102411024eucas1p1X;
        Tue, 17 Oct 2023 09:19:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DC.53.42423.C915E256; Tue, 17
        Oct 2023 10:19:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231017091924eucas1p2e65759cd05340e3e5b3a1d9ab9de1320~O2oKk6odL1166511665eucas1p2P;
        Tue, 17 Oct 2023 09:19:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231017091924eusmtrp1dc7542823289519892a84ab5e64aae0b~O2oKj6mN_1506015060eusmtrp1P;
        Tue, 17 Oct 2023 09:19:24 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-13-652e519caad5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2E.B8.25043.B915E256; Tue, 17
        Oct 2023 10:19:24 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231017091923eusmtip29409eae1b8f2dd9c90edef1eb4eb4585~O2oJcy3y62731827318eusmtip28;
        Tue, 17 Oct 2023 09:19:22 +0000 (GMT)
Message-ID: <a85158a0-858c-43c3-b64a-c09de72a50f9@samsung.com>
Date:   Tue, 17 Oct 2023 11:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid
 unnecessary memory assignment
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djP87pzAvVSDfa/MbRY0pRhsWbvOSaL
        +UfOsVrsutvBbrHiy0x2i74XD5ktGnp+s1pc2/mExeLsvONsFltfvmOyaPnTwmJx4MMqRouH
        K+ewWPzfs4Pd4uvez2wO/B47Z91l91iwqdRj06pONo871/aweTy5Mp3J49uZiSweW/Z/ZvT4
        vEkugCOKyyYlNSezLLVI3y6BK2PDRKWCNXIVSx4LNTDek+xi5OSQEDCRWLbyB3sXIxeHkMAK
        RomF3Q+ZQBJCAl8YJVq/VUMkPjNKrG48wNLFyAHWMflzPkR8OaPE4QVTmSGcj4wSn/c/ZAHp
        5hWwk7j+9BI7iM0ioCrx7c1FJoi4oMTJmU/AakQF5CXu35oBViMskCTR83AvI4jNLCAucevJ
        fCaQoSICJ5kkeubfZodI1Eos3TAdrJlNwFCi620XG8hFnALuEp9exkKUyEs0b50NdpCEwGpO
        iZ+t35gh/nSRmP1xGjuELSzx6vgWKFtG4vTkHhaIhnZGiQW/7zNBOBMYJRqe32KEqLKWuHPu
        F9g2ZgFNifW79CHCjhK7nl6GBgufxI23ghBH8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xi
        nsCoNAspWGYheX8WkndmIexdwMiyilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzDRnf53
        /NMOxrmvPuodYmTiYDzEKMHBrCTCmx6skyrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVI
        ID2xJDU7NbUgtQgmy8TBKdXA1LKxfOZx2QmfSto2/f1Tvf2E4UT5LYpvVj90czDlz+hoOfi0
        +OOfznmPNjNrGbwtagmaEfWyMibwbWChylIn5uUSPb0Spd8NMv9GZtqISJrGLm37erOn7cq0
        roD/1jIbftjOKff4dH+Rje2XTt/Jm0NL45wuOb4/d/Eqw//XCQVsBZZGAduM0/YqHej+mV36
        5/6GAK9V1+5/PxacdvV300zNY3ltlpevRNYG6H32Ty0yWj037kBtVc/jU29F0zcz1jVt76mZ
        m9RXPieJjZXxf/00BwaRtwta4pR6l6V1J6lP/j0tyMT+qfvm/evVBHwKBRakhnipRC2Rvh0g
        sm7fK9b6na93fRWcae4Z616hxFKckWioxVxUnAgAc/ShYeMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xe7pzAvVSDf5cYrJY0pRhsWbvOSaL
        +UfOsVrsutvBbrHiy0x2i74XD5ktGnp+s1pc2/mExeLsvONsFltfvmOyaPnTwmJx4MMqRouH
        K+ewWPzfs4Pd4uvez2wO/B47Z91l91iwqdRj06pONo871/aweTy5Mp3J49uZiSweW/Z/ZvT4
        vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5B
        L2PDRKWCNXIVSx4LNTDek+xi5OCQEDCRmPw5v4uRi0NIYCmjROuLC4xdjJxAcRmJk9MaWCFs
        YYk/17rYIIreM0rc63zBDJLgFbCTuP70EjuIzSKgKvHtzUUmiLigxMmZT1hAbFEBeYn7t2aA
        1QgLJEl0/f3FBmIzC4hL3HoynwlkqIjASSaJF82/WSAStRJPt69nhtjWzChx+8sxsKlsAoYS
        XW9BzuDg4BRwl/j0Mhai3kyia2sXI4QtL9G8dTbzBEahWUjumIVk3ywkLbOQtCxgZFnFKJJa
        WpybnltspFecmFtcmpeul5yfu4kRGNvbjv3csoNx5auPeocYmTgYDzFKcDArifCmB+ukCvGm
        JFZWpRblxxeV5qQWH2I0BQbGRGYp0eR8YHLJK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8s
        Sc1OTS1ILYLpY+LglGpgWrk16sTxl4JSTirTd9oZffnp8TNvEgtPt+Os7X90VBOW39yy4kvJ
        kyNXZM5W/lBNYnqwI+3SARndD1Iz88+eCItaslhmp7/ntHurm4//jn3NuqeJfcdZ/7OLr05N
        qk72lLj4VKoiX2Rao1RozTkvlaLzTOpJKdwZ80zWyl9/9njFLYbHkg5BFquumhf1vwnOEn07
        +dBBjv91S+UF5Zq9J13WT3+YEiogP2Nxw9ZzyjsYTN22xoRpWWWsra44tGyiqeQzFfNpkgbc
        jl4xxxU9sib0T/m1/eTnqqU122yeXn+t6KU4TXz6JzmZwP/cxwrdOr9sUrzj+uIdW6JjXnLS
        VanWowFST4yNt3XdVeZ/qcRSnJFoqMVcVJwIABgKMQl2AwAA
X-CMS-MailID: 20231017091924eucas1p2e65759cd05340e3e5b3a1d9ab9de1320
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231017091924eucas1p2e65759cd05340e3e5b3a1d9ab9de1320
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231017091924eucas1p2e65759cd05340e3e5b3a1d9ab9de1320
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
        <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
        <CGME20231017091924eucas1p2e65759cd05340e3e5b3a1d9ab9de1320@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear All,

On 11.10.2023 09:14, Yoshihiro Shimoda wrote:
> According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> assignment during device enumeration. Otherwise, Renesas R-Car Gen4
> PCIe controllers cannot work correctly in host mode.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch landed in today's linux-next 20231017 as commit e308528cac3e 
("PCI: dwc: Disable two BARs to avoid unnecessary memory assignment"). 
Unfortunately it causes the following kernel panic on Samsung 
Exynos5433-based TM2e board:

exynos-pcie 15700000.pcie: host bridge /soc@0/pcie@15700000 ranges:
exynos-pcie 15700000.pcie:       IO 0x000c001000..0x000c010fff -> 
0x0000000000
exynos-pcie 15700000.pcie:      MEM 0x000c011000..0x000ffffffe -> 
0x000c011000
exynos-pcie 15700000.pcie: iATU: unroll F, 3 ob, 5 ib, align 4K, limit 4G
Unable to handle kernel paging request at virtual address ffff800084196010
Mem abort info:
...
Data abort info:
...
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000022047000
[ffff800084196010] pgd=10000000df6ff003, p4d=10000000df6ff003, 
pud=10000000df6fe003, pmd=1000000024ad9003, pte=0000000000000000
Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
Modules linked in:
CPU: 4 PID: 55 Comm: kworker/u18:0 Not tainted 6.6.0-rc1+ #14129
Hardware name: Samsung TM2E board (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dw_pcie_write_dbi2+0xb8/0xc8
lr : dw_pcie_setup_rc+0x30/0x4e4
...
Call trace:
  dw_pcie_write_dbi2+0xb8/0xc8
  dw_pcie_setup_rc+0x30/0x4e4
  dw_pcie_host_init+0x238/0x608
  exynos_pcie_probe+0x23c/0x340
  platform_probe+0x68/0xd8
  really_probe+0x148/0x2b4
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0xd8/0x160
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x84/0xe0
  __device_attach+0xa8/0x1b0
  device_initial_probe+0x14/0x20
  bus_probe_device+0xb0/0xb4
  deferred_probe_work_func+0x8c/0xc8
  process_one_work+0x1ec/0x53c
  worker_thread+0x298/0x408
  kthread+0x124/0x128
  ret_from_fork+0x10/0x20
Code: d50332bf 79000023 17ffffe2 d50332bf (b9000023)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x8c00020e,3c020000,0000421b
Memory Limit: none
---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

I've observed similar issue on Qualcomm's RB5 platform with some 
additional not-yet merged patches enabling PCIe support. Reverting 
$subject on top of linux-next fixes this issue.

Let me know if you need more information.

> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a7170fd0e847..56cc7ff6d508 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -737,6 +737,14 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   	u32 val, ctrl, num_ctrls;
>   	int ret;
>   
> +	/*
> +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> +	 * assignment during device enumeration.
> +	 */
> +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
> +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
> +
>   	/*
>   	 * Enable DBI read-only registers for writing/updating configuration.
>   	 * Write permission gets disabled towards the end of this function.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

