Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54805359A1
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 08:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiE0Gus convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 27 May 2022 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbiE0Guo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 02:50:44 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B815ED8F9
        for <linux-pci@vger.kernel.org>; Thu, 26 May 2022 23:50:42 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2049.outbound.protection.outlook.com [104.47.22.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-HtdqZwZbPQqr9rBOPs_8KA-1; Fri, 27 May 2022 08:50:37 +0200
X-MC-Unique: HtdqZwZbPQqr9rBOPs_8KA-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0441.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:25::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Fri, 27 May 2022 06:50:36 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2879:acb:62c8:4987%9]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 06:50:36 +0000
Date:   Fri, 27 May 2022 08:50:35 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220527065035.GA8349@francesco-nb.int.toradex.com>
References: <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
 <20220525215739.GA275957@bhelgaas>
In-Reply-To: <20220525215739.GA275957@bhelgaas>
X-ClientProxiedBy: MR2P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::14) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fff961e9-f43f-4dfe-d0e4-08da3fad33f4
X-MS-TrafficTypeDiagnostic: ZR0P278MB0441:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB04414A6A2730F2FF4E00E942E2D89@ZR0P278MB0441.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: DVg4w9rGOdiBo8gPs6jeIAYWcQ9lq/IgHCqRZdoN1wmgnB4YlsFZIIxMDl94krL6F0736x32p109gLPkr338i02DIKHKd+OFMRBXqDD74faGn6YechukZYOcJVx9f+C0ycjnFXF+8blOUrs25Y32C9kYNMRJtinaInsUrDcgCiRb4dJ30N+OUEqWjr93LgIFx4Ka0xAApzzHFsSutHdT5THGAJI1koWbVxEoD8G4BBNrKCL+A8GleNyLDgRKMobpa21tBKxCZeMn9GBuTA+jeX1rxKaJ5d6XYcPXfq74WviS70oSyPAK2D9wwKYQAH59VF1kWqSKsWknS+qAVeBKY7hDWQV2dYz9O3RGuYBbbWT0AYW6zEhn4PS0PpLQVysk+804vaMXYjQEJiJhYdHx+hKAVaIRNV9TARcPd6UxR48zHQJ15n8wz+SaDY5WkNp8ji5uMB0PrPjAIIdlsFN36jmnCmIpdvJZb2vOWygY7NTogbPdcZ9mDj5Jv7+BUx4fueepvubLXekP73txOcGgeu4X/ik/r7WuOgGXrbjn1hzkeQdd825H/a7K05Osi9wkHUZXZPfkR9JBrfCiCfe18Etmqg/K4b4UzC4rL01+1sspDIdwxzUySRn29VSYkxj+qNFfYPzOyBdEGfQv8yZwHsUF3MV+MEnuGBaADMAHi6Uk2eMMmWwCpRcAEUmKJbAZkOIV2bTrgNFkiZoDq2L5ntT33yaBUNY0xo40tsh7SW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(396003)(376002)(136003)(366004)(39850400004)(5660300002)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(38350700002)(508600001)(44832011)(33656002)(2906002)(7416002)(52116002)(8936002)(6506007)(6486002)(186003)(83380400001)(1076003)(41300700001)(26005)(6512007)(316002)(86362001)(54906003)(6916009)(133343001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zJ5uJ9yXPRkm8Df8a6JXs+ilcLye3l+SnNRAnxgWWH8911eFrg9uCcUq8M/w?=
 =?us-ascii?Q?+br1vDehCx2qnqxmG1yP9ao3YYyELiQ9K5lcBsBAica9BzFUpOZO7gt9w+od?=
 =?us-ascii?Q?jW17uA2LaEWEZ66NmLcz0Sj9J7pp6SBBztME86RBXA+aJ3BnUNr8hh00UPqX?=
 =?us-ascii?Q?fK95S04CYG8yOkigDSOgkF8nUNagJjMoizMlEec8oP7DUQqM00armym8Yy5n?=
 =?us-ascii?Q?qnxP39zVeDQO+cgTdu/DM4M0S1FKPagaNtB+H7ndDmQm/B1gnBvy5Pvv7bcL?=
 =?us-ascii?Q?3uV5PeYoLHkroegAmlY8DjWnZry5HcxP1XuUioBtrEgzmUPIAselSz/dGRI5?=
 =?us-ascii?Q?LLjMZh1A8SnoG+8LzttaOsmylyCjqlrYcvr6REih/w3Deo1m9XCOWoct2WQu?=
 =?us-ascii?Q?0Gm90qKBmu5ebCK3vu9RliQEBUFeUtU4KAJIz84cEwCqsLfuyhbydw7C9WR3?=
 =?us-ascii?Q?dBAXuwV7q4VsFQdE+nwhvi7O64NQQTn6LAe2fyI0XqhxBgK9FQXiBfiHuXnB?=
 =?us-ascii?Q?+mNt0RLkz72x3QfaI0jNu6CrnNqRqwaOrF0x03EPIfVeSFqcxGs6GDURU1er?=
 =?us-ascii?Q?ThBcveblQjvw/Y72qtEsfUQ3pUCGDGKWhmTlN2G646LZaz4r7KwcPIu90sgw?=
 =?us-ascii?Q?hoCSO5rhZ4tpkISaS6naHdbkQ7c+PpxUMM+9ZixXJvTk5b/yn5Smhyraz5EM?=
 =?us-ascii?Q?1ExZ6q4X/gDNUAqYrE+mvGExCWxywZEC+DQrB8gyHu11HWXuYfazJ1HZolhV?=
 =?us-ascii?Q?M2frSGbNlMUOktKLgFa8ZL7XJM8EMVEMkJa9xp7O7xgZ45rp9Q1NW+srxM3X?=
 =?us-ascii?Q?8tuLKJxQHM/vgIIyARwX4/3+7atLtVkJmetF7GYHBhPX6hVCUDasKCT8FxvI?=
 =?us-ascii?Q?bKxooh8VnHYl+ZMx8NqdwwR0M21I4eO4Gkj0kSbfdR5A4SASltL8aYwETp7d?=
 =?us-ascii?Q?/C2CC/FSAUPsKCatc2fz3f/DS3mdlBpzAkfcxP6pTN+pt9/hbH32mOfwt7Zm?=
 =?us-ascii?Q?1B1Pi7bhlC1yBoAkboya2cQphQsWQ7Sfxf7Gr/Fmmmt/mzhu0Xz97WnMtEKm?=
 =?us-ascii?Q?Vgn0OUyNo21i+enSJai0GGwEjMGx5lCUzuwrY6Pe8M60crjdKgQsOtVngxUw?=
 =?us-ascii?Q?qs6ZeMYzZhpiUtqxoaBAXXTw1WtzFGKuWOmC+6fkkW4TZQteGqfkFctsIZ7I?=
 =?us-ascii?Q?Fp8jqbRcz8rT9Bq3iz+KMvm7PNF/STbVQp/o6uzCEl0ZLwswKLjSdY83Ywf9?=
 =?us-ascii?Q?vU9WEuOXUSdXBRRtCu365yGqeuFv99vN5P9RyowLjLrByRurSvdfxlsuLOUl?=
 =?us-ascii?Q?W4cZfbks8USjVYB/KxjqpIrR8ExaHHItQOpPubNPRUv36yPs/Ks5tPKyKKKy?=
 =?us-ascii?Q?URr8uWNx/djtCzMCzxUKzGjlBBlk7g/Es/iB8nQCCS6dy9hQpf1ixwVLyuJZ?=
 =?us-ascii?Q?slI7ClsVICsYGZZeTHuQ0xySy95L0Z08gGzaQdoH8dco2KeTAa5IX8tCuPQv?=
 =?us-ascii?Q?9a2jhwXtNOohNM1yAkm5iFGkL98+ifO1RGCp7y6ZuOZ/sLOL60KEg5RqxJfY?=
 =?us-ascii?Q?LD7RlPcLnspa4DfnGBkuiLSKwJgLli4NenNXllfgiqUDbr2fUr6Uwnm9wiSS?=
 =?us-ascii?Q?kCX3XuA9nBgU5IB8XkjtM8UNK9EjWSMM4GlsMC+Tt6/y1f6u+EnlkZhmi/dR?=
 =?us-ascii?Q?s6n6UpjZh/MPQ9taya2kwlZwaPnmWfeRJJkIOtWjGJkh/d7Ox/HVeGBPriwi?=
 =?us-ascii?Q?tKCx/YkjVdvTANvos8LJG+6MAOuS1+U=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff961e9-f43f-4dfe-d0e4-08da3fad33f4
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 06:50:36.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIHxxFX4O1Q777++pW6xTBuk6IDYC6pJ8jjHbrLRfbunE6q+cu3jBejd0FLTLpc2XmeCZd2iN5nP40gL2g2oCuVCnBTYEmAIW1daEk6imus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0441
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 25, 2022 at 04:57:39PM -0500, Bjorn Helgaas wrote:
> On Tue, May 24, 2022 at 12:54:48PM -0400, Jim Quinlan wrote:
> > When brcm_pcie_add_bus() is invoked, we will "get" and enable any
> > regulators that are present in the DT node.  If the busno==1, we will
> > will also attempt pcie-linkup.  If PCIe linkup fails, which can happen for
> > multiple reasons but most due to a  missing device, we turn
> > on "refusal" mode to prevent our unforgiving PCIe HW from causing an
> > abort on any subsequent PCIe config-space accesses.
> 
> > Further, a failed linkup will have brcm_pcie_probe() stopping and
> > removing the root bus, which in turn invokes  brcm_pcie_remove_bus()
> > (actually named pci_subdev_regulators_remove_bus() as it may someday
> > find its way into bus.c), which invokes regulator_bulk_disable() on
> > any regulators that were enabled by the probe.
> 
> Ah, thanks!  This is the detail I missed.  If pci_host_probe()
> succeeds and the link is down, we call brcm_pcie_remove() (the
> driver's .remove() method).  That's unusual and possibly unique among
> native host bridge drivers.  I'm not sure that's the best pattern
> here.  Most drivers can't do that because they expect multiple devices
> on the root bus.  And the Root Port is still a functional device on
> its own, even if its link is down.  Users likely expect to see it in
> lspci and manipulate it via setpci.  It may have AER logs with clues
> about why the link didn't come up.
> 
> Again something for future discussion, not for this regression.

I experienced the same end result, root port not available unless the
link is up during probe, with the imx6 PCI driver and I'm also not
convinced this is the best decision.

I guess one of the reasons for this behavior is to save some power, but
it should be possible to just disable the PCIe root port in the
device tree to handle the use case in which PCIe port is not available
at all on the system.

Francesco

