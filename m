Return-Path: <linux-pci+bounces-39238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD2C0445E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 05:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98D01A03451
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16226270553;
	Fri, 24 Oct 2025 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N7AeYqNz"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC222333B
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761277225; cv=fail; b=RxhKxFTpavbXBkWG7jLXikrPs+h49rtroscCxVpHIXUqLjdRJs921YoZRZCndMxmM8iQnATnWy5l2FTP/fGocaaCGBlNUhWYbqTfACL0MfyWMe1S0XyqJwbOUkRItf1tb5HfVeOC+GHGACx7O8UsNn41dL/W8R/bYshHcAB5JNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761277225; c=relaxed/simple;
	bh=9Fem03UPluxTkrksZzxoLI391M6dy33kV5RRdnTBTZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sgkApsg8t6OiR/Mj+q8ZsBnZ9VUkjbRZiAMHYC4znoanDPFsyNMGGa0gDzxTZ1ljtvigqGA3vyninnrc7R3M73iSmW494tANF1oQQMt1+gt/fCzclCeq9pxrMq4fk6r7HrOJfdwrCZ9XAGcF5rPnsLlzTy81mOwiIYMqEbFR5HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N7AeYqNz; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYM2OaMqkDbU4uZBLPKd1X1ErFBcz+R8fKxfb3a2fzRiwp9jZ716BpwMv6uJNenQP9StCoMKRd2rk+p3dbNXILFC5tCqwQa0RyatUs0nhtOEXKnnWL8OvaBQMpRJENTOFLKa7zfX1E5MUFEk2H9mt0e1EyNqiRQwj7EqyXEjBFxOJU13nAjaVPkLwIGgloXF2cpE9nFBymu2FH1WA1WcxLtSluVfSre5VjrdT0xelDoxY5yvEeW5hgib0wxPNIji/MtFzfbnl9glgtPCEhO9mups25y/UBWzNJa0PZQ/Xs99ZifK1i2/mR0JEVbhYUKehwIe6fsgXb29jPzXtk8QhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDgtpzSnmgc5VCp7SPbm9LQRlXK85hr4UsvXET9YazY=;
 b=oA4z/AMSznuanliD+3bR6CpDI8Ra7j3ALdbA849oP/p5uvEH9CIYScDdFlylDbbfSeHcpAqI9kU3H8xAbe3apSE/YPMXEZmvjDJJrYSfET9C7aXYUOhMuQPYVysIIEEqhz4JHUcRXs1/5YUibQWfyak///hdbMimf5/7EkbUXi1xm0pV+f5WtwdAKEJv9LUZhamJcsT9Oepi0t4C6xB5kZXBLnuEeGEpSeLCRcjgeqW5XPGK/TeFwzfIVcK4pqmASOUefgjLC/YXfEEbp9yjaDZ80WtE+xcoZRPuj7px8ru31vgTS036LWG7yIbllLGek5xOaoSUFSG4SGHHVXA0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDgtpzSnmgc5VCp7SPbm9LQRlXK85hr4UsvXET9YazY=;
 b=N7AeYqNzBHh1cGh+XQauagqmRAjKCbtvyZkn8c2jpUss5fvsFkE4rVTa++jEvJFwdYy8EjEalDAOsEu/M1E4wqrjp9dWUsZ+EfP/KcQuNWqzcz1DSUknPaV3CEyMpnzjiQFMUpgb3B/5xipRSVfLru21bWmnB1wBgkTcu1YrlOR1WMjf+Mbro5/zPDCD0atBOyMmd4wBXBsTT0RI8vFdEgx1DVxxqRnWOwIUAhDuHjco3fsqJrx9k+bGlblzl9JmDqv1v2rauZGEQASxczwER/VYcNBZqPmfhORZQsKFhktRHT7Fi/Gk7JUb81rt0/s6dAfAARQ4C2zEnom7dKODHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7672.eurprd04.prod.outlook.com (2603:10a6:20b:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 03:40:20 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 03:40:19 +0000
Date: Thu, 23 Oct 2025 23:40:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: dw-rockchip: Configure L1sub support
Message-ID: <aPr1HS0Ld+sRN4iC@lizhi-Precision-Tower-5810>
References: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
 <aPpN2NX7IkAEU9Rh@lizhi-Precision-Tower-5810>
 <de9371a6-654c-4360-a34d-7f8a20848a6a@rock-chips.com>
 <aPrt/H4lF+DrF4Ej@lizhi-Precision-Tower-5810>
 <eeb1ee07-7bd5-4082-a376-81e4bd0152ea@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eeb1ee07-7bd5-4082-a376-81e4bd0152ea@rock-chips.com>
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 8777392e-4c3a-4a01-c7d0-08de12af0e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|13003099007|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0Q1cEFEMWUxbFRjQVRuMC9yZzA0NUhmeFNVUzdwNktOY1BsaFNCNXJNSHJq?=
 =?utf-8?B?V01CRlhJOHc5cVV0YVRiT1I1aDJvWCtmdUhLdVFOLzZUU05uTWZSbTQ3bFUr?=
 =?utf-8?B?OWs1dVY1eXRtdzFOdDh5LzhIM0RwUHJkQ3NlQ21mNTFVTXFpWmo3SUR2Z3J4?=
 =?utf-8?B?aSt4aTJ6VHFmWWdtMDVWSW0xNXJhTzk5MW9haFArNkhlMk1uNUFCWXFmamNa?=
 =?utf-8?B?bm1reERCQTFYNmNXUGhSZHh0VHAvcW93MEJibUFEL0hUOHNvUklVTHhvOHM5?=
 =?utf-8?B?aFRMTDJMYlk5NU55a1FlT3ZORzN2SVladGF1RGdnYit4Z2t2VmFxT0F6am0x?=
 =?utf-8?B?dDFsQStuaS9BaVpEa0NMTVoxa1FGRHVnSE1WdDdmWUVxSERCM0d0WWl4N0Zy?=
 =?utf-8?B?QnRETGtKc28wTDlQRXBEVXowajJZNFA3UjQ2bFhoZExIQitjRU5PUFJxSHlo?=
 =?utf-8?B?dWdKbTVhNVJCaDVHTndvcjNEeml6b0N6UHA3WnlpSFkydTNpUlJ4bUlkbGRO?=
 =?utf-8?B?bGhqVUNaMlNFa3ZqdGZmeHhadEd3NnhSMmw4WmMycURLVW5FK3ArT3hDdUJt?=
 =?utf-8?B?MzdScjFJTWRUQ1Z0bWs1bFJkaGJxbVAvNEhFMXZZZjBxVGtuZTVwMzVxaTZZ?=
 =?utf-8?B?TmczbHpkQmwrTUR4Z3lWSXpDV0tEL1BJTit1MktBbXVBMWNsenRFekZYTHZJ?=
 =?utf-8?B?Q290RTFaYll2T3RFazlNTWdpWm1kcU1iNmwxcldDeGpWbTh2a3A4NDcwTk9h?=
 =?utf-8?B?SmJuZDJCUlk3MmtNZERkc25TVS9OaG1Odmh3WmlXTkFiK3F0V01NQWxpcXhQ?=
 =?utf-8?B?dWI1N2N1WURvUjlMclVRM2VXRzlLNFFDMytDMU4zd1VQK1pjZHJLd0hnOXp2?=
 =?utf-8?B?QnFvMGV4VmFWWDYzbzVuNHVFck5pRUlDWW83bXRkTEo5VHlsYnFQbERCMVZM?=
 =?utf-8?B?emFMU0pQZE9qRXhIbHdrd0U5a2lPSDFaWXE4emkrdU9CUTdLVXNBREtzc0lj?=
 =?utf-8?B?UlM5dUlKL0FJVU9JNmpZM0FROHNyMjQ4UE9LcFlLdmhFdHFiV3ZJRWw2MzdV?=
 =?utf-8?B?VlkvN1BDcTUySGpYSUNKMjh4TEczeFAyT1VueXA0bDJvZ3BqeFQ5SmZKVVN1?=
 =?utf-8?B?cEgrU1BYcnpFdkp0ZHRNbzVRN3FScE5uMVV3aCtNaE9HcmYvVGU4K3Q2NXNW?=
 =?utf-8?B?UDJBbVIrRmxnUThTR2JnSzUycXl5YS9oZ3MxZmk5Smt1cmRZbitDRnk1Y1JQ?=
 =?utf-8?B?VkVPWk16cXZuMkd4RGl4U1paSFlZNUwyT09aMlNCVWZUQnRmZENXL0hmK2Zx?=
 =?utf-8?B?QTRkWnpTZU11MDhCeCt0R2FGNzNEdHdLZXFTUklNeEVmWUtPNS9ZcEVuNm41?=
 =?utf-8?B?MDhBcmt6M050ZWJKS2tyU0Z2NFgwcW5vbmtXZXhMN2JrcGlQQXArYzRXVC8x?=
 =?utf-8?B?VkxKZmZKa0lpTHRXWUp1ZVlpQWhlQitPQkd2SkE3Rm1xZVNjejhvUk1nY3RX?=
 =?utf-8?B?amNza1lsa3JlZVBvOGo1ejlZZndWanpLOG9LbmM3ZmZUWWIrSk5KZHhaajNr?=
 =?utf-8?B?NDlDTlFyc2tOWTA1dDFGY2VDLzQ3dFlqQno0NWVVSXFaZjI4RFhyWkcwSTgz?=
 =?utf-8?B?dS80ZURGd0tNQUh5RGd2R0hSZjFUV2VkNlRXTE9BRGg4ZnZla3N5a0RXaG83?=
 =?utf-8?B?ekV2Q01OUC8xL1BVZnUvUU94ZTBRbXRJVjdTR1ZBS1BwaEx1Vk5tYVJOMU93?=
 =?utf-8?B?TDNhYVhtTTFKR0krVkdPdUwxZmhMSmFPaWxFQmhhcmRpSFVCbHJzalIxZGt1?=
 =?utf-8?B?TXNEUnNGQlFmSzFYeHluYnJMdkZORkxhOXBGb2ZLVFJVM1dmNzRMNXYydGRD?=
 =?utf-8?B?WlMxT2RHYmVVUEhBbjhuQnoydytOaC9MamdUYURsNVYyZEFjaUhDVjVwWGVK?=
 =?utf-8?B?Zi9YaXAyNWVtczFLSXY3MWh0WHpUVzQ1UjBiajFmQjBIREdLSTBKWjdrT0Rk?=
 =?utf-8?B?NlJMbXFCdm9XVWdLVlprNnNRRDdBQTNoSTdoT0RGVS9OSkFqVXl0Sk0wbmJ0?=
 =?utf-8?Q?6wpAND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(13003099007)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djVJcVE2cmNlL1FqcHBWMzU5YnJ1bEI2eDg0R3Z4eUpLb0NPQ0xNMlFjcjRD?=
 =?utf-8?B?M3R2Tk9PcG5qSXBTa01mMmM2UTRBS2IvclJaSUdOT1pPdjNzdFJ2eTRmdE1s?=
 =?utf-8?B?cGk4ZWxKV0lITlRnbm85UlJnSHlRWm1DQ1Rqdnp2NEEwTjhuZ3gzZmtHNjIy?=
 =?utf-8?B?dVNLZ0VFOHExNW9qSGRKRG50c2xXc1VkZmlmdW83V1hGWDRsUEs3MHBZNW83?=
 =?utf-8?B?OGpyQW9OZlM0clB2Zkg2SE5ZRWNhZ2dOYWdoRzc3ZFplSFVSeGxiRFY2QmVr?=
 =?utf-8?B?QXpnMEd4ZnlHQ3N5NzZXc1RsSjVXc1ovWklaR1pJaG1RK0cyZWlQNUFZcEtI?=
 =?utf-8?B?SStzcmlTczJiYjRzN0RSeFFvNk9MZkxOb2tpNWlsekloSVV5dVZRdk9mMVNT?=
 =?utf-8?B?WW5wVHNPRWZwcGFxbHRncVc1aGRJVEVuUHlCTzBuVXg4eWdLejZjam0xQkND?=
 =?utf-8?B?b3VTcDlYa1hiQnlQVlJNMGc0aTNYNTExRktxQWc3dFV3VUdYN0V0eFFoMTJr?=
 =?utf-8?B?ZjIxZURONFpMK1hjcmdSUGpOeU5VeXFsQzhzUDNXSVNzcmVzZExyL1F6TWdW?=
 =?utf-8?B?a2pGTExYUExTM2djcHBHV1AzSHRSUCtsUjNRd094MFlyekR5dUdZVmhtU1Bh?=
 =?utf-8?B?clVVcDE4QXBPNW1wemZ2N1lxYjZqS2VtUEtqR0pnNU11UEVCQ0Y2VE9XVTk4?=
 =?utf-8?B?SUVnaHlSbWIvSDNpRkxRQ2lCQU1qZjRiNm4rNGgyRXBsZlZmYXlEb0VTcUdY?=
 =?utf-8?B?a01STWRyaXMzOTV6VHBlbitHb0phNHducVhIODcxVXhxSjVWalc4c1JBdTlu?=
 =?utf-8?B?YW44amhOVkdiejVWTjNvRmFJK2FFK0czRDFENzZ0VE1PR2orSjBmWDlQWFZh?=
 =?utf-8?B?NUpkWUY3ZzdUSGZrb3NrVk4wWkVpYU1PQ3ZCUW5IeGh1MlE5U0RmL2JkUS9y?=
 =?utf-8?B?UENkaEZzbE5SazlkTmlkbnBLd1dhU1NlZUFoV293KzY5TVd1L00rcEhQL2dZ?=
 =?utf-8?B?cGtlT2RkRXJkMFBhZkVPWTNIb1FlaHN0blBnR0E5Y3RFMDl1cGY5aHhieWx2?=
 =?utf-8?B?RVR0YjVMMmNxanl4UHNvanh1WUJkekJyOVJwMzE0VWg3US84OXhZQVNTMWpQ?=
 =?utf-8?B?c2JhSmFOMXQ1NlRSYW85SzY3RzRqRkdWYzV2REwxVEFvdGFRMGdZb1lrOEtH?=
 =?utf-8?B?SFQ1ZTkzMERoV01CZmxFak1HNkV5MnNrbENPb21kVmpBZFJYMzZHNms5WW5i?=
 =?utf-8?B?akJ1OFd6WVdwcW1aSUlLVXo5NXBZNHR3THljWjVJUzNTemR3WkdtL29PKy9Z?=
 =?utf-8?B?Q3BxcnVsTVUrWG54ek12dUtrbnczMktJQ0RaTjV5cm82TVVOU0xDUGg3cnEy?=
 =?utf-8?B?cGlQeW4rS0xKSThnTjg4YzRkWnJERFRnTWdQNmo0UCtUSUJEZ1o0elB3QzRW?=
 =?utf-8?B?cWRKbnJzMjhiQldVUytSbjFHa0pUSjhzayswaVZvV0E4TG0vMWhpRDFFNVIy?=
 =?utf-8?B?a010RnplVWxRa20zQmE0aEpBY2k3QzZVOTI5V1FRMVlhUUxZR3VxZUNPZElt?=
 =?utf-8?B?WUp0b2FZUFhEYWxtZDFPUEJmRXJKemY0bHh6WUZMbmdMMm9pc2pGZ0JSR3ZQ?=
 =?utf-8?B?QkpKUmJtMEtOcDIwOVJSMnI0OVA3UWVwWFJBbUNKYjZPVXNTdmRkZWFIWW9F?=
 =?utf-8?B?dnB3bkR3L1dFcWdSYldpRDVFWmFlWm9XNUxBaVJFN2d5ZjB1L0lIYXRieFov?=
 =?utf-8?B?UnUwb01jOWVLbkNFQlplNG9HcFhRc2g1cFd5VnNzWDVmVDNLOENDdWcwb0FE?=
 =?utf-8?B?T2t0bTMwWFVROEtQTDU1NVRicjNjaW9lZ1R4RXJUVzh0UUJSaFhadzJaWTQr?=
 =?utf-8?B?TjZLa1B4NzlFcWdzYUswV3pUMGRWRzlURmZ2V0I5SUsxT3VadGNyNFZ6Z3Br?=
 =?utf-8?B?SGpXZ1BjUjlTRlQzSENZVTU2MnRtbWlGR1lsKzhEQXBYTmlONnZrNGttQzVy?=
 =?utf-8?B?OVFvSW04b25qRnJFY2pSYWJ0US9wbldWV0dhc3lsR0hnV0MyTGM3dmNDTEJI?=
 =?utf-8?B?Z2wrbDlYbVBmcndZMmYyUGgzUWlicHRjYVNTTlVVTnpMK3NXMkNpMXUxZUd4?=
 =?utf-8?Q?DWsM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8777392e-4c3a-4a01-c7d0-08de12af0e0c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 03:40:19.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6yeKBO9+NMzqXj93PdyUHZ8VSCXVEsFbxhYIqebbyd+Y/0nr+R35NsJ8g/Sc+kUFlRuHOI9Zy8shSSbyL5TKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7672

On Fri, Oct 24, 2025 at 11:19:45AM +0800, Shawn Lin wrote:
> 在 2025/10/24 星期五 11:09, Frank Li 写道:
> > On Fri, Oct 24, 2025 at 08:43:28AM +0800, Shawn Lin wrote:
> > > 在 2025/10/23 星期四 23:46, Frank Li 写道:
> > > > On Thu, Oct 23, 2025 at 10:51:22AM +0800, Shawn Lin wrote:
> > > > > L1 PM Substates for RC mode require support in the dw-rockchip driver
> > > > > including proper handling of the CLKREQ# sideband signal. It is mostly
> > > > > handled by hardware, but software still needs to set the clkreq fields
> > > > > in the PCIE_CLIENT_POWER_CON register to match the hardware implementation.
> > > > >
> > > > > For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.1
> > > > > Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
> > > > >
> > > > > Meanwhile, for the EP mode, we haven't prepared enough to actually support
> > > > > L1 PM Substates yet. So disable it now until proper support is added later.
> > > > >
> > > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > >
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > > - rephrease the changelog
> > > > > - use FIELD_PREP_WM16
> > > > > - rename to rockchip_pcie_configure_l1sub
> > > > > - disable L1ss for EP mode
> > > > >
> > > > > Changes in v2:
> > > > > - drop of_pci_clkreq_presnt API
> > > > > - drop dependency of Niklas's patch
> > > > >
> > > > >    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 43 +++++++++++++++++++++++++++
> > > > >    1 file changed, 43 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > > index 3e2752c..25d2474 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > > @@ -62,6 +62,12 @@
> > > > >    /* Interrupt Mask Register Related to Miscellaneous Operation */
> > > > >    #define PCIE_CLIENT_INTR_MASK_MISC	0x24
> > > > >
> > > > > +/* Power Management Control Register */
> > > > > +#define PCIE_CLIENT_POWER_CON		0x2c
> > > > > +#define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
> > > > > +#define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
> > > > > +#define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
> > > > > +
> > > > >    /* Hot Reset Control Register */
> > > > >    #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> > > > >    #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> > > > > @@ -85,6 +91,7 @@ struct rockchip_pcie {
> > > > >    	struct regulator *vpcie3v3;
> > > > >    	struct irq_domain *irq_domain;
> > > > >    	const struct rockchip_pcie_of_data *data;
> > > > > +	bool supports_clkreq;
> > > > >    };
> > > > >
> > > > >    struct rockchip_pcie_of_data {
> > > > > @@ -200,6 +207,37 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
> > > > >    	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
> > > > >    }
> > > > >
> > > > > +/*
> > > > > + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
> > > > > + * needed to support L1 substates. Currently, just enable L1 substates for RC
> > > > > + * mode if CLKREQ# is properly connected and supports-clkreq is present in DT.
> > > > > + * For EP mode, there are more things should be done to actually save power in
> > > > > + * L1 substates, so disable L1 substates until there is proper support.
> > > > > + */
> > > > > +static void rockchip_pcie_configure_l1sub(struct dw_pcie *pci)
> > > > > +{
> > > > > +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > > > > +	u32 cap, l1subcap;
> > > > > +
> > > > > +	/* Enable L1 substates if CLKREQ# is properly connected */
> > > > > +	if (rockchip->supports_clkreq && rockchip->data->mode == DW_PCIE_RC_TYPE ) {
> > > > > +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER_CON);
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	/* Otherwise, pull down CLKREQ# and disable L1 PM substates */
> > > > > +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> > > > > +				 PCIE_CLIENT_POWER_CON);
> > > >
> > > > Looks like you force pull down clkreq should be enough, needn't disable
> > > > L1SS. when RC force clkreq is low, Ref CLK always on even if L1SS enabled.
> > > >
> > > > Of course it depend on hardware implementation, But I think FULL_DOWN have
> > > > high priority to force clkreq to low then PCI_L1SS control.
> > > >
> > >
> > > Hi Frank,
> > >
> > > Thanks for your review. TBH, the basic idea here I think is not to
> > > advertise a capability if the HW as whole hasn't been well prepared to
> > > support it yet. So I'd prefer to keep it as-is.
> > >
> >
> > If that, I prefer do it at dwc common driver or provide helper function to
> > avoid other vendor to copy same logic.
>
> Right, definitely we could improve it once another driver need it. :)

Basic pci-imx6 do similar things at

https://lore.kernel.org/imx/20251015030428.2980427-1-hongxing.zhu@nxp.com/

Just have not clean l1subcap.

Frank
>
> >
> > Frank
> >
> > > > Frank
> > > >
> > > > > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > > > > +	if (cap) {
> > > > > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > > > > +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> > > > > +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> > > > > +			      PCI_L1SS_CAP_PCIPM_L1_2);
> > > > > +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >    static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
> > > > >    {
> > > > >    	u32 cap, lnkcap;
> > > > > @@ -264,6 +302,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
> > > > >    	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> > > > >    					 rockchip);
> > > > >
> > > > > +	rockchip_pcie_configure_l1sub(pci);
> > > > >    	rockchip_pcie_enable_l0s(pci);
> > > > >
> > > > >    	return 0;
> > > > > @@ -301,6 +340,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
> > > > >    	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > >    	enum pci_barno bar;
> > > > >
> > > > > +	rockchip_pcie_configure_l1sub(pci);
> > > > >    	rockchip_pcie_enable_l0s(pci);
> > > > >    	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> > > > >
> > > > > @@ -412,6 +452,9 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
> > > > >    		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
> > > > >    				     "failed to get reset lines\n");
> > > > >
> > > > > +	rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
> > > > > +							  "supports-clkreq");
> > > > > +
> > > > >    	return 0;
> > > > >    }
> > > > >
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > Linux-rockchip mailing list
> > > > > Linux-rockchip@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> > > >
> > >
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>

