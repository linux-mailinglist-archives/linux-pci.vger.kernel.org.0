Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACAB62C3A7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiKPQND (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiKPQNB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:13:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3548B56ED2;
        Wed, 16 Nov 2022 08:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668615179; x=1700151179;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nVWuxxIf2OIN4/iqCtWSJJxw9sh/hCiTLGcGzuzjajY=;
  b=lWfLhCwwVDhlaHjYvrlQS6MWo2B3yV2VCImz01jjBXET3ROkIeQFxsRR
   IYFwsnaEbxjLaaI8f+UqAqRTWBhEFSdXMqDEYIe/12g7Ytgo121qEijG6
   vHvBiZgw9TdRBxNjXyqURIrY+bkRoAjY39+jmqTbgzFJRdPx0a36H0PpB
   eFP4wdMBG2VzQhGF9tF0Xuhu3GXlLqVbi7IoIlS5dDkfEyk6GtHlgjGZs
   EbwjmUQzfVgxJmmLaZy2NEH+9YLUFNZqYB/xFaa6Iaz4fL5XTVRTFjPvt
   eP6ZggkbBmCqIpGmWwzTDYW2lK+zoFT2eH6P3WXgFMqQPudUGLDHDjlIo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300112920"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="300112920"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:12:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="708221355"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="708221355"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2022 08:12:37 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 08:12:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 08:12:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 08:12:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQK/vHh0sgzZVxp3mGDUEno/0x6TAET9XFDSEK7IGrQ2joAFFJ5aZFwDluiVbcLTNzSS6zoFXN5xPofGi9T/aLdd3YpqukAxDV1Q0h+Nw4Wh10jUlmVzN/vdc4r/TqOncqlLpWyTEj6SKIbi8rPH3v7/b2cDhrfS5Q2eOASwKuHx1gqJLSR9YhJlVpnNw+Dd82V2Kt0WQBKeTQziAqipmgyC+2heME3Nm/DLg/bYjQ8TPuCvaX/vAiNl+5KT+BMxJKauzyah9YuFf0eupZ4GMEQNZK2dP2dd/1vpq3n6JzQlrYA9/eCJ/ndUivRuwcw6ys5Zt+9XJX5PfD+Ncw3wbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gEmrS2k41uJ/N9BfMiqkbW7aweCgiKyGJxu/WDOue4=;
 b=kZR54y+BNY/W7z+LgbJmr+LaMrdszcqtqWd4I+3CgrA667JcSSyse1aSdbzm5IM+XVFgo4D0CCQWW2+Rz5B1Jiko3gTNr2QpuCBJLjKv56n+BMW8W4sLQeB2OWoO4dMxrPEhW0EN+X939H8P35oahzYrS7gZYcgciCK2wHl5PUIXdMo0ihxfpZvCkk8KEfdhNfQAWYFRoItGVFihqLwljzRfJDuPjDRaQH4D+G91YLQfc4FV6xdGuEzwQ7fj/EWKLsIqYa8JytuUkytlTD6EzdyowCgaYaiiFYVpyDBNvAdgT+ZxmkdSqQ29eD5VUup9V+YJ/kdMTYPPJrdHZzbshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 16:12:33 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5813.013; Wed, 16 Nov 2022
 16:12:32 +0000
Date:   Wed, 16 Nov 2022 08:12:26 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 04/39] genirq/msi: Use MSI_DESC_ALL in
 msi_add_simple_msi_descs()
Message-ID: <Y3UL6t5FCdCOIxaS@a4bf019067fa.jf.intel.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.831151822@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221111122013.831151822@linutronix.de>
X-ClientProxiedBy: SJ0PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::27) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MW5PR11MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: a521c564-fc9d-4f45-322f-08dac7ed5e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDDODzzSykk7kmfcHHivxzmO7piN7p8oYikmYh14Ee8GD6xJHKoMbZqtpKFRMw8nbGqnW2E/1jGaB6ABe+DXKRCMCH2AFSLEHyAal0wTlztzSJI+QgVLVTL4qstvl4SQFpNjDO8pfZMDueaDOz76k5XhtUmQSDXfDOxNO5HR+poPKWUbp4FSgU3arDISK4yaV2/Dtw65y7E/99RO/7fFHR2wv1frf7rD5N42L4VBrO1EdWOysZHhJRgAnm+uOWfSJVj9EmViO7jq0Eg4O7JOFzu+AjKCr99PfLvLtq7W9Gbrl2431FKID+rPpsUVmDsrvNyuaa2xW4AQI6moOrR2slpExnOwEV4zdLgnyPN3EvoTuotMaAG7vPk6d1iJXNBe31SaDPLKG2ZXTtYqhYPKNMb29AfwdBC0YKVuz6qpWr2YxkykL0rCU+sNl0hEECRPkw4Th5RhNOmO3pfmRlYGkExXBEt/VYnaqADiX7+glUiZ4CCxOnCQ5YggSi0SUp15644QfUWoAv52yIpNenNS6ttCk2UQLJ5F9/GqVto+hG9fTC/z2DFzk1njc019a4qBHqE5hT40DPqIFkznQemkrNtA1zWzU4DSCoMqx4xnBxv5V12fHb73G+rOqPL8KOYMBVb0r8f6w7IGY9+OsbxiwIxUb/zUglOE1ubTcQtI8z5V7l+iANcMjLNOCDNP4NWoShqQmDu5NHNHfQDgUBz94g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(41300700001)(5660300002)(186003)(4744005)(7416002)(8936002)(316002)(6506007)(4326008)(26005)(6512007)(8676002)(66476007)(66556008)(66946007)(6916009)(54906003)(44832011)(82960400001)(86362001)(83380400001)(2906002)(38100700002)(6486002)(107886003)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dj+qjh1kgIy2er7wXAbdY3lVLSZDY7NTXmOlVsR0nNml3zwsVYnLbiOIXs9s?=
 =?us-ascii?Q?awShNcLP+WCi5s57IwLWH1x/50fhJnkBEfWc9iqoHgIdgxKCj5h60ba7S4g8?=
 =?us-ascii?Q?pZjCmHASr1HC8upejf8l/m1J3q6vLNOHAOg0sSYjEim+J2tqtUH0ZGJVPmyj?=
 =?us-ascii?Q?VPjzywDhjgHcK+lZ4AfmZQ7Frv9V3/YpSgPVucmsXrJ2cGYkpXZxvIMYijZx?=
 =?us-ascii?Q?Wjj0wen4dIhECDJRq/8fAr5/lrUhiainPnIQ8WOz+khQzfiBlgEv2/34RQiU?=
 =?us-ascii?Q?Qz9/XsODFvF5RPweR9cv1COqlgADkk45xVV4Q6QPvU/AQq7dkk0vAHBmY9hM?=
 =?us-ascii?Q?1ZZQQxysYvMLoMMRaFGfpvN6aTsuOpapLlJvsdGZMQET8n8puLfB95EnXXsR?=
 =?us-ascii?Q?r85WdA8uAYVeTBbuuBNu7a+OAswZzjo4uDxCrVnJoOLcVZFCWjQY7Ps3lftr?=
 =?us-ascii?Q?PbpDznX9MRKKjeNg8UK3KeCY19qhhPsfgBS4Wz4Dj2o+7X6mslIUtZw6Y7oS?=
 =?us-ascii?Q?6TI3AgtXMhL/1M9wCAfc5xmaCdvJK8psvYYuJQM0tM+Hu5pYxDObCtXec8HN?=
 =?us-ascii?Q?rwzWpi4sUdfQQKhfE/kos8bxiJd37NPuculmG25JrqG3QGXsWPKy/paWvsDe?=
 =?us-ascii?Q?XZcJrXNY2pluPJHDRD6Pl6ADW1Y7B7W1ssnbWPJMW9mdx4ojSqYdGokVmxdS?=
 =?us-ascii?Q?/ipTukw4zTMEeQAKgA+3m+1IwnN4aXKIEzvDBH6KazJxNCgIaGHxCwaqplaq?=
 =?us-ascii?Q?HudFRxOTqi0XTg+KRaRE0CEK0Gdp9uVmNe1b8X3G0+lCQRiAm46+jfAMVok+?=
 =?us-ascii?Q?G2OmnOim49sMugd1hxu3ItQpGR07gRQip5feAbd59YHkkfMN7k8GXkUgyh8q?=
 =?us-ascii?Q?Imqvej8BAlP5yI3RxWD9cwqNFMCZOo0uqRvaManYOzIDaoxgF+7r/mS3dYXf?=
 =?us-ascii?Q?NmWebUDvR8naLcT81Zgqbx17ksLsDkjp7o40xMNTSLooUrl/SKlXTdLMIBtB?=
 =?us-ascii?Q?NJ4rNAc9uq+KrgyyH9yaifhg81urcrtKIEJkCIiI3O9XbpO7TNWN5NKrz4Zk?=
 =?us-ascii?Q?Ao5VnI30/a0UP+8+iD81aBAigwLarFYlkEgivqFVa7qV4Ncd8OUlGM9XKqoN?=
 =?us-ascii?Q?tngwXcyTWweCezhBjDzG/uYCt3L8evQze6SLtE0le+Dy1yCzT9scnriIzeTA?=
 =?us-ascii?Q?HWfUQxVzOWRJuXpWP2jfELRa4fFNIw7si+SbxqKbEtSGVSzY2G47fbuyROVU?=
 =?us-ascii?Q?FdWJnWQZKZEXYQ9C+L43Mb0+mMbXv89cTziv1TQlGrttE4j40nlv8TnfFp7W?=
 =?us-ascii?Q?DkuKL35MWV/B+XgsoXDRlyqZq+btJLyT4GrmTvfS4f+JJLmpIkc40GwwVm2F?=
 =?us-ascii?Q?9p6zUMsoFD3xIaTNr/wc67npmAlqvr37GAeNXORtY/ZFG6i3lcugXZwisEjn?=
 =?us-ascii?Q?4hNGHX0oVb53CAACEYxiAzzMhKZ8JNlJ5y8Q2R+xJNYp7TEqRrKWhmLaVFN9?=
 =?us-ascii?Q?iGDU1uPOeOSwtCNuT7Czv05YfBBYWFAIXbUjwyK7NGwGfsSDTRivo20ZZmrj?=
 =?us-ascii?Q?57fLRdkkDgpkiCA9LZ/e2mzyNX4Qzv70HuPziUunX4v+jReuTX21RqC9l3+c?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a521c564-fc9d-4f45-322f-08dac7ed5e2e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:12:32.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfAK6R+frDp1FI5XAGRzcdY1mq1VvZcHOyD/wTEj0EjK8KdBNpZ04kjhBdrC+T90LzNmJSIaQpCyUU9MW04v+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:20PM +0100, Thomas Gleixner wrote:
> There are no associated MSI descriptors in the requested range when the MSI
> descriptor allocation fails. Use MSI_DESC_ALL as the filter which prepares
> the next step to get rid of the filter for freeing.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/msi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -120,7 +120,7 @@ static int msi_add_simple_msi_descs(stru
>  fail_mem:
>  	ret = -ENOMEM;
>  fail:
> -	msi_free_msi_descs_range(dev, MSI_DESC_NOTASSOCIATED, index, last);
> +	msi_free_msi_descs_range(dev, MSI_DESC_ALL, index, last);
>  	return ret;
>  }
>  
> 
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
