Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F47744307
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 22:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjF3UAG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjF3UAF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 16:00:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00301FC1;
        Fri, 30 Jun 2023 13:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJHtTGw5aoFoOQ9+hTtSYnffJlgz70G3gYl6SyijPQnDuWGcp2fecEhD6FxOZ1JHMrj3hETlIm6sVIZQCflAV0X08T4hNnsoDq/C/BJFYqkABO3DH3JJH0CORN44TPDY7wRpD2n/foFbS3PdmkQKAdTVWjSsS5PXgi3R4QOQBgsCG9TvnlHLx4vraBqnlbA0WdTP+f2IvysmOjbtNyg7o/TqfpNOeiMu1oHsCQHTX8UQw8NMPtuvhRmHzxbYF4zOg0VfL3KOA7u8xU6tUpBNDpU/sfipfQB6344Rhg4agBut0lmL5at5r8ZUvYIxPnUhzhxhbwR/DtGsuVeyOwPLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcasFk97ljDjKsO3gI3Gv1wsnlRYpJuPfekRKC+UplI=;
 b=FnWZMrd3xmICj9P9VNDIQF/qex11+1eRZ9obuAYuV2uJwYUQocUFMpGRatUeyXm+cle75uuDlaIbz40eQND4GSlvYPM0nYAKOUABdS16IhJ+EtYctpfjSUXrYKgmm/vtx9DuN8+TgcEWlDAZdPCIaAoO2Tdh7S2uO6OtSBqRI1SImEYnURtYx0LSPk9gDVt1SY0oVKqDbsa2jWxEj4o0KjTPS7yW2f69UYcMenvBDOooWpcH1gx0VVm5A7epvP951bDoAp6rEWp9ShraYcSlLiI/F3G3kVAAAGeQfUHYq6dP8RRGXSARJp08uQDKfh9RLIZWrd52Cdh0PSpjCd7joA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcasFk97ljDjKsO3gI3Gv1wsnlRYpJuPfekRKC+UplI=;
 b=Ciyn3r4yfxMx8vU9/Z4jrin/9v3Y5AK4htx2Qg8TV3D6lMviqmSwyu2BBw+t3K+F21K+XykwF7IlIyxoUrM5fXwlavNABfsdLYOLx1AhDUzzT/Z9Zfi0c35ZldHjF4KwAzoNVCuuOx5wpvVpUhx5+1X764jANDMBIK+lQAmVVW4=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 19:59:57 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::78) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 19:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 19:59:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 14:59:53 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 30 Jun 2023 14:59:52 -0500
Message-ID: <1c41b8e1-5b13-463b-c522-6775954c0ee7@amd.com>
Date:   Fri, 30 Jun 2023 12:59:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
References: <20230630164821.GA483874@bhelgaas>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230630164821.GA483874@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|DM4PR12MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d53abf-3882-4d14-18ad-08db79a49457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1K+OchoippdYHbjSUjK+us8XeZOgi9N0CypOfGoPK2Rkol0REtfZqCmw77S4cxzcO+TyAZc8aG0ibKeB9IFuXsViUF7JsJuDMh66ACkQRERiaw4N01YbFrbvQcw/hTjuHn8ZV5hMN1AG0YbcE5ioMj1jXfdHU6cexw8RDIPB2htUUGVjt2ySsaOWJf0pUmkL36pglQAaWn+siOX8rhnykd/hung/87jDgP57kjhCVlXhciqTW8vG9RGY+sodeZ9a1o/N4n9+d06eFLpva5u/xq0ZVUD6Aes3e8WYXPBVwdbxfdI7D8QCguJiQr0fFEGfwQxfVcRNKrDf/9/Zrub/w36HgKh3dgL2Vibo5C+5xsfVWqjMCMRGLXwDf60zbH3CBFbo5sWC/8PwFzSLLQlEFpZZ9Mscx/Jt6wrJC/U3y305O7Z0jPM14votok0K9iNOS/mhdPD0ui4ammoxvRwPuNcLlE6mX+Qokr03hAgRNyCH0tO37/4kQdmIpkc79Ikz5J3Dl73MoEfKcldVI6w/5Pdyw29pnE/kGAt0MnX3FuPpK3sJC5xymoOu6beE/9Iv2asORG5vnFSx1VDNHWcXdj+8HxKrG4qTUwjyjD9m8xRkjm7fe7+b1lBomjYRpku32wwFyR5veFOKJjpZem8Qf04CrbqLXe0cEs1Dins2ae9ds1N0MjfXCo7eicKtH91Q2x0v7GXikm0QV+hKuOZ440WI/7Gdxgxh24uwMhXuXEfdxyv1bEk9NSI/HQupsh2B9HEIkbcKnS7YmGfzzapC4ioV/N9wEDGP/xytIYOuxms=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(336012)(426003)(47076005)(40460700003)(83380400001)(2616005)(2906002)(81166007)(82740400003)(356005)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(110136005)(5660300002)(86362001)(31686004)(54906003)(16576012)(41300700001)(966005)(4326008)(70206006)(70586007)(6666004)(316002)(478600001)(186003)(31696002)(44832011)(53546011)(26005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:59:57.1671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d53abf-3882-4d14-18ad-08db79a49457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/30/23 09:48, Bjorn Helgaas wrote:
> On Thu, Jun 29, 2023 at 05:52:26PM -0600, Rob Herring wrote:
>> On Thu, Jun 29, 2023 at 05:56:31PM -0500, Bjorn Helgaas wrote:
>>> On Thu, Jun 29, 2023 at 10:19:47AM -0700, Lizhi Hou wrote:
>>>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>>>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>>>> the PCI core discovers devices and BARs using the PCI enumeration process.
>>>> There is no infrastructure to discover the hardware peripherals that are
>>>> present in a PCI device, and which can be accessed through the PCI BARs.
>>> IIUC this is basically a multi-function device except that instead of
>>> each device being a separate PCI Function, they all appear in a single
>>> Function.  That would mean all the devices share the same config space
>>> so a single PCI Command register controls all of them, they all share
>>> the same IRQs (either INTx or MSI/MSI-X), any MMIO registers are likely
>>> in a shared BAR, etc., right?
>> Could be multiple BARs, but yes.
> Where does the PCI glue live?  E.g., who ioremaps the BARs?  Who sets
> up PCI interrupts?  Who enables bus mastering?  The platform driver
> that claims the DT node wouldn't know that this is part of a PCI
> device, so I guess the PCI driver must do all that stuff?  I don't see
> it in the xmgmt-drv.c from
> https://lore.kernel.org/all/20220305052304.726050-4-lizhi.hou@xilinx.com/
>
Yes, the PCI driver will do all that stuff. This xmgmt-drv.c is created

to just populating the devices based on fdt input.  It is removed after

the unittest is created which can populate devices and verify the

address translation.


Thanks,

Lizhi

