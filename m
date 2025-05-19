Return-Path: <linux-pci+bounces-28012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2BBABC898
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E2D3B2000
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 20:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C014F1F1319;
	Mon, 19 May 2025 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmPomp/U"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553C20E700
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687639; cv=fail; b=JVSkFWN80gPrzdiJzV48G0fynztMOP2a7eq69WMB8K/n0QILI0lkm6dEp1g7xmQRcWma8LmtkE64fJob9hmF6dZSq0Mg7nw67bMP5sXBk+o1Yj2OCVwahKUZVOJSYmrvTABi+6tUotMu1yaJkMS9fJpxM6MyaDvlQzAXWqvihCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687639; c=relaxed/simple;
	bh=CDNE+ZHkMMCpsNM6yS2V/EIM4WjMd++qGNx80NMU/Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aHoBa/AHq3D3R5oFO4cEKu7nOkic1asSpHGzFLMwbYNKwrMSZNzR0IHzVM65Oe5QEvRibilofy71VmyNHoPw2VUGVCOPLwAzFMlXVveO1vN2tjaue0gIXFByShzjN8QQSUc1SGnJuxgnwMLbhV2umxrZDxBTMU/wxnPQqJ2E+GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AmPomp/U; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKkAw7KXmJEMcGNLzD8u1Qm9ohx8dF1srEDbpGbUC82jWh3t6GbXbt3w6Q1BoXwgZKyMZua8gh3xFjsiZQDACuvwUjCMla1W1vUf0zX43+4RMhayrYF0kYtUyjXEWrzZ1FWhLJnlxK4jH5b35nBp/4SnSBtpRfPsxwBZ1opR09USxcEHG9zxQI4/bfMgHoY9uTxVOqkluPYcEfMZNW61Tlp0ebDCouDpxdP83WC0KnBa0+/BWFWnU4RVLGeAC1StYkEjyC86xqrXFZG2XLzyizmM2c2C1vph4Zaz312JP0X30yu4fYvpaYiD1Co/18dMBiskTcw/LsCQAu+Erjr63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPcx5eCVnfWk1JKOQ/WTX6xH8WBIj9tp97Tt5eEHxo0=;
 b=bZVYIq17Q0WJ9bzRBrAMAMe2K7CskzVszGeQfkioRoAC1aZNZF5CuZ6CgVHwkxLsQVw0C3P0dUXci5SrSwMhDfLmMPkeCOqK6hEOSjycjubfXIIT6nls4XXf2Dl7eqXItxnd3nW3Cav6iAeqd/KuU+3MF2PB2IPIrN3fVaoQ/z1+ndhxl50UbTKiniNYuNp2IXqOS6hNJeCtqfOkt/bSKkxEV0R9Vyvn92Wa/ZN/VtkELAs7Qfa8XuQUgtffecW/BUPZBUSBrOuFltcRcKAXFdnCvMzUNaNwFxYhR9cQgFDkJw3N75uneOdRqETmrufCf42GxAsOmH6AWibm3ljUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPcx5eCVnfWk1JKOQ/WTX6xH8WBIj9tp97Tt5eEHxo0=;
 b=AmPomp/UlgOFcL7kRJw2tN3rs48ASIgsyYVooMwB69SI+opb0mnW1zQofvkLiUOZRAjKbSxmpbIhY6AN2dmQ56lGENCx2e6u897dfD+vr8wJanQqBRh2kvRIitnZH3YbG/xu9ZSS60+ddxiE0y8yas7hQdMPCJxyTihuux2euKJutjZqX+FJJTjUwi2ClN0sTydrgJZ1oJ+SGGWE+m/A9FMY3SoFALyYJJtlpUc0tlgXZBf01rpdVwnpKMpox6CzGiEZQM6TFV8qvuhjJiakF/VEXxBzbUvHlzIjI6UHXr5ht7HPMp9DhIF77Nn53QRIFqWd8VUawmZg9gyXSv//gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10084.eurprd04.prod.outlook.com (2603:10a6:150:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 20:47:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 20:47:13 +0000
Date: Mon, 19 May 2025 16:47:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix errno typo
Message-ID: <aCuYyWsMVdFypcu6@lizhi-Precision-Tower-5810>
References: <20250506095138.482485-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506095138.482485-2-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10084:EE_
X-MS-Office365-Filtering-Correlation-Id: 025198eb-cf5f-4377-0357-08dd97165529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evc1M8iApGqEUsdacbzyHnSUbwYIgJIUtmaIUi8uPeoE9Id1Om8nFtOLDvyq?=
 =?us-ascii?Q?VkY02bfKaC6PBa0AwWjXHpiUI8T81mowjJvmwP+ouDJWV09YENh3a3nsciXE?=
 =?us-ascii?Q?Rpazx/gZY+MLFFlGc1Wf1dybhiaV71BVDibEVdpt02JN+5K4e6RaOj88Kzzv?=
 =?us-ascii?Q?/nKzhnrpapI2JUtzLrEDIxNECYrOTJMA/YFjiFxyzflqCi9h3x+6tMOUy2aQ?=
 =?us-ascii?Q?iQK/DFAUUEk31cE90deZMi3D/l0GKLywvGU+ftNyNVIVAgndbQ+Etpu7bJxI?=
 =?us-ascii?Q?Ugf+Bh/tUXcG5C8EcpEyoGlywlfhSMMfOiEc4xO7eIhcq4R+5Q5KSIY5eupP?=
 =?us-ascii?Q?BZ0YnPZHWe93BKd0sVFA83T9EO5YGRHzZQaee2T2gwLEixTBEWhL1I35V2gx?=
 =?us-ascii?Q?NsVU0zZ3bEAvZ/qBgPAgM6KNKPjgyrsgMK+BvdzZvCD4tU3XcPNDcsrzrtyv?=
 =?us-ascii?Q?wVAEL9BppeW0GKrk40p4JjBOR+BwPEw97VYU2+cOifulnhJPN82Sk1zDq7ud?=
 =?us-ascii?Q?9Xw7Hy1L2QeYb/osLzS9ozSIoRoesRalp0vjTcaCNajcF9KYMtgYaJmtcYZy?=
 =?us-ascii?Q?EGTkZmnByMEcSoBLcoAFoBe/QzjpTkgeaCFnFydJ8Vv1LNu3sQur84y9Ev2a?=
 =?us-ascii?Q?FQjfCanZQ/d2ImAe8M0qN7GqF2gP1fMls39PguunI1uf3T2I8Ro7NY0t+xlY?=
 =?us-ascii?Q?Ut+AmQVLX9L+o9LAZDZbmPHZQwiUrT6BZCmj1SEr9Vj7I4iLwDVwj68CBpOK?=
 =?us-ascii?Q?qHXPMmi1TEXVV+vy4GR9IE9cDQTUzeR9oYLzaNiZYxqIj0SpikwsEGDLkgmu?=
 =?us-ascii?Q?1cnhMeVtBPYA+yGQQqpp/+ykveny8is39u7hthOl1MsnjjnFy4QRr2PIo4Ea?=
 =?us-ascii?Q?WN2fSuaaOulAi7TxcvpMTaCTji/qfjxncdk4SOTvVv6eMTsxxUL4OVJmlR9g?=
 =?us-ascii?Q?R/xpyH2ecWhZ0zvIyqMFdyDgPMc8DqE7NSeyJ1yqkb+/g/wVXMEdD/LU5vCK?=
 =?us-ascii?Q?kkCmv3V/LGG+zGHNr0anvIM+1axYUhIdnMGHAOdGSqYCYK5KuIP8WJquVuzx?=
 =?us-ascii?Q?gUO/MQ+nZDTDtK3U4tOdsYzW4iV5D5iNb81UzPbJylnlpfEjlTs4+r9G/l0q?=
 =?us-ascii?Q?K45Ptc429kujSMB/sK7n81uX2hRGJvDLtJLE7MRKFkTWiVznGl718A7Q0+C6?=
 =?us-ascii?Q?uAbRHCBm2QCsIP3B+MQ5oJbjOy9g8+xcpM4Tk+dgYxRiQ3AsI4MZPMFHp99F?=
 =?us-ascii?Q?OAYk7BuQji9ZkX5r7sT8fYW4V9qUrYgVn5ufDpTOJVVygqdd3lCVs2w0x1Yh?=
 =?us-ascii?Q?+PZNlA6njs3NLd9JhwTLDZErglNo+vtBmrRuN5rXeHRAyG+HIxnTtCEEUoeN?=
 =?us-ascii?Q?kyV3kI9Y3E20nasYlM9tAPsZ7HS6V92rzwKzcnfA0qLqbzTEmp4hOLsh+NWm?=
 =?us-ascii?Q?a8ckn1aFYDL1slCRrLX3FooeAJ9Ema+qn/IwkAv1/WsNMWZUZA0BTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zZWGQNT5lK0HGsIPwPkgREsfk9Y4BB/hRMLTTtVn3iDiBEOBAdQP8zE5C7UZ?=
 =?us-ascii?Q?nmHj7x2PE3z++G9dhX8HurKEr48aTTinsxz7bZV02LZ6t8ohZEknbivn11VL?=
 =?us-ascii?Q?tg3ukAgtiPkjAgWgpMs5qIgmi7PxlnE9safUrUWIzOCw6vRYni03LRf64Bou?=
 =?us-ascii?Q?/SLroJcCZvInL6fk7/fs54wizZaXnVFzsBHFyFUPWftb2Xspkf2d/NnstL3i?=
 =?us-ascii?Q?PjCqmgRN5u2zGQWQ3XyNqlebMtQN5FRBearM8kUoGNGP4zmCRrDJrQUywWPc?=
 =?us-ascii?Q?y0EitWyhjNmO3OTFQzusNdGv/jpN6fMle9AgaCYxo3Ylmx+pAR2HFdFd5Gjw?=
 =?us-ascii?Q?rsx87PSiIqGQo8QLnsunaR/gpZaFn5nl21d5J9Ig6DZ0nY45JSccSrDLLuPr?=
 =?us-ascii?Q?wfIUTHJeJrrk+1XKUgxBHBgKEgoJEsCjPWvhfDXCIXqSl8/Wxr+wI47Ho9Q6?=
 =?us-ascii?Q?ez5ppGjKxMyDgph78yArpIp/bDIjv3ymhZmzEiRtrgXdF0bp6AUtrvplpKgT?=
 =?us-ascii?Q?LnJEQs+V8LDuEP++WneS6BwycxzHaMKZYtNehO8jC8kySQPBk3jaKDXFcIy3?=
 =?us-ascii?Q?6UTp9f0zm91HVb/8qs6+4RVrMoSQGivEdU4HdiORhEPTClsZBP/xrN9pH9mR?=
 =?us-ascii?Q?OTPAu3z0hq5FEyQ3KWvEB9BjLgaDQa/BFbPvpNu/H3hdH16KXyLSgjzuevo3?=
 =?us-ascii?Q?06vMbrinlZJE3+O40jRQL92+uCMRVGWkDgAz/s/vgUhuCQ7FpQJntUjwX1a5?=
 =?us-ascii?Q?Stw2nyrGjlJzv1UdUSFvAuir3exb7GhxYmd2IzBGT1yAnFp0yGf7G0ePOKLP?=
 =?us-ascii?Q?jtO0iqcQjcVyi+iiN7USa0j+QcFAizi7MxWwDNlzzs6Hq4t3YwT4H1ay6OdH?=
 =?us-ascii?Q?x2KlvNRIdlZvpre/7mXklHIqdnhBXVsI4XxmQv2SSBHz5ewQ/6n/2+FiYmqC?=
 =?us-ascii?Q?c7kaDk88ndMRrof6i/Yv4JzZwT6+MaQhDZ578kABnybCfnt4Ewj0d6pVF8By?=
 =?us-ascii?Q?auvKXjYPA3dQWHK22cDGFtcWR6Y5eUQRDNmL8vCVKYezi+Zw+psslyPmJNmD?=
 =?us-ascii?Q?9EXhBY6DWbWdKI2gwCkUtvJTfgtq7ww/4zNzUetvUuvFK0iN85XzLvBizVmW?=
 =?us-ascii?Q?2lY3PfsXeaDN15xzLzfJ/bmsGm02xaqVcQ1fHu9128Jmzo22TSKjNs7DkdIi?=
 =?us-ascii?Q?gpbxhJgTkQkZiLbtGMEcN/WhgVSV4vwwfCJFC52n1xJFjcjIMe4wH+alyMub?=
 =?us-ascii?Q?3M4o+Ors0Q4CgPdG0mZeAKzGV8W8t3mS5nIOzHLOucW4uVPfuVzqRXcZwgu4?=
 =?us-ascii?Q?3iYtPAoTrPUW0ozysMkJ59vERlgrl6CFgfUr7M/b6U4DF7uBmOP2d1fttqGP?=
 =?us-ascii?Q?qoS6o/Lpu3rNqlmMlQ83ncTQF0ix6HGEFNsCYpveNtdekm/FomPZfoqIzmul?=
 =?us-ascii?Q?HqzwSky1fylWcOdyoSy4yZ4Heeg08vSrVXo+opcZWMYrW9AbGEP2EfEu2E5d?=
 =?us-ascii?Q?cY0Ch+/t+NQ0HubcnSckubTa3yN1nPc7iDvOAUoNB3e0UBhJSzYjXeHHZk4Z?=
 =?us-ascii?Q?D6N0+aVIQgJzO2pATvY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025198eb-cf5f-4377-0357-08dd97165529
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:47:13.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Md7wi3K/4LySo7E8pOm6x3hREZU2HgxhXMfUsMfpTxuZXvgNS/GABNgxdOAerJhRfZ9iS7medzagGdWlahXTcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10084

On Tue, May 06, 2025 at 11:51:39AM +0200, Niklas Cassel wrote:
> Fix errno typo in kernel-doc comments.
>
> Fixes: 7cbebc86c72a ("PCI: dwc: ep: Add Kernel-doc comments for APIs")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1a0bf9341542..d12fa7c74bb1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -671,7 +671,7 @@ static const struct pci_epc_ops epc_ops = {
>   * @ep: DWC EP device
>   * @func_no: Function number of the endpoint
>   *
> - * Return: 0 if success, errono otherwise.
> + * Return: 0 if success, errno otherwise.
>   */
>  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
> @@ -690,7 +690,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
>   * @func_no: Function number of the endpoint
>   * @interrupt_num: Interrupt number to be raised
>   *
> - * Return: 0 if success, errono otherwise.
> + * Return: 0 if success, errno otherwise.
>   */
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num)
> --
> 2.49.0
>

