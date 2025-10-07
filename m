Return-Path: <linux-pci+bounces-37674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388DABC1DF6
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3B919A0799
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686E8BEC;
	Tue,  7 Oct 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lxdS8zPR"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE42D8363;
	Tue,  7 Oct 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849893; cv=fail; b=mahOyu4eBj7y9RoiBnnIOT6FI0U0rvmaAxD4wqS6kBZyXtxkmNaUV2WpywArn1hWF1djPyjIt4Cfy048Oara9eY0LW7E41l4wJufVYYYz/XT07HRvg+qjigg0bYU8nnyT3Gy3apWNT8SLQtFFT1SUDb4Jo7bi+7WLuzNwdWHjU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849893; c=relaxed/simple;
	bh=iTc23luWUXkaaGWRbGrNB54S/u7tBMLYg+VIptku+bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rAI00+F7uCYJgN1ITt4ZXUYjSwkzF2Hw4GD7FlLnsXMNZenCEEpBxBHg+BcYbRLEfot1UM4+cTCCl/DZX+9HebMi8g6BUd9pYbkRGK0nYrXfPUj26Yy+bNF+xrhxsWIZSxLAIvl0g840vLSB4eveLCGbqlQHxF/VHuOYeUFkldY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lxdS8zPR; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+NIC5DCxlqPslpCojADamlc1gnOmslSEFPlgdeDd8bUyzSL05p0/LoiWB5EJjlB45kRpBbieg3YC22JKTY2GiSBoVjft1NjGQ2y5B7n5dZOdielWFdZcgVqspDWw7vtx2c3fO7LbIQ5+CpbiM7++DZ0mvPwke5NiOhR4wSnideEi2Xf0WOSWm7kTBEqh67a6++3B0WKdkOvYBvGtkoLIBRzK9wfcuUV972LWY1pGcY7DuJTMveR3VgP633j+F6E6AQnu8/iQjnM72jMAPQE3ykWmnvBwAWk45PRBOUJsKFp+471HnNW0sBeM8ZS2H2EEq/vYNzXom87rcKNmYLlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/cBvaEjyH8vxuj6qVo4HYwdzm6XJqiaq+bgMoLP0OQ=;
 b=QeSFdXDRvMwZHMtUI+8X+sHJCV/HduuAStTWIKzMSxgBzbpC3dye9Fjgx6LtOouiXOxfJZEsHLTkIESHqonK53YbWr62dM8dtYyVOAnEAYS+ZUFTp5JxHgMPUnM90VNxybuiMhslhaKbVDIQd/sLvfKNHIBi36PTFImhWI72uUSdBDViZp25kz2yL+7inUMFzLfMXyLyiYYeY6Z8+STjH4CfXuo0I7d4GL9fb/dVi39TmLaSFCt0fAj2qQLZBVFuLlFBzMs58nC1Hvz5m4DGNRyaiEbpCof7Hzh8aK3OdlzvYgttIAoX83yW766QdWELFhgZcwDLDkP8podhEifEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/cBvaEjyH8vxuj6qVo4HYwdzm6XJqiaq+bgMoLP0OQ=;
 b=lxdS8zPRtIngO02guikjJnjR40VpzlBgXSeCokOL7VuM8TDQN/hfDwjhYXh3uOvQY1QPm+lzq1xNff4mNbicXZvyq+cYu4XfUWrWjbI3CwGlTvng2XMlwnV+UVNm68MyZiUwnHN/ScWV+VtpakahQ20UsQxLB/ltJrqdY60DOA94ICQ4uTW4WDJlfCDxkulsKdaqE66SS8MisxZc5SoReAkpsvyxbD8jYI+V3WCA8MBG79alM2KK8tU6r3chW2UErVca7N77Ez86Pn8mL8lHHJdeCIqYakfdU1jiNQ1tCXM44jelZyTdwJ9ERbwNXfDPIM9f75VaFXoDLOT76dZPaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10082.eurprd04.prod.outlook.com (2603:10a6:150:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:11:27 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 15:11:27 +0000
Date: Tue, 7 Oct 2025 11:11:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [External] : [PATCH v4 2/3] PCI: endpoint: Add API
 pci_epf_assign_bar_space()
Message-ID: <aOUtlUIcHE8JIO4j@lizhi-Precision-Tower-5810>
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
 <20250930-vntb_msi_doorbell-v4-2-ea2c94c6ff2e@nxp.com>
 <c9efa64c-20d7-4aa6-815e-2be040480ff9@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9efa64c-20d7-4aa6-815e-2be040480ff9@oracle.com>
X-ClientProxiedBy: PH3PEPF00004099.namprd05.prod.outlook.com
 (2603:10b6:518:1::45) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10082:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a4cfa1-8a56-470a-5b20-08de05b3c98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fwRQMAv9p3b8aUzqEJSh41RpDdPdS5wMYgHNwU6Q0fc2uSCMZbjU1tDWNr1d?=
 =?us-ascii?Q?6IZg/niSJgd+OuUAoWxZ7lm1WobSyoO8fKp9i45II4GlAHyYo3ybkyMUnHnB?=
 =?us-ascii?Q?ARr/DgGZRvuX+IRQq3DY+b3Cc8P3NFgdVyRx1h12OIAzqc9trz0FOP+/tsR6?=
 =?us-ascii?Q?xwj4FOm+1MNvgyWPmrVtNtLR8g4JTvefEKjxKnVrjdckINWdEfQo0QohhAh2?=
 =?us-ascii?Q?2uNC18aLqg7bBAZETqhIhTWHQt4MvhKfRFHnDBj3Y/PEYs2yGEUUCiqKxZII?=
 =?us-ascii?Q?gCA3Qmsiv9LSwAs5Xhphafs+dStnb0LYr4WobWeBBK+DRylveqqkgDiLz4Ur?=
 =?us-ascii?Q?4bP/XmyEc4iVRtkA5mBs4EvQJ57TVhfwDKhsRty2WBZtS1vU9R/yn2TQCE9V?=
 =?us-ascii?Q?0sQB2GaaEWYqiICt+/MSnu55hYG89NbKRj7AztMfddrlyMxSY2Y12FANX9eO?=
 =?us-ascii?Q?U4Oz32ghY8tW9uHOexZ2zyGEFELUp+9wetRrmiqocuw3hEVXMhY3ccbqg4o9?=
 =?us-ascii?Q?9eM5WjBDaVW4jKF7122Xa2lKnRV8xNRUt6zn4uaCj7CtMEGkfh5lgpZF82hY?=
 =?us-ascii?Q?3dH9zYhCCFv+g5UVVO3RH8WtXZXsHJflnWgl1EFCd197N4B7jEsB0kzNa6or?=
 =?us-ascii?Q?UUbsAKj1Lp2lqhUBzlbKXn5ldW6QLYsAlzRCtOl5eouB5h1u3x2SLEho4gLy?=
 =?us-ascii?Q?A7YLTUS00zoUfof8yEmYX45Z2hUEprA+LmTp6y5cOa/6jpPaDgaxbeKfZXTW?=
 =?us-ascii?Q?Jjtg6KJa8qDP4HzsuSGpS9AP//wBeHH2H8ilYjUJf0rHYCfXp5V5fTe5aBHR?=
 =?us-ascii?Q?W2NxDSXsZCLc+6u+dC4Ni4r97Q33Sxsmt+dLWBpTJ3t/AgOKR4zuRdYgcitZ?=
 =?us-ascii?Q?+1D+Ay8R0QhLRSH5o5Im2T4zglV2oXWfG8MTFjD91Lszq7WEoK9GJUCeefF8?=
 =?us-ascii?Q?WbqKBeDDddaL3i1emsRPu/wfhiyclKOKH3Uq3AkrH9CZhZO9sKaPHVqKkdW9?=
 =?us-ascii?Q?wyGG44XiF5Wc1KEMoodx3HDwNFalj7qColztp6h7kUN+S4UO5YRUf62GYPJo?=
 =?us-ascii?Q?omfkYhvRc/oHfI2iBoVLEAcabcO8NaVBnApcY0Mn3RU03KqgcecfvtDAGQGZ?=
 =?us-ascii?Q?CNK0J9FLE17r9YBpm52VCAAqVd+IE+oonLaBZG1CjJnlvA8Jiie0jDcyv+an?=
 =?us-ascii?Q?nY7cqPugPHmN720H8baJ+9xw3o0iRJ1T2oVdYsET+GjUppbAySGjTYr/TJ6v?=
 =?us-ascii?Q?8BhlwMWkvRqiFYS4pRNGhTjcmi8ncAL30AYPARYNvPtZyRyaRxLhl6x8xhJ6?=
 =?us-ascii?Q?NVTSh51KAEZwYJARrp4ZOVXNVeH8HOYpeYrav0UqqknyJr0VwMz33YdCmsX3?=
 =?us-ascii?Q?2LvvXnNIrHJew0BiPMr3kf+FO34by0k8euFTnANzxB6u+/dx+2NjenhmW2Wp?=
 =?us-ascii?Q?I2j+lsK5nrTcEWNm4mKDD/YvFwODLk/YktBGKID69jXXkcEQrQ9VrV9fJGi5?=
 =?us-ascii?Q?mRVf1UFq7q+piK44vMAPUDehIqJO+KdQmi0q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hnHQFRtTX59uKoB695Bb9IYRwwxHH47tt5bGvp78fu5So27rEoYTGwyytDk3?=
 =?us-ascii?Q?NMRKauqmugfBWGvEn13DNTs4yMGeH41cAZWwDMrZp03HouUNhXl8JswRZBVO?=
 =?us-ascii?Q?sjQz68kQsKoG8zPuzdV74HfxbRz+omPN8ZOFOU+rxEtGYibZ3HKyelxWpMRl?=
 =?us-ascii?Q?eB0ADdSLA+DMFEc/ZeSxs8IuSJC4qzFwG+0dswAjd6MdZ9JHMrfyqwkH0/KM?=
 =?us-ascii?Q?ugtJUbLLd+LQKXRItUIRQ3Kfj2CkgHct5P47VcVORLo4J/pUBZhf1b/51IRW?=
 =?us-ascii?Q?Crw7Khwy5mefNTascHJXnZ72uSwxXuvSwJrB9vWLWfzvul6R7nroE+8u075B?=
 =?us-ascii?Q?IEqmNUn3ekWoapsgWL5TNM2kAIj2mwQj07U5lM7gofve0VWn8Um7WjQAjUq7?=
 =?us-ascii?Q?xJzadoD/bX7qY1AFQ5bB+Ae3CJIMAFtka6Jpfd8oQDphGSq0EU5qv1rtvLVw?=
 =?us-ascii?Q?TPQWbFcZc0DVgavW6XTSEmyfbdbl1KtcZP7oREsl9LdbJ2XoqDHnK/S1NPf3?=
 =?us-ascii?Q?o24dywKqetoYxOUhBt22qvvVS9hT7ZdDHZkLsmWiAFwEBfDlOED4jFUXrhmK?=
 =?us-ascii?Q?dePnWFTdQyKs3obWiFBAfL1mvB1xJB/lvP5Y8AdVA8UG4QdvEreIzdgaZkAE?=
 =?us-ascii?Q?VPVknrliDgfkAdah7icGdZLPf9mqLwn9j17uHpkU2Mkyeb7VpsObrSZSLq9d?=
 =?us-ascii?Q?Eb7tEWHWheCG7sxx/k67ZxJmoat48/cWKzQ5CcHX/gWjeghv7ssz1swaNdBe?=
 =?us-ascii?Q?msWX4RJAW2BmQKTuazcKgneqePRGXGn2K1NZR5pCfZQCNluDkv7IV/pWzfBq?=
 =?us-ascii?Q?7scT75OsGRNtNvqzNTsymzzvd0cVmsmue63fbCQJ6KQyed1PxdMYWJ+xfpqD?=
 =?us-ascii?Q?H1XXPVn1fMaj3AzgJMiH4r68pvmwoiFptIpOmaOmgUV28AGce5ExNnIgjE9d?=
 =?us-ascii?Q?pUHb6HutLU88mu9Ahqj5ZN/GYWJEfvTeU1+1LpH6e9D5+GyzRU3CVgQZym8r?=
 =?us-ascii?Q?S5zORJpr6NxWgJvGFHxaBLSZpCL6/CBGXOE0/2zYD48jmnGKVWrCtbmmgyNv?=
 =?us-ascii?Q?Egnivnlud4S5CHWDrTczf82ErGG9QlEgI0VYT0CgXAvM6ehm6UfaXyzUzGCV?=
 =?us-ascii?Q?FSPWhIeaYAXblmjdbK2KmmALEKvr1O6zn8FXFtVgYfHjOr9khfMv1hoscBKw?=
 =?us-ascii?Q?ztqEPmXMdyzpTtydcND+BJBfQQemJOzh7sWWWnSry4kbPCMnvGV+8BdMpRKy?=
 =?us-ascii?Q?M7IuauwMeqq7/cWFIe3dbYD0vbhE7CLRHOAW5m5F94Fpqu4B5SRdV86+GrPN?=
 =?us-ascii?Q?t/D2hqlpSaoy+XsbS4m2AXkTRDKpCcCij4pNnmYqJ1yuibKgeu6M+bmbhEHu?=
 =?us-ascii?Q?p+vmtkM2nctFgBQeA5otVbo6vPRNanMiYUxMkx/sOmHFSlUDbgXb23QhKUUX?=
 =?us-ascii?Q?dE82O+m+zRqvAy9qlrf1TWk4xuXCOhYEpegvO5AeBr/8x9Wx2514KqHFopsp?=
 =?us-ascii?Q?tNtBIe3WrBa7YLj6UUSWDo6QITlkn6PtTqmkxErEyUqi+qOA+xVrDaaOFYtj?=
 =?us-ascii?Q?huRP621rhjEr0YkBhy5uk6IFTbGeNB1PCwd0NUR3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a4cfa1-8a56-470a-5b20-08de05b3c98b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:11:27.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2bGSgmIXJB1HpVhZEgn99xEXj0hMLKQy9d5jo2yqIkoW2r+VVEI2ak1kXsrLITm4dkmnEBXqT25UbqSfff4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10082

On Tue, Oct 07, 2025 at 12:25:59AM +0530, ALOK TIWARI wrote:
>
>
> On 10/1/2025 2:09 AM, Frank Li wrote:
> > +int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
> > +			     enum pci_barno bar,
> > +			     const struct pci_epc_features *epc_features,
> > +			     enum pci_epc_interface_type type,
> > +			     dma_addr_t inbound_addr);
>
> nit: Any particular reason for using inbound_addr instead of bar_addr ?

bar_addr is easy to confuse with RC side's bar windows's address. This one
means the ATU convert bar's inbound transfer to what EP side's address.

The below API also use term 'inbound_addr'.

It is not big deal. Manivannan or Niklas Cassel, do you have any perfer?

I am okay for both names.

Frank
>
> > +
> >   int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> >   			       u64 addr, dma_addr_t *base, size_t *off);
> >   int pci_epf_bind(struct pci_epf *epf);
>
>
> Thanks,
> Alok

