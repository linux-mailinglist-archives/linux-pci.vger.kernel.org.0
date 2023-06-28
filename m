Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019C97417D5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjF1SO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 14:14:26 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:31721
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229541AbjF1SOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 14:14:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBzYEj8GJhigV0z5Y4BoCpRwW/NS3d6T43n799Wj64d77NqCYMMXo3HS2GR8FaiPX1/6rMZyTg0oHAoOcA+Gd8f4BVnI3/rN7degYAQqPdieIcb0efERUiCXIm+KsZoHcwan13Q7J6A67dvzPeAPeUYBzxNKUycNV+y09lOITHKjZXWdGqm80kCqEabk0IdbdT8HCIZSA/vlpy4ITNtqTTZ4Or/w4iCwwFaR1nPbhGo+gfzoBPXgO7N12WwLPnW2GA9Os7XHPATmvrNBd29SS+YHO9N4ro0iCwXRCBIvlFJcZMCDvF/DRdFrVmqHt0/bY5KUaiBXBR/tTUInhBVnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMHDJHGCVGuJxeQzSZhw7+eUHepbY39ltKpq8KgC6Rk=;
 b=bueh8IQp2JHHtrHEHRBO4aKNpPpcV8ONDADxBbW2ZTy4IS7VmMx4H9kS6iBA+UVV2KLLKdz83vEps6CMMjKrFXHantYz1s+vFvV40TwEPmmEn9CNXoyPGq9nJjjkZRnvcAhTb5U2zXS+xO8smUmubuSXISImVmeQDEEqOdFu4d1XBNJC7wrCQm9SJh0NAlIIzaszlM5It2Dh2laxkl7PO9TmBw5BouF1BuV3h9mh08UmLIKW0mKEAadudVymJjHDDBMLg57r7M6dAlzAQTJOk32tuFgTV6RMQ6/4+BPz7WYZ4SIg2V7n8Fd09lVuS0r47hS5rYoa6wR7gHRUy64ISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMHDJHGCVGuJxeQzSZhw7+eUHepbY39ltKpq8KgC6Rk=;
 b=rIU4fOWy/glLgw7IJAqr3E7d0QqzxEUppUBHthv38eLMJ6qzy+V2k0IaN+JpY5ZXCmeh7cNE6eFdDix2MCkPhGsSdGtjas9wNeJtwXdPRBnRJLDL935cV8mvYSc+y1W71G+QykzGhexf1Av1J38Lz1xhOO4CRIy2NeDw89qA1lw=
Received: from BN9PR03CA0479.namprd03.prod.outlook.com (2603:10b6:408:139::34)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:14:22 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::91) by BN9PR03CA0479.outlook.office365.com
 (2603:10b6:408:139::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 18:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 18:14:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 13:14:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 13:14:20 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 28 Jun 2023 13:14:19 -0500
Message-ID: <cea2cb94-6f50-4a92-bcc9-f5d7bfe38e7e@amd.com>
Date:   Wed, 28 Jun 2023 11:14:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V9 5/5] of: unittest: Add pci_dt_testdrv pci driver
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Herve Codina <herve.codina@bootlin.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
 <1687368849-36722-6-git-send-email-lizhi.hou@amd.com>
 <20230622122742.379a34d2@bootlin.com>
 <CAL_JsqKnShsngeq+9_Y24rQSCmAJ3uqP0kKB3UoG4+2TT8MOsQ@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_JsqKnShsngeq+9_Y24rQSCmAJ3uqP0kKB3UoG4+2TT8MOsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4978781d-d03c-4877-f571-08db78037f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIjL2GAkOyH7Whcy5SJf14472oYGIyd6xas1O90+W2h98ekOpfz0a/dTVnriqAjfekgRSq+WNqY88nv6bjdLcdbI3jGwh6fPBHG+fds/hkgWEaYCjeRJgTL4+6+mQTuomWj8T6A+Ez0Sx4CxG0wq4vThJ/tq9dkVXowWnUtb24AI7OBEXA4VHDTc24p/G+7+a0E8TTwyhsgw01/1412XnFO90JWe3arxvw0wt5q0jh+YbzWKm1TWpnXAn3Jzcz6I8KeASeZWOAyIxo26gfgHplP4hqEyADsAHKMGVMTZ7xdlha+bQ8mAweTxCz0PEts26NExVwhXEoCitOzdkEzqI2dIOtn2EJJidnyMGUCyM7sw/AYGp2CTA8efiqpYF3JZCpYytfyaHuPJI5GSeRW+U+7+y9/ryTBg2xyHHjXBg+tCNAqqaZ24TjyeQSO5o/0AvGFROzGRa5g5WN8RH0nf60iEyHdvynrRdRSwWYwrrzpnUIcI3yhFjBTKOHXrxliQm0xwd0u6ZnbjJ3Hki9R5Dc8EYKaVPZyLa3/SYIJadgceJwJd/quesYvXMrQ4Jt31BC0iNHpW79Bn5/43mcWr67lviRlg6ObPIorqbOhuFSlNZ7L+gIkZhB5yGa4eCMsejM7wcfGKC7pXqxyduYx9B04G4lZk1kCEb8eHDBED8unQFLIm9a3hcW+UjdwQTvZ1OijsA+e403TPKnwjpLYzltYCb3dttdl+B4gLoQ/W+DmvWa2lVyzXdoRa4sycsg7ousJ0bIYmHtWJnZ5Nu7WwtIaXweusXrUqz4mplnSZorDHrHo6Xutu7T29Fc+qN152
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(8676002)(316002)(70586007)(8936002)(186003)(26005)(41300700001)(426003)(336012)(4326008)(53546011)(54906003)(2616005)(110136005)(16576012)(966005)(40460700003)(6666004)(2906002)(82310400005)(44832011)(5660300002)(40480700001)(81166007)(478600001)(356005)(82740400003)(31696002)(36756003)(86362001)(36860700001)(31686004)(83380400001)(47076005)(36900700001)(43740500002)(376954003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:14:22.0408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4978781d-d03c-4877-f571-08db78037f68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/26/23 09:51, Rob Herring wrote:
> On Thu, Jun 22, 2023 at 4:27 AM Herve Codina <herve.codina@bootlin.com> wrote:
>> Hi all,
>>
>> On Wed, 21 Jun 2023 10:34:09 -0700
>> Lizhi Hou <lizhi.hou@amd.com> wrote:
>>
>>> pci_dt_testdrv is bound to QEMU PCI Test Device. It reads
>>> overlay_pci_node fdt fragment and apply it to Test Device. Then it
>>> calls of_platform_default_populate() to populate the platform
>>> devices.
>>>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/of/unittest-data/Makefile             |   3 +-
>>>   .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
>>>   drivers/of/unittest.c                         | 188 ++++++++++++++++++
>>>   drivers/pci/quirks.c                          |   1 +
>>>   4 files changed, 213 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
>> Did the test under QEMU with the instructions that Lizhi provided at
>>    https://github.com/houlz0507/xoclv2/blob/pci-dt-0329/pci-dt-patch-0329/README
> Instructions need to be in the tree, not living somewhere else. Don't
> need the full QEMU setup, but just stating 'add "-device pci-testdev"'
> somewhere. Probably in the test failure messages would be the most
> helpful location.
Sure. I will add this to the test failure message.
>
>> The unittest results were:
>> --- 8< ---
>> [    1.107378] ### dt-test ### pass of_unittest_lifecycle():3273
>> [    1.110068] ### dt-test ### pass of_unittest_pci_node():3909
>> [    1.110401] ### dt-test ### pass unittest_pci_probe():3840
>> [    1.110618] ### dt-test ### pass of_unittest_pci_node():3914
>> [    1.110759] ### dt-test ### pass of_unittest_pci_node_verify():3870
>> [    1.110894] ### dt-test ### pass of_unittest_pci_node_verify():3877
>> [    1.110985] ### dt-test ### pass of_unittest_pci_node_verify():3884
>> [    1.111088] ### dt-test ### pass of_unittest_pci_node():3926
>> [    1.111171] ### dt-test ### pass of_unittest_pci_node():3927
>> [    1.112056] ### dt-test ### pass of_unittest_pci_node_verify():3870
>> [    1.112201] ### dt-test ### pass of_unittest_pci_node_verify():3890
>> [    1.112326] ### dt-test ### pass of_unittest_pci_node_verify():3892
>> [    1.112489] ### dt-test ### pass of_unittest_check_tree_linkage():271
>> --- 8< ---
>>
>> Based on the test provided, no failure detected.
>>
>> Tested-by: Herve Codina <herve.codina@bootlin.com>
>>
>> Further more, I dumped the dt (PCI related nodes) available on the target.
>> If someone needs to look at it:
> Thanks!
>
>> --- 8< ---
>> # cat /tmp/dt.dts
>> /dts-v1/;
>>
>> / {
>>          #address-cells = <0x02>;
>>          #size-cells = <0x02>;
>>          interrupt-parent = <0x8002>;
>>          compatible = "linux,dummy-virt";
>>          name = [00];
>> [...]
>>          pcie@10000000 {
>>                  #address-cells = <0x03>;
>>                  dma-coherent;
>>                  bus-range = <0x00 0xff>;
>>                  interrupt-map = <0x00 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x03 0x04 0x00 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x04 0x04 0x00 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 0x05 0x04 0x00 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x06 0x04 0x800 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x04 0x04 0x800 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x05 0x04 0x800 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 0x06 0x04 0x800 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x03 0x04 0x1000 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x05 0x04 0x1000 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x06 0x04 0x1000 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 0x03 0x04 0x1000 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x04 0x04 0x1800 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x06 0x04 0x1800 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x03 0x04 0x1800 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 0x04 0x04 0x1800 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x05 0x04>;
>>                  #size-cells = <0x02>;
>>                  device_type = "pci";
>>                  interrupt-map-mask = <0x1800 0x00 0x00 0x07>;
>>                  compatible = "pci-host-ecam-generic";
>>                  ranges = <0x1000000 0x00 0x00 0x00 0x3eff0000 0x00 0x10000 0x2000000 0x00 0x10000000 0x00 0x10000000 0x00 0x2eff0000 0x3000000 0x80 0x00 0x80 0x00 0x80 0x00>;
>>                  #interrupt-cells = <0x01>;
>>                  reg = <0x40 0x10000000 0x00 0x10000000>;
>>                  linux,pci-domain = <0x00>;
>>                  msi-parent = <0x8003>;
>>                  name = "pcie";
>>
>>                  pci@3,0 {
>>                          #address-cells = <0x03>;
>>                          #size-cells = <0x02>;
>>                          device_type = "pci";
>>                          compatible = "pci1b36,c\0pciclass,060400\0pciclass,0604";
>>                          ranges = <0x81001800 0x00 0x1000 0x81001800 0x00 0x1000 0x00 0x2000 0x82001800 0x00 0x10000000 0x82001800 0x00 0x10000000 0x00 0x200000 0xc3001800 0x80 0x00 0xc3001800 0x80 0x00 0x00 0x200000>;
>>                          reg = <0x1800 0xffff6d76 0xc2b23600 0xffff6d76 0x3fbf63a0>;
> Something looks wrong with the values here. I found this running it thru dtc.
>
> <stdout>: Warning (pci_device_reg): /pcie@10000000/pci@3,0:reg: PCI
> reg config space address cells 2 and 3 must be 0

I will fix this. Thanks.

Lizhi

>
> Rob
