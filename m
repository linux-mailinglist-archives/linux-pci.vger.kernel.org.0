Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56D2B5666
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 02:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKQBt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 20:49:27 -0500
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:19841
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgKQBt1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 20:49:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRhyZQDZ6xNEofKsreCvbIX34ISupQnJ64X8wVFrqf0CloyOBXzXxHOLVKVCNi4R+F+1Y50EpLYoi0hthcs7N9glCUwK/vGqKGWVl9zGS4wLYqH/q5Ccl9KSkc8PsRmGXs9Jcvp7z+M5BT/gswGSu5m1BSNfvjjQjL3hfv6g5ns6cTgyfP+PS41lAB1vxWKTFlNnfiJmEPm+vAAbVGL08LNXGsJzbJKovaLEENSOEeWOdgBoyFBdirdBsTiXFxOwG7HSSr153hJQv3ZQFZeOxmsR/Od+jhsUev7zv1jHotiGCEV4znOOq7Yn92AJ35lAo1O8CbniqDt6tgW53JmIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/u9+jdfD+9lq3lPfYrSWCF4ykvqjLdKEGZSKZr7L7k=;
 b=GyCsSoFOLHYeKN013UcXBxr45eveKcCHJG/CfL8ePbzCMavMU6yli4BN/y08/MaHDEw3sM4Qju1FPt53O8trwVfOhl9UnZEMLUxnsOfcM/D6fDHSHrb0Spl4UWoilzV+9NbrEGECaikyX2O15oGap9Pl86HZ0/u/l5iez1w27vRKE0sfvlHPBiNsAx1Q+4Kyn+E2viADdTv5pUFxYxyel70Q/hKnOZI7rNo5mzMwiLzWGefCZ6wdegxQIOQrgkdKYcN1s4OlyGdD3QappDIL6ZSD+62ynnFJJLfRJWmZSKX2ID9XdbF/o8C11K2LuZjHZ1/GSMkxJQ0ZI4ExXXIKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/u9+jdfD+9lq3lPfYrSWCF4ykvqjLdKEGZSKZr7L7k=;
 b=NLu4YyeRi40w0g8vXKtSIDLkfLDdYYZ7meyPEY+NAnlhSwN8Fbez0DxluFx2sleylFpwczQUsnqVolzlOCw3vGI6tx97jkGT+2rZ/Z1aYkE165yxfRhT6uckYr8OBlR5iG004zRNyOKp1W/Htj4ul2KjWUsUQ2VTiYbiAUsbeAc=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SN2PR03MB2205.namprd03.prod.outlook.com (2603:10b6:804:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 01:49:20 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 01:49:20 +0000
Date:   Tue, 17 Nov 2020 09:49:06 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: fix error return code in dw_pcie_host_init()
Message-ID: <20201117094906.6e196cac@xhacker.debian>
In-Reply-To: <20201116135023.57321-1-wanghai38@huawei.com>
References: <20201116135023.57321-1-wanghai38@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.16 via Frontend Transport; Tue, 17 Nov 2020 01:49:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65b00ab2-5cf8-4489-c225-08d88a9b0049
X-MS-TrafficTypeDiagnostic: SN2PR03MB2205:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2205CFD102C280CBB2C49299EDE20@SN2PR03MB2205.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hm/C/m0PW55H2J1iC92nGnz22df2ytjaWHZqNdpWZsHfOv/wTm91j69CbiftYOTeNz9C+0LSuobgCa0InoKDkyaC5Hi+DbXGfqUib6+lHyUmXyr6pqnNNFlhL9EcU44vkRgQ3/iNEzF2CfBtP/wvZLbuL++kxkdmA4ap1vhwgkKZkkmjPGAQZiRWDhrKzIYOink/8f81s5e0T9lLxwUyGmMTkS2ge3h7m4CuSsK0sz3qxio7K73EOF3c5vNWN73IlJQ46UTP2adZ6TIWyTtXUZl4dnL3PNvui/ObDe53v57ECi9apdzQtSc6+xlrLVHuqQPu8HPrp/kE+86gOHprUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(316002)(66476007)(66946007)(86362001)(66556008)(55016002)(9686003)(54906003)(83380400001)(6666004)(2906002)(186003)(8676002)(956004)(8936002)(5660300002)(52116002)(478600001)(1076003)(6506007)(7696005)(6916009)(4326008)(16526019)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V41mY8exDevIU31AxbXNDpgHiU3Cuhz+/eC7Zv7aMDccjhCfGNaOqz/Czi3eEbFU9QU27CTne99+u/d1R0cEaW3SlSxx6GNMwh0GWHCodUvn6tJZVtYUl3kCTs0Ef3pNwsHHXYfsRaVJDT+kL2k4QFfkt00vw1lUqziOBq1/I2Pi0O3sg23ha17mSxyi5rNIpEVIjxS3s6eipZE44O02012UPkH92JxRc0orFkfo7T5CKMsXqM0g2P8gh/aHWE9oL4q/Hn+JQ2vzuY9hU/NU7OXZ2GnfqQLKsUrIQBTgA+7rPgSWcOElPj+GsPBdb4tjjBKLBapMKZRpXI+cA1C5NybWLhbXNZrZsWA3+BRftwc+ZAkZ9sAxSGpBJpWBVomuN0K19jr/hginajijneANBwQsbKY+/xZLQUUOLk19ycaUdlv6c6sUuR+Bn2NSAKcVkSn/wmvlkD51BSyO788upF2QWOJqSsHQQGYLqVpPkFoN7Lp3MWh3YmWPJAFd/7UEgHr4Q4vAe8V9JqR1b2nNgNdcOvHziYuBQmwAHlgtK7jB0dyV5tzVBBO7CrGsyDL8uutwpCCtDIZUiq63r94ioWIHtfFCINHJYn6hfXfwbVALuhpqBEnCpUwLHOTxlmomG5XAf+6qcqryGGhynqS5kw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b00ab2-5cf8-4489-c225-08d88a9b0049
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 01:49:20.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMpSz8YVcfvzXmX/OlNh/BMoVJbKty3No0HJYXLInFYBBrbRGkVVWBgRq90zTGnqSlpNOoAvYe+nmQcoBUkdMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2205
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 Nov 2020 21:50:23 +0800 Wang Hai wrote:

> 
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

good catch.

> 
> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 44c2a6572199..7b3c91c6ae02 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -395,6 +395,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                         if (dma_mapping_error(pci->dev, pp->msi_data)) {
>                                 dev_err(pci->dev, "Failed to map MSI data\n");
>                                 pp->msi_data = 0;
> +                               ret = -ENOMEM;

what about use the return value of dma_maping_error()? I.E

ret = dma_mapping_error()
if (ret) {
....
}

>                                 goto err_free_msi;
>                         }
>                 } else {
> --
> 2.17.1
> 

