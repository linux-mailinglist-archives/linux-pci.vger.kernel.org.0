Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5FB393DBB
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 09:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhE1H0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 03:26:30 -0400
Received: from mail-dm3nam07on2083.outbound.protection.outlook.com ([40.107.95.83]:37216
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229641AbhE1H03 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 03:26:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwTjOvATG3vkpJS6sRL78cqvf8124WSTduRx3+UVw1PdkljCAnpise2hPRLAJtgTwV1U5cR1OOwmkgPtWDYbm1vF1ZiD2FA8JUmYQ9K9la19cYyiqQg8JkRoagW7uM6FO/JWcpez69d87GDrOvPIOJDZq2NRvZwYEj94VIPDalHavsfqM5SD6J9NGgGYwZeJRzVcfF5+p1bU9gT2NIQjp6/195zHdOjn00F2an5FrLAT+F6hdxTqXABgfE9eD355BgTyuAJRjNlrxS0Q0LRmOtTolNkNWaHIqEYMw+Xhwuy7cOSedG+6g2+QCAGNQHY3Gh0spfr2GW/u9pR034UUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3bgFzcIzQyj94YQvj/kMqOGImvD9rYpmSPwjM4FHWw=;
 b=E1dGpqdgqb9vjKylHgbDhCtSg49fBVGnLj32B3c2gG9nY8assbZ8cW1Ep7+hWdUR2AndoKnvwkwXws0qJe67YBBL8DZr743p6LV3TlsoVfYnyp2TrgGwIrQRdNF+7bOqmJI/XRCioMS8UHBNVp6qqVFyvJzWCr55/IoQ7b4f9EbWir42CDAE6/6zwwWrFSGf0/WXmSUn74fEBLUDA0ucdT1lR0cLBPqLDVp3FJ5OVv4Y6f/iWOfEc47RLzrc+evSFO09g3ve/cHYXguENuBoze2+ub8a0QWuyNY8TO8SkCuitLgWTsRMmomjXPO+sKA32ziwk0cUZ8VLA7W+i23pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gateworks.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3bgFzcIzQyj94YQvj/kMqOGImvD9rYpmSPwjM4FHWw=;
 b=uJMVWBhhUWofbXEW+PHah729FuovKbg5IoWlzMKe/jyeRs2dekx0izoH6X3mmUjQKKGxfgk5/ktYNPJpvWWgFJwEbPN7HGizGVbIkAGQOt3Z5KQlMw18ArfPKobwGlFW/7627vwK6+vkxqXiE+xRHy5HSjXTRJzfT8+RRDrR/ShS3V4E5XoXSzPOrJj+V9ze1a/nPyMS6wacABbU22eo+JdU1ELj/QOiqHCiKrwxFs5ZRtHEc3RyFayRitDv0Hx5UT5a//oEJD5uQ6NXPx0KVj+yzkT4vNAufp1wS4GACobVX2icpsD7cmRuTFfTzp59aEFVz/aiYLxxKu+nTMdWFw==
Received: from MWHPR20CA0009.namprd20.prod.outlook.com (2603:10b6:300:13d::19)
 by MN2PR12MB3517.namprd12.prod.outlook.com (2603:10b6:208:ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 28 May
 2021 07:24:54 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::3) by MWHPR20CA0009.outlook.office365.com
 (2603:10b6:300:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 07:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gateworks.com; dkim=none (message not signed)
 header.d=none;gateworks.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 07:24:53 +0000
Received: from [10.25.75.12] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May
 2021 07:24:51 +0000
Subject: Re: PCIe endpoint network driver?
To:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jon Mason <jdmason@kudzu.us>
CC:     <linux-pci@vger.kernel.org>
References: <20210526162854.GA1300083@bjorn-Precision-5520>
 <4268cd10-37b7-443f-2c77-d5421c2574e0@deltatee.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7397b5cb-d955-aa4d-6784-ae95cc26c6fd@nvidia.com>
Date:   Fri, 28 May 2021 12:54:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4268cd10-37b7-443f-2c77-d5421c2574e0@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5760647b-1c2d-49cf-403f-08d921a9b01f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3517:
X-Microsoft-Antispam-PRVS: <MN2PR12MB35179B5C41013E63D2287A5DB8229@MN2PR12MB3517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4D6osWUo9LZWU6rv79gpu0bro8O7/XxSCfjzY07sZN21CBDy+Wos0xia5/DOEwd8V+H5HZtinPariFuakDmkV2BgE+VmkP1uku4E9QW1eKpOQ+DDO+/TN80VNe2YosJBJDOYMyMswAPJN5aPhKkOLAmlrtbrl7KqC3/0ls1ZJe2HHVNE8sZzTqjVKNLQxiY0XrXwiqP7QLts3SM5UPMyhWNNsFgg2KZpcXkJ/f6qk3iD2kmodL+ceSp05xZ2pa+3vlvpljI/QNrOVHhjQRE2m7mThWYStqonaUnfauMq7YrFrZegOMG23wa3HwBp1Npy/L+ZyIOvjSWL2gQCFXQsQ1Ir2xzTfPoYJbHP67vBEYDxn4L4GM9nS97iabIxddMDqyne+/1W5G59l4DQOEAUqPwPwU7tBXygjad6k8mNQxGB3PnFSBkfnsCPtN4OnShrdhEHmtmLb22p486uc3WGLlYBsG7OiYhff1Fqba2YuofCsjgacWUJVhlc129Fk/EBYAfXkNU6oO40MrrDF4iz51rnohFS0CvfPPAK5MmC/MNFysI/2gf6STmR0AqtcDM6NLRXqAkZfnSJrra1NS0vHx6EaYAGPt5yAXB/G5GFqXFAfJqgjjN83MzwEqQjgqpgnwan5Op+gzwHgXix5+Nljjnfobdq981/dSHLPalCdtloK/XNBSQ/uUfzccyEiplintVOGRw9PvyC98BHMheca6tWk2vKtNMx44BvD6TKlBi9m1uS0gUdxuDG/P7lAmI1pvfofqEeCG75PELUill/lh4DX19LZiutLRrGaEnyEwUlA+7WbWTBAMGth54XaGjc
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(36756003)(70206006)(336012)(316002)(16576012)(36860700001)(186003)(5660300002)(478600001)(82740400003)(110136005)(4326008)(2906002)(16526019)(31686004)(36906005)(3480700007)(966005)(8936002)(70586007)(8676002)(2616005)(426003)(86362001)(82310400003)(26005)(356005)(31696002)(47076005)(6666004)(53546011)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 07:24:53.6604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5760647b-1c2d-49cf-403f-08d921a9b01f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3517
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm not sure if it is fine to give non Linux kernel references here,
but Tegra194 has this implemented (not in an optimized way though)
for Tegra194(RP) <-> Tegra194(EP) configuration.
It does use Tegra194's proprietary syncpoint shim hardware to facilitate 
interrupt generation from RP to EP. (FWIW, regular MSIs are used from EP 
to RP).
syncpoint shim hardware gets mapped to a portion of the BAR during 
initialization, and when RP does a write to this BAR region, it 
generates an interrupt to the local CPU (i.e. EP's local CPU).

You can take a look at the code here
EPF driver (on EP system):
https://nv-tegra.nvidia.com/gitweb/?p=linux-nvidia.git;a=blob;f=drivers/pci/endpoint/functions/pci-epf-tegra-vnet.c;h=f55790f8c569368ad6012aeb9726b9a6c08c5304;
hb=6dc57fec39c444e4c4448be61ddd19c55693daf1

EP's device driver (on RP system):
https://nv-tegra.nvidia.com/gitweb/?p=linux-nvidia.git;a=blob;f=drivers/net/ethernet/nvidia/pcie/tegra_vnet.c;h=af74baae1452fea25c3c5292a36a4cd1d8f22e50;hb=6dc57fec39c444e4c4448be61ddd19c55693daf1

As I mentioned, this is not an optimized version and we are yet to 
upstream it (hence it may not be of upstream code quality).
We get around 5Gbps throughput with this.

- Vidya Sagar


On 5/26/2021 10:31 PM, Logan Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2021-05-26 10:28 a.m., Bjorn Helgaas wrote:
>> [+to Kishon, Jon, Logan, who might have more insight]
>>
>> On Wed, May 26, 2021 at 08:44:59AM -0700, Tim Harvey wrote:
>>> Greetings,
>>>
>>> Is there an existing driver to implement a network interface
>>> controller via a PCIe endpoint? I'm envisioning a system with a PCIe
>>> master and multiple endpoints that all have a network interface to
>>> communicate with each other.
> 
> That sounds awfully similar to NTB. See ntb_netdev and ntb_transport.
> 
> Though IMO NTB has proven to be a poor solution to the problem. Modern
> network cards with RDMA are pretty much superior in every way.
> 
> Logan
> 
