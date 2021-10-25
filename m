Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2B439493
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 13:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJYLPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 07:15:38 -0400
Received: from mail-eopbgr60135.outbound.protection.outlook.com ([40.107.6.135]:44293
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230232AbhJYLPh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 07:15:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUZq45I/taBGmBXR5Qk2jtMfiRXHLi69RDyP/d5pvy7mSQgXkvIlkYZ+ePiuk9gNsKuVQaeihmQueCNynch8g4w9jyfsEyxDXmt1WefNQ54dLB26esyLEnhRn3x6YYmpt0QJgSgO1pkiS6KpOdd2AWgOk7hHwlzoWpzCZT5nGUkYobx7anE6/BQM+9b6d2Jlxrh2aUBmzzmwCZdS9tJEW7pdMsMVL8yuK61Jfge5X0Hm6U37QdVBkB8adHaUxA/giM8veZHLt38MUDaQOqyZ2WQV9C0+MCxCPul1dc5GZ+xvwQnQTyI7PoPN6wf/uRWqnAMSf81eoe5B1ekuA+jGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD5Jpjps/FojkdeVsJi2WkaYpVj01UK4Mu4dolC0DoI=;
 b=kpGeX8JjzapnKupPjFbSvvZ6b5Mz7XZkjzVpZT474lMKg0r0m+1UuR7jDSeor5QiOnyQP7ffa8GDb2l/pp5YapOcazY7VG3M+9v0lhKGFGwaU0AKWyjR7jodVT3PrCUxaz5+dE/1ncSo6CwB4wfjm3Xyuu3td2g49mDY8NsRDGu9RT7HZvf3QyWIWdzy5SRUL/3CwzUeZATJ2XAFRjM38RWO60cLAUyXNTcsZ67XOwaLSmt8ZoIIFKTbZijdD0dtbGFWqCLH8QZiNXvqsi1Q06UBcV41gSPXCiQsheMWug7if9GRXc5E7M9OCCx5X5xMB3TYtXHL+W88nNkN25lXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD5Jpjps/FojkdeVsJi2WkaYpVj01UK4Mu4dolC0DoI=;
 b=V6xdoS5AoLrgkcWUL+fMd8nuPMeG5IBTnmoLP3JBvGh+CEje4SwqH2rQAqEbiMgfeyywIyEsTahsYRZTILsGiT+nwr5NqgHqBkT/UevVPmLFW8kLMease7JMAsZBEw9BH0CTCtFPk5HP5Hc2VYwOQXSRab+22mXtkxe/RT4tirY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DB9PR05MB8075.eurprd05.prod.outlook.com (2603:10a6:10:258::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 11:13:13 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 11:13:13 +0000
Date:   Mon, 25 Oct 2021 13:13:12 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Message-ID: <20211025111312.GA31419@francesco-nb.int.toradex.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::17) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 11:13:13 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 28EF610A37B0; Mon, 25 Oct 2021 13:13:12 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51280e4e-2ca8-47ed-26d5-08d997a86fa0
X-MS-TrafficTypeDiagnostic: DB9PR05MB8075:
X-Microsoft-Antispam-PRVS: <DB9PR05MB80754C416DF7A13348667355E2839@DB9PR05MB8075.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ds1cZogc/uUAWsdsErweVzgR0KaChf0Nuz/8mih8SrGnfy+6qVcG6Mwq5IPkgqLEOStmXZxXc5MB6xzK4IUUyvEYpyQjYNS4dE9V/LcqaTv0gZYZMHuu7RwT6RW+U8q3nLSv3zYQGORhFoGO4a90+fT+oWuLzY3ZI0teSlZdSTa0DzntBe2gzFgEWhbfJqOTUE3Id0I9CVFXzkonUKPEIz4Iy514Hj6ojdIjdFCUhlc4J1W8wbW/51TOKc5ZtMbOYmFQwFZFt2SrRuxuQLvOPL/Z4PWCJEUywwkII9VZM1kCACLgjjRd7q5OnrpcO+c7mZcQ9dO/LmWwIo+MIMpeS0Eb4rY4ZNEslYvY1DrAxBJqiOWPzj72rJAY+kw++IFAzuo7u2ImUCuU2GNdmX1uNB5gaPFK5IDxyaOF3H2h9WHY8YCAC2ID6ITLboXIzRfV9r25MFr3Mupq7vGq6b3pXYAiEXZnpRVlO4fxFiP7Lo3HzEDqzYfzLVCSwVxeiwV8R1/QkZptnuTTC6QWcajhuixeybd3ufdQc3GLKIUwMlFNg5fQnBNF7saYi185B3ndGOBG1RQFNvQ8AtuwQh+6xnSMm3rLUNx7EuHpPCO3jCUsab12X/2fqWqJMKN4Zzb0QPlld3iklfSrZ6H/bP5l6ZTGSp3LgxhGtiiC9SKWvIOAp3h2YE3TZ8bRtG0hNwgcMZc9VVOol+u6thKJ7TYaqNF70TL76Wr9xK3QQEbZKlcq5n+TVBIZzSeFCEK7SjnIbRTuAMhQRbyG0n351AeC/cvlwnaMIeXqgka7teoF2P/biBGPrJvaSsFUIp9HAqZdiP6RzXS6TeTQbsD0afRNPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39850400004)(396003)(346002)(83380400001)(52116002)(66556008)(6916009)(66476007)(66946007)(8676002)(33656002)(186003)(966005)(86362001)(8936002)(45080400002)(38350700002)(2906002)(5660300002)(1076003)(38100700002)(4326008)(7416002)(42186006)(316002)(44832011)(6266002)(26005)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PkNaCN9XvfhTihnd5IozOlMzQOOEREnYq9LrEj880PYF4ybI57J0HXE/iDh8?=
 =?us-ascii?Q?0TUATM3K91CX7uEiwNahA8FKq1eDWGwP9BzA56P86quhWwY9jGxvfchUnT1q?=
 =?us-ascii?Q?w4LxyFBY8lzyTVtRG+UEzGm7H+6fgQ1XS3gE0CbXTvmJ2u3CO8uPxOMAy9SP?=
 =?us-ascii?Q?ExOUF95xqYfCxkAyFDx5IY06s128ygKIsn5G+sb/O9hALJTqameJI6IJArKw?=
 =?us-ascii?Q?bhOAuzEGroKjjYp1rKXIKP29JCh9YR0FtBKUUI9ZZ3ws/YqV5u58uF/fEpT3?=
 =?us-ascii?Q?uYhce7YK/nSO1hnKMiygoV5057EEUWMEINSH6WXiwG8u3JJ1Lsz/x/18ucCc?=
 =?us-ascii?Q?y3xdavWFDpfXC49Bin0T9wdjcFfhF8J+n8e5jGwgvHu7WwU336r/cVnfrAbE?=
 =?us-ascii?Q?uqXi59LYny0NnKywGzF5KqN2aebmxxGAsViNC8/xgub5VD3h0d7rCioTLHH0?=
 =?us-ascii?Q?lCz8JC7cbZWeLgUU4Y56BKVx9rT7/vZt2xoyeLHsJzhIWpJlGgcSczIYimGi?=
 =?us-ascii?Q?TX3aRpKDEjOSS0yt5esJuPR9YZeJ/2C7OXInhzx1L2FmSJ6P3LkQiRC0Vvy5?=
 =?us-ascii?Q?K+y+liiJgvkHv+crN+/8uPRssNIlnF3QSPDZOcaZUUfBLNh+EKaLLjjI/rQb?=
 =?us-ascii?Q?0WypRNpebhzDRiGgimdEiqRAzYGK25Si8yQaYY7k/vhfe139mi1p6GFYz5f6?=
 =?us-ascii?Q?y2ehSohl8tNkt2NJJsnswAUPFaNLHjBr1P7s8i1BDsW9+wzxgn/d+UwmK3fW?=
 =?us-ascii?Q?UcNrcuXF3xz/aopVoY8ZGr8LKY/C6vG8yVAJuVZF7M3vCc91vGrifgsi5za1?=
 =?us-ascii?Q?BsLST3mG27NN96iXudvqnXfGyMXImz2jowyz0GuscBTRSBZmWFERD865BC3F?=
 =?us-ascii?Q?6XX3Q076S0Jmtk7G1vLJBFnQx+wOOmzHGaxup7t/bQ7ndiqyuTqWf4ppUBpt?=
 =?us-ascii?Q?E3FbiDomuGuf1QSnhf6GbjMDrVUQZWTCrDeDovVWBJIyzYW/eSRbpz28s0Fw?=
 =?us-ascii?Q?AyeWbC33T6rbicx96EUkPBOtqlnTkxb7y+WYSEjlqHZuE+zCkgtEmzGyfPzx?=
 =?us-ascii?Q?zT9h8GP9iGO6M+hRbgLw6CDI2QR0uSQ+cdL+SQATKajhbN28F2qEQfLgSagC?=
 =?us-ascii?Q?EL4SqxupChdER49WRVCVMRKGrnH5mHfdvfn+FB9skOdwjthXhOUSvvFQ5N5Q?=
 =?us-ascii?Q?5qBhGCCkIOwLlmV9BCYSrMJtBDjYuDLUoR9Dvxa3GCHMxhp4/P/+OAcfP7SS?=
 =?us-ascii?Q?r7Mjx/iR2whdmbACDUexDe+scydQhRW0TMtREkMITgJmt9MpdvJTVyu3is7i?=
 =?us-ascii?Q?VSUOHS45KORgoxMN67stCEec/NQEB92RE19jo+uUGK6ojmLj8qS5xw/0Hk2O?=
 =?us-ascii?Q?nL+IdLdlj2ubBqkY5xotzNu0nskXuZxyQFPaPQg6hmXcGh3MtUdbLMIAeUGF?=
 =?us-ascii?Q?6jxxZgWboih/RxLcA3TOGtV4b28imc/0EDHl6TIr+FM8uC4PxXqxzNsscI3E?=
 =?us-ascii?Q?hg9T4yckALSZzoHsfiaeiaPeM+kv+U4McCKunuFeIaHOXkUcZ58KZYF7+qcm?=
 =?us-ascii?Q?cwVt1/lepPhqnDJWOrqasGioWvbwFPxzZ4sduSyOBrl5HSdvSu2SjKZ9aPMu?=
 =?us-ascii?Q?NWztJGJv4A9Ov2rr1mDT3z7UYHrOfBZoO/P0Shu2HZelqiOnrADfEyw5W1JL?=
 =?us-ascii?Q?Pb+4odJvhEaf3DyvKitUg6rGoyg=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51280e4e-2ca8-47ed-26d5-08d997a86fa0
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 11:13:13.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YObh02VbxoDQFEq6d71m9OAGib1owS5HZnGok/aCf89LtvaG6X2WrsjlpGj8NqtWhJ7xy7sYsy8g9bp4R9/ldgienGGZNoaxOb5xviot0g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8075
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Richard,
please see this comment from Mark,  https://lore.kernel.org/all/YXaGve1ZJq0DGZ9l@sirena.org.uk/.

Francesco


On Fri, Oct 22, 2021 at 03:12:26PM +0800, Richard Zhu wrote:
> When PCIe PHY link never came up and vpcie regulator is present, there
> would be following dump when try to put the regulator.
> Disable this regulator to fix this dump when link never came up.
> 
>   imx6q-pcie 33800000.pcie: Phy link never came up
>   imx6q-pcie: probe of 33800000.pcie failed with error -110
>   ------------[ cut here ]------------
>   WARNING: CPU: 3 PID: 119 at drivers/regulator/core.c:2256 _regulator_put.part.0+0x14c/0x158
>   Modules linked in:
>   CPU: 3 PID: 119 Comm: kworker/u8:2 Not tainted 5.13.0-rc7-next-20210625-94710-ge4e92b2588a3 #10
>   Hardware name: FSL i.MX8MM EVK board (DT)
>   Workqueue: events_unbound async_run_entry_fn
>   pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>   pc : _regulator_put.part.0+0x14c/0x158
>   lr : regulator_put+0x34/0x48
>   sp : ffff8000122ebb30
>   x29: ffff8000122ebb30 x28: ffff800011be7000 x27: 0000000000000000
>   x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000025f2bc
>   x23: ffff00000025f2c0 x22: ffff00000025f010 x21: ffff8000122ebc18
>   x20: ffff800011e3fa60 x19: ffff00000375fd80 x18: 0000000000000010
>   x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000108
>   x14: ffff0000003cc938 x13: 00000000ffffffea x12: 0000000000000000
>   x11: 0000000000000000 x10: ffff80001076ba88 x9 : ffff80001076a540
>   x8 : ffff00000025f2c0 x7 : ffff0000001f4450 x6 : ffff000000176cd8
>   x5 : ffff000003857880 x4 : 0000000000000000 x3 : ffff800011e3fe30
>   x2 : ffff0000003cc4c0 x1 : 0000000000000000 x0 : 0000000000000001
>   Call trace:
>    _regulator_put.part.0+0x14c/0x158
>    regulator_put+0x34/0x48
>    devm_regulator_release+0x10/0x18
>    release_nodes+0x38/0x60
>    devres_release_all+0x88/0xd0
>    really_probe+0xd0/0x2e8
>    __driver_probe_device+0x74/0xd8
>    driver_probe_device+0x7c/0x108
>    __device_attach_driver+0x8c/0xd0
>    bus_for_each_drv+0x74/0xc0
>    __device_attach_async_helper+0xb4/0xd8
>    async_run_entry_fn+0x30/0x100
>    process_one_work+0x19c/0x320
>    worker_thread+0x48/0x418
>    kthread+0x14c/0x158
>    ret_from_fork+0x10/0x18
>   ---[ end trace 3664ca4a50ce849b ]---
> 
> Link: https://lore.kernel.org/r/20201105211159.1814485-11-robh@kernel.org
> Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 3372775834a2..39a485bfc676 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1180,8 +1180,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	ret = dw_pcie_host_init(&pci->pp);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (imx6_pcie->vpcie
> +		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> +			regulator_disable(imx6_pcie->vpcie);
>  		return ret;
> +	}
>  
>  	if (pci_msi_enabled()) {
>  		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
