Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABAD351769
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhDARmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhDARgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 13:36:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BDFC05BD1E
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 06:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTouuMlPQmYO1ugtbJKR6uWpp7bN8dy5Mw48qwunlgdpITvzJZPUzWmRJGLcS1oQ7xN2Iw2yZ54FNADWXadzWHACqDrAEQk0gqNJmsEENEuFh0xheLTByEBvqGkIxNZXCiiMwsxbdJpULrsFfCCGDj6INMzaUGrp+Bd2I9Ex/43ccFeKMl4TflhAq2cTorUVXhSt1PomYkkVwGFW45nFyzowqIGXCGj/p890/ZqPrKtCimifLjrZlJzwpPQqkmUz82vplEmIUuCfm0b0RmN4sG5mnKRX4w7M6Lzx9Xxna1ioxlbRA417SYQWj3ipIlmwllhG8qIDX7tD0ZDa34RjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcGYJpjK6k0Bm3fsAh6L3UZogSztddaVq95p0i8UiYo=;
 b=L5l8bZjqZVjGXpvMmMF0iypYzIZSvj0IgzQvbWRd7rIn7Z/0Ey0rJsrt+BpXdmdPk6nlLTeX/+q8DfthbKyzSBYPt2Ua8Py+7vCXNBsvqhbEmt8Q524M5vBCr5skK826sVNpadlokMC+VSU9t0kMFHOCS+GvHbDoa59AKH4qDiUjIMqQA5DhjdNBsQY3aiXdZeaR/CS3o7Z9WauDbFP9ATd2kWc1iyRh91NDY5pDHqIwc7/lV3BRFdEn2vmKZ6ESI+Wl0jytXu50yMd36AKMRUo56bqCpyqcUs/H6THdc2jD3jHGSR7Wypsdh3S4fattOjHWAcZrXvG4vJ+y4V1fmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcGYJpjK6k0Bm3fsAh6L3UZogSztddaVq95p0i8UiYo=;
 b=X0sHfjtxJ+RCW66n0c9GxFfsnNlgavvGbagocFDD0dc+81Ii6fKEh2FW41SeoMWdNUCZ2iDIXrfgAwoaCd19XrpqHi60Q+NS14dYXG5wioHOSsAAOwcyTDJzmeLY1USqsK973OwP1KOohShqdg8uA5n9HEDaTCfSCdIErVzXbB4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2388.namprd12.prod.outlook.com (2603:10b6:207:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 12:03:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 12:03:39 +0000
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Are back to back PCIe BAR allocations supported by Linux?
Message-ID: <30b3cc23-75db-a2f7-cf1d-e02182db8be3@amd.com>
Date:   Thu, 1 Apr 2021 14:03:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3c32:c312:443f:a091]
X-ClientProxiedBy: AM3PR07CA0148.eurprd07.prod.outlook.com
 (2603:10a6:207:8::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3c32:c312:443f:a091] (2a02:908:1252:fb60:3c32:c312:443f:a091) by AM3PR07CA0148.eurprd07.prod.outlook.com (2603:10a6:207:8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 12:03:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3eea53-3c3d-4520-ca07-08d8f5062fa1
X-MS-TrafficTypeDiagnostic: BL0PR12MB2388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2388F427C0A8A8A03DC97914837B9@BL0PR12MB2388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nit5vCZwpOC0HZd9tQd2BsrZdlMbo++dAaq1iZ8hkPDKWTslMRmUkhJZHgwlkUPrJFFPXDGzH4dCO0paPc1MS7a+HumErKOImRCNLu0cIngMG79UuRnDx1BPe+0Oy/0tOvPX8JYcC84QUjyigoJbtsnkHJ8wHY63Ldza5gnqH0srL9p09f1mWVtDjwkDkJN47Wp0ObmMsJL5uhMQ1+4BO3nzSggbphLgP1RxlWjXH+NytEq1oZbNqQwCsNqw8MGFodKHkpIj8hI6TEPfjO1BM9JOzl1NrijbtSw4IQu2NNFq0bcrO7aiHcJF2i8/zG6lsEVcq0pVAg7sOBfACrVLgRpaOs9yxLf2iYAPF6oytOs/uCQIHxCMrmIbkv18SeI4rOu3C38We2b6xpvbUM7Ucln3oXPR68Zf9xEN7oMJ8BtUn5b6T7/Pi48Hkj04CLjajTCllJZHgbQHYUUn0OuKmCX+PtqW+e0UmOhTRrdrkgLIS1v5aWlGZytysepwAqeHBJtejahkj0fbLs7u3zuVW14j8SjZkJfSDPoyquQKId8lTyok1WpqcD6DlDPdP/PZrn4TBZjqjMLrDM92PEHPa0p+cCU/LyP2vgFCwe6OHNQ+Ex/l7fLYlq0HcBSp3CuNWOO1jTt8O0R6sSyuCdOrmlBMZg0q/hwe+d+xV6mpKHyFaP/8FI5tft4FyaP6OJ5KqH81CH7jI6NnXO6wrSsEPfqHLQxIGwthujeajCYmMCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(36756003)(186003)(66476007)(66946007)(2906002)(66556008)(83380400001)(38100700001)(16526019)(2616005)(6916009)(8936002)(316002)(31696002)(54906003)(5660300002)(52116002)(86362001)(6666004)(478600001)(6486002)(4326008)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MXBEcEw1RDkwL3ZpSDZiUjRiWVJDRVJYZXNEZlhMOXdOUGp3K0VRU3dGaEts?=
 =?utf-8?B?aDRIL0Z3RzMwWG9GZmtVVFdqNTVaUnhRQzVSWE5kVmNOaVFMbENuVmRYUW5m?=
 =?utf-8?B?QjVjMFY1TFQxbllodit2eHNrZ0UraStSTFBicnJlUDQ1dXVVVUpqSTczaXFs?=
 =?utf-8?B?enAwUVN1eXBuU1pDQ204dUdoMW5MSTJ0T1AwQXFYcnlKQXpjdys1cldBb0Fs?=
 =?utf-8?B?RHk5NG9yL2w4V3E2Qy9aeWtzOFU3NGFPSmFtWU55bi8yUWNUYVVOQWJHenk2?=
 =?utf-8?B?TW92cGdBb3UrTHRSblFIbnJZYUl6ZzlSclNmME12ekF3UnQyc0FIMm0vMFFu?=
 =?utf-8?B?Z3BpZ2FHTWpNTm54VVBxb1BDZG96SG5OaFBrZVIwMytnT3NQaHZMOWE2dDJr?=
 =?utf-8?B?NmhZNytST1JtYkg4a0srY2QxcVVZRGdOVXB2K1FBOFRIUVV1VjFZTWJlcTRl?=
 =?utf-8?B?ZjhyQk1wOGI4YU1hYVhQTDJrZ3dJMGhnanpsbWhsNEZuUVE0SmlSMGdRRTVy?=
 =?utf-8?B?ZWt0TlV2VU1RNFdrNWZOMTR3VXJZcFU5cjFRRGNFMU52QkNVUWZ0aUhuT0ow?=
 =?utf-8?B?K3gxY0NyVzNIVTFSSlM3K1ZTc0QvTEZ1M2oyUllnMjkvdzNKdGwwOUY5MWZK?=
 =?utf-8?B?NnozWElTRmxWVFhqNnhid2JoR3NQNFk0V0o5SlJlY29tTG1zRllnUzRsdUN3?=
 =?utf-8?B?WkhhOG5tMS9rdXdza3dKQWtzcitHYXViSHQ2Nm9pTjgzYWdYaTR5dGJ0MG82?=
 =?utf-8?B?RkdtT25ZK3Q1VUZERnJBVjVVVVJPV1hVR0wycnUrS3ozaWxwS0xGa1Jod21B?=
 =?utf-8?B?UXcvZDZMK2NVbk1jdXRLRC90V2FOb0k1TmNjdzlxTnU5RndTM3ZVM0RZN0kr?=
 =?utf-8?B?S1JmQTRiWURjR0kyNHVqNnJKM01WcFA0SWlOZmt4L1hRbm9xMnVwN21JQm9V?=
 =?utf-8?B?ajlSOHVjNEsrSWw2TDFJSjNzWU5CbnRzTEk3cmdIRmhzKzhtN0Vrb1VZMGpN?=
 =?utf-8?B?NWIwNSt4bExjTTdDK1RqNEJSVWRuSTRkY253VmllS25xcFpVRi9ESEVaRFFM?=
 =?utf-8?B?M3cvQzh0VjZkdm9SZEpKMU9EbTZ1bjZ0ZUk2cW5MV3A2SWhPOFRYOFpRMUo1?=
 =?utf-8?B?dXg2cnJuRW9CVndxUlUzb3NpR2pYUDlOZG9HZ1EzdVVTZ0dJOFQwVElpL1RT?=
 =?utf-8?B?RE9jNitlWWtXTWhjTjNoRDNMZUQyblExSUlQRnJVZ2tIR0MyWnc3cXNaRE45?=
 =?utf-8?B?MkxBblp1eFZqa2kvcWxzQ1pTQkxoc3hiSWdJeTUxTjZNZVRRZ0xjcnhCTi8w?=
 =?utf-8?B?TFN2S240N0krS3IzMTc3MGk2VHdaNzhJdkRBWnRJK1ZDSTBQWUJOeFdoYzNE?=
 =?utf-8?B?N3BGbjRtVVpsYmZWOGZQSmJDT0ZPY0lwaEZBRTVuL09rZUV6bnZ5L21OOE95?=
 =?utf-8?B?MkVuOGxzMFNwejU3c0lsdlR1MGpoMmd6TFA1c2hTeUNVZHBTMXpkdDc3U01K?=
 =?utf-8?B?TDArMHRwdDBuSFlyMUQrQitWTXhrZFFLbUYvM2hpcFVrdDNLbU5Nc2F6blpK?=
 =?utf-8?B?amlRaHBvKzVBbG9sYnU0M2drSGdyRXVUUVZ3UHhvYTdnWDk5ZlFhaHI1UkFu?=
 =?utf-8?B?V0tEOGp4RndUbmdsaUZRMWNpU2VwcVJ3MGhYZUdlZ2N1Nkg4UHc4c1FzNFZS?=
 =?utf-8?B?VThseEl2N0J4UEVNTlJzSUkyeFVRMEtNdkx4R1lRYXBMMmdEQjcvcXN5ZUd3?=
 =?utf-8?B?cjRzSGp3a1dVQ3JzeGtYc2tvQm5zQ3FRZkE4ZXZCNnByNzRJQlNCSVhWdGJv?=
 =?utf-8?B?N0VXWW81c1VpUlQvSGxudlYwdmNxY1labVdsWHhLRXRRV3RVT3VEbCs2N2Ru?=
 =?utf-8?Q?+nLBVn+5tb7BC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3eea53-3c3d-4520-ca07-08d8f5062fa1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 12:03:39.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohSeY5O9fwem52HGycy5BCva1Ii+oTumxAjqaKz3vCXL9ij+jhk7sVZWSzRdguCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2388
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone,

we recently had a bug report of a system which works fine when a PCIe 
hotplug device is connected on boot, but fails to initialize if those 
device are disconnected and then reconnected again.

During investigation I've found that Linux isn't able to assign the BARs 
of the device correctly while reconnecting. The problem seems to be that 
the Linux PCI code doesn't seem to use back to back BAR allocations.

Now what's back to back BAR allocation? Let's assume you have two 
devices with a 256MiB BAR and a 2MiB BAR each behind a common upstream 
bridge.

The configuration Linux seems to use is the following:
Device A - 256MiB BAR
Device A -     2MiB BAR
Padding     254MiB
Device B - 256MiB BAR
Device B -     2MIB BAR

With padding this results in at least 770MiB address space requirement 
for the common upstream bridge, with alignment this is probably more 
like 1GiB.

The BIOS on the other hand seems to be capable of configuring the BARs 
like this:

Device A - 256MiB BAR
Device A -     2MiB BAR
Padding     252MiB
Device B -     2MIB BAR
Device B - 256MiB BAR

The result is that you only need 768MiB address space for the upstream 
bridge which then perfectly fits into what is assigned for hotplug here.

Is that already supported by the Linux PCIe code? If yes then how? I've 
tried to read a bit into the BAR allocation code, but it is kind of hard 
to understand.

Regards,
Christian.
