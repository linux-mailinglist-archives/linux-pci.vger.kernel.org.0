Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4960681990
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 19:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjA3Sri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 13:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjA3Srg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 13:47:36 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C81BADA;
        Mon, 30 Jan 2023 10:47:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDOnocyXEDKlbCUN7huIsxdvzAw3C4UJWKQipCRdVewLu7/yQMXEgRI4Semxap95Ns56jVZnGcgmSiFTEOs7G8plE5CdQ+hAiJreyTNmAWVoZ7nS+KpWJ2qx/jU2IYsAqFBZa86j6AoxvZNpfqrQArEhklwra8H5V2kmJQ10MbVqXn8F2/DuevGDa18pkddPLnx2Y9iS4OiXkujqJN7uXFokStYLRuSc7er85wjEt67Dea0PVd7/MAf8WrdULEOTYiq6O3byS4rUvJvGz9f4Mwutsq/TMxUBqEIbeVRZkDIBBlgn1A1/iff/c5X0G1TiHZgPUZvDB78JizbIPQLBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34bt4BXEqlLQ9SQJgqSdQHPm0+M6diyuNRajmuIsDFM=;
 b=Wz6yM5ZeA794BhF3YOMEQLVDwpO8K1qXZ8E8g6OweS/J6fNfPewFgoPmD2H1M6oRJCi1tBbY6+Br/DfVWgda4NAt7jelRya2VfFoscZjI7y68gg1/YKlcPOLRMm7be5DWSJJPAqVW3Hcx6Oobfxq3BZ6A4IcQfqpi0KiF7ixPIJJvG85Q/GP3lCILyDNAEGQCggYmkYYI0A9XnOoO0kKILqk1+tTH3H18wYLOpcvSDUtNauk753LjQPbmJscmjylc0vMMkka2pOz0aDufOxMgtxAON9w13UBdCO6TYmf0QvKNr5J/+H0ZFMJRo9MSJGViiVOtOBIKmgmwbzOd3XqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34bt4BXEqlLQ9SQJgqSdQHPm0+M6diyuNRajmuIsDFM=;
 b=AtiqmPabIMKjYkjrMMiGs3KY4JQ3RECe4yAClQ0V5br5vbQ4rsBycFL9Kj2nFVe0f8myLTDXTqeT4+dYg4yFvKe2Dg9ceoydiYRWPBA5Ni7li/xYMOqvOcBSiHnvN90uT7ChhoqfrbDp4EndBhkNDx5OANmDda4ihicqbI9uFR8h0Ofj2f/Dp5Gmn3vPhXelG+FYdyY2JRSIc/ysAxLipDE3cMlaEnhqkbtNn0iZJtzVHDjsmfZAk0JZJa91lEL6NiwCxnr86mwcdobROw/kATTy5skoqTQpORauL+4H2IMWOUI27xlPza7g4NP6HCMH/+EtbCoJJOMiFalKUt65QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 18:47:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 18:47:32 +0000
Date:   Mon, 30 Jan 2023 14:47:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <Y9gQxCmzqq6WXZK4@nvidia.com>
References: <647de371-fe11-15b4-5e11-8ca43a754180@linux.intel.com>
 <20230130183810.GA1692786@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130183810.GA1692786@bhelgaas>
X-ClientProxiedBy: BL1PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb9956a-be43-409f-9dfa-08db02f27263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSeT9OfJ+T7NrYNx+aOQZkVAyYPnbLnA1kcjrj30kvhQPzmbhwYnNT49egGzG++k5Hx0BwBU64HoVmGkrnE+n2FXVJ3SsaLgmaKcr6gXDFajmQ9itcVOwrzd1uqWXK+TUzYkRJGLCWFHj0eS0M4PgTf8IFV591R0aLNgv+Lvb5fZXIUFX7glZvhwhegk+ipk+ezzyA6LgLnWxzyXbcnVFa7iOK/aa6HsSzJEoJ/cLm7uLVbnITxlrknLxWg4BoHXe60JB2rG5EK5ERH1tuMvG2iN0eWwhegkUijdo8TVFu7gBcsHRPg3iuyBJyCgNxPrQ6h/emaV5Ji19n97YQZ9YzqeI+R5KXjXF4WcFTapSNM5HvIUYphuOAk8M98bJAogV3nIJKY1H9Kl0vU52sKRo4mGm3KHqkwHs5xO214tHR1X8XBuoukpUQCLA6ZO3Ag88u1k/X8JtWc2XOyrSB2wF1tTDGnfzKXjBgVRpFTMgCeiK2UIdPmbp7NBGpooNox9vbMIrDjSxZ1NHD4Riz2JLdF9kE7QUkvjPTKLBQYTegxs+3CS5+DeIcWLg6FOoOcDKG2FoH+i/N6Qoq4+z0/YrX0NNl5dEX8DTTaYkk3r3ub5zC06drefdz/hUx7PAsZZhgdnae46bctoVFTsyCfFnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199018)(36756003)(6512007)(38100700002)(2616005)(186003)(26005)(5660300002)(2906002)(7416002)(4744005)(6486002)(478600001)(66946007)(8676002)(6916009)(86362001)(4326008)(66476007)(66556008)(54906003)(316002)(41300700001)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBcVX8p7qKbaqbrtNJPGBZGyMiSv5e57RVCNEHGEQ3zob0MPWfaCLNlssMTS?=
 =?us-ascii?Q?5W0v/Fao3fhUPi0jzKItjBvXqO53yol6KHLJLMpOLMiNkbeUhFO5kRjEPnyh?=
 =?us-ascii?Q?i9zy2F+5x5tLf990tU0db8z292yj/AU3EeZk3oU1TDyqOFgS6zshijQ2Ek47?=
 =?us-ascii?Q?YfLM4OhtZzTcAw1n27fG7dDdQXNUmsr0Yy/eSI1d2LQr1er5kklHGzS8YkJh?=
 =?us-ascii?Q?jz77nAW5C0uBkEdOJBMk/aN0WDl8/pCvOS8V8e+BaWV9eNpiEF/Qnx2WxezR?=
 =?us-ascii?Q?YAQzNtAE/9b9mPD0cvipG90cnxwXBbsKv8h7HpsILJ2EQAInSKnYjoRwyr3V?=
 =?us-ascii?Q?36llEZA09GXcThMdp+DfmTiJfr2MsiiaDe1RwOeJtSNrs66KnQ06LatT2gev?=
 =?us-ascii?Q?HRuskan7AJawTjOSb1k7cpJxlCs3QwCKRg+RKE544YX6QMzKQYA0WCxygsy3?=
 =?us-ascii?Q?A+SmNEhYWg+kEO0rgPAorVN8gtWeW83fo5joAy+/z3itY26HGzhIWPcbXjgT?=
 =?us-ascii?Q?Ti3eE7aKqSu+uWCWK97hvLCBtu2ZpxbAMQVq10ZBQ559242hmAngWA9hYhMf?=
 =?us-ascii?Q?lwXzcwVkJfIvNj9/EwQZcgE+9UNFEGZ+7PjoYvozOFe+jy1IPQ3F8Ogu6b/Y?=
 =?us-ascii?Q?2Pgx7+bSoaLP4FuytCuHBK9hc/Z2GXXgTZryNz6qt3nK2As7P5yz4eXbVRhC?=
 =?us-ascii?Q?HSUNMh+RilJu2AUwBxUWguHr82NrWvduscX/zchSft5jmQhGmUQL8q4Y5ZH8?=
 =?us-ascii?Q?Jc6j2ECP7blh0NhpqbK8gEafQ0fJVdHmv7kQt+q47GHLk8l5Qy34L5DKjzMM?=
 =?us-ascii?Q?zK3rMjOL51iGVB1rcp6BTWDDE+DugmNezanZ7G7TDzzeVH9olBfACdbKlPrf?=
 =?us-ascii?Q?6bxIjH+uAjt9O+DhVg4FgoZoez24R4oscJoC0H/acbyvn4F/fnITaTLlCN9q?=
 =?us-ascii?Q?EnSsnoBALwQ9Iy8XXD24qRa1fabDW2AeBuNYidtnNHcwoV+Q1EfEe3BorC62?=
 =?us-ascii?Q?l4HzaWbmKE2FcUEvDwt3FslQX5gh6asg1vPu6QwZcNk3DJ8pYqAXVwp5FFN/?=
 =?us-ascii?Q?gsy31acduBw15oZe5HTGamqmydS85vBNNglGcmQR+TDYwTZtVoN+AebmEJER?=
 =?us-ascii?Q?SHhQGWQne4QXuuBm61sZ9avuB4NnK7THMyv7iMDxxhVFlRoC0nLHTGhDYR34?=
 =?us-ascii?Q?R/xd4FH8ejFLm6xN26tgUeAXqz4mR1VFP4OkrLFPD343YhEgMjD08N/A+klG?=
 =?us-ascii?Q?/L2657zktLDka3gI4Tmt7vZjqu8N6lSVmgEkKgrDChf6TK539KF3lBr0KSK7?=
 =?us-ascii?Q?a+jlz+rtvJN4i1k0TsOG1cAPORz/R9gd80RsOQL3VvJl8UQkUYiKedSudrEk?=
 =?us-ascii?Q?6nQcLFzDrUzMge1lzvKeOPk8IapEU9rfZ3+KsmA5kwIlT3unp3BQ9mM9p9nC?=
 =?us-ascii?Q?JQMLnpR/gbTbzd67crSsicnAqi0Q2djh/1btY7T2ICCoUerJsRJWQdeQEsLN?=
 =?us-ascii?Q?WxPrMDqWkvC8YL+asUTg9hbUn0pNcz+kBtdxZ9g1Rmk8uivhYWycexppDnIt?=
 =?us-ascii?Q?a2ovciB4SodE0uLCTgPer35ugiJm7RxgnyLEXy2T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb9956a-be43-409f-9dfa-08db02f27263
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 18:47:32.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmtbSgHk7Bb8Utpq8v9b6GzgFC5V+QwmYc76uDvjA+1Lji1YxJD0YDPodMmJHhBl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 30, 2023 at 12:38:10PM -0600, Bjorn Helgaas wrote:

> Sorry, I'm still confused.  PCI_PASID_XLATED_REQ_ONLY is a
> device-specific property, and you want to opt-in AMD graphics devices.
> Where's the AMD graphics-specific change?  The current patch does
> this:
> 
>   pdev_pri_ats_enable
>     pci_enable_pasid(pdev, 0, PCI_PASID_XLATED_REQ_ONLY)
> 
> which looks like it does it for *all* devices below an AMD IOMMU,
> without any device or driver input.

AMD GPU has a private interface to AMD IOMMU to support PASID support
that only it uses.

When AMD's IOMMU driver is cleaned up to use the common PASID API this
will have to be moved into the GPU driver.

But we are not there yet..

Jason
