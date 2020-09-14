Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AEF268D36
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgINOSl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 10:18:41 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:54250 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgINORk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 10:17:40 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f7b7f0000>; Mon, 14 Sep 2020 22:17:35 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 07:17:35 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 14 Sep 2020 07:17:35 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 14:17:30 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 14:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le+hBpod+vaNJ6vJKSHxbNKwr2SKG+JPb4CYqM/OFfBlEyILhmeiUF7sdbvrhIjjQu7hqyQJ6SVRAQzUENlTLGtkJjvWyRUxEEkfCHW+zyzY9pS0DZSx4H4MGAET3mUsyQNUZUI5NNU7p0PRR8w+66/fhgiOOtf/rCbTMxLtt8i4U9brsKQr9QJzVhEcJHlz9cfhyVK0LARX/+8GDPotAATmLdIOcIj1PzFtDuvco/k9Alcnt6+Ufl1aM/u4+SU2Uy2ImNzt2E06JSnImUjEJAE22jTXJjSUXzHEa03UhriQ8TmleGVJsOCkhzTz4oe3NRAK2dKlkrfX/lHmHCmV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaYnZcXnnZXyuwzImWDlKeYrKUO1gBQu2q3yCsKxoLM=;
 b=HQswlSapTjsQ7Gf7vEIqsghB3X/G1OrVK884cVkG6uJNIj2u/ERJFA1V1CqTd0VCDiIDrdXhKafx1Gy5Ci5DPdnHI1qgEgKxQmcT1vqkNyHHAmpg1SV34uAfhz9cAE+KpNUnGqW3cJ6oysmhcuOtYj5SzwHCcaWDlF1gFZekNP9JOrdjUnYsJ/Hx3IL4K0jmIo6a2+AyVbRzwj/0RHpTWEXfuDqAxiJU0zf/Nyk5M4JEyk1lEWeSLDxL7G5YliLkZzEbA8CtYYRczgAIC0W1RELslrDsdfVvW3boIeLVLGZ1ltYy/satS6CkLTnJ4Ik+7QLdn0iZhnJiBUylrmA3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 14:17:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:17:28 +0000
Date:   Mon, 14 Sep 2020 11:17:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Clint Sbisa <csbisa@amazon.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200914141726.GA904879@nvidia.com>
References: <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
 <20200910123758.GC904879@nvidia.com>
 <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
 <20200910171033.GG904879@nvidia.com>
 <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
 <20200910232938.GJ904879@nvidia.com>
 <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
 <20200911214225.hml2wbbq2rofn4re@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200911214225.hml2wbbq2rofn4re@amazon.com>
X-ClientProxiedBy: YQXPR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQXPR01CA0107.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 14:17:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kHpIM-005yLu-BV; Mon, 14 Sep 2020 11:17:26 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a40a830-b10f-4731-069c-08d858b8e914
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-Microsoft-Antispam-PRVS: <DM6PR12MB404181E4E3E670D49481D3B8C2230@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oep5w4h0SWiiaJh75z4ic/tOESlyqdUp/nZbX2mvRPOOCd1oyRzKOlN4M3p8wjlk5ddLhzcTjcCNknUxdg0cKGVkwNMAnfYV3ksywPEG43yGzfauCBmINhFqSTlIIAQ2cbNoQ3Jw8R2DwwyR4Mnd3WcXMJYzNcM741PzSJs2JolXYmO0t7lc9WsUWivvAUo562sKmdPSRbf0wjbDtN175RsI317KVSzG9uUE8obyyusLpZydDylUmoy0EuGXhgA8JcNcsXWzEpCFqbTlzn1agD2HCP4cIsDzOm/c1WZpPfXzD1+CFkQVUNVXr06Obs2LLDMlFQeSmiz5oBPmD6o3fDrJHbYry8f0ww0lL5eE9H/BW8ufmM0i/vg/h78Zm7TX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(9746002)(9786002)(4744005)(26005)(1076003)(426003)(186003)(83380400001)(5660300002)(8936002)(33656002)(8676002)(54906003)(2616005)(4326008)(316002)(2906002)(478600001)(66556008)(66946007)(66476007)(86362001)(6916009)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9bUNhAAx/AqFzB2fpYJIYSJtS/mDWAEu2nC6mZPzwz7vrZDheWps7hVwIME4StOIMnVbMYa7ifvswrNkaCIn6GObgPSdDmj/qw8+2/3gqTEG6ZYQl6weEtUB5u7EYYjF0jc7BVvjJWS/CdUgJpEDByaDyhVf9//OVngEwXnLUCvFCqq/o3wr+uMvob/XsbWhC0IPJzh3j24eYGAuh+ChVCj3wjJxQ3chhLmaQVjFplwFwmDtp5swRu7Kbbbj1pREq2N0gKfTdywuoSDuViJDJhZF9OJHS8hraQ7OxHrF7C3EN8C9Q4iJdmIwEvWANuRmrNmp0IN8NrQMtJXGwCGueK0AratkRcFKyo/TfnBGziAa+sQq09n03kXnUU31mstmopXN6ZDL303MpK2SOZM2ZSDPSyM0ENS6M3S2E3HH2Z57o+n8wPzbNItU82acSXisD1JQORNoHuYuFJuHr1mI0bPY+KY1uV4ri+RGS9QULJ4uGI7eJBNi8a7eI8FqvCeFQF7xJj9oNdYRl1e3h8vIxjKt4YnvBtWkyNUV7hwnOeKfla7ow4T1TwjnDkkxlnkv9YhUTID5kuxFeSEl9MeWlZER2oL3HV/F3V2t6m96QQuOWywHDJU0Ck84f0ljhkxM9riRiJir87b4DgO/Le/mng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a40a830-b10f-4731-069c-08d858b8e914
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 14:17:28.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFqiQ5yHSvl1KBuRS1iBQqTMOZ37x3ugWMGd6eIs92cmvgs0tVE2ayvWwBLDO5n0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600093055; bh=TaYnZcXnnZXyuwzImWDlKeYrKUO1gBQu2q3yCsKxoLM=;
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
        b=AkGi/Cy8Sg47tYGjd+LU0M7wRFFsSC6/16uBtqx5/DN3a639wXVEwjjPmmpMtHCsE
         W+L+PTHU9hL56PtIgkX10UcEatu2NY5c0Pnz6IYcDMXc6LJ5M0avYFHZ2pGGw7a/Ie
         EhUn9pZ4q8sCnHKyFofWOby7b89/+7Vly2Bg0Sh1DRNE//f8NS7CNxcp07eMoWHcUH
         +QzHfDn9kOAZQ045UFbEmkgbKkdvdOX2z+WqIEjhlQKDKlhvVc1gbpqvuKU72fjOUr
         idLkDeK/lFgcm4Yy4motfESTY0+TyB+m0Sc0HI9kx64JIBEMgjtW7g/eIvbdinEmAY
         oNGIaMv0uTJ2g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 09:42:25PM +0000, Clint Sbisa wrote:

> There's no DMA involved with this BAR-- the driver writes a portion of the
> packet contents in addition to the descriptors, which generally increases the
> number of TLPs if write-combine isn't used. Furthermore, this BAR is only used
> for writes and never for reads.

You use DPDK without DMA? How does receive work?

> As Jason noted in the other reply to this email, the Linux ENA driver makes use
> of WC by using devm_ioremap_wc().

As Ben noted we don't have kernel accessors to make this portable or
safe :(

Jason
