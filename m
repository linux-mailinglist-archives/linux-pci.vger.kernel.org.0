Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D407CBD1F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjJQILm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 04:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjJQILi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 04:11:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FA993;
        Tue, 17 Oct 2023 01:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxtqxnwGAxuRo/DFLC4U0yMv8aaeg5I6erqr/OqQDGSTHo4t5Cry7olkhie3cF0s9ZAlZ5VDCrSRQsfp7FX4e2q6VrBN4fWu5KPFGpuw3o1vC/h+bEl4fw1kOX3YyqIjrKF1Kq8bbxDvrSQtVVEeaixhiLylYggOgpbF7zxR4Yh3Zkgrt47nlnKvRWxy2Wr3bEBykoBP5t/+qcb5CIeXdXNVaBqoNr/bpmHREjrKdbY14wN2IP1pJeJhCFI27DP6TPqvj1JRnR2hy6TvWG2MNxQJPUZCQzIQx07eJPQKdn8rCzwqcI/NjqjHSPUUF7EzeeWt6pPDiMx5QS53PBzEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4T+JoLj2ZzuDj3d75na6qY4knZE3cPRlR/JKGD+th4=;
 b=F7tn1vn4qWdlUxpoxjjqnI2eU7KW3OdLtMXmp/aRnNI0tksewy5HKN3E3zH2MueXUNcMcu6fHLCZd8VDPcqsSVrKBYBHrwZvCYNJs2VIoxZUBA+uoVgfajiRfUfoQTiguLxRs2NUCIuE09GAnZK8iKhG5UtPCmofzPQ9GGgltTcjbKneYd6wosfjdd8MPiSa8w25BqII/Jpyk5OivCTHSjKdbLZ/I6TWjCdkF1Zxty9yEsHK3aKpe5aYf45jln8jR/nyq+mzzvogZvGSh35P7mTv0gqck7nl8xDYQKCFf5ImdM9Dg5Mj0itN3Oo91dMQnX1dHSXCFSreqaz9FYR8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4T+JoLj2ZzuDj3d75na6qY4knZE3cPRlR/JKGD+th4=;
 b=YxQei0w0r57E4U8fwsjPSEm+u8IzoLcwNVTlffEae0+0XmfL5io4pZc+oDNaBcU3WLBKFuoGBabbGb7AQYRJDifgA0fFB76lh+SnAMoEAsLSr0oF0xcquqWqS8OGZuyb9AK4Y2uj9FOgi8w8JGdCUxFAFlkWx+Q3Dq8eWQtvUgG9ezkf77ggZNIxLiO/f3YftFf3D6jS0WXEYXoReqNmKbgqz2u8J/tSqow/kOyalEoDFl8FYjLmaVkYKPQMYSWWHbGCOqCZX3Gj6CxEtWNeDEdBaZvAjcviC59L2nms0wQHInVV6YX/RMDPUtHkijjaGRVPX09QAl+J588nMbkIPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 17 Oct
 2023 08:11:34 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::628c:5cf4:ebb2:77f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::628c:5cf4:ebb2:77f%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:11:34 +0000
Date:   Tue, 17 Oct 2023 11:11:24 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de, petrm@nvidia.com,
        jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 02/12] devlink: Hold a reference on parent
 device
Message-ID: <ZS5BrH1AOVJyt6ac@shredder>
References: <20231017074257.3389177-1-idosch@nvidia.com>
 <20231017074257.3389177-3-idosch@nvidia.com>
 <ZS4+InoncFqPVW72@nanopsycho>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS4+InoncFqPVW72@nanopsycho>
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 1835f0e5-8902-4975-8bbd-08dbcee8ad9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgfE173nmDOeze4pg8k0f4h2JN/khMTVUJklJnmr5kni1XjJYRvr/P55mR1EKk1berTOSOs4B5MDnTIuabY3YXHRQxwcrtu11TQ/2mqOEPdmFu8O3NO/Cy8bwDr2hEFXlrEQ8AleGU7QHQN7ANapcuDImv1AmBrxhdb3oRNOhxZHYkgUD14sxGI7vAlnjgV5617LM2h+DWd4Ri7TMEoHcnXAk+Pt4C3tYOpPBx2G0bZ+r6ZGezkBQC+KXFMczPHFkIQHoN5BrZCu3SaFKIryZQ5bA/0WQTrecjaqeJLUID5ixNibLIZM0beaU1LV6AgXbhjtFac2G+IwAL0PZ4HhDtkgKFMdPeQjhLQCiJmRuniRVPlJnSZf1GuuCu2b5FoINSqutbk+KI6JY1Z+V4LdnkB71qm8O45GYWlhQXIOXK50DoASoaLs4pQoBX0wtJOmYVqYliFLhPsON8+IcqEXj49mo/UTIESuskndN23GPPZyYQsRNFDINOtVOpIBEeqOcWN+Md0OE+6CK8DqatUFJEU3NjpgcMQ7vOu8Y1735QmGHr0nLEmbYWDeZoCmEcupT2D9S1orF6N5zQWbaOayubh3hCKRY3SXt5z3iLqK9Qfc1XuUW53w2ti3ztofKfPhTwO+IU6eRn9S67RFvlHCOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6486002)(7416002)(66556008)(2906002)(66476007)(9686003)(6666004)(38100700002)(26005)(83380400001)(107886003)(4326008)(8936002)(8676002)(5660300002)(41300700001)(6512007)(478600001)(966005)(6916009)(6506007)(66946007)(33716001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2W44znea0tuJGL/3pr9RSGoda8+gjMEi3v8CvGwDz+uZJdSts0s+vpvKafS1?=
 =?us-ascii?Q?LxuQBknNbbyuhJKUgmxKIsMwp8veMe6D6FtV4nzyK59W33zdgmHu4l/C2+E8?=
 =?us-ascii?Q?dFbUc0wkloJj+/w6mJG9vb4pfWTnWUMiGcw6UuG/+wQaaN58Q52W27igT/QQ?=
 =?us-ascii?Q?VaiQgVgrSC2/LSZLpD6Nj/TRx0h/4GvNdNv9aC5XSYi5L0SAzr7sX1KLeZmk?=
 =?us-ascii?Q?TD6tnskBWbgAQSgDI3OK3nFH+JjbLoiDGZhmM2xyKwVIYUefkS52PSGRPrJH?=
 =?us-ascii?Q?K47O3e1o0Qh7uZwrTxidvffzk+m697vBxGjDwKb59TcOuR8gH01LGGg+MGx1?=
 =?us-ascii?Q?J6USPTGX9QwtZYvEiFU6FroV6vCS5Yj2jMFMzg1zHUVuL3PnwJqwgMRlLYXy?=
 =?us-ascii?Q?0gFc7Rt+vxH6zULWbOzsRp7VmNrV7XRGtialuwh3BJa+TT7wqsz/ZjEGzrK8?=
 =?us-ascii?Q?rETSrKtZyP5hqMODdDs0COWL4b3yy2JVqgZYPc8jKBDz31d1TfMfRkpR6XC6?=
 =?us-ascii?Q?IeZJYrVYKHMZjs3uS/pKa163ltcemiphja0cgR8P1wTCb6Mi0IBhiB7GICMH?=
 =?us-ascii?Q?0ODMCIwl1iTPIpygvJPnPVEKLkw0KeCEAXg67q+RXuV3uFCA6UPEy6z6NC83?=
 =?us-ascii?Q?w/A5YJQPcDtjsu6u1omBITsULEIwKYPlcx1ENBsJ/Kid4voDplCSHEBZt2RP?=
 =?us-ascii?Q?CQntZVfAEZt4feHiG3JUJiawfdj7vRg8dD+y+k6I87GwY3Tc5VNhHmNr8tpk?=
 =?us-ascii?Q?w3N9ZZijru7bS+FrEGHaMi9kujebjXQyrpNww7N3EYeM9HdbPAYWtO06iitz?=
 =?us-ascii?Q?jsTArEQl7qOdP9b6vrEHREjL67nz33kdI7TtB3MABCxhk2z20elsqiw+hIUj?=
 =?us-ascii?Q?8LuIikI94bZPPbaxJRzJV5EcmXpxjk80bNR4HSCaTlZitE5CyDHZ81LaAqPB?=
 =?us-ascii?Q?ELG9RmWMEkMgweMhUMgFxRmaSACAIK6Gpr8MHi7xGZgX7AuTwbkuepGRewLz?=
 =?us-ascii?Q?YJEtePERQRQfQP6bW78AtFPErP3GDC4aQqyZSOs35tQt5jsiMcKZv7B76FM4?=
 =?us-ascii?Q?0wO5tf5J6derf77FwV/IJv9UUdAOEsWetA1mxSZWV5o0lTz/DqwplyR3rEyW?=
 =?us-ascii?Q?AbF+AvNHaNjltVjU+JGqPBsIYO84PUaoSmr1CUP1FMFCwBFn5QjXQuhCmNzp?=
 =?us-ascii?Q?zh2d9kKdMV6oeyolQ383x3GAIuXPEFEuy9oicXyrJyaRz7VYxs+sNWL+1lMs?=
 =?us-ascii?Q?AOBuer0MtlLGODkp7RCSLe5yPUs+I+/MCNc6h4ekZGsnrx/H52c57Cr+2UEM?=
 =?us-ascii?Q?FZrSGPVtoap1zpoiYGlGDrNo4+qOKAq9fTXINKS/7Liyt8rb7BfehMAuzbN0?=
 =?us-ascii?Q?ZfOm9xur2T7UWRFmH8+yz1Cre55bSdE19WRxc/DWk7idk3w9jewNXsBobX3W?=
 =?us-ascii?Q?UH8GiN+oKZd+ZC7gCXU4Ch51V6DPR7Sj3/9uMZO8Fo1uLymTeVC96/iH3eqL?=
 =?us-ascii?Q?6ybv6TYzfC+R7KM6sHwG+qJmcUMo0xRJ7S72erFilmbxslLj/V4wzebOIFZZ?=
 =?us-ascii?Q?pqD9uDl8qm34YN9Cymw/wDmdD93AglLcjozEGiWa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1835f0e5-8902-4975-8bbd-08dbcee8ad9b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:11:34.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nv6ayOI8R/m/YuAMyYuUu1B6YdoU+XCPu5TXSG54iW/7Mdf6mwh3BIOEWJO9SLOoVxPnFdlV6/khCTub2/2e7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 09:56:18AM +0200, Jiri Pirko wrote:
> Tue, Oct 17, 2023 at 09:42:47AM CEST, idosch@nvidia.com wrote:
> >Each devlink instance is associated with a parent device and a pointer
> >to this device is stored in the devlink structure, but devlink does not
> >hold a reference on this device.
> >
> >This is going to be a problem in the next patch where - among other
> >things - devlink will acquire the device lock during netns dismantle,
> >before the reload operation. Since netns dismantle is performed
> >asynchronously and since a reference is not held on the parent device,
> >it will be possible to hit a use-after-free.
> >
> >Prepare for the upcoming change by holding a reference on the parent
> >device.
> >
> 
> Just a note, I'm currently pushing the same patch as a part
> of my patchset:
> https://lore.kernel.org/all/20231013121029.353351-4-jiri@resnulli.us/

Then you probably need patch #1 as well:

https://lore.kernel.org/netdev/20231017074257.3389177-2-idosch@nvidia.com/
