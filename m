Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D0664254
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 14:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjAJNvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 08:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbjAJNvP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 08:51:15 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037CAE6F;
        Tue, 10 Jan 2023 05:51:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laY6N4AGovCVOR2G5zN0BbJ80zut/bofyLmhLfVNdZC5Rsp54pkqLQ/G1lqISyJ+qk//ws5W6etaQTMRhY1uQN3oecAYM1ZLD00kt5uIETPQhg0FFcZofbkhA39CJ94puiNCciPH7NJLsmKkGuAM6Z4x5QTX01KvgRNsqIQe8oHoHhBMyO3vTRIDT9QoHc/G+TO3Y3kUrKXLFja9WLszcS8F1AgGYiwx1SWS/Yo+zLkQWs+yCdyerpYMJEN2+IzjD5INf5T90C0xqNzswR6xe/WB2Z1696hIfKG+lrGq1/A2B89PcWdiIeGHaWYBVCN1WqEHhBgynpT3EOxpRVoEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGPLuklMW5UNMUmKGKR+3eIl+g/OQWf11c5ki19M5fA=;
 b=hw1MzZ5CGxZH00gyP4oitUVn8jeTtAF+lKZv1NF/tuMl0m50x1Q72gJbDo4nrSGuBStJFOs5WfPBJiSLkYvk9Sb/54Aon4n6uC8TTz5BH4TdoUA22rxJVMQfSd4mrqGJiwShdGR7OZXWg3XOZoQ5Gj5qr1MTzJ66e0DPTEj9t3i0KGOx097EKyzK/gQ8bh58R6WTeROdYpaEVxfpoSdI9nodGMiph282cR7cDyMe3uE2AUa4bDOD7oVCJoMYEmXMksFCJah+7BqD3q9Xl+hqM/CIdIbFTn4f2z8ZQ2h7KBT7CKU3Ji4sbnvBj10G+CFDIjhbSFz/dgxcCGgxmzW0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGPLuklMW5UNMUmKGKR+3eIl+g/OQWf11c5ki19M5fA=;
 b=XYI1+ncj4sZW5w4+rwZIT7M0QGdaWn+7VP06qEHnXqH5Loc082Mtz+Rey6lhmnZWJMdKOOQFEogqyu0EQlcufpNdhdDyEiB7qeHRILtJlvtW6IGqtLJLSLdWDV0HB/3gq5aIdtcgp2K+3Lnaey21KFIl2QGgN6zzbhHFtXzAlxp7iboSrlizSIvPHuEE3WLVROenvTYnt36oA6FaZd5F4FHcHVJy/YB9WusiF7pehLw/3pQl/fM1/UR8bwkiXRbJNXB8mfD5C1D7vaYMG7VCE1+AkAJlPCeKQLurJ/+aiHpx6R8bzUGlcuXYa6kBhdbJSm+dGP0lzYsjQzNFF/CHsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 13:51:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 13:51:10 +0000
Date:   Tue, 10 Jan 2023 09:51:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [regression, bisected, =?utf-8?Q?pci?=
 =?utf-8?Q?=2Fiommu=5D_Bug=C2=A0216865_-_Black_screen_whe?= =?utf-8?Q?n?=
 amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <Y71tTdm/f+uxsTKj@nvidia.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com>
 <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: d1241da4-c16c-41b4-1d6e-08daf311bb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArYgSq11Y04FYul/HrrB7MBVz+wzwkyovmy1nwYIbQNkAeCc7OQ9u/SJTCZLphrqOBs/ZwUi6KcHiI2+Ot901eiNEWhvnQtY+5bJ/HFILbyh2oXJcc48cZbSAVpa1/ar37pluoILRRX7iDtUOehGGJapaVZOPwL5iq8VryKJBphDL6NkHMR3fVANgQc2HDlj4z1U0R5WuWE7nW5NW75zTMvwbk3zUwyhCWNp15X4oRi0QRWJ8AhIORod6ARURrjyT/OCMSBMjqI+0bQZLMfJOSNc3+3MfZwMxVjYVDy0HyIZX8y76owrpP0hpSy79+xq4/tjN+R8/uaTc7ZCQE74Nx5UwK7xMzK+Ys0r/v0b4xUC4lSTcUf65LJbMPhmFsWWWjDAokSLN2UVmtm7pd9I18Y6rP8Tt+A1SktWXjlpFO+3PqDZ09bktM4x5TAVL4GggZSgLHTwlGK8LUm6dfwOk9Ywa4mL3Ow92g6X0bRgOuEz7GsS5y5eY5R0ZZ16VxgKdy/BrqFIKLYigLJ5K1BC+ZXE0R2655MCqnntbFXGMTga8KMibeJXAOZ+MIoHBsAAm5oyC/bINg0y7KndAiKcOoMt3VShKjitnv1h42tWICFAfeG6/f7t+3ewG7g2L06K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(66574015)(41300700001)(54906003)(316002)(6916009)(2616005)(36756003)(66476007)(4326008)(66556008)(66946007)(86362001)(5660300002)(83380400001)(38100700002)(7416002)(8936002)(4744005)(2906002)(6506007)(6486002)(6512007)(186003)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFuY2xoVnZZV2MyZVJGUGJUcjl5UUxyeHhacktrRThrK0xXcStQUmI0YzBE?=
 =?utf-8?B?WXIxc2c5OW54cm14c2dJUWZqTVRtbW13bk9Zb2FxbERZUk56TnNpSTE1SFZD?=
 =?utf-8?B?MlcvZlRHcEYzK0ZxRlJEeVY2UFlSZUxMWjB4cVZxdkZPRnR5ekNBQkI3endQ?=
 =?utf-8?B?bG1qVkxyYzJ3aFcvbUhYRVlzY1d3MEVlZnFLdVIvQktkckRHM0xUdGN5UXoy?=
 =?utf-8?B?ZHYrTHE2dWJvRjM0aGxpUjluT1YvbUtQNDZIb09MU3BjdkltU2pSWkg3SFVw?=
 =?utf-8?B?cytVQzZTSHB4eUsvcmx6OGJZMit2dkxXVG5vU3doSWFvZ1BvZmZ5V1RzR1pF?=
 =?utf-8?B?WFZiSElRL2c3Z0dSU3AraUR4SUtoczdBS0syQ0pzTHNZTnVaM29qdU1jZmI5?=
 =?utf-8?B?YUJJVm53YTNVUG4yaEwrVnZEZU1yMkNSajRZKzZqVmR0Zy9CWURxQU1PTGpl?=
 =?utf-8?B?N0dxZjg5b0w1VGdreDFOSnE4ZXZkUG81VWdsdVBGY3FaLzhFWkZkVXJneU9D?=
 =?utf-8?B?THFvWTA1ek9nemE4S0tJZERXVGwzTllhYmZVaDZ3NlQ4WWxDWHFlZWZHRHBR?=
 =?utf-8?B?dy96WUhZMjV6YVFTZXlhbWNkejhHZ1lMQVhvRHVVdjdnMkE4SkUxUTRGemlY?=
 =?utf-8?B?SVgwMnVPVTZHdmYwZXBmWWdDM2tacDg2MEVtVVJFN0ZXUTNMNmZhRnBPVjJn?=
 =?utf-8?B?aUNKNVpCSjRmbEZKb3RjK2crcm5DYlVMNXA4Ylp3V283VzJuL3BMRHIvZU5w?=
 =?utf-8?B?dzZSUUF3aGVzaERONmdGY1lRblg5ZUFjTjNsQ042S0hINWQzWkJINGpPSmtU?=
 =?utf-8?B?cTJ3YThBYk50U0puMWkyUFVMWmxGUWtZSXZZa1ZVMTFhaFZTVmM0bkgwQ3dn?=
 =?utf-8?B?TU1qdEsvT0dkbkw4azk4RGViSDloNm9XM1FlRmZjU2xvRVRRYnN0a05LUW12?=
 =?utf-8?B?Y1lOUG14eVk1aEtuTjFpOVdtbnJaVmJLQVdVejByalRaR0xIU3RpcXNBUWZM?=
 =?utf-8?B?bUw2SFVxdUhpQldTNHpvdTZXNy9Ld0twZFdnSkpjS3BtT0d3UVViTFZNbDJs?=
 =?utf-8?B?cnVLRTA2ditwVUdLN1VOMVAyY25wYWJxSTV6eVROZW9iL3VqVFU2Q1VMN0Vv?=
 =?utf-8?B?NjhTd3hJM1Bna3ZIUmdPN0VzbVhWNXdDa2tWRm9BMGtEbDVkQUdjampVN3Fu?=
 =?utf-8?B?ejFqY2hJT1Z3QkpUejg4QTVnemgvMytoVytwQXhVRk9lbU1zYmFKcytZUS96?=
 =?utf-8?B?MmpXRE5naGdFMW95dnJtSmZDU1poT1Ara2U5dlF2eXdicHVWZngrTGhYT25M?=
 =?utf-8?B?cGpGK1NJWDRIdUR4MVNVRy8wcW1lSWF6NVQ0S2d3WUI4NXBPK0kvamxtbXBo?=
 =?utf-8?B?THNUWFJXZHlJY3U0WVZCVzRQM3psZ3d4NkFSck5XWmV2UW12Ym1oeTRUY1Br?=
 =?utf-8?B?WkltWlpFSWhpWGdhM05FbEZlWW1xTTJRREV4MkdNRzFKd0oyaXB1N25TQVpw?=
 =?utf-8?B?dnNFYjF6aXlJaG5STEZ5bzRJNzB3VG9xbVo5UHNLZ1FWVmU4TlJxZlhnejIr?=
 =?utf-8?B?S295Y2xBQVJzR2E0RjNJR0tsZTc5K0U3VUw3MzF4RU01U1JsNG53Rkt3U3oy?=
 =?utf-8?B?ZDdGSFhhZ2pGaEVaZnlTYnd0UUNIdnIwbGtQeG9SWmM4VEd3amQrY0ZzaXUr?=
 =?utf-8?B?WnZHOXQ2aTA3UXlmV3ZSdXkrNkI1TWJtZERVZTUzNmY5ZzF3N1c0NEhnRVNo?=
 =?utf-8?B?ajdidkxmMjhnWkJYMitjOWtQT0poakpieGd6YlZXdkpuU3VKdmtDR0lBOGgr?=
 =?utf-8?B?UHdyRHZsNGluSFcxOVBoTXVyZUJlcmtuZnlWSERrM3JhVGZjWkdoa0FkdXlW?=
 =?utf-8?B?cHl1YUVpQ2RHdTVsdmYvWEtKN2lnMTFhNHhVSmprNERNSWQrNDZ2cHBLeVB2?=
 =?utf-8?B?dTROd29WK0hBQUdlVC9nRkVkL04xZEVLT29DRWZGeUhPM2ZobEhGS2J4K05L?=
 =?utf-8?B?VmN5RDF4YS9zVnVFRDBIZjhmZCtPTVc0ZlVuN3VPR1QzUTJjVDFLT2lpdi9j?=
 =?utf-8?B?TDVGbW5GN2tvZCt3a2ljL1RxVWk2ZkNDdmNCVUhUV0tBR1oxMUlqM3FkNmhv?=
 =?utf-8?Q?CdvrFN2Bg5JyS+1v72pi51c2d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1241da4-c16c-41b4-1d6e-08daf311bb11
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 13:51:10.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIYrQD2dAjvCo/YaShxKU+Rv7lxMAnKmqd/Z3eOjGs54Mk39/R4NVGfY4B7ELvbB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 02:45:30PM +0100, Christian König wrote:

> Since this is a device integrated in the CPU it could be that the ACS/ATS
> functionalities are controlled by the BIOS and can be enabled/disabled
> there. But this should always enable/disable both.

This sounds like a GPU driver bug then, it should tolerate PASID being
unavailable because of BIOS issues/whatever and not black screen on
boot?

Jason
