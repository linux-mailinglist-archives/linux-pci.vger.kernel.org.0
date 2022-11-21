Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2500F632ADA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiKURVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKURVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:21:14 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DBBD29B6;
        Mon, 21 Nov 2022 09:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhCWPS4BxB5NjgQJVET9e+2twuMC7fcE9A3TlWgZH5tkRtnFMZLybtxkn1S+4xSUeUeEVyVPHka8kXmJS0kuUQxDL1Rqp0i0vg44GmbwSn+7K59FO22amQ2IVsEWIntTgcxxLlLMuUWEAFnI8Ghh7YHtNi1dJ2+RLWLiiPcGBQ0qzzZEv/Y/scrKbLQL2q1nLxlR2UKBHyX+z81h1M14h2c4rtSwmdn9qhxWWGavgkOYDakE8nyFoWcsDI8Av0L7KgXq6Fy8yramGq5UBAkIqQInbi+cPA2uo4AbdCwNvA6vD/CM7xtJA7auE6LZhZcN7cQ4RSNn3uTFOGQWeoncMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlutBJxvlvzHUj8gwPKI9qiwRfiZV9chrM/fPFsNBfo=;
 b=EovD/gJj4VuB+zAlLsaw8bwa0/Qn3xesfsQMjRC9yGwLOeSIPt7fXRcZd1M0abck7p3ko/CfdPG5Zs5CXalysAbax4tmAUxTUnoBMrbYUQoYlKWd4/7JGVCqNrmZqj+icZFAnw80ArmiNAwol67htwhBybGcomr0+4olwR7pCrrnQpcw5Sn1liYLuO9/LCl1tPzkOhTNCoh2BjIoNms41EQyzLHVYFj+yvSkiP6B9Vp/Mx0XtREr2qa2XO/FJviZ8/aexc8ejvUzw1qMZSsVoT9yHw6grCIQ+RzaNbn1TNBYBL+EneMtPTntUW+NzzSlQNXGiniebU8TCJkzs16wTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlutBJxvlvzHUj8gwPKI9qiwRfiZV9chrM/fPFsNBfo=;
 b=XuBK7axY2RYS7806cpk6eT4skiYZtEwjV/F+rTvIna8kK860zAKF/Xe2lTywUX19aNjv2pAJO21GtXiy+/zmhaoE/CP+LVySMaVnXoFLxQLso2P6DCfaksoFnvdruiZP+D+PAieD129yWTe3vQjd9gU+DxtkcC6DDt8PlTOFShRL0RIaMdnjV5MdDPxUOXpU7wUaPN/HR8dqA7FwrZTdmkO+G4Is48iceUdttU602jQfIEynoLLgcMN9SRntpxpFxNUh9S5a1YYNGTMEP3bAHX2jWSLdBJKSn0gXN3Hm5xejamZEtGQ6WxLiBnAcDtf/YUx4+lsYBGl/s0FU1/y4XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 17:20:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 17:20:21 +0000
Date:   Mon, 21 Nov 2022 13:20:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 19/33] genirq/msi: Provide msi_desc::msi_data
Message-ID: <Y3uzVJ/7ecL8DBK7@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de>
 <Y3U5xwujkZvI0TEN@nvidia.com>
 <871qpzkj9k.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qpzkj9k.ffs@tglx>
X-ClientProxiedBy: BL1PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: cf30c9a6-8a13-41f9-fee1-08dacbe4ab89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5H8OOV8XBWGT2xA5E2EPmRy4ZgiiARRBO55FV598UFeBW04aEw4gy10cY2v4zA3WvegUoeerIPuduSsinfLIZe6cN4c9SyrQWT1Wm7CXOdb3jcocVjgGTUpdJ0Ee5M3JtVLkte6t+mOnq6uPmCL0WtgXKfCc+9EIC2DZ/GjKLVaj8pYMhrNHJs2Yb7cs/rzAiBpxunvHEnbAvLqNb8wY2CsYZNfMxWfjaAf9i07hSvaKJpJ1cyu4gxpZTZ4lxBvqQou63ubXt/AXpADLhiRmrAAMDlt1/raubnn/c4UuclEc4DcKsJ2L7SEYd8m7DdSJhG1YxBbTLDCvcS2kbu33nflTRPAN9948yU59cUqEiTuZtd3gotoFi5ZNIdx7yNFi60Ta9WshVWfO5ZwZiii0l4bLpKdlfpHFNupUcwKGJwVElUY1Sf47sWgfu88SRppXsRT37vRSI0mMa1CaSEJIQUSHNQcI/kBM8U0tkWkPsDFoA49dCbuMKL+pr0dB2sXPEJQnL3s37ZMxs9toJImL7kMf9f4ywTR/IqFFT8diFmblci4LM0iOvo3NQANRZbOvRXKSiTLDy6w85KGdPCY80wQDVwHO3VP0Yq4pQOQCErCUJLmqR8TS7Gl+5XiIe/K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(478600001)(6486002)(66899015)(66556008)(36756003)(66946007)(6512007)(41300700001)(8676002)(66476007)(4326008)(8936002)(186003)(2616005)(26005)(7416002)(5660300002)(316002)(6506007)(54906003)(6916009)(83380400001)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9SxHW9m1aDe5STSjxD06eugs9Tf5VJWkZZAUgZrHXSHuB7dfQlUguN+URS/z?=
 =?us-ascii?Q?o/vVNscCeK4ia5CtdC4gvqUFZr6JaW6p3Z3UDZ+v8egxi9foEwoq+K6kskkI?=
 =?us-ascii?Q?NHUQLUNiczJrXn8nXAeGcX3CFZwwTJ7v31AiVy0fhc3WfuF1W4cl0tNEY0sI?=
 =?us-ascii?Q?hA46mgiWr2MDdw5YL6NtKvFXWer6JxZBXFL80HBsIcp6VL8rq6bkHqBz4d5T?=
 =?us-ascii?Q?dIE6ypOvwC8rJ89fa7H94j7H021xg6JmAbX83/+tx83/Sy0qM5S4flfvzKd7?=
 =?us-ascii?Q?Jo/T0FYZT6vkloVK1lEkDejKJE3mx7PP5jMQlneD3z9vcajEaJWs96gEqxHn?=
 =?us-ascii?Q?+O6Ri6Dj3ouhdd0hbOB5jF/0IXkr6Gby2qK7V9Rx87bK/2EWJe7+8kiaoxF0?=
 =?us-ascii?Q?WkYtBWtd7xJreF99BeCSvmuQPU4mJ2wNrHFLHAioH4mmJvmZs3BKTCEDDm0r?=
 =?us-ascii?Q?KxNLSO3t88/vpud1jawn4ya8jdEEau/gH7uYiLx4U/S3fkSeYFw4maxm1ezt?=
 =?us-ascii?Q?6IOxWP8WV1xbNfbPTRqxvBLdv99KvFo4UolJaQ6pp9s+j5QUSRscUoWy9Ns3?=
 =?us-ascii?Q?hsm/UdQFXNE+OjT3jJrwWyWlNtVvj+Z8QOj9dYE8G1+P5Xpcyd7AKrQsbAiC?=
 =?us-ascii?Q?bqkUgTN3CGIipw401jnBgmKG0cvLWTpam92sZqXPhqHthtBvzvCiEJ60usYT?=
 =?us-ascii?Q?G/Z5U7X8jQ1qF59cmBmizbdYr8EdiLn0bK2eKpBQrvaZrrPx77wXrIoFj2AM?=
 =?us-ascii?Q?EZtgTbKU21dQd2DrqMyUKstFnNIOcZ7darXNBEAYXB3Z/d3K3UGIbTArX9LV?=
 =?us-ascii?Q?n5BpB9gHIJxRkPPko5tgBzUx3z8ZNzwG5KDwdj7XaVCByNFm0OzRVveVImI4?=
 =?us-ascii?Q?3o1kBsu500YykaZxh1dQWZxP5SZCCDI27CME5+udmbJYNQ8mPR00WywyLK3z?=
 =?us-ascii?Q?DeHdc0TcPxfA6ZLSTTtXHRnc8m9bUuf9MMV1KnEFdTPgTvxvxwQGxKREq/TM?=
 =?us-ascii?Q?N7PEFXCXz/n14GT2sGEYC19ewaB31XC4wzfZ+JqTbpCZHVPzL/R9ZWHYCKXC?=
 =?us-ascii?Q?RApgwmreiooHnxK5kBTz9juzdTmV1mRH5mbP6uoWXTWUoirTTMihUpnsPdQV?=
 =?us-ascii?Q?XcCphz7vYajBBkjvtof+5lIkr9m4RDkum7epgkb2fy7hC+LD9fR2OVGSO+wm?=
 =?us-ascii?Q?R7XXP5kVGKZ8/FZSr/g6rbmt4/g6qEImzoQUf7eqJNaemfOxxxfD73TyNS9y?=
 =?us-ascii?Q?TRrE/ZmI+c+aredRflmkP7nNUx+u0rfh1Iwa/YoY4OcSWAHednXJ19Xo74vx?=
 =?us-ascii?Q?SKQkWIPVEL4McOhyuW4wIo0FDIz+3yrdM3Ke0SAWPn2ok4g+scLZNIbZQzq8?=
 =?us-ascii?Q?eno1K/0gWhv4SPJLDy3GHsIbQNLmVcn2oX2N//vXhqe36IbkNsSI0kS1oDNV?=
 =?us-ascii?Q?h+aBFt6vmSnKINelZwTknqmo0azEvAdQwS96kYI8R1HsmE+wiGhGqVy7e7Jf?=
 =?us-ascii?Q?4+Y1SxpNE+8cACPLbw5zymf6Jj9i0EG+yUCaylRfKSxYBCaLRwltATIgcnSV?=
 =?us-ascii?Q?UyUqRYP4jaR7ghhK1PM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf30c9a6-8a13-41f9-fee1-08dacbe4ab89
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:20:21.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISAGbCI0Tr8TpbnVp5KoJDE8dJcBjodAh2+W/cxmcnIkBqUQXVS2jVMLGu86j2dB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 11:08:55PM +0100, Thomas Gleixner wrote:

> I looked into this and it gets ugly very fast.
> 
> The above has two parts:
> 
>     iobase    is domain specific and setup by the domain code
> 
>     cookie    is per interrupt allocation. That's where the instance
>               queue or whatever connects to the domain.
> 
> I can abuse the fields for PCI/MSI of course, but see below.

I don't know that we need to store the second one forever in the desc.
I was thinking this information is ephemeral, just used during alloc,
and if the msi domain driver wishes some of it to be stored then it
should do so.

> Sure I could make both cookies plain u64, but I hate these forced type
> casts and the above is simple to handle and understand.

I guess, they aren't what I think of as cookies, so I wouldn't make
them u64 in the first place.

The argument to msi_domain_alloc_irq_at() ideally wants to be a
per-domain-type struct so we can folow it around more cleanly. This is
C so we have to type erase it as a void * through the core code, but
OK.

The second one is typically called "driver private data" in device
driver subsystems that can't use container_of for some reason - just a
chunk of data the driver can associate with a core owned struct.

The usual pattern for driver private data is for the core to provide
some kind of accessor void *get_priv() (think dev_get_drvdata()) or
whatever.

But I do understand your point about keeping the drivers away from
things. Maybe some other pattern is better in this case.

Jason
