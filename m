Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C183441FEC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhKASYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 14:24:24 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:65248
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhKASYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 14:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK35FHxRpulz8PCPtC8ljkEeRfgyFkl2wGV1ZjbsTw3nrAeVY25B6abMm1YsG9h8TgBNCrVUo0/pza0+oteRMqp6Rm0WUcoIAfQS1/C0uQh0A1zmNW/8n22KoBuU9rj88nl1QKsZfVStORJ55j5PZUN1PJiUIyekfiGVRU31ty8B76tf7Gi0fZ27x0wN1AblUvrJNdvQ/bEO9ydFOZjWNE25l0MaKWeiPZTvtSCqTYG+XR0y80tBAh50ES/o5CSuK7rZS9OOUwVaP+YLlaUcVOR+wUmVS6lOlEd3XPfCIbSHfdfzk7cvPg/7ADbknRkGm2rf+n3U+SaqyH+0l40PuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNu7/3hRlc6Ufgn9D3PHykFgnyKTWnRC17mkwWP7n/o=;
 b=gcgYy4GB/yd5VsbISYmTJ3M8YicncJ3MC2RGMIcxd/5xg8LnP2jxLGT+HnfqlpZjuyr/KYGJs25SXy6L4PNv7gyNl3QhXm40SJl9UFVAn3zi/yhwAIBdGheMjHQHN5UmdS3UjXLr/gCYlnuDD7f5SpZYs34VpjPEUq52kYQYSFt6x1oJlsgQCu0Lb4L6XY8uYOHn/9wPG7Wq0H1+cNYW+pO3zd7eyYqBvr8YoZbTlMDYIn3RE782FY/IweXT3LLDWuFeXtyI7GlCjPMlAZUHFibPsLGqmOa7iugVw7jCNl9tK6hriSOr6pZ+L0jt+77tEpwOIsOYSmOdpOYNeH8wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNu7/3hRlc6Ufgn9D3PHykFgnyKTWnRC17mkwWP7n/o=;
 b=B3MraNbuxmnll4xE8g/RiD+V7ENrpP4/tK9bJt3/hsVGQH7HxRP51q8uS/omqbjaZEBfOPmAhuP+R0vSKqJoMODHUBxSjqYD0td1w53r/mIDf1xTIgAsDfbXCG4ud2ei20qE/906pin/11QhHUjlZss3iylQNUahPX0A3z4XrvfanKsMF77Q3UQ2viNKgLgSLvcByj7q/LKJLE2RB+TVQKkqux6JhKbCNzQUfGS3yLj2mE3tGgxdMO5+KAyjkwSXDRFDxini2ChxudGeUiySp7xgBfNaQvVpZNXD+aG2LwpfR9YB0bS7fbzTBRY/tgjn+z4cY9PgE7ylX2zl6fPwpg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 18:03:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 18:03:15 +0000
Date:   Mon, 1 Nov 2021 15:03:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211101180314.GE2744544@nvidia.com>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211101162711.GA2744544@nvidia.com>
 <20211101175649.q743eg65jpjtk7sd@pali>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101175649.q743eg65jpjtk7sd@pali>
X-ClientProxiedBy: BL1PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0153.namprd13.prod.outlook.com (2603:10b6:208:2bd::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Mon, 1 Nov 2021 18:03:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mhbeM-004q7N-N3; Mon, 01 Nov 2021 15:03:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 072cbb6c-8dc1-48c6-2989-08d99d61e0b5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5378EA46DA55FFA67F56B2B3C28A9@BL1PR12MB5378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71wBBFhenfpZBToqmc456nfQwJbxJXwOXUqnSYuupNSO4h/bPMhs/b91F1rDb5gWiuGrdNJLBt9WGQm0qy5eaJCG6AQXiMkOcvLrN/5H4NioclOtEfIUquArOOKQgGoO/cotPWGDUAjEtZlB7tbs6Jo64DAKd2lSBHSXEN0wFjAHfevFm03U+eGN5GDGpidgOmwQ6tiCAqtlXEdQPoYgosJD0ErIED5EaSnGQXMB1nOhqHwdWlTEFLIVIkNOxLIVnazR/NBOZ0v3AKPsmL7Fisig+prT8hm9pUwGjVGP/bEu/XNWCbvATNjsYLcu3mIGCWKAeC2ayUhrOL+yAS43s+MSyaOsb+JR6lFIyzW1q09UjRs7av+CcAIs6duKexZwA0l89gRq3IFM5dtI3hmuWxzEq65Cj41N8iAiUKIXwKYHgkJFXLoWP5b+sHWBPITRGmK1QMiaid2B948ZxQvb1xOTH4aosA5PdOYEaLkFfpwHoeS+EZlHMecbcjRFXUQatdWt8yZpWMieVQT6PLGucub8+vNvBf82Z4o7SdRoCO9C2nF2wqVOp8KMgcvH/6aA1XiQER5U4+bpxa2szsbkzrS69RXPTCB/cnzcdsGlUjg/oNFE6fzqAZsN55S9Y7gd6OsBje3RxQxBqoyFwJPBY4Ix7pIiCZ+637budWOTL/zwTfXtTFVWymbb9BtiwPVYYq8rN0vfKVEfYGXF/zcY58MkoS3XNLyuFmZlNiDIuu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(83380400001)(7416002)(66476007)(15650500001)(66556008)(966005)(9746002)(33656002)(186003)(8936002)(426003)(1076003)(54906003)(26005)(9786002)(38100700002)(2906002)(6916009)(86362001)(4326008)(316002)(36756003)(8676002)(5660300002)(66574015)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhHWTJkL3dCbGFGcTVENm5ZZ3ovcy8xdE16a2ppTlJNMTNUdlA4T1NDWHFz?=
 =?utf-8?B?RHIvZXBMQVZqZWxhUjcvVUF3WktSQjdVNE5XNXRYL2hRdER5MnpyTEIrdnJT?=
 =?utf-8?B?T0VFdG9ySFRzMCtESnVSWmFOTlo2WEpTaUxhQldFVlhOd1kyRnJzYjdmdWlF?=
 =?utf-8?B?bmhQNjNwa2MwZnFwcXV0TlpOcFlpOEpialVVT082TTM1cENiZ3dNU0F1cGZZ?=
 =?utf-8?B?aHhTUnhMd0hlaHdzb0pSMWFSRWNnV0lVK1Q3MFZ2NjU0clMrTUpBbVF4czJs?=
 =?utf-8?B?SER2WFFFSTVsNnBkWGgrUmpPS2ZMUnVTR1dmajRsS3BsWkhjTjBKbzFWUmln?=
 =?utf-8?B?Sm9EQk10R2w5Q3hRcjMzUDhicEtUc0dlWWdWSENvTnllL1BJRkhaL2lRRjNZ?=
 =?utf-8?B?TkI3TldUWWZkMWJMa3hSOVFOZzJhRmIyNUxyZFN2WUY4OEtlZXl1WGFoOFJU?=
 =?utf-8?B?OUdIVnV6WmM0cTJjVndKTHpIVUNtK0pxNHlDa2hVNHcyT0hTcHZMcVZwblpa?=
 =?utf-8?B?eGpFdkRyQWwyR2VkcU0wejlOMHlGckxnV2pXR3MwTjlKWWV5dG85cUtnZU8r?=
 =?utf-8?B?RjdHd0d5VERJVDd6U29zYlE2WUJqQUpEZHhyRXVMUEpac3pVRWFkQWthZlZI?=
 =?utf-8?B?NHRFTWlBNXdsRnc5cWdWK2pScjBoQ2ozSGlNeFBISmlnSmJJWHZRdGwwbG15?=
 =?utf-8?B?N0FhK2tQOHk1Q3Qra2dVc2l0cXhVWnE1UUFoQS85ckR2eXNJalMxN01VZHBB?=
 =?utf-8?B?Z3JvejdkRlUzczJ6VW44enhoSVBkUHNUUXJpV1dGSHUyNXo5SXJhUE82cXNi?=
 =?utf-8?B?Ky9PVUoxNlJSRm9DVWRsbjRuUi96a2QxMUdMV1JiOWNZMXdhSFl3NnI1WEpu?=
 =?utf-8?B?U2tiZTlOdXo5T0Z0SUl4V2pwUG9tNDBva2dWRlB6SHFkR0srNU5VenFGMk0z?=
 =?utf-8?B?ZzBiVFYyTGdid2xGU3NXdFV0UkxGa2R4K1Q3VHIvNGlSVTREMzB6d0JSaHQ4?=
 =?utf-8?B?c0tzbjB5cFZqYW5ZbUYxajY0OHoyaDhoZmZKMzQ3amxXOHUrUmpUQXk3azZk?=
 =?utf-8?B?cnROYjZueDQ3NUIrdWNSVVBOOVNZeHlRTXZkOFBqdXc0MEp0dE9oTStVVVdy?=
 =?utf-8?B?WkRzZTN1OENsNlpjQXhhVGN5bU9sdWhiZDJBOE5PUk43MnNtdk1xR2pPWWJC?=
 =?utf-8?B?U0dGUUtrRGliVHJCTlRqNG1KbldjSy8wb1BndDlEa3dGalZWakRrVkUyMU5n?=
 =?utf-8?B?R2xHYjhBWm45REFNQmpVZStMSG9WWTdiTmJyajdZZ0pqa0YxQlJLTFRDdmlD?=
 =?utf-8?B?aTVhQnhFMXdXQld3R1UzcWdLZWZ0aDZ0RG42M1hMVkRVY09lRm9GRnJ1bURG?=
 =?utf-8?B?dVpjTXRwQWFoTzQ1UXMrSFdVZHZmMnRmN2NzcXh5OGZhaUxCeDJTT1UrMzk5?=
 =?utf-8?B?aERhajNheWIvdjlKaVFNRDdLVWFYU2c5dkpUbVVITE1lT1ZMTHFjZFVrenNR?=
 =?utf-8?B?R1UrYzdQWjg4Q3R4Z3VYOVVBU3FXdm1taTFUd0hTOWJCN1V4QTdpOGNwaGw1?=
 =?utf-8?B?c1lIYUNyM2pnWjZxVTB4SEhPam1rTXJ4YVdZYkVlOC9lVHRnNHlJOXd3NVJH?=
 =?utf-8?B?WEFVaWFpQk9jQ2VLSHlYaFhmVmFHZXR2Q0t6eVYvdTVEUFR0eUxYMGpLUU5I?=
 =?utf-8?B?UVIyYVRiTC9KR1JndUdQWTF2eEJ4c2Q4Q2dqSllSVXF6WTFoVnB5a0hsWml4?=
 =?utf-8?B?UzRJK05jTEFSWXdXeGcxRE1TUFRlZDd3aHJqejcvVjNsZWE5MDZpTGFyWFpq?=
 =?utf-8?B?T09aMGlZYWRNSStkUnVYTEpRL0tHUGEzdWVnMnU3SVBpMmVWRmhRTUdQWFg1?=
 =?utf-8?B?L1o4L3F6Wm54Wlp1QmJ2YzF3YmxOMWQwR09sR25uOC9NSUV4SHpVR08zTFZ0?=
 =?utf-8?B?TmhiNDloa0QxWkx6RFdJQmRNOS9Ub0dwb1pJcWFLLzgvS1VXNzNNdlV3WGt1?=
 =?utf-8?B?Q29ySlViT1hzT2ZzK3Iya3BoQkxHWFUyaTZUVTJJV0hIdlRVd2duK0FpcUow?=
 =?utf-8?B?Wll5UEh0S1ZOa3p6QjhwbHpibXNuQ002YXZ4Qm9UVWVnanVsc0NtSlI4RnRr?=
 =?utf-8?Q?Z+0g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072cbb6c-8dc1-48c6-2989-08d99d61e0b5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 18:03:15.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cls5k4KgIYefZrULGpZb/ZdxslNcGF9iuEuctzgqVnAttqi/Rl02STUr+5szP1rj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 01, 2021 at 06:56:49PM +0100, Pali Rohár wrote:
> On Monday 01 November 2021 13:27:11 Jason Gunthorpe wrote:
> > On Mon, Nov 01, 2021 at 04:04:05PM +0100, Pali Rohár wrote:
> > > - The code relies on rc_pci_fixup being called, which only happens
> > >   when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
> > >   this causes a booting failure with a non-obvious cause.
> > > - Update rc_pci_fixup to set the class properly, copying the
> > >   more modern style from other places
> > > - Correct the rc_pci_fixup comment
> > > 
> > > This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
> > > PCI-E fixup") for all other Marvell platforms which use same buggy PCIe
> > > controller.
> > 
> > I wonder if that code is even relevant any more since we started using
> > CONFIG_PCI_MVEBU
> > 
> > ?
> 
> It is (still) relevant for platforms which do not use CONFIG_PCI_MVEBU
> yet.

I think you should explain this in the commit message

> > Really, these broken controllers should not be used "raw" but always
> > via their special host bridge driver that fixes all the config space
> > problems.
> 
> I agree.
> 
> Long-term goal should be to convert these platforms to use pci-mvebu.c
> driver. And until it happens simple fixes like in commit 1dc831bf53fd is
> needed for all affected Marvell platforms.

IIRC all these platforms were obsolete before I wrote the above
commit, so I'm not sure why this has suddenly cropped up?

If you want to use a new kernel on this really old HW then update to
use the right PCI driver?

> Some details how these Marvell PCIe controllers are broken is in email:
> https://lore.kernel.org/linux-pci/20211003120944.3lmwxylnhlp2kfj7@pali/

Yes, everything about this controller is broken. It does not function
properly without its driver. The solution to these bugs is to use the
driver, which was specifically made to deal with them.

That said, I can't recall if this driver needs some fixing to work
with pre-kirkwood systems..

Jason
