Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE85979CD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 00:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiHQWtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 18:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiHQWtA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 18:49:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7122E6612F;
        Wed, 17 Aug 2022 15:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha2aGuXa8GTQ5gkfLysK94bIw8ZnyWvuE+vaWEfC+Eq7peYqy2L88CLYm5VoG/aOjNVQZaSnB/7lP85YFWLTV7Z7X9HCpYQsH/0wLF2WtlSSVkEtMbShhcBn/Sb2gaxYT6O9h7l0KKA9Zc1iLsEfuogVSN7yY6ve5Y7IW1rRB6gySDZlEX4kqhhxFlznR8VrU18dQPGdW7/IY9wPjq07OdaeelhVyt2UBwIlSVl4JfYWVJiH/comxCOX9vpYUS3LlZLVRyBKb9uA3Q59UCV8A7yqQZ6uutRH6VvuGmfWOuG6OvCEEWl67buWTbpwzaQvZdqmHhjSakJp9bqNb6sLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SICfTvv1ip5CqkHJqT+ZmBqFI/m4UW13gmmfGt0mSpg=;
 b=Xf0AQwwHGg14NAb2krKW77prAIlY+SUnYMGuXcqkCPFO28Mp/JEKnwDjBDMkfwWsGFGYkBp01C2C57CE5s9Mge2VmLZd/oLBKueBiEgfLy2xAreUfEziwsEhM1JUcuj3efXuoYLGQugRn32aGhxlp+XSAjVXihB589ZpSiKacn3KAMQMKQE3FHDaEASx7tuUg8HkI9JVfO14jdrQvvuev9k79AuzZ2E+9+zMdOjbhXGZr6e+caCSZcIu8U1LxoPbxZjernOXVBs9IWPVy+cPbSf2hUKjQu07yJafoPhPVdLhyr97frb4BY+jhwONEMGDUuTDA8MFSy5eH3MqnFOgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SICfTvv1ip5CqkHJqT+ZmBqFI/m4UW13gmmfGt0mSpg=;
 b=pFXZEXPkw8Fs+CYLQdC9HDEnD702g1an3R5o9WR3D93QkNnwUFaCfYE36TWearGicKDFoIoWpKTcKjpbywkRPZRU13dwfINe/vqJjfVbbyxgsLaAjTM5lrQ5HqMZfbsd0fTHc/G4qhLXctmteE6UCKHtNkPN3cI6Fyq45yEuUoeglXcn0vNhxwgQ6SGG50+C7vAwyPpCTV1dI1L9bUKnSz0Ll2nJwEqpClBZwGHtBE0OI8C5NP2n4xR5VtUFQYyXI7yWHnnbR8QAc1El/vdrD3U6K0it1bOwTBd+7o/x72ZumshPuVxG6tTMLUdIHu5OH9VAhAqfQGVeQrJvP0Fxew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 22:48:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 22:48:54 +0000
Date:   Wed, 17 Aug 2022 19:48:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on
 upstreaming path
Message-ID: <Yv1wVfCWHnTdvPOc@nvidia.com>
References: <20220817012024.3251276-5-baolu.lu@linux.intel.com>
 <20220817211743.GA2274788@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817211743.GA2274788@bhelgaas>
X-ClientProxiedBy: BL1PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:208:256::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae88bd83-1c4a-4d6c-3783-08da80a2a96c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YK9D1bdLQU9lAIO48hfjsVphSjpZ6wm4eNTLE0HzOpiasVo34GOwrigWxk7+DvhlSphz33RZ8PiPHYC+eGwgkNTbTB8+UFVqiRCC5yV+8Ovqnxpu2ewxUjN0tua31GKss+/o/Unyhpz4wce1JRZbh+tNhpxPzrRL68iWoSrfHj+nuDo9Uv/WEhaOHN6HPZQil27xfYvHEahxyDzK6whNiIyAUwIHqzEZ0oP98b5enRi/G5GNYh02kT2nk8lzteD0zkUZPe6N0HZ59AeaVUCFsfG1UGnJZzPG3z11U9jxnbZEVmf5HCV6Av66gH9iBK9lZ+Vj2jWCl/kN1u5gO9jc2mYVHnlQBOvl2O92VsKwP9HfaLIagUcg0zj8xytnOdUsQxS6M74zaVDm3vWNCZoRB6PiREbCGikSCeiKLd2A5791m2h2TYuna0yM00GHghoi0vkQYXRFK4VgB9/6kJaT39ZcgmqubwD6TuEq2bRgHaeyIBpt37QYdPQAzpX/CwYP+TgVQ/B6CB1ngm5OH6FaEx+hNSF+IlyLbhwy5//ffz2wedfTs9q/FycFvtRPTNtQo8lZJuaYyuS+VoOvvMNbN4NfD0H8Hi8EObg+7ABx1rIr4ENLF9wxzovzb/+zmFFU9pgKpDgTWJOUnj6tZngcyUWlIHULcdnreKPTV0JqJ4gKLLhT9wvk8jwj0FWd5W2Wqu44ndxsuFgY/nRG9bJvdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(36756003)(6512007)(26005)(6506007)(38100700002)(41300700001)(7416002)(5660300002)(4744005)(2906002)(8936002)(66476007)(4326008)(6486002)(186003)(66556008)(66946007)(478600001)(86362001)(8676002)(2616005)(6916009)(316002)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45w6+aJE+WbNPdyGURTBfdtbbrghqEQ4X7X1m3FGDkphwF+qwgKabqs7BxBj?=
 =?us-ascii?Q?S1gmLpRnLN2iQEm+mucWCSqa2ogOdiFv7r4aw8axHO3pIUHd82EmxVB2V9AH?=
 =?us-ascii?Q?2XgOBaPkDBZaP+zWk+VQ/vudjGvN60UVGQntPBV2XGp+gzXQ4FDHwkTHMUS3?=
 =?us-ascii?Q?mJ65iDYQQsgJ1E6CtLltTryCCKM81UQxaK8o8+lXgOsMSIDQYc2zsPOAXFeZ?=
 =?us-ascii?Q?IacIb+vLPLlaDd0waQZkDVlG//m7g15yhbWfP74yMo6F2nxPkMaBNqeyyLKL?=
 =?us-ascii?Q?y9KqjX0U37ohfDHQzEaW0mSLvxqTSoWQ3N58lC0QIbO1Z+3ljueLC8m0mXKR?=
 =?us-ascii?Q?ByGGbtCyYGKQ9RD+o5LgS5G5b4qODY3SLuKhuMu6BtV7ExKxn83gmI0yx6yK?=
 =?us-ascii?Q?O5WGpS4ZAm0aoT2dVQIKN/2OoL/u2DI4fVyt4E502JcGaF0DhGm06RzwHvkj?=
 =?us-ascii?Q?Nf7440JcDxaNkGwH508bgK/CQIQBVXLiYbznS3KszKczLC3JhA2L1BFJJOkQ?=
 =?us-ascii?Q?kuNWqfSWsYd4BFI6WCP6n75/ujpTaiWbI82t1Q8u7CaKWcMGHq/13rRvxMz0?=
 =?us-ascii?Q?sAfw0+mwE9zqyYyHgAjgJhHoMLc/9RBShQLfmUvziwZqfRtodItw4+xcQpkE?=
 =?us-ascii?Q?HgUR58UG+Vr1a35UVme+oeBoXhQPTWKzOhNqhr6jwCRTvDARR2/wVjNlxM6/?=
 =?us-ascii?Q?4C7oZsLnEAb7lhKX8/kTMxcYLEfm8uTLBy/BxLSLbdjxxGtQhBfwd4G6DD9q?=
 =?us-ascii?Q?wOuVV/Z9nsN9qQAp6bHYPbs9sKttLMA6QG+BF198zm2Dksf5XhM1Zby3AMXG?=
 =?us-ascii?Q?SNPqwDLlCjHHXGMBixl/zv5ESsj535EELOZ5Ny87jRHQvMHOoEB4hsHSVNWy?=
 =?us-ascii?Q?KJlLWxzg/SxuvR0OU9tmiZJHtLBXPZwxltL52djFLnMtigumLpSg8jGr3Um7?=
 =?us-ascii?Q?/WWWy6LdZqbNWv2VShjWYuibkUmGdEwQH1076oN/o32cSpmEw2pDnuJwITBB?=
 =?us-ascii?Q?WvXza0EN8unsCb5PuJV/Erdhid+KMxZwm9U7KEYGeZsISkKgH1ilS80M0n4g?=
 =?us-ascii?Q?4SU9U0gFiGGmii97zeG04rKCeZTpbXtGYcl9t+oWj/AgcZkMbcdzB2wkrOGc?=
 =?us-ascii?Q?Ngz3mlubYQZoKk5LS/KE5ZydTEadRhyQT5JDZlDdsEapXB2Nlbj1TBpKZHyd?=
 =?us-ascii?Q?ba08n7hoqFo59TPrygUdLpAJycRK93QMPyYw+02+4boq3ZZxmmEA3vUDAJOv?=
 =?us-ascii?Q?SdKztr4nQjICUIhdzcQwsgX/aaQ0pmD5O3uXYZtKnExjJ6OHYN+6U1H21Btg?=
 =?us-ascii?Q?ka37p0qoBdgDUuz3ih/4HaMWFlKbBU3ASCzuPhKlQ9jC6cKvGxZLcCcmmdwP?=
 =?us-ascii?Q?h9hgC3/iZZZMlvB1gXILwl+UYsgmT8OnhEBYZVYgtJMZDJyEP+gCEV4pBMip?=
 =?us-ascii?Q?DnnBl84iPOIcDr2mBbsBRprZt1hY+IkXaq6rJnJ3sim0VcaAG5+CFli98/f/?=
 =?us-ascii?Q?sXs3lBxPv8+IocwZ89EUBRohIe2E/AsuJUgUwj8uyxdZqJ3xeI4LZSesgr7W?=
 =?us-ascii?Q?OVGh5nTRtyl0uAk8+AV21iUCg25fQpZHKhTlxwgU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae88bd83-1c4a-4d6c-3783-08da80a2a96c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 22:48:54.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKHzaG+4oqr/vivDQeJThWK32DE6m6sjIzaa6pf29PAufUC86eDz3hgaK4UEcdXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3041
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 17, 2022 at 04:17:43PM -0500, Bjorn Helgaas wrote:

> Does the PCIe spec really allow TLPs with PASID to be routed anywhere
> except upstream?

I think yes:

 2.2.10.2 End-End TLP Prefix Processing:

 The presence of an End-End TLP Prefix does not alter the routing of a
 TLP. TLPs are routed based on the routing rules covered in Section
 2.2.4 .

Which I read as saying that routing is done after stripping all the
prefixes. PASID is a prefix.

Lu, you may want to quote the spec in the commit message to make it
clear.

A strange choice in my opinion, but there it is..

Jason
