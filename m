Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1DE6663C4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 20:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjAKT3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 14:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjAKT3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 14:29:45 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83B10B7F;
        Wed, 11 Jan 2023 11:29:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kpc6GuR56r3TL/VijBqTLPSMOtaefdISkFrBJBl5Z/0YsoTMqB84Um+/EOYI+X4XrzYgv5XjGcmyOO784EhSBAZH/0/9hYHq7tcE6NUy9mEt/plxyi6ahb7PPgu209WPKrmcqOBB4pyUDpAwk18pPfzwtcqv0YjhOMYZENJPmX3Xy+OzeaKQpUS2DBxJpHC2sbYgvLHmGJYvlqBE0qWc7GU6cLZcCgw9LD+Tavxo5VHMOjWm72t7auDjAVd+TGLzDLrKyTScm6TpD30iVRJax6uWUE7T3IYuD3kevhEAGrpa4m/Q9Cp3h+daYphGqJmnzdi7vskXmOcDtfF+gKCdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31TpgbjrtOMAi2kvdGlWqaLh+IRQBPxuHAL+Rk4xVrg=;
 b=k83ug5NEzzZbJzSF3zf9D5GytwprpTCvdWM5gb5/zNDQxWbqzdJcZcH2OU4uHyZD3yDnZ7hHsUSdq/fYHoJvfXG8pMFoweQ3F/DpXitZb107VeoE2JUlJuZfuI3ciBlF7FoeS/yaVgi9zS1MrUxIMZSulNY8bvlUcoT23LOpKi6tsU68A0Z4k5EqIog7UNHeSUg78xZnzNDbyQaXMAnoZntDc4fIQDdDELzCGhJVIgayEvgFEf+8ywr3nfOPC0GSzQyufFF5HOqQIlZcCcvVPdyr3j2Q3KPf6JCd73zcnW7WQeZtLDHL/6QcRcH8psuPcDbsd6dgaCt50C5wJXDnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31TpgbjrtOMAi2kvdGlWqaLh+IRQBPxuHAL+Rk4xVrg=;
 b=NlK6vC6gdlilzKllYe4QiUJGlbdc2mF/Bj6+qn2aykO8B36+zjbTEitSqEFzEnEBNZvD3EEpzEulIPgDb6sOLWAzTx6Q18h2J+HQkSmd4r9rmTZDVyTW2eMVBGRnOK+XgruIP9oMweXibTXPysaFw8mOvco9Yw3l/gommi7KLBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 19:29:40 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 19:29:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de
Cc:     agross@kernel.org, ammarfaizi2@gnuweeb.org, andersson@kernel.org,
        andrew@lunn.ch, bhelgaas@google.com, festevam@gmail.com,
        gregkh@linuxfoundation.org, gregory.clement@bootlin.com,
        jgg@mellanox.com, kristo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        nm@ti.com, okaya@kernel.org, robin.murphy@arm.com,
        s.hauer@pengutronix.de, sebastian.hesselbarth@gmail.com,
        shameerali.kolothum.thodi@huawei.com, shawnguo@kernel.org,
        ssantosh@kernel.org, vkoul@kernel.org, will@kernel.org,
        yuzenghui@huawei.com
Subject: RE: [patch V2 00/40] genirq, irqchip: Convert ARM MSI handling to per device MSI domains
Date:   Wed, 11 Jan 2023 14:29:09 -0500
Message-Id: <20230111192909.997468-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121135653.208611233@linutronix.de>
References: <20221121135653.208611233@linutronix.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 7707d5db-da0d-4a89-89d4-08daf40a2ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6G+YzF/8g4xcivMELs5Zlip0CXpKOpDfeBBd3ewrrR6hlsFeGBxzsM42nqNplaKR4XPZKmXNFKERSgsPz8tHFY5U7V4YPAcEBRqWFlMZMm/RDYxPuWtnaizw33G71J//W83rxExXf4iEPw3bC7E2JRVlTcEwupNhAeyBk5yq/Kk1OyBTJy+rvCGYfZTGeKYDapxpi/18Hg7jqt/lW7L2ZB24qlJSBi+yevMjwNL/JY5FLsCJdpGtvgEAj/QJ2Asks0icYP8O0MY0wqKNRV2hxKpjUFLsaSnYzD6fME5mlppGQRtAWwfynJ9CxppghhguO+xejEmzZP4qNAydPBe6PUY6kjCAR9NnmhWX9qvd1GaUVe/FMKZsSIV2iv7J7NO8icn/pDGwuE1xYl8dpTY+oDdifuF3p1dSwfFnuKD4dSs5YLkbdmseO3e/Mm4TPjE0yXlBbDxsEJQIUSkngrI6Gc2b8Wd+haT5vWMTJxukkwLENeaKpJZ92AuPHMTHF8oGLWEG8rHgI+6Jjicbz95/4q9xoYulqUCu622vQ0Duvty6wVLTxm5rf6r5MFiwvDiY1mwcDTLahxpSKap0/i0XG3n996g37kHBJcjraGr0VIhc52ocqKzOVSqjyR/FDbxC4csceGQ64jjAKrffJxjyjiY53Dixyk3mg1MZEVjpfpxEHQzLzneB+zAgKdcwFVTodLWeHiGzxi3RO5cf+v3XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(7416002)(316002)(186003)(26005)(52116002)(5660300002)(6512007)(1076003)(6486002)(478600001)(2616005)(41300700001)(66556008)(66946007)(66476007)(4326008)(8676002)(6916009)(83380400001)(8936002)(86362001)(36756003)(6666004)(38350700002)(6506007)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvxJPR5B3TGQ2JtL6S7JwnlG2X5naTKgHJ0zyorPeChegVQlysqkyRsc+jPm?=
 =?us-ascii?Q?XiwjCVjlP1Kf0GaK4KNdgZin2cgYeUKsMu3HxURIOBtNL2pvpwO7TocrrS4I?=
 =?us-ascii?Q?59yDRsshcUibyUSjKp4mzjQptwbVxUkglZiGyvwM3nsFMm1SDKEI5tU/3jwh?=
 =?us-ascii?Q?XXTfWrxIOA5I0ZWQ1yYG2lWG3AhH+zpJm7xuxnKTLv49XrAR62APGsOBiCv/?=
 =?us-ascii?Q?Fzvt9IyU7tz09Vr3TwCla3o1NWm567D+Mu4DKSQv51etwSmpDVS9wO0Dl5dS?=
 =?us-ascii?Q?GAov8iiZaStwLL3HJzlbrCCJZ6w/tCMWHjnw2Ht1oPxNq8sW3omLX2FGV8Zs?=
 =?us-ascii?Q?gPb+VS/GOwq0lcsVJusiGLQMLR1I5aCCMVhV89jLxtRkU+j8JMn8qnHeaShE?=
 =?us-ascii?Q?czdn8w3ZA9DBevEdM0JZXwUSJq0AsDqWnxfp3dbGCekmJeJbC36JYJz0cEdX?=
 =?us-ascii?Q?HEnDAtI+bMWqrodCFsVVdiEVRUMUpHwq3ic2l3GbX5A5R4w3DKclAsfcL8Bk?=
 =?us-ascii?Q?TWrrZpChxj2DbZKU1aDBy0vCeBBoTABadHR69Pzydz9tdk1x9ME1pL8rvTZY?=
 =?us-ascii?Q?1uJUlN+JtJLFzSTo9rZWcyPka5fg0cSIXfS+XtoMGd0rIKt5GtKg9qhuSGMI?=
 =?us-ascii?Q?TCBprt6KICZBajL4PMBsSpRc2dnEUz3pvotSI7XqrQRSA1a1buX4GQ4xfRJq?=
 =?us-ascii?Q?8etJdqm7sgdXm/xGMvVd4tXWLSYFhflsJ2BZrJyLUJ93kQRMrV7YxWSYCLZ+?=
 =?us-ascii?Q?gKBOdETiRdR9cGaMVMz5iYzenrtHUbz4LcShwyqCxbEGnd+ZjoQtgbbwfcVv?=
 =?us-ascii?Q?LUvHF6n+yR7GueS0k9x/2h8MbYMW8cqcstJJwC50teS1I9dfwkilNkOdqH7E?=
 =?us-ascii?Q?zrt749zcUcFPFJGNi87KS9ulXpfz4WPNCkCcCg20KF4J9weM0Bc/cQVsCs4U?=
 =?us-ascii?Q?DhmADHNF5uW/bujAjYNSpvX92+wTlO1G7P7SpGNEb/7MA+rkt7p7XmaBgaXp?=
 =?us-ascii?Q?Rkf8yv2eFppm5iOaQ52ZPJKxA+14BsI2BT+y1NVpMjYBepuPxvrtrYpwuQTi?=
 =?us-ascii?Q?WHJMAyIWbRXsQEL+HhdaCcCWOAgt27kAeFvpHQgFbjPVeSzlkqo7R23vpFT1?=
 =?us-ascii?Q?2KK1RXNoFNDVYIY1OViECoqwWDhCqaotprMa0aQSGhAlq6/DkNdsjoiTeHW4?=
 =?us-ascii?Q?JV549wLgtJWV00OVtnj6bxd/yCwzOlEU4LbKIjifTNjwz6fpH3Kd/fHHUUlq?=
 =?us-ascii?Q?pXrFXqSDuqLS9grvmXjcon2eB0Y0qWBpwAVGRAfwMomoXeHNkXAxswGYPNkL?=
 =?us-ascii?Q?2U5skxE44idORJ+mIIxTOw13MgtmxXWHCyvUxD7Eo4kL9pC3CMEVi2Ui9ioA?=
 =?us-ascii?Q?kH6fos++T98zeE9s0gVKBAy0/hOleql7CPCrMiPhffc6qO8yvuK2aoy/Slrl?=
 =?us-ascii?Q?vMnw7vskRV5SkKMLpVK3fy8JjgMArIk30FBt2rfR0fF0vlYAd3HaXJnWQQm6?=
 =?us-ascii?Q?3Dz4bXZK2vfgaCc7TCxpFKbRRBaqpQSfUTIo/PPjTwSmmYNm45kKKRIrDpoD?=
 =?us-ascii?Q?BR5lzu4kCQZeDgDv6KvTSo/j0OggI42S0gzycq4e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7707d5db-da0d-4a89-89d4-08daf40a2ef9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 19:29:40.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1vXmA1MTa3d5aQpXFtexuipyzblbmPIjE7tcVJbsXPhc/xUV77WaYEijmmGitY6/S+fJ3KwpfPwO/2l2nXufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Li <frank.li@nxp.com>

On Mon, Nov 21, 2022 at 03:39:28PM +0100, Thomas Gleixner wrote:
> The series is also available from git:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
>
> The work was done to validate that the design decisions for per device MSI
> domains and the related data structures are up to the task to handle the
> ARM oddities. The design held up, it was just necessary to extend some of
> the data structures to handle the ARM specifics in a sane way, but there
> was no fundamental shortcoming.

I based on branch devmsi-arm, and run at ls1028a platform. And found 
Integrated Endpoint Root Complex and enetc can't work.

The reason is that pci_msi_domain_get_msi_rid can't get correct rid.

[    5.153596]  pci_msi_domain_get_msi_rid+0x94/0x110
[    5.158399]  its_pci_msi_prepare+0xac/0x180
[    5.162594]  __msi_domain_alloc_irqs+0x78/0x464
[    5.167138]  __msi_domain_alloc_locked+0x148/0x190
[    5.171942]  msi_domain_alloc_irqs_all_locked+0x54/0xb0
[    5.177184]  pci_msi_setup_msi_irqs+0x2c/0x4c
[    5.181551]  __pci_enable_msix_range+0x374/0x600
[    5.186182]  pci_alloc_irq_vectors_affinity+0xbc/0x13c
[    5.191336]  pci_alloc_irq_vectors+0x14/0x20
[    5.195618]  enetc_alloc_msix+0x40/0x2cc
[    5.199550]  enetc_pf_probe+0x788/0xea0
[    5.203395]  local_pci_probe+0x40/0x9c
[    5.207151]  pci_device_probe+0xac/0x20c


u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
{
        struct device_node *of_node;
        u32 rid = pci_dev_id(pdev);

        pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);

        of_node = irq_domain_get_of_node(domain);
        rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
                        iort_msi_map_id(&pdev->dev, rid);

}

supposed of_msi_map_id get map informaiton from device tree
msi-map = <0 &its 0x17 0xe>;


but when msi_create_device_irq_domain pre device msi domain, 
fwnode is NOT PCI host controller's device node.

bool msi_create_device_irq_domain()
{
	...
	if (bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE)
                fwnode = dev->fwnode;
        else
                fwnode = fwnalloced = irq_domain_alloc_named_fwnode(bundle->name);
	...
}



[    4.601732]  msi_create_device_irq_domain+0x1bc/0x20c
[    4.606800]  pci_setup_msix_device_domain+0x98/0xd4
[    4.611691]  __pci_enable_msix_range+0x21c/0x600
[    4.616322]  pci_alloc_irq_vectors_affinity+0xbc/0x13c
[    4.621477]  pci_alloc_irq_vectors+0x14/0x20
[    4.625760]  enetc_alloc_msix+0x40/0x2cc
[    4.629693]  enetc_pf_probe+0x788/0xea0
[    4.633537]  local_pci_probe+0x40/0x9c
[    4.637294]  pci_device_probe+0xac/0x20c


I don't know how to correct fix this problem. Can you give some suggestion?

Frank
