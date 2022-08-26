Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D285A295D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 16:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbiHZO0m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbiHZO0f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 10:26:35 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26163ED59;
        Fri, 26 Aug 2022 07:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze14l6JEoaTVNHW1NvMOiEDJ+6hUtpybe0K3kiIjJhxFG0YHUZjpVRCDpHRslrJWZTqmi6FVglxd7QKE+h+86GCTP15ih1kYy2ibVx5rOIcxBxILdecqx7qGs1A8ft8TN2l22mYMs+iQzCo3QcX/RWjKwOSQzG7qqSLBQCpMv/eA/HhJCGGL0N3arObFU7GnqKtsR/0B71Pi6IrMpgA49qcSjqUld3W2sYPL0ricbD2/1UPINGRGEAl+QnmsICfiI6Axood2UrGiwP+w9GBuqRslpnLSbb5OmaTgmvLg5ImzX0ki/i16Zdhfdw2F7DTqnaqPAGTpK/XCGC970muH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8obkH97+nBvB+rIPVuA+gbhpjvsA/p3prsQUJXDlEEA=;
 b=btNwsjNJwFTevCrjHq3cA0YKUSlCUC1728erd15Ga6AcNcjVMMtrhv0g9VwqXvZMuP0gguxvg13rwtp0qkVjkooKY72bu+ssC/IiyE42veYpAG/Qy7qKWtcqdE5aYU0aNqFBolZ9NdSx8E7v8GgzvYVMYRHu/MP2MrbM4KKqocO28BVxlVy2fDKdMeUlqEN9/+NXprNXzQAQz4UbvWtNPL6LfyLBaSZnHDxOWVbLQqsFIL517KT96yVpBzvCD2oQy36mNtZdGRf6w8wgpfNXD9Tf0HkzPzuRLrLZhU65ig2Eu0hx3Kxm0PNJz79vVioPFzT53W/JTdh+yrfcjCxVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8obkH97+nBvB+rIPVuA+gbhpjvsA/p3prsQUJXDlEEA=;
 b=Ov5HFPGK+dzK+ISIDjyTft94xTRGFXHX9q1GmMm/lXPZy+QAMQuUd3AqwH4QjndwOeS7Lo4fjR6Gb8FGwOwfz8bJglWzm29XH8ptvw0w11WYF+RXEvCHC8CVbvl71shA3Jr01LL6r8RHSBKCVGGKw5iEonWDP+z9pWzAN1HU3dEijYM1iccJ6kQ8uCTsj5gH9IWuH38C0/JlotmGbs1Dxken1uGWbMBmQE++6ZAuM/1oDR9B9i+Q7nYIa7+gKt2GSQsoTinVRXXg6BTgNI4f3GWJw4xzOF/uHWw9RLx0UUc2PwyKDtXs9Nnx0k4nedY1uzFtgxdVPxvEa5L0SHut6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:26:27 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:26:27 +0000
Date:   Fri, 26 Aug 2022 11:26:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 04/17] PCI: Enable PASID only when ACS RR & UF
 enabled on upstream path
Message-ID: <YwjYEpydbJ8z0Kmf@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826121141.50743-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:208:256::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51dcede4-33f4-4595-71e9-08da876ef663
X-MS-TrafficTypeDiagnostic: CY8PR12MB7363:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIB6sHlHWmWrDq+uHsvE7Y/BCmBcHhDu8elS3WK9Y92R+YMQmShgWmGrJ2OZUdZCqbICfFGvBpCFiIeOylhiLDIPG3hjYr+jNx9oFiQwH9E/SdxDcgUYUyKlkOFP7nGGp30lk6hRu1GfgoVozBbanlYjvKqJkIwOiN6f6xCatPSdpYxGuKXazY3FDzH8ZW6Gev1wnGccqitXY3jnYDu335etpP1H476TpU6WokvcsdmBCiklCt/bXjJJH0xGfQtvsOpUwtaXSchhsXOBtC8E3/Yc6mR6OtfoQrB8WjLJC1Bmh0eW6x53aKcQWC6MyPkBk4ACV95O4ZQN1KvdHjc16s2ArXYBUT0DVe5mTUiKmOuJsmJpW7UaFEINI3jKjbFaA5sjhGpRsWl2fELBrV5VRKBvqNnH/Q5xcmBSrEzESBfer0xO9Q5hi6+IlZGtJnJDFFjiG3DaUK7cOWnhc55FPs75srz302pUXgkqzIR9P0gGlhXCvcdhhvdZM8PkNPjIG9yXpmDAfEW9SnmSae4N5doCnTH+B8tlLl7FOE2S4OUEW8sxJmJaAhYa4fPITUiKz0J+o52nh7B18HtQb5EAwVrrFBFM0OduebT/S0iC4gsAc7z0PSpBGU3CplYpzNensROJHnWV7x0MGgnBCgtOW9UnmCuYinDojziU4P0jFg9C4jvW6xKN+Aa1lmqqi7NsyX/Te0vFQRBwDKDq4Yxb3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(6486002)(5660300002)(478600001)(54906003)(41300700001)(6916009)(316002)(7416002)(86362001)(4326008)(66476007)(2906002)(8676002)(6512007)(26005)(6506007)(66946007)(2616005)(38100700002)(66556008)(8936002)(83380400001)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bnkSHRha/rohSZH28hmANvWRrn4FHIRUGCyT62Juds/IsvxGD1dVNa6rpz3E?=
 =?us-ascii?Q?tWJsX0jQgRnkNY3nkkPYge961CWqBwv48OGChrH6NnQms8ln4RYXNkDh6Qvk?=
 =?us-ascii?Q?2wJhrokUTar+9H5SrDphZ12dBNKC//Jt9ku4+Vz5lfHLRGfA5fWA7YvWs5RF?=
 =?us-ascii?Q?be0jS+jMlMfV2VN/Ere7H2Z137xHK/izWOthWLDRkn6DiHuPj2aVGbIObE9S?=
 =?us-ascii?Q?GLv9blJhFdy+KEeaAC0QbPJRhNU9XnxLcTd+x3F0LrXhpt8M3dFLiikSPC9X?=
 =?us-ascii?Q?Ca7SRd97PL0ppd/2zw1jEf0pTFxGNcQSl7SttU3z2H8kWrGd4z4rS3hAuynp?=
 =?us-ascii?Q?eXGrx/jZX2VZEBiLqc9TuMX3iGmbSMAxcuvCoIKLUoD4KcS4dzgYFvB209qD?=
 =?us-ascii?Q?9SsdIv/kgxmRXnCY/UpZOT61LEdhs3Sqg5RIBOgxMvlGjga9QFC2UW3T4qVW?=
 =?us-ascii?Q?fnE4fJUkexNZEXX3WG2zXN/vmonP8u68M8vJSKEtONsDZtB8/DO1iO19TjTk?=
 =?us-ascii?Q?EEJe7ziQ674t6ovex2c0msJb/65C7XnTmuk39wiQv29ITsAabZhSwIf0IahZ?=
 =?us-ascii?Q?0Zt1SqNL95qFrj0cB+ylUZ9f2KLEHcjgNUDBY3GK5xwsueKob6xNtEj9Vnhu?=
 =?us-ascii?Q?6frXUOzwgCrIB7jt+0eam1LaLVnpTl/LILsu+EpbdjK0ZessT5QfgyAjH+yL?=
 =?us-ascii?Q?svrRTEM3Dg9XqKaXpJdj+PY2c1suJtd/J09noF1M6KHHwI4EVcWBBBTXj/v+?=
 =?us-ascii?Q?6NVb4dSkNcSdm2laW8A59iyPyy0HNDpX0L1Afl/ZOMXqcjufMqqvqkF/rae7?=
 =?us-ascii?Q?mfdtg7x+ASse08JLnoRxLktIWJfHdOEukudRpDTy4SH8kvzz35YWvk8wGFgT?=
 =?us-ascii?Q?Os+7Zi0Ijj6TV4wV7CXb9GEPlDaCeMH0EVN2ExEXQpCay7FIIGdDGplHKsl/?=
 =?us-ascii?Q?OP84/CgZft59m/Jhy6xCs8DLAA9FBExDinqNej+aaj2sG3YvgckJEg/xbZun?=
 =?us-ascii?Q?Js9D4MFCj/yTjz0N46jS0/JfymhIRcUMRGchxrxmSLEboIujncpWMV1GBMJp?=
 =?us-ascii?Q?vSMOTVzoUFHrXRM1rYeqBWZ507aJblFkY4WZgc+ozSSPtYlwOkgoiVr582F1?=
 =?us-ascii?Q?DLm+CvZexrXQw/25Hte+tJzmE0Y0JYSnag2ZWfQC/iXgIWtogfLqaqc+g9lt?=
 =?us-ascii?Q?Yl/7cVH/RhiU+xbtiAOyX7zxQv7QoRA2EKdZpA3WwK8BajQbOtyHTB8SSU3B?=
 =?us-ascii?Q?Kw3ZRMKeHpqWn1yyVKHONU/ZrU0OjtQYWL3n67448j/bkDQD4sXz/03jdhhn?=
 =?us-ascii?Q?riXd3kmfXA3h7B/MCe1qTaUiLUQHGkHsKB/T7ywsgPPryJWwuFotDAMctufC?=
 =?us-ascii?Q?XXutUKoqNd30vP5oEHZcvjSzeZUWOBvhpxgSQioqZGb3wYGZ5O/SetdLGPhG?=
 =?us-ascii?Q?p4fdFYr+pGq86f/2owo5DO7r9kvPlTyRkEVh//JDi69YOAcJFJuaH2J5a3Bo?=
 =?us-ascii?Q?G0XdLHgGKMW+zGNu4G4iNXgmgwTzKYSGR31sfBfBHkcWalsbV7dDbJSsFooX?=
 =?us-ascii?Q?sCWAH4DACJcKV6VP+Kz7CrhAQym+eiR7eG0CmiNB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dcede4-33f4-4595-71e9-08da876ef663
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:26:27.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJ3MAcm+eg6YpWluXztZqnevmYhahFjsO0seQPdxAeM19Nir5izz9iiUXijygS/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 08:11:28PM +0800, Lu Baolu wrote:
> The Requester ID/Process Address Space ID (PASID) combination
> identifies an address space distinct from the PCI bus address space,
> e.g., an address space defined by an IOMMU.
> 
> But the PCIe fabric routes Memory Requests based on the TLP address,
> ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with PASID that
> SHOULD go upstream to the IOMMU may instead be routed as a P2P
> Request if its address falls in a bridge window.
> 
> To ensure that all Memory Requests with PASID are routed upstream,
> only enable PASID if ACS P2P Request Redirect and Upstream Forwarding
> are enabled for the path leading to the device.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  drivers/pci/ats.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
