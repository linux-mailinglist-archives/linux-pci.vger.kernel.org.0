Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2123D69A503
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 06:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBQFXa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 00:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBQFX3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 00:23:29 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3EA5B74E;
        Thu, 16 Feb 2023 21:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwM8YU/fbUdICFeuxFo0ceRff3PLZlQcbYM42xFc2VmlKNuIfU+ZoP68ugMOAjN6LV84bgHJ7VlBPo1HUwyqBqV0VmBNAskuiPAcu+NhsmGzROZLpfsnNOcbTXRvejKmk35rvtR7yr2KLiV709vTrbtWg8FKE5ZRHj6qpy4hWeWk0lTJuPPlM1phNlBzM41m+JzW9KVy7nyLfKi4I7kVKRAy+ZjN14O6BIU6iMcaNkwePMelhWeQtVQi9a+2tgbkk4Di6Je+nE8dakGdRXe9/UV9r7l1yITFLIiDORRmHxsFcUZPqCiz7bL4h6eNvvhB90eoMbS7PxmmR9Kjg0I2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN8JBaaduoj8m68RXTBkZ3CIAM3qsn+JAuaX87trYXg=;
 b=lrC4ToLjlS5ImCdvJ+p9bYo8TecuIy13pAImSZwzzijq7VJCZc2VyXta5/h6IfzkIskh4GPGSdZJrvEIZqINeAGVgY+BTHwJLaptcjYqrQcvoS/5qlR45sroCcBCzQTMpJBhU+8BoO6+WMUcYy9266qvfhxPTFrjMwJ/3cGlCl2PAvDDqXkQ+rRYwkRvE+X/0I+kFugr3WOhL12MoNlIpUwbhYcQI0bxRSTZxYB/WkqGu85ok14+2/Y5FXZxwcGP59VGzU344srTkYk/SOuYAW/WrVpgByY2h8ODoHPBrP6XrNggctw2uCFXrXW1xc34N3A31rev4PF8yYojtUoEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN8JBaaduoj8m68RXTBkZ3CIAM3qsn+JAuaX87trYXg=;
 b=oXRiQ7zhDinkr5p5fzoXQxlzXVc2MHccn1TbE/BmPwXk73MGIMAmx/KvOU6YjS61YZTF54YAVD1oBXHl9xWbvqHNNtMtEXGKra328SiOEn4qfPQhgf2cx6vRWxy6jT4ct6dnGdiMDEMl//u9L//V7ZmpDMrB4D9oHjYU2RZop+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.28; Fri, 17 Feb
 2023 05:23:26 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 05:23:26 +0000
Message-ID: <e17d1ee9-7383-6717-6f10-9465b273b1ed@amd.com>
Date:   Fri, 17 Feb 2023 10:53:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Matt Fagnani <matt.fagnani@bell.net>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230215153913.GA3189407@bhelgaas>
 <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com>
 <51861ff2-380f-640d-d5e8-7efe979a97ea@amd.com>
 <40b2da4a-a205-3cf2-0c78-c94c28b2d3f4@bell.net>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <40b2da4a-a205-3cf2-0c78-c94c28b2d3f4@bell.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd483f2-d449-40cc-2e75-08db10a718af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l96YA6XQbx99xhz5fdstr9oIxzJYWsSWCZHeeqQve11kADNEUrFnicSYpdyJwR+OiRN/WoPH6+6N73FF98jzhtkG4al4ttM+MS2peloUt8kVaLCWhnkDUNqLszS3Fw4hUWEHmIre8kCqVjKKpyeAGdMZg554OvH+9+LqqziDalh58OlnD+jtJtAe7Kfj5Q/0T4wYrvE2hkFN/FpGWkCLBnTb0b076ZFviBOHm+WHjY/BRxOesCQilCXXWKtNQjHRcp7mx8kq3rWHkQDTt3pyyh+Slm/W8h79DaThWykhQXPfGlLh5hb7Nu1uTWlKlmsmt5JIUYialDQ3avuGiyZA2EGrukrK4pozsXjquJxnta2lZW8ywmtzyzKKywGSI9yvExUjUnc8zaqbZSVV0Qy5qd6EMOSCewKSjhRuxuL+im3X8Hc1IaOlsVD349xO7cD45LxsVh2YLlObz4TQKp9DlwnDvBM64hdMkfad1NfTDJ+04U7RNhPUihT+E0c9pkdn56rbR0DQYNpDvAJbI9b3/TORK9jlwEDXQAGIEMws09FBLKRSHta0bW953NW9v0XR8Db74mmE3E8gSdfgbffBdYur27nu4YgGDXFL8MVV7S/vwQcxB+XsjDLUd0spRsW3i17S3uUU/8bH3p5+9Xek9P6caitFY5/r+/WXE4c001N2D4rnJD3l40GszrX8APMIZNVOe5+i06YlOmljl1TpXgUGIru1MjjV+2uRKxe6wrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199018)(6486002)(31696002)(478600001)(2906002)(5660300002)(36756003)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(54906003)(41300700001)(110136005)(44832011)(38100700002)(7416002)(4744005)(186003)(6512007)(26005)(86362001)(53546011)(83380400001)(6506007)(2616005)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTBpUnk5bXU1RjZCWUhuM0N5S0lCR0hDc1dXb3M4WjQ1QVZtRm1jTzMrZzVk?=
 =?utf-8?B?eEg3OEFSdUhIaGh3T0sxYXZjalpqNmJYN1lpR2NPWURoNEZ0YnN3U0xHSWNj?=
 =?utf-8?B?TkNiSzFHVnAzaElXWHR2aFU3cUtkN2U2c2tkVVpwZm1zWWxXQUgzRy9vY3Bw?=
 =?utf-8?B?bkF5UVZzS1VrS29EcHk5UWxOMDJXYnBhWkdzWEp4VmFCSi9TODVpMjgrVlo5?=
 =?utf-8?B?bnpGY3NlTERSMHZ3T1E0WnBYWW9xY2MvZ1VrVFJnY3QwVVpKV2YzTzQ2VHAz?=
 =?utf-8?B?SkZJeFBSSDJJMURVemNlU0toemo4Sk15cjllaVdON0NUcll2MzQyLzFQbGt2?=
 =?utf-8?B?aE04SWNKSTBEU21ZS0VRQ2s2bnBSbGhJQVRTbDVKb1ZzU0labWZNNWNveHM3?=
 =?utf-8?B?QXp6bXVMVEcrT3JlRkJoeC9CcndsQjlkc3Q0ZnI5UnU4cE9ubllWU3Jqdm8x?=
 =?utf-8?B?UkJHdE0zY3JXdk5jZEk4N2huNDdVZnBsYUVJVzZBWUxXcEc0N0V2azdjcW52?=
 =?utf-8?B?N0MwZ29NZXFURWFHanNWM0IwMHRFYzJvTGZZMTZXcHdGcVljYmNjNVpFOEZS?=
 =?utf-8?B?eXp6MFBFK0FEbjVNeFRmSzJsWkRiNHdYN1lNRHdVMlZMVERNcCtRMndoMC90?=
 =?utf-8?B?NWlsUWpIK0ZsUDM2UmpzVjVvbkdyb05pTHh4Y0lNWGJyWTh2UGttenlPUVY0?=
 =?utf-8?B?VXcrVDFaSWEvNlFvY1ZIKzRqSnFiek9pQUR5SkFkNEpqbWEwdzdiTkk3alZx?=
 =?utf-8?B?Q2ZSMWU2OVBaU2N3UkVBM1lrYzFFajVVTCsxZHZPdkJHbEE2VzRqRkFZcS9T?=
 =?utf-8?B?UnBGeWRlVnEzVzFKR1UwazcvazVQSlJmNnl6OWR4VFErSklqR2N0RDhoYk9J?=
 =?utf-8?B?M2k0QTNDZGx4Nlo3MzBIWVVNekE0QlV4cy9vMk1CemQ3WFBKb2tXSU9PZHM2?=
 =?utf-8?B?aHR0ekl5aTBQTFljb1RYY2hKTFNJc0NRRWN1b0VnVlFlNTExVDlWUWRzQ2t1?=
 =?utf-8?B?QmhrdS80N2ZHMEhxUnhzWkFsb3dIbXZMYXhZVjEwbVlpYmRBQi9JLy94Y0hE?=
 =?utf-8?B?NXgrKzNFbEt6VzlkeHg2Q3k4cDB5cVNSckhWa1RIajlUK0hjWHNnYXVNTFla?=
 =?utf-8?B?VUNYNWhyQ3MrQkxCd1lRWUhSY0xKRnhtSzRIUjlqZytTbU1ldktZSmFlU2xK?=
 =?utf-8?B?cjZQRnVOWkQwMmZNYWoxbHQxQm9zcnl4TFpUcGFuR1htTEw1SEZsMWJVajVn?=
 =?utf-8?B?WUQvS2lXaG9iczZZNFRaMTgrYnNQK0dEOEZIMXZTd0htUjJJNXRpMnBwRFJ4?=
 =?utf-8?B?ZVg5QWJqK2k2SDJDSUFLQkJlN2pFRTlIRHU0aFV0UGlvSFBSVXZ0a3djeDEv?=
 =?utf-8?B?UEEzYjdCTmo2S1N6bkxlV1M3U3QvalVGTmF5ZW1PZ2VHRmVMSnVOb1E4bTM5?=
 =?utf-8?B?eGdSYUZ4eEFlREplNG0rc25JWHlTcldLUFZUNHlXcCtlZCtQa0YrcHpkMHRj?=
 =?utf-8?B?ZlJZeFpjOThibG1uSlE2cVZBSytjZDBHdEZzNWdueklobmc1L1A2SnNlMExD?=
 =?utf-8?B?eFhtdGY0V0VzNVdLUVZ2d29nUzZYNlIwMy94cXR1L2ZhTElJUmQzK2puaE5l?=
 =?utf-8?B?TzZPSE4raEgvcjNzSUwySGl3d2xtSnlBRFBMbDJWVG1IcUZRVTNlTGlJVkZQ?=
 =?utf-8?B?Qng0V1M5ZUxMbHorQjAzRXpscGMvdmRRQ1RNb3d5cnFWRmplZ1VjWEFOakJ5?=
 =?utf-8?B?bWthWFZHcWlCVzlkeFcwbGhZS2h1VGFsZExhYzFmZmNjK0RndDg1OVBKKzhM?=
 =?utf-8?B?K1B1cWs0UU9LSE44dWRPZUxuNzFPY3dia2YwVDlFTEI0b1MwMDJvTHlSR2Fa?=
 =?utf-8?B?OG96ZEhtRVZ3VHJQM1E2aXRtVnd2UFJaaGNDOFY0UXBwUklCb3h2MGtGcyty?=
 =?utf-8?B?MHdET1pJZkMxditjckt0Nk1yRWdZMExsMXNrNzRxU3hobjlsUkVuajlOU3dD?=
 =?utf-8?B?UWg0YUp5aVlOa3hwRm5yZ0hzN2VudlVtV29Dc2VOcFA0bGhMa2JMSk9RRVZt?=
 =?utf-8?B?YWJERVRFajFFbnBmQTRGK3MyVTBvS28rSXNma29CK0NUUEpUQ09Za2RLUkRq?=
 =?utf-8?Q?F0chvBLuO0UjtYCUpVkTJKJPl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd483f2-d449-40cc-2e75-08db10a718af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 05:23:26.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noH4ElEMWkScXYnM9mce1qqX4dcZ68YM41N2GHHXaD4VQAazcpWlY6UccLEaEdj+Jea+UsKYjnsMwYAr7OGf+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Matt,

Thanks a lot for testing and the dmesg log.

On 2/17/2023 12:29 AM, Matt Fagnani wrote:
> Vasant,
> 
> I applied your four patches to 6.2-rc8 and built that. The black screen, null
> pointer dereference, and warnings didn't happen when booting 6.2-rc8 with your
> patches. There were errors that the IOMMU wasn't restarted when amdgpu and
> amdkfd was starting though at kernel: kfd kfd: amdgpu: Failed to resume IOMMU
> for device 1002:9874. I don't know if those IOMMU errors were expected or not,

This patch is not for fixing PASID enablement issue. Its more of gracefully
handling the error path.

This means patch worked in expected way. i. e. It failed to enable PASID because
of original patch (commit 201007ef70), it didn't attach devices to new domain
and attach devices back to default domain.
It returned error to GPU saying we couldn't enable PASID/PRI. Hence we saw above
error message.

-Vasant
