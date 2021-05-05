Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF684374908
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhEEUFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 16:05:22 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:44000
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233381AbhEEUFW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 16:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxqqi9HMfOHGJRfIvRhoBSI52KgAm7LoI79OszJJIkhvQbJ6QTsDHL3y2t/viKpnH+nGJ9CPKWSXO0A78tGBmWKi6pOFLEvS7pGSTGisQFX6JghHH9LIiD+FsoJLlk40VGBsfxKB5HrBLjUeDQ8zaFaWxv/Fxk1+QdauhJTrW+xSN1wpJODZycDFPdHQRg53f0cEs5yX2DZ4/twr7KXy2ta7VAEVQEEKzwR0oVnQd1IiODuj4J7CUEgxDbGsKaZxvyHnGL60k18uTzNOJfWjqAVPTUCX3RIRpjpZrgNZTyNYIk9/LKTC7+8iUx6R5F8vDVIuM2KWpVeTtpA1POahpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ADFiv9JHKHE8WhOguza/Zu1b/rysUM8gGaAti1Z1SA=;
 b=nrlJROhGZsgcohN1+fYcRqazlY2hUIY/Yvo/KKc5yR+DfNs5c6m54x6GdxpHhdggYc4oyKNqSLVZjI+7HzGohAmDX8nFnf6b/BKbCJxPwb7M3P6NB8SsgzFnCHbZ8aRfeiukLcKWfGNqwpf1d/mkf3UO6l46xEkKNI0kbjHWtanQXQVAw+kQSWtHAGpBfyyEV9iObJPXD62E6zO8YqvrNfiYrzpgUk30f61XQgYEFSv8VTpP2NE0oHgmlBpYiKcAinZfGnSNtPVZLka/1VmZ+/Muqvythfx3Jo2DqAScKBj7vWvJ70vf1xGXqy8VRN80jxmoSgs28w3R8HGbD1JthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ADFiv9JHKHE8WhOguza/Zu1b/rysUM8gGaAti1Z1SA=;
 b=QumhVPrxUqwMLkzCr5tkRVH8JIkI16jSRs3COFhSJ4yQmcs7O6zuxMXx6rwW5hCIT6/GwhB7z+It2ge1D9Pc06V6Sa8jM1s4rQdGrEophRbsiVvvu7lkFPhEW5UfioyIY1a1Krtw1RrfTN9TQeNyO27Rgpv89VYKNi68V/lgSpDkS1jdn+LLDkUHItTAblercXJGMxDk1evk3Q6SlvgpZsRGDPuCwUqYU2SpHkpBkMe1VZBNQLqByQ66UPCwS8tD5K4faA0YuebEMkR0hif6Fa4PxOWU42x5qFRXpmBbgltnNb9o20eP0nOAVQAH+rBdmdaxLDFAqjtRjc0o02vF6w==
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by DM6PR12MB4864.namprd12.prod.outlook.com (2603:10b6:5:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Wed, 5 May
 2021 20:04:23 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::68) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 5 May 2021 20:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 20:04:22 +0000
Received: from [10.20.23.38] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 May
 2021 20:04:21 +0000
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Vikram Sethi <vsethi@nvidia.com>
References: <478efe56-fb64-6987-f64c-f3d930a3b330@nvidia.com>
 <20210505021236.GA1244944@bjorn-Precision-5520>
 <CAOSf1CFACC5V1OdA9i9APipTUE3GmXu487vt-btXWk5rP97UAQ@mail.gmail.com>
 <20210505174032.sursnpwkfrc5qji2@archlinux>
 <20210505131357.07e55042@redhat.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <2e64d906-d398-a859-413a-c7ab3341de88@nvidia.com>
Date:   Wed, 5 May 2021 15:04:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210505131357.07e55042@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0672493-dad1-495c-dcca-08d91000fa16
X-MS-TrafficTypeDiagnostic: DM6PR12MB4864:
X-Microsoft-Antispam-PRVS: <DM6PR12MB486493075353421199E71835C7599@DM6PR12MB4864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWY61ATLUHs3Zhx5sVo7JS7Mg8QdMll35PdEv1ZKBFuELFnfi1FRo81g17Daql/7C8D65iCSKo6ZBRBXC7yc+wHbM8/HIT/yrOCx0jZxPVCGPLRGeIaiilfBi9W9AQzJRxe86guCkOJZgwMXn46pNzWQxcacqLOixY56D/th/9CDGDFDpkodzsrAiOEdX2FpyTWWuS0rIXFOALLpr6DJ+Ib9WS1hxW8YatwgUSPKhHVMv0CfRnWV6+avxv2sR02AWJer2jY+aoCQWI208EC6mSM58T3cEmMGD/u0jcOoXUxtSLGkmcijaQdVeBqmgBZTRApaipYUh4LlOwk1EQ2fVRQJKgzIgwwMWB8IyiY9fYlhpzInhitDSoTq+kg1rpTIuC6uC80xarz18ur/rAreinypFt65ZDOf+rAaIMDWEU/oDiir4GSuqur+0EZDZDOHwcFnN2GKfA3HjBhB+RWm5Z7kIiHntAagkxxVb/9qlN7c1s1NuRoRtbkkHy+SmL4+ZZn2d4qGWvVRhsJRBCkAtwGPugL55eXJ0a0xRxiQFAcBDeF7TtsRbdAZUJkPVEH83pYK7ytMoNNsDv7KrBDvPNd53yD6zOz+I43I1HNfD4hrxbIv7DEEoPYaFVTQTnXZD+kNBliwy5FI2/ml1tlvyoK5/5oHeV08V0d595PvYcRHUEeZ/rkGA3yBI8AisvX+
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(5660300002)(31686004)(26005)(478600001)(8676002)(7636003)(54906003)(110136005)(4326008)(2906002)(36860700001)(186003)(31696002)(53546011)(16526019)(47076005)(86362001)(82310400003)(107886003)(4744005)(70206006)(6666004)(70586007)(36906005)(316002)(36756003)(336012)(82740400003)(356005)(8936002)(2616005)(426003)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:04:22.9723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0672493-dad1-495c-dcca-08d91000fa16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4864
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Alex for the detailed explanation.

On 5/5/21 2:13 PM, Alex Williamson wrote:
>  I'm also assuming all SoCs integrating this GPU will provide a
> _RST method, but we're also disabling SBR in this series to avoid the
> only other generic reset option we'd have for this device.
All the platforms/SoCs which contain these GPUs will provide ACPI/firmware with
_RST method.
 
> In the more general case, I'd expect that system firmware isn't going
> to implement an _RST method for a pluggable slot, so we'll lookup the
> ACPI handle, fail to find a _RST method and drop to the next option.
> For a PCI/e slot, at best the _RST method might be included in the _PRR
> scope rather than the device scope to indicate it affects the entire
> slot.  That could be something like the #PERST below or a warm reset.  I
> don't think we're enabling that here, are we?
No, our_RST method will be included only in a device context (not _PRP).

