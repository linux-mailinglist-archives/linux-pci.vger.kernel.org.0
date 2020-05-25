Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70FA1E0735
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 08:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgEYGok (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 02:44:40 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:28512
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388385AbgEYGok (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 May 2020 02:44:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhkhhRqA1WQTVDFB6WSoAQne/GUpYUDNS8fdle8s4+4SJf4/v8fxcF7JQejPPezwGBaUHvwulwNgfh3ZzK60NW6bda/tOOWJAV8SDTwBeFYzkT6L/SG4OrQNuv1BZkoJK3RdEx8Mke8Pr+Q9bxddOm+EcCZkTSdnjMXShNMMCGRs2SlIEJJSLInogWDLKTztkItwkapTLrBxDKRH6HwfZJ7Hvp7kv7e2E8uoL+WtCZQSDlQQLNkISL2kmph8q0gVpq1s5qaVgn1p6SYH40DDfY1bGSF+tw/FY3+0Qhy/z5p9bwQJ+hH7YmcmzcssDrUEB++pMM/uT/yJHArmFMwiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvDsdbt/k4qQA2FsJjdceLnkBst5NRqNBOzIpXVe8a0=;
 b=MiDpMa9U3jbW1kAnM1qFXv45PyotT1zsbMPpX4EriLk8BNsfszucg1NU86n2mjWECIb3d+xTxjDpnCLiwmRRfFcOatHzbLDWDYw222LkqlA+UqKPEMxUugNAzwKnG8ZkP6xMP+7EufrT15hGCET/09AXGARnrtwbqXmkFgPRh4r1J4wbTq87GVjPiC3DOk4/aszPNnkvwbeiVGDo06ReCVbiBwSizfcs7HPUGKpvbGJ/ZXtgIAMdkZmlyER3CRWq3C2R90rt1Gfjfrgka4F9i8dQJo2OvapAix9YeGxaRcPAjhZw4M2JRH+moZMC1BowK7clkwuHSRWKZr7f92kPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvDsdbt/k4qQA2FsJjdceLnkBst5NRqNBOzIpXVe8a0=;
 b=ZS6FLHAHGzmrR6t3nKsWLaSXujMLb1og7eEU3WRul/ZyE3rCWLKCMwgh9yAF0zKpffx8NjxLndj/bCX9a/tiPL7R0bewkwotg8ODOn2+WBOTAQ9pUDtAtnoPjAeCu6on+REyaD2N1+6S4pa4JxQkKH3aDNttYpqVX+HKJd2TJII=
Received: from SN4PR0501CA0107.namprd05.prod.outlook.com
 (2603:10b6:803:42::24) by BYAPR02MB5381.namprd02.prod.outlook.com
 (2603:10b6:a03:a1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 06:44:36 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::3d) by SN4PR0501CA0107.outlook.office365.com
 (2603:10b6:803:42::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.9 via Frontend
 Transport; Mon, 25 May 2020 06:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server id 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 06:44:36
 +0000
Received: from [149.199.38.66] (port=54569 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jd6qA-0003lJ-DG; Sun, 24 May 2020 23:44:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jd6qh-0006Nf-Iv; Sun, 24 May 2020 23:44:35 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04P6iXO1029510;
        Sun, 24 May 2020 23:44:34 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jd6qf-0006NP-NN; Sun, 24 May 2020 23:44:33 -0700
Subject: Re: [PATCH 14/15] PCI: xilinx-nwl: Use pci_host_probe() to register
 host
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
References: <20200522234832.954484-1-robh@kernel.org>
 <20200522234832.954484-15-robh@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2fb27897-a715-520a-16e6-5c22bae96855@xilinx.com>
Date:   Mon, 25 May 2020 08:44:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522234832.954484-15-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(39850400004)(136003)(46966005)(36756003)(26005)(81166007)(82310400002)(356005)(31696002)(47076004)(2906002)(70206006)(4326008)(70586007)(44832011)(186003)(8676002)(478600001)(54906003)(31686004)(2616005)(110136005)(336012)(426003)(9786002)(316002)(8936002)(82740400003)(5660300002)(107886003)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f60c49f-9060-4d6a-e744-08d80077170b
X-MS-TrafficTypeDiagnostic: BYAPR02MB5381:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB5381FD81CB9F10EEE48FA294C6B30@BYAPR02MB5381.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AcheypOKm28CWznaq3tvuphkmF5+UHqc5EdOigm6BsphxSDa/XvvcL728TgpZh5dowMnKE+wbY8vY5Vd60ymYP+mY+THpwl3Al0Ua4/1X8Y61kLo0dIxy2NGKZ+8ACKLD22e5oOsqwtQAdWOaYalKNd2kbEZKap0rA3kLv+PMZcaR2LdqPWaSbI3s7kFW2N/ZVtd4i0CJAmHZ2m/4wG169p9IJ6oCGGXL+bFvFa/wBnJyUzii40Xv60ncTQvl3XEnbUy5l0B4MzOdmLZ7um0X0d70d/nM3fwemjRgR1hRpKfUiLfDuw7gNZ8EFfS1rkD9jZco8ZZiXZgtDxFcF9yCctoFSmdvH9ptzqCrmCuAwWicje67eGQvY02VUZ9IrnRkL6ZE+2lnygV2WKas47VuidMPKSlHSDmst1QouKBi6+T9A921FrPC/io/2wbsOe
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 06:44:36.0619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f60c49f-9060-4d6a-e744-08d80077170b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5381
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23. 05. 20 1:48, Rob Herring wrote:
> The xilinx-nwl host driver does the same host registration and bus scanning
> calls as pci_host_probe, so let's use it instead.
> 
> The only difference is pci_assign_unassigned_bus_resources() was called
> instead of pci_bus_size_bridges() and pci_bus_assign_resources(). This
> should be the same.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 9bd1427f2fd6..32a0b08d6da5 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -817,8 +817,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct nwl_pcie *pcie;
> -	struct pci_bus *bus;
> -	struct pci_bus *child;
>  	struct pci_host_bridge *bridge;
>  	int err;
>  
> @@ -871,17 +869,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	err = pci_scan_root_bus_bridge(bridge);
> -	if (err)
> -		return err;
> -
> -	bus = bridge->bus;
> -
> -	pci_assign_unassigned_bus_resources(bus);
> -	list_for_each_entry(child, &bus->children, node)
> -		pcie_bus_configure_settings(child);
> -	pci_bus_add_devices(bus);
> -	return 0;
> +	return pci_host_probe(bridge);
>  }
>  
>  static struct platform_driver nwl_pcie_driver = {
> 

Bharat: Please review.

Thanks,
Michal
