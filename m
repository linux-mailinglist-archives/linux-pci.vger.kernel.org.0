Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C79373402
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 05:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEEDwN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 23:52:13 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:17889
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230465AbhEEDwM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 23:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/opIuVpjG0mjrPR2gVkFGBDg/wNAWes1S1pRSiawq+sPPBlXfJrAsQfZF623WMhht45b9pcnKyiAXd3uECCzIaw0DLInUn5y6MKbf2qaLv+veFi1FnalMbdN9ZtY9Sa+KeSTrowE9l/KVKU44QSOSSy9Ng4rsshez9cbXzd2QwL2CudaB5DZ95DJJPztbaPuJ44QIHLdllZouay7gWNZVdT8F7qplPvsCQ0xDuOVv+tWOjVdrA4AtztY6PduvmtqrYQB6UVih6UNdkEAUeq+3EvQsULCM7gZTEQzgI6ZUTM3n3aboSK8Rnyw3OVt4PblqK8LQtoWN6de71PHpRXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4MRJQFBjnEt+ZlkkDgD/vveBJtMU7VXHmpq8QE2ayI=;
 b=daf1amDirAWt/AYxpDaCv8DmPRf1OSJgJc+s2+o28mr3Fh8VmBn9CVE+UJNBaobzcSa9xa44spRq4P7JvGth9ZElOUgCR06SdXRAEU2Sp99SfT/rRQJmcikb/xlp1iJxO2MhLdXqnOsPy6LRxbCYCHygjJOjuWkBlOZrlvi3PBI7dlPBKok6VZt0C8GQZEGPJlreQIRxy/HGI7bTfZEPx/X6knhlK2J1OmyDIOW4kU+maBEbunMZ+oyWilrZLrJqD1o18e1Fcbq+Feyk6iu9d5FccomUu8aV8Crx2An4yUdXl2J8MhLJUw77NTYY7JLknAS9Fs2gSHhVvAGsMir48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4MRJQFBjnEt+ZlkkDgD/vveBJtMU7VXHmpq8QE2ayI=;
 b=g22iMfVFxgIQLedQLMf/dRwewPjKnTSsiOnraYZRlZOtFmOttePH/5+qcoyqHWoq5wplKSqZ/YkACM7MwZKGcbZSeHYm6kzho8/Mb0D/BOCrRT1H7oxhj7tbdXmjgycXUrf2Wk0HMM1IcqTmK3+vkf4/mui98S5GHTJzJNm2a5r+CLIAjNtEKrghRLyykKyCVtnFaou4DtYprkWOTxCrm0GBB7GU2VFWgHnUOVbcVVlMh9UzvRfPFoD+XvBkXY+vc2EndmIbLz5JVAtd+GqhtvCFzIEr4IGZzBxj6Wgvb9Ve+hA8eTJl3j8YQSNk/IHXk8HjD1oGlHnyt43MNAwqMQ==
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Wed, 5 May
 2021 03:51:15 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::78) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 5 May 2021 03:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 03:51:15 +0000
Received: from [10.20.23.38] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 May
 2021 03:51:12 +0000
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
References: <20210505021236.GA1244944@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <b94ef9dd-4f44-724a-6264-fc3b571be85d@nvidia.com>
Date:   Tue, 4 May 2021 22:51:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210505021236.GA1244944@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3be3e0b-acf6-416c-59b4-08d90f79083d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23675440EF7FE15C22CECD66C7599@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HDZt0V9F5V0p7sT5Nr8tYul4+7TnGiQCxkESRU+0tZU/4Njs3teVWmZpktzTsY1lImk7Wo9J7fCkojkZR8y3Va7HufsrV/XanMU8q1QzoFSKfUF8lq1GH8VA9mjC2fWEgN7DN1T9yLOa7kWjN2zjG3Jj16Su+fWjgMbeBdkF1Xf8yDX1P5nKEcj19PdNmoQh1Nk55UrmTcWgAR8oVsrAQCvT3XNtsRAz4NQotGfHX8dufIZh8VUh02E+ZfKLPZY/hdlLPS/A/PN6PiRz2zTphvxJSBvY+V5ISrIaQrrcLBLUQiQN20hQmJXasbnqYKV69MDi3+CTBEWPXVCwHaw9nfXWo2ddLGofhROrF8C0aaTcKWQHk6kkeK/GqyVM8FPNwS6ZOu52MAW3j1ctQ2+bgTJeU/7h/QGhkqOke2D0osJwFZq73GUvHdcyaRkqv0knM6Zj+UQ6p6Ue2/h6Dpt7BLiOEbgY/XWq6Qt+HkxH6Hv3vH4rxhoKnudwCqtUtModLOmih9vZgVLZXRMCelBpiEIrUDoS+tDLWOsGWX+yBWgde7KwgQmnLmU6/Wt+zoFX6L3a9dxjAwO+xKke4Znv62VeG/trr9TUolUahUZOx2bxwqufgyna6eiq5us8DgSXaOlmjC/unUc76k5O9dM1ec3iNFIX0h+A97RP60NSVcMfQrDyhY6xoE00q2LzmhB8
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(47076005)(54906003)(4326008)(8936002)(36860700001)(478600001)(36756003)(2906002)(31686004)(86362001)(8676002)(6666004)(356005)(6916009)(336012)(316002)(2616005)(426003)(53546011)(186003)(16526019)(5660300002)(70586007)(82740400003)(7636003)(70206006)(107886003)(36906005)(16576012)(31696002)(26005)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 03:51:15.1514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3be3e0b-acf6-416c-59b4-08d90f79083d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Bjorn,

On 5/4/21 9:12 PM, Bjorn Helgaas wrote:
> Maybe I'm missing something, but I don't see how _RST can work for
> plug-in devices.  _RST is part of the system firmware, and that
> firmware knows nothing about what will be plugged into the slot.  So
> if system firmware supplies _RST that knows how to reset the Nvidia
> GPU, it's not going to do the right thing if you plug in an NVMe
> device instead.
>
> Can you elaborate on how _RST would work for plug-in devices?  My only
> point here is that IF this GPU is ever on a plug-in card, neither _RST
> nor SBR would work, so we'd have to use whatever other reset methods
> *do* work (I guess only FLR?)
Sorry, if my explanation was not clear earlier.

These NVIDIA GPUs which need SBR quirk are not hot-plug-able devices, they
will exist only on server baseboards and directly attached to RP/SwitchPorts.
In this case ACPI based reset will be applied to GPUs always.

Agree the RST method is a platform specific firmware implementation and
can't be used for other devices without probing the device PCI config space.
It would be possible to enhance RST implementation, probe config space
using ECAM, check vendorID/deviceID, and do FLR if the non-GPU device is
plugged-in.



