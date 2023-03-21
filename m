Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82D6C2DA4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 10:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCUJJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 05:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCUJJq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 05:09:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F60513D74;
        Tue, 21 Mar 2023 02:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYcdsa/jnAAT3yMFgDQIlQ/Nj0vAcLbi7ZxSCWclzj2SKhWs4FGLXSBv06jHrYJVGLszoTD5ohg+boOM1HYAbFzPxN4MQREi5ATL3HP2prtDWFXb1r/bqvihUgyDKjw546NCASJnnE/F2f2KDUOlxEmdXO0vdb9HNrDFnq+35fHqkeKrDhm8RLwXHSgBh5keaVN9OXTcPNYrY1PwToCEIxwlWoIFxYz/gUYs8gnf15NITx6FTaUBOUBdwmGOms24D7tu7FsHsgk/hB56KAFsD4qJxbWn43umpsGx8pXSI0zbwt/xI7NxuMbCuDo1aaLMhchW0OeT92JZiw8kKVBNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIM+RBIvcLhA7EBqG5yipVY+9LHzv8xl8etYkcVlvmg=;
 b=Y4Ap9maaFs3KatVvOh9FVWIQwC5d9yfVxjrM5RS7g4Aoqooa/EzpufyCWoer5YNCOFAU3eCQ6h0rXtZuB3O+V9dXy/sckSkcQhPBWovnMxG3kB+y2GJjxH0uccmRTs0T3Hll309ure1iakp8a0or3WKTTKwgtXzYOo8232VshjJ/q/q8sk7Ot37CSa9Wr4gtw6MuM6hYjcAJbUAL+5sqd70q0AdCcUy+NO3Ig4Hock01EqAqb/4mfUARBe3MQ0XAY2T/eNU86D97RyEk6/JT5gDJ8QyHN+u/utIu9AoWSy7S8zonOevRFrKrQRLtEMQs5myqO3n3VW67DkPnuqgsrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIM+RBIvcLhA7EBqG5yipVY+9LHzv8xl8etYkcVlvmg=;
 b=JSxTx0k70eAtlmoyB153Gvt2UzSAhnodN/51svhN1Og6D9wrwKO7xPuQydqG6vOyj1wIByS6JkZLTQUiHmE+qahsMugFm/IDnybqv3/QnXgB0o23W1FAP/oPzGOERgX9Ugrz2eqPlUMmFV/VzpfCzuYmp+0EJtQfOG4XR8NlZo25C/nV/BCQ8z5tyJk54N91YooFygp/Xubq0E1ZW16H+Soh8EofWCxy0hCdI32bNeiEiVb/4EmKkL+JVNvxAmYiB+0JrjPN9k7+wsiWXcktIHLTztt5mbJRCWPMA80xIAvEbwQz7jBrDrWDtwG/asQaniKBxGN+FXxF1FBQZRUW5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AS8PR04MB7638.eurprd04.prod.outlook.com (2603:10a6:20b:291::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 09:09:26 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%4]) with
 mapi id 15.20.6178.037; Tue, 21 Mar 2023 09:09:25 +0000
Message-ID: <a1cca367-52b6-a6b1-fb01-890cad39fd29@suse.com>
Date:   Tue, 21 Mar 2023 10:09:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
To:     Oliver Neukum <oneukum@suse.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
 <4888964.44csPzL39Z@steina-w> <90e97b96-2918-294a-0e71-33a42f28d8a8@suse.com>
 <3607385.usQuhbGJ8B@steina-w> <ced8713f-69de-e48a-37eb-4f844e651b6b@suse.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ced8713f-69de-e48a-37eb-4f844e651b6b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AS8PR04MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1db02d-d5bd-43fc-b15f-08db29ebf7ba
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GtiLNvIGmW0TV+j+zMxA72AH2JpCz3VKZ8qMCIgQjTFk3rIt+gbgh15Z0G3Vwd/8q+3JGdJWNnnFLGQbNOGdApSLYZXQihMfzrv1TvuSE+vTW7OFDoFCdsi6ogD3fW7Py3T34bZRpP8Gg5cbO5X7CV2zrPt1wjlsYkIN4Orvx7tXvSWKeXLrQs7X7p0sB56QhNxrVWBz+l6ZSwbENWOC0s+hvLaYkBxQD70OdE/LT0qnSI7RR3a5DrzrYIOk7iKTJsJGfoDw+d68BNjtr/VUaJ0964av16+5pxg2aq8EzYOyqNzED+UQYRT66Q44lsUngmXSNXn8vbyQ030WqSlMfh7U/V88OBrrvNwZzMjJ5Rrc8mtV/f0OfqkC9fAR6VURWtBKpbbuTyrk0PmrROMjMqijgQGYHgr2cGfu7KMnBwlVifNX3OP1eVpjKKIRzKCQ1oj1fX/S4RtcjD1McxROjVLaSwDDCl6NQzcw9U1FI1q9oWHhswOMQuDoU1p2ettiDNJsR7GiMwjFNrhALP1njdxahsxk2hZCZSW7SB7+UKW/ogEIvP/UMYP7qBZBo8svNU2EpbrJhSPIt6V/Fy09lTkYUMhUsI5+WXzNnpKt6pxnUZMlMLHry0QCsU8QGWdwZ2S2LFbXzyIlLnR8NHaE9Wb0JiUiXTs2vK4oI/GsCqFEb+uFRDS+5U6WTZMflMyrIT2IIFWPAo1KIR0BO+/GdMQCArxkwm45U/utqxPH6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(2616005)(6486002)(4326008)(83380400001)(478600001)(6666004)(316002)(110136005)(66476007)(6512007)(66946007)(66556008)(8676002)(6506007)(186003)(31686004)(4744005)(8936002)(41300700001)(5660300002)(38100700002)(2906002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MERTb29XMDBVQlhGMlE3c1BjSFY5SVJLT0JRM1ZrMVFwcVRneCtKRG1PZE1I?=
 =?utf-8?B?M0NDaDk0VE9ad2p6YlVuelc0ZE1aY09iUHZtcDVsbVRWdE5tRHBUa1ZpeTFz?=
 =?utf-8?B?TjlBZjhSUUZQMWkxLzZIZjNPa1JyWlVXZ1JPalN6Mlk5c29IZXczQ1F1OG5y?=
 =?utf-8?B?SG5DNDBrVmZpeU8yWlQ1ZUJYTjYzcGtJNHE0Q3Q1ZHkxa3BmNHM4cUZtbkoz?=
 =?utf-8?B?VFI0Z2c4MVRsMWg0cjN5ZVdZNlM0ZkFzVkt2d2pqZTNPRGV5VEFSZlhFUVZW?=
 =?utf-8?B?ekJZa1NVQWhEbnlqMVR1RDM4SGt4aDkxcjk2MWpiUmlrYmpJNUd6ZkdxOWFy?=
 =?utf-8?B?STlrTDVxbWt5SnNyMmZBWWJ1d2FydkVKLzVDa3ZKLzNzUW14SWFjd1hTZXB0?=
 =?utf-8?B?cjBpZ3ZxU3pSeDlPM3NuZDdlZGpWUHd1SjJkWCtzUUlOSUNybmJxUngwWjFs?=
 =?utf-8?B?Z1U1ZWJmNDA4TitDbkVJcWY5OWd0cnFKbHR3QU56eVlwU3RwRmpES3RCMFpa?=
 =?utf-8?B?dlN1U1VUSFhHVlR6ajR3Yk94dk9OWEtpeVc1WDM2K3Z4ZzFhSmZhRGt6a2Na?=
 =?utf-8?B?QUtUQzhGdncxYmpzWFZoTm9rRWNobDY5Mi80bjVxQjY5cFV6Tmh2bGM5bTha?=
 =?utf-8?B?MjB5amx5L1JQaXRlMEc1Ymo1RDk5bVd4MzFVeTRhUmNiOTVSemN4Wkk2RWZQ?=
 =?utf-8?B?QWswcWs0ZUczY1gxUzR1aGVFYmw5WllMeTdlZHo5QjBURkprUVBrOWppcG1k?=
 =?utf-8?B?SENCdEc5SXZqekM3Wjg5RDRnZ2xYM3pZRFBtL3pITFgrVUt2L2xGUzFtOVZa?=
 =?utf-8?B?ME1QNU5vSUdQZ01wUFZxdUg4K2FFUHhWeTRpN0VPc05SK2NTcHloM2dZNFAx?=
 =?utf-8?B?NDZrTVdrQkNNc3BpNi9jOVNqWjdXSGw1aDNvRE9hWTVTK3ZLdGZPZTR5UXpV?=
 =?utf-8?B?Q1gvSjdrSlYrWGg0Q0FKZTRPVlloNjVZNzRSM0l4T3lmRTN4U0p2eHZLdGJy?=
 =?utf-8?B?eUNjKzZXWDlkcFBMa3dzMUpzYzBianNHcDd1N2pmdXFzSTJtSWdlbVFTMDgw?=
 =?utf-8?B?YzFtTis5MFN5L3BxV0VRSUVwUWxnSGpXZUZyT25TUDUzcUZ5OEUrall5WUEv?=
 =?utf-8?B?UWJEcTRRQk1YVGZ0bFhnWEJOWW8rdUlraDBSRGhDNFJSSzVWams1dWlmckF6?=
 =?utf-8?B?d1VHK25hY3FvY3ZhQ01sdk5mNXpMNzNSRUNRUHUxdFBWRUJRUHhiSkxwdk10?=
 =?utf-8?B?eXREZEhpZFZBSEl4ZC9saWZnYXNUZ2VscVdNQU1vamZnWklzM2Z3OUNtUHFp?=
 =?utf-8?B?RVJseW9JTkFLakI4NnV6Y0RxbkdiTzAvYXoyL2JzZDhzQmY4YTJiSFE2Q1Mz?=
 =?utf-8?B?QnVRRlB0NXBiaUZSMVg2aWFIYTFjZVRXWGp4enRDSWVCMGRIQ1o2dGhnZ3Mv?=
 =?utf-8?B?VDl3TkdJdW9SbkNUaTRvcGQ1SGpiOG4rcnZvSGdsYktKOFEwNW4wVmhxVzVq?=
 =?utf-8?B?YlVlOEEzMThKSEhYdkVaNGNIVDdIL3FUOTduekxZeWVUS0p1V201eTZDZ0RJ?=
 =?utf-8?B?VUNyMFM0L2JnejlLQXM0R29ncmJNVWt6cEdFSFBjbzNrdzk2RmhISlJUMlNL?=
 =?utf-8?B?L1ZLci93ekRPQ3VSekI4TGVxYXRhUWd6MGIvenUzNndhQWtrNnI3RUZhMVdN?=
 =?utf-8?B?NjVaQUhnVmxFSEFtS1lpUGt6Rm01dmJkdDRIKzQvMmxrT3Q4S1VVZ29LMTZS?=
 =?utf-8?B?RlplZ3YxdjhENmw2Y1hPMllCRDN3VUdCMTVTdVM4bVJmdURWcGxCMEFDckhG?=
 =?utf-8?B?NFNscEtsSnpsSFl6RDRiRkRoZzVkeS9Va3IvT25zQThKako1c0JONzFyU09U?=
 =?utf-8?B?TWpGeitYMWZFSXVlVUdFOXNXYjhpR2VCUmZ0T1hSbWRYenBFRmpsRkRLSlJq?=
 =?utf-8?B?ZFVXb0xseTBTVjRBZ0grWGpRWExtL01SdDVwTTBDMm0yVkJEejRycVBHblhP?=
 =?utf-8?B?VVp2QWJZVHJBbEZadXg0NVBGZCtoQzBvS0orN3lEVFp4ZUQ5dlNkRFp6TXQy?=
 =?utf-8?B?ZFppTUtBQy9HK3JCZklYNmFOYmdSNU5qdHEzWVpjL2xwN2lha1dya1VGZGcv?=
 =?utf-8?B?ajJZMmZDTGFJOVBhWVlQRVZWMHRVcCt4OFBOaXVPNGFyZHBFMU14SXVxRzVq?=
 =?utf-8?Q?ZR6O/6KYe98qefElNcftMkbiMoRR7PnIgrmBhscl0xLF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1db02d-d5bd-43fc-b15f-08db29ebf7ba
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 09:09:25.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qAB6U7UgYBnAN06Og1hX+b2o9/tZdwVlDexfGRlWm3jsrxXpc+RQXqVCWy9D25HGjhm13ID4asG8eCydbK3uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7638
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, 16. März 2023, 15:01:25 CET schrieb Oliver Neukum:
> I'm not sure if I can follow you here. Can you elaborate?

There are far better reasons to leave the setup of a PCI bus as the firmware
has done it than to leave a USB as is.


> How is it necessary? How do these PCI devices get attaches to the pci_bus_type 
> bus without calling pci_bus_add_device?

AFAICT they don't. But somebody has to call it.


> Okay, so which dependency is provided by pci_sysfs_init, which are required by 
> drivers then?

It isn't. It is missing from the code. But it exists in reality. That is the point.
You have a race condition between two probes. We cannot have that.
Hence IMHO the dependency would be best expressed by waiting for pci_sysfs_init()
to finish in the init sequence before you add any PCI bridges or devices to the system.

	Regards
		Oliver
