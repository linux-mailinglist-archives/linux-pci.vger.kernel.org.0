Return-Path: <linux-pci+bounces-17610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DBE9E2FC8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 00:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B785283221
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3B61DEFEA;
	Tue,  3 Dec 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PULc9OQA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3247E0E8;
	Tue,  3 Dec 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268262; cv=fail; b=PvyQlBaWDZ4ruIQ8KdpxlxDq7MxCUUJzjJzozCjlmPYB8yRC37g8bhhsccKranVK0gmI/i6iSoyV9V5f/Ce3tNQJR3a/wZnlJmRVSGaRVzDY1OaHSLNeOQWnICZdt4k+ghzc7RK4O7j0OZRCfG2bU1i+fKYNJYYt9vA1PFAsXLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268262; c=relaxed/simple;
	bh=mxXn85eytpibqGUn9CStShfcCvmTnO21LXhgAYs2Eg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=csE/Noyk6EODlXq9sCbEW3MAszTJieTsuyTsyX2ao9luDjF2LubtML9gtonrVCmhY6AqMsoQiHYS6FR5OZ8iKVNrtXs4fneRsfAzaG1IKJgrXXAEM0oOe6FZHiZrMcwWPOuLxiq/8a29JA50abupsc8Kn0xRps2HqXvWMv9AJ/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PULc9OQA; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctpfPVZDa4c03a0lA/9KB/zSgRUnnIFYjDRXx0DGxs5grDMsb3yTq+6n1I7nsg+ZtJ3XlHZuPECNmmhncSvk3pM/6/q/ThIJxrgiZM+Hn9GCLurlAYW729G7Wkz839U8ehIr8kLvV5jkqdoTw4re0aYmCTDVTxa0658xZOk7dJ9Q4d+50WRfRf6wM7iCNxEwDY5YJ0F/h0xDJMIBTvpttuuFbHzPh/5wSJSAX6m2gztEzP9whQoIol9VzrZHgwxEh9Am6TKGE2G3N46ja0UUjLniLWg+9xmfqYaAAAYGcfpEgVmJRcSLpT0y4iOMR6xvdZ2r4s6T7XYfPBIJkIRLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4njjPMy3j7GQPjh372rdNAlkF7vIzAV+8zK1Ivmn8A=;
 b=wwBNIPmHwgkl9OD0ujzvrn4b9cSnc4PZbWQIDpCnqhKA+yMN2+yhgEy3W0EyNUzMSr6bbrlyOtBsHGiPEOusHoWo0mlKJ5SOAImmNRoglm0WItHJ7EXgD2wEISJtxi9istbmsSxAbELZvLr/XuxGfZKyfiRSF+U1hvyEA8g6QbkY2C62w1CMtET712YuxN8w2zNvm/iOrmyAeg0+6h9Z6Z2A2RLnQNDz9Q5e/J4GW0cNpSBt5eOF72UAmoKkJHNIodVTqKVe1FNiGeXxCPZ3KvQoxEJm6qcg9H7M0Xf4do12qW90CALKtjMctVwF4NWlafaADMpYwB8U7NtmfJihuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4njjPMy3j7GQPjh372rdNAlkF7vIzAV+8zK1Ivmn8A=;
 b=PULc9OQABWNwAzuUG6mNNXefb5VlzMcbKHjvWiKiAiNM+CyKRnZE4AVJSJYuJHOOk3gKYQWNZ6k8jGxBPxeqs+Uajk4FE2P7sZTeZkpNjLLwneAFk6fBtIqIsNwuYOpE6bo9aZsgz3NpRwoosBOtvX7iKizyehO/O6F38xZ8ZEyRirPhfMCcYafeySaGCFVtcpJsjdSMOruNFmsaufAxhf89Qt8sHKRGGUEPzJ1+CMYMzyrR6Su3OyxWaZexfDrT32gs+bkLXQt8y3TR7VD6dl0K1f69PwTgt5kuewyr8UnnZeaNdZ7BXydB5idqHRFC3hsiFpKAUpsCru3cnnnYiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:24:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:24:14 +0000
Date: Tue, 3 Dec 2024 18:24:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	maz@kernel.org, jdmason@kudzu.us
Subject: Re: [PATCH v9 2/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <Z0+TFbH5uWgFq6xY@lizhi-Precision-Tower-5810>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
 <20241203-ep-msi-v9-2-a60dbc3f15dd@nxp.com>
 <87v7w0s9a8.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7w0s9a8.ffs@tglx>
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 631ddaa1-6710-4287-ef0b-08dd13f199b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PlNDh4wtUqTuy4cYDhoJ8SB4qgmM+glGJCMgDU6IKXCNb2uX5j7psOzIiN1n?=
 =?us-ascii?Q?FAisLfEnty3ntyvkHG94dUmi1ZRMOfgNRUuSSZXG4ZSmSYhyakMOQuq6b4aJ?=
 =?us-ascii?Q?yvOCGpYpwyHgv7SpJtwqJwp7UE+iGz/RZ6UQ8LVBWyThbCId2L65fCcfZHrk?=
 =?us-ascii?Q?+5G5Y6NoV+sCb3ElYsIJGNsNUfPI3EQ3k4nZj+aGo9kEfdQJ8fM6+fDFtHbE?=
 =?us-ascii?Q?2/IoWIdgqJrZ380FpfRRY5r5AewwsPzgvE8FXP0XHSXl3kjCS8sjSToIZsjK?=
 =?us-ascii?Q?ZzfwAtzcXCiIrM2zzrL4OoPyzNsAQOaTlGdCEyd5WHHHP6/hKdidT+5xx82x?=
 =?us-ascii?Q?U2pEzDKzSqsjmPRUnBhF8cc7mDXu5hU/Pl7l/Nb/aoOxvPU22bINiloaQ2Q2?=
 =?us-ascii?Q?GSiRpFevZ6DKfG52XO5QgzmI5RCxXrPBcCTtvEWg5fSzR4Z/VCHSpqj6dai2?=
 =?us-ascii?Q?vd2mcYhRRAYai3c6lSMQ0MHrGOifDIwsuwLU9OyokAzBUswCtrlXJ5JrQ4it?=
 =?us-ascii?Q?oIQvfdgkJAjwMkV5IuGYEZudrchJSc7UwU7LUpLTHj60WPRqpomAZXqoWG94?=
 =?us-ascii?Q?UOKzUKRBG9b5BIH7K5817QWoW6U3AVTA+cF+2xf/W889QxTXIPay7JZV+IOz?=
 =?us-ascii?Q?0yVsrIomuOsZ3rl6wYsEjrJOreRizWEu7wHk2eMCHps57HAU0CQC7ZxJZ1tW?=
 =?us-ascii?Q?YZiT5pBgQ/thiMUwp/U18LSof7309In5oiWE5uzRY3aeIxrLL1sgRk6cOjE7?=
 =?us-ascii?Q?/+fxWZpK13Lpx5GJMVqSaKQUNX0eX69U6+gSzJ/4a9zqYOa8dzzZFzLBz51J?=
 =?us-ascii?Q?vSKxFxtvjdMjPKGr+klY+5sPdbOaZnvyS5zTTuWaatuEZZX0i5rLPLxYJM5M?=
 =?us-ascii?Q?doeOaF+0utB8nVu+tyomgseWE2Jyyu0sL8Wd1xVZdh4jNEdAdgDk9FLaZaK6?=
 =?us-ascii?Q?ZzAwlykud115DiAPrY9sn+iwH5BXEx/ozCELnOUgb7Q4dVFXHa9iQ5v8U3DA?=
 =?us-ascii?Q?SdbH5K//PWsLV2UsuhQ9FZ1m3AtZ7KFs2qi7Bs9ZUvm+ZNABPVgJSb3d85nw?=
 =?us-ascii?Q?TqUGBt+t2sVQ0o0rMOVoN+6bh58uoCPKNQF53vRwh/NfViF+sgiVsTnFFTma?=
 =?us-ascii?Q?+1tgzAe4mx8MpwN6rDv4reB6rvCslXTWdpx6eCBa3IWNEyV76ZVdqJJWXzIT?=
 =?us-ascii?Q?bIbW0G8p6kgPYwbEDr68KtvY4nw06yAhsPLRLreNK3/1t3yUZeVSvXmCWZ3a?=
 =?us-ascii?Q?GGSPZIZ6ut+U+us0RiomdLiiHN54Jq2gglIaFoeAg+K/Nf5ohrGHbihkyGai?=
 =?us-ascii?Q?6inA/RUQ6haTozmQ3mGgrAGU21XefvkiVujOYuSKqZWWtSNA2Q/UUpCy6Lvz?=
 =?us-ascii?Q?Yr9F9krdRudWeNr7hyUvFkuRc1xGk1hosnEHKRFOACAZNSiqMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdEtZ9qobzQa8BBiylhj4Tlyos5nIHupm3ZT2YVWQr4bUKWRRoe8iB1Yhj42?=
 =?us-ascii?Q?IHsFjXGDTF8dQPtY2sA/arjSMOCs6Oj5kXtKv3VAg+K+pLoeNxKKvmQkq9+x?=
 =?us-ascii?Q?s7X+7bz6fpMnDvNcYTQeyNWxjxxI1Hx6tWS0N2TYifSl0nefAbU8FkEAcWAC?=
 =?us-ascii?Q?ldOF3WWa+KxL4wDk9dnwqn8qbg+6OQGPEXUBzzLx8wUBypxkGjIcJPTkQb8/?=
 =?us-ascii?Q?Ufm+jtZexBxm/psHVBgh3jwuWLiaYah9xxv49riHkrtHnisxpxNIGAlghNlg?=
 =?us-ascii?Q?b2rgbe8r4zcDqizAPetD6DGghzgbmfrjmcSAnEM/Tv004IjYgKXg1LbkwYN5?=
 =?us-ascii?Q?vB9GIobS858+IHLN3TV2xqXRPk4K62SOYWTAchrZYa/y0Jx2DhmAOyeB4Nyh?=
 =?us-ascii?Q?14CQ6DTD5uJbpIHFO5Ku6asi/kfn77q6HHehYNDfDvpFtJXLn7iMzBAjQ91z?=
 =?us-ascii?Q?zXa7qMJCdz6wC2FpRJzlSaa/Qaz0YqWT143YJLWpPTIAJ8/yxZiBIi8BWRMS?=
 =?us-ascii?Q?Uxpy4CEEdZQ+AWJ0c2Qyda+A+h1J64D2s7jQ1ApYrkecEJ2fxy5fySXiQUpF?=
 =?us-ascii?Q?iuSVyqTGeYTl9W6yNnNdM/Sx2iqcak9a8XICkA8pwhKfAcTKPDjB79PdIkfx?=
 =?us-ascii?Q?LkbFt1KdBPn6H87+WLTDV84WnEDyaKQ1dZ2K1jaMaJuTKzcwuuaDYftcqBQh?=
 =?us-ascii?Q?1Ht5gtjGSEmwm1OosibN4L+hbfE5vJAdB8k3YMH/IJg8NkiHPMJX2pcNwNxZ?=
 =?us-ascii?Q?F4mmanex3q3VVVCTZxbJtW8h3koduqowP+wKjkubbbsYAWhy2tD36dGiz6OC?=
 =?us-ascii?Q?Eov7ECCdxK/lAsoLYo2YM3Xfz4K0Md2UjeP7RvVO0HK5vf0pebasmFto4kIa?=
 =?us-ascii?Q?NhWGDM7bR48ouI1GY12rmCqG3iv8wLc75m+nSNRmj5GEJ0df9+KrkR3udhPy?=
 =?us-ascii?Q?9XuSnIwIe+/fi4BAvHwEgaLY2ZQ3+R9MParO5cYnZFi+b4e79MkJniqFguHS?=
 =?us-ascii?Q?JX+KNwBDceNecHaDcYvLmWdBuQ4CiIxfaiabqUcYSr96uIOmvDWCZDRuB+ys?=
 =?us-ascii?Q?Hk58A3XIX01c3113mLbTxuhODYhtBid4DINwDm0A0IbRn4JBLV+7ZKS7oVg7?=
 =?us-ascii?Q?1Yoh1HKmJDquGKv6CussxLqrJGu7IXX7q6znYyTflTACOk6fy8R0catyIdzG?=
 =?us-ascii?Q?P+066aDOJToHbiuEudTZ0YUGGZZjvi7Iv9XV41IqxQG0znQ3YDIGxXLAdaAZ?=
 =?us-ascii?Q?qpeuImqfT40hUGZ7ss7JaBWukwJ45QvlnC3jWCUWEq/NJy22bAyAEEpbLxZ+?=
 =?us-ascii?Q?X3qfILbfHo5cIbJw1iqCzWEmXynMsXGAKeii1BJeYlhYwTexrCFHMpQ7L7Co?=
 =?us-ascii?Q?/r4D/OpF+HPnq1x5NON3cyGB2qDxHozaI6LskPuupc46NtX9rbleOn3ntOfE?=
 =?us-ascii?Q?HWar0y0StehHjZuYiX3RbfzfY/mAsHQQOPOG4FosqP9GkEzNtDU01q1LgTdY?=
 =?us-ascii?Q?f36QOULQfePDQGQ+2OFsIPZF2pqPDWquHpeuEa3ppKruL6ANVyTgFWD3DatX?=
 =?us-ascii?Q?CwFnrREsBW6qNj/+jcikHxiPKOBhu+cqJoTeKkWz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631ddaa1-6710-4287-ef0b-08dd13f199b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:24:14.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cc6NqcvwQ8VlpyLTj1pWSDiDeVQO4RHBN6UWqyL+da+Cq3jNj7SJG+utIrVJPF5m1bVreD2n3rGzWRDfohwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846

On Tue, Dec 03, 2024 at 11:15:27PM +0100, Thomas Gleixner wrote:
> On Tue, Dec 03 2024 at 15:36, Frank Li wrote:
> > +static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > +{
> > +	struct pci_epc *epc;
> > +	struct pci_epf *epf;
> > +
> > +	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
> > +	if (!epc)
>
> This is wrong as pci_epc_get() never returns NULL on failure. It returns
> an error pointer.
>
> > +		return;
> > +
> > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
>
> How can the list be empty?

It already checked at pci_epc_alloc_doorbell(), which should be never
empty when this function called.

>
> > +	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
> > +		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
>
> So now the message is copied out into that db_msg array which is
> somewhere in the memory which was allocated on the EP side.
>
> How is the host side supposed to know about the change of the message?
>
> This only works reliably if:
>
>   1) the message address/data pair is immutable once it is set up and
>      subsequent affinity changes are not affecting it
>
>   2) The ordering on the EP driver is:
>
>      request_irq()
>      publish_msg_to_host()
>      tell_host_that_message_is_ready()
>
> #2 is a documentation problem, but #1 needs some thought.
>
> It only works for MSI parent domains which use a translation table and
> affinity changes only happen at the translation table level, which means
> the address/data pair is unaffected.
>
> Sure GIC-ITS, AMD/Intel remap domains work that way, but what happens if
> the underlying MSI parent domain actually changes the message
> (address/data pair) during an affinity change?
>
> These domains expect that the message is known to the other side at the
> time when irq_set_affinity() returns. In case of regular PCI/MSI this is
> not a problem because the message is written to the device before the
> function returns, but in this EP case nothing guarantees that the
> modified message is host visible at that point.

If irq_set_affinity() can change address/data pair, how to avoid below
raise condition:
	1. device send out write data to address, but write command still
in bus fabric or some internal command FIFO, not reach MSI controller yet.
	2. irq_set_affinity() change address/data pair.

1 and 2 is totally async. if 2 affect firstly, 1 maybe missed.

>
> The fact that a MSI parent domain supports DOMAIN_BUS_DEVICE_MSI does
> not guarantee that the parent is translation table based.
>
> As this is intended to be a generic library for all sorts of EP
> implementations, there needs to be
>
>   - either a mechanism to prevent the initialization if the underlying
>     MSI parent domain does not provide immutable messages

How to know such information?

>
>   - or support for endpoint specific msi_write_msg() implementations

Even provide specific msi_write_msg(), write to address/data to shared
memory.

host driver:
1. read address/data from shared memory
2. write data to address.

1 and 2 is not atomic. So it can't avoid above raise conditon.

Frank

>
> Thanks,
>
>         tglx
>

