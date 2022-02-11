Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6364B1A9D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244490AbiBKAlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 19:41:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbiBKAlu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 19:41:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B35F89
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 16:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmkwmLyXVipfiQ2fdogbvUpunvzf0kd8Cugk9toSJy5flXxFT+VUZF9R7/Jiz6dxWRCdOOg2abC+wFVSKgGaOWiEv7FK2MEYWYP2lKKhlzLXqvDPaoCYaU+xu85uZveYEko+9LuwMGRVQvcBwqDZicXwPFaJR2s3J3jAhbVpPFoEGxyRBQxJtDSHKpvZOhFSyUmt6UrnB9ydn6kLkYDwB6y0+HqrAuAseOU+5Dg6yA+8qTHh+UKs7jFEiPfF7ekFWBo+EsLoEuVtS7LkUW3YRJdppkfMCjMuXOObjHrfLUrUe/HgZ8T4ZYslUfL2vEN0hojI6O0sPvLFBSVeY5myCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4geiNE5wNKEzx7ODRCekobfzQJ2m4y0X8LjNiizgO3o=;
 b=X4ksOC1frQYNuqRvM/7/GG+8BxXHuR6FNre+5Ufpzi/UcjD+Bj56SEllB7bEIxhyQT5HOYUvdyzAsFB99AAUTL9vu21PWbB6RMn/s/5DBc6+vstv9TaKyhkvbsxPYvi8bC5KwqIqHczbUhX98qzs+pKiPHVmj/X0usQgtlgsQAMqteQPeRk+EKaqiRCm7YcdC4Icq4pZSH0ekriREZNjHfkC6Os7THhy+GFC8/evD4knfiqxUUGjMwFA8BxTyLigQfKRLUbHgjwD3sDaoFUxGcHC9nuKSzTsXkeuoO4t3ntn7RofR+xHRJPJ8ZjeP6L91vd68PC+IWkooUCIkk0/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4geiNE5wNKEzx7ODRCekobfzQJ2m4y0X8LjNiizgO3o=;
 b=LbT7WVZniek0/tBPyRiLAxfjO6t0R3SfQaT14DNLK3O1dHA9SdUvgYdxylUyOw7fzKT9Xhlx+W7lPm4/2mVvvEF4sKgdSpn8b5pPUd4zhyuj7tTHGw1OE0xAjuwnIKx7weGcD4XaQJ14mQKNS4fBQrIju7X8JbiZhc6EdtT0kv8RtjDcXbwzCWOxl7qQpPhkzYluH4GonvxWq6N0iBSghhVxWAP0esfzJWpFrayzfEiIFa1ABKyrX44nNKqx6DoHbIGkGU8MN8k9xZFNf66Mg8csJXhl64y+qUtXmY8mfo8tBVeKYp8XBktP7hfNU1ckGPv/hhkfph/l9L9xNf0omA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3338.namprd12.prod.outlook.com (2603:10b6:5:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 00:41:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 00:41:48 +0000
Date:   Thu, 10 Feb 2022 20:41:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Josef Johansson <josef@oderland.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] PCI/MSI: msix_setup_msi_descs: Restore logic for
 msi_attrib.can_mask
Message-ID: <20220211004147.GK4160@nvidia.com>
References: <f5a224ee-b72f-7053-6030-b6c4d8a29be9@oderland.se>
 <20220210235532.GA663996@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210235532.GA663996@bhelgaas>
X-ClientProxiedBy: BLAPR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:208:32e::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b59569d-a826-40bb-b133-08d9ecf74953
X-MS-TrafficTypeDiagnostic: DM6PR12MB3338:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3338736ED55F7F7980C0C638C2309@DM6PR12MB3338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxI1r/6O2L9O7S+aCRA0wUyu3usLIPURkmDze5brCj+NJzvOeDoDrkY/dmAI3KYEdmg9/DqsYCHzCkVQ/L3I3ni1N5+6M/RdvrHphGE8DZuFt2JIh4u5tpTOsBDZk1tNHxxSjA2pOmwa6Fl1P3fmsPediLPEGhVrgVYf4v0mbQjgeXtF0aUTSLymjRbfaKjMyShm3PBavOdahYrY9sJevHFqMW8OoFlb/yWj3ZbAhwWECxiTL6gDPBesmVPNandwU7Ry03Vx+kedUaeULjWSz/L7Ifcp6lgGjvzP/J56PHzYhgyu2meXifETKVsgSVZPdQRr84zlF8OO7pzjhGghP/Am0HBL3FoWg1OzUMLOmCboA4o8O5i50roFrgd1yvufYbVCRfmzwsKYSfeJb049d+wqpAG+LieEWSdTIVXHDD1/7Vb7zpKTCGQPufcjYOSoiI9gfxRPE/kQyhAmKY7DxHaSjtHQ6uD3MHCjnzmB49nuz29gQFoUMWce2GWGAjDhceUiUPH87741jHZ3bCqij59KbhpO8VwzhXvbVQ/y9ZZ+rETEsqLTG9apZXqIGJx9DpmfCxptgUZL3WTIiakFM4XgLQQAAm3DtTmNZednr5Sgq+s0nWCR5pbsM0IbkpakW4k9iU+PM9klPJuErDPAYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(1076003)(6512007)(2616005)(186003)(4326008)(8936002)(6506007)(36756003)(316002)(6916009)(26005)(66556008)(54906003)(4744005)(33656002)(5660300002)(66946007)(66476007)(6486002)(2906002)(508600001)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9SgokovyEVYA1rXtvfv0nqsW7nm1joc2RW4N6nJ9+g0lOMHtK3LSfvBMKfbp?=
 =?us-ascii?Q?JSgz1Fm0bWIgWVM69giROrIxsEe4Ph5X5303FYlzN/N8nua21V8htXcg7nxX?=
 =?us-ascii?Q?IkByPQDA4MZZx5+I/z9UqklAGVV1+kBXJed5866M35r1gcxWnuGsb2Fm+hYD?=
 =?us-ascii?Q?WYY84fePKxIbay8zqJ/o/glW05WW4xNp9kM4J8F9Ygmt6rYW0ucSNvoIlQnv?=
 =?us-ascii?Q?lRrauFbhR99e4lNhlB3yvQv6L691TAJtMJhUpJwGJYciPovo71z2mPP9znsh?=
 =?us-ascii?Q?zmyL1brvxm2kpM7axRhO8GHBjevX2+Ay07MEwmc7mO6gxqRmKnOcPkP1RVnL?=
 =?us-ascii?Q?Sp1SIWDMRTMGsFHGiR78tT0JPfFI4lP9PXwXGQIbPrKi8um+j5pDjouVJiU3?=
 =?us-ascii?Q?AUXWvyinml2lwPbPMjmith1Nt7A98BCuGpimLmWzMfy3LHtVpUucXINkF3E9?=
 =?us-ascii?Q?22ACR5slyWokOp5Sea3TmOE3JxmU502P4XiK8JgsAB21A/w7CxBpgxv9PmJq?=
 =?us-ascii?Q?EUcatnto0+3YaSC5c2UQ/QPNckMY8FGKWdggL/hnZKR0h2yfyHoaYXqHSy7D?=
 =?us-ascii?Q?C/Y+iRnb1OeoCg01h5nlk3AWbkhLn+reQu1pXO/DL+uNaL3ZAVJjojkdUILC?=
 =?us-ascii?Q?go1m6QfWh9GeCPmFTbnpsyIRKNxguPdsj20h8BuCJUr/6Fh+MM4aiqQlfqh1?=
 =?us-ascii?Q?VRvT1UvaKmM7nVmvs7TY0w7zRq/0tQ37QzqKBUHQc2KRUwxMBWzpJKXtT/Cl?=
 =?us-ascii?Q?tQuWMIrKxWPaT8k0OEvIxvljZI7mWhMqKl1W6GVL0VCVJc/kdnYFkTN6aJV6?=
 =?us-ascii?Q?B/UKn8DelFZS13FCUS7Z84KumY4tLQaojnIOP9xmNuDSNCm0r9Rbb6k54uKb?=
 =?us-ascii?Q?NcMG2tBJyQSdXkhyTfXP1uhdjSuXNzTuNNxqCibLW4L7p0BK7FoAKWQxfvZf?=
 =?us-ascii?Q?Z+Cy27uH52t9wajG7oB5PyP+UA038UYj04Xl+1oOCPGo8vz2D3d0Q65qXphs?=
 =?us-ascii?Q?hZR/pXfS7QafiMDK3TzQsmpZUFsMYyJpWk/ilmRSTWOuNRMZgllHMRtQFHQ4?=
 =?us-ascii?Q?IzBiC2byAavFCEKhkTBglaeJUHKVoRWNmthblTKsu+0vsIQ7u1Y0J2/m1qKd?=
 =?us-ascii?Q?Q5q1YYuST04fdFVJ2npQ9aMOu+QsKAhpuAU8Mk3A3XoiFyAzesBijuwbdrgW?=
 =?us-ascii?Q?I9SrjKP9F9mWqwucGKIfA4kGZWWzUqr02eetz2YEZdwvId1MAX1SlqJ+AEFF?=
 =?us-ascii?Q?I+le1h1sRbPoDipJYOTYAoXNWvq0YbhGIyL6uzZcsF8SThHIrirQXEfJI1BE?=
 =?us-ascii?Q?IDoHfo/dWqI+kr0KD50iUN1LnpSjTYL7Qn3f1Zo6uVhpdrVrB8RxsWvgbpbO?=
 =?us-ascii?Q?vPUQylk2deg7kbTocOK5IVzwaYImB/G6a5l4su/fZ0yoEg6qxgXn1aTi2DTY?=
 =?us-ascii?Q?zxjfRMbBPy0eFu/Kck+tbe+bP3tqxXR0OqFn4cpT7KPjSi0nhwkiTVd0+ryq?=
 =?us-ascii?Q?omhX12r0PyU/FRXp9h2mbk2DSIQ0+xaFQKuJ+5A//Ks2Z61NevxnCUocxx2R?=
 =?us-ascii?Q?Ei/wae9jtMGBR/xlPnA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b59569d-a826-40bb-b133-08d9ecf74953
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 00:41:48.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfOvg6sBsUmf36ncZbEg0cKDKM6Y81pd25RJUdGM8+TIcZq6S3yX2DVOjBWP4A4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3338
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 05:55:32PM -0600, Bjorn Helgaas wrote:
> > Commit 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") modifies
> > the logic of checking msi_attrib.can_mask, without any reason.
> >     
> > This commits restores that logic.
> 
> I agree, this looks like a typo in 71020a3c0dff4, but I might be
> missing something, so Thomas should take a look, and I added Jason
> since he reviewed it.

I concur

Jason
