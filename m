Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24EC26630D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 18:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgIKQJu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 12:09:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17162 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgIKPwd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 11:52:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5b87c60000>; Fri, 11 Sep 2020 07:20:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 11 Sep 2020 07:21:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 11 Sep 2020 07:21:39 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep
 2020 14:21:37 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Sep 2020 14:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgwZyhuxOtbd3TgOkgtugUqH0I2IAcrJcYVXoseAcy+YgMrvEL9SEKKS+Ck9EtRz0lv/I44/mvX5cv8MMERjOCXpGUeDn3+lBuNvApEf07I58m6ETkFFFR3Xwg4S33OGkfNTHXDxrYZlvPnItwKh71TPWMFTT5Aw9vAthF2Vju1jEq+GWKLgFs9M1W53jpcswqRrLc4+udNZ+YNsJYrVpS93fITnMUKvUvjz86DmwFfKmamZf/cKE8bDUtIesCCOV28XwJPhJoc/154QhUWSQGaCc7tMYvmNEKWDckZuH7jTQX3sLiAfMRzn1UggQKZtkeIFo+O3D5H+OSQiSONbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYM2wFKLgozSq/0MfhkYaJPq82+H2cLhdx8vVRyrBMM=;
 b=HUh8qmHG2bhnSPwpdRX3y5khgVDZBrvw1UDZie37tnZ5XgaA9AkpnbB2O3tW1nCDx9veAIWHpUv1fDUBjxHgeledH5t0QKVc7WE5qpy6kBqsN8yycJDhmS3E3pxX+kzySk4lKqxTyGEv7QrS6Hl7Dp1726Cr36eFhuWqFcAOgdrtNY2Ty9b0DxyKel+nwAn5qyWyaS4LV6T1Tzt1UuULKMji8mBRWx8fwfqhzZ51AEgoMcyzT7KWsB1SxOXlg4jmBy1dS3qWv2Q+iup7RMZ8EiKIHtHIlC+r6A3BbHw1ocsJmpZH1aPKVyj6ZLRpa0gBYnigOF/I1LLa/ctaspMkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.crashing.org; dkim=none (message not signed)
 header.d=none;kernel.crashing.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 11 Sep
 2020 14:21:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 14:21:35 +0000
Date:   Fri, 11 Sep 2020 11:21:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200911142133.GL904879@nvidia.com>
References: <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
 <20200910123758.GC904879@nvidia.com>
 <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
 <20200910171033.GG904879@nvidia.com>
 <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
 <20200910232938.GJ904879@nvidia.com>
 <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
X-ClientProxiedBy: MN2PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:208:e8::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:208:e8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 14:21:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGjvh-004xAJ-Uy; Fri, 11 Sep 2020 11:21:33 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d854b4bf-93a2-4030-d5cd-08d8565dfd5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3020:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30204C3D49EB372E07D62110C2240@DM6PR12MB3020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEcd8Wv51zNW/F+E3ckfy1jUqYzmpr2MDUzSD55kUW/G0BMV+pZ7gP2pFw6ThsKjGgBIokmw2VfTdOzFgMS0aEEI9AmdPPb0jHclUkuJxkNJyUybKR4FQz4U9OGLWHo0N4yKPaSzxcP7p42gA/z9y+FLEXU1/JFxTqCN9ysO40qLxChIHy0FPDa2DOI02gTaUFzcolqPUo5A4S95wWwq9XkBVM8y2JH9OYbkONVVeHpHL2BI46UhlbzLlDwIndbO96g+J3syKTnmvIfXt0GJV+4YL0ot1GAHDjzDNY9xPjKchru46pE56Wd28+d5vpb3cwKgm/VGgXsrCX/7a2dmGTsoSRnoV88efF6iWDgZyguKPbxWYhbYGtAe0YdzTZmR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(83380400001)(5660300002)(1076003)(426003)(186003)(66946007)(2906002)(2616005)(54906003)(26005)(316002)(9786002)(8676002)(9746002)(8936002)(33656002)(36756003)(66476007)(6916009)(66556008)(4326008)(86362001)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AD4PC51MlOvXvEcxT+12N7WhoWqvW8TLLkiCjH0Ra+0tKCf4+rKtxgVg3hsjKEBepBIUsadHTleWiP/BuSiidRnEURr9iLjeS8RjBptIBNfrBfEvCNTWx0F/KqRgC7QKR6t5iPTScn88WkGGHExRgP58O7zoKtS4ucokghBi4fdqpqxej0XOLWkPTZoTQIaUF9wgvbv/3K3byOkmkV8oaqUSIr7AoE5MjzyYiDayc4LHqb40JK4BVEyyBEEZheckWiyGv2F1Hz3mqRv0R0N1XGRiRYsp53sjRHvq32et7SdTwS6EQurYZsyebvXfNZThS3nABjpWhIBnc6EhUZRn1hfwOJrguIwGwMk6d86ykThMqExvAJFeE0XS7FD6OCHC4KbwfQUkNrNdG3+6ef2Zdr8xnDYKZ9k0YmsawOQyQxDZfYaITbFQsI+ve/UrUY7ursnsw68dmA8+RcKYZclcR2mHdWCCJSnfBpv1iJKKU5F6o03TWXJoxYMh5mWANo6x8PHk7U6ObWi1j42kjngDeWcf57NlwZxCeFH8Lz4tzcxvWEyo0uOVNkBCdXVakMb2BcBf7Hl2OrFsJjusyYLMXHvNozz9SevnCf71cG+lkq5ZtnO2EAftX2tlmiS522fmDs7SbKiBs80v7DP2rDfKzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d854b4bf-93a2-4030-d5cd-08d8565dfd5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 14:21:35.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oDQMGtqNtXFBhpiCBrXFI/Dj9Kgva9BkuWeH0WHT7IcYWyZDsUpGJ5i3BX5wbQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599834054; bh=cYM2wFKLgozSq/0MfhkYaJPq82+H2cLhdx8vVRyrBMM=;
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
        b=pp6fTbUv+wgBOeTDMlqEVgMDGviqRE2W/QTX6vKl2cmuKG3XgNn5kTZxhcIDfzrDW
         W8cUewwv19qMPU20Z35/CWylskYPTGa7f2ZNLK9gIFJ1fD7k4Co2YRHqSrS0ik7HH5
         YLiCRG6pw+xxAi+ICBw0nxp1oQTqrC26S/HH+vabt8BqaV/4ZZ32R4jXY7vJ01i207
         A3LU7V/8vPGIysX2fnasM56gAQSjFXrmy1O7F47Q49nf3NE+jNboBV/8D/2UUtXe82
         CfpjiQ4tTR8Om5h532ty+/NytBUXkMOUJeuJae+IlPj6OVm4uGG0iXn0VTlwWZ7p7t
         l0ld71eCJwz6w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 10:39:16AM +1000, Benjamin Herrenschmidt wrote:

> Yes, "write combine" isn't a good name.... The goal is to get WC but it
> comes with the whole package on several archs. We don't even have a
> reasonnable definition of the semantics of readl/writel on a WC mapping
> (hint: on powerpc the barriers in them will prevent WC even on a WC
> mapping) nor of what barriers might work  and how on such a mapping.

Yes, you can't really use WC properly in the kernel, we don't have the
infrastructure for it. mlx5 is using __raw_writeq() and wmb() to hack
something ugly together in the kernel.

A useful API for the message method, similar to what we use in
userspace, is something like:

  /*
   * Almost always need a spinlock as multiple CPUs cannot write
   * concurrently.
   */
  spin_lock();

  /*
   * Ensure that all DMA visiable writes in program order are visible
   * to DMA before the WC TLP is sent.
   */
  barrier_wc_after_lock();

  /* Generate the TLP */
  write_wc_message(wc_iomem, message, len);

  /*
   * Writes to wc_iomem past this, by any CPU, cannot replace writes
   * already done in wc_message.
   */
  barrier_wc_before_unlock();

  spin_unlock();

And another varient without the spinlock for stuff that can be per-CPU
for a range of WC memory.

(oh actually I see most drivers are using ioremap_wc(), and there is a
bunch of them including an Amazon ethernet device...)

Jason
