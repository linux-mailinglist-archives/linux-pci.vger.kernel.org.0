Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292965C6A7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 19:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbjACSqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 13:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbjACSpd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 13:45:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F441276C;
        Tue,  3 Jan 2023 10:44:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFyNNtLHf/VYZRs0TURLLFucAxs3zSp1H5vR33TtWI/kZ6UCEQjIc0PJGMDYoXsiedLbo8Hnj0Uenge9SPDTKIuULUSYX1wlhMIOQcOnFR33UXG6HnH9i36KhxFL8mQM7mYwUeXpJu/+FKGStjqxq6PAAj04M+PE7ahIROG11cup0EhnE1f+v2hdcSZpZIn+Yru3hyLFMafWvqFHB7gcHAWkEwJEZJTDE4hWfPNzKdmZk0Ansu3GeHEQhnonkw07NWLQj/XMF5Cur2eY2VB8mtQlJ4qkBb8yiqxBVYMO6fKFsFjeeGDurQQmYcGGVBazeM04F5pFMqy0CPzYnyXqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAV32TvhH7B45s91Ybvd37PzXKvk1UgtFd3SuTD+aXg=;
 b=B9xuxbtTiwwOUjE7q5KEMbAKF5mIW8JxL32IRfKliUXyERtVEWcAcncl4qlvC3p0jQ7GM/jdcr8mTKqfoCMCuSQpc2x2LWw/v6+JraLrWpLyCrXvfBOUBNoZdwYAMLv8g2QAWqw5antr6WXGoMztOwFgW1XBhSUBHIbMlbks7AIn4NinThxOS6tsXTwJbD5oO4hH3ZTwtmJpzcabRZoIQf8iqpETOpMrXg/JIEL9pdxeB5OzhVEZ5CftmgqrSZiWF51LmmNgRKN0xZdsXQm0LrXXZNC0AFqaibdqIU3hJRbKFBZP+VgHKkyNw2ppneyzEG/OXANwudr/asaXpBsaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAV32TvhH7B45s91Ybvd37PzXKvk1UgtFd3SuTD+aXg=;
 b=pZnNWlu5ItzSOlwLX0JWNkPXYmUiAqp2Yyfh6vqdocq3isLrGDusfWdoy+ypfRmfM2vRtStLYxlvnBWggjQJNH540L4yuNAifLWNt/BjQnJYBPF8eKIROLyLtepAd0aOgRV0JcbvyHXwA3YjMIzpbZXmvXpV+HoJ88MGBaABvvw=
Received: from MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 18:44:41 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::74) by MW2PR16CA0048.outlook.office365.com
 (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 18:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 3 Jan 2023 18:44:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 12:44:37 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Jan 2023 12:44:35 -0600
Message-ID: <b50306fe-d710-4d11-d5e2-2b9c8293e44e@amd.com>
Date:   Tue, 3 Jan 2023 10:44:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 2/3] PCI: Create device tree node for selected devices
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
 <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
 <20230102145618.4b5bace8@fixe.home>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230102145618.4b5bace8@fixe.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: db963756-82e2-4b9b-7135-08daedba92d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbPy2ct/uKP0Vc0rzMG5WmWhExc0klPCkb3mKcMlBxBUtIIie/h3ExGMGCzU53hulGsMxeT+aYAXMsiuEZ7+9UzIe6ugp+Qp4ZKhyENGIQnavqUwegosQugfaVm+kJ1S8yF4xvDGnTM+dh1PLncnhzSlStTvpqHZTXXCLlxZtErB3gf4TH5WxuCjUrlYQ2Y3Az9MU/yDaCxcoPFkmX1L2LGMiOF8tQxrm6Im34GPDUnIybNldeiUZlG2T4Ur3PlBX+eg/GNs2ffZzkU/dNzj5qg7Q1UUcS4y1c6UA2gOPdW9YRmG+90RB9RmZ054lzYRVCAlN6hG90x4YPz9Z9gpSTOO7/r8wYaVi6GasQhmaqQeBkfnKHnQsxje2f6i6u1aroSZi9tMcM0NRxjpYi5jJNlgoAVwwf0ooVH6rQ0WP3TDLN502qhcmmbtxVjiKsd3Uienk/B2bC3EfHARm7GegspiXgdhmpOKTi5hP7vYsMK0v77Disyt3Su2EH6KRW3kJjViItv6YlrkLoK+a6YzWs7Db/vjCtcd4IZVlEleL8RdCgireud2ACSRTEH0UE9uwfTRzTBFUSzP6qXNG+fPC48AEIn7kqbeO5ZNABXISiVl226up9/h64MvDcN13X5vBRVRbMe2AiQkg0qRQkN+LG/BpkbH7++lbYiFDAfjq4+44JatKHRaAJSXU8hxh2oTONO0NR+6JAelxCvGeSg6KtOFTCFoR3aL5RTWW2yjg7p7q/RxYCS6AOBNVVKiXzClPGeNSXZPX4suKezgsRlFmYA43HGAi9aGcI61/vMSefj03dOfHK7TBOYMY+/MVz5X
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(66574015)(426003)(47076005)(82310400005)(336012)(186003)(26005)(2616005)(53546011)(40480700001)(31696002)(86362001)(36860700001)(36756003)(40460700003)(356005)(81166007)(82740400003)(8676002)(4326008)(41300700001)(5660300002)(7416002)(31686004)(2906002)(44832011)(8936002)(966005)(478600001)(70586007)(70206006)(16576012)(316002)(54906003)(6916009)(22166006)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 18:44:40.7774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db963756-82e2-4b9b-7135-08daedba92d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/2/23 05:56, Clément Léger wrote:
> Le Thu, 15 Dec 2022 09:30:45 -0800,
> Lizhi Hou <lizhi.hou@amd.com> a écrit :
>
>> +};
>> +
>> +static int of_pci_prop_device_type(struct pci_dev *pdev,
>> +				   struct of_changeset *ocs,
>> +				   struct device_node *np)
>> +{
>> +	return of_changeset_add_prop_string(ocs, np, "device_type", "pci");
>> +}
>> +
>> +static int of_pci_prop_address_cells(struct pci_dev *pdev,
>> +				     struct of_changeset *ocs,
>> +				     struct device_node *np)
>> +{
>> +	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
>> +					 OF_PCI_ADDRESS_CELLS);
>> +}
>> +
>> +static int of_pci_prop_size_cells(struct pci_dev *pdev,
>> +				  struct of_changeset *ocs,
>> +				  struct device_node *np)
>> +{
>> +	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
>> +					 OF_PCI_SIZE_CELLS);
>> +}
> Hi Lizhi,
>
> For all these functions, the "pdev" parameter is actually unused.
>
> [snip]
Ok. I will remove unused pdev.
>
>> +
>> +static int of_pci_prop_compatible(struct pci_dev *pdev,
>> +				  struct of_changeset *ocs,
>> +				  struct device_node *np)
>> +{
>> +	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
>> +	int i, ret;
>> +
>> +	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
>> +		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
> Maybe it should be better to use "pci%04x,%04x" to keep the existing
> naming.

Based on 
https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf, 
"pci%x,%x" should be used?

"name" Based on the PCI Class Code register, pick a name from Table 1. 
If none apply, generate a name of the
form pciVVVV,DDDD as described below under "compatible".

VVVV, DDDD, SSSS, ssss and RR are lower-case ASCII hexadecimal numbers 
without leading zeroes.


Thanks,

Lizhi

>
