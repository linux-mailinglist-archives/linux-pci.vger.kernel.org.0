Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B0686816
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjBAOXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjBAOXD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 09:23:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9361D18AAB;
        Wed,  1 Feb 2023 06:23:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtXdLKrKuWjmAMzlKBuH6QduH79fhMuG3rrdUe2Nmith8+ZoG8Mwdoy3otaDO+ZYd07MM3wy/1STihpJFmYREcJS/+cK3yDyndUnsHeiaLJ8gITTOT2ebdfqQ6a2RPd6sVyFy8tO+FVA7D0p68r+qu5QlwJitNVWaJwHTTiVdYI1dt4ORRFVYtOp5oLteKfj6cL12uKOC25hwClgbdz7DaECOCbvaOrC19b6a1u5zJ7Eyg9v4rPgQd3YbU5Q46x97K87sp3uXWyQSlaacUk20CDVPY/m3gT15di9jo0GSdyto38ARi5JuqzUOnZEEbiod/2CaikbYx8uj7a8X8sEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjL5cfExpBkmjhTpHbTdS2BB3czuRcgXyxqYbF7l/TY=;
 b=OPbkJSg+SQABcur0s8Z+IdKqCfT2YqlNjQe+GwBdw45AE4L7DVuKg0O0CByt7xLcHlKAqE9tuoJ0t0A7TL12Z/qyfkFcom5xRRL/vABZlA+B0HLYH/Wj5GTZpWkxSOnQcy4FEIRFOnYExd47yFzbt+/BuHJtd9BqsNG2fFJbDQO+sygC0GIEtJUt0l3+gHLBePDMsihVN5qOeE3GWvQa1kZzwxooLIn0rDfikSo/tXgskX60HMZGIS9fnKpIFmbdVF1bOrbj9NcPfGILUxhyaLT5EaFp1+APz31XMnWCuRSSkznRlLcGHKtRA1CkXH2ji19fvPUVi/D/+P8hiny/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjL5cfExpBkmjhTpHbTdS2BB3czuRcgXyxqYbF7l/TY=;
 b=VSMDI9CzCWwsYGePMW3xo6sB5ch2aAqO/xaKACfUkoGbJnm76lJ3IQsOMDhSzdrZZUV0i+VX0+8kVtWG1yOL+lfypYPa3RjPyX4z0cxKMq/LLKYSJ8H9qEdbRMVZ8zXl+TX67HKJzs5qDg2jx4HwdgMl4t3TZmkyh2QpjAsyeENW5fHBPCkqvBANkavY5RenD7rYjzqg7yZUF0z6u5jdQW9Y8bjKjM/Ht4CGmVkM2vLTi6dBM5GN1KPDjq9bs2SmTh3f4VwImNPVw83DOBUpqbovb1TlebWv3saRmndRBVAJP+rSVtP5T0thylM1h+JTVhiE49pWpM7eEHU7Lukw5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 14:23:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 14:23:00 +0000
Date:   Wed, 1 Feb 2023 10:22:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <Y9p1wqicUQOfQ3B5@nvidia.com>
References: <20230201001419.GA1776086@bhelgaas>
 <9c34747e-453f-8344-e7f2-cc24669160ec@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c34747e-453f-8344-e7f2-cc24669160ec@linux.intel.com>
X-ClientProxiedBy: MN2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be8cf98-bb57-4c08-4c8b-08db045fd278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUZJmRWs7ygym3x/My1kAV+/70mEn+VvhITjFJsYq9ZWjmyKKJUVtPyIPn1MXvv4evSkr+raUy126KXUFMwz8G27PnUsGuwgiNU7y78pfmiAol7MXL/PHda6oKpBckOg5/9dYEiloveDGo++4Qa5qIsKxmp0LWTDRzN0OWzlbuYowTQMqy98r/0htzy3pJApXStrUObTWuPfvvKk6FKMtGf3ZpHtkPhGKlMPnajXkM/jfgRuJPewKSOQxBk+w6/8+wOAIEHf0HleGsRtRIH7oPSZMQjhYNdS27iBwqWyVEjAqyy1wpeou1xMB9EPozfquOhRyvKlH1E1lX0zu6LafJ41JOSpLdeQ0PocKZc8sAsnh8+tsfM4mCxZ7Xk9lUCWeBlCMW3R3kO9cp0LOAxrgyhr+cnaVnKYNevo6OfQ27YmOKQMjkROgPEwDJlRMbMdOtFlAQbwOvWlb1KIbowUZCso25aWQgDu/1GA1prRCr36zueivvu7DVU6oHvnnXfz3l84A3z7fP0rCK27OopSrFAE3KvlNmkEdrH3eK9C9KSRAtwci6LzFsfF4kVSGx2GIBedEhk40MzZkleT0yMT2ldfIeZQX33ZMkkG0a6uQ2qz71yB3NPJqd5ui+E0Zq+tHkyy0k8F19C22nQZpaGllg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199018)(2906002)(316002)(186003)(6506007)(5660300002)(36756003)(4744005)(26005)(54906003)(7416002)(2616005)(6512007)(38100700002)(6486002)(66556008)(86362001)(478600001)(8936002)(66476007)(66946007)(4326008)(6916009)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lVssCdYBFdWuh0h+VI06Jjks5kVA0syKgceHtBVb8RXxP9LEr48TKMuDK/FL?=
 =?us-ascii?Q?YTsujLht76VZlhx+hV70dQOB8D2GhN2kKMEPSn85WtNHndpTi1JEkvXe/jEa?=
 =?us-ascii?Q?WiWRf53M9aycqEujQGhPq+oDUpDqJlgFDrALIN82bvPUgqfEoZpOtSi81Dbj?=
 =?us-ascii?Q?cr/CHE0vV51mhFd7+Y/KRcOvj2yHQoin41eB3uintJZ51mnDSq/frkEVEbHT?=
 =?us-ascii?Q?zXQNH9LgZcX92ZcZpjsdgJUCWQv/donVUSh+XD3NtUTFi2WvGE6rOuQg41ZI?=
 =?us-ascii?Q?SHfUY02yYUcLTdk7VYpWXk6iFqOwIOCWBG5YP58Ayihiemvw/4So+KdZ2VVB?=
 =?us-ascii?Q?I9Bm71V22DgJBq5dmCt8E3qSzuep7tQVysqCQQHmPMvHUyLXvIPVdqHNagXj?=
 =?us-ascii?Q?ynFCb1PBcK/Dm4sNvkt7qmZqHKXDXUHNAL+deIYAbBrHo6vSiyiCGXlL1V/7?=
 =?us-ascii?Q?sHBXYHndrWGXnm2ctf7pNJhlj+rSgMvindZjgz76iG0l1SE2Oqf+85nncu3w?=
 =?us-ascii?Q?iwnfANMPxEHqImonYZTRikWgrqWvxSCPdeVU973nDy75PNvJNP7rfHYP0OpZ?=
 =?us-ascii?Q?abDyEzwpsFJNoL3hL89dKe0olSPVfwVgUSD5hFuz54XDCjYPRleXtmlldpOp?=
 =?us-ascii?Q?F6BlCeC/Mf6jupAOYtJFynfbxpsFZfFEamQTOx63XZ0+0ZqDnOXxgWmExYAj?=
 =?us-ascii?Q?3MyrfPp+UVoHfU/sX1m3tVAySyFKXzkionpvT4LKgul63q43yhy6iwjoWTwl?=
 =?us-ascii?Q?KGgGoEDmgaO0d7629fa6A7BuKTVG90TwkALrG/IEsbAqfGUhXKlJZMfMJZWa?=
 =?us-ascii?Q?9n+vq0hQJeHD8273rVGX9JEhqHQ7ErlDxGCO6GsTlhnB7Y02TcNB7FQmLI5J?=
 =?us-ascii?Q?BbI5rE9397T/gyS42I4jwrXZ7CYfZlDS3dyKSPlfYPAzNRly8ILfftPnFOik?=
 =?us-ascii?Q?1Oy/gIMVZcxHnd+L0zVUaSOZItrF46n9Mik1PkbqVqbfF/qmmV5RZ41rkDi4?=
 =?us-ascii?Q?9xsS97l39CJpu+Hy9X9N7O+zgWqywSx1E2YJppNJDpioTGn3SU1P93G8MRUO?=
 =?us-ascii?Q?rdlyedYfu4r2okz2qKOKjgv0uwn1ajvvOqAhaHdC5sessFheHq2iqT5P7g91?=
 =?us-ascii?Q?2/Y2TW89VrgtsqybiZUH79ym93aqX+S1sOxi3XcEbEmG78zaPWz7j8pZwF77?=
 =?us-ascii?Q?i6h3WqLUpAVQeWrMGmI9irLkIXu4H/tyvYCTQP61+kEoC6f3IMb5250nMiDM?=
 =?us-ascii?Q?181iu1OhihncNtLGH53YEDrSyyib98TBRsQMOXPPm0ahjV9g+6KyPYcfvjuG?=
 =?us-ascii?Q?HYv09bWo66hmhsu8v8Ga6ZEpEz98z1AjEBAJkhXnoqiUQHsn/4o5pOPOa1gq?=
 =?us-ascii?Q?VjgCpDg2LR3CAzaW0ZzpnLqm/ECApXV0wFbGEVJxkrYwU8q/qNPaw9QnZiB2?=
 =?us-ascii?Q?asL3FgVNOWuXJ19GVUNif+P12YsHSI5kquai+UL8uiFYe6AViescVBYCtCPL?=
 =?us-ascii?Q?S/ussz2zDl1Iu+/hBfJ8BaQBFE7nUTR4tifnOhKd615iAhPD6JCKBnr4yxP1?=
 =?us-ascii?Q?AaFmKN2+40Y/OMhGeT7NYdrWpT4okC05eQwsnzY5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be8cf98-bb57-4c08-4c8b-08db045fd278
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 14:23:00.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyOo1Ay5IfkBElubWrCRNdpPVfcSgoYuxatnOgwFAd4sOBC7gYI4o7jsjlm1Es4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 01, 2023 at 02:31:04PM +0800, Baolu Lu wrote:
> > This change doesn't feel safe for all possible devices that have a
> > PASID Capability because we don't know whether they*always*  use
> > Translated addresses with PASID TLPs.
> 
> I tend to think you are right. :-)

This is why we discussed moving the pci_enable_pasid() into drivers
and out of the core iommu code as a followup

Jason
