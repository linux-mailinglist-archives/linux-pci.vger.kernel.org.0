Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389C35265E3
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 17:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381886AbiEMPUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381906AbiEMPUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 11:20:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D5C67D3B;
        Fri, 13 May 2022 08:19:54 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=c0EtEFy7ZIDa/VguUBKw4Tb/KFP/b2fCOqSZK6pCmPetbB5Sgju7JZqRePCrMfudrJdgnES4cFWz916+FLSGiqRw8U/o1ayE0WI7gdo27Euovu7C5s/6pIt45wTuoNhVwDgTH7MTHsDgnnMft/oWogSEHwJ5EiD/apqIyiUg/4+PyYgGsOzWHQSRyhwmumkh/VSB2kFM9775s/n0zJp8PAtyAQQUgC2gBNZQW9lZ9eg074k5Yt5HPSWe1GC7lLPlAauuyaSIIuKJe3jW254WXL1rJtdLDRD7C12dTdjGnwMHHJW6R12IZjcSCOx1SnPVPcUVXGLhZCrCsWmAV4Mu0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAjxc/RPPY3iT6yLtXygdrZuuqNaX/6cCUTsnQX4luc=;
 b=GfcIgrNpJdSqquINc5L2P0LTKtSLejU9LUrF1YonLjqjOtdym402UhosPQSS8ZvdHEp75IS6ZLxdpZwYrJiB3f1pFkNDeaqC0pyFrkaty2TpyjbTRLTVWRgSbAtXPq8J0cVq+vi4InSS8MYuxZMqP+DWLKhFTvzYPu8TQxMhD1kWsxDtQiDIl1RoNY5RRV4F6ApEWN3K0trGn3J1Cq5tRZ1KzK/t9X8LzyK4ye1boPxsoHtsh2SRqFBWCG0BW3e2D75kl5SAHjgDzHqpQFBaJYmGQEzKfqWVcBrWAhnxX7obJHhjyGJAH1mwKCieddpsVf5mBejeScVYipiA7WEm0A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.83.241.18) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xilinx.com] dmarc=[1,1,header.from=xilinx.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAjxc/RPPY3iT6yLtXygdrZuuqNaX/6cCUTsnQX4luc=;
 b=oih6gUKqJ5Z+Ep+M8YBgtSTLvrh2kTIcfiGbFMiUdXn46rMOH8Q3DOVI79m+kEe3xOv3ie8806kJnK7v/HwbyKEI6p7KriP/ujYEIVeXpMq4faNbEFZMlCeJ5gRRyiNSAQKGyqE0JA2g2VOTLKy84YiwHsH7SZT4VLahhy5w0js=
Received: from SN7PR04CA0230.namprd04.prod.outlook.com (2603:10b6:806:127::25)
 by MWHPR02MB3280.namprd02.prod.outlook.com (2603:10b6:301:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 15:19:50 +0000
Received: from SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:127:cafe::63) by SN7PR04CA0230.outlook.office365.com
 (2603:10b6:806:127::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 15:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.83.241.18)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 20.83.241.18 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.83.241.18;
 helo=mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;
Received: from
 mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net
 (20.83.241.18) by SN1NAM02FT0052.mail.protection.outlook.com (10.97.5.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 15:19:50 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net (Postfix) with ESMTPS id C248A41D2B;
        Fri, 13 May 2022 15:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAP0oDk8zd/mzHSq7kOEweoC/upJkMv0krUP7g9fmkkXmARr8UUqmYrvss1ttf/8fY5Up7ZSmf0eB7c0W8GtQwl+0RtXrhFYbeYIf4JojujE/6hd6NKXH9QIdaAOXBFgtTxkC6WQMF3ma3hvPsG7jWl104HLG6YrZ527pWJZcInqeFQRM5BfM2GUaYdZ7YdG1gRCJvSBAt/Bsk/UMw6zxUn9gsj43IOcnSpSZQcAeVisPnPf+x/1M7+uSpz106OB6vr0cWJjrPDloYdnHv6cydxQryItQscIt+MvbiO1B4IZN/k4KF0om7u3qHBewSBswNBOrROmI+dZD4OkwR2Pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAjxc/RPPY3iT6yLtXygdrZuuqNaX/6cCUTsnQX4luc=;
 b=djJPtAnmVRPJE94g1ieJ2dI2Si0RXtlj6hJatyfx5Mf0Vd0jCQVqJuCXImdX582FYzkXeuBsTyqdPQEPfUuefnwEA+gMHHbSdVv6BPpT/WU/d69fVGYuFmf4byAYcyXgYHmEi73/aEFsuQYYlQdPeMZvG10HQSaFr01FW1G/e/0dGLymSIzYoyKK/JfIXwNTMriQzy/lKqw7ZET8m1duB+bX7akx8QRQ/4S30+5PfCkRVva1W/nHSqSwRFKEF7Y4jF0GhmfdWauSKlSO1XZu26WHhixpwRUsQMufSCL8HCO56MgK3YvWmbAhRfWxgku9YlbpyY+6XnOHFBZE4i2xEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by CY4PR02MB2712.namprd02.prod.outlook.com (2603:10b6:903:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Fri, 13 May
 2022 15:19:47 +0000
Received: from BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::a2) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 15:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT005.mail.protection.outlook.com (10.13.2.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 15:19:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 13 May 2022 08:19:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 13 May 2022 08:19:44 -0700
Envelope-to: robh@kernel.org,
 trix@redhat.com,
 linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 dwmw2@infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.74.144] (port=39254)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1npX4y-000G3w-4j; Fri, 13 May 2022 08:19:44 -0700
Message-ID: <62e98217-e068-35fc-6809-11d75f4c7933@xilinx.com>
Date:   Fri, 13 May 2022 08:19:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V1 RESEND 2/4] Documentation: devicetree: bindings: add
 binding for PCIe endpoint bus
Content-Language: en-US
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     Rob Herring <robh@kernel.org>, Tom Rix <trix@redhat.com>
CC:     PCI <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, Max Zhen <maxz@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Yu Liu <larryliu@amd.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20220305052304.726050-1-lizhi.hou@xilinx.com>
 <20220305052304.726050-3-lizhi.hou@xilinx.com>
 <e4c058e9-6549-4ce2-be05-d09d5b1a9fc9@redhat.com>
 <CAL_JsqKzxq8T=obPQwXeNyqedQOKkmm8hwHdfVgKr15EyAgBnQ@mail.gmail.com>
 <79e4c876-e5a4-861f-cfbc-c75ed1a07ddd@xilinx.com>
In-Reply-To: <79e4c876-e5a4-861f-cfbc-c75ed1a07ddd@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: 60694d12-1497-4701-bb83-08da34f40610
X-MS-TrafficTypeDiagnostic: CY4PR02MB2712:EE_|SN1NAM02FT0052:EE_|MWHPR02MB3280:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB328086FAE5AB95EBD0E8C46FA1CA9@MWHPR02MB3280.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5x1PYgYcaM7eMWL9e/yptTWCVwIR5V9nVTEF4cyuAD5GTaajJ8ZYB+FapU+MdlyVHC7zSzNdOzcaR0GfOxH+D/sL43CPRZ12XXxJJt31qAhHmlIprSF08+av/2L0xYFmtdwZ6xU6jwxrG+EoJpQKajkQghJoCb9vNzxsRUaRb6DuZpiiANIzb6x1F3kwTmTa0Ng6Tte6gq5VwEm1PEFegfKqkE0i4xXMJiQXcs69bnkRMVx6EkbjpUTkoBhth4TkLwEqmOjKTe6Exgk5zr1UayevT99QoiiFz2DKQiHZdxt8mbH5k+kowPdESHI12DDxGCP2bMa/W9lH4vEmm/8xuHPLKfn15FaoFK2whIsCAqeq9JYSo7y9Gal2u2vf6G/ruNGfv6iTA92jj7EngsLCrmBAcgoopj/UYTcp6J+ekFmncd0qPeMqA3IJ0c8qtXBXDQml7GjzaQwX0xWyIAx/j9rlKy3WSBxesUo1GqfO3rLWqRxIKgU/32dukyE2lCOs2yMfS3zvZM0ZD1/3YSWpuE2EwsPrzkcZlQ7VnHJSyCNWVYNhoVPvqMgqnLBiMTDUiPMUDUAv6hHqFaqVS79YRW6vkeHdSNeizB8jueeqNSXyTwhLP/2BB3oFSLB1e9QVJKEH5ZtYCUqhe0i3Ca9gFf3QxZLSbjPp0mgXbZ2zWXz+w6A/p3Y4rTkST0ACZNKK63goA9bUqChPzqsfAYnowtTY3rsACgH2BvLXGcpFmVjgJwf115FGSYJAWgK/WFvgvhyhmzjTmF0pDum+fw4mrVAYoL5TIMPjO/xIPhmeWOOP2EoWbfvskJokr83QFb0I5iPQLSXYjkOE21RxtjMA8BY+G8AT5EzibORVTm7UJeI=
X-Forefront-Antispam-Report-Untrusted: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(26005)(70206006)(70586007)(2616005)(40460700003)(5660300002)(356005)(8936002)(9786002)(83380400001)(508600001)(7636003)(966005)(36860700001)(36756003)(2906002)(53546011)(426003)(47076005)(186003)(336012)(82310400005)(54906003)(110136005)(316002)(44832011)(31686004)(107886003)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2712
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: af6c84e2-ad1c-49c2-b6d5-08da34f40435
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMSLpV8hFJ8s7DDwbggNvIFfC6UT1ccCAjFBdfVk9feQmnkwXdWid9LlhJQ6h4xyOnbMujWQNxnQ7wn0JiyXPmL2JaZVBqjQzy2Yo2CXrxgt5rAFoLeWcEpQHKfFXh0NAL0zJo1iLnOE559tqcOVtg2umViSXWEe4YK3QP+YvDj8csfbiNd5ESXmpJxEnYrf3BYMzviS26zAK2TKKAAXTUMe8jctRbrawAkWXQ7IeUcO1pwmw49ngBE1c44t3j312GVYeQ0ZXQAgJiEDMI9sp1LML9Sur180kcjxflPnLJBaY5Rzt3nIIvK9YA3fYuatlYzNYhZBCkgBgURxEknOGqrOEQ88dRRz1ocyUVt39wpWANOcDpnsaIvvrcvz3D3+pZPfAAjpeNO9SQGlQ0R8xQApkYk8GlJ5gIkGUwM3GXDppZT4HztQCLpKDL+OrcWvrc6zP/899ZXp8169yPNeZjrMpO62zbfoPsjoRcbV4unMigJvUsDfo+TFk3+3U2+EEagDo46WgYy8hLH8ZpydlZ4rtvmz1e0TvdimpYeBtio+FgEr5/n/08qinxs7dZKLdZ1a39aeDr4j3ekiKPStYWzq2odz+L253vRD/yfock3d/ald1NIYNCeu1gdb5HqSNDagy5O5JdI4oRcfkvoVsa0RH7OH1ZMyWfvhUZ0NFgeVoI3+i9nh4j/sDxXSVEF1l/TdDzOHLAEDb5XsOQHsmg+pQqYeG7RtAHUncDXc9DTZPcVaJvMJCemIJgYNIOm+sZDhEmZPfm9b/NNkem5JKO9huivgNDRx7rCnKhhjg/cTuu8N5QE156JItd1EbCBi9bvdRBtgKsQ1kJgS6X4/DyrSZv+KsS6KksBaorLgfQfk9HiCmvjY7l4OMwwCGmW5xaY8ytIur/nZgcU3EIZ01A==
X-Forefront-Antispam-Report: CIP:20.83.241.18;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(110136005)(316002)(82310400005)(83380400001)(426003)(54906003)(40460700003)(47076005)(2616005)(4326008)(336012)(31696002)(107886003)(8676002)(508600001)(70206006)(36860700001)(53546011)(966005)(26005)(81166007)(44832011)(8936002)(2906002)(31686004)(5660300002)(9786002)(36756003)(50156003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 15:19:50.3521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60694d12-1497-4701-bb83-08da34f40610
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[20.83.241.18];Helo=[mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3280
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,


Do you have any comment on this? We are looking for guidance on the 
approaches suggested.


Thanks,

Lizhi

On 4/22/22 14:57, Lizhi Hou wrote:
> Hi Rob,
>
> On 3/7/22 06:07, Rob Herring wrote:
>> On Sun, Mar 6, 2022 at 9:37 AM Tom Rix <trix@redhat.com> wrote:
>>> Lizhi,
>>>
>>> Sorry for the delay, I am fighting with checking this with 'make
>>> dt_binding_check'
>>>
>>> There is a recent failure in linux-next around display/mediatek,*
>>> between next-20220301 and next-20220302 that I am bisecting.
>> There's already patches for that posted.
>>
>> Just use 'make -k'.
>>
>>> There are a couple of checkpatch --strict warnings for this set, the
>>> obvious one is adding to the MAINTAINERS for new files.
>>>
>>> Tom
>>>
>>> On 3/4/22 9:23 PM, Lizhi Hou wrote:
>>>> Create device tree binding document for PCIe endpoint bus.
>>>>
>>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>>>> ---
>>>>    .../devicetree/bindings/bus/pci-ep-bus.yaml   | 72 
>>>> +++++++++++++++++++
>>>>    1 file changed, 72 insertions(+)
>>>>    create mode 100644 
>>>> Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml 
>>>> b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
>>>> new file mode 100644
>>>> index 000000000000..0ca96298db6f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
>>>> @@ -0,0 +1,72 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/bus/pci-ep-bus.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: PCIe Endpoint Bus binding
>>>> +
>>>> +description: |
>>>> +  PCIe device may use flattened device tree to describe apertures 
>>>> in its
>>>> +  PCIe BARs. The Bus PCIe endpoint node is created and attached 
>>>> under the
>>>> +  device tree root node for this kind of device. Then the flatten 
>>>> device
>>>> +  tree overlay for this device is attached under the endpoint node.
>>>> +
>>>> +  The aperture address which is under the endpoint node consists 
>>>> of BAR
>>>> +  index and offset. It uses the following encoding:
>>>> +
>>>> +    0xIooooooo 0xoooooooo
>>>> +
>>>> +  Where:
>>>> +
>>>> +    I = BAR index
>>>> +    oooooo oooooooo = BAR offset
>>>> +
>>>> +  The endpoint is compatible with 'simple-bus' and contains 'ranges'
>>>> +  property for translating aperture address to CPU address.
>>
>> This binding is completely confusing because 'PCIe endpoint' is
>> generally used (in context of bindings and Linux) for describing the
>> endpoint's system (i.e. the internal structure of a PCIe device (e.g.
>> add-in card) from the view of its own processor (not the host
>> system)). This binding seems to be describing the host system's view
>> of a PCIe device. We already have that! That's just the PCI bus
>> binding[1] which has existed for ~25 years.
>>
>> For a non-DT system, what you are going to need here is some way to
>> create DT nodes of the PCI bus hierarchy or at least from your device
>> back up to the host bridge. I would suggest you solve that problem
>> separately from implementing the FPGA driver by making it work first
>> on a DT based system.
>>
>> Rob
>>
>> [1] https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
>>
>>
> I investigated the implementation detail for adding device tree node for
> PCIe devices. Based on my findings this is quite involved and so would
> like to bounce off my approach with you before I start making changes.
>
> We will start with DT-Base system which already has device node for PCIe
> controller in base device tree. And we will focus on:
>
> - Adding functions to generate device tree node for all PCIe devices.
> - Linking dynamically generated DT nodes to the PCIe to the PCIe devices.
>
> So the first question to resolve is when the PCIe DT node will be created
> and destroyed. Here are the different options:
>
> - Option #1: Add functions in pci_bus_add_device()/pci_stop_dev()
>   - The same place for creating/destroying device sysfs node. This should
>     be able to handle different cases: SR-IOV vf, hotplug, virtual device
>     etc.
>   - Leverage existing PCI enumeration and get the device information
>     directly from pci_dev structure.
>
> -  Option #2: Enumerate PCIe devices and create DT node without relying
>    on PCI subsystem enumeration.
>   - E.g. Enumerating and creating PCIe dt node in an init callback
>     pure_initcall()
>   - Linking dt node to PCIe device is already supported in
>     pci_setup_device()
>   - Eventually need to handle hotplug case separately.
>
> Option #1 looks an easier and cleaner way to implement.
>
> The second question is for linking the dynamic generated dt node to PCIe
> device through pci_dev->dev.of_node. The biggest concern is that current
> kernel and driver code may check of_node pointer and run complete 
> different
> code path if of_node is not NULL. Here are some examples.
>
>  - of_irq_parse_pci(): 
> https://elixir.bootlin.com/linux/v5.18-rc2/source/drivers/pci/of.c#L492
>  - pci_msi_domain_get_msi_rid(): 
> https://elixir.bootlin.com/linux/v5.18-rc2/source/drivers/pci/msi/irqdomain.c#L233
>  - pci_dma_configure(): 
> https://elixir.bootlin.com/linux/v5.18-rc2/source/drivers/pci/pci-driver.c#L1610
>
> It needs to identify all the places which use of_node and make sure using
> dynamic generated of_node is equivalent with the code without using
> of_node. Considering there are so many hardware and virtualization Linux
> support, the risk might high for changing the code which has been 
> existing
> for long time. And how to validate the change could be another challenge.
> Introducing compiling option (e.g. CONFIG_PCI_DT_NODE) may lower the 
> risk.
>
> There are other approaches for linking dt node to PCIe device.
> - Option #a: Add a special flag or property to dynamic generated PCIe DT
>   node. Then convert the code.
>
>       if (pdev->dev.of_node)
>           funcA();
>       else
>           funcB();
>
>    to
>       struct device_node *pci_get_of_node(pdev)
>       {
>           if (pdev->dev.of_node is dynamic generated)
>               return NULL;
>           return pdev->dev.of_node;
>       }
>
>       if (pci_get_of_node(pdev))
>           funcA ();
>       else
>           funcB ();
>
> - Option #b: Introduce a new data member "dyn_of_node" in struct device
>   to link the dynamic generated PCIe dt node.
>
>       struct device {
>           ...
>           of_node: Associated device tree node.
>           fwnode: Associated device node supplied by platform firmware.
>           dyn_of_node: Associated dynamic generated device tree node.
>           ...
>
> Could we implement Option #b for now because it is lower risk?
>
> The last question is about the properties for each dynamic generated
> PCIe dt node. To keep the generated device node lightweight, what will be
> the desired (minimum) set of properties to generate? Besides the 
> properties
> defined in IEEE Std 1275, it looks more properties are needed. E.g.
>     interrupt-map, interrupt-map-mask, ...
>
> Thanks,
> Lizhi
>
