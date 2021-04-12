Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8513135CF12
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbhDLRCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 13:02:33 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:55040
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244569AbhDLRBa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 13:01:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBZ1RJgifFPH8OWH3JffZ8hPu0V+hiDZrKGmEIK4g+pib/+apVwwKTMMAvGChdOt1ghWPmRh/YjoljbEBr0eDmmbCrnEfrRJKT0kHKVbfBwGSoZp51RNLN4sdaAUIjSJtB1KzXTQ5wGVGslEkC3bPPWk94hafYChvjW0o0mdXNXCA1RaOmTmbVn1ME7QKXB7nauEbt/phstz+Tww3KfVtjADNNkLHo4xlJwUutKr+PoPeh7akEDYemdXlBgxQ9B18mSbKpBMtBYd+UDRO6MwIul7CRqSMaPb250RNo8MAehQaF0Pyxne5/nh1rtyUByy5nAv+FWFSIE2omz3Vc1srQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBDVm6zVK6bq0ooHelHGw8btrTaqsC/fe5WYRaSwMdQ=;
 b=F04scSpyU0frZ2s2CkLrwxDVqbILgzTGp9o1nDXzEa9IICJXDD51S0yvQRf1XOM6pJG91LBEk3WZWWaivHNkZk3zcTFAkVdzQavlGOPbW0Eo6kj8QFNe05RCWuSDfkECl5wH+8IEEDb+ULckbJaABDMd1/TgIiX+K1J3ZHMRdf4zQDljyXn1+5JSd2ajf2ggJRekyj5E9aLyMFk7wej4Am2n5O2xZJheaovl5NJl6OyFSAK0bphilLAJxGSLIFJCwEjj8JbnSk37Dh2b2zlIK15KmmJXX3nBjKyQaibJOmZ+Bn+RO9lBtGS+kTP66Jr/LrP3QXPHQbcNj2SA7Drbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=thegoodpenguin.co.uk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBDVm6zVK6bq0ooHelHGw8btrTaqsC/fe5WYRaSwMdQ=;
 b=HT1hue9Png5yuxh+/x1Ai27MHsY8I6dC7bLz8VQoZ8lQv+Trj5AtfBYs9r/PvgJzbtBby7i0tkkS8cRUAI+kIZEGqEmlSf7xDFz6hAmeAO3w8Wg2ppcfulcQJC6M50oAvTB0+HgPqiwKj4pmR2Mhx+qqAuC9zfmHl6dQFzmngbhLwcIGrYktdhQYDPXlGETdSDAr0MH03lqzit9nZVvrIn11qObdMCP/0G27LUOSwJ5NyHJ8237U937ZCbKiJLFzlXkSTzwBP4q7IaNviwMJZ91mteJ9UeQ+vKYuUcVlZDi7vs1G+MrEe6PVjS+SObSToS7n5opRYHkp5U8Wd/0vJw==
Received: from CO1PR15CA0112.namprd15.prod.outlook.com (2603:10b6:101:21::32)
 by BN8PR12MB4786.namprd12.prod.outlook.com (2603:10b6:408:a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 17:01:09 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::b8) by CO1PR15CA0112.outlook.office365.com
 (2603:10b6:101:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Mon, 12 Apr 2021 17:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; thegoodpenguin.co.uk; dkim=none (message not
 signed) header.d=none;thegoodpenguin.co.uk; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 17:01:09 +0000
Received: from [10.25.97.143] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 17:01:05 +0000
CC:     Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
Subject: Device driver location for the PCIe root port's DMA engine
Message-ID: <d840687e-bfd7-71b4-e8f0-37c971d3d414@nvidia.com>
Date:   Mon, 12 Apr 2021 22:31:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b232020-93b0-4cc3-9c3c-08d8fdd491b2
X-MS-TrafficTypeDiagnostic: BN8PR12MB4786:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4786B098C6FECE00AE5F8DDDB8709@BN8PR12MB4786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgeCndsnZvEaXWekGjNcyUFQFJ/XJUDHtKBycxzcRA+Y2L/xmdQ4pWitorY7YlqMkoeH11/+R1NxOqAww8S8FaLR70CsFqt0FZnjBUX4woiUh3q6Qtfh2ZsJr5NRdSwcC7gEvOMqM9B417HR+qAMN5SiM8lp7WL+RLmCIXV0dHbD0SlPRMEbOkbahlWDKIJxuMCnmLK2P/Q2XXw7btUlt1qiUJZ4710AWRyuprDNOLNvV/Ai30qv3pXQhbvASxuJuKbPtbB7fYScN43Yov1tU1OoXgpl/L5p0V2Wp3PLwuxKKDZStpj276fl08ihFJ1xT9EJFugLFhyevH/Z0ROdzYKnBUDEOmOmMwfCo0eLrfU63HW5MT1Xgjy33S+T/b5+12tJPEzHyEdKdAqgJOm/Offatk99hnWr+hqscz7H0DW9hVLKnH0XkwC9cnR0+yaDtEoZswQtrHHb96UGSncR4NkbYDwq3lDB5FPgGIM3Uty8i1shZTUzW9Yqb4rlBOSprobQ+y6uNBYHDGcTo3DXd7ubPTpEtKClS3vfQtexfT4CQYRPM8wmqNUFqZ+6+HgqscHdjTB1HEUNVeXTsFT46crlekgMp1TWsl2U/Nj4zZ/RvbGOuQ6Br8b5X1mBwPdoO6/T8ql2sg1HeROodE9odoE99riDt9jwRH0W7/IZgDfIOT1bFrD6qPrW9SfmHE8r
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(316002)(110136005)(47076005)(36906005)(336012)(8676002)(31686004)(16526019)(16576012)(70586007)(186003)(31696002)(26005)(2906002)(70206006)(426003)(54906003)(2616005)(8936002)(82740400003)(86362001)(7636003)(36860700001)(478600001)(5660300002)(82310400003)(6666004)(4326008)(356005)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:01:09.1581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b232020-93b0-4cc3-9c3c-08d8fdd491b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4786
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi
I'm starting this mail to seek advice on the best approach to be taken 
to add support for the driver of the PCIe root port's DMA engine.
To give some background, Tegra194's PCIe IPs are dual-mode PCIe IPs i.e. 
they work either in the root port mode or in the endpoint mode based on 
the boot time configuration.
Since the PCIe hardware IP as such is the same for both (RP and EP) 
modes, the DMA engine sub-system of the PCIe IP is also made available 
to both modes of operation.
Typically, the DMA engine is seen only in the endpoint mode, and that 
DMA engine’s configuration registers are made available to the host 
through one of its BARs.
In the situation that we have here, where there is a DMA engine present 
as part of the root port, the DMA engine isn’t a typical general-purpose 
DMA engine in the sense that it can’t have both source and destination 
addresses targeting external memory addresses.
RP’s DMA engine, while doing a write operation,
would always fetch data (i.e. source) from local memory and write it to 
the remote memory over PCIe link (i.e. destination would be the BAR of 
an endpoint)
whereas while doing a read operation,
would always fetch/read data (i.e. source) from a remote memory over the 
PCIe link and write it to the local memory.

I see that there are at least two ways we can have a driver for this DMA 
engine.
a) DMA engine driver as one of the port service drivers
	Since the DMA engine is a part of the root port hardware itself 
(although it is not part of the standard capabilities of the root port), 
it is one of the options to have the driver for the DMA engine go as one 
of the port service drivers (along with AER, PME, hot-plug, etc...). 
Based on Vendor-ID and Device-ID matching runtime, either it gets 
binded/enabled (like in the case of Tegra194) or it doesn't.
b) DMA engine driver as a platform driver
	The DMA engine hardware can be described as a sub-node under the PCIe 
controller's node in the device tree and a separate platform driver can 
be written to work with it.

I’m inclined to have the DMA engine driver as a port service driver as 
it makes it cleaner and also in line with the design philosophy (the way 
I understood it) of the port service drivers.
Please let me know your thoughts on this.

Thanks,
Vidya Sagar

