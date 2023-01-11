Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF15665C1F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 14:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjAKNHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 08:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjAKNHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 08:07:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D374B15
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 05:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvmC9KFxz1uLLCcjJE9Ckkr7ZgktSFVGtsCCqOB+yNui61lKQ9Lcpjq+5MEgKSBHUqwDU3GoP1Pfbdy3EZAusS5fmI+uUJpkO4e8AhiBp51Hin009pTlA1GiM5jIjwUftkuv0XsbXGrAu0a6qMZoUoyMw2vGMcfOMJzhuesUWNGqrZJglVTp5F2MS4wSDVbK1m7oJjPBkp6FyINB2wlYZfeSMsZ08LSN0Z62DvfnUguyG6j/ZFVODTuP+Wj63oRpQJZPRq1ski9gOh2a5xqZsDrQsjfv3P+VNcqXHHbO8cQT2ChFVVSj+ZeKgGDCl0hBPf2ZQRnQ0aOvRZMOhylwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYaBtlceYid6mchekFBLHV1A9yAfZud0+R8heciCzK0=;
 b=gYW+4rB8vCXHEkmzzylxmMD7+IYh8YybZXOpjlIf2m8F+Ht/BObQOE9DtISGWCoF9OICx95+Ckoe80q6/s+iTsfCW6eIewKlDCyuubEwz0qC7k2IUKtJ7h6gs/9k2Pc9qrj3oAMScSJXf0+Zv5NoDlgmpzunAaZZY268DTu0iGhGCxg256I6C/3j874xOmWVSBmvQsqStUjlIKtT0LAzVF0qbLc+FBlUd7f0A4TWDFhK7YYxFc7TljMeZJM9c+KEiA6L51jfgN0WRnDuwjGTM5WSPE9M5lbgIlg5/xdHnDc4wqocSF249088xgjifDnmpEbPmKLwDmoXF32DytzQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYaBtlceYid6mchekFBLHV1A9yAfZud0+R8heciCzK0=;
 b=dgv9+uJrk0fIcwaU2rBcaIMl71MuedLs7gzM21hsw5Utqkd6eB0Oc89yCt9GpjHzQrAwf10VwG/VawL9n8aO49srHIa4L6JYPih42TTyB7YOmgkl1dK9fv0kwNZOZmf25cdOh+6pVQwha0QTC95afYEpyZSXRVDYv2hsurw9kZGv+rPqjHwNJ9oOesr88W/FuCJWpoNsRn8QIgFHOVoyALbPb0e+WvmNVtzSvgj032dbf+E1S7p9mdBFviQW7/Bt5JTSeZ7IIk9oMVfdjA/TR7PHk7aYgqp+En0clHkSdg2rWtv13md41Hm7x73bAHWQP6iEY3QiY5nOGV8JNmkXJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 13:07:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 13:07:19 +0000
Date:   Wed, 11 Jan 2023 09:07:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Message-ID: <Y760hRDQbXRlc2Yz@nvidia.com>
References: <20230111085745.401710-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111085745.401710-1-christian.koenig@amd.com>
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 427f3541-56f1-4175-30d4-08daf3d4c4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6UnFnqpGLFIeneg/dI5WrECkvZwceXRTTm21RI3YbCSTOYEtv+pZtlxnrLfe6J1ukerAqSl4RJUKLcB/icWtE3EbEgy+YgiVVkoe42rbDCZNMwLFUaa1bzZSqyTFHqJtWOGdmxZxT9Ay2XqVwaUWhwgWLn1LlA92m22VBIdTiIG4lg+eg5ajWzZZ+rTawvJXlguUyer8L5kO04lbLYlUzB7upKCarfCNsETopvOPCbi6krIiDHtEt9EyIOIuy1ONQQrXw/KjcjNMQpoyV9mrW8sD4+GBtpmyjBmbYixb/O8w38QQSYYZHPdaTNzqX8Yd1LEr+VYBb6l4zzwvxBgvEWJIdQbSNH5xb8McsSMID1r4QqPfMrnVSUKq+TZk7JlgNbCycqCGS03B1KradINNKU/hrIppM6GRRGOkIyOItPfDs8lWhjY64RIYy9+kOHByOI6w6JM5UBC/WTPZIIujla//TGHx30obopiLVo81aHS6X4XlcMeNq695/SKR1pGWuBg5xL2/oXbWofzwURDu+Cj2QM0KAcqV7zaiXU81km80dJA9JkhyP+XoMjvyXUPFGek8pkthRRdH6A4J0h7agLRxf57Q15/Zv9JAsk9sms3fMn9T0E1kkUIgy7unFKkiHehr6AIuFE8XhYYmSjWMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(6916009)(38100700002)(86362001)(83380400001)(8676002)(66946007)(54906003)(4326008)(66556008)(41300700001)(66476007)(8936002)(2906002)(316002)(5660300002)(6512007)(2616005)(478600001)(186003)(26005)(66574015)(6506007)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjEvN0xHVGpISUhLWTB6UFJtS1hydW5ZSFNSQjEzZFVldkxKbkZKMTFUcWI4?=
 =?utf-8?B?M2JXdnFRcXVSQXBzUVFaZWZVYmpJdFh0Y3NGdTd1d2VoTGZqOFUyTVNkMm15?=
 =?utf-8?B?MDRSQjhFM21Jbk5uTG5Wa25ZM29KblQwNFRvU2dkTmE1blpTZ0JOYWtWQUR6?=
 =?utf-8?B?cEJmcFdBODRKc2RtYXMxYWRkV2NoYXNHWXA0Sy9ieG13RldYN2taZFJkeEU3?=
 =?utf-8?B?SEYvWkhZOTd5M1U4RCtkYjdlYkUrZnNNaDBua2VoakdPbSt3Uzg5UUFKdGZP?=
 =?utf-8?B?c25kZEhZTXhpdWVoNHI3VDZST0N4cXFMM3Y3UE0rYkNUUGowQ2sxVG5odWJa?=
 =?utf-8?B?VURwb2VlMGNrN3RqTDUvSDZGKzJ1QjNKc2dVYUFhb2FqY1M4dERPOFpFd0RH?=
 =?utf-8?B?cVFDbnN5RFB3UWZmWkxMdVMyRjJDVjI5a3BVMWU5UHJaL1k3QTFYK0s0WmdO?=
 =?utf-8?B?TWFRcExuUU1ZMTlYU1hGTWl2YjFzanBQMlEzN3pyOEQwYnJPR0QzOXFRazZY?=
 =?utf-8?B?VTNFUmpYcmVhblVFd3FSeGVrbVJ2UllZQSswR2FWVEtrNlBhWUZMWHlRMEMy?=
 =?utf-8?B?SW9XNm1zL3FJdzNZMTljU2lNVDhxcTdCV3NvcG1paFhKU0ZYVlJmQTVBZUNz?=
 =?utf-8?B?VXNCZTk3MTRFYmxFVmVNZkErcHc3TCsvNEVkU3VMUVRiVHVXMkRidUJKVTdL?=
 =?utf-8?B?eTRUdlpEMllFcmlpZG9abnR1SDFndHZvcGlVM3BSZC9QYU1GaEVodExFalgy?=
 =?utf-8?B?VlRBbVkyNzZBbTNFZ0xoUG10N05SZXVBZ3JQUVFXa09pb0RYUGVZL0hjT2NJ?=
 =?utf-8?B?Nm9iZHVUb0VQam1tZmc5d1RpSkQ0SlJmemU4QzZlVUFFWVhudVdxQndDMUFr?=
 =?utf-8?B?aHp1NnZTWTNNTm9Tc244T1ZwRk9adWpOSXY2c3JlL04rT24zVFR1MGJpdDQz?=
 =?utf-8?B?RkJqMy9JMFZsMGVqRUJGQ3BuZWYwTi9XSkhwcjhiQkI1clhXUWNJUDEyYlli?=
 =?utf-8?B?TS9XbEZCWGF0cDduM0V3MlF1NWQ4TmdUVW5hZFY3NGtXeHhBNWw1aVhiQUow?=
 =?utf-8?B?Q1V6VWIrOHBCcnprWnFpUS9NV3BKc3J3Y1JMcFlrRXY1WUxWaHpjaHgvWW9F?=
 =?utf-8?B?bGtIbGFmNlc4dG1XRkUxdTViZ0VmYlpzYzhSWkdtclV0SDNqSTEvUWNCQXJz?=
 =?utf-8?B?eER5SGZqQlRNeE01VUdjWWhFZDc5WCtTYkROTDM5WUZPUlN2TUxUM2ZoS09h?=
 =?utf-8?B?QUQvT2hZYlRtSkJFUnFmbjdaeTZQbDVvTldHUEpicWlLRDFJb0QvL0dJb1Jm?=
 =?utf-8?B?UitnZGNqelZQT0dpcTZwUlB5R1ZyKzUramMrcVI1TmhEKzVITlkvVVNJYmJj?=
 =?utf-8?B?YVBVdUVQRGI0NFIrY0F6MWFkVkY3T0FsejlJbDhUK1dES2F0YzNzSGdoM2Fi?=
 =?utf-8?B?VUpqNG1sMmpxTjAyeGMwU3RzK1ZCMWkweUgySnVpb3owMU85dFYxRHBIMEly?=
 =?utf-8?B?MGlkNXZqbmFmWWJvTkNvbUUyMWlPazNqUzA1WUxUbDhtZkJpc0VVMzRiQVhL?=
 =?utf-8?B?cUdCYUx3NXpRenhFRHIyUWlWRTlLcFdTanRJUldjS0lwMFJISDBKKzNJd2lJ?=
 =?utf-8?B?U3RFQlNTejRhV1Q1ZGRScnQzYTM3L1ZxekZmV2c0UHNjQVJUbS9aVG41OTlo?=
 =?utf-8?B?RElFVEZlc1ZNdjBlbitHbVdFbW05UmNVNlY5dEsvaXdTdllSRTFaMFRjdVJT?=
 =?utf-8?B?SmZWNlJWbVVoNVg3VTBEUTRjRzNNK05zREN2VXF6UGN0WGdpYnJmcFJpMVND?=
 =?utf-8?B?cFhpcUJ3cXZ2elB3aXM3VEZobEhTYXM3em5JZTkwdU1jRHNoUkxoSlZxRjIw?=
 =?utf-8?B?VHdsK1ZGdDBlbmh6Rzh4OTc1TkZadE9ub2xuTkxzM3YrZVdEL2RqcG0zUDV0?=
 =?utf-8?B?eG1pYnhWdlBETUxLdEt1U0hMNi9jM2wrK05vdmNNVVFaL0hud24vbFZFZ0xo?=
 =?utf-8?B?RDRzYytJRUFkQUsxempXYWNQcUcwMHphVXhHOHJWMzZMV0FXb0lhTG9JclFH?=
 =?utf-8?B?NVBlaXFZNk83T2s0UUxCUWRudEo1VnlZR3dEaVVFZEhIR0J6clBwbHQ2a3lW?=
 =?utf-8?Q?YADfFrmcf059AL2J3BLpmbuZD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427f3541-56f1-4175-30d4-08daf3d4c4db
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 13:07:18.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA9czB/ynAojihWQHYWlRBj9Qw0fpGxRky1qBcoZZALjAIw+hArtNZ+crMZbrvLG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 09:57:45AM +0100, Christian König wrote:
> This reverts commit 201007ef707a8bb5592cd07dd46fc9222c48e0b9.
> 
> It's correct that the PCIe fabric routes Memory Requests based on the
> TLP address, but enabling the PASID mapping doesn't necessary mean that
> Memory Requests will have a PASID associated with them.

It is true, the routine assumes the device will use untranslated
requests with the PASID.

> The alternative is ATS which lets the device resolve the PASID+addr pair
> before a memory request is made into a routeable TLB address through the
> TA. Those resolved addresses are then cached on the device instead of
> in the IOMMU TLB.

We should pass in a flag "device always sets the translated bit for
PASID" and skip the ACS check in that case.

The ACS check is not wrong, and it is definately necessary for devices
that do not guarentee ATS and PASID are used together, we should not
be removing it.

Given adding the flag is trivial we should just fix it, not revert this.

Jason
