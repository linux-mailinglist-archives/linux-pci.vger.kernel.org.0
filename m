Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172AC3D954F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhG1Sb1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 14:31:27 -0400
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com ([40.107.244.76]:53060
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229556AbhG1Sb0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 14:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0yFYQNE1mZPWLUBheoNwYvL2MSKx/XXRPUkDzUmcItcVcSxGlyHwhK+8Q6vx2a9RJ86k3uEqTJNZvhsd+v1SccBD8MNvhfioDvBHevbvQuv+Vbn29okqZRK/pNPcmOWMQulX0/153klWknFjFtlYhr3feSlaLqMuSq2iaT1DMUWJoAneYjqJ5YkaHBHVbv0GadeFRyN/pXiWf2iOIfeOvCF+BDlB7EtzqlMZZMxPFk19ca2q/7fDe7tMDgF+BfbUr7EdCoh7q7UlqSoSls1DjXJhdtwiPrRYbRimVCYdQUL3GQym+gtdfY1sPegtlhinEJfQt+6iCJwYbYZc6VdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no1oS7S+hGq+e+KUC8lQDZG2Y7kghk0Tf3WAIGa4bqE=;
 b=ZRRtaEexNH8UrASiHnmJ6liUBAf9eCHOHvQqgQtAfKzlnmhfvgN9qznlr6MGt6kEzRJTexmj6/0Dv0QtjBG9OwM3Pbri8/KxT6MPncRO4lqjNTz364NKTFQL150skhlTispmORxwuvDnW0CMmsDzVaQhP+dYzGfSwKRJG6alaCMYq1+axRj0Vj7SEk0NSo2Yx1n8/1u0CDks3ngIcbnPoRsljefk/FmtS8q7CIFejbu80x9CI76X3aG5nvPeIiyTx2H3r8I4RfYBmED7d/drsYiMSl93Q17av4FchN5Qqiv3hr7vTT984yQVNfHovVyo3le7QkrFTBaBOexQEBtmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no1oS7S+hGq+e+KUC8lQDZG2Y7kghk0Tf3WAIGa4bqE=;
 b=gSMN1Dsdt/F4TYwdMdCW8c8kEEQoB61y5LGE1+5AcssgcWDXJteuxxtydZe4cUHWCCXFvWW0Bilf4pTTdLuxJcjMLnsPdFcSANRoQbqwOlIub9z17EPPKS2yHF0SzR1O6A0mDxRJ0+R/P5DI2QbE8zH8C6nGwEWVIP5iFqxMcJHG7UfmPm+s9sh8cHLF6C9eHd+8diHdogThmOpuBOBB0Iv4e9bcLhZvADBAwWY+xus3jNq+OXA4htMX72yUCC8Ed1q/A+BHSuoClu3cHnPFYU9d+mgbzaizZbcTsxPvSD0aHEtO6KnQadVKaUMW/weVoR2n6u9FUGOo/trUeaDiDQ==
Received: from BN0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:408:e5::16)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Wed, 28 Jul
 2021 18:31:23 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::6c) by BN0PR02CA0041.outlook.office365.com
 (2603:10b6:408:e5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend
 Transport; Wed, 28 Jul 2021 18:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 18:31:22 +0000
Received: from [10.20.23.47] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 18:31:20 +0000
Subject: Re: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210727225951.GA752728@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <f89b5c62-56d5-3437-f8e7-24c5d74a7afa@nvidia.com>
Date:   Wed, 28 Jul 2021 13:31:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727225951.GA752728@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e309b89-27ec-4746-3f17-08d951f5e6d3
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5523318E36669A4893EF57A5C7EA9@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EOo3fXTpDY6abuaV0GL3o8+h22oeTpgHisZCO9waBpAMAyg7nSAU6dX1FyKDfNslmRsXBoKMZlTwllTc9AIFr2D3yImMr4EbV/PBOPbfXIwdhGI+PfhhHnz7ycKDW4lmIBx7WlhdpspKhKY4rlkI/tVaA6oTD8pifB+BUtW+Yq17nJKwgF4h524ZSz9CUAcyzbwkqWU+ugcHrubtdWeS9RdkcZfsY1j7RJgPQzSpxUufxUj5+uwZbj8UI/9OPekU3QbaJdKBVSm882HKRgap2sStHS+5o+/QxIZMaiB0Jd8vXiBgJObwk95zIknqTs5XtYqH6Dq8Y1yA9VGI/6rQYUBaNQupN0Ms+pxm6rB1wxxijVHFZNcmrNRdT5FGm2G3ZBHWfTzTAf2FSTToYPJzISW5mb18tUaP2dEDeydPtrp1FvRi/59Y0sRW4Ym6A/YRj2PRLjSu5avUkzYFZgVLewSK0lgS7sWIQrnYjZCtskFrXB6OrvC1lu24ySKtUwwA6+/BYochPyr0EmgUkH16TJh4mtzlJUNN8h5GF1dOIZ9tNOLfjyh41gNyi8FiABnMbIhSxiXDXqKKoveESW9AaFL+fciS3gaOkawjx3/4J5ckCgkJ8CxrbXUK68WhsJWGj59o/pmAYojaLeZ/tfplqUy0UhjkyVk1NfDshOeW88A8nXIzbQPGOlJnu8nJMnLPHsW7vSnKC/pUONMlsfEH6XvDCC9o9bcp8BFfkA64IhBe76soLVwsELiU8Pbx/fT
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966006)(36840700001)(82740400003)(70586007)(16576012)(7636003)(70206006)(2906002)(478600001)(31696002)(47076005)(110136005)(36906005)(4744005)(5660300002)(8676002)(186003)(86362001)(8936002)(31686004)(336012)(54906003)(2616005)(36860700001)(356005)(36756003)(16526019)(426003)(82310400003)(4326008)(53546011)(7416002)(316002)(26005)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 18:31:22.9478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e309b89-27ec-4746-3f17-08d951f5e6d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 7/27/21 5:59 PM, Bjorn Helgaas wrote:
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index fefa6d7b3..42440cb10 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>>               msleep(delay);
>>  }
>>
>> +int pci_reset_supported(struct pci_dev *dev)
>> +{
>> +     u8 null_reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
>> +
>> +     return memcmp(null_reset_methods,
>> +                   dev->reset_methods, sizeof(null_reset_methods));
> I think "return dev->reset_methods[0] != 0;" is sufficient, isn't it?
>

Agree with you, it simplifies code logic and can be moved to "include/linux/pci.h"
with inline definition. Can we change return type to 'bool' instead of 'int' ?

static inline bool pci_reset_supported(struct pci_dev *dev)
{  
    return !!dev->reset_methods[0];
}

