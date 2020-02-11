Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336DD158E10
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 13:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgBKMNV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 07:13:21 -0500
Received: from mail-am6eur05on2048.outbound.protection.outlook.com ([40.107.22.48]:64424
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728628AbgBKMNV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 07:13:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV/qwuwu/WCguYcODDlcFE5exZQ01/RWTBRr00Hs41pE9dR00U5Fuc3E4ifuE+H83c1aa/L+8eOMVl6Pz9qTfcyUbhDc4l1V4OhqxWJ4Y44xBFxEUKlXrYGhJIJkJ1q29eMivzzfdCqXHzlryiyXfaY26vhyBnMDMZlnLrVdRsQurmI14KdG9QmkFTDzSdRbrAc8FJ9zo3coHUwVpT3Q36i8wFK/oETdHAB8lPD7SrpPA0+jAsWsadXV8TO9gems/PI0UFv1e56dih8QdEfXwVkPx73E775b/hrWKnscljysuYQyuq0TiLiXLKBeK9RFNiDCt2ZUB+zxakEIR7eZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxh+EnN4+cibLXb+KgscpYB7TuSJ/RzEWyL8XD7AEXo=;
 b=EIMZfGwF4qlRQOci21z/iEP26EGLOFHeaVYMAitWJNMGfYn/M7yx1UqyIeD7uCPa9bvBGgXNFk1XBHcIQGNAXH+zovvM9L1Tkl2RaHeAAy+Twz92bhe9VlhFnRdmzmTzlud0Z6ZYEMH9MtvkkKooWOE/j/3mng0lClekNtQf1n0tfLKGmlB6/+6NccfJjDDu1mH7Fr1UN7AX4vIaxoEUg6R6T7mEerYEeKMJILMx6KcITHoSs3LVZkoso0xFYmZRwAvI97BOwpiQatCnKRLElIcsCcxSqx4y0diBYa7ejduVgw6V1lMY1TVZmhe1gUtuXqT2zWf3qEgiHT9WldsuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxh+EnN4+cibLXb+KgscpYB7TuSJ/RzEWyL8XD7AEXo=;
 b=ogRYCTSs4ExME8+/VUYAbNdC5jCDNrPuXvS+Fg4wycAo43jldoQZ3pBKgHv497581QAjQ6dHjQO1PzdPGia2VX6Lj0WNDIIyT910+bHis1oazohelPVsFhXV2UYjH5ZNX9LkKeMQyaiuHgHdREX1dF3ETVB9ATypFCu5edXm/Tk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com (20.179.0.89) by
 AM6PR04MB4071.eurprd04.prod.outlook.com (52.135.164.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 12:13:12 +0000
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e]) by AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 12:13:11 +0000
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Li Yang <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk>
 <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
 <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <da4dcdc7-c022-db67-cda2-f90f086b729e@nxp.com>
Date:   Tue, 11 Feb 2020 14:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------AE161A00404C95FFAA71826B"
Content-Language: en-US
X-ClientProxiedBy: AM6P194CA0099.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::40) To AM6PR04MB5878.eurprd04.prod.outlook.com
 (2603:10a6:20b:a2::25)
MIME-Version: 1.0
Received: from [10.171.82.13] (89.37.124.34) by AM6P194CA0099.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 12:13:10 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a61e0cc-c5fc-4682-bbb0-08d7aeebc377
X-MS-TrafficTypeDiagnostic: AM6PR04MB4071:|AM6PR04MB4071:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB407152F8935A151FB48449E6EC180@AM6PR04MB4071.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(966005)(52116002)(36756003)(478600001)(54906003)(110136005)(31696002)(16576012)(2616005)(956004)(235185007)(44832011)(8936002)(8676002)(316002)(81166006)(81156014)(4326008)(5660300002)(31686004)(6486002)(66476007)(66576008)(66946007)(66556008)(33964004)(26005)(16526019)(53546011)(186003)(86362001)(7416002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4071;H:AM6PR04MB5878.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJtZmnNwo0/Eqp67vG4qYtNNkUlRuDIYgOWjvkRudyM0x+HhiLT2JGpt4WlqB+dRdHM/diBJwL7Kxx5F3QmfQF4ObYzT/yeH8WxdRW3UE/RQtf9ykwQHfFJpr74Vtff0T/gvsksstw2+pITKHt5C4T+dm33EwI5U2ACyKNrl/st1OQAcQDOm5c6yML6mMU1tU8xiB53N2aEckiPodWXnPjZRgEJ+LFKjDiNHnSsz2hZZavLmsW6kWgZfLKcm0a22npAUjRRMrwZbb4lzr8WhpsAjfhxB41aCBLbAN+1lpfkxwAvZf3A9ALlvJlaiXTFhLoJyctmUBF5nngKvqth9bD6GPLJwshp3FViiEb9IlC/IEuWNlJ06YtGKGdvJOmcz+jvSCxSrZLxOP7l8dJajB4UlVhFs/HWe3PFTDbHezzINMDgMCXKl5kNqf2GI+efPraqJ1bB18xYaSzy4mvH1i2fqwURTBp7RACpnXppEol77cHh2q/LU9JY8u6lMVFvpXtR5WPGt4QRnmZJEDtMDSw==
X-MS-Exchange-AntiSpam-MessageData: Ad/9kJQsfoJBhfvPfG+aek2/BIqOG3EiLDSEG382jd+ndJab0If10IPcraBu8cOBbgyaEjI3q4cLBUQu2eZW2EiPn1kTiFbQUCmIf/cecSdyk3J5GNbPnlRefuRR0pIosurVA8/yzbDR5BBpgKmQ3Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a61e0cc-c5fc-4682-bbb0-08d7aeebc377
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 12:13:11.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +58NJqrX3PaKJIfLITJ6SUfPdHDGbgCtw7Oqg/1XDN+73kXWO7cOH72TOcJQRLwhKtfQNBgrpVH5atasdLT7Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4071
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--------------AE161A00404C95FFAA71826B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10.02.2020 20:41, Li Yang wrote:
> On Mon, Feb 10, 2020 at 9:32 AM Olof Johansson <olof@lixom.net> wrote:
>>
>> On Mon, Feb 10, 2020 at 4:23 PM Russell King - ARM Linux admin
>> <linux@armlinux.org.uk> wrote:
>>>
>>> On Mon, Feb 10, 2020 at 04:12:30PM +0100, Olof Johansson wrote:
>>>> On Thu, Feb 6, 2020 at 11:57 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>>>>>
>>>>> Hi Olof,
>>>>>
>>>>> Thanks a lot for your comments!
>>>>> And sorry for my delay respond!
>>>>
>>>> Actually, they apply with only minor conflicts on top of current -next.
>>>>
>>>> Bjorn, any chance we can get you to pick these up pretty soon? They
>>>> enable full use of a promising ARM developer system, the SolidRun
>>>> HoneyComb, and would be quite valuable for me and others to be able to
>>>> use with mainline or -next without any additional patches applied --
>>>> which this patchset achieves.
>>>>
>>>> I know there are pending revisions based on feedback. I'll leave it up
>>>> to you and others to determine if that can be done with incremental
>>>> patches on top, or if it should be fixed before the initial patchset
>>>> is applied. But all in all, it's holding up adaption by me and surely
>>>> others of a very interesting platform -- I'm looking to replace my
>>>> aging MacchiatoBin with one of these and would need PCIe/NVMe to work
>>>> before I do.
>>>
>>> If you're going to be using NVMe, make sure you use a power-fail safe
>>> version; I've already had one instance where ext4 failed to mount
>>> because of a corrupted journal using an XPG SX8200 after the Honeycomb
>>> Serror'd, and then I powered it down after a few hours before later
>>> booting it back up.
>>>
>>> EXT4-fs (nvme0n1p2): INFO: recovery required on readonly filesystem
>>> EXT4-fs (nvme0n1p2): write access will be enabled during recovery
>>> JBD2: journal transaction 80849 on nvme0n1p2-8 is corrupt.
>>> EXT4-fs (nvme0n1p2): error loading journal
>>
>> Hmm, using btrfs on mine, not sure if the exposure is similar or not.
>>
>> Do you know if the SErr was due to a known issue and/or if it's
>> something that's fixed in production silicon?
>>
>> (I still can't enable SMMU since across a warm reboot it fails
>> *completely*, with nothing coming up and working. NXP folks, you
>> listening? :)
> 
> This is a known issue about DPAA2 MC bus not working well with SMMU
> based IO mapping.  Adding Laurentiu to the chain who has been looking
> into this issue.

Yes, I'm closely following the issue. I actually have a workaround 
(attached) but haven't submitted as it will probably raise a lot of 
eyebrows. In the mean time I'm following some discussions [1][2][3] on 
the iommu list which seem to try to tackle what appears to be a similar 
issue but with framebuffers. My hope is that we will be able to leverage 
whatever turns out.
In the mean time, can you try the workaround Leo suggested?

[1] https://patchwork.kernel.org/patch/11327667/
[2] https://patchwork.kernel.org/patch/10967729/
[3] https://patchwork.kernel.org/cover/11279577/

---
Best Regards, Laurentiu

--------------AE161A00404C95FFAA71826B
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-arm64-dts-lx2160a-add-iommus-property-for-mc-node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-arm64-dts-lx2160a-add-iommus-property-for-mc-node.patch"

From 75dcd4a7bdf51db65dc5553a255b277f9d126e30 Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Tue, 19 Nov 2019 17:01:39 +0200
Subject: [PATCH 1/2] arm64: dts: lx2160a: add iommus property for mc node
Content-Type: text/plain; charset="us-ascii"

Enable SMMU management for the MC firmware by adding the required
iommus property in the device tree node.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index b032f3890c8c..f46f0d0905b5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -868,6 +868,7 @@
 			msi-parent = <&its>;
 			/* iommu-map property is fixed up by u-boot */
 			iommu-map = <0 &smmu 0 0>;
+			iommus = <&smmu 0x4000>;
 			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
-- 
2.17.1


--------------AE161A00404C95FFAA71826B
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-bus-fsl-mc-make-mc-work-with-smmu-disable-bypass-on.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-bus-fsl-mc-make-mc-work-with-smmu-disable-bypass-on.pat";
 filename*1="ch"

From 46ccd2291e259c906b449f789ee62e03598fe4d7 Mon Sep 17 00:00:00 2001
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Tue, 1 Oct 2019 16:22:48 +0300
Subject: [PATCH 2/2] bus: fsl-mc: make mc work with smmu disable bypass on
Content-Type: text/plain; charset="us-ascii"

Since this commit [1] booting kernel on MC based chips started to
fail because this firmware starts before the kernel and as soon as
SMMU is probed it starts to trigger contiguous faults.
This is a workaround that allows MC firmware to run with SMMU
in disable bypass mode. It consists of the following steps:
 1. pause the firmware at early boot to get a chance to setup SMMU
 2. request direct mapping for MC device
 3. resume the firmware
The workaround relies on the fact that no state is lost when
pausing / resuming firmware, as per the docs.
With this patch, platforms with MC firmware can now boot without
having to change the default config to set:
  CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=n

[1] 954a03be033 ("iommu/arm-smmu: Break insecure users by disabling bypass by default")

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 51 +++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index fec394a28891..f9bc9c384ab5 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -18,6 +18,8 @@
 #include <linux/bitops.h>
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
 
 #include "fsl-mc-private.h"
 
@@ -889,6 +891,12 @@ static int get_mc_addr_translation_ranges(struct device *dev,
 	return 0;
 }
 
+#define FSL_MC_GCR1	0x0
+#define GCR1_P1_STOP	BIT(31)
+
+static u32 boot_gcr1;
+static void __iomem *fsl_mc_regs;
+
 /**
  * fsl_mc_bus_probe - callback invoked when the root MC bus is being
  * added
@@ -906,6 +914,19 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	struct mc_version mc_version;
 	struct resource res;
 
+	/*
+	 * The MC firmware requires full access to the whole address space plus
+	 * it has no way of dealing with any kind of address translation, so
+	 * request direct mapping for it.
+	 */
+	error = iommu_request_dm_for_dev(&pdev->dev);
+	if (error)
+		dev_warn(&pdev->dev, "iommu_request_dm_for_dev() failed: %d\n",
+			 error);
+
+	/* Resume the firmware */
+	writel(boot_gcr1 & ~GCR1_P1_STOP, fsl_mc_regs + FSL_MC_GCR1);
+
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
@@ -990,6 +1011,13 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
 		return -EINVAL;
 
+	/*
+	 * Pause back the firmware so that it doesn't trigger faults by the
+	 * time SMMU gets brought down.
+	 */
+	writel(boot_gcr1 | GCR1_P1_STOP, fsl_mc_regs + FSL_MC_GCR1);
+	iounmap(fsl_mc_regs);
+
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
 
 	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
@@ -1018,6 +1046,8 @@ static struct platform_driver fsl_mc_bus_driver = {
 static int __init fsl_mc_bus_driver_init(void)
 {
 	int error;
+	struct device_node *np;
+	struct resource res;
 
 	error = bus_register(&fsl_mc_bus_type);
 	if (error < 0) {
@@ -1039,9 +1069,30 @@ static int __init fsl_mc_bus_driver_init(void)
 	if (error < 0)
 		goto error_cleanup_dprc_driver;
 
+	np = of_find_matching_node(NULL, fsl_mc_bus_match_table);
+	if (!of_device_is_available(np))
+		goto error_cleanup_dprc_driver;
+	error = of_address_to_resource(np, 1, &res);
+	if (error)
+		goto error_cleanup_dprc_driver;
+	fsl_mc_regs = ioremap(res.start, resource_size(&res));
+	if (!fsl_mc_regs) {
+		error = -ENXIO;
+		goto error_cleanup_dprc_driver;
+	}
+
+	boot_gcr1 = readl(fsl_mc_regs + FSL_MC_GCR1);
+	/*
+	 * If found running, pause MC firmware in order to get a chance
+	 * to setup SMMU for it.
+	 */
+	if (!(boot_gcr1 & GCR1_P1_STOP))
+		writel(boot_gcr1 | GCR1_P1_STOP,  fsl_mc_regs + FSL_MC_GCR1);
+
 	return 0;
 
 error_cleanup_dprc_driver:
+	iounmap(fsl_mc_regs);
 	dprc_driver_exit();
 
 error_cleanup_driver:
-- 
2.17.1


--------------AE161A00404C95FFAA71826B--
