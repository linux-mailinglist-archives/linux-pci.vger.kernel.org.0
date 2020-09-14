Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC33268DEC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgINOit (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 10:38:49 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7706 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgINOie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 10:38:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f7fd50001>; Mon, 14 Sep 2020 07:36:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 07:38:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Sep 2020 07:38:25 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 14:38:21 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 14:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV2xe34XJB05G6iPQ+EU2n4sUI556ZLI2ovE93xywccxmO0rkx5VXfLpvRkcQZ8KjGFSEitM7ragIJ+HieNKjdCZgaWUMfN9eWds/6YXy9Nz3lNXT+X27rq2ELh0G3Iy36Xxi+V6nx3fNhdnwB5h6zBYn9KdKbkLRgWqqReJLYSdQ0qosGkgUfJ0ovV8FJDlfPxE3jrxTpBmQl6w9gUk+DWE7cSksDMno4/D6r7mGzoSLT7q2nnzSLyUvre3Yp9J07cw9caUfPX+2dDavj0VwKp7iEIGyW4YIVmvpuGhHg8W2fwLZIGkYA7Ka68pxv61rZkOG/vKkX/fsUrPx6zAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIiz3oSTFXEpNED0JGdyDe4iReP+I23HHhr/KZ789KI=;
 b=Am15ZKvc2QFmFM7dj/2nT8CByNRUHEOsGU62ehaMtOeNBPMwAo3Z34RZ1wuraS5JUf2KmdG106ETsk/WljP1b/6nF2E9ZMyva8eA4UojNBXbmSe2jYPN/Q7qs4KH7CizKYBSuqnJwjDTTU8XDIal558WTCvNPJ3xIm0psoOIzkpBAPn0BgPqeoJ+ECFO3YyFxbqRkG7Peb6YvEQqPZ8XktHItWcWkllu6+xB7jsiLpU3ZkCudLRbzWdeDm0V+Bxm8aw3Ef+b5EWWNoTdlluteg1cFCZTgYgFQraMxYE3e8qM8vO+BsJ07wq55blPqE6+ALMXfxt8+DETjjyA1BdLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 14:38:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:38:20 +0000
Date:   Mon, 14 Sep 2020 11:38:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Clint Sbisa <csbisa@amazon.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200914143819.GC904879@nvidia.com>
References: <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
 <20200910123758.GC904879@nvidia.com>
 <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
 <20200910171033.GG904879@nvidia.com>
 <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
 <20200910232938.GJ904879@nvidia.com>
 <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
 <20200911214225.hml2wbbq2rofn4re@amazon.com>
 <20200914141726.GA904879@nvidia.com>
 <20200914142406.k44zrnp2wdsandsp@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914142406.k44zrnp2wdsandsp@amazon.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 14 Sep 2020 14:38:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kHpcZ-005yg5-3l; Mon, 14 Sep 2020 11:38:19 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf08d790-c076-42dd-41d6-08d858bbd380
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114127B9310330EBC47BAB9C2230@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqgOT+CCd2M6qBwJgGeL3PQR1rWxdZPl46Br5DvfxWfkYskT+1fHPlrRiVq1F7vtm/i99VWVf6dCF/EgC1c6WJ87RfpWxsJ1Fgq45oqbZhGfvpNlnQ+TLH6KYHJ40Wwf6MlVhExKcSGfXZYSTJVBty7rneAqNo+gQyP87AzrWLOXFWSCUYDjC6IA6LNt+ZjyzkY80oZjXpv4TAsBsNR5/5Pra5Q0Bo/V4eCGmPqjqx3wTRoROJ66z6hG4JfneWhQ3/mdLTRIL5ArZsn8X7XoRLm2KKWJFNAa7Ym9cLULSoJLHejiNOvkMEVCjTpqCO9so5XEtYrYBwxpN99qOCQKqjMzeNUpAHxA4ye201TKlVBRzRdNOtvjRPhZerR8Yz6t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(26005)(316002)(33656002)(8676002)(8936002)(6916009)(36756003)(186003)(54906003)(86362001)(4326008)(9786002)(9746002)(478600001)(5660300002)(4744005)(2616005)(66946007)(1076003)(426003)(66476007)(66556008)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1TYD7pF2UqYZhhp8kxGSMXTfUCOCjMNRCWouev4abflBizcDc4WwqsUjKdXGabr5wzvVzvo1sUmJEGZpMIybs+NnPqqRTICQic49uncbZdXrnYlyfc+R78wHRI3/UmmoWnb679Brng+NLFYI8qIN78YNARhcOEIUtZhhHTOhAsaAagmcy5yvNcc8K1m73l/WcLAF+fs05L2vw9ua8S0+WVNgCUOWkHfjm54GH1eiHpJhAYsh932BcfN2+ETO1Bwlm+hvUGye4/2g8d9TT/SJXtZROOghhQWZBPFA81My0toycO20EDtVQ+YXqUl9PxgUKMe/aMHtkyDL2Ef8hvWYwRgyfTeDE/S/kByAYwT53mDliWuCJYbir0YeqxERnijda48jLMSnnJwfz0fJhqWKD17w9zm2sPp7r98dd0ENl7TGyKpcp/FpNi1KeLv5O22qqc7W0zrddcbXegpp7cELFCJFAKF51qHltFajycd/LujKai2Dks+ONiLWryFvYDFNbei9fnHDK82weDBRmUDp5ZLLPYlBA8gBS/MNm/vFTRxD0NUdjHqpzIGWjtdiEETl+dDfriGbDGLfGET5of2W+bhH3jMF/yKANelllhtb35aFcBsWRnAJXKb27Ya/WZuvhcU3i154l12Z/npW1dxGNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf08d790-c076-42dd-41d6-08d858bbd380
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 14:38:20.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmxV1fXHZOF10wbRnI/dpF3j05V/XtFWDzDES3PoAPQjVnVN9WOK68qcfQamMGuD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600094165; bh=MIiz3oSTFXEpNED0JGdyDe4iReP+I23HHhr/KZ789KI=;
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
        b=ckG+UfN4+OwTmM/84OL+PNQ37QbyXpZidAQHHwRsYFhlUGhl2s1ivmwBmzvmUn1Vl
         sSS0D1edSUniADu4+eUxex8BbVRFdpJ44uzvDenuLNBqQyLVvn6IPJ5TxfW9JQezgD
         V37hYaMCzs2B01mL3SOT1JYSdbp4vqka7NFyHrgm0LoQurCeQ0fO4XIGiotWN0U+xr
         QHgOuZqdSTxPl/oTeUzePcsNfoKh4vSHY52iMPXIUHD9TF63dMNyjINh3gKHn3vJkP
         bzTn//PombRQC2JXt+q6XMqBq/1QdqlCdNAYPU9MGsS1/j+ihKMXKhusryZz2Gu5UQ
         vAhsAvFWMbhFA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 02:24:06PM +0000, Clint Sbisa wrote:
> On Mon, Sep 14, 2020 at 11:17:26AM -0300, Jason Gunthorpe wrote:
> > On Fri, Sep 11, 2020 at 09:42:25PM +0000, Clint Sbisa wrote:
> > 
> > > There's no DMA involved with this BAR-- the driver writes a portion of the
> > > packet contents in addition to the descriptors, which generally increases the
> > > number of TLPs if write-combine isn't used. Furthermore, this BAR is only used
> > > for writes and never for reads.
> > 
> > You use DPDK without DMA? How does receive work?
> 
> That was not worded well. DMA is used, but the first X bytes of the packet are
> written directly to this BAR instead of being DMA'd-- the rest of the data is
> DMA'd.

which is back to my original question, how do you do DMA using
/sys/xx/resources? Why not use VFIO like everything else?

Jason
