Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED7A665CDA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 14:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjAKNpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 08:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjAKNpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 08:45:03 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A532E4
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 05:45:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2to2hz5z63WJHwpWl9VCVX8mX+saJazKlFqpuh9lJnqiABzCwhXuKfCYGY1OI2ePInj7NvDpZX6OPf7zA+jT8pwzSuVgZUc9FFMd1CzZMwo3lYHItX/biUK5ooQ+jA5nRxqh1qsJ8Tsfvj+EFDsrVp/KpDUcQ2FKkBjYawXmtxroxKwkV5pWg+7uM7rJ9I4gsmufUN7bds8wfpMe7dh2jMh2e/7LNwJKS6FmR+l8k8bcZwbzVW8jS4l7EUcq1R3GQb4keyZeZcItYI9wrCS32vYEE9UUmCVU0/V1HjMbSbqlAXMT39ApKx/52hktYRYaD3ELnM3+BffAWGzSWqfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXk85VNxlxgl8ArtGphgHpIM4yinCkQyCOSuJDhIHXQ=;
 b=OIIb7Y2RCi0A1erkaHVpwEFipx9wE77b6zDKfNN2WyOC4tXMyO7uyxstPm6M/dPoQBHe2rMr6qvKuaRWMA5FyPhruJsEh8R72/0EcNYikPsiu1yQG3O9TIQHTEeBRt3ZxXBmnemjM8cqgBWq75zk729ZxQhWOXiZFG49/XAIkXQNCOJIkEG8XzpzHMahX2ir5ucmUOdVqoMGxGE7Y2fhvNlYl2g4wygfDpwxO7qIe5FgR9JNpg6kCOfrca1JrHmvmNlmBS/zUbpqmyVMbDlQ4mQCR9/Pval5Zve0SY9EfJ3XSn3uGw1gCE2SFsNXWAYbcOgHf4Hfyqkm6s3yQ4A9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXk85VNxlxgl8ArtGphgHpIM4yinCkQyCOSuJDhIHXQ=;
 b=XjNOq4Ua5doqTQ6o2ySssA/qD29W6LJHvS8/z+7EEnh/n4mwyBGZV7jN6OTPkB/uR2VZuIDkgQw4pPd5yDIv6DneM/zsgUEe/yympzBOY3fDzxVErP5H1JYMu2G5nwNC+B/nDgzdKg4K1e1coBE92OK3FtRIACuAayBafwyM36nllIq/sHzdIS39rliEtBViubvygvYMwykAOmf0lBbbXrJA9JMuTxDEZlxWsu3ts4ALC20sXd67fR57SE6pCwRhXGptwz0GuasJdKpYLHtWCkbow9+BeG0tH545P22eY2XXcsnZBv7k6IhFskMojT5Hy0N3yE/BA6YD2ch4hNGveA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 13:44:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 13:44:59 +0000
Date:   Wed, 11 Jan 2023 09:44:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Message-ID: <Y769WqrbEUPQ3pt7@nvidia.com>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com>
 <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
X-ClientProxiedBy: BL1P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e988ff5-7cb7-4b7e-f191-08daf3da0818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMJ6VNCeefjHKnCfc9G8rf2ZxmQdBXqzeJr5KxfTa1KUofx+i/nQU44ufWmn0SeHmBdl7c9TT8UHRo8xUY3W+eInEWT2CHBoL/GqJRXwQILrI5JatSq2uGJF5BYr18xrxhXxtVcwDpyqDguSJjbvocbUys6G9y9l1fxxQIksnFy/VwqjL3RHZdMl8mjUbJ+iuG70VMcT6ktQtyXLvtk8+SDozI6xvjvJAPbJNdhzZI9S07wGiWG59WnXi+RTTB6QyHZQSy5PActUFjzQ0sKYDdF8Vhe5qm+VR96BmqPLD15d6smg6SMrlxa1ef1QVEAM+IO0V9ynsxZAi2R5wacYaizkWjTaURkG1pyQNQ2h3uoZFfhZSQNOfjyGkBjfWMNT0byhgnijRvAye4llJHOhiULz5xkJQMSSHoieDKk7cjK8V6OM90I2BS9cET/17Kvb8JCVwh2MBkDMY+ocMtDpYToN1iYQUAKsuyYKRpCDOhe4kM7SdgikT+6E88MOU+33FUz3r67Ad+HslmT1Fj9BGwJ7hDyPBRDNVGB2815xGoqbsrc8Rz2+TTXVY5Jobf3sypHwsCaTOR+XR98SSVpBG/vfIPbBhtStjCGa9PlAVah+IUR1JNmgWy1t9cdDyjaaUM7W2JHHTAfqWFjyaNRYww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(6916009)(38100700002)(86362001)(83380400001)(8676002)(66946007)(54906003)(4326008)(66556008)(41300700001)(66476007)(8936002)(2906002)(316002)(5660300002)(6512007)(2616005)(478600001)(186003)(26005)(66574015)(6506007)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9nSWNrUHovanMrSHJPS1ZaRWpFOVpWcFlhUmN1eklqMXE5YlJodlZZVzBj?=
 =?utf-8?B?aHpqUUIzYWdOL0YzUEFaSDIzODVNVDZTYzljbHJXdU9CSG9ndVJkditEMUdy?=
 =?utf-8?B?REdmRlpPNVRxMC9WclVtNmE5eDhnYVBzZUFRcXJycnkwaXk2ZzE3d0xHeGlO?=
 =?utf-8?B?alR6ZVRibWtMRlV4M2k2M0pHd20yMHJnQkNMaWZJOE5kUS8xQmZSeVpTQkhO?=
 =?utf-8?B?VDA1Rld2azdFbnpBVktXdlZnNE9yK0Fsa2JxeFh6WTM3ZHQ4eEJ5RWJGM25Q?=
 =?utf-8?B?VFR6d2hySWcyRUVSa3hnRkdLMVZGWnRoZDdzN284S1oyRDU4VEhFM1J4amRs?=
 =?utf-8?B?LzdsamxlUzVYNW4vNnpLdGt5SFVuSUFQY2gwdGdKMm1tL3VDK3dGYmRpejNn?=
 =?utf-8?B?bWlBd1JzT2RGZlBGRW5JVWNKWjErZUNuN3VlRGppNnpmeXVIUkxTNjk4Q2di?=
 =?utf-8?B?R0Z5aEQ3MzZ6cFF2cFNxaG1rU1VHaUJ5bzVtS2MwcStYdHZJZElUK0txVTB4?=
 =?utf-8?B?NjJTR2RpVnhkdEJGOXhQcUJSa3FsWXRkWFlMZW83eVd5Nmh5Yy82bVdzMVZw?=
 =?utf-8?B?VS9KRTZ6LzE2eHM4dE5oVUYvcjJCNGhoVVdoK2Fsd3p5aXR2MHRZbWkwVFZW?=
 =?utf-8?B?Z3drRm9iN2lZR05JR2lObkNaL1hYSFFJd1RnTFMrMUZhQ09OWnExbzNUWUU2?=
 =?utf-8?B?SVVIcEdyZ0JBV1V5eTMyMVZ6c2U0VEkyMXVTdHhsSjVuQXYvdVgxY2plR0J6?=
 =?utf-8?B?Tmw2NlI2YitZYWlWS2dNVC9vTCtpSHVIcTZnejFLcHhEMnpEZkhaTTdyODN2?=
 =?utf-8?B?Z0xOZk90SE5LZ3BaK3ZGMXJCNEVONzliMGsxb1B3QmVnZFhUd3ZwZXlPR2hP?=
 =?utf-8?B?ZVJiYnl4ZE5ERGNqRGh2UXFGeUNZbERPT3dKQnlRSTEwRE1WSm93Z1huUkw2?=
 =?utf-8?B?OXR2VklRZkVrOW1oVkdUZyt3UFZLa3I5SlY5U1FGNmtyQnBDcHNDZlp3UjRu?=
 =?utf-8?B?eDR6RDNrQnIwTWx3S3B5SUpnNzA5L1ZsVEhvdk9NUGtJWWtNYUJkRjA5dUxE?=
 =?utf-8?B?cmtRVmJxaDZXc3dhemZNUWlJMmlQT1BrWnZib0xTUEZlRFY5a2VCMytCTHJy?=
 =?utf-8?B?Tk0xckkvR2pWZHpRMldVeThxOWRqZEVJZ0hxWTAwQzAvMG5PWWw0ZmlVWnZa?=
 =?utf-8?B?MUIwNS96a08vUTUxZDlHNDhSeXBuaCt2aWVWZGMvRDQxVWJubjI3dWhGRklE?=
 =?utf-8?B?RDRac3NxTm9YNmIrWFJXODNBTVJ2N2I0cFlQV0taMHJYWGNtdDJ4ODhxWnR2?=
 =?utf-8?B?a3AvYlBXVXp3eUE4bE9ybDZSdTBIVTNVbmV5QUIvT3RyaHVKWkN4YmFxNTZF?=
 =?utf-8?B?eWNUWWdRRExZZ1JDcVhLZFJWQkU5cENRdXFZTE8wTDQ1aVova2s0dERzZ0hY?=
 =?utf-8?B?dVRtOThVV3ErUEtaMDgrRDdJdy9HWTh6YStFRmdiL01xQi9RbXRFdGIrRklZ?=
 =?utf-8?B?THdZVk9mN3ROQmx5LzVBUFRWVkVwbWNuVzBHMmxxUlppVVEyZHBodzkxcm9B?=
 =?utf-8?B?YnN4UjFhUVhseDY1M1grWEs3L01qdFh1ZnhWUTNZTmd5YkVHSktWT0VFM2Nm?=
 =?utf-8?B?OWxWWStYN3hVK2VKRUd4Wm1aTzJkem5NM01IT3I5dkl3N25wd3NZRThoZXNL?=
 =?utf-8?B?LzF4UjhhYTg3TktCWityQWZsNVEyYjhjRmI5am0yRE94NGNzbU04bWJDeldC?=
 =?utf-8?B?dTJ6VXZjeTlHeFRwZExLSFE5dHBBRWlwbFM0ck14Wk5WV2FnV2dlVElPQjVt?=
 =?utf-8?B?TWNDVXpqanZnS01WY2p5N0F5Y2hmTy9UcVpDeGxVZ0I0b0dTejE3dHVmQ2Nt?=
 =?utf-8?B?STN5U3FFMHJ6cUMwUG9ydjV4ZVZtMy9CZms0TzEzRnd6ZGZmUFlKM3k4UU9y?=
 =?utf-8?B?Mk5IZTJBNDNhMXJQZVJlMzdqRU13d3o1cFNmYTFWK3gvekdVUzIyQktpaFZE?=
 =?utf-8?B?dWlhcXFiRitMNDF6Q2hFcnRkNithOENsSUVVVVpIWWpjRjVWRmg1Uml2MVhS?=
 =?utf-8?B?aVQvWnMyZSsyUHVoanNwQzlnSi8vblRDWDd1RjlITjRacTVLcVdaMG9hbDNG?=
 =?utf-8?Q?3HjYX6ytZzNZlwHu17tKDhk2R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e988ff5-7cb7-4b7e-f191-08daf3da0818
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 13:44:59.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7SH+Ls+XMqBcfkHEdfGTFMKexWrX4/hy0eRyIGR0dQddtkAhAEa3g54SQ6WME4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 02:38:34PM +0100, Christian König wrote:
> Am 11.01.23 um 14:07 schrieb Jason Gunthorpe:
> > On Wed, Jan 11, 2023 at 09:57:45AM +0100, Christian König wrote:
> > > This reverts commit 201007ef707a8bb5592cd07dd46fc9222c48e0b9.
> > > 
> > > It's correct that the PCIe fabric routes Memory Requests based on the
> > > TLP address, but enabling the PASID mapping doesn't necessary mean that
> > > Memory Requests will have a PASID associated with them.
> > It is true, the routine assumes the device will use untranslated
> > requests with the PASID.
> > 
> > > The alternative is ATS which lets the device resolve the PASID+addr pair
> > > before a memory request is made into a routeable TLB address through the
> > > TA. Those resolved addresses are then cached on the device instead of
> > > in the IOMMU TLB.
> > We should pass in a flag "device always sets the translated bit for
> > PASID" and skip the ACS check in that case.
> > 
> > The ACS check is not wrong, and it is definately necessary for devices
> > that do not guarentee ATS and PASID are used together, we should not
> > be removing it.
> > 
> > Given adding the flag is trivial we should just fix it, not revert this.
> 
> Well exactly that's the point, adding this flag is absolutely not trivial as
> far as I can see. We need to go through multiple layers of abstraction since
> this is the low level function and nothing high level.
> 
> Additional to that the check doesn't seem to make much sense to me.

AFAICT it is the only solution that makes any sense..

> pci_enable_pasid() is called by three functions:
> 
> pdev_pri_ats_enable() in the AMD IOMMU driver while enabling ATS. As far as
> I can see we absolutely don't need the ACS check here because ATS is a must
> have.

Enabling ATS does not mean every PASID TLP will use ATS. It just means
that some transactions might.

We cannot do this properly without driver sourced device-specific
knowledge.

> iommu_enable_pci_caps() in the Intel IOMMU driver. This also does some
> handling for ATS, so here we could check the info->ats_supported flag if ACS
> needs to be checked or not.

*groan* this is seems wrong :( Lu why are we doing this inside iommu
drivers instead of in the device drivers to declare they want to use
PASID?

> arm_smmu_enable_pasid() in the ARM IOMMU driver code. No idea what this one
> does with ATS. Here is the only place where the ACS check might make sense.
> 
> So even if we have some need for this check this seems to be the wrong place
> for the check since not all necessary information from the higher level is
> available.

IIRC we only have 1 driver using the standard pasid support, so we
could just move these things to IDXD.

The AMD sidechannel thing is only use for AMDGPU so it can just assume
things until it gets fixed to use the standard API.

Jason
