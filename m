Return-Path: <linux-pci+bounces-6675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C88B28EA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 21:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187C1283CA4
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55914EC6D;
	Thu, 25 Apr 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1IyiVgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981152135A;
	Thu, 25 Apr 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072628; cv=fail; b=HWnI6GFs04k6rBZO0TjFPSdw1kcnIl/3BkFE4VzHW2D7dcABLRC6f5ySTfPg0iOfrQ+lAMPXi3N2WMZbN+DQc5+gHvkGFPRzHfWnsjhjpvwwuE4Apr2+B8XHiaQhdaI8z0opSGI8Jig0XaRRzBr8psdf6+Ra8tcTuhbpVEBcz9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072628; c=relaxed/simple;
	bh=QpmUBmmGOxqOw5CqTh0eqLj7NaGFPVH4ZlgLh1HWMyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tnaGTav1rllnHxagmbvmDWWeDaSKPhnSonuy+hLrAThPJwSHBWAhBDa58G/sr2qjFaqFo42v6kkzIY/YJxd6LrI4w0EmR/L8xJi2AmmDomq3zNMacTBMD+3v1IB2CJ82VIJoAh3gXzakAYUbNPHqBAaIgSR+gCtSuTDhx2pzsco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A1IyiVgR; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2qyWU4Kx+i1yu72SiQuZ4/jpbohCVlT7IjVrnHI2/SjSPFpkFWePMxookKHomJCpVppjzqReV+eLzZVnQJOirYAowMfLLNRBIwYiTZX5O5+Fj/gmVcaBtugnbho712KUhWI201/fnYQ/+6qFMNmplW5+dE+0fj6uIG8uuVUkrcyIcnsWNVBI1pkOt5gcFWvXO5DkNt7tLKStYgH7r+2M9Tso50x6mQr6XGFpdcSV0SaFN8LJgEIL4PkYDbrAt3+SigVkJoZX/cNvTyd1phoyXoLpHM+U16tjcU0V2UoqiFLxJwlazKPkyM3AyDAKSE5TqJRa/RInCPT7BX0vtdKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zygh8rTAtyEej1NzheUKejvVC7z1W/Vpvhydk4Qpb4=;
 b=HJzfFWFyq81E8SotLLMyxY2X+XLzqkKizx5UUXmqSgqv/J479ZYnZF4qVOAVUi4H44mP8iB/9few6J+BC6CXr8UPTaySubDuDEAFXZaGCLma2LRBswD+luowKOge8ACHOw5h6JZ9uQcr53G+5w6LT5t6sdMEC8Yslksohfe0QhBCjLVARsk0nI9Lg88uVxm8NXfLfl9fUbZ0TphXMfhXm1UNZmz6YINL4/5hYDpaPQBpOihK/W1B7wy8DrDsqzfdS1PCibUGAlV48LM40mmPMbD6Vdgp3PYy5yk6CvZgi7kHvhK43qGFMETm1rA5ktfPfv0iOB69RwlIY6jUvsr8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zygh8rTAtyEej1NzheUKejvVC7z1W/Vpvhydk4Qpb4=;
 b=A1IyiVgRl5vwXvRirGZzIz5k43VXeHnSqrN+bMve5oylL+/uvQJNAPY1I0r2S1VePMeJOTQe84RUbg6Hz3r4BxrZeJHg3VjQm8s/FhE3Q69eQocol41u4eapjVfquW4UaBLzeZsOCs1nRif7Uqncu26dEBrmNHUBNirR7B2aw8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 19:17:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 19:17:03 +0000
Date: Thu, 25 Apr 2024 15:16:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 10/12] misc: pci_endpoint_test: Add support for rockchip
 rk3588
Message-ID: <ZiqsJZh5SV6q33Fz@lizhi-Precision-Tower-5810>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
 <20240424-rockchip-pcie-ep-v1-v1-10-b1a02ddad650@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-10-b1a02ddad650@kernel.org>
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b136651-ce48-43cb-b727-08dc655c4a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/6mPRHmqT9NO+D/9nYEGzf1JQqB47a+wu3i3uZRiv4Y8LLElIlktWVfPla6a?=
 =?us-ascii?Q?wFjImKZHgdKjCGrIt3/EXZPw84/HQs3f4cT0XjCGQuclLMOnC6ZBIplOCwRN?=
 =?us-ascii?Q?B8GfgsvYxxrO42/NB5P15zOeBBWX8KYEv7a8/c3Fkn8RhAIk8GXpAyw6DBk6?=
 =?us-ascii?Q?pWu0mhIkiR0Lq5x7eME7/LLFizt0TEvkvR+DlHc8D6mdw0uawsTSPZrZZkup?=
 =?us-ascii?Q?ZD9F8vCzIAjwqF7W5KsgG7nNR94vSFY/MfhKFjCQrb3CKs7S7PT55zZFsdCL?=
 =?us-ascii?Q?nE26RTGbe5uFktLZ3Ldfs+Nef6gA7CciAmM5LWEjCVDPeRoG1H2DF3Ons09A?=
 =?us-ascii?Q?5p6P1JSqtwlAvSz21TQbV2Oc7GJ6X/0w6HLg6rpHqmj7kDadOuND7jU4vfkd?=
 =?us-ascii?Q?DswOEmP+eYs2ZFT8pJzIhWzOR+PciMmtFQRfsPjUMnVVOQi5YLloAih6mBjF?=
 =?us-ascii?Q?cX32yJDLdqtFWUgpXXvzQVUg+55usg1jM6KDP8yv0L3gezuismtauWRwta+N?=
 =?us-ascii?Q?97DY0WxQBWLF4enH21+6JSOVHAvDXY7aOG9XAMnc0GYi/d0330vChBuxNxwR?=
 =?us-ascii?Q?BycVxLEEOW6AdYk3n0OqUZM1EzltYtSAHWYWDqjn6ZohK8bQ04+J4SKye1eC?=
 =?us-ascii?Q?ZNQb2YSbViyfJNHL/A4+Vl2zsdkJSQdbcHjTvP+xpMcN1H7034Gnj2+eksWa?=
 =?us-ascii?Q?8SbhQVQCFribyjIf+Laoz6Xf9T8TXcYe9VqPDlZszr0dh7dA+BFpGSviTz1B?=
 =?us-ascii?Q?SPysu6QYjogmCJ8ykyqjBMY/3xBz2Bd7YDJaGii4gb4AppOEDrjGrV+1GoM3?=
 =?us-ascii?Q?/RYdghoPGuP1DQyjI0oh6QNA0lfWj9q+ygJWdZptSfcHaQtXAZaotAMrfOn7?=
 =?us-ascii?Q?SI4XrWeBaw3MUaQkM6woYJyw0PpxQFJY8pfDreKvP74hj65JjsiGkp3pPaUE?=
 =?us-ascii?Q?Eeeqr9aKg07Tl8ImEoYR2wpb7br6AS6FSwkQzfNhdt/tfEWN31DRckJBLv1Q?=
 =?us-ascii?Q?5tqzGBzCUw6shTDAiozwHfEvPpWoBpgBY9MbJ+XbZ6cFbG/HWjcFOqV0OpoE?=
 =?us-ascii?Q?/TD8b1IOc61cBGABfhEmtglKiGPGY9BO3hJ3YgKWI37wEh1XyU6kuJGiaY/R?=
 =?us-ascii?Q?419NIkVvLDnVfbvYT5nFGMAxGXrdHzJqbokR7jhop5szvXXDAtYYIoHja9zq?=
 =?us-ascii?Q?F0sw4SJ62VYAbQ3aLhnXtgvmfIJyYI7WQ52FA9j+XBlORoIyxw+HxIECFK/M?=
 =?us-ascii?Q?X0OS+33NVXD8eZRRM8GyKfuHeN3v3nh3QNlYWvyAY2YK7RmzBPvzR3ATo+++?=
 =?us-ascii?Q?6dNg9sKyIF8W0i1Uat7lo7gZACkQiaQjnu8ExFWMf7kXTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z2xU8Ongyf+TB7c6oLUr9zHlMfEuGMTC0OBMIe/09lcEXI/51M+XynRg+B0V?=
 =?us-ascii?Q?PBi7PCvo7V/ecnyjlnsQzPfNm9Kpm/ECczd/L/Te7H4AXH8Geu9Fqy+ZHJ/F?=
 =?us-ascii?Q?wUo3QgqrugBn+IcpjAA0qNofKMiPJgKHuJh3fTKApxC2dFAbBbcpKTJyP6tP?=
 =?us-ascii?Q?ZerBIrRTmQny32seZ+2yAsBGQx5GsqymF30vVoyZ+RzABbL0UPXNrA4eGrfY?=
 =?us-ascii?Q?J5P7h+N3Gs6/sRYZGZlYS166n0loMPDPHVSwKJNZ+t68PlSdpZn4TD03/i8B?=
 =?us-ascii?Q?FBGopO04D95Xe55zsJ6KvwPfJhDsMXGKo/o1qMjIdip+7E4/VRw+qu+bKsFZ?=
 =?us-ascii?Q?bJIbW9ZGpKwvywgBsnNwXGUcHvmhe5KqH+45+e0OeTwevjXiLfVD9rkLstjF?=
 =?us-ascii?Q?OLotoMt431VQYMWDrevip5Kp/zlfyxw4ZGrUhbKMbwcYGPF4Js2D+xuShiG6?=
 =?us-ascii?Q?JHDvietfvk/0nqSo5vKf0Tl+UEb88NPKDiBHjuGjE+n3JzgPUdcjGuFZpEbs?=
 =?us-ascii?Q?TPLFJL6+vrx37luYXXbsCi8q5x0K7D9AHwlUyag9DmkTznkl4WMdEGXjbwCX?=
 =?us-ascii?Q?sDVVSXxUM29IU0MyaiT7mvJtthBEeKg4G7Uy3CzdJnXv2wvbwNulxT+gCMyg?=
 =?us-ascii?Q?jXDUaw+Pe79E01TVTaSkyb7smRzziBr1o69mx6hJLzoyzUAFCHFfTKRNoW7Q?=
 =?us-ascii?Q?8dcBmfQcm0ZtaiphGXAmF20esQ88mCJoCXE22ypvGw+IXcAwcP/sZUJPcvMK?=
 =?us-ascii?Q?DROhRJPGxXnpIotnFl1w2vOqWMqOUUm300s9iPyZg58x6pBeYgZvuctRNIi1?=
 =?us-ascii?Q?WEgi9LcD0n6j7kbvOWkCk+6xY3CGg9Z1FjotLEMVxmOz73OaLneSN/05vMQP?=
 =?us-ascii?Q?L8ByfGcupY1y7/AQUc/LVXmaxp56M5vHFczgGT67pWJk59ywm1akFVyWxo9G?=
 =?us-ascii?Q?DIA06rShSeqFMWlj5iaZ44pyBP8k0MdtD2vlq8LXzX6natDjDXSGJ+PZRBTO?=
 =?us-ascii?Q?AJbYutj4OdffMjZBpXq8BFC9E3RYUA7yZsEor/B8AB7tYJpbbkWIZ511CdDU?=
 =?us-ascii?Q?Wzs8cs1UbMjH07iSw/f1dN5glwkiesz5kIynaNh44U8YQ1f4D1yT2vAThGDe?=
 =?us-ascii?Q?jsXNkbP6Jm3FPswibrmm7hcORECII6c3GqWdJg1UT/bRaghM5f1SF9oGNmly?=
 =?us-ascii?Q?akqyY41Tt5TkzMg5D8/zayAbbJYrRVBiGUpJFTCSBR4eZb9EHl7yHr8BZ1ko?=
 =?us-ascii?Q?ralxp5sdUaAMRbwZAdBARipGrmiJmbG0MEKr75httuC0kfn1OikthUICg41b?=
 =?us-ascii?Q?6vmPxqp/lRV/j4ZdqucY2dkaq8ftVfmxssC1ZGEETsVXIsTRDQ8jA8RqcdNc?=
 =?us-ascii?Q?OQO55FaFIsq7Acd/HqMFREJpx09WxLsuYWgqprblhaG5XcBOiGmzFRHPeAIo?=
 =?us-ascii?Q?Z0ChoY90tXy78ABMWPFgzioMxAvXPk4R8EyCz8BvOEx28zLEDPD2HTDmHS+6?=
 =?us-ascii?Q?WzZwuIsglfMrZn5b7SsGiZ6yACLd/8xELa+IluU5ejcfEnDhXDvTpmDe0rbK?=
 =?us-ascii?Q?BdVTIb9qG40iJLlyf59f5yTw7kuO+RZB26jjRP4p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b136651-ce48-43cb-b727-08dc655c4a07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:17:03.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHzLcomHtvRpD3HaeqQWTchmq5c6bfXsNNT4mrxQnbHmOdYAPea8i08V9Yu/fuVJrZWmYPOEro0qcbpxLCVe3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965

On Wed, Apr 24, 2024 at 05:16:28PM +0200, Niklas Cassel wrote:
> Rockchip rk3588 requires 64k alignment.
> While there is an existing device_id:vendor_id in the driver with 64k
> alignment, that device_id:vendor_id is am654, which uses BAR2 instead of
> BAR0 as the test_reg_bar, and also has special is_am654_pci_dev() checks
> in the driver to disallow BAR0. In order to allow testing all BARs, add a
> new rk3588 entry in the driver.
> 
> We intentionally do not add the vendor id to pci_ids.h, since the policy
> for that file is that the vendor id has to be used by multiple drivers.
> 
> Hopefully, this new entry will be short-lived, as there is a series on the
> mailing list which intends to move the address alignment restrictions from
> this driver to the endpoint side.
> 
> Add a new entry for rk3588 in order to allow us to test all BARs.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index c38a6083f0a7..a7f593b4e3b3 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -84,6 +84,9 @@
>  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
>  #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
>  
> +#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
> +#define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
> +

Did you make sure 0x3588 will not used by other production with vendor id
0x1d87?

Frank

>  static DEFINE_IDA(pci_endpoint_test_ida);
>  
>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
> @@ -980,6 +983,11 @@ static const struct pci_endpoint_test_data j721e_data = {
>  	.irq_type = IRQ_TYPE_MSI,
>  };
>  
> +static const struct pci_endpoint_test_data rk3588_data = {
> +	.alignment = SZ_64K,
> +	.irq_type = IRQ_TYPE_MSI,
> +};
> +
>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
>  	  .driver_data = (kernel_ulong_t)&default_data,
> @@ -1017,6 +1025,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721S2),
>  	  .driver_data = (kernel_ulong_t)&j721e_data,
>  	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
> +	  .driver_data = (kernel_ulong_t)&rk3588_data,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> 
> -- 
> 2.44.0
> 

