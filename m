Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200D3665D9F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjAKOVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 09:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbjAKOUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 09:20:45 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136912A8A
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 06:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im6qKZnc3TQUjQQgTd/g1gmsPQGFZlyax+QlL+MwDHOgXu1gYX6H5FYP6FBsLBJDYeMJrbUGJ8Kbr+Kx1lW287XT060DbpRTmK8uoo7at2uJwmf9ZmkW00UVBYni6ozvXKigFoxdPs7IxvrB0KALkDfpBBy6ek+SAuj8u9O6Gci2P6p4usZSobIJJOw21lcjOw+Giixw6tY4nwA1e1xxWnkEuAVLlAk2hqTwPraZfvs0Boj+ajv599L7lkreucTP9fTrOUUAMaY4M0bEVAMbR86qU9T/8u0TQmwa0x7MpL1Irkc/60DNI5ZovHwxS/1zLxhq5LOPYK/AhQ8nqqA9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqekPXWl/sYk4KJbLZFipwcrBuaZCtVwFrVzG7RM5kI=;
 b=Ack6LunOIStGDNu9VpRG3p8Oq4oNiLmEoDy3JooHOc/d3MD6hgSBwHNUjIasro02IFmWL8uvi63jU9tkOqbYIoQS1gXEtIgAcwF3d6YWs5A8ymK6DDiQcmAulXHg933tpp3+bSlMSb4gZXFKX9V1r77PDwOAQSrQE1rCKu5hUa0yKMpNMEyaSC3Uz9mBxhJ13EBg6TAVbhEiR8ZeaHwmNvAo6hpvbkKgZi9UJraSLsdv0O4HJfZWVU02fV/JE9MP2q/+9YJA6bGT19B4jJyGlkmQ0C98O5vpZ3AP5M7TTauwbG1U+WaV++Oz9nu4jmZf78c9hpn8iZGAz2G/CgoyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqekPXWl/sYk4KJbLZFipwcrBuaZCtVwFrVzG7RM5kI=;
 b=BERsvsaI3TPWZdpHqR6S30K2B8+hLOx+Z9fUlcQc50xdxbpReWX0yblX+aTJuZCaolpF04jz9Lr6WZXy3HwlYxOwDmgTp0pTwaf/Yw3qQXvwIDsTOPLeyAWEqRMiVyKFpaE7M9U3cEFhVNNHEtCVUuZKjiZ/4JbQQ/dkK/nLHFXz/jqspZqtJBUHvuvOFwQLFj88LoG5MW4h4/PgaGd6pk4z3oSikNpQ3pnVQzQnuCwUzlaapFTqI+haCbsUGEBQZdGg8AsDDPOWR673x6gVD967PXzun6nep570gpAc4Gvm2TTSgqetsAl4uVrIabeL7hiIzmjkOFfqIoIZo9b2rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 14:20:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 14:20:42 +0000
Date:   Wed, 11 Jan 2023 10:20:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Message-ID: <Y77FuaSI8AV/i2cW@nvidia.com>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com>
 <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
 <Y769WqrbEUPQ3pt7@nvidia.com>
 <38a7baf4-9b3b-154b-f764-fa8cfa600858@linux.intel.com>
 <Y77ETB282pVL9/x6@nvidia.com>
 <8c33f83b-3b8c-4714-b812-1e0627fd5537@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c33f83b-3b8c-4714-b812-1e0627fd5537@amd.com>
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: f75430d2-a8f9-4a06-74c5-08daf3df0592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCBB3QovSUWbfEIs1RAh0JAFiYg0GiX8KHmyxjSSWYinz1T6pqN1hV+uaVEuKP2X1VrgCmyg9UIexyOu6h8LBNDxXb4BOl9Ny02IMd2TXHhHESZ2qva4y35TSyYxSnVJEZneeFknlsmT2yTtPm2OBkwKyMnXWs8NFq8m8nufZNbjvnpYmFGurciciQ9xQw0N3aKtbJS5z2OZEMxhasX02HFONjZWEky3RcIFcFfb4x4uGzjmQzqUVX9ucO4no0UgKVbR5VBwFGvBj1R7GTkXClRY3kok8AbwM3RH/pXXo3xpmWGE4unogD2ueDqrhLHzTmcEkoT7XjwkAbebBucfQjB6FqoRtZsm/qJws58C+FNrrExUfEOrMWTA4u8v8MPU5JNxZiF8PbZSfmmBa/ezVRGBAVp4chVymWEeMP80a1Yl+nJcupwFemF70vUB2inQem9BIUbkm97ylos3nc4/t6ia/FF8abGJevexkmvsKZG2pEheEqlxPsaDlISJHaykU+6J8RlaJJ9eF1GVA7mmv3TrNJrpw2L+23VLt8zyQazm1fAdF7mKi2XiTOE2KBDR48aUDkCyix5waUSNMnKS2gCMbl9IcXCXaHgMgV4W/7nsiNjNzblZWAK/k5LBCVTWXX+w2zZAh3V0ZjmXL5L4Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(6506007)(2906002)(36756003)(8676002)(4326008)(6916009)(53546011)(5660300002)(8936002)(38100700002)(6512007)(478600001)(41300700001)(66574015)(6486002)(26005)(66556008)(66476007)(66946007)(186003)(86362001)(2616005)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkdVMVIrNWhLSHhZazBTK2VSbDVvVFVNRVQ3QnBvT3JuOXJKWCsvRzhhUzJ3?=
 =?utf-8?B?SWpkNG4wcm1IY0pQb2lwakJaZWs4a3BWS2dxb1RXeDNKSzVlQ3hrVVFjYWxV?=
 =?utf-8?B?VHhiWFdoendZOHI0UC85M2VibHNZWmNLZW1veTFpTTVHNFU4UkkyaCt6VlNq?=
 =?utf-8?B?QnJLSGNOSStTM3Rnd2VrSHFCSC9PWDRvOEsrK1JEMFdQbW5UT1laaDBMYk40?=
 =?utf-8?B?SlptMlZpZ3R3VzBFWUlFZUs1ektZOFY1NTVXQUY0UExDWHp2d1BPNkgzWnND?=
 =?utf-8?B?cVd3K0FpVHdVQlNXWllFSjVKTmlUcWZaTSs2WVFYYjBnMG1sR3NrdmxHMnEx?=
 =?utf-8?B?OEpJUllkWTVnazcwWmJoYU5vcnMzdk5JOVFEYnJsbWU0NytrS3diRm5zdUF6?=
 =?utf-8?B?UnZUdHROK2pmOSt4YVNyZVhGb2xiR1hqa2dnN1EzM0RDZm0wZ3hya1YyRVlV?=
 =?utf-8?B?KzdLT2R0amFsVFZiMzFRd0hCR2NxU2hBamw0R3lpSVI1MXFQaXNacGdISmc3?=
 =?utf-8?B?MTZocXJBaHhuOEdld1d3Z0ZiNXVYL0NQUGhjTHloSGxnU0dGZWhUMTFBVlBl?=
 =?utf-8?B?QjZKOXlJWVZENjNFME9pV3pkclpzYW9hSW1FUGRJeCtHSjNxN1pCUW9jOXBI?=
 =?utf-8?B?T0daVml3MGt6Zk5KSEw4L0FtNElGeGJEbUhLZUYxWjdHZHp1dGFBMlNCVVR1?=
 =?utf-8?B?RFRXeWt1Y1d5WTZEMENhY1h0QTBBenRRNTNVejBRWWpEK2dVV3JmcWN2V1Zy?=
 =?utf-8?B?SHowNWtxVWtKSGpseTRvdmFvaklnditCYmU5NzJXcm1mWm8vbE1DZ2xIcTJZ?=
 =?utf-8?B?TDN0L01tU29tUkhKeGo3Vi91eFhRRTdma2FtLzJwL3Irb0VkVWF3TE5RclRE?=
 =?utf-8?B?S0NZTGQxVEZLS3hqNDB0YUVqOUdwczVScndNZEwrQi8rVVpzR2FHK0N6TEtF?=
 =?utf-8?B?OXJtK1BnK1ZFeXFycWdOeVI1dEZPR2w2R01BSFJxaVVzekRCQ0QvRzJUR3Ba?=
 =?utf-8?B?SVg5LzdBeFQ1bys2NUxNRXBMNTliblhESnRzNkJRdnlnaE9iU2UzMDZpd3Bw?=
 =?utf-8?B?dDVqK3R1bzVFMFp6cWdCSXpaajhNaHNYek1kejlsZW9CUjNVT0JlU3A4Unla?=
 =?utf-8?B?Umh4ZEZoWnI1MFBNcFZsWHJQUnA3Q3hFSjlRUk1JSHFHbDdESHNGaEdiZ1BU?=
 =?utf-8?B?cy80VkhzbkVlaXFDbWs1blhzeSt5RVdSdXkrQVFTVFRBaU5qdFU3dDZhMG1w?=
 =?utf-8?B?dGl2akhTYXJFYUdURWFycUFXNmtOMEo3bm5zbmJnWW9tWU9KTXdRVHJHQkxq?=
 =?utf-8?B?bWFtU0xHQ2hMMitjSzFjY2psNERnN1IyMy9XMTRPemYvVGprOTg2SVFiSlNP?=
 =?utf-8?B?UXp4MCtRL3lpK2N6aXNmZGFDeUd4anYxSWQrS2FMdEVYTkNPS2tGNUUyZUVt?=
 =?utf-8?B?eUVranB2THFqaWRYV1VkMDZ4MWIyZDc4c3l2cTgvUkZzK3JGT29Zc1lRR0E1?=
 =?utf-8?B?SkZwMUJ2cEt0d2dsejV4eGFnZER4MjJjaDZBRUg4aGtSb2FHdTBqR2xBQnFS?=
 =?utf-8?B?alhjUDF2YzB6dlZIOTErdXJ1WmI3NnQvYU9taUxHVVY3TVA0eDZiL3JTOEox?=
 =?utf-8?B?Wkk2ak10eEtUay9iYkRRTGRLd2dzRzRYSFNTZXNzOXp0TjFjU1dYT2NJRlgw?=
 =?utf-8?B?SHR6cC92WWlUZ0NJK1UrSHA0OGRYZWVEM1RMNFFWY0JtNmpaUDhhc0xMdWZJ?=
 =?utf-8?B?RmQyNlN0Q2Z4VVF5d0Q1MXVUUncxeXAveGh0aHpPOHpBQlpFcnJyeUhPZ3Ir?=
 =?utf-8?B?bjQvSVpjbGczeDJDSUQycTJhVzBOL3g0dXArMXdWYk1ZK0ozb3loMVV3WVo1?=
 =?utf-8?B?MFNiL1dEK2k2enZTMWZaSmFtOTRJQ0o4OWR1VExtYmwyaVR0M0xzSmU5QWdV?=
 =?utf-8?B?WFFHUXhGV0tBRTlLL1EvZlRCYU1yRCtJYUhsd09pYVphOXNYTEpRNXNUQ1o2?=
 =?utf-8?B?eXhaZWJVZ3lnU3F6VHpSVjJTeWU5cnljZGRzb0xld2ZoMGxWZVh5TjVFUGFv?=
 =?utf-8?B?cE41RHBJZUJGN1pRa0lKRFNTZ1ptemswenJWQjdtcWc1b2pOMzkvNTZJejNK?=
 =?utf-8?Q?CLOyTgp57LFWZjUS+VKBQQWaw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75430d2-a8f9-4a06-74c5-08daf3df0592
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 14:20:42.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vL/cOGRvygl54aSo6xyW8wH5V50bpuneVF63IBLMq01VZ2pXrFsVmRoquLSszxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 03:17:03PM +0100, Christian König wrote:
> Am 11.01.23 um 15:14 schrieb Jason Gunthorpe:
> > On Wed, Jan 11, 2023 at 09:54:03PM +0800, Baolu Lu wrote:
> > > On 2023/1/11 21:44, Jason Gunthorpe wrote:
> > > > > iommu_enable_pci_caps() in the Intel IOMMU driver. This also does some
> > > > > handling for ATS, so here we could check the info->ats_supported flag if ACS
> > > > > needs to be checked or not.
> > > > *groan*  this is seems wrong 🙁 Lu why are we doing this inside iommu
> > > > drivers instead of in the device drivers to declare they want to use
> > > > PASID?
> > > Currently it's common to enable pasid in the IOMMU drivers, but device
> > > driver has more knowledge of the device, hence it makes more sense to
> > > move pci_enable_pasid() to the device driver.
> > So, lets fix it that way.
> > 
> > Add the flag to the pci_enable_pasid(), set the flag in the AMD
> > IOMMU's special AMD GPU only path assuming the device will always use
> > ATS
> 
> That will fix at least this the AMD use case.
> 
> > Do not set the flag in the other iommu drivers
> 
> Don't we have other hardware which supports ATS as well and might run into
> the same problem?

As I said, I think we have only 1 user of the common PASID API and it
was happy with things as-is, so I think for v6.2 we are fine.

Honestly, not declaring ACS in a 'enterprise' multi-function device is
already kind of sketchy/rare - even if ATS saves things for the PASID
case.

Jason
