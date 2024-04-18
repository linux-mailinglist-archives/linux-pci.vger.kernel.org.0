Return-Path: <linux-pci+bounces-6430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568028A9B9A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E521C21B9F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C116191A;
	Thu, 18 Apr 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oqKwGbPv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D565161912;
	Thu, 18 Apr 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448153; cv=fail; b=biOc1ru26/Y/UYTWl2noTLZATtmH6ffJ/X7Bp/hHhguk79LT3rIyIADzq/CtPh0e1Im/SxfnB+sAMmdARBfW5DgjsiemOEF6MNjIHQXxi0lp1oi8CGMoEdhFFSw3EAG+B0gZ4ptwDM9KjjVxADCZ+G983y/fSP7iyUixK1xa4oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448153; c=relaxed/simple;
	bh=121Hjf1c3D6tvravgBqTMSa391pllqxx1Rh7Aq+ecJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WSicmkN4ivkbNQ9SSWOIFOGC+zaTl/vQq3ocHNcWrXUc8V3lm4bGVQ3rSkc6xMUlfsxQVaRFdqZqTxebN0+mTiaDVVIkb3SfuglNb02yZRe5aixEWMA9Sh1CFXLmWXqopP9qj1FcRweGYj7iMnYK4oUILWAtbt8E8w4ymXN6HMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oqKwGbPv; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMBv6Gxmhe7h5pQrtlwzoRe25XzO5ZNO98c4eLE4mN/3wchkEpWeM5tGXjNy0FhiUZwYpIkHt3keACkWLB0ezBZlJGTRiruPcoA5lv0p8H97kfGiZ9Su3F3s/VERH6oZEr4/tbgyaUblWlk0AckqcW5wejS5gTbustPm79VbVJleLu985T7tBNIKXLP+yEsUUPOD1h3O7/bUh+FsyyNKwOoMUJgQfB1EEgj5b49emJp6JkrRWua4vcbVuA/DXKNS8N7vU19g6d7WU31x5LVq0GNyo3tIXyDx/WNPfbGLs/qAmRXuzkToPTZ/MX4leu8l357/nkwDedlzyd2yB0ZUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9UEpkhW00ecWS89MtDAWIiTESRocBHkeCWBy8lSDX0=;
 b=nsVCm1knkLv/mSeCcQIhsJhUgSmz0V6pFPn6cjI+FdBo6+KnpEK7dw61EowVygitZJbWVxdDE9cpD6BR0Q+lH0E7VkX+uIRGvJckKSTKq9xyWX4FcKqpQg3kfXH6Y9LSYtbp76Q/a2VdMKx344G4Y8ZTZAXG5ov8C/XKd55i30INC+H94HxmZuRwSqdgH0tBeZdnK0JpFcAKqAGKLkJlFLI2qydwjrYjeZEbKO9V3pv8nUDaMJ0atK+00oDUCCdjRUKvZP2OUJAGu9sXqVcWmIz9nJ44FzwTVKgOvBy9QWtpC5o3gfwEpo+2X4lvlaerN2lvOvKNrVqKelCAp3ppcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9UEpkhW00ecWS89MtDAWIiTESRocBHkeCWBy8lSDX0=;
 b=oqKwGbPvfO96vM0IQ257yHRrmJLcKorGWjO2l3biGuCe8tOxKTr9L3Ggdsv90zOpqFIlCKSt2QMFT1TDAJhVitCgRswydH5oUb+PrnRM2awxUyhz0hnwJOeyGPc2NJAgkjbtOlpcojFPaRyeq7XOBdpjrAaULlmc0zkWFH34nvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Thu, 18 Apr
 2024 13:49:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 13:49:08 +0000
Date: Thu, 18 Apr 2024 09:49:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: endpoint: pci-epf-test: Use 'msix_capable'
 flag directly in pci_epf_test_alloc_space()
Message-ID: <ZiEkzrwelbYCFO5P@lizhi-Precision-Tower-5810>
References: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
 <20240418-pci-epf-test-fix-v2-2-eacd54831444@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-test-fix-v2-2-eacd54831444@linaro.org>
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8f0acc-1212-454b-4a4b-08dc5fae5205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/J145NfifridSQ/Dq1sgB13jCI7SjJrYDXp6bohc8FRwVLnUR1ghanVcF6vEHBZR8yTlTAmj52DzcbxPGI8rJhNwtBMFqt77vyE1PO6HRXm+uJOZHgMH6dhAGoFvFO4U73PiVIExihvoxLboB7wC4pTe2c4BmxhJHijaWCBsPSNcO1mCctAoQbWtG82i5J1vX2n+WwUQ7ujze3/ZUE33yr5xSrQRZ+eCb83OevTJY1Gi4mkb5/p+yjVxzQIcSZqHuzO13x5KoQcqQ/jaoJ5OZyu/UdV5n7Nro3EpUPAXqpIZKbh7Q4sAs44Pqscv6tN+N/iLwup0UVb3WWiPS+FwadKm8eG4Jm0Z+EAeFhEp5jUqEVG89HeVAeQX1GOP3jx6RafKnSYHEZbqJsEPlBxEy9VjffAE+BKd4Yn8kcrS5PNEODbjyjKWnK0V2c55Ch1BfHc5boVMn9JI+2/ynkwy/GkSBkJyatrq/dn+HMJSpCarpy9WpyWIjk4iclHD8EpMstauoQ1B9mVCPQ9YajWXVa2zaygc31LEB32+yQ/wSGZIWSTQKWu2j+DufGTW7iiuaY/Mz37AI5T6P53tdJRapqcd+TcHjzdiwq4zY+p9tWjP81XZo83GED0lKe5cpMBoh+3epDh0hctOUk4K5O4zLkVV+BJHWP4hG9N/BUT6YljQnepHHXOtVm7QCSQDejAp+xUT1ITnpvjNSUhGlLUlmn3TiYRjg47QV0IaRqbk6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XglSshW2H+NP1sWn801vGsdGNeIjW4EhUmVz0waHZmsn227LZYp8jMxW+k/K?=
 =?us-ascii?Q?q8MUVA0AJ+saCxm33UYXFHDIIEiEuhg+AHjVUQjdfVc+al1MFbCXqW8JjIZa?=
 =?us-ascii?Q?owwzit2uZgOtw6CcjA7Wn+36uJ0SlIy2Q5BbfYAPEwMuuJ9xKEyTe/CtooNH?=
 =?us-ascii?Q?nGF4WvurbQchrlku3NdKPvNDQKX0NCyeMbzuAq9b2gfWyWRsVQfNJp9gj8Hf?=
 =?us-ascii?Q?yFgNJH4rPf0ulq0SoPZJ7GxIxk154wP/s8zvD9tnhfoL8siWt0hfik6zKfV8?=
 =?us-ascii?Q?TGjX9f79IzadzvyCGAQHk3Z+A4y8ct4f9FOZJbfadUkuQwaf1AA/p+sdN+XX?=
 =?us-ascii?Q?iTm0i4nisIJ3pxXp+wdBumk3lqyTDNfttryH5sETSlQ/C1blBTt0IsjJbGaw?=
 =?us-ascii?Q?bMy7tbvpzEife1mlxIfhScG2Ln5Rw3YsK9FsF8a5SKlH2jBeZ2+zORP97DZ7?=
 =?us-ascii?Q?ASJijpOB8f0hooI9rejhuPxpAIregn59tsFUXj/YuuZ8NEzFLN7nfExA8aMH?=
 =?us-ascii?Q?Utosv7c3Bl7/Mex+ZURnFMVqWlmMx1Rrvc5ZYrKthKimPg8YFZKIFkMA9N4/?=
 =?us-ascii?Q?vVEoIX8nFUQwJtCazhB6goFa8WxCLEZi3jsZKNvWGtoQDPl4bGH8WW9qe2cH?=
 =?us-ascii?Q?k+XCYfoeJeTTQXBneHvvp5BFQ92f3DxKIPYnBYwE6sj9+wyHCItpEqbGl3DR?=
 =?us-ascii?Q?a3Y3AjR5GJVLe8BiFoApMd9GM2v4jO3zabPFt8msqIWZvjSUI54i4D/SlOb9?=
 =?us-ascii?Q?/qZvOSw8xjN3WOZVCWFGgeAyE4k4RLwGtp6T8c2XEAVgaZl2qD7r11aWBtwj?=
 =?us-ascii?Q?3O9aWrArPbs0uWZNTMw2CE8OcmweO/D+odeqe1zGpMFOGMcZXqeccGHdMbaQ?=
 =?us-ascii?Q?PX5whvcY98IB8yC0NYmgII/nhilJw8BFrLH78B+X527T1t+G2Y0Uu9HFVMlT?=
 =?us-ascii?Q?eHx/6boIoCSKf17rRJZLQ6cqPgfizA3V6ZJepHqBGML90gtu+ptQA5QfD+wk?=
 =?us-ascii?Q?I4nNFoko92e3GGbPCrW3oXjZka6Xs0DPNyciNN6JrYM6XOVZyFtHpUODmqi+?=
 =?us-ascii?Q?i34gwUUFOA8rBOXWgIBkGRAd/b6Cy1k0r/oerY84opXvTmDDLlDwIXmNV7ys?=
 =?us-ascii?Q?redq7iPfyhW6Ygbw8WlnJ0430xlMSaTu8unKeF4fivuHgtASWoH706ga+78k?=
 =?us-ascii?Q?+zif2JCPYbZsSck0xZdMoeLmdlSgyWnI8jx+K2aVaHT4MQf1E9twr+0eAJUR?=
 =?us-ascii?Q?NIMzY9iE2aIBPuK1ox0iqxRAZIenmxwR+9pMifpr4UPsOWHe2AKYztHBHPTM?=
 =?us-ascii?Q?MyUA5oGsNR65jDe3kCyb6APbb2PIFKhrCDNuV/me5vm+CRfM80JXZXwBwmmv?=
 =?us-ascii?Q?gl/BzJOGvKOJOkphYXQNDKjutIrrrouO4XkLp+SFFWJCBY6kfuEUKTeJZN4D?=
 =?us-ascii?Q?mqJN0r0ku6Db7zNjnIviRioYSH+C1OIKGjRQajokEJk64noywIJ3RoFbE6mI?=
 =?us-ascii?Q?1xoSMmkX6IzoOuP/YdOvn/FfNHrNzUxyI9jcsdinpztPciZtX2zxenUsdz6y?=
 =?us-ascii?Q?b2dOuqFvEl6fPHCJALLDigOH5r5/h8s7b2BmsXrK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8f0acc-1212-454b-4a4b-08dc5fae5205
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:49:08.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uVBVIX4YqacLLhG+Um2MrPkhYkRwQ1jbtv4fqgK2zyd/OnkQxMnuCg3LYuVdtgD0ztaRH9JlUbwdlw2b+8+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640

On Thu, Apr 18, 2024 at 01:29:59PM +0530, Manivannan Sadhasivam wrote:
> Instead of using a local variable to cache the 'msix_capable' flag, use it
> directly to simplify the code.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 546d2a27955c..3de18a601e7b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -802,19 +802,15 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	size_t msix_table_size = 0;
>  	size_t test_reg_bar_size;
>  	size_t pba_size = 0;
> -	bool msix_capable;
>  	void *base;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	enum pci_barno bar;
> -	const struct pci_epc_features *epc_features;
> +	const struct pci_epc_features *epc_features = epf_test->epc_features;
>  	size_t test_reg_size;
>  
> -	epc_features = epf_test->epc_features;
> -
>  	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
>  
> -	msix_capable = epc_features->msix_capable;
> -	if (msix_capable) {
> +	if (epc_features->msix_capable) {
>  		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
>  		epf_test->msix_table_offset = test_reg_bar_size;
>  		/* Align to QWORD or 8 Bytes */
> 
> -- 
> 2.25.1
> 

