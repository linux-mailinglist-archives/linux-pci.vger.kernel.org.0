Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1DF58AA88
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 14:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiHEMKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Aug 2022 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHEMKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2022 08:10:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB11CB11
        for <linux-pci@vger.kernel.org>; Fri,  5 Aug 2022 05:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh7Ue+MJvGMREL2MiPtXKas+SAYp77rsPhWFNPhF181kq4erhOLdILSC4xUvPhLRyRGIFvEymLuHHCMXjK1NVRy6UjatCh5DPvBz0lFjf1AXMOm4vjC/tnJRdPVgksVDVulMqvFmPPMI4yGzdiz2ozqb7WmtkraNX9rxYDrhFGl8ajw6logtnC9aA6BWeBefaSpEahuFi4hHiUjwFZMRfpsa9ZUNfgSFAx4xPMntsiUtnJqpGpjZ7WaLHtsGVqV8qv7VQ4jYpBwcofd5RpAWkH/TAnlyp3vmar1kFzJjuEjRAONXZRlvsunBrleAMoiaXC4TLDMtQ2ej6Jcel19pZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xxeV8rR278VqMcf3mIZ8bLAT4CFg7jhy+Oi9B4XdAM=;
 b=Tppk4QN1wkt4mSwe8rGOwh+Nig5+wlwI49BGOAk4YhVlUoU67fJdb+ZdoU7Twwt8U/G+yrxL8F/ps90NbuQS2FMCY+GQE6vF4gEapi96sDQA89JJn3jXFepvTlSoNQo6BjY5clnUbg5HHVpJofV5ytoT+OLoU9hyEswP+uUiPKmMkOh+9S2L1Cd61jfOWSbi9dpxBwFwYKUkuQ4qBb0K/JHZEJgN8I8aGANoAdwOXf3HjSF5YKa0aX+ncuD8tYfQh1vGsfxhUlJkpeTXq5OP+049t/iW8O/zylaZJ9eA7J2h7a7VSKDQ/zSfn51Y90Q6zoBq/kbHDJpCY0zXSjmWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xxeV8rR278VqMcf3mIZ8bLAT4CFg7jhy+Oi9B4XdAM=;
 b=ohPAArF8s3Pc3VCcZ9pAtmuOTkCTbCCe7dSw8Fb+HPVxOE8BLm6w4W8Evjk06+5wRCnKcTe2WfMRpMNCTyFBRRngpdoUt09qPxoYB+Umbq0/nhQnDma7u5PLa5FoO0cC+xckM3Z6WJ8QuWQuPeRlpt8HcsG03pbSC0B7BkuPIGn+BngURXIgmRiSrvZZKr0J1vW773Sqwz0R93Cte/opg7ouH0tChsJSaqqtfiMwShNlvCseB8KW8+FwaqE0WCRzVDjp+b7Wu9mMidwsX+17zwCnVhvBqxhoHv28/qulPTVlwrL7nxtbk4X2eP8rbMb7FMqwEGjHtrVsyDC8e7zbVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN7PR12MB2676.namprd12.prod.outlook.com (2603:10b6:408:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 12:10:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 12:10:42 +0000
Date:   Fri, 5 Aug 2022 09:10:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Josef Johansson <josef@oderland.se>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
Message-ID: <Yu0IwZXyTIhdALMb@nvidia.com>
References: <d818f9c9-a432-213e-4152-eaff3b7da52e@oderland.se>
 <f1d3ebc5-0e5e-20b5-430c-9426aa5e4bbe@oderland.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d3ebc5-0e5e-20b5-430c-9426aa5e4bbe@oderland.se>
X-ClientProxiedBy: BL1PR13CA0282.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afdaee0a-f265-4bd7-b749-08da76db848b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2676:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/ZYL9xAGYkhlwftTK0ifDVhB7op4XjzUWiujDGOpgIfgQRJBixPrruv9jedOjn+DUTYPVkUNWcKeUXjW9lvsjb80M+ZLgYMCJTvcJocnP02IX7N5OQno0CromeAM1YVTT2cppfNAKQm6njZXy6HBZAxnSVw2RrKTi+bd+QzZDZwxmebBqpBHrrin4DUhOmBLmu/s4L9HPjloqizym5o8BW3XgEw7fh2T4fzQajCbhPn/CN+ebhtEOwx4D1Xlys829a/02cS9a9YZ4EeXk8wCxLnfnqlMqvVIL5Sja0+/X+8NSdOq1H54YLvyyRmC+MC7ZdNik0n7A+ZCE1JKvDvUj7RgZGPHwReFjHiPN5y9i1pmRHP7PUYR5WxY1bZePvXvbM5mg98hvoEKl5xKbfcNQ7JBnQAAHrjtMGCB+eVc8/BFTK7jOiOwvyNEIhhZtW5UaEqHVaLj2dAdUo/882mj136b7si34i+dGPokGE35SKM6N6I9hXfBeSLkuvZCncRF6OImSPQGnJ/TlXOyfRsSCDXhU/j3WB4GOf00IlSn+9AvBtLOHZwZt/r6S0+6T0Y3kMiMJO/cBNZA+3wZDNHf/qg8SComgQ6jUOzeAhKfe+TRAvFlT9V/hkuRTbxyeKIyvyb4HBhmAOXW7UUHsboMkVv/8J4Lw8/YUYWZvDeFAP8QXRm+vmQWBGuMB9H1bxhMbv8Lhe6n2a51n6ZNXQU64JEF+Z+ox8VmP/HO6lsaMdpsvs0jnYtze7XfiJuPMKC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(2906002)(83380400001)(38100700002)(110136005)(6486002)(8676002)(66476007)(4326008)(66946007)(66556008)(54906003)(316002)(478600001)(2616005)(186003)(41300700001)(5660300002)(6512007)(6506007)(26005)(53546011)(8936002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGgwgg62OJ23hNDSV0Aw3rnMkOGNyck/QKz1/1gbN+JxghvbGwv6nAWCj7T6?=
 =?us-ascii?Q?o0JHGTDaH+hnsG8yi66ES4IL0mkgxqCrfUFMS5Uf4j4+/WHkGwqV9HnZj8XY?=
 =?us-ascii?Q?2uIE0N8RoZpyWDbf06rtDinXCDyU9Zt2LhNuOHaC0ZghfZY4F+K65Wgu6MNX?=
 =?us-ascii?Q?V1opUK+5nvd2fu1Hs/wQwwQzi8zpZvqbl4ZM9TKoCvHnFPnD8HS4ZAvElOjC?=
 =?us-ascii?Q?2cD8wuFYoyJnDSmO7vj43KQznN9PuLJRUHbOuxhTHvDQA95oP0qKXhjc8av6?=
 =?us-ascii?Q?0qHlA5+NrgUv+/yxzirRvHaavxIYuTP2M8tYixjewrnO5GAipStI4up59Pd/?=
 =?us-ascii?Q?A5tRVGUMlnBY6Swo/LnMz3vbVpDew+6gxyq54azrXv0coK0Fd8toVt7c2nHG?=
 =?us-ascii?Q?8dl1wpiylGgr1PWTloxxjJOhugrXxUNYhZq1Rg0gbLnKxV7ZPPEmFlKjpHk4?=
 =?us-ascii?Q?w4qAsCc4QdYTXI3jBHyB173TCvVHqUF2+ZQthYzNhNYqkwVsObF5iSgZNrar?=
 =?us-ascii?Q?cppY59uWAa2YBPxh0orturx4qVyHz+5rysegmn6BUBnqVyWceXgKBCKncZiD?=
 =?us-ascii?Q?T12rOk+jpokjs1Ufi3x6pRMP9EltPnbUHk1EIBoapH+LwrtghEK4zvR0/Xrs?=
 =?us-ascii?Q?jAo4BPFM+w2j4K1y161RngOBUOcldgFkbwKkrIn0+95OGtS4ImxIvThRScYf?=
 =?us-ascii?Q?ZBUhQCBQpDW/AOF2E9GUOKzJ0V8yxC1zx1ttHwgzwam6bRDCyk4sEGIyhrsC?=
 =?us-ascii?Q?k9oJnsFMaSpIrNQA5RIXuRlwY1LqW9NqV7RavaAuOGqLuwTRulP1sp+5T/A4?=
 =?us-ascii?Q?wCBXnumIzJLe3OBxvhsj9dP/2GCO9ZHSJE83KOExGOetBXDYn+sVahUgdpug?=
 =?us-ascii?Q?usN8kqGx7OuhKQ40EbRXDldQLOeyuyuWBpzqlGNUJy44wsMHN3xF6/zMpsOY?=
 =?us-ascii?Q?rCiajsQRz1/ndenQL6NvojSl8u2/pbij46DrOIWvzCuMiTGnKLpJCa42mFY9?=
 =?us-ascii?Q?vvcSWxd4GEukb3XcP8sk+XhzEL38dt/9FvmvVSCdwS0DRm4dA3LdXrSy6O7J?=
 =?us-ascii?Q?2FvlvwrZh8nCqUOt6n63Ytmos5Vm3KdTAdIP/9XQDre39Qy895AOxiAm7eCn?=
 =?us-ascii?Q?oGre5gYvsYUUXrEuqPA3FZ2G+MUX+TOOCpzSCTSSakeHtTnC6BMGdVkar8ww?=
 =?us-ascii?Q?jaxH2vmFAOGaDgQ47h+aMvc61O8o6dOonRdXAIPpkoDD/7/HbCnxjhVTfaWw?=
 =?us-ascii?Q?wIpe2EDZJ/fLJbMef6DlHLq8G2jXt2iTH0wog0/ZHhDoM0owJjSLzwO+5h4P?=
 =?us-ascii?Q?CoIY+UWb/iNRLkSOLm6nUYsYDkNo7MlCv/YeqTFniEMsAz4/za4M2p80/9Pt?=
 =?us-ascii?Q?i7vlbfHGZfD1OvZopmGflQUuSxyM1LKS1wUf7THDpNgEYMNtD7CLCH/vm1hd?=
 =?us-ascii?Q?yX98dteGwXkFkkNSSBw6Lulw8clVGEoKSjv8UNWiQszYfLznLfdJYKQ1TIlg?=
 =?us-ascii?Q?UACV7oT0C227KsQxrz5L+nXuUg3fn/K3ExM5Z5KL3InvEhyNLIpQp95vWhCF?=
 =?us-ascii?Q?99SmlKH4n+zHdD5R3VHDLK5KY1n6WKFuQZvANujw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdaee0a-f265-4bd7-b749-08da76db848b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 12:10:42.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDCa341oS1udUlYEgJR16KRnAwek0Hf8+0R/6mfpfWCq3DIikXCfeZKySxscZVSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2676
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 05, 2022 at 12:03:15PM +0200, Josef Johansson wrote:
> On 2/14/22 11:07, Josef Johansson wrote:
> > From: Josef Johansson <josef@oderland.se>
> > 
> > PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
> > Commit 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") modifies
> > the logic of checking msi_attrib.can_mask, without any reason.
> > This commits restores that logic.
> >
> > Fixes: 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()")
> > Signed-off-by: Josef Johansson <josef@oderland.se>
> > 
> > ---
> > v2: Changing subject line to fit earlier commits.
> > 
> > Trying to fix a NULL BUG in the NVMe MSIX implementation I stumbled upon this code,
> > which ironically was what my last MSI patch resulted into.
> > 
> > I don't see any reason why this logic was change, and it did not break anything
> > correcting the logic.
> > 
> > CC xen-devel since it very much relates to Xen kernel (via pci_msi_ignore_mask).
> > ---
> > 
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index c19c7ca58186..146e7b9a01cc 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -526,7 +526,7 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
> >   		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
> >   					       !desc.pci.msi_attrib.is_virtual;
> > -		if (!desc.pci.msi_attrib.can_mask) {
> > +		if (desc.pci.msi_attrib.can_mask) {
> >   			addr = pci_msix_desc_addr(&desc);
> >   			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> >   		}
> > 

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Bjorn, please take it?

Jason
