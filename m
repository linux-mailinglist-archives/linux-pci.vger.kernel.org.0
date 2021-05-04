Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA637245D
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 04:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhEDCIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 22:08:12 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:34593
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229634AbhEDCIL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 22:08:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoAj93iEMONgW6qdwb0jyxlaHJxclDi2rg3TzEJOA5bU2aKsfSBeNOF4rg+DU7wiWmSN7zgcgJ/9BOIg0bof51/Vk0Izmsb/otD4m6xPkgUhx0PiVC0OahTU/yXTJYwZ9TYWxHReTFzdtKEUsBr0isSltCpR525H6gMUfo+fTGkq6Gl+FcKYIx3kNU0o9KoRNNd5PhzlcfbCDhbZXW4uIf6pXx15bsaFd2Yr1CXLGIRFQT2/+eXpv+Ui7nK3nPtnz26PLQ4t3la//JqPjj/+iHsjhHeFbDpB/JVGdesYEKunjlZdWn+dDPOKMbVyKkNgOni8ZQRR+P85BtnEFMmAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIVQKM6/hDfStmdWnAq8BfkndcnXKSJ7wWSCZrvFDqk=;
 b=lH7/RxJYHITcR4WnDJ5ZPK34JC3zBFJc8k5kNsxxsK9y86CXf1vXS51cqqmpKao47ZmnuQudDeN9fl/z07gjNPGtrDPd5vKq7st8pb/mzO/y4dbgVhrR2+oSjF6gVYEYh3pUpx+ZiDFC4waooQRaHq4fBa7Df2BPfW+6EXw3nfcUI+e3lgW9LDC4ToR320nFMiZ5w7S3QwDcm/zTjurjx1TJt9Uc8C0+O8A4G4pif94z58vp5Dn76P+W1hzySWLgbjElfWxcyxExBfExdbP73REbS8eqyHP2748k1X1x83wNnhfFRwFG6viZ648Lp5Ys1xqwUx4GKAHLgrdQ7bAwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIVQKM6/hDfStmdWnAq8BfkndcnXKSJ7wWSCZrvFDqk=;
 b=LB1tNXgLV44crvi+ynEODEC7k7D5cC/B43YROKrHUSeQ17mBpTnp954tQa4r0m8e58LwbOtU9HiXrpXHwI5+IknrNaIMK2JCFEQif258ViZWogY1Ux3ZgaLMej5tALKQX4YOKqEUVZA4IVw+z5kuVBTOUHX8qn6BQEZu0fvQgQi5iUPCiWtUTsUpxkSigaF6k2hC7NI7dJvFZ2vN5A6kvI9bB/GFzJKeqg1NKzd4P0pXmisjSwwNFIV5vVEd87bbRF8KCMoCAGUIAhxmG3Sg68NtLQqVcbh/S7LmrGmj5ipqe9/5BJI6F1xyJo0nLT4Rm4qb5RtOU1IWFJ/cpBMqcQ==
Received: from DM5PR07CA0033.namprd07.prod.outlook.com (2603:10b6:3:16::19) by
 MWHPR12MB1808.namprd12.prod.outlook.com (2603:10b6:300:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 02:07:15 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::fb) by DM5PR07CA0033.outlook.office365.com
 (2603:10b6:3:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Tue, 4 May 2021 02:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.32 via Frontend Transport; Tue, 4 May 2021 02:07:14 +0000
Received: from [10.20.23.38] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May
 2021 02:07:13 +0000
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
References: <20210503224220.GA999955@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <478efe56-fb64-6987-f64c-f3d930a3b330@nvidia.com>
Date:   Mon, 3 May 2021 21:07:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210503224220.GA999955@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1eed71a-49ff-48eb-5585-08d90ea1562b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1808:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18080A7A541A92E462EF00A5C75A9@MWHPR12MB1808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eY2VmJLm3psR0uYwZI/MGS3yahqH2lsqpPi/rSC4yDCxk1s9DZRgFd0FsDyhfdenE2FmwE1z0kKv5G+PyLQpxbXYSInsy5l0MIKErb6SG4dAXQF9dpPAxcyPMSfIogUXdqSJXyJ8Ua4VVtYidhthYBoOBsc+KxGecOxe5gEoqexqeLprWQgR4fQk6xDVMzw28ujfoJHjoDm5VevXxgYp1XRk2FB3phMVICaNM8hRlV6NkoselvaKvoDUTNdgZdMtRedNuLrLMnHuOpcLWcOm03Eu9spC+sFdZAzOt0EslT8HtkhR19r7H6MP334tV9CdoNGdOmCsfqbtS+sPGcfvEDGlE0k93h7pkVBqnyvtUiCTDLYAwulsNAMSG6ivEkHw9lkJja3tgh7qgoeJ5XsgwVy0R7r9q8lichqluYk49RVI66nXx6sSJbRi/iHsHuLEXc4OQj2wjwCjJvtsx2BmQKA18LATQCKGPOEQVCoGyntHUzhqkQKz6G5LYkrE4HberkokNPfbldyYs5f4LaYASTdWqS/NubQYmVJL+RT5pQi9C0Nyp+2Lg2okN5T4b1gn53p0lvGleEdH4ljcAlXWbfXss0k7s3X0AT2TzzU3Su9glZ4Xdj4zCmEwy091Y5uZ8zXOoFkWBaTcALb0Kb77JgmxvmF+K3W2MxTF7POmeV4fh1OO277/0hnw6/Yl00w
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(478600001)(356005)(54906003)(8676002)(6916009)(53546011)(8936002)(5660300002)(36906005)(316002)(36756003)(426003)(26005)(47076005)(82740400003)(336012)(16576012)(2616005)(186003)(7636003)(16526019)(70206006)(2906002)(31696002)(70586007)(4326008)(31686004)(83380400001)(36860700001)(86362001)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 02:07:14.6810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1eed71a-49ff-48eb-5585-08d90ea1562b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1808
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/3/21 5:42 PM, Bjorn Helgaas wrote:
> Obviously _RST only works for built-in devices, since there's no AML
> for plug-in devices, right?  So if there's a plug-in card with this
> GPU, neither SBR nor _RST will work?
These are not plug-in PCIe GPU cards, will exist on upcoming server
baseboards. ACPI-reset should wok for plug-in devices as well as long
as firmware has _RST method defined in ACPI-device associated with
the PCIe hot-plug slot.

I've verified PCIe plug-in feature using SYSFS interface.

1) Remove device using sysfs interface
  root@test:/sys/bus/pci# echo 1 > devices/0005:01:00.0/remove
  root@test:/sys/bus/pci# lspci -s 0005:01:00.0
 
2) Rescan PCI bus using sysfs interface
  root@test:/sys/bus/pci# echo 1 > devices/0005:00:00.0/rescan
  root@test:/sys/bus/pci# lspci -s 0005:01:00.0
  0005:01:00.0 3D controller: NVIDIA Corporation Device 2341 (rev a1)

3) List current reset methods
  root@jetson:/sys/bus/pci# cat devices/0005:01:00.0/reset_method
  acpi,flr

Example AML code:
 // Device definition for slot/devfn
  Device(GPU0) {
     Name(_ADR,0x00000000)
     Method (_RST, 0)
     {
        printf("Entering ACPI _RST method")
        // RESET code
        printf("Exiting ACPI _RST method")
     }
  }

4) Issue device reset from the userspace
 root@test:/sys/bus/pci# echo 1 > devices/0005:01:00.0/reset

dmesg:
 [ 6156.426303] ACPI Debug:  "Entering PCI9 _RST method"
 [ 6156.427007] ACPI Debug:  "Exiting PCI9 _RST method"

> I'm wondering if we should log something to dmesg in
> quirk_no_bus_reset(), quirk_no_pm_reset(), quirk_no_flr(), etc., just
> so we have a hint about the fact that resets won't work quite as
> expected on these devices.
Yes, it would be very useful to know what PCI quirks were applied during boot.
Should I create a separate patch for adding pci_info() or include as part of this
patch?
 
 --- a/drivers/pci/quirks.c
 +++ b/drivers/pci/quirks.c
 @@ -3556,6 +3556,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
  static void quirk_no_bus_reset(struct pci_dev *dev)
  {
         dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
       +pci_info(dev, "Applied NO_BUS_RESET quirk\n");
  }

  /*
 @@ -3598,6 +3599,7 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
          */
         if (!pci_is_root_bus(dev->bus))
                 dev->dev_flags |= PCI_DEV_FLAGS_NO_PM_RESET;
        +pci_info(dev, "Applied NO_PM_RESET quirk\n");
  }

  /*
 @@ -5138,6 +5140,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
  static void quirk_no_flr(struct pci_dev *dev)
  {
         dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
        +pci_info(dev, "Applied NO_FLR_RESET quirk\n");
  }


