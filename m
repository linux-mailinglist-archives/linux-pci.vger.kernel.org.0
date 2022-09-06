Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84985AF48D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 21:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiIFTlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIFTlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 15:41:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6F80B58;
        Tue,  6 Sep 2022 12:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdyEp9WvbtF/F1AzQEFeEmRgg2VUqbxGp2b6pU1ba2oYdcX45QxNRiYzaGTZ6bcTKTseyHknkwazOzhJGb6x9KSp+oqbe40cGwoMqTGcfS1iZAegwJKbDnFStGL++gho3XVe4l5rLUYAm/f/dDsarjMXjOtnDGmUmpSqA+j8q/PZ/10YD28GLnln0vFDJUT4UzYiGtYDku1pz1WKEjS8+68LOLqsRte1akmR+QwvUh56ennB5cQZnmXg1XOxMD+Gdr6Jnm3UopO0H3wT19Rx+fCSl9KcoDit5ETOiASkw5WjMQwMN/3S5GNxBQc1dzjM/r3lVIATkImWjq+4KLnVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFGTE/3jBtDDKCXB4iueaGQ5wt1Pd1x1vRvU6A6hoKE=;
 b=gZ0BFCFlcJkHtJ9anHHor0MRKVaevxqb8ppanf86y+e5jJbkJcQAS4a6DfZ7EuVlGJFVjF13KHmbOM5kj72sO/ecAFgy+j9kV/aEeKUtr9VhmHzt7d7K5l0Wd2oNoWiJbKSBiKzA/pU+V8Rf8RKMKE3HY3LwJr4K/eLdHMnAAqN+tzOr2afE6EpBexOQVQX+1+Fnam2Rk5fT95xOUK88bUaDOMhh+z9OFWLrPxuA0tJ6U0MUVnv4II++c/BHoB3zfV6ddFyEbb2MY1YG3DklhxnQ4Ob7aa7ZBysjMa9Z7Picijyv/bMRUF/dlOUmYCQbpv5B95Da5gWU1OwCD/mvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFGTE/3jBtDDKCXB4iueaGQ5wt1Pd1x1vRvU6A6hoKE=;
 b=T4oO8SK5xiJUTd+EAbv+sR8sepsWt8Y3vJ5+sCOwVGopBu5F2egX7Vgy0iy9GyLXEPnyY2ta+wYESLmjVCltkchfYb/Xg6YNbU3mxlhlkFkNEkWYT7N5V9xSDWaQ7BcljXQipxNJ8Hc1cny26IBEUr1CObr2WF0q/LzRIUr/JkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DB6PR0401MB2358.eurprd04.prod.outlook.com (2603:10a6:4:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 19:41:14 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Tue, 6 Sep 2022
 19:41:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev
Subject: [PATCH v8 0/4] PCI EP driver support MSI doorbell from host
Date:   Tue,  6 Sep 2022 14:40:48 -0500
Message-Id: <20220906194052.3079599-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|DB6PR0401MB2358:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c6a782-818e-4316-9fa8-08da903fc209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8o/Vy/RGbH/GVamUXrXYYJM6YG1emUao+m2cTS8FGQ02DiNIvJt0rONM38yo6LvOg6rph1SGK8rIjhkv5/gAZnE0C1MgCcSMoYTA+YjHOSVjxlNikbPwFBREbbrBkf5H6R1PsPW+lENewDkjxPZpmlkzM7jAvIDBxXSXAT7KHvFMLzMts9GkRWcifAkzaTUhmEw8oALATaCbr8IUSqHS0diW955n61EIQNv6AGEEBThQY0FGgEOaSThIaAAiohORc4uyoXrCAnw4MgQtio7j0LSOWDxbpZSqrjECuri2IUgC1v1Kxq7zeilisTnVL+1VyLye3G3PxzbCOPqHPu2xJCAy4rOfdyqiLSpQ8271edb7Sj2G+bwg+0DF7M8P0/I92PpdtdtVgWdtN3eeRzyJmUKAlxRYgNFw/orK6gL2Jlm0nL0TNr9CqTlH83W886V0e75EZYUHwPEYFOcmqScOrYpTsYVCVAv3Y9T2+XKuKca4PHv0o5olfXxFJmp4O7myYqdImpLdBmQiJsco3UjXjE44ryfksorH9NcXXquOIn8bEVvqoGCpgG3RCZ5zjy6DSBk1bUkrOLwmLEqdut/+7aBvlr/vavHHnJS9JfoxhvSJYdWQe4+wkFiX2qzWlgyexudNLsmY7geL7lba0tVC/7L2rvcFIOQ32YH03l0v+wvDX7tV9vYwxiktqKnHNQURKfhcnba2BWHT3h9A0tkYpqzf4mCQhpwmYMvBEbH7/o7LphvPcJUlYBeS9v8k3dgC8Khhr64TTVUNKiWRy96qa2e10ngiy9a3YY7Quk1tAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(41300700001)(52116002)(26005)(6512007)(6506007)(6666004)(966005)(6486002)(478600001)(83380400001)(2616005)(186003)(1076003)(2906002)(7416002)(8936002)(5660300002)(66476007)(66946007)(4326008)(8676002)(66556008)(38350700002)(316002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lpeUJqVTdITTFmdUQ5d2RocHVzSFF6Mk1tNXk2d0tUYTVGSE5SSUhYWG8y?=
 =?utf-8?B?TW9MWlE1R2VqeEJ3RFYrdnJCeW4vM1VPaTFpeGxaSzZXZEJpNEV2MnhQYS9r?=
 =?utf-8?B?M3NSOGRYaVFFdnBMdEtDdlh5cjZ4MXpLcUNqd1MxQ2l4bmIwbkQ1cjVnMjVB?=
 =?utf-8?B?NVg0VVV0dlk2Ym8xeWFVUTFnOHB0WUF3NTZmRVJ5WFR5c2pMalBrcExNMitL?=
 =?utf-8?B?am1JcWcvb1ZOUXVLSTBhdlNrK1VQUEJRMjE3dUZDTXJWTkFzTFNZOUFzSWlO?=
 =?utf-8?B?RGg5dWNCcFh4QU9wYjZMMDlqYVh2ZjlyMkZkQnlUME1MbWxuTDQvZm9UT01t?=
 =?utf-8?B?YnpwcWNQc3d5Z0JBekl2a25xOElTWGREQUVhOGNnRHVTM0hWMEhWUGtXd1k1?=
 =?utf-8?B?a2VjMGR4aUs1ZkkvdGx3T214VlVNVTM1enJ2R3ZEa0ZPV2xvVk9SVVFzRmVZ?=
 =?utf-8?B?Y1h4QWxzdFo4b2F0QXEveFV6U0dLd051dFhNYkpLUG4ra2h0NzZsRXBCMHp6?=
 =?utf-8?B?NE9KUCtVeVF6Rnp3VUdLdVFkVmd6WWhPejRqUWpvZ3VYYzJRMDF5c3VVVFN0?=
 =?utf-8?B?SGVVUXVYcGdsTjRzbDBPRC9QWHlGUGFPeHNXMEh1WSs5MmNlVXhEcXAzaUdT?=
 =?utf-8?B?QWxkREtzcUVST0hBd1EyakFoakl3a0VoV01GamVmUUY2dTg3SWVVS29QMTlC?=
 =?utf-8?B?YjZaRVJIeml6WFM1ekViM1VnSnh4d0JBdDhLQ2U3NFpsdzJRSmQ2NlZZZ01q?=
 =?utf-8?B?SlRxc01LZlp1TWRFZ3E4NWRwdEg3UlVqOU5RMGZCSWt1Y0NuV2ErWUFJMEZq?=
 =?utf-8?B?bC90R3lWRXBHMjY0NnNxc3d2M3JLaUFzUndUTUcrYmJkSGcrV24vM2ZnOTJP?=
 =?utf-8?B?SDc5Z3I3SGtGZ0NFTEJMcUFoMlYrQjFHL0RsWStBMjUwMmg4aURFaWRiREQ4?=
 =?utf-8?B?TEgwN0toM3h4bjhQWFlPZkFsWUVzSjc1bjJQbm41VWFXdXgxdDlPL3RkaTZD?=
 =?utf-8?B?ZVBUemIvTEtXa2VWckEzbTFBY2F6WDNEMjA0Q0l2ZEhVRFIvU0Rrb3Q3czIw?=
 =?utf-8?B?RVE1bVlGRnF3YzE5Z0NLaFE5NzRJZDd1V3V3OVBTT1g2SFl0QTFrMSs0cjFt?=
 =?utf-8?B?KzhnWHRUaTRXVFRuMWpvVTcrdGF3aDFTTDJMTGVISGJnY240dlFzUTUxUytV?=
 =?utf-8?B?K2V3TVc2VW1sbHAvMFNWVXR1QUFiSTFhQkorVWVtQVZIT3Q2eWlWZE9MT1d1?=
 =?utf-8?B?eHNyU3ZFMitSSW5ZWk1RTGI5ZHk2bVV3ZnZ2VmNiNWZzTUV4ZFJMVytoeC9Z?=
 =?utf-8?B?ZklYc0pKZVY2YmxxRGhYSDZDWTk0RUZjRGhvN3dMV2I4S1FqcXVUbWxnang5?=
 =?utf-8?B?TGR3cytMNE94TWtLeDNweGRUcGNyUmEwUWhPRlVZUk9HeE5Qcy8zZFVBNktu?=
 =?utf-8?B?TFhUVVh6WUliNTNqYVY2MHMrWGdpUnRPUDF2Mm90VEZLdmZDeWN3eVM2dHpw?=
 =?utf-8?B?eTErYTBRMy80VzNjSC8rcmIyeG4rQzRWb1dGb0J0NHU3MWRkVldxTGt6MU0r?=
 =?utf-8?B?czl4dEQ4UVJxZnJoaG1wWDFkeU5FR2M3SmZGallOeG1ic1VvT3BTOVBVU3Zi?=
 =?utf-8?B?K3dudGh3TlpkT1c1UWVUYk04UEprcjRqK1ZEdWoxV28wM1ZoWUMyR3UwQjRs?=
 =?utf-8?B?c2Z1MU5Qb1BpQkFadmNaZmJFSFM5emFlWnIvQmxqM3JwNzk1LythMnp2TGxK?=
 =?utf-8?B?ZUFLMGl6eHZhUExKSHIwSkxsbWVTOWVXTExHWkgzWExQSUl1ZlBrQk1EekUr?=
 =?utf-8?B?K2xCbVR0VTVZdnh4MVNBUHZGSUxYeGVxZEpOVmlTOG9jRkswcEhuWlk4ckJY?=
 =?utf-8?B?MkRxNFN4TXVzbDNreHlGanBLaWhCUFc5bzNPTkFpYzA4dGYzMWEzVlFJYm9l?=
 =?utf-8?B?d1lJNGdpdS9XVHZ5WVhXc09CV3VqY2xnczlCdFVxSWVYWEM4bnFqbFdtbzZO?=
 =?utf-8?B?QTJzUUkySnIrcVRaUVYxNEljNktJYzZVR3NnZUk4WDErVXBPVWo3dG1KTnh0?=
 =?utf-8?B?Q1JzL1FrUjVYekJFMktKQ0pwNEI1U01pb3ZWVEZvZUhFWldPWjlyQzdmWVo5?=
 =?utf-8?Q?cyXdnefMzlcypwwzHIZf368Zp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c6a782-818e-4316-9fa8-08da903fc209
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:41:14.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CSD5deo8LxQIE5EuByhHfcLCgSbWJmHJyCHqfqj3DvmlC3cJzAV35oduqQUxzRfnqPwg71/E/jhBf8kX/6LcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2358
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


                  ┌───────┐          ┌──────────┐
                  │       │          │          │
┌─────────────┐   │       │          │ PCI Host │
│ MSI         │◄┐ │       │          │          │
│ Controller  │ │ │       │          │          │
└─────────────┘ └─┼───────┼──────────┼─Bar0     │
                  │ PCI   │          │ Bar1     │
                  │ Func  │          │ Bar2     │
                  │       │          │ Bar3     │
                  │       │          │ Bar4     │
                  │       ├─────────►│          │
                  └───────┘          └──────────┘

Many PCI controllers provided Endpoint functions.
Generally PCI endpoint is hardware, which is not running a rich OS,
like linux.

But Linux also supports endpoint functions.  PCI Host write BAR<n> space
like write to memory. The EP side can't know memory changed by the Host
driver. 

PCI Spec has not defined a standard method to do that.  Only define
MSI(x) to let EP notified RC status change. 

The basic idea is to trigger an IRQ when PCI RC writes to a memory
address. That's what MSI controller provided.  EP drivers just need to
request a platform MSI interrupt, struct MSI_msg *msg will pass down a
memory address and data.  EP driver will map such memory address to
one of PCI BAR<n>.  Host just writes such an address to trigger EP side
IRQ.

If system have gic-its, only need update PCI EP side driver. But i.MX
have not chip support gic-its yet. So we have to use MU to simulate a
MSI controller. Although only 4 MSI IRQs are simulated, it matched
vntb(pci-epf-vntb) network requirement.

After enable MSI, ping delay reduce < 1ms from ~8ms

IRQchip: imx mu worked as MSI controller: 
     let imx mu worked as MSI controllers. Although IP is not design
as MSI controller, we still can use it if limited IRQ number to 4.

pcie: endpoint: pci-epf-vntb: add endpoint MSI support
	 Based on ntb-next branch. https://github.com/jonmason/ntb/commits/ntb-next
	 Using MSI as door bell registers
	 This patch is totally independent on previous on. It can be
applied to ntb-next seperately.

i.MX EP function driver is upstreaming by Richard Zhu.
Some dts change missed at this patches. below is reference dts change

--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -160,5 +160,6 @@ pcieb_ep: pcie_ep@5f010000 {
                num-ib-windows = <6>;
                num-ob-windows = <6>;
                status = "disabled";
+               MSI-parent = <&lsio_mu12>;
        };

--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -172,6 +172,19 @@ lsio_mu6: mailbox@5d210000 {
                status = "disabled";
        };

+       lsio_mu12: mailbox@5d270000 {
+               compatible = "fsl,imx6sx-mu-MSI";
+               msi-controller;
+               interrupt-controller;
+               reg = <0x5d270000 0x10000>,     /* A side */
+                     <0x5d300000 0x10000>;     /* B side */
+               reg-names = "a", "b";
+               interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+               power-domains = <&pd IMX_SC_R_MU_12A>,
+                               <&pd IMX_SC_R_MU_12B>;
+               power-domain-names = "a", "b";
+       };
+

Change Log
- Change from v7 to v8
  irqchip: using name process-a-side as resource bind name
  pcie: endpoint:
     - fix build error reported by kernel test robot <lkp@intel.com>
     - rename epf_db_phy to epf_db_phys
     - rework error message
     - rework commit message
     - change ntb to vtb at apply irq.
     - kept name msi_virqbase because it is msi irq base number,
	not base address. 
		
- Change from v6 to v7
  pcie: endpoint: add endpoint MSI support
  Fine tuning commit message
  Fixed issues, reviewed by Bjorn Helgaas

- Change from v5 to v6
  Fixed build error found by kernel test robot

- Change from v4 to v5
  Fixed dt-binding document
        add msi-cell
        add interrupt max number
	update naming reg-names and power-domain-names.
  Fixed irqchip-Add-IMX-MU-MSI-controller-driver.patch
        rework commit message
        remove some field in struct imx_mu_dcfg
	error handle when link power domain failure.
	add irq_domain_update_bus_token

- Change from v3 to v4
  Fixed dt-binding document according to Krzysztof Kozlowski's feedback
  Fixed irqchip-imx-mu-worked-as-msi-controller according to Marc Zyngier's
        comments.

	There are still two important points, which I am not sure.
	1. clean irq_set_affinity after platform_msi_create_irq_domain.
	   Some function, like platform_msi_write_msg() is static.
	   so I have to set MSI_FLAG_USE_DEF_CHIP_OPS flags, which will
	   set irq_set_affinity to default one.
	2. about comments

	> +	msi_data->msi_domain = platform_msi_create_irq_domain(
	> +				of_node_to_fwnode(msi_data->pdev->dev.of_node),
	> +				&imx_mu_msi_domain_info,
	> +				msi_data->parent);

	"And you don't get an error due to the fact that you use the same
	fwnode for both domains without overriding the domain bus token?"

 	I did not understand yet. 

  Fixed static check warning, reported by Dan Carpenter
	pcie: endpoint: pci-epf-vntb: add endpoint MSI support

- Change from v2 to v3
  Fixed dt-binding docment check failure
  Fixed typo a cover letter.
  Change according Bjorn's comments at patch 
	pcie: endpoint: pci-epf-vntb: add endpoint MSI support
	 

- from V1 to V2
  Fixed fsl,mu-msi.yaml's problem
  Fixed irq-imx-mu-msi.c problem according Marc Zyngier's feeback 
  Added a new patch to allow pass down .pm by IRQCHIP_PLATFORM_DRIVER_END

-- 
2.35.1

