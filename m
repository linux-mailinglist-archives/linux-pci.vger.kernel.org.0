Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5CB58961A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 04:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiHDC0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 22:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiHDC0E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 22:26:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783763F2;
        Wed,  3 Aug 2022 19:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4zjl+8p3dhW/681tevWjQZbJ12UDP8PI6AdIrLalTpaiWuY7cCVebS0PAzmHbAeI6IJS48oCM8jgBL3+XyvCiEHOd+PTmrUHFfBnX3iyumPTgNKh6gRJjMcC6vv/ZfBdF8obItyzkrff3A5YmY8kqg/Z4qEEX8xVaepTlhdX4sbPdiwK4+V2kML8jrFBJ0PwhlEBO0UGksPCa4aVtfawjTTjyXDH5gvtaamZuOp4GhbM2fuNWIQrEmiUVqgwbjZausLInta5lXz34S9Xsx0+0fj8DJTll2I0+g4KNOJ+4FBfh/uKk7ncJW+A0ophRWWWnks6zT4uzcyBbKiwfB7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo5olsfAJ3/iCAzn/sFh1sSP1oPuxWYWXy+loj59HSg=;
 b=MuP8HDImwaTuH0qim3DG08KOsa4MrpaCo28v0wtV0KBqdmcKGzUaJomamIzm8evsbLXupUXR5uUp23fcpnvr+m2zRVFw/8W9f6UKo4AqdekwuLmhdglDbCMGKwLtdo2cTNeZeL66nZpc3po2CQXUn2297keTm/a0Mngp44hbnqd73AhGeqq4ujBSNkrrx7zElZnJr0H9YXAvt7LmwnMEVstVclkq3M5cmgJkXhI6oiZlAdqP0WbA3eLTfGb/y8/W1JZWqSp5i6ncW7sg1n0G4NhZeZdJLrlrOkTfA8R9ZZHrXgNhAIBT29q6Q1bTeJo/tw5x+zS73piAgrK5qtvuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo5olsfAJ3/iCAzn/sFh1sSP1oPuxWYWXy+loj59HSg=;
 b=AGbxi1/lRetJH/p8s8tXI/gBHazZ6OAGrG/oNYAUN/Od+rdL97LeMNFBfoQhskCjDAmcqrbFmSW3VE7AV0oTYn73X/mHKoWWGV4rwoCHkUDiKPyC8kbf8cKntuNPC7CQ7MzVdmLKjSU5+q3cpp3vb+d1K9+9weI2pLi0pjBWlPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6826.prod.exchangelabs.com (2603:10b6:610:ed::18) by
 MWHPR01MB2253.prod.exchangelabs.com (2603:10b6:300:1e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.14; Thu, 4 Aug 2022 02:26:00 +0000
Received: from CH0PR01MB6826.prod.exchangelabs.com
 ([fe80::d68:3d30:ca66:5dfa]) by CH0PR01MB6826.prod.exchangelabs.com
 ([fe80::d68:3d30:ca66:5dfa%5]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 02:26:00 +0000
Date:   Thu, 4 Aug 2022 10:25:51 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bhelgaas@google.com, patches@amperecomputing.com,
        zwang@amperecomputing.com, darren@os.amperecomputing.com,
        corbet@lwn.net, yangyicong@hisilicon.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: fix the invalid aer-inject git tree
Message-ID: <Yuuer5vV4r7K1m3D@hsj>
References: <20220804094755.1885603-1-shijie@os.amperecomputing.com>
 <4503fbf0-aeda-8e85-432a-8808f7312152@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4503fbf0-aeda-8e85-432a-8808f7312152@gmail.com>
X-ClientProxiedBy: CH0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:610:11a::14) To CH0PR01MB6826.prod.exchangelabs.com
 (2603:10b6:610:ed::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d998aa1-d95f-485b-168d-08da75c0ab81
X-MS-TrafficTypeDiagnostic: MWHPR01MB2253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLw+RaVS8akZ/4gX0XFvgX0MjaGXDMZ7Srtc7QcD8cqQBS+c0seEOVpVrWuNFWvtZYBn9sLCKpU91t0804Szf6EPvV+HK3OFi1fBFl5jL8V+lFeoZhhZp053pLVLBt1rvyG8GDJjermFrw/bJkfn5SO0sKyqPu3l2eauz4/rQl39UeN/b0Kylkge0O2KEvZey+KZUC2OveuRQtQZN0MrtnRyrH/YMoyINfCEbIgxM79q0lqDnjYumzUoXLU4j9+PUb5enwwkmn7NHDnDhtXBS3YWSuGqaDbJjZKxcC12gYyQsWakst0gBC5B4m367KX4MNCCjxfUMLRS7qKzX/lBM/pyfW9p8FC+H6ebzNgoFQaFvlp1I+AIbn5w6JCWi6YiDNKBoqF4dM3JABr0MCFqwUHpiNqvNLbMDhdsUmswmnoy78QkA7JGkT4ksSTIoxBUWq3uOd9pf1ASjRkx0UJ284XWCK+dZrifYFYUduKM/vLNT8JRDQWvjhXNFh1KQSvPe7Bjd4mD+2lz2BOq5PyafkLxeQcueOdo3qmAONFS6dvhwd1E1eGUfILHaK7ViYrOgQaI1P5wC4sC0js9Q9NIvr87QmwZ7zMdLKOrvqEyu0PMSKuYbvgUDFBYhwh/A2Oxh5x+iy4kKNmvi/hC/vIRfxuHBTxP+ZXv4c43NQx0nlWXHVwQaRYSkajhWeiJ68PzoW2CjFKZPVH1pzqMO1mwOeUnyrTVnCSyKEVNTe3tM0/Gaql39nq9EiB5OalvQk/FIy3Lk3s0b993L2SiOpkvbx5JChYghWezrjIA8Tv8o/kJ52r2Ec9uY7SeguWjjtlgOPB/e1GsjsF9SFn3hYCbsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6826.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(316002)(6916009)(6666004)(33716001)(6486002)(4744005)(966005)(8936002)(2906002)(66946007)(66476007)(83380400001)(41300700001)(66556008)(5660300002)(186003)(4326008)(9686003)(52116002)(53546011)(8676002)(38350700002)(38100700002)(6506007)(26005)(6512007)(86362001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?reZd/v/S+3HmPm2ScHthzO5cKBZn4EWwBXFa4X/+HS6s8H8mD+nDlR4BQsqa?=
 =?us-ascii?Q?Dccb4AlqCcZ7v5ACsrYzh4oDkvXJNMUSZT7flCC9iW+NJkogPdqK/5Uk9wqJ?=
 =?us-ascii?Q?Uh6OCMkxe8VNaIPa7hGqIkeWt9LeFguXsznenjZsy9Hzl0zhXE0hNwB0g+ZE?=
 =?us-ascii?Q?23yOCk2NUR0liiW7hlOgHmI+dMyYc0eTB3K/Z8LTnOU+04EnFQgXQoB6qvm6?=
 =?us-ascii?Q?8dsH7jj6aqnYc2RLYLcVpH1u9pwamdE25atKImSIu4N69VrvfRAXKs8XREHy?=
 =?us-ascii?Q?92sEBIibFqc65VJUYTBJ5yS+28lM5QKV+0kLh9p3MtSXkPgrVU5mUOyGLdzd?=
 =?us-ascii?Q?pfUr//VtTq156xpbav1hDY8mo0hmd5LfWtjQ4+ohfJEQLgZQIj1sgY6IGy7Z?=
 =?us-ascii?Q?q0kfDm+VbgIgfr3MClFj4nZmJeWJYwZXJcH7HXSxOzyXAfBXQiFd1hS+4zH+?=
 =?us-ascii?Q?lFs0HGKM+8zz9sSH4bU2essOiDj6uvuQ4H4wBhstktYmhGRkc44q7uXgXOHP?=
 =?us-ascii?Q?spqmb+gzkfP8FidYP7LMPx7suxOMPzRksgUolL+YN3dbPoVOX+UJQwK9xzUx?=
 =?us-ascii?Q?BxOY2JDrcIg9VvyI36Kt/Jtmx5QsA6dpWnTL6xm7XfOFWzDvPoHgrAcjEAus?=
 =?us-ascii?Q?E7LPMj9C03kVj5PhMRvU4uQBtvArA2gR5ngq+OL4R2Ts0kgWJa21HutcZuYZ?=
 =?us-ascii?Q?8qUPuJUh9qgUmA901VVfl9eFyEcb0IKmrw6PXN0mH1ZwszTR2a0FVEDIRIpK?=
 =?us-ascii?Q?h7UABp9c8SyOqYfN8XK1TvuTAT+C4IBe4S/LPUv9wXHNJPmUcFGx9RfXrVdA?=
 =?us-ascii?Q?5rQZztY/1Cr6oYCqCuU12qIVfOu9Pfz3HQ00u0oIbbNTjqkXh7IERHh3mRGv?=
 =?us-ascii?Q?Jk30JA1E0GuXqkUymcdln7/316minC3UJrf1781m8hR2EO/TxygTLJGR0oRV?=
 =?us-ascii?Q?Tl/NfQMDzwFKU1OXvlR0aQWx2r37vu1C0/HEDpiLa0KmW5fe85UmJ0V7+H96?=
 =?us-ascii?Q?MZQvpVdj2zNkdkmSGbxA9pNxriOHQ2WvGHK3Jf13r0y1gU61xauOFQcdNohk?=
 =?us-ascii?Q?cWPdVJWXYmceK/lCmz++VcZFUw0f54TjHK6nkkuV6P2t2UizO80QA13bOaVO?=
 =?us-ascii?Q?0wrdBvpGmNHNvYByRBJtCgvPmdlYSrt0dvtRJkfucMBOojkzZO6lMw0woMgQ?=
 =?us-ascii?Q?UzKHF/ygJDzAvdoMcoMTB+YMwHxKdJQzIdIOS2QgS8RabXxA0atVRNYMdkAh?=
 =?us-ascii?Q?z4o0/6MkdUwoF9AF3XerRuD5MChHhs6G2VwkdQVuayFlOUTg9FPJpmBP7ewp?=
 =?us-ascii?Q?rsrZhQzh22CKNkCHkO2SPaAXXO2t+epNSXqs62KQQnzBBe/PKHhyRR17BWm3?=
 =?us-ascii?Q?zfLAXvKv/0M3bm0j5vMRYHHvZEPWxt6tFJ8ClbZKfc5QmtsjC1r3go8Q8hFi?=
 =?us-ascii?Q?nr3jcJIWBrMCzgva4aiWFDjdep0uj/6xvByiPK6NSFA57FzhhwxCrHwFyl1Z?=
 =?us-ascii?Q?X0NRf7Bk10BEWWrOGcn09lg4xmiGUIUoXDAwXNgDS0fne9jRIfExXTUUf3hP?=
 =?us-ascii?Q?eKhsfMpjZrPtOvKweQcXc6hQppVpEXKeaeeh5mxf2igq9O6A7ioEVKfKVrEc?=
 =?us-ascii?Q?0TEODDoN496aSvN6UVzQsM8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d998aa1-d95f-485b-168d-08da75c0ab81
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6826.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 02:26:00.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4a84oqCrcIVU9nqu2DwCGwC5v24Cw5m71w8kpoOAq3gPmkEM0iAa3SVuCFXLTueY1MGVyYibdEVFJ+06K1C1Zb/+DYCqPLbSfTNZn7tKjCK9/LuOrE7ig6KS/Q3zDyin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2253
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bagas,
On Thu, Aug 04, 2022 at 09:18:26AM +0700, Bagas Sanjaya wrote:
> On 8/4/22 16:47, Huang Shijie wrote:
> > The old tree is invalid now, fix it with the right git tree:
> >     https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> > 
> <snip>
> > -	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> > +            https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
> <snip>
> > - *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> > + *   https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
> >   *
> >   * Copyright 2009 Intel Corporation.
> >   *     Huang Ying <ying.huang@intel.com>
> 
> This is essentially s:cgit:pub/scm:.
> 
> Better wording is "The aer-inject tree have been moved to <new location>.
> Update the link."
okay, I will change it in v2.

Thanks
Huang Shijie
