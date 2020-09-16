Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8728A26C3D5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgIPOom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 10:44:42 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14810 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIPOnB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 10:43:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6200290000>; Wed, 16 Sep 2020 05:08:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 05:08:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 05:08:56 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 12:08:55 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 12:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmHHiWGn1bryjq/iD8rKw0uOVSpyuVxOPR2yGqcctZZ/kzPExyLbYQsnFA3vG2XkUUo8BS/n2SKYtwmLB9J4IHryIbibG6FrFeUfY8itJw85nqGOxOMDb4sJJHaQdLBPOAoyi/4B626F7pgPU1LFdsF4bnq6obG7ZM63lxz5b2oIB7LBbPngFbhKD2Yq2wFE9XynBbzBNMjq0MW4PfdcbK/BDEz7pVCHhgDy33FpVwqgfYJn8d2447geqdyB2s3vMEi9b8w2nbTGVkmQ029nHqdndWKDHVrFqFjVpijq5F4eqnkJTUwBXL230T7Qg9iReURqkDl4pedSW5TIL+1hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKT/7wd52TGL0Hy6cEMxNeaCObdkvqppqEl1m4B9x5I=;
 b=RyTouCxFErjhAo0gMEmAPUetA89EJ9e254FW9oFdh1GxDeqxrNu9+DK+SMxHWtq5SX0/N2MB1Dgg/4+ix7ZQj4vwXqj5udU7rIDObU+vvS/U7F029/HnpqXbv1x6aMh3WmF1zgkJViLmRkiKT5qqySECbpe8iFPfuzzDQlfOlVNHfkmh39lPj/7zzomSbofMJ1B6fQrfA1QoRdMG4UQnVN/Anmfwsj1SKBtAEGJ0PihcmAN4AfEtlKIBRtHeh/yRJovOczm02DvTKfg4gW7T49uiAde30BlA2xuLolX8qtfPJH2BuDTfsOcnmogQdS/zHd8YEgvf+TQPHr/9Vl2QXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 12:08:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 12:08:55 +0000
Date:   Wed, 16 Sep 2020 09:08:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        "Leon Romanovsky" <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200916120852.GM1573713@nvidia.com>
References: <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <20200916083315.GC27496@willie-the-truck>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916083315.GC27496@willie-the-truck>
X-ClientProxiedBy: YQXPR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQXPR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 12:08:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIWF2-006v9F-Vu; Wed, 16 Sep 2020 09:08:53 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 482b7410-4517-4bfa-6bf0-08d85a394855
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42663D3BABE86CB73EBA4FA6C2210@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1P6OXo1fg76PmlJhPlLw2JgYSLgc7LaWF9xpPrTpbpJ/W0SCrDMmBjIc6d1s4/ARaXhwH5jcaDoZuJuEyOeBPW0JaNR6/2awYqVYksQnz3zMyCxP8zmuT506jU5l1eZT7gxLT9cdGCZiAmf157vhkh0UELf4rlSsW71u3m0VdIU8IEwnOtV9SbJgDN1q8cAp4etwNZyC8eyczknTYdQ8lLSWAkjno0uvR5aJ7kaZcRXmMDPUCoLdaw9wBCG68cGqGDFH2MAXLzPYlVrFFm3/aC9bClZ4J5uqa6bmIrXUkZ2c072HrO6tbxYuolIv37J+54iNmRWGrUFQcUHJw/OOExq+l5Y+ZNEhkUU1hwyc3S0FJpRVaLKIOYhEWG/SyLQg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(2616005)(478600001)(186003)(426003)(6916009)(4326008)(86362001)(54906003)(36756003)(316002)(26005)(1076003)(4744005)(8936002)(66476007)(66556008)(66946007)(9746002)(9786002)(2906002)(5660300002)(33656002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9NiTAqCX1LDYm0IKi/VrgX15vbwi/1ichNcmEaciwEqKbCcOvI34b2M2LT84a2i9Fr3Fji7zzB+9ohYqSXGLm3T4nDA2fJnK9LwUJjXoQOyOOTf7pQS1/XQf3YNl//jp4nG98loFObgGXKXIfVL/Kec/L4DFROsRWWKdCwZ2YpSNkDDX18qfMQvUEyl7RLGjMvqaiqOPM+2xAFOEU0NBvdjncEuzNdVaPAjQCMgQ0Ujs8SCcWuvskPdT9k0mJmFMFe1IsE/g+INloM1UvJPj4vxS4ulluQ1MMtyOtzy/CTIHYyIUUOTLqwXYLeA+WFMXt92s+XsPVyGU7XeiOABXct5velnleUSvk9QkTE305sED2N+PdZjlzPQDig38HbKkRXpY8QNubmW2w9PVFWbSAm7kmW+O0KirwvdCesJk2/YutMr8x0/PQM4VFmFaXTUwirOCjb8IQMH5dEhOewSvRiPVf7sEw4uEF0KcgsVw1ebE59GOuTC+xh9ia84FPbmb4zpBWyG7vhQiNDyuBx+yskl7Wz7SDCU9aXsnRgSTkbQw5mWA7E/LP43J4L0t73dKCzAjmPDHfUgG67Kamz/gdsQgdpVyJ7zZeGcT26X1uTg8IfeAA98qxBWitGsELzglur/uY58rsIjD17+J9NBgGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 482b7410-4517-4bfa-6bf0-08d85a394855
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:08:54.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWuMeg3Oo/7SBWepoai0raDcXa//KDNZy1jlYCGmMZZxFWf4WEfFjooKnxd4yYfO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600258089; bh=OKT/7wd52TGL0Hy6cEMxNeaCObdkvqppqEl1m4B9x5I=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=bv6gR2gDiVMVgpqFNij90SWGZkeS3hMaM957c3QXA19qg+RXb4/WCnoQw5DAupkWt
         m8SY0Csl47By93AHHkIDqO6X1XnCQjsRU3z0DGVj95JYuMtwLY9a6x81StVuL4MqGW
         YQTm6ZdctH8j9tx77ILKof5izsl9j4iN14wZtXxNyLtPqTgI/l2ufHzvNbTIA9rR1J
         fL3S9N2hXF8MDhSdJycyuLPVrbKS9fqLf9yoM4m8qtOWVpVOMkAw0+Zg1zDP42G+8v
         SOJw+uLQbaLhKYi18MHMegRpU2k13PMBNBymYF/UTpjSi2d2FZ6EbPHN1EPuLY7m9a
         J9nxRj2TgJN1A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 09:33:16AM +0100, Will Deacon wrote:

> Is that just TX2? I remember that thing being weird where GRE performed
> better than NC, but I thought that was a one off (and the thing is dead).

It is at least TX2, yes, but it is not really dead, someone made a
respectable supercomputer out of them that still has an operational
life ahead of it.

Jason
