Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E062C693
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKPRnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKPRnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:43:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F25E9DF;
        Wed, 16 Nov 2022 09:43:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqex9DZ5vNXF5Dvlr995WNd/juPgcHvvmCUep85tfuzr66ZMzzHalD670L2T0lpnVv4nl2jAUNhzjnrJ95BjLH5eFKWkTXmJCiz5GykAmuk5FEQZ2e5WSz1Wue5Fr6TsrBQ47NCY+Q8XfpdZA6fieUFJUwdrQ9op+y+WECtOX+mubvsjfx45OoZj9kNkDctS6Hh2fsny2Mxd2KVfKkNaFFBsKJKt9HUKaWAUJ6PNIofq9R6pyN68znWizYkFJZQe/Wv3UGe7x4z7KGE59afOUAfQyQ9fnLBgA2bpvHWCin4IVMFOVK55NoAcBulnizjaPA8Un8JqSzqUtCcRaqyyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ado2EzYImMYDN/efQZZLmkFiFY+Bm3L1EKb2uLorsc=;
 b=L+VBFehCKf13dyc0S1CEUQbTxauBPjEsIny+EZcPg3JIFcIRLmlZctT0TvlsBwtfU/GuS9egGhuL0RnEoBpsFDVrvsbIhpPq1zWb/KyfAzvco1J7dpNgan30dEsb3VZ/c3VsbWqos9h3qHI736++VBsYNoeyXaFWoOW7aYKpSJZ+C65eFSt2zBB9XXSSFm0AeMBWMyhdJKWofX6HxmkLX8f45ZEPrhPNj58S0tretWVcUOkIJxg0cRwhayt1yI7HSrkK1+q14nXGFpP4xOMD0F7NS/ABpN8v8Sj5hSI55gm5SygZMs00oFH4DgZTI6Y7cxzm16kppvdLyb1Ox+jsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ado2EzYImMYDN/efQZZLmkFiFY+Bm3L1EKb2uLorsc=;
 b=AwUNS0wGdRZuTw26jE4TlIkuC2K2dUePmJEKatnSqQ0/DjBE+jO+53L1ljURL4+X98a/cUhHeYiAmlPX5j3zKwu+mVNQf2yt/+viFZehHB6NGfDfRwVojqZxknQ+/GNpSb5HVvTsp8wYFzTEOaXhxpNFHfloqYkGmqiCC01KiAJAZZBAMq9FFQf0MUGjbJDJDKE+gHa5qN1aOVgLONFr9Kv/SAt2lsoi6jOIZjMTm9QnrDRIwQm77r/bDwJZs2XZe7KCTT1IUdVeb/aOlEuULP/NaSYoqCW8oXl79dJseAorO5Py3kPQ953JwpeLq8i6DylrRNk/QxSU890oyPOd9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 17:43:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:43:17 +0000
Date:   Wed, 16 Nov 2022 13:43:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 01/39] PCI/MSI: Check for MSI enabled in
 __pci_msix_enable()
Message-ID: <Y3UhNGosBbucAL+g@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.653556720@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122013.653556720@linutronix.de>
X-ClientProxiedBy: CH0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:610:e7::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 28cabb79-6a33-4014-f63f-08dac7fa0b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3AxYZX3FM9k9SAVY5A+GbhU4HOcR7sl9C0H1IqjyD6WorWQPtvZb99NSvRAB8/LJHbj8UGGOnSvlf4ZEwZAjUcgSPZMAxxbJz33yqFbrPukrPgLTxHzIJStH9T1ncyTyvtd/AN4vi58MkKFXFMQtIHz4iSwYM00Ci+//lI++eW3phk3dJC00du3GHCrv1SuAwl+2tZZyytKDyUoP6qSYwia+2qeKvV1KVQhdjCFDh4kNWiJ7+7BLH6KrMvHKWgohkxhvJOJXB+UPZ08/en54AI8AK5n7yYZVJGeaJgl29nfA9SpIkNw7/FwmSS4kmwXi8B0NFRpvDh/YswxgnwxudgDdWg6PQ1i91VYx3/0Oh6hnEIVwNJom2VMXr3r4ACt0zgnW5AAMqWXz2AYY+sgobwwANXJmkL25mOhg9jI76iail3qaK1FYq4RJl+QimE9oT81CQ/lM+dnue5C2oyRUMLmUxvE95Hdl7d9m0jyP26kcX1wD9ROmN5cHdSfrqPu5wtdLxoqLn6KNlK+nOQsKbNm2dpJ9sQP9vcaQo+e8w1Yw3ZoEHjXD8x2QUVi5fO+fmrDIfI6eN3mLsaSVodiKhKEz/XvOPvwjsWoe7MmtW9Nr0fDWBe/ooeZz5x3x6+Nn9hQIQyZb0cqrN9Bgk4380GbGIbQ8Z+SxvEbz8+cfpqId0bsglijGe0Sfy6vR3E/u16WPNc//9FDG39isQMSt/yUXgiE/II+PO2T9yoVzHmBudrXcyR51uJPdad96cLV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(6506007)(6916009)(54906003)(26005)(6512007)(6486002)(66476007)(8676002)(4326008)(478600001)(2616005)(66946007)(41300700001)(66556008)(186003)(8936002)(2906002)(7416002)(5660300002)(4744005)(86362001)(36756003)(316002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3gT6vu5PsYoUwqgg+T51oIRrv+W0nnLdGSGmbCoZibD8UGKj6SBybZvjIlV?=
 =?us-ascii?Q?TJ21l36536DcyV+VEJVlFHt3UfwVz6zWUm7ZE+HSce2vu1TXHPH5Lkk9lZ4l?=
 =?us-ascii?Q?ZSKhy5eFx9KUjP0CpgWDYMIlV/iYx8aXINn4xgcc8Impi1o8D3rZIpxG7EvS?=
 =?us-ascii?Q?t8izvw9b4nXXSN2/KjVI7WvB68V8O/1obSedSiKGj7UZHGzhmwHxB7vCZvfa?=
 =?us-ascii?Q?PKImWdtcPj6ffFuACnZ9AxmMDsW8IfzO0JTZpMTGHR2HyWKy2H2IuE6ilFRc?=
 =?us-ascii?Q?AKCteFkvshaZTxGfyujAEQWu2LBbLW+YO3xNPiNxpuuP/1BYnsyp2B7jIjfF?=
 =?us-ascii?Q?EcldNSOzqZDvxUAL/C21cu7SQPD7kTyq5axqVjpPa9RTrwLPaD4haob82/7+?=
 =?us-ascii?Q?ELnmeD4XAF2L4IrEw6F81XvqqTIb9gL+8+YnvmebwPBcZeGirSF7S33wrrxz?=
 =?us-ascii?Q?0rleFtcINNI06p3Hh/cCwbu0R6zo/iasNdN/OsLlHT7w0sFbuLbjPL9xGsu1?=
 =?us-ascii?Q?qo/vVWoMCgzE40QqfUl/gYXb3Swpw8mytrESaHmWYzG7rs473YP1InSkk8P3?=
 =?us-ascii?Q?dDKMp73qpl4o0tX5S99x8m793G7m3lE7NNq6KnzG+ASsxNQ0sovbk0YbuJ+u?=
 =?us-ascii?Q?QEcqmPr9VFW4mL+uPNJyiw2Uyx54HRg50uiIVY0oaIGWDOBXJZa96cr9qsRx?=
 =?us-ascii?Q?BB1T/LpPWGGo6xo4air6eALT+PlonA+6mv5hu0H5jj/73/14ZF2Bk/Gdae/x?=
 =?us-ascii?Q?n20WKDOgvIGwQCux/pr4GukWG48eqQ3cVH7CPNAZHYJns9SNiykumNHsKqAA?=
 =?us-ascii?Q?uFWrZADrzE+z72y7m2a71UvyA8OCJ3TATe1GrVQgavh0XkKZbxxTnkEAFZB5?=
 =?us-ascii?Q?VnFa8claIUAI4CIxmMkMoWRnoplET/vRfy659eaSu4cGWSt5Fp0L6ewYtOfb?=
 =?us-ascii?Q?hg6kc/ndu9GgNbkYQ5NNopFTQwhP82W2zV78XS9olNxCNqyIM85ZVGVpzNrn?=
 =?us-ascii?Q?gWEUGsirxvRFhjCfcyIpPVZjEeCl0mvn7nTfANf4PGvpBWeIuU3C0s8YVKt/?=
 =?us-ascii?Q?p5B0xuhPvyTKNcqoYqZcy3sAbsbAANRb+KDdAvYYdylHIV8ZEq2y9vgyChPT?=
 =?us-ascii?Q?zP1yYyrXocaXSKr94IMYZi9bo7KHAYljYBb0WcO/PVIsIc0HMjBAEH2P+6YS?=
 =?us-ascii?Q?9oVWbjj/9MiNOOCo/Y3WXVbqlTdm8eRLWfK/hmCkRlxyCADFKLqOw+RDBrJN?=
 =?us-ascii?Q?DWoaOjvnINKhdVoiJUMpX2bA7iv0Xpc2kd2ayAWpTVYoO+O50xDmbLZhshI9?=
 =?us-ascii?Q?12ke1HA+jh6nw3oa3GWT07u/eH/V6nLRARjQKKh0+Uu7qLDzIDb42fOivwUY?=
 =?us-ascii?Q?FQO1kU6cnaLRnmuZixT6rrxGpIRpmLwSgSVnGqQhPEiMmEJ6tSgY6+L5xAB+?=
 =?us-ascii?Q?yBXCfgZnwu9Q+PbFd4jKJWYxeejzMzaKvEQaL3f1R1gbaZGa7SWJSQpK6FUu?=
 =?us-ascii?Q?hH0ttuOVEsFgTDPRLQMLPbW15jMQh+j5ndi/LiADYgBPzPYtj91Lud8yxOsH?=
 =?us-ascii?Q?szAkTlmGiLN+Or3zHyAc65iszHRlnXdw1otj+MwR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cabb79-6a33-4014-f63f-08dac7fa0b49
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:43:17.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mKtgOQocqS+9tMlAdrwnUfdlhnsf19q3vQSLqs5r075zA8PKzlEK/wMCNgxMHrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:15PM +0100, Thomas Gleixner wrote:
> PCI/MSI and PCI/MSI-X are mutually exclusive, but the MSI-X enable code
> lacks a check for already enabled MSI.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/msi.c |    5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
