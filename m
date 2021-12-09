Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3A46DFAD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 01:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhLIAum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 19:50:42 -0500
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:55008
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229846AbhLIAui (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 19:50:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB8JpUYZUqhaaZfsAbnr6nxUMs7K+RhThO3vZH3TETnzKOdeOT2ciFwTHYXEQ8TyfVDWHAvQMk2hAP9Ju3tY8vrydnGi6DB02fimcHDTY2suoc0kMS8+bVevLU7FOLfAmJkUyu5KL36Tq67PQzDNv7XzxNJuwxqFvyLqWPETgzyltsIBuhEJ34FfbkYF6xFNQqv9PJEgr5fTtdFEEoc9LwUikVfReQWTVliAj1mIrDq7hPKj89umv3fj3agFNN3JNda/cHg6M35cf4cCGH9L3N02X6cK7qE6dz8hbxMhxD9YL8bkl1zkjJ8N7hfpquF3W5aPgDf2who7vgJgAyovGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcTVV+Ei22uQ3QsSYsqc/2t1gTooA2VnriyB6SbTpXA=;
 b=YtTB56kxvnXaCDAppfLG/RddniC7Yo4XLEua/0A4E9NRMzK60v6UacvCASIU03+u0Ez6i39o/JlYiCEMVeb0GujRWm5PFnOIw88Dfsnr4Coz54pDGq4kS2fEanYoDoAs2LYE/7ksyia0P6gb4Rz6hGGBBpE3LzSNqsSHwfvzWQMvRIr9EuKp55i4fwD7SVessVXsQCzGze/Q8fe9KTiTNvGFBuX63MWPSB2LB2dCFh/T5r42wacgY7392MxL0H35M5LUumc9dmzNhgmKQX9FU8IHWwZh+bTXijQi8ec+wSwajOKOB6cdB7ltkCHaC9wRGmevHkSou0qbAy1+hTm5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcTVV+Ei22uQ3QsSYsqc/2t1gTooA2VnriyB6SbTpXA=;
 b=F5GCW4kkEFNbA5uo0h4WGmvJscAXmTM6otVGQ6+hbA7+mxbgTnLEnPl6oNvuAMmmaVPzf21JMi3P3+drgOx8ifkxhGFMsVPj/iwzW0iBGWsqbr6+EimzuFCWEgXzje9F3hjchs00M5Knija7L0TZcNqPs8SelHUtdspfXEs+PNqjsTLw0b2iSP+wizO2BvLsakG3wwCxUJse0rT0l/gpux64dgFQudKtVanyHZsQ2hChtBgfhvv7X5o9CL5l9XDZ4zKTtOpGkqTME1rZKefGihhFUNoLwCT14YXI/Pi3UXhdNnEOmm37IjVJ9bWLEBGyOxQ7SkibtmpDv89A+KjtQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Thu, 9 Dec
 2021 00:47:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 00:47:04 +0000
Date:   Wed, 8 Dec 2021 20:47:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch V2 02/31] genirq/msi: Add mutex for MSI list protection
Message-ID: <20211209004702.GL6385@nvidia.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210747.708877269@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210747.708877269@linutronix.de>
X-ClientProxiedBy: MN2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:208:15e::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c14e566-daaf-406c-77a3-08d9baad6afe
X-MS-TrafficTypeDiagnostic: BL1PR12MB5302:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53026A671AD1BB462EA37021C2709@BL1PR12MB5302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZSdN6zaq0rHllMmOHawJEe2xbP54HWpMgxdC47tlUZpX7MXHAZaK4jGl33lz70+c+/Rez18WL3zBe/2RaI+1D3F9L9CICl9k5yGo66TyTdBTvQDLIL47CFFSDHwe0zytJhKh27/T/NDhxdfVNsaeXFg7QT8fWB7k/iV42t1NsK06f3T0PLQQaxKBim6yn11tSIMaQo49lfJr81I0GJ426iVwT+177bRKiCr5ZawDXQGrSSH3dBJJxGbEj8sZkHX5HluFKTXqtwN3eWXweeYMiD9V9FWWhu8ht9H3Uy6ODAOVy6uQMPPgK/IG8LzQw3TXcJNTP4AHJ1gCZTUltzyNQSvfW3+MNJcnvKYV0gaGiJCsi6MCAoCjZ8lLRIiVQME5NcS8N/Y/o9bWnOJPh4Z1pnQPjxoyL5wgeDmQ9bBmnVLbVVFCgOlvCIEl6ijQsZ2UliPMHMH3Q7GerMnYzdXkhEztnWRoBWs3I+PDRrsEv2Hr+CBv6nfNFQeH+GbIub1MxErQPmQ3k7taBsfPNy1PQD6vgyhfpeXDSbWSi9zziopkfplkQsxToQmRsGnJUu8werBG8YbLqw3T+vRd04ArDf7fOuXSl5bbgpM+CfBEg/qOedEh7lsjgRbN8lCv2O0hNaxd8TW6PVdR4lIoPaqZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(1076003)(33656002)(4744005)(7416002)(8936002)(4326008)(86362001)(83380400001)(8676002)(6486002)(6512007)(2906002)(66556008)(38100700002)(66946007)(66476007)(186003)(2616005)(6506007)(26005)(6916009)(316002)(54906003)(5660300002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IhnJsqHq/qBxb2jYgaHL8ooQrKSsvmcu/5qZaYYSkI20/1gw+Vhgb4bTPq0Q?=
 =?us-ascii?Q?Gf5pePMzGeQ24KGMZBiJpCEJxz/ZIzh1OuGqzUdmXbzstFa69j3LaDxh3+t0?=
 =?us-ascii?Q?vgONaX4CD6WjGj/Fq2q2xAPeOhdWrwNDKAxtkUYGGHtzKJIGw3zhAtdDMtQC?=
 =?us-ascii?Q?eclDzq+d9u2mG1xK7lU8Pxt7sI8eU+SASWJqMBKq5Te1lFe6w4wVohWSvD2N?=
 =?us-ascii?Q?jUGY3+5C9SVj5kIOKVzae0bl5IsxexpreTxiTdnI1kRF9ryqBDn4aTPdkhjD?=
 =?us-ascii?Q?/GhZKFADlqN2s+pGVjsECEftQ6C4c8AHpgbbC5yVha+BBmLAPQ+9qMAtf4H8?=
 =?us-ascii?Q?OAO0e7dC4+3ufqhiPL4fNhOKNeyOcJ5ESolsTUGPeZwz96y7AhLY+/GQISky?=
 =?us-ascii?Q?ccTMEckAUa32KpKtvjDI/Fy7Pl4CX8jCrNhYemgPyScO6sWRBudpEXw9WqQq?=
 =?us-ascii?Q?naK1/qlJnOjdPPkelzQ7G9X1YlZwONYp17EVlHoTkThOxTuEtWWFmNdGp/9O?=
 =?us-ascii?Q?0HacfLg1Um+ONjBNXifqasbG+cH6uZabPuKy/C9b4Adc5e3TnEs8+lSWDEyO?=
 =?us-ascii?Q?XhN0E80UAN3WFCdvvCwiRugmwmSf80FtSClBkptSiKAdjnTFqC5hm0kBPocV?=
 =?us-ascii?Q?03UzVlKbg8F974AJaS7rRwjRwS/Tcrlae6dIIKJtX8+nXi1KRnkzyFuOKUCj?=
 =?us-ascii?Q?HPQt8N0SR/fW1ymFWkOkZcSzCAhjpeSZhqSSsrJDCbx4cPZZzwmHKpuPKfqE?=
 =?us-ascii?Q?Ih8+5bz1qqunPknmpHrkN1KNNHUq8U8HfRzccfwA5FameF4auKSkDj/b2BrX?=
 =?us-ascii?Q?yJ1OhuRLCq1dIZBoQQL1yAN5BvSe+HDYBQLfAOaiSqxRISIAeU9dvaaqKm49?=
 =?us-ascii?Q?90Qd/ouNmreqYUHpyL2BcyInexO3UN7Q9EpqtHOV14rVySvGv86qj7InZtcd?=
 =?us-ascii?Q?t6JmlV8rmAOibM8JWOQOHvIPara1+aniVv/CXrNAGxrG8qMpIEerM8z8raa6?=
 =?us-ascii?Q?JzjXmya4nTNnvlXCciYfR8fXmepXn559k6Dsp+OndWi7EWDNmEqcSvkLP7Ve?=
 =?us-ascii?Q?ExhRvcFxpk9p9Ns5XSmfWf8Lav8kUt14BwGwIw7F0ezZyvLjjG5GBMW2LXCt?=
 =?us-ascii?Q?oD9I6XNdy69x0q/QI/embTs3L+aRC4DiUe2U/s5K4i+euts1oSKoTSVGhMPS?=
 =?us-ascii?Q?2V1NeBNrPVFwvOdTtMaWfpx+F0zyKGUxXLYJs2XGFVqnMyXbG+BIPkatNfmf?=
 =?us-ascii?Q?2wdCgOMRjlOaW1A2tIxYJtzCzrFOnFRnb5ZBRzjNEIT1Kiofyzq20g7wiC0V?=
 =?us-ascii?Q?3iQSmW7V1ujCl31IWixOw4ZpDdjo4pdKB7DLUFLIIf7rzKA5NfdLv6FDwCZL?=
 =?us-ascii?Q?8YdKjB6Lgrxy8GCodikahFQ6QGOXiVabTJ66GvS1H+ZBLuIMTPTHwpyUNswC?=
 =?us-ascii?Q?X6eCipMewdNRSYOXEhggOWegxVpyXupYaZUXhuqidW5JaxOm4MuKS9SKwT8M?=
 =?us-ascii?Q?uxRKJ+eQu/E0AcHd20qNEN03SYShxCbLV3Uo0O4B3M8zXh/mytjtq7OwLeKb?=
 =?us-ascii?Q?ijq7hSUr0nnjSFFapEI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c14e566-daaf-406c-77a3-08d9baad6afe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 00:47:03.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw9FYEpaoBsAeiwIYYxisGGhScNaHffggJWKK9TqDuFHAggnPKGHyOBgz/wnnSy4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 06, 2021 at 11:51:05PM +0100, Thomas Gleixner wrote:
> +++ b/kernel/irq/msi.c
> @@ -127,12 +127,37 @@ int msi_setup_device_data(struct device
>  		return -ENOMEM;
>  
>  	INIT_LIST_HEAD(&md->list);
> +	mutex_init(&md->mutex);
>  	dev->msi.data = md;
>  	devres_add(dev, md);
>  	return 0;
>  }
>  
>  /**
> + * msi_lock_descs - Lock the MSI descriptor storage of a device
> + * @dev:	Device to operate on
> + */
> +void msi_lock_descs(struct device *dev)
> +{
> +	if (WARN_ON_ONCE(!dev->msi.data))
> +		return;

Is this useful? Other places that call msi_lock_descs will continue on and deref
null dev->msi anyhow - is the dump from the WARN_ON that much better
than the oops from the null deref here:

> +	mutex_lock(&dev->msi.data->mutex);

?

Honestly, still a bit unclear on what the community consensus is for
using WARN_ON.

Jason
