Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9D325D7B3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 13:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIDLpO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 07:45:14 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16737 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgIDLpL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 07:45:11 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5228c20000>; Fri, 04 Sep 2020 19:45:06 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 04:45:06 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 04 Sep 2020 04:45:06 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 11:45:05 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 11:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtAR2i6VeSEYH1ySrtkjjKgw2aVA8J3czVTg0tJdSiJhu6xdT0Al9OW9CyPShrt/fhkw8zuN7kUXZ/OAgEAInd/M5Y1P5RsOd09+TtphjmajD6RVguePRtsXVCzuRNDjr+RBbgkJpFBs/tcRgsGgnRkU8Umen6ZXr4SwpEPh4LEGPhW4JxxJTkPz3tUEBfDCh5QugtK49GdepMZohR+zG+tNmkPiP3N0PFLsmPN9meWf6orHB2rF0CfcAxQfIwJPfkklNcSzGAwTRL0pXgr5EuY5cz0qgo3GYghIrz9Y78cBZtlcX7KOPvYBePi4+jT706TaaHfvsYtm5lQWJkKWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpKi9Uq78BZpCzdFEfP9RLkmEkb6kuDM2UsMxw26l74=;
 b=kVkk0aNxsGLmU/CNdAq9hFamm8QuipddOef67pJn41N+DuRpmg2+Ak6jMnguI6tZ99UHXk2wlSgV0wEQT/TEObWxnQ/0kJ5s6UAmUPeq28+mjS+hDqSTpf61eQhZRcU5PznpguEkUuRM6pcL9r/xlrhPbDO9BC9oVyhzRzPoArwOw+OHx5v/KH5IdmZzDnbCtHrZMwRwmqAxAw+5w/6zgYgGvScAWB/Csc0oagfEDgz1McpXccys/orINO7gIxR9OvL8ANyw9MMIhFuftNl6uETz4pmqf8H02ty97gvnZGhSJ7YP/kD4Z7wdI8SilFlDdpJqOhfs6tYmhODisRTIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 11:45:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 11:45:03 +0000
Date:   Fri, 4 Sep 2020 08:45:01 -0300
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
Message-ID: <20200904114501.GO1152540@nvidia.com>
References: <20200904105613.444945-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200904105613.444945-1-thierry.reding@gmail.com>
X-ClientProxiedBy: MN2PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:208:19b::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0058.namprd19.prod.outlook.com (2603:10b6:208:19b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 11:45:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEA9N-007HJd-Im; Fri, 04 Sep 2020 08:45:01 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2525011-17b1-4c90-7673-08d850c7f5e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4451D3A1DC70988E17F88ED7C22D0@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXnV6LyKeUqvouuMEnpv/rySVGm8cxkH9zoXeeA1Czxbu6lntt7YbhYMwH0nHWT7g09ZC7ep6ZueZ6jL9U46qUb7LyH3pkTBC8Z9qcw8+r7opo7USPAE7Kzb9vY15zmFsH60zKKnS7N1wUoNNVbHDp3wZoD5hCAR1T4gwXGVFoEwqnRMuLWRoxNYvEX0xpCdZIfRE7Radm4pF17x5NHLTZaef+nZ1SWbB3uFovtRQC+MVFgsZtbnTC/vr4qH/EH8mKoGDWXyEXBuMyBcJSroSCbqI/KmtXkbyUgq/Rc9adcRv8At8VMO5E/5KpnAtgrU4K7NFk0s+8cu5XruWR2fiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(9786002)(4744005)(1076003)(2616005)(8936002)(54906003)(8676002)(9746002)(478600001)(2906002)(4326008)(36756003)(316002)(33656002)(66946007)(66556008)(426003)(66476007)(6916009)(86362001)(26005)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6le88Eu2MmzcFORS0mtlzMjWldHNBSb60tFU2Ikn5WltcmrjVRqpXFmRXMDM17L7RvoK+furBDAW6ZUr34jxuy5DAB7BCMAzJfYT3J/9LkjXJd3XOr7L4+26/rNj1nXkvos4QrhXCgcx6QyhNxyrpwobPOwFCIDDmX0Jq1qmF+k5PFB1mkWhGPWTjtqN/l3pc+W+6wdC3WWkjldhTHWiTRVljQ2wDcqB2uKNCG3axDW8ALLlKnQgam2UQgjkKsA4eytIu+1ae2Pj641l6k5KTuX0qpBNPEIQ4LhiOQimmgxxypjnSa0UscsZnpaNFopk8xxWvljnd+o2k0OJ/tO4AKVNydmwF9YNL4+m4zOgwGWznzftdvO6gTBdbkRkZbHSuEs6YIRjwlrjgo/DJINilVceLbjyLlEw7QZeFn3iALbJxrUBljgQNTOeMZPtfSsiH8q9i7cY6txXtMI3YkmfyA/3hmyJCYrUgrVlMGYouTMVgPDP8V55mhw96t4MR0Cp3Kd0zlefKLNgiVAwjfpbi5ekRF0fmWx+r92X/wOH0xmkC+qbj3fs++yqIcnyUA2HX7rXpluL3p/a82VzkCdP0hkT+IcltYZd0lISnB6IUlUZNPIMYo/Nu+ZBDspz7HBEsEr4gmjklUVLqzwGyyhvlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2525011-17b1-4c90-7673-08d850c7f5e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 11:45:02.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9+8ssVutFd2vp2ETQGmjAX+hnaItcB8RpfRg9txtcFzpx+ezyAZnheJHKvtdZsE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599219906; bh=WpKi9Uq78BZpCzdFEfP9RLkmEkb6kuDM2UsMxw26l74=;
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
        b=foF8JGCicESgfuRFmj6PJi7KjK7kxjmJOOztUH0KL/G0+GOz7B4q8IXiOquvt+i1B
         aiynSj2V8t6yjfUeNBhmyUAcY1uBHDW+yTdUZ/FcSby8CYNBXp/uyhJJWLea/2JwMR
         lD0xP6AekwzDYtmwtNsoK1Nd77kwRHEoHKY+xcECSaSCpdwLNIyaUF9Jx004qiASi5
         scl2YI+XpPChZxRaZtk7hZDho6/pvDHKdgvF89UsjkKueOxAGQPsItnSOG0LBF96vi
         unhEwxrDoXeW2y9cH9YtpfYcfcS1/GHPFUV01TTmxBTlwyH61wnrwKoVdZT8ij/Nby
         0FZv24Fz4/LMA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 12:56:13PM +0200, Thierry Reding wrote:
> +static void tegra_msi_irq_mask(struct irq_data *d)
> +{
> +	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
> +	struct tegra_pcie *pcie = msi_to_pcie(msi);
> +	unsigned int index = d->hwirq / 32;
> +	u32 value;
> +
> +	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
> +	value &= ~BIT(d->hwirq % 32);
> +	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
> +}

Do these need a flushing write? The Mask operation should be synchronous?

Thanks,
Jason
