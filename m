Return-Path: <linux-pci+bounces-6429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3008A9B94
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4065E286586
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FF87D413;
	Thu, 18 Apr 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A7LBXgHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53015AAB7;
	Thu, 18 Apr 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448127; cv=fail; b=bLIIDJ2cv/adDRAYpIxjEF0oW2Jc7GaxFzJCRbheQJweBiFF3taVC6EPSfeLEo+5Mib/wOJN/fhXWRhhDlc6zZLXgiRQOyucpZRRpsBTjG7yrZnnr8amAfXR5v7U17BDP1MeTW8DIB1NHm9dOTxapGYHfDSiGxj6Yvrvhcm5wBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448127; c=relaxed/simple;
	bh=7AXsMi7pMBV1RW6zCXQ7o8wunbuhTP/9a5e41RSdc/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jfBmzZRQR78lEVnR/8FgEYPbc5BNZwNsWMdpS1IqYkWSFISENbWnKtFhDoxQtcV7qDisuak3N6q5kOoCx4lpSA9JywQB3aSK+qBgYTRdV6NoZ/iMZ9QyZi/SmeSqCe8jLKiZYBVJgB6K+v2k+AWKSZmLkl1fPUz6TCfKh+avrCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A7LBXgHy; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT2B8hx5Mrq/NxNaqg+U6izuBezyq4knrFJW6W7HsnCmWFYTtUZkRyV4ZXLealMPwWw/F7/4Yv1BNwqNr2t6xyzpqB7kLb+LYQpkwlQqafCl3+5GgD0NAslRPuCDCDdLFm3jkNuRZ3eFpLfMgVF9QmA/iqp2ysyTOw/x3XPdSF4TmKZLG3Yi1we1aAk5IEbSU2MqPW/Ke+3FtkyOdn+vur3VB8riZdWKcw1ZVy8WQ4SdwhMecVkRsHst3oCTMMDgCsUTDjD9SWArCVPWMzs6RwbxG2BNF7WKiHbNLGua4haTAfY+wuhZ4EwVtQiP1qkKXiXdv0rd3zC/3O/6DJLjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmUcnZTBCbse6SiFlPbrU34npzJi1kac3Bf0d/AK0tI=;
 b=MCA1tquJVeDq0RvuJZnKGcIO6kNAMtpOnvLkaGKXPRfQdMSo8vSwWRG26WOp/VqE5L41/5r8wngpARKRGIfUA/uY+bYPLVhAHRk/8n3H6dGlzst/sqFmUdHkZQXGkWSY8ZSPNf4JQrP3gASzOhqUsSqSygIfQ58OIJ4iTE1wmpAWDG9XUg1bblDHtOGSymrEDovmVuL8AaXTWj6xzTMl+PgY2eFeZoQK7ZXoR1S/JRswmPbt1Gl72G7qLp/g9GyO/NhVdie91zx3yNqOQszQpWiYycVP/dkvDhnMjq+OZpDom+72eBgl2wpyjZryirbFNX4qvoym3wtGqU7hnbE2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmUcnZTBCbse6SiFlPbrU34npzJi1kac3Bf0d/AK0tI=;
 b=A7LBXgHy/lO5t1SR/qYPbVOH3SD8M/pw0y+6KBUJBQWJhi1ii2+JTWX8Y4+234KplKuHcOwe2pINEEdSWMgt/006YQlKYNvXFSwTqFOOGTMZVmDC2Irt8dub57btsFFZkY/zld7QdbL6xZzdoM2baybIxGKORrIWRutHPKFaRPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Thu, 18 Apr
 2024 13:48:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 13:48:41 +0000
Date: Thu, 18 Apr 2024 09:48:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <ZiEkr3uTLK9B1jGx@lizhi-Precision-Tower-5810>
References: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
 <20240418-pci-epf-test-fix-v2-1-eacd54831444@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-test-fix-v2-1-eacd54831444@linaro.org>
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b1edc4-8615-4627-3812-08dc5fae419e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IrDBbepmNlxHYTiL2iN2NZcsxfwSuiGRaq6FWF2NPhp6UdAsyzZXk8wN/WEl/QJVt/AJgWc2gvkHsop6fX6gHwXXqBWYy3we2S3hL04nSkawrA/WIhuHTndfy5Qb1O6NLZl0axdufX7sRqYKlSYBgcmo5a3xvq0uLGQ3IcZ9SvoN6YXKAgYjBdqTsWU0y3I7D66WdGK8MqrRRrDsGsro18wVDKrfQ0RpG89PO93ktD787V8vKJPzvwY3tBtd4ASZyTYUYx5jHHERYqr+WjHbT9sflnrfSpW9tHBEF5XB7/zMpGKAMbLXgfMsyDuHH5681NVkkybO5IuI/3EMZxOgnC+OWseC8iyYKkz2cR1wLLPxEaSmdu7hVnNYQvYFKAGQQNZ0bJTzb9bW+Qo3zSlr4NTbjK3H4BzC9lWLOOtamtlGfLh+22FwkIM6U99urqWdQSRNAPtl3YWjdepsWjn/3x6Cr+esfRzaVpo8ZqFZ/MfGVTZ8GGVlaTRdMId6abkfLGmdPGWD+Bdk5hzFSnDh+rtfLcLHmltpEl8eB6VBdpduPyGOhii4Ud4hrSdpYfTquSIU+4Zdq7mIiYV5U4+Z5B5YIdpbzsXrWRCkkxflveR68M+mN0nwROzdArcTJDd3NkPd0bQYzehRXtRAU7OmIbms/WpRFKs3AFU7IJ/utvOJND+eU8Is8uUdB/0es65apj5ItKOkRGTumPGFK5nLNB7EV7cz5fFB37vSmAfUM48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8NPmmMmXgfuYyVwFh6N0/bnArTVUad+Y4FkQnPHNpoGi5Lg76tJULWi9KU/B?=
 =?us-ascii?Q?wKFsVLvJex+AJCpvZCFcc4Hl5ApHUmARH46GfBSUx4DCpYmdnuiQyYFE1260?=
 =?us-ascii?Q?w8eYdKrJALyS+TICLTkyHXJzAQgINYi3aTqRrdUXrNFnMxQRagIEzohslA2m?=
 =?us-ascii?Q?8olTKiv7SbxnTaVhdRWHVfFHM4nA5Hj8+YTCe0iGeEUUF3NiSUodyY7IQoLl?=
 =?us-ascii?Q?J0AJhRbcK6+lq8maP8iwBQBrATqN4n5TqnpB+LcLkwFSg2TUogEZKpVrLwiY?=
 =?us-ascii?Q?zP16jVw1qgGoRzqMrre5KLg1SekNt6o/yBP1+5zmh3TZ0AR2LZQxv6C5VkHY?=
 =?us-ascii?Q?WwYCedUMW1DGJdoqjWSruBvxOhPv+Yn70cbEW9tzkVXIlMqzGkfKh6GOKdzu?=
 =?us-ascii?Q?wC547BHKxPCjg8WLEmldQQeW2hRNJeLA2ZBnctnnyQ05BQ7Q+TfZZgX3FJwD?=
 =?us-ascii?Q?n9HZGUn06cF6zc6Hgt0NQwzJVolCUNY+5bmk4SbGjfAb4CP/ye/rLt8PJq+4?=
 =?us-ascii?Q?qfKk8a6qftzufaQH0dUiWCPc4uU7ncsjzvzhl91Lmcd5yJPJ3VMWAOYOy1FF?=
 =?us-ascii?Q?nNZHuaFVsH9D+NyOzuw3ZY3EZ7dnVGwMFyU9IboBbG7Ze0SOTIbkV4hc5/SD?=
 =?us-ascii?Q?X3l5Uoi2fNdT4VMAinx7BPZWQnqGnwX6VHDW+pCI3nObeNQSO8IXfD/TfLkW?=
 =?us-ascii?Q?xw36Gqg4IlEGvjuGVfaWzMcLm/65ifEHzTLFVNlzRahrhym7U1t7YVvSRlnS?=
 =?us-ascii?Q?3Ag3tRIYKdUgOsQ2kZGDQmIttVRXJ4CPN2/In+uvX9QWes35u/2TMIegkxqA?=
 =?us-ascii?Q?fhvJLYYxk8wjPAMzoVbgIn7NmEqCm5rhz1kdwntJKw2KC1FnT17ou8zl/yDe?=
 =?us-ascii?Q?0ALnWJpBgjFv3bPHk5qbnMk0MZmeA7gT8jvbhTimRp42Q1nHGPsGo1wK6lKQ?=
 =?us-ascii?Q?SZT0ArLbr8oSyD0xDm4OQWubYKhS3TSo55A25fDGCLjfm0a0rwVSIHbcxuLD?=
 =?us-ascii?Q?LmdaxhjcjJLRWnFdPDQgOI0dSod+Lj/3Zyqw613R3nOy6WTJhXmBkRzLjqpK?=
 =?us-ascii?Q?obOQOSDRiRZouYveoiIDS14wRUcAdWyhcCpP0zSosd4u0d3vqcSnhQYFYs5d?=
 =?us-ascii?Q?NUw7apJbRkkM417JLZCBBVoQfCuZdz4GzhaD23RKKIKfTas3iZtVtjXMV7YJ?=
 =?us-ascii?Q?GNM3hXlRtKPesau8DXr+L3ukv9s0rj0vGgRWD9aXHYki/kRtWp99FS2vHHVN?=
 =?us-ascii?Q?HGKKA/OJ7O34TNNrFDNSAnUCZaXbBPua1GHtUIC3cejfKgyvvio6Yh9AwpfK?=
 =?us-ascii?Q?+pjk4mZJtKymt4PeWErIkxtFkHi98HztJujMipsYn74zCkKJaJyqca78VdX4?=
 =?us-ascii?Q?BAXUqqVt6djnvzWwLmKof+Lfj2qYfaV+7j7oG+yuYe6Z7riy8PEa7fIFSVyW?=
 =?us-ascii?Q?FCa8D0CW8n34MlG1b1X6pUqgTS8Qxbm7ZuPFzXPrRQhxr2V8c1hsywvTzzlR?=
 =?us-ascii?Q?8kzkX5Qjg2hT4JeOpxGj+CC28O/lJ1YuovMgFSvptRJWXI7vFRhrk+/C6E02?=
 =?us-ascii?Q?HDhXLkN5Miv8+ecqUso=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b1edc4-8615-4627-3812-08dc5fae419e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:48:41.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLvO/7vxIh4K6BXuyC2BSI9nkdEC3vf/Y7xe8uBodiWgKSbsFJBQE7rj8XYf7NGN3QXwKQH1CMH6xsigYAfCcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640

On Thu, Apr 18, 2024 at 01:29:58PM +0530, Manivannan Sadhasivam wrote:
> Instead of getting the epc_features from pci_epc_get_features() API, use
> the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> the NULL check is already performed in pci_epf_test_bind(), having one more
> check in pci_epf_test_core_init() is redundant and it is not possible to
> hit the NULL pointer dereference.
> 
> Also with commit a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier"
> flag"), 'epc_features' got dereferenced without the NULL check, leading to
> the following false positive smatch warning:
> 
> drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> error: we previously assumed 'epc_features' could be null (see line 747)
> 
> So let's remove the redundant NULL check and also use the epc_features::
> {msix_capable/msi_capable} flags directly to avoid local variables.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> Fixes: 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer core initialization")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 977fb79c1567..546d2a27955c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -735,20 +735,12 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	struct pci_epf_header *header = epf->header;
> -	const struct pci_epc_features *epc_features;
> +	const struct pci_epc_features *epc_features = epf_test->epc_features;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	bool linkup_notifier = false;
> -	bool msix_capable = false;
> -	bool msi_capable = true;
>  	int ret;
>  
> -	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> -	if (epc_features) {
> -		msix_capable = epc_features->msix_capable;
> -		msi_capable = epc_features->msi_capable;
> -	}
> -
>  	if (epf->vfunc_no <= 1) {
>  		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
>  		if (ret) {
> @@ -761,7 +753,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> -	if (msi_capable) {
> +	if (epc_features->msi_capable) {
>  		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
>  				      epf->msi_interrupts);
>  		if (ret) {
> @@ -770,7 +762,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  		}
>  	}
>  
> -	if (msix_capable) {
> +	if (epc_features->msix_capable) {
>  		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
>  				       epf->msix_interrupts,
>  				       epf_test->test_reg_bar,
> 
> -- 
> 2.25.1
> 

