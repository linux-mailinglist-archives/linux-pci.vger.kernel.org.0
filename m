Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3A063FD26
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 01:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiLBAfo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 19:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLBAfn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 19:35:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317AB82;
        Thu,  1 Dec 2022 16:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gkw75pMM2VrcWW639FBSiQDk35StYIzAKzE1DNh/hnrTwf/A/eHhumHca5q1kZAKiZ/HMZVQ653YMIRfxpL4WSfdRFkZqeA+LyRSbvvkhAPL1UY28Cj3XW93vWITbORTcfoR/1jIPe1tza1yJ1i7bXGMQWdHTh1vPzGwcJ3UvBbx2jDIMrLQlBNOA/TJaQduPglJxjqg/hWqsj1tuaTOsZFX4a2jhiZbj17iOnJi/cB/fo0CyBWf3qAAg8pN+oq+dXfh6inX2CbGq0mbuFJm3Q21nNnX2Bned76DUcEeEA5ij1ifHVQ1fBsIShhZFRYuMyie7I68YZ9Ea88chxv2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W15Z2jjFbMbaotFFPhyhXUv2nIet/uzduxC06F3zfxI=;
 b=aSCAiDTz5OkXukDbHVq5mPJYHj7FGwmzLnsyqpajrINpNoDekpQGcW9QZPMWjCnKFWWRiFcdXHNo0vZgwauWTZC2S86Dmmqv40edRFEH60mL5GQoaXTVAeQGREbTw9cfQJHiLhVf7opl9qm4guc4qekAoo2oUm40LrqaCNFkyA9koNPRtBFE95y7AbcdBodiT+ZDHkdAVItO90LD/g8YMq5ajd4DDiGT20X2OaYpHKyR4kVos1p+kpP4jGsTUwCAbZjgr7nPQOZx6FPQuKdfqYH2lFDIX5aDR/aFLo2W3Tb41T/fTUn1zw/rOaTjk00SuUHl9UshU4iAYUjMHFE8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W15Z2jjFbMbaotFFPhyhXUv2nIet/uzduxC06F3zfxI=;
 b=TEKPPldgl4i3Ztt5gYHDe4SP7f6CNKZsjFuJanZjMQjtm74gRiuLtm4fH1IzU99NFfOOdeDE+pRNmntHKH3e0JhhcRBsQXWDusQ8jqn2MslSy0BDr9OUQaXmXODHZFabsa1NKSXuxBy+OPTcgsRLW7xs3z5AOQWTGJ4MDDZ3LPb/YlmT29960qaF4jLBeWrSRE8qgvdKlIqQ7aSpxcQP+EMgV/jZ/Ep4gi4hiPG6S5g+m+j9ly1WooWZih5XxqvpIFvImR6cYXHZ4LC50GYO9WTNmiejYiZkUobv4aB8VR6tGqgnD0VQRi9HCvaT3J9E7P9hmH6MUAi1hN4XJUOKfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8; Fri, 2 Dec 2022 00:35:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 00:35:41 +0000
Date:   Thu, 1 Dec 2022 20:35:40 -0400
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
Message-ID: <Y4lIXPVUSYc48A7q@nvidia.com>
References: <878rk1ectk.ffs@tglx>
 <87cz93s464.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz93s464.ffs@tglx>
X-ClientProxiedBy: BLAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:208:335::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 7193cef1-c42b-4751-8c4f-08dad3fd23cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXv0+AIhCj0mr6HhCFhKJxLCIE86aGEDDDMyq1Z8j+GN473kZKOxjCbKYY3bw0ymB5aZHr7EhJSRQ5Kh8T8SwzoAfU+yKAbRw8dpV20qYIF88llj6KKJzn+Gs2/g6HJ0AfT1QqM3mtQYllHd5Y0XoNbIAXu0qZlwjuKpedEihxHIigKaerHXbbCHJfFDiOFCzPc8SPhONLB4LbsdmaYEVvAhH+KRAyl4sZx818xFQXsdYyws/GMGnZE6UyJSWrJ6EvQOxRQ7VQ2TA4kmzBME7xxZe6SGz8vXwVj8LsuYajlCvkmNFxFqBceQe8Kdg+hcrElxeMWn7hCAkgZgaL0Z2zGZMCnTmaWLYQ8sekL2suygH+fZFwBxT2X+aaCnLOcQmvNHA6ccFyh5IBURJUUmX7ryZFGXlFy/yWFIDp8JGZ8Nu5gkJByNu0QbJPcuIrr9IKd1Af66XtGa1m8oT/PytzZh4CvAIp8l1ACqPYt7mbT8YbtLvCVTx+aVhcP68QN54Hws2CSS9f5Os2VIyVqcoJtDDK012NZ8LiQgEMuv24R5lDjN+YU2rokCOIsXjwyMZxAGYeqwvDCLWXwnB6YLqhXXF15zZYddZ63+y/e1j4r26iGswubnWIkSCRJzv9B70IQPztpjV45ce9oSU15/lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(54906003)(2616005)(6486002)(6916009)(316002)(36756003)(86362001)(38100700002)(83380400001)(186003)(2906002)(26005)(6512007)(6506007)(5660300002)(8936002)(41300700001)(66556008)(66476007)(478600001)(4326008)(66946007)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U74TWBQA8I0ly8BnwK1dPH9+Tj/ulwmw2dyh3PIedoejkYIPQ+Ssv4eE+pmK?=
 =?us-ascii?Q?5jK4d9WIrFctEvoNZAf4CMZrxxlkr7TdOo1gSRtX+CrSWvPZByNBRkEON0Ud?=
 =?us-ascii?Q?Z/ELr4pY+2qMc+Vw/gflVgWvlm5CxxeM4Zeqcm6nTXRlZE6l5XArvOzJ7gOF?=
 =?us-ascii?Q?SBJL9kUWapSZ6uMyruu3zWehi1MYwbZ8Mq4VHyAmbLWKa0tghbM9FbmyJ+TN?=
 =?us-ascii?Q?d0vzm4wNWdSd5838juGpCo6M07uYNW63cUeb5DRFyfIr3ij139oSxfaUkPrp?=
 =?us-ascii?Q?Ma4lJuLdpc/xfkSMBI7sGcIDghcI9FZZhc65u6pWInbdMT/1FwX/XVIm3mz4?=
 =?us-ascii?Q?hym+VLFthelm7sQWMsciOlki1aQJ4Z69vsk6NW+RbT+Zy8bQiQaZv3Fq5lbo?=
 =?us-ascii?Q?l1d/7xR0zqUdS9fgYo1w4EsDd00dav2PkXrGV0E4hT6oBw1ruAngBOTBBlkG?=
 =?us-ascii?Q?4sSXv3mXIQ6MmKwWjVoKH0FC3MgnpWIpIaM88Lwhg+SmmAby+BJKtcKhCsWQ?=
 =?us-ascii?Q?1toIcjliND9kBeGgeH7EPS+uvKA3GZ8HMPks841Mhe3nnsTCWOfDiKE0u6m1?=
 =?us-ascii?Q?plA8yAtgxlOIyzzBHXB5JsGaqlmEI5R1VhQ868idHcVhQpczyZlQD+iZoIO3?=
 =?us-ascii?Q?TbLt1NVKv2nn1v6POq5QvHgIEEN03Lb1u6EeN4n5BHiT8OKJIMTbsPlAg2aX?=
 =?us-ascii?Q?VD/NqSdWU9DNOtQil6Ufd67k5NbbHr9B6xIutDHKAeBaLs869oA+UV20BNaS?=
 =?us-ascii?Q?sfKQju+MvOfYLZBoHz6CvEWYpi/YY8QcUCgzdTOVPnqBHntat2itd0YQMaf7?=
 =?us-ascii?Q?W3vSbHW0KUBHabazfHV45i+VcOO0WTUsod60NlUXPlSNFAPWLRpZDY02O4qe?=
 =?us-ascii?Q?DxB0u+YqdeDrjIElM0MJgt/9Amh/z7FL7D57ouRqfp5dIkLso7GYnuKBso/w?=
 =?us-ascii?Q?AI1lWTq+MZ2r8zERg0QLvEmIdCoth0waAITPNX+pX4RbkqA7URb1EN7QPKve?=
 =?us-ascii?Q?Qy9qJKxcPJXUKofoiQPlKnCw3STXm6rGImgvysH2vcg6SljbaI5A0Pcn7f9k?=
 =?us-ascii?Q?gHplDds7mxK8bGgr/NHwrNLUIJpDgbxFxapfiAQMuPGEMTcn1KFgyWV2MvCZ?=
 =?us-ascii?Q?Ym3l3wuydpn2bB0GXKRQhDtBtudT8c3kG/lTxV7Ts0J90OUYsh0uvA9ydH/C?=
 =?us-ascii?Q?RC+ptHFLEanUNGTYmODRdWbXftW0gO59U/jQXgWbspJYLxCloBU/X+huC9rj?=
 =?us-ascii?Q?GRNT1lx8KD2I8zBD0uMPeuvwG/vLh5a730FgW8ekz+IkFRSKsUV5JP19hSHX?=
 =?us-ascii?Q?Ri4Pyen8nnIGGTHP8z7/tvc35cPhh5dpyduRggHMtqrmCbXf9tyTx8dw7NhT?=
 =?us-ascii?Q?la1yubHgG6kcMDlDgZuzET2ZeWybjkOfYOhbZzsPts/8JbYSGiKMHxBMhJ6f?=
 =?us-ascii?Q?7P7CUZt2tj5T3HoMx/C04fN9EZPq2LzdA01Q9TVLljI7QvqrFlDz8BDsCVW7?=
 =?us-ascii?Q?njP1cUCxwHBn7NZvxCXMldFiNYJMJUaizefa3ikp9C65WTw861NoN7IDR/Zt?=
 =?us-ascii?Q?T+1y8y4VQaKH77qcqPw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7193cef1-c42b-4751-8c4f-08dad3fd23cc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 00:35:40.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CggbyDt2aziRMqdZlfO9z3dEFn2mjnIvZlGw1z+tH1tR/mFji7iJhCPy4sS3VTdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 01, 2022 at 01:24:03PM +0100, Thomas Gleixner wrote:
> Jason!
> 
> On Wed, Nov 23 2022 at 19:38, Thomas Gleixner wrote:
> > On Wed, Nov 23 2022 at 12:58, Jason Gunthorpe wrote:
> >> I find your perspective on driver authors as the enemy quite
> >> interesting :)
> >
> > I'm not seeing them as enemies. Just my expectations are rather low by
> > now :)
> 
> This made me think about it for a while. Let me follow up on that.

I didn't intend to pick such a harsh word, I get your point.

In lands like netdev/rdma breaking driver is unhappy, but we can get
away with it because most people don't have systems that won't boot if
you break those drivers. The people responsible will eventually test a
new kernel, see the warn/lockdep/etc and can debug and fix the problem
without a huge hassle.

In the platform code, if someone's machine boots to a black, dead,
screen you are much less likely to get a helpful person able to fix
it, more likely an end user is unhappy their kernel is
busted. Especially since the chances of a bug getting past the testing
basically forces it to be on some obscure configuration.

Due to this difference I've come to appreciate much more putting
stronger guard rails and clearer design on the lower level
code. Supporting the long tail of rare platforms is difficult.

> What I learned pretty fast is that most driver writers try to work
> around short-comings in common infrastructure instead of tackling the
> problem at the root or talking to the developers/maintainers of that
> infrastructure.

Yes, few people can tackle this stuff, and there are often interesting
headwinds.

Regards,
Jason
