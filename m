Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF82B59E8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 07:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgKQG45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 01:56:57 -0500
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:35328
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbgKQG44 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 01:56:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ5WQ12l6+8MYqPkQl4lL5ViUlor+WA41Y5e80j88vVMVPc2CFfB5tEXqcA6U9voP/72akrmbkfd7h5SeAsTfgAVexfM0DQMELQYkeWZ85Y5tfVv85CX72+csU2kkB4sht2e8BsflBNL3/Aby9kpyp33JnD0Qh1yqyGl8PrJtp44rSs3Se0NSSt+54Y7qpOORhwItR6UoYwwFwNtua+kxBAbAU2W3xSBnuZtk47aCC6Yx3wljqiqL1t9765Bitn3li+3K72rGpZu6ypO8xWYoYJdGWFcMh0NtBZvoyAWrwDE3qmUbp9x+ZnI2PdEYqv9c1xqccbZMoa7LaDlTyXeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9vk2H2B2fKcUiETinYD+1Nl6+JjzWoD9EaNxWrzcZ0=;
 b=mt2S364+dPSTlgCZlARUBWxr+EarLM99rwkyhzmve3m/c2WGGt4UZtxrMW6eiXESfdEZJU4qLdN4nlvK7zYQb8S/zU0W65sfW481RLakwDUrhkOBIwKuvGArZ0Vs7VVaKKoMLHCgZgslyFgnVi7n4W4Q4NobHk58kduZQfkA9r6a/eP83Z+Im9utHVlnfmaoGnavD+Ir+VzE7Bnm3ovBMWhuahmzUmoD/YWPvInR7gj4OQD7MW/RIWmQ6NWu44CfMFYgKPkM61GvAldCItmmgw9BLHHZ9j661L0h3Qtv1gav44Yvj4kIo4fufj5bvTF6vo5Ptt0WQai5uVEdzML68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9vk2H2B2fKcUiETinYD+1Nl6+JjzWoD9EaNxWrzcZ0=;
 b=k5dTAmOBY46NVkiNNnpFY+LFrdHAMLS70Ax8m5H3kVYaBnSjdD8CdrEaR88UfEvzuXglI6bnogPs9DQiPuTJN+xUFWnOIVs7d3jwqjM2CMXaNVFeA7Jz5yfVoEiYkaBsWLcCP+y0tu01boMIkJBPDzZnMbL0TFReh0FBfyTXxok=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SN6PR03MB3568.namprd03.prod.outlook.com (2603:10b6:805:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 06:56:54 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 06:56:54 +0000
Date:   Tue, 17 Nov 2020 14:56:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: fix error return code in
 dw_pcie_host_init()
Message-ID: <20201117145636.0267b2f1@xhacker.debian>
In-Reply-To: <20201117064142.32903-1-wanghai38@huawei.com>
References: <20201117064142.32903-1-wanghai38@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:a03:2ef::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 06:56:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d792d6d-b6a7-4298-b3cb-08d88ac5f78f
X-MS-TrafficTypeDiagnostic: SN6PR03MB3568:
X-Microsoft-Antispam-PRVS: <SN6PR03MB3568EAEE938DEC73F7B0F741EDE20@SN6PR03MB3568.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NLUpyODzBxSSqpQvmvVTup2nMvfPNlm7DChOlFeEIWCrNSHAtEfmaDoX9wHcDApByymigxNXa945Ni0w/oKYEe95xdndCdi79kmjplICzPSyh/mhDNFrIu+hbLBn/xnHdvsBi4mpniJqBTtq+9E4MADL0pMcU4OXlTpqA+gWN4goBLTTc70WA+/bxlybAvT6ytePH8MhDOZbHxc+OK9mfM1VFJDTl0ovGZoBbxuPn5N4uYS7OR0kSEw1b+r/m+5Trk3o76beo7263zynf9R2euAlbYf7zq0jddn9MUB/ruKMEcqqrMt1lMpqZpJQSWys4gt78w9XD/4W0kapt8OhuXYG4ns6IGwh5Rba893WAGIEHKReTosI12l43CYjdOv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(956004)(9686003)(55016002)(8936002)(54906003)(4326008)(8676002)(2906002)(6506007)(66556008)(1076003)(186003)(26005)(66946007)(16526019)(316002)(6916009)(86362001)(6666004)(7696005)(5660300002)(52116002)(478600001)(66476007)(83380400001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R5jdk2G6hsujCeUcohjsIAJ7Uz74EpbmLGrEm5W77zFoMkxq36qNrMDPXRyUOmNW1LAROEDASmMfUPwUtvkXgrvhGmeCeZ6FvfWXmq8RNLPbK/5kAE0PJAeJi+Ygq7qIpe2QmGZo+H9RzFy5CCm2Df8OW6AVTtEclBhJHSiTbn4Zr70qHIkI7pDWXFRxzX7CsaQ7WOIqZ1zKud5s2W12CHYrWGfKQYLfhhXDEWkvzMLLcmnrbewSaCDlZs2rzrMr2I0/T7NBqaZXuEcSz4Q5N62oh75kUzPhp25F0dagtiDgEwfK+lJ7xQ44GOdY465QmJ0uAOMfPJXRx8eT+zpENWeiVRzBTmRXq+OwSWAYdjFeYrU+C7rcVwyORHpbX/RW59x2B0FB8WvuTnoj9ipS6DO1aJCO5rD+7Uh1aKZI3VFmlx4TQ/aLtU6Lau+ctPsPps+OGQTi5LY8xOXnmRwXF9+/HSZa3KrWe0PjQFVNFBylePkat4yOK5po2vSXHwMNP2r8nZIfaYEs5vgRHBupcNN+yaaMwIHlfmjovYaoWDTdrlUXXPaKwDz1gFy93HlkimKPiN8C51VjuIoxHIvLLx/HpKMSAzcOQsStadvbrvD/X1pBIro/N29Y1zzIgjuW5trmykKjA5hATAAsUC99UQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d792d6d-b6a7-4298-b3cb-08d88ac5f78f
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 06:56:54.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6MicCG7ZKT/nxSlDRn0z7+j2v75cNXuyqG1sbM7qA5zbJnivBQoe1VSLlS0YsBzLGx7xT3lB0AufByieHEaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3568
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 17 Nov 2020 14:41:42 +0800 Wang Hai <wanghai38@huawei.com> wrote:


> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Reviewed-by Jisheng Zhang <Jisheng.Zhang@synaptics.com>

> ---
> v1->v2: just add 'ret = xxx'
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 44c2a6572199..42d8116a4a00 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -392,7 +392,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                                                       sizeof(pp->msi_msg),
>                                                       DMA_FROM_DEVICE,
>                                                       DMA_ATTR_SKIP_CPU_SYNC);
> -                       if (dma_mapping_error(pci->dev, pp->msi_data)) {
> +                       ret = dma_mapping_error(pci->dev, pp->msi_data);
> +                       if (ret) {
>                                 dev_err(pci->dev, "Failed to map MSI data\n");
>                                 pp->msi_data = 0;
>                                 goto err_free_msi;
> --
> 2.17.1
> 

