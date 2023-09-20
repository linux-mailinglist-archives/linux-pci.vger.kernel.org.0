Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A207A8E9A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 23:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjITVkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 17:40:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82429E;
        Wed, 20 Sep 2023 14:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJrK9watHPJKQxUgMDkDJS4IisTVunYzotyfLGD1vh1qAFibEunaspld9GroxjzTSYqTMK151VOLTZYOxi9hccITPD9BEsm6Rn/Jo3I1oXfOOG9N7uEUr/ZPi9DsytrYiVtCQVRp54MriHFqj5YwXsLYlgf+aYeCuZUglqSSQ1kZPVJhVmmtG0QtQ/Izd9ldAZjGISsER1gi8Pm+JYVMcCVHYpF6JoMXcdAnJAWdQ6AERGiLPeK+D1oi6vyHM4erw8VbDwfk7tV44tIWhQvjVz/A+Wghf/NvjEVLd+r0zj+mKU208gaxMIGotlojtHKQnhnHiioWC/3De6u14GZkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq/C/pID4iz4Jjz4P79msRy2xU9IP5O4y5A1YZr1GTo=;
 b=dtG5OConzbm22sgmeffby/bTJXlSSjBPtsz9uszgVn1evRAwS2nn5Id+NfNZ2E/l+EWry6MlVr6/grv3xDJz/IuQsOxm/I0kud2syVv4jwlxiElvWEJS8TMopaOmml5XXTpQb9eJJ3LVFQFS8i7Y5l+Mm6F6g5Wmq+Dz2xMAIrNSdAchx6MIKy0va0zRJ61UiWS4YX7110KjaiBm7k+nVPINbwngU9GvyD2OkHuOYmSFO0klZqUz8q3LwvDXZvNKg4snwlVhvmu62OtIUugYqQlNhLgD6TrAhnNxfimg1w8EfAo5U6hJVOQPSYMCPLpgm1kNizK6TewUC3/KwuH+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq/C/pID4iz4Jjz4P79msRy2xU9IP5O4y5A1YZr1GTo=;
 b=snn1fR2Ue7leH2pNkv8T0KXBPoRQnMk968e0WhRM3oOP0kckG3iydOKjc33Yi/GmTA3dxbJP20ufykEOuAcg2ArpYnTTmbxXDeBCllm6y50CwYIW6lqwH0dhOgMur7CYhtWUrDXmrj/4syyrdqvlX41OGLqERwwHeZjZIZcsHcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 21:40:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 21:40:00 +0000
Date:   Wed, 20 Sep 2023 17:39:48 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/5] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <ZQtmpL2vCMgR+Upu@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911220920.1817033-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: a0919d92-ae04-4342-15be-08dbba2223f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQ3i3PvbcZ15FUEfL9nUVfUmvxgA4DCz19PyurFkz7NTSmRkjnKV/YnNkiAJpRoSr+tV9m9qAGhezv/K1z0F/L0z+85L6bHR5M5Yw/mJDmTOzogwNJnAoRT2AFp9mUOm9ZpzieB+V9CXLsSP5vnx00eSoyzn6kOfK71rY1yZxnsbs4LmMw/xmJaXZQKWTF6FWFB7bOH6MvNJRzPG0BK9/ky1lZ/77MSPN1i9abS866oyRcSWTA8j3HWJlHt1G1ypIcIb+8aXO/Fd7AI+3px8qQzyw3r6fGmICJ8AXauxQZfOdGKupPMgHHzDRtA5TIC8of53B7kYPZ+N1lAvBmWp3A0jGNxxn+TnKzxBPEwPTKDqecK59tz0xcIOqON4uWukQtQrsm+UMdJQgmhuDXSiFK9hbbRJ0v2PKX//6Ew6bxnPUmr777slKk4gjkO6/A/VlAV1JddF7EHz82JfecsGDwke1fVVOGGOcY3Ftu19SMrTiTZUEvF2lqHLyu+2BEppkE0/tRQh9ctJ2e1JBo5YXZwxwvXF2SR85Mzl+gLMWZXeUbhDl2GndPN5VnmPBNX7/tyaA7K5rsIIXHEfXulj/Z1HCVjh33yj+1drYLHedYdf7tTkmWpvKypC9m5qaOQH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(396003)(376002)(346002)(1800799009)(186009)(451199024)(9686003)(6486002)(52116002)(6666004)(478600001)(6512007)(6506007)(83380400001)(8936002)(8676002)(66476007)(66946007)(66556008)(966005)(316002)(6916009)(5660300002)(38350700002)(86362001)(38100700002)(4326008)(7416002)(2906002)(26005)(41300700001)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FtaHpEdjRYWVZ4TjZxeVlYMUdaRjkxdG40RC9KUEJxMDhyeUhSVCtrSlYz?=
 =?utf-8?B?OXdHR1BINlhUM3RpR1Zna0lLOUUwa1c0RlZ6V25Kay9zalBJR2ZTaXhlUVdB?=
 =?utf-8?B?MVlYTUQ5K0RmRlMrbEYySXZhQmQzZmJCME8xZTlPSlJJdU9BSDFRVzlJdTZC?=
 =?utf-8?B?M0QxNUtraldTK2JVWkFPcExwVzlmV3VTVkNCdTVmUDF4N3RUV01nR3B2dHE2?=
 =?utf-8?B?VnN3Q1JQV0hHS29iNFdIYXVpRGRPMUtSUnlEZEZFSHNpWll3MzVpRkNVdlV4?=
 =?utf-8?B?TWJpbGRUT2FhTVJmT1VhU2pySmJtOWVBMHBDcTR6MTd3bW01a2duWGNmMlZQ?=
 =?utf-8?B?WUtZZldvaGU5NmpIYVBidUQ4SkszYm9HWnNYOHpEV2lCOGhrbjZJOXlHcVZo?=
 =?utf-8?B?UE1NLzB5MmVLZ0lsNWNHK1NPbXd4WXdkK1pVRXZ1aW84VnlvRXB5WEc5U0pk?=
 =?utf-8?B?T1NvczVYbGRhSm4za2RPb2FPTEdXK1VQNjkxSDNYWWQ2ZjVIWm5rNXNuTHB2?=
 =?utf-8?B?eTZEaExVNEFyNC9TUWJxbVNtVVZZUFRFNXFmbXdJUDBTL0ZxSkNSc2JTbk9n?=
 =?utf-8?B?L0QvbkFZZkZDU2NUNTRRek9xempLZlRuKzYyZjBHN1QrUjV4SGZuZm9OTmQ1?=
 =?utf-8?B?NlJwZHVlRW9ycnNWRlc4QWpsN09MSHE1UDlhbzZ3SmV3TDlicGY1K2pSVkdI?=
 =?utf-8?B?dUtUYXo1NDQxOFBHTlY0UXZ3eVdyU2pFMkFxU1FSYVRUTkxMNW1YdHlxY3l4?=
 =?utf-8?B?UThJeTdXa2hEQkZ5cWVhYllGVDNQTFRldWxlYmd1VG4xdmVaU0JIK0s5V1dG?=
 =?utf-8?B?dDJhaEZ6NFgrTG02cWVialNyOHhxSlpLc3Z2OEpJMFEyS0lIaFFvUklaMlc2?=
 =?utf-8?B?UnozWlJUemJzZy9vc0hZckg4UU5LV3hvZHUrTVh6aiszTnZya1ZtNjBrdmpl?=
 =?utf-8?B?WXRDR2xoOUNuVWNqM2c4VmVKdE1xb0hLODkwNHRGbSs4endvaVhnaHQ4Wkhz?=
 =?utf-8?B?YTVSWkFpN0JnTXJhcmRzSUhVTGZ0S2prK1R1ckE1WkpHZmlDK1RwbEExQ1Z2?=
 =?utf-8?B?dWMrd0VSWEFyaHc4dnlVc0ZDSXF3NTlUZWpDRVBBOE11a25wa1NyQXlQUGZ1?=
 =?utf-8?B?TUQ2VkRxTVlJVGQ1dW5VMlNjaUsxdVl6L0dtOEg0R2NFeGh2bENrSGhlUEVj?=
 =?utf-8?B?VjJOcm01REN5NysrWkVYcWhTOHFPMjVnRFpnWUdhdTNMSHVKenJGMnp4dXhV?=
 =?utf-8?B?T1NiOGJoUngrSlRHQmYycGRTYnZ4L0F3RGUwQkoxNFJyU1VrekdMMk1QK0My?=
 =?utf-8?B?TzNQSjdnVFZCNW1oMVJ5Q0t4TFpSeFV3UzZXL1lvVHF6WllyNFo0bGpmMmdH?=
 =?utf-8?B?cFl4ZmpMNktmWCtJR2lzT3cwSEs1YXdlNGYrUmErOURocHZIZzdldFNRSUJi?=
 =?utf-8?B?MmhtZ0ZYSjBoVzBZeVNxamF0bDI3RlJMNEVCRDhJY2lIS0FZbkJCN0ltZFIv?=
 =?utf-8?B?YVZTemhtK3U4TFhHSWVnMlNQUmMxdjRta25UTjZLR2pOd1djVGJ4cXJweHNJ?=
 =?utf-8?B?YlkxQ1NiNlV6ZGhvN2IyODBUNForOWttYnlMckthdkdZU1lZRU9SSVNnRDZV?=
 =?utf-8?B?M0dmZ1ZNdVFKL3AvNFJsWDEvL2NWTUhYMm9ETFBySStQZmNaZnRPYWRrcnlF?=
 =?utf-8?B?di9GZExjRHFVWDlhbkErYmJ1emNwSENXZ01iREkvMlBJYnoyUmNXTFBtcFlo?=
 =?utf-8?B?VUxmbmZ3d2dQWDJZNlBxQ1U4SlFldHNMS01xaFBnZGpNWnNHQTAzN2U2QVBX?=
 =?utf-8?B?U051R3NmT3F4ZlVZUWl2NlF0U2NyMTZDeWNCaU9QTmdSd3FqaGpvdDBnbkNa?=
 =?utf-8?B?Q1BONEVsSHBQQndEbTdES0o5aHBOQXRmYmxnZFFFWHk2ajJXWll0K0UzMlk2?=
 =?utf-8?B?dmJqVDQ1dUJzOFpWNW9pWHRzQ3JCWjBsbzk1L2NEQ2RSYlQ0dVZLN3ZpbUxS?=
 =?utf-8?B?VHordFFDWG16Q3ppS3kxMTlMZm1GRVNTVTJsQXU3SEErZlZMUWd4V05tTERk?=
 =?utf-8?B?d1gvcVFOcUpoVVVpd0psN3ZtZmpKeXRHRzcxT0R5SDgvSHNsaGxtSFVXQi9v?=
 =?utf-8?Q?ieAPog6kYVOrELXZgXlAk5zhT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0919d92-ae04-4342-15be-08dbba2223f3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 21:39:59.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIpEl9sd4DYMFSr/kvSHIs/5sA73Gr1yXHUBPVUbBOaqPA6oetlOr6yzB0BPBhH86VJLM0k+izstLqgOaFl3FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 11, 2023 at 06:09:15PM -0400, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘

@mani:
	Do you have chance to review this patch again?

Frank

> 
> This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> 
> Original patch only target to vntb driver. But actually it is common
> method.
> 
> This patches add new API to pci-epf-core, so any EP driver can use it.
> 
> The key point is comments from Thomas Gleixner, who suggest use new
> PCI/IMS. But arm platform change still not be merged yet.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> 
> So I still use existed method implement RC to EP doorbell.
> 
> If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> and update this patch.
> 
> Change from v1 to v2
> - Add missed patch for endpont/pci-epf-test.c
> - Move alloc and free to epc driver from epf.
> - Provide general help function for EPC driver to alloc platform msi irq.
> - Fixed manivannan's comments.
> 
> Frank Li (5):
>   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
>     controller
>   PCI: dwc: add doorbell support by use MSI controller
>   PCI: endpoint: pci-epf-test: add doorbell test
>   misc: pci_endpoint_test: Add doorbell test case
>   tools: PCI: Add 'B' option for test doorbell
> 
>  drivers/misc/pci_endpoint_test.c              |  48 +++++
>  .../pci/controller/dwc/pcie-designware-ep.c   |   2 +
>  drivers/pci/endpoint/functions/pci-epf-test.c |  59 +++++-
>  drivers/pci/endpoint/pci-epc-core.c           | 192 ++++++++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c           |  44 ++++
>  include/linux/pci-epc.h                       |   6 +
>  include/linux/pci-epf.h                       |   7 +
>  include/uapi/linux/pcitest.h                  |   1 +
>  tools/pci/pcitest.c                           |  16 +-
>  9 files changed, 373 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 
