Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8003765CAE3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 01:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbjADAbp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 19:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbjADAbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 19:31:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9958765E;
        Tue,  3 Jan 2023 16:31:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SL3Azdx2WGKMjXnowBSYxV2jqR5FSKtl3Foov/VDnfOE5GPJ8kWgbBVnzIJl1BeoGXbvMSqnWFncvTJdOO8w6WeJJzuBJmqQaY2Zt/yffGw9hHCnolCb9ZQ6mISJxBH4sOzMoZ36A97B8uF+9jtBQyMzJYRf111nL360+MY4jhQLAs0zNLPpe/uFmq1JFslGc9wxdbWwDelz5tDF/y+vwLrkIomnluFePj1fVUmi2qEUR3TmyUk9yd+H6+K7/0ZZ/qo31PwhcO6tX4MC8OAn1wMFYzJnXu3D+KLayMvExWgyLiSySVK3Cv8G6URhy0x5QillU9nLVp16Fe5PY+o/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8agi8UzNmulPZ6g+looiRQKqQZQNbK61R92n2iyXPo=;
 b=NPuszypZgq4FDKom2yoEh9aBAdmalgK/+a0kh/uU1eXlicdQ8lDT2oZcTnQegDPpnPYPsklZl5wNk2g/W7gddP/E5Em8Sse1LUYt8sPvcNtplNzqIlJt7ov0hITuZIt5xmzMSWSfEBAGaT2hmJDEcDygBiH+LnjNGykhGPc2X7nXHdZFUAjDw3WjffgpmT2qQf2ee6+8Esxv6AkDGGHiO0tJPwXIi+4Gr/cE2wLDNANwapaZsYDDn9UAtWlWLctWpG5ReJpFsPmTJv6F0CiUqrGzcF7cHIhpGo3fLiJJ27eoFt+1ZCK0/HcqG0nON1xIW7gAXrnJBlKoyPXCMj3nIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8agi8UzNmulPZ6g+looiRQKqQZQNbK61R92n2iyXPo=;
 b=cpi/uLom0CPeHFxJQndjNC0n2kR3WAlo6qiiugVIIf0VFRap6kkf9lMxIW9UJfOHhvJ8VejSHJAH/oFTzgoYyXLx12XKyP+0qGuUk5vv9r7HkiovMu/bVlLNYSaUlquVGBUe2OFoye8HI3iF+k/omdrz3kwVeepfC3C/SSVdcEs=
Received: from DS7PR03CA0316.namprd03.prod.outlook.com (2603:10b6:8:2b::17) by
 CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:31:41 +0000
Received: from DS1PEPF0000E642.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::cf) by DS7PR03CA0316.outlook.office365.com
 (2603:10b6:8:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Wed, 4 Jan 2023 00:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E642.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Wed, 4 Jan 2023 00:31:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 18:31:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 16:31:37 -0800
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Jan 2023 18:31:36 -0600
Message-ID: <bee02801-c3a4-4717-61a0-290494a097bc@amd.com>
Date:   Tue, 3 Jan 2023 16:31:36 -0800
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
 <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
 <20230103154811.63e71494@fixe.home>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230103154811.63e71494@fixe.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E642:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 116d17ad-68bf-4b82-219c-08daedeb0b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQJjHbsIv3WLupzWzSZg3ocPbQPOLapMxum8viw2smzTsB0TpMZKIH93bkhkOBFPKnyRl7p0bYYPSc2dKvNIYBTrn7MUeNIqiQj25TJrLVu7ZUcCdFlMT5aOLchrhO49C8R7J/rvsy50Ex5hwB2ncYJaqgNAhLyEC7RWaHUa3F3FEweMmEkLKFKEJbJwlvvIYNunCnWDjGTrWCdU2TwMEaCVlJuaOzJ6fj+5DuReu4OWVr/gmt4GQM43h2g8VL6WaxQ+CHvfFWBrzu3IbskD5R2r93BjhSbnKXtt42132eChkHEHgU1zffFB8WM8m8ON/238kHpfw2B36LbGinUwDq6LoU8GtKSa4Eto9WkM5ibXpl4SSUjb5nEVMSYjoPkUlcIDZENKqR7CYlHlgo/BjL5SffWOnztwuN/gpbJls2htM5oaNpMiy2TD1bOtQoubuREPyyndeBfcVCh/ZLD7yCSY0xLKy0wsHMfa8gVvQ0cC/N4e8PCK+GbGm6JuEyTPxNPd0qIG93fyof3jjaWkUzMZiaEbq/GWUM3hRS60VenH8dq8XaWBdSb1HXvMXEe90IRa2xrHXg2OZg1JksWChITrbRzP4CpaT53Zr0JHacTb7LRDeKIvVLvh6ZuY0yk+Og7sxMIqm8aWdTrrnwu2fPmyeYVi/Pyf/Ar0wDARzXntK+iZwW/nQy8PuRn0nVoc4kn6UlL4XtI0DAmtVwh5hAKIa/yLFN2zdD+c5XqGonMRQg3bWSEQfvHHYjNkaBQ8c7dgTdtXb63e0dyGPy0ZEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(66574015)(47076005)(2616005)(336012)(426003)(83380400001)(186003)(26005)(81166007)(40460700003)(356005)(82740400003)(40480700001)(31696002)(86362001)(36860700001)(36756003)(82310400005)(2906002)(6916009)(7416002)(70206006)(16576012)(5660300002)(8936002)(4326008)(8676002)(4744005)(31686004)(316002)(70586007)(54906003)(53546011)(41300700001)(44832011)(478600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:31:38.4335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 116d17ad-68bf-4b82-219c-08daedeb0b11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E642.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/3/23 06:48, Clément Léger wrote:
> Le Thu, 15 Dec 2022 09:30:45 -0800,
> Lizhi Hou <lizhi.hou@amd.com> a écrit :
>
>> +
>> +static int of_pci_prop_address_cells(struct pci_dev *pdev,
>> +				     struct of_changeset *ocs,
>> +				     struct device_node *np)
>> +{
>> +	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
>> +					 OF_PCI_ADDRESS_CELLS);
>> +}
> Hi Lizhi,
>
> This should be #address-cells and not #address_cells.
>
>> +
>> +static int of_pci_prop_size_cells(struct pci_dev *pdev,
>> +				  struct of_changeset *ocs,
>> +				  struct device_node *np)
>> +{
>> +	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
>> +					 OF_PCI_SIZE_CELLS);
>> +}
> Ditto here, this should be #size-cells and not #size_cells. Was this
> really tested ?

I will fix this.  I verified the properties are generated and did not 
notice the '_' error.


Thanks,

Lizhi

>
> Thanks,
>
