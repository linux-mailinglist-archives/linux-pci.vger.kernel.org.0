Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD025D8A8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 14:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgIDMbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 08:31:21 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:46912 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbgIDMbI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 08:31:08 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5233880000>; Fri, 04 Sep 2020 20:31:04 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 05:31:04 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 05:31:04 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 12:31:00 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 12:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRg7t5WpxuOVvzyJtx1KMy8gcnyMLSVL41xmT9lLYlhcymQY5P2O1QO+DYRbCi2vOEf/bqwKUWPTgK/f5zv4UPTJX+AGR5fb8LjH0OM3bcPoMzgCqnKPuDa39TUKRU/prMKqGziQxPhFzRf7ZTc6pd5MHaqDELsiGXeQjOA+Fv8l1J2bzKyGH59eXWrplMKlL8m3+8PIE4PPu9NUKT6sLTg3q6rx2TOEtcSHPg9ddAADMrIoDrDylHWZyHvz74KB551ngjizeCEx0WgPREB2EcL/dlFj+UPa2wHriTkzndFaR9v9hE0XS+G200bVj0zrpsIPKO6gT51kuGorWgi8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn9Q0KuX8NHY2/wVR+cfoDcGl+vkGV6zHL4Sw+BmllM=;
 b=ff5CHEoxCw7SPiyoVxYt4KSpdGSgz6nW/21K0AkXKgPBqW4VUaEaY6iv+FshYRObmz6VImyset3qOL/56sm1VAXEIcf/Z3E/fgEDkQJN1uBoQ6zJhF+ujB/vD65DpZ1ntrZFAvj3Xyyc6vXdHqFGSfynnhSCyZzhqe8+xEfFqDiZI4SKKcZLmjJsNdY4pDQ1VqcINSOVec6z2F96xww58bJVtkwPt4R9cwI0hpQ9Zt4bnl4x2d11rTGU+ZBWE7mrXI/IhxiFRqLOI/GR6V4OzgJX/FDLSPFMKyjO6sfUAUMD0tYw8ABVH3x4TcHCntFocCnXamHKKlD64WI2559F3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 4 Sep
 2020 12:30:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 12:30:57 +0000
Date:   Fri, 4 Sep 2020 09:30:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: tegra: Convert to MSI domains
Message-ID: <20200904123056.GP1152540@nvidia.com>
References: <20200904105613.444945-1-thierry.reding@gmail.com>
 <20200904114501.GO1152540@nvidia.com> <20200904122827.GA591744@ulmo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200904122827.GA591744@ulmo>
X-ClientProxiedBy: MN2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:208:23e::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR14CA0005.namprd14.prod.outlook.com (2603:10b6:208:23e::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 12:30:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEAro-007PBZ-63; Fri, 04 Sep 2020 09:30:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe630ae8-9900-48e8-bbd7-08d850ce5fce
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29389EF0D2B4F46D076EB47EC22D0@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8vdCdPKJzP0IBldwmk2ZDOimNVTBRAalB5orQbCFueCYjJ20K8zORYreRdeubJ1e77dXLq4vz1dXSBwHs+I3Dd5h3jhvJioNDIBIgy14S4Mem1hCWeh6MG7sJngsTgo8OleiIiWKkeIoxJFLfa1aFuKMSHe2cBzh4qLpeM4fPWo3DnkXPDyEYNCRnSA4nAThQKoCEH5CRI1vJFhha1+HSBUMEMBe/WfI+6gJaBm32YwOfblrKuQp6jvJPOVfuQcjfwGpWVKo5uGN9s61+Xlfg59iXENBCU9Z5ygmk8Bh4b+KSF5rgk0GjBuiK1Oy+Cv+Qukq2SFGX4NZxiN3DHaLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(36756003)(9746002)(33656002)(54906003)(4326008)(86362001)(8676002)(9786002)(8936002)(5660300002)(426003)(2616005)(2906002)(1076003)(66946007)(26005)(316002)(478600001)(6916009)(66476007)(186003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: z1ig42Fh9mC3JA3CTUfkOCKwIcvy482v44SXA84FrlUiq+5IR1rRnw6chIDnb4rkxnYF4rRi31WKaSKu/zm3+jmgedKDwZWYgkEi1fnV1uSK/uSf9BurM/NaYbu1oH183fj8v9y5CbnqsjPZ0ooJBHtTgSL9ROmjtFWC3vsguMEhkT5WZGkd1eWErIsUpKqjbYXUEyktE1993ZnUUqUyRbk4Gl+YXsYXEIrGsd/WUY3t4YA0vbOk1Jn24oyLTKHlFdDSLksmeFrUQe1zeQJDk8IhEdD93slvBPTcYBT3InO2CZQMqRBA9kgDY5tc1jbohWi8SHmaQPS8yjOLcnN5bofrqYFniLDsGDEbKNQCv1ABdmmm/EU26UGh0BkI8gDd0W7utqowzQR11jpaGSuT/v4kq/56k/tNSCRd3SKvMG8d6Pi1WG9CsIrud9YMOLSRdKIxGYTofYBjYoAXY4E5q6vQUKuYTktPb3HEZws4CTbURfEa6BsAg7nEh+3Erb2C+30t40OoD3PmJZod6RdvHGiUUu2Z+xEbhuqypFFzzyH+FajTNVhCbZ7dpyAHZ/otSxpneUiRaVFQSElkyWbwzDXWU6rGBzFgl5Ms8QtJcuEVMyvE1GYhYd2adNfngbKBx5p9BTWx+MpdtMnXtKSGXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe630ae8-9900-48e8-bbd7-08d850ce5fce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 12:30:57.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVwp8RVZMzKKVuLQqO8xaVsT7JX8rzUOL2sd+FASPxF5X7oHmpjP+2budHiUeFYA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599222664; bh=Sn9Q0KuX8NHY2/wVR+cfoDcGl+vkGV6zHL4Sw+BmllM=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=cF4/BcyXF7ZZj+SlpUGIETDXlqerTKdJunCLd0txTt41hn8POAm6ttUdNN3W6p98U
         2szNZmbOt2tQikSP4xeyHRUxmZYFWwxJmCRHVCtjMW52TUJ9g8XJPPASs4pJhfcvW3
         zuTPG9gGu75kWXIkOskMBriRw/6QhMpC42XrLLb/3S65vEi20b6WgSWYXRDk5Qh9Rr
         l7RislULBKgSUoFbOzANYi17f36kUHiqd6eZCg+zN0T+3PfXQd6bJpmdusCmyu7p2E
         qTTjga4slIHYTWqTnsiECZm19xKtt0+HseET1tLigyx2sdupqp0xsVzwqN0Zdzs6af
         C8JKjLEJHHFWA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 02:28:27PM +0200, Thierry Reding wrote:
> On Fri, Sep 04, 2020 at 08:45:01AM -0300, Jason Gunthorpe wrote:
> > On Fri, Sep 04, 2020 at 12:56:13PM +0200, Thierry Reding wrote:
> > > +static void tegra_msi_irq_mask(struct irq_data *d)
> > > +{
> > > +	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
> > > +	struct tegra_pcie *pcie = msi_to_pcie(msi);
> > > +	unsigned int index = d->hwirq / 32;
> > > +	u32 value;
> > > +
> > > +	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
> > > +	value &= ~BIT(d->hwirq % 32);
> > > +	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
> > > +}
> > 
> > Do these need a flushing write? The Mask operation should be synchronous?
> 
> Did you mean a flushing read? We typically flush out writes by reading
> from the same register. Another write wouldn't guarantee that both
> writes are actually flushed to hardware, would it?

Yes ready, sorry :)

The read should 'pull back' any in flight MSIs and ensure that no MSI
is delivered to the GIC after the tegra_msi_irq_mask() completes.

Jason

