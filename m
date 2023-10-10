Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117AA7BF7C8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjJJJrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJJJrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 05:47:40 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309CA93;
        Tue, 10 Oct 2023 02:47:38 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39A8eaU4028580;
        Tue, 10 Oct 2023 09:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:content-type:mime-version;
         s=PPS06212021; bh=tP/SWSiMCjMotZ/GmddbaZ+VaSZsS7fKnddO9o0d6co=; b=
        FoUbChXQeQQ9H2ijTs0+tiMlDJQVYd5/R7TAhNxCjmOLxmf35jD3EmxP6CHZb6zP
        WE2rdGBi7DrzW9ostK80s59L2Nq1/VF+SYtBI7l3wSE9nIVqpeM83RcOOKEFby5u
        V5wT4z9gIv78CfkgojCGBqHVj+Ff5SnvN0ZeWFYZRAzinkgtogAjXtFKxPINXnn1
        Z+vBMb39iW/dWdfQGmzuQ3IsAczWDUFYENo3ZV3B4GaDPt8TX68o8v11mU6Q3Zec
        zvnbxgXlwY4MzM+hk0rpn1cHbLFp85waBVhv7YE+stxFKCpcQUDOqtE3/DtdR3eJ
        Pod+LB4TUIj4kDk89Ujv6Q==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tjvhx2mem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 09:47:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSCFMtDn/gShIOGtmh/fpIxMH5z7fA6yJSXVvESY038SrwTdjWhxuioya1Dq9rgzpTj+1/Mm1u7i64hVXXPm3wmOX0CWQ80YZSOUzOaKVuTxqoEVibCszLkVOfAknihkEly1Dwr9C9RewiwXiGUrMfpChGAKFFoEGYVI870/zOmzCW3u3BkIxCN3v6jHvl4fAUpytB3LfddkzOlt5VX93Rc9Ba5H1sIOq+1RqC6SbG5qVU/qpGVqE/rSCbZF5tBg9RCY6q/x2sKeXQpv9tKQwxGb4IgLUObQjhxIbEDenlVc0CRgSR3qS1MHAjI+a8yZZ1Q5bSkozX1h0MsZt/ZO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP/SWSiMCjMotZ/GmddbaZ+VaSZsS7fKnddO9o0d6co=;
 b=Pv8nKhWCPU3ItoVXGoyu8Ww6bYXFos8RjyaWQLE3UzpqKUTHZK72OkeIrDdF2hI64JmwelEbFwGKW8IlanQcvwjM/+ZY52R+PuZeoYQd79z/rYR2lWZt1toL/YCP/OXtGhxxJmhWQe5OefRzhOf2I5JWjHmPjBQ7JbeKCUWKe5sk22SQhZpwdoJansSfyVF56y673ALoX/CEC/lRcamLd+zWe1OwWdrUu0xtPSrQ7BEIjJYnYeZ/e3C0zcl9U6CT/B+E8X9NAbAFD462kvvW2MV/jxIdpGXhBg/AvUEz7bl5L0f4ndSnzgMOt7Zbz+FT1aZGbW007JyBYDnC5Vx7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by SA2PR11MB5114.namprd11.prod.outlook.com (2603:10b6:806:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Tue, 10 Oct
 2023 09:47:30 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::1b7:f69d:4797:6ac7]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::1b7:f69d:4797:6ac7%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:47:30 +0000
Date:   Tue, 10 Oct 2023 11:47:23 +0200
From:   Marcel Hamer <marcel.hamer@windriver.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: pciehp lockdep possible circular locking dependency
Message-ID: <ZSUdqxOZ9HUFR32S@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: GVYP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::6) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|SA2PR11MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2725cf-a1c6-47ac-0032-08dbc975eb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TD9zkDgo2/m9e1CvJz1qBb+Xsbu9IBqgXRJ0KYaGUT4ksNagl7hhNKI1wxvm65EbWB/L/y+c3sZwVkO9crCpdwTOn6qTpFfzTc91WOyOow5MmDHCB2uIvM1qvAOj2lWMHqZsLORartLwqOsSyMDtk1p5EQr7ngeWlA9vFAda/NueoTxiCJUNhKOeRH6aED5duzdFOx0nRZndeMLmHvdVMgW/0oDqRiyC49bN01WSFRUVJMgy/P8KtNcbdyIUy7wg4rv4ZE5WCbyapUhLQKDLq4b0oz8HF3vJqT9DcftOKMtv3FGd1XnlWbKdwgR4Yeo78o15KjUGGQRFZVcTD+dSlsFKhIWNk2szzVT3yOqmrL4aUNbIkvIBqi2XB1Mpf08UlDkVF3uruRvHG+Oyk0OXS8tgxSLyb6yOfSW2m+WMXJsTXlAjAHQ/ntTw/AbEuY4PHh6rOZcKHSy8kQRMb27ANF8APCr3CydP//pjMdrgf8LB1Lf4YICI7b+xKVBkm0jKRNg3DKHC0gI5I43KXOvArmckyFwEswdW0kXhEA+3TJCeCynAR5cOcUZe6YHgkHmC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5617.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66476007)(6916009)(66556008)(2616005)(41300700001)(66946007)(6506007)(6666004)(36756003)(83380400001)(38100700002)(6486002)(86362001)(478600001)(316002)(4326008)(44832011)(6512007)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RatUHCHdsFr7gnF+G9bdUvmO6m7+W22ieP/+HgHwkJIxMtoACPuiQhHTfsWI?=
 =?us-ascii?Q?fn+37p75UHM61+NUg9bbzPu+7Kf6vAwHfps1Su86jzZIZXTKhT+5iUdh8gQy?=
 =?us-ascii?Q?pguKvLYVMAxE77vNHwiV1oQcOZ1Jit/FOd4yiV1JliRaMGj6d/Htu12R1L3M?=
 =?us-ascii?Q?rkNxrUftm7Ov/VP/25wIn5JK2/PugbNGHlN0tvI7h0QHd97WyEs1paY3R1IM?=
 =?us-ascii?Q?QM8FL8Gdv/tIw3ZU2VTuY0ksdacXbgf4Zdt2nvX7uzWDqal72RuT9oAbl/xi?=
 =?us-ascii?Q?PK8gW066PbAjINI/LH6QwM8zddVDj4BEaDsyfYgyFEGvlrlyEfhenuxjIQ4G?=
 =?us-ascii?Q?TTXF2aYHMo/YnQVbaQx1YXDJmvkQn9i04FbNTmYS3IW4+8Q5VTf0kJWP4auc?=
 =?us-ascii?Q?lMYPg79s1HeQYNNI6xbCNvLVE3k9ja98daZw0yxIiBrCCRxa4H7MdVLf3UxX?=
 =?us-ascii?Q?ZZ3CSIGciGl2LWp3Mqo+/weGHnhE4JI9xZHeHcBBa7o6FCAopfRnJ1SXEJLM?=
 =?us-ascii?Q?dsWjEdAr9wC8P0m3EEZC2uv5MILB6ojyfkbFdtZ27E4bCit4LZqGIKjmHXvV?=
 =?us-ascii?Q?LScmg2M/IE0s+uWN8GfLRIcFauEeSpcjNtZJo6Ni+vXpehNO+3iVAqkiiXmp?=
 =?us-ascii?Q?k5kOKNZTi8aOdJp9PfW9xAGCJ+89e6aBXmDHrnXTU95RIXMIODSFA+5WP9Cf?=
 =?us-ascii?Q?WZtYusgSBBwVg8FIi6pjvbkCeZUdv1J+LsXPfX186HbGqhAP9TcO3H05gX2C?=
 =?us-ascii?Q?Vm6SlebtwnIvn9mEjn+IJjyL0PmF3N0/SPSgHUk60yOyxR6sUdoEDF4xET2t?=
 =?us-ascii?Q?TR8FFKcOeHcMGDqqgagBFLMLwuy4LP9V1d2rLYqb5AaSzTTSKnBHq3jCghKt?=
 =?us-ascii?Q?hpabzwPKwE4zMKKEiq7hVLplY+PeLcgRj+cwARRHdJNKKFQnNT0hgNvXC5j0?=
 =?us-ascii?Q?5+kTYQYEt4A9qVlXPH2reCZy/Win1QfOWQpRzcScleQ2lcD5XO50KX2ylwHO?=
 =?us-ascii?Q?jkPm6/8Jm//sUosl1kd28Ii5dJe5KLZWegWZBciSi3lDJlHZzNG4xbhXZvIO?=
 =?us-ascii?Q?9tkyY7lGLKDq0YjcMExmU2T87MMEw1Xj4M2vVPT4PIHYUHGVkvLRw+30NMFi?=
 =?us-ascii?Q?0krigy+aZDUCg49/dcfzhzK+SCSh1p2n5xmYY/8iJhFRAqbLIZJ0HHuriLCu?=
 =?us-ascii?Q?mAcsVMY1/9FmMMdrgEAa4vVUHBQJ1byCx/89oA0UjPJuOpgwBoZFbtjpf+lf?=
 =?us-ascii?Q?PRjQjTsLW+eLxngkKzDJu00JGHhb5bGL0navzDQ8YY9z+aVqhtQhLC/urIER?=
 =?us-ascii?Q?boVvkVsV99Ru6jzPcJrnoBUcmOHiNn1yQdMl2gQHLzdhWp8RME6WAXvaTUF+?=
 =?us-ascii?Q?tgd/tuSmftixj1QzJ0ofuBvkWttPnpUl+JWjyBSUM09upsIDJ6cpgKqDsi3F?=
 =?us-ascii?Q?VsvzNX37yHe5lhXCfblreZnZqnt9YsYt/i9F/X1D4qXBP4Flbz5tNvDF7UUT?=
 =?us-ascii?Q?/v8XitFBjkeI0SdfVC8lWHnqSXWyi8rcXnlNqWufRCj6xwiW9T0AhpoTkv+6?=
 =?us-ascii?Q?U3QpRUiu17KB2brWg55Oh/OntpvtjJ1R/BSrPHpFGUm7VBN7NwV3gU4jfXuN?=
 =?us-ascii?Q?S/DtTfewSOlN1sBuxcd3m7PGt9TH8OcTRlpb2yHxaCH8gDu7OSZLtUqwEBF1?=
 =?us-ascii?Q?Y+TDag=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2725cf-a1c6-47ac-0032-08dbc975eb9e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:47:30.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lu0niCg+6Vi1AnRaIWkl4v86dVxAmH35VXf8XN6zIaxITzolEpWM000cMCewPyhDUrn55bLR/LXljrR91FvzxQqfBlZSdncMs8pJp0Ve4AQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5114
X-Proofpoint-GUID: oVhUzw3fJCzRGUVUA6vRNkUgKps34jRO
X-Proofpoint-ORIG-GUID: oVhUzw3fJCzRGUVUA6vRNkUgKps34jRO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_05,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1011 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310100073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On kernel v6.6.0-rc5 we have discovered a lockdep warning when using PCIe
hotplug. The issue is reproducible using PCIe hotplug in a Qemu environment.

When reverting the following commit, the warning no longer exists:

commit f5eff5591b8f9c5effd25c92c758a127765f74c1
Author: Lukas Wunner <lukas@wunner.de>
Date:   Tue Apr 11 08:21:02 2023 +0200

    PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

We have also experienced the issue on the v5.10-stable branch.

For now I have difficulty determining if this is a serious potential deadlock
candidate or if this is a false reporting. Any help here would be greatly
appreciated.

The warning output:

[   18.660032] pcieport 0000:80:00.0: pciehp: Slot(0): Button press: will power on in 5 sec
[   18.662205] pcieport 0000:80:00.0: pciehp: Slot(0): Card present
[   18.662791] pcieport 0000:80:00.0: pciehp: Slot(0): Link Up
[   19.805119] pci 0000:81:00.0: [1af4:1041] type 00 class 0x020000
[   19.806830] pci 0000:81:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
[   19.808184] pci 0000:81:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
[   19.809635] pci 0000:81:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[   19.813842] pcieport 0000:80:00.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
[   19.817462] pcieport 0000:80:00.0: BAR 7: no space for [io  size 0x1000]
[   19.818737] pcieport 0000:80:00.0: BAR 7: failed to assign [io  size 0x1000]
[   19.819920] pcieport 0000:80:00.0: BAR 7: no space for [io  size 0x1000]
[   19.820876] pcieport 0000:80:00.0: BAR 7: failed to assign [io  size 0x1000]
[   19.821428] pci 0000:81:00.0: BAR 6: assigned [mem 0xfe800000-0xfe87ffff pref]
[   19.821835] pci 0000:81:00.0: BAR 4: assigned [mem 0xfe000000-0xfe003fff 64bit pref]
[   19.822460] pci 0000:81:00.0: BAR 1: assigned [mem 0xfe880000-0xfe880fff]
[   19.822845] pcieport 0000:80:00.0: PCI bridge to [bus 81]
[   19.823728] pcieport 0000:80:00.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[   19.824466] pcieport 0000:80:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
[   19.825769] virtio-pci 0000:81:00.0: enabling device (0000 -> 0002)
[   19.880141]
[   19.880246] ======================================================
[   19.880886] WARNING: possible circular locking dependency detected
[   19.881494] 6.6.0-rc5 #11 Not tainted
[   19.881789] ------------------------------------------------------
[   19.882354] irq/24-pciehp/53 is trying to acquire lock:
[   19.882803] ffff8881002a66f8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_configure_device+0xb1/0x100
[   19.883601]
[   19.883601] but task is already holding lock:
[   19.884080] ffffffff82beb608 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_configure_device+0x1f/0x100
[   19.884804]
[   19.884804] which lock already depends on the new lock.
[   19.884804]
[   19.885280]
[   19.885280] the existing dependency chain (in reverse order) is:
[   19.885923]
[   19.885923] -> #1 (pci_rescan_remove_lock){+.+.}-{3:3}:
[   19.886623]        __mutex_lock+0x81/0xcb0
[   19.886889]        pciehp_configure_device+0x1f/0x100
[   19.887211]        pciehp_handle_presence_or_link_change+0x16e/0x4d0
[   19.887587]        pciehp_ist+0x157/0x190
[   19.887822]        irq_thread_fn+0x1f/0x60
[   19.888076]        irq_thread+0xe5/0x1b0
[   19.888306]        kthread+0xe4/0x120
[   19.888499]        ret_from_fork+0x2f/0x50
[   19.888728]        ret_from_fork_asm+0x1b/0x30
[   19.889018]
[   19.889018] -> #0 (&ctrl->reset_lock){.+.+}-{3:3}:
[   19.889382]        __lock_acquire+0x1509/0x25f0
[   19.889661]        lock_acquire+0xc1/0x2b0
[   19.889899]        down_read_nested+0x2f/0x160
[   19.890177]        pciehp_configure_device+0xb1/0x100
[   19.890492]        pciehp_handle_presence_or_link_change+0x16e/0x4d0
[   19.890876]        pciehp_ist+0x157/0x190
[   19.891085]        irq_thread_fn+0x1f/0x60
[   19.891301]        irq_thread+0xe5/0x1b0
[   19.891538]        kthread+0xe4/0x120
[   19.891764]        ret_from_fork+0x2f/0x50
[   19.891989]        ret_from_fork_asm+0x1b/0x30
[   19.892227]
[   19.892227] other info that might help us debug this:
[   19.892227]
[   19.892635]  Possible unsafe locking scenario:
[   19.892635]
[   19.892944]        CPU0                    CPU1
[   19.893179]        ----                    ----
[   19.893415]   lock(pci_rescan_remove_lock);
[   19.893633]                                lock(&ctrl->reset_lock);
[   19.893962]                                lock(pci_rescan_remove_lock);
[   19.894307]   rlock(&ctrl->reset_lock);
[   19.894506]
[   19.894506]  *** DEADLOCK ***
[   19.894506]
[   19.894830] 1 lock held by irq/24-pciehp/53:
[   19.895143]  #0: ffffffff82beb608 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_configure_device+0x1f/0x100
[   19.895785]
[   19.895785] stack backtrace:
[   19.896014] CPU: 2 PID: 53 Comm: irq/24-pciehp Not tainted 6.6.0-rc5 #11
[   19.896358] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   19.896770] Call Trace:
[   19.896905]  <TASK>
[   19.897022]  dump_stack_lvl+0x4b/0x80
[   19.897217]  check_noncircular+0x134/0x150
[   19.897432]  ? lock_acquire+0xc1/0x2b0
[   19.897629]  __lock_acquire+0x1509/0x25f0
[   19.897843]  lock_acquire+0xc1/0x2b0
[   19.898033]  ? pciehp_configure_device+0xb1/0x100
[   19.898282]  ? __device_attach+0xfb/0x1d0
[   19.898494]  down_read_nested+0x2f/0x160
[   19.898700]  ? pciehp_configure_device+0xb1/0x100
[   19.898945]  pciehp_configure_device+0xb1/0x100
[   19.899182]  ? __pfx_irq_thread_fn+0x10/0x10
[   19.899406]  pciehp_handle_presence_or_link_change+0x16e/0x4d0
[   19.899708]  pciehp_ist+0x157/0x190
[   19.899895]  irq_thread_fn+0x1f/0x60
[   19.900090]  irq_thread+0xe5/0x1b0
[   19.900272]  ? __pfx_irq_thread_dtor+0x10/0x10
[   19.900507]  ? __pfx_irq_thread+0x10/0x10
[   19.900716]  kthread+0xe4/0x120
[   19.900887]  ? __pfx_kthread+0x10/0x10
[   19.901084]  ret_from_fork+0x2f/0x50
[   19.901274]  ? __pfx_kthread+0x10/0x10
[   19.901482]  ret_from_fork_asm+0x1b/0x30
[   19.901689]  </TASK>

Kind regards,

Marcel
