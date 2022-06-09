Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DADF54452F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiFIH7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiFIH7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 03:59:14 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815F1016;
        Thu,  9 Jun 2022 00:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBzZDLG0YotQlZsWaQ/jdcKl8Dxw1Fakui8JYfcYvgwd0meWDzWBZMCwlx2efF6hWWveByXapa8xOzSv9kP2FKk9Key7XpYvckx/Yo1OtzyygEDe71oDK4eJqZsJyRBcP+mLC9wfNImDk/RW/4wLRKVKi2Xlqnuf7dNuwhE+x1qS0/GstqDJrYLw9iXa+SgOB8A1mladnjNlufDHWC+wPaMEzaHQiFZ8nZFdzC9o+B1WovTRSLJQW1VzU+iPYCy5zSzHHw2YPSiSRsU3s69cuSk/uUgrr6E5r3ZCO8U/UMGtG4AFincFcIMYD0DUzaLirTfQ30BwWAN+qKCPWYJ3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeJBYcA6NgZY8xLS2mZD7PRMf/kth9qf5IbX+z4SbBA=;
 b=PAM6JSFo8QMOecHieKj+OAxDUvKguVocjoIrzCFQrI3pnyw7qHrzQrI8wZI7VpTtkAOIzVDWNObmYUwG523oRIuu89awcUk57TPyicw+81uORHG8FCn2gVy73boIOCA8kkQuq58inFVW5sxluEMW3j6seOz0KvkVtYW8L3Z4hVw7oQzeXV0WM62Bf0mpDodMTXWnTKKws3LKCx2xqVk6+RcF9CL36D48A1FD2vpd27M35E8fcgLY52+gF9vYKFGV9p8jdt/VZio5Y9SIFTIphptUkN9aqMoitAMTncu8w3u0J9fhVloPY0HsWnRAaUk1RKlv1/raCQgXhFXb4ay3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeJBYcA6NgZY8xLS2mZD7PRMf/kth9qf5IbX+z4SbBA=;
 b=MfsA+fY1JdtIPT6AzVPTioO1triGDEGUtIVWJwxH4+sIJ7FkVRk8tb0tXNrFks4Y28voKXTDxo9Oty3s/MMp3KDNVBY8mQqPu+M5kq2yrJKaZy3zlqm6izRfUR+rFDndcDdpxG7+88RlWTb0JXhLVp5SG5L5OIruuiyjV2b3WUA=
Received: from DM5PR21CA0010.namprd21.prod.outlook.com (2603:10b6:3:ac::20) by
 CY4PR02MB2312.namprd02.prod.outlook.com (2603:10b6:903:c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.17; Thu, 9 Jun 2022 07:59:11 +0000
Received: from DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::f1) by DM5PR21CA0010.outlook.office365.com
 (2603:10b6:3:ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6 via Frontend
 Transport; Thu, 9 Jun 2022 07:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT009.mail.protection.outlook.com (10.13.5.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 07:59:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Jun 2022 00:59:11 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Jun 2022 00:59:11 -0700
Envelope-to: helgaas@kernel.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.254.241.50] (port=57120)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nzD4R-0001e0-2P; Thu, 09 Jun 2022 00:59:11 -0700
Message-ID: <a403b92d-00f1-885f-7d1b-0fce82b50993@xilinx.com>
Date:   Thu, 9 Jun 2022 09:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <robh@kernel.org>
References: <20220608191437.GA411770@bhelgaas>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220608191437.GA411770@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cb9d3c7-139c-42d2-4aad-08da49edf078
X-MS-TrafficTypeDiagnostic: CY4PR02MB2312:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB23128F5CFFDD8634E5995C1DC6A79@CY4PR02MB2312.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hBvAm5NRZg2oXCW9fioayqn5EoWEooJ616MLB9QSuiLQ14fs4+zsZ3kLDl11PxRWZXF0jqjicBQabFUJEUcDuUpmeH57swSLHnFhDFGPuDGrLUOviPQrTUGDyujsZBDf4kLrTUP/so91J7b+L2m8WDs4INUi1aGLwhRMK+iKoxpKybclevXzKnxOPPrqUzlNLors51sqXtLyIj0HZS1//r+lni75d6tNwCAm62kcmvvKgzeGMQ8PSQ8O2wQ+5QjKo5s6PoFFv1r6s81WCmw4L0LwIQMMjdvg+9Iunap3lxAo7Sry4Dl21F72xLdNSglrT2H5DQ1pM/r1i/JS9hHNUCr/iAQjKwcsGw6469MxjN9wcod1PkWwNNWwViWcl2etXXMCbfvYmfoSX5gxThwEjvOXejfK3QBSsIy6v6BWUxOdCNiykQMDveEJDDMbCQX+bEIJwpNHVxn2JW18P0T249297R79eQPBOme0PWls3HrjvJiiUNSEY9Yl1WY5PZqVVa4UqSUZtzEoSXikbmfDFkNaN48V6lePfZHtmQrsrqzN+oqO5e9Gm54+csNTyWCTkVnUGLd4Y2FzvIMveoSBRqyGN/GHxBgmq7NGt3EAbYvs5VaZM4ffMGQtaUoGCdbhrtA2DoetYUm6/nFsTRlxUeFq4DSStw41CrpvAHXUieFQH34kuXq2YxkDTiIkcriCJkwhYMrM5zFFJbe813b5p4N+ituHdMl9q9+5RHkQDM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(70586007)(4744005)(9786002)(47076005)(82310400005)(8676002)(5660300002)(4326008)(186003)(8936002)(31686004)(336012)(7636003)(83380400001)(2616005)(70206006)(26005)(36860700001)(2906002)(6666004)(356005)(44832011)(36756003)(53546011)(316002)(508600001)(31696002)(54906003)(6636002)(110136005)(40460700003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 07:59:11.6057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb9d3c7-139c-42d2-4aad-08da49edf078
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2312
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/22 21:14, Bjorn Helgaas wrote:
> On Wed, Jun 08, 2022 at 10:10:46PM +0530, Bharat Kumar Gogada wrote:
>> Xilinx Versal Premium series has CPM5 block which supports Root Port
>> functioning at Gen5 speed.
>>
>> Xilinx Versal CPM5 has few changes with existing CPM block.
>> - CPM5 has dedicated register space for control and status registers.
>> - CPM5 legacy interrupt handling needs additional register bit
>>    to enable and handle legacy interrupts.
>>
>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> ---
>>   drivers/pci/controller/pcie-xilinx-cpm.c | 33 +++++++++++++++++++++++-
>>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> Per MAINTAINERS, xilinx-cpm lacks a maintainer.  Can we get one?

Bharat should become maintainer for this driver.

My fragment should cover xilinx things in general in case Bharat is not available.

Thanks,
Michal
