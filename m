Return-Path: <linux-pci+bounces-36986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA4BA05BC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BC03B8879
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5A20ED;
	Thu, 25 Sep 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzDTleBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013023.outbound.protection.outlook.com [40.107.162.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6D1D61A3;
	Thu, 25 Sep 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813955; cv=fail; b=PS6x4TWlAgsooQ9xtqsKc2Ay6aonX71AXXipzU/U7xKyQbwW6CbK6Jy4NlqKRFjTi++ywEQZsyx3TKczktwlbPG5Z6VQ5Wrv3YlafhNAcMJYwLPnh2+3eTs+uEjidehtcmOr8yTSfKs+mVT5JywIBmi8vyy58DF3yox6Q9ubRB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813955; c=relaxed/simple;
	bh=iusC5g4x/SS8NC5qdaAYVzQWsutwrD67fAxws8tqcOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n5kac2Z7423sXAImNrFN8s//pCDl1o+iONkO2i3y1rMH70r49U46SfHfisl6Lxy+X1ulGz2raiysYoZCVi92EaFirSyQ13aFiijvemndkA46kimQR5fg+ZgpvCc3w2o2vsEGmCJ33ztvDh2s0nbnoKbaX/uwdYceeI0fwxFTgJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jzDTleBO; arc=fail smtp.client-ip=40.107.162.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anLLCVczrFQnFkJglQhc464Y93uPdPpuuispiDQVxAUJ8YJshYezREUNfSMDoxVv8eXmPh9q8inoYDvTP+hPIgB6wrik/nHYN7a1eJD4KoM0Px0kQEzM5xpFC0qn++KsjwEHaqfz/s8SCxng0cjpwKVO8IGpixkdK7O5Z0MuUkSo/ojZVme1Bbij68mKOWy9gfp5ipEzSh9Mv2wGrLn5Y84XHychFHniGjwwiWMVQW1Q0xo1iG7TSpSBK/yXt15hS20zbUq8Pt+H/wCmv8iOuHG+tU5p2gKGuXRJDOgNvz44bA8u2pp+9XsALYCPkuSPvyk7BqF+nmRfZd7auK6h3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h24rX0YnOus0ByYLpQaN+Bnkd0T4+wsb9xIohhMLG7M=;
 b=uPi3fG10CPgntaPJW3/e49fOos0nyxZtm8JmoScspqE4cWqgbl38hrJlniH5WvwjEzmErdmuf5wE5iRO8M8RV+8mR9DsKqrh6xQ6EUE+ViMcJCULaHwKNUr9+rUvNbxyv5eMFPEOUGOb8J6JljUF5eM9e4JrGl/u1oCU6Z5QxsQgPeb4sRbAGmd+xtbPRnBI9jtrh0ejXfBVBryg+uEh3zwQo5StBboShQCMpup9THYTiA16IxpLjfiOAh3t6z/SA+W01E4ub7z1MnZ0lTTq3kcbnrVwzCImtoa+PbJSRETQPhsC4qsHDhQtHED6tQs535wi/W96EnuCrF6drZE1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h24rX0YnOus0ByYLpQaN+Bnkd0T4+wsb9xIohhMLG7M=;
 b=jzDTleBO571Qk18caVDyvY9Bp7gAXSXMKnh+BwVmdBuPSbBVluHzc3EvHGEd+yoPpkXzzW16V7PU9S+Eo7tFKpkFpnRIbxGCbAwYMNnSn4kvnewNUWy3kvJzVVTxYt2CgFWVVoPqfRZLh6Hom9tqTgG9eirTJk0zYZ9Zhm/FU9kZZkZJXjsYG9ijGpbgQgIOWy9I5TrVrVkZEHipLYta3rfbwf2jcoqoX9TsjZIjWpLboVu/7Ks9NUN5iTwiHqPIVDTqa8KHir03xz9dPTM10KnHtqD5ydO5+RLP9pg4R0uruI1Hb3ErD238azSYbOgbLBdvo1i7L38G5PFFrcBLSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 15:25:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 15:25:50 +0000
Date: Thu, 25 Sep 2025 11:25:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Message-ID: <aNVe9UIbFE3/1Rql@lizhi-Precision-Tower-5810>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
 <20250915-vntb_msi_doorbell-v2-3-ca71605e3444@nxp.com>
 <ejhs6fb2nmfhnjswhrvd7iwyddwvvr5nv6bu7dt4aypbiecyfb@wza667q2x4qp>
 <aNRZxAU0n1hvYeEZ@lizhi-Precision-Tower-5810>
 <qm7jvvvywqmegynkghxbfn6pwfdlkboowa45sqbvygpetkiyj4@ovve44f7qvpr>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qm7jvvvywqmegynkghxbfn6pwfdlkboowa45sqbvygpetkiyj4@ovve44f7qvpr>
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS5PR04MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b49836-d91b-4d20-580a-08ddfc47cee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzYwMHBrNmVteC85QkJYNzhoc0pzU0gvbzJIQzVaOEg0TThYTTRSSTRPejg3?=
 =?utf-8?B?Q0c0YTdVczNoTDFzOWFwcVpTb3VjNG1EZmUrWnRicG1QazM3MEN0Z21La3lK?=
 =?utf-8?B?MmFhbHlyS2xrMEdjMlpJUUY4WHZ2OWtTOWQ2SHEvV1U2UVlvT05zZVJnKzNk?=
 =?utf-8?B?anlVN1dlOUo2SGl1WW1kMjZobGV4dXg0WVk2T0YvS3FNVGNaYnd0cVVidEI1?=
 =?utf-8?B?aVh5YjJsdEZXT3lNem1VOURKSXVJNHJ0UzRYWHVpOTE5VEVwU2cyRkI3dm1h?=
 =?utf-8?B?Tk85WkNRRUpFZUljTlh2Z3pvVzdjSE5ZZ0FhQ2Y0eVFFQU5aUGdVZDlYTXE2?=
 =?utf-8?B?UXQyN0phRit2MnRNY1dFamhJeWVneVcyUHoyWk9CbDdjUVB6UGg0NHNiV3Uw?=
 =?utf-8?B?Nm54ZUF0WEJUUEFJdU1RNGtDekl4dDJVZnFjU3E1eUFQNldDSmczbHA5ZUZz?=
 =?utf-8?B?U3JIQ1lvZ01lWnd3QnVSZk9BT0NDSDc4T3dyUDhNSjdJeUpVNHZxTGZhMDJp?=
 =?utf-8?B?dnlVMWd2Zi92dmlBMjlkWUxDUmJXNnkyM0YySGJESEUwNXZxenlKR3Qzai9R?=
 =?utf-8?B?cTlqdW4vczFPY2pIT3lwc1dubzBaRllVRzNNRzZCcWVKV3lNYXk0Um9iRTZH?=
 =?utf-8?B?QTdJUXdxYkJ0SGUvSGwyM0M1ZjVVWjBCQjFEMkVMVjIyZ1NOZjNrYkVoSHla?=
 =?utf-8?B?VVdURi9DK1JwelJOZlZyaHNGT2FhL1YrSzJLU2YyQTc4L2RHbVppV2tZTW5F?=
 =?utf-8?B?eHdxZ1ZzVWllZGlWalgvRDZRbGRqRUczajQzcnhpd25VQWp6LzllbnRlNklF?=
 =?utf-8?B?OW55NGIzRWRYU2dqNWdKVVFza2NmbUh0Ym1VYi92SFJjVGk0eUQxZXNYdE52?=
 =?utf-8?B?NlIyNFZUdW1LdjJvY0ViNWJDWkdoSkdnd2xFSGRRNWp4UzZQK3RQdTB3YmhU?=
 =?utf-8?B?NG93SHU5VWhEWmVocmZ3WkEwcHZLNSt0citpOUFHNkYzWkphVWprQ0VWUm1G?=
 =?utf-8?B?OGxvS0MrRzZQQUhFR3RJWkIzNHBQQlNXOTdTM3lZR0Z0aUFOeDR0ZnVua1dL?=
 =?utf-8?B?NDZKUVFIRW9EeG9jNHptN1dQWGovRDhOaXNNUFI1dlVKYk5MQmJzRExyM3pa?=
 =?utf-8?B?Z0pob1dwZXd6SnVlN2UvM0FiVzlLMEljVi90NCsxeGd5YlhsR29QL2pjUG42?=
 =?utf-8?B?b3Z4UFpkWEFkNW9EK3p0aWNxUDNxaUlFeTJsVFN2eHRwYlB0Sk41cWdEZ1Zl?=
 =?utf-8?B?RlRCS2oxUndkU1NEYVlKRXBaVnNxUHdzQ01BSDkzL0ZTUFowR0J4MjZmbkw5?=
 =?utf-8?B?N0JKNnV1MDdQYzdDbDZVWnVVZDc2aUtjaWQ5bUY4VHZJVXpRaDlSN280MVFl?=
 =?utf-8?B?c0NRQjBtNFZiVUx1YmxRcjNUc1ZLZ3JLQ2lKNlh3OHYvTXd0dVBsRlhiYytY?=
 =?utf-8?B?cVczY2cvVW5vbW5YdnVDMkRqUWhSbk94dnZrNUdsQUZkYVB6cVRRZGJSN0FK?=
 =?utf-8?B?MFdraHEyQXp6aEVjYWNzSjRZTHR5dGJiZzR4UUtmQTRFQTNqNVk2NkttNzFy?=
 =?utf-8?B?OU9HWmZTeHN2QS80QjEyd3Q1RlBKWlFTTnlrcTFQQWZuQ1VGNlBQNmdOZzNm?=
 =?utf-8?B?RlpiVmFkbGd0RkV6MXNwdlFoN2lZR1FxMUN1dE91dWxtQlg5ZmkxMm9rcm5j?=
 =?utf-8?B?UDA5TWxmQ3g3OHZWTklMeUFwL2dTWGpSbzlLWlhSaFNsanEwL2FNSEFueHZk?=
 =?utf-8?B?amVzL09ic0VTdTU4N3E0M08wemtPK0lvb2VBaEthMlhTZllSc0ZGS3ZYQUVX?=
 =?utf-8?B?ZHlVbkNLa1paSmJCendYRnl2N09lT2pveFJSa0pLWDRZOEU3azNGOGVvbWNI?=
 =?utf-8?B?c2hlTGdJUDBYUm41b0FQbzhtTW9tU2tTZmJxK1c2SkFINnR0NG9VZzd1YmFq?=
 =?utf-8?B?a3paUSs2MzNFZi9Yd2FIMmVuZ09YV2ZDSTZOWmJ5bDJLQUl3NlhXemE3MGQ4?=
 =?utf-8?B?SmZhUG45QUFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJjV2NGVDgrYTJkTHZTSG50Z0lWYUNwbDhEaXFrWnlqcWdHSmdqNkd3eCtT?=
 =?utf-8?B?dWwxc0hHbGlub0FtcithUHB4YWR2SXlsQUtwdkJWWVdPZGFlTHlyZTdzUERP?=
 =?utf-8?B?OWhJbmpRaWFySkJJb2lKU0dFakNZbUdjSXczeUY0MmxWWnVQVHRTd0psNTRW?=
 =?utf-8?B?K0U3by9YVk5ZMjVxVzFwTldIVk1mQ1g2YXBpMjQ1TDlTczZyZ2NjWVFZTndp?=
 =?utf-8?B?TURKRXB2aUtHT3FteVZ1OUY5ckc4NG9TVXY3QU1JckJueTdHamJMNHJXemk3?=
 =?utf-8?B?a1JkZkc0RzlKY3JMQ21kK1RnOWNCek5UMVpwNHQzUS83MmFwNHprNGdrdUl4?=
 =?utf-8?B?My9hZkg3VU5DejU3WWJETzdVYnBzWWNicFFnMnNMbDl2VWFlMENWbHNpSlB6?=
 =?utf-8?B?QU1rMkpMUWFaM25qRkY2dnVyNkpiTmhQeDAyck5NOVA0aXJranRiUmJTeS9z?=
 =?utf-8?B?ZmdtQnk2MFlucWFVMmJwajVDSEtTYng0bDhuZGxJR25HbmRzQVEzRGVzZm1a?=
 =?utf-8?B?QWsycWRzbUlkdGk1V0pqd3M1MUlkN0FxNDVqNTMzRk1ya09sbnBqNnQrWlJz?=
 =?utf-8?B?bWlPc2JWeG9mVE5VRUhWdGtadG90NnpsOXQ5N2tZeDhSMkpMU0NRbThadUtM?=
 =?utf-8?B?aWJFV0hOT09YM3U3SEtEb0w4d0RzV0NhUHBXM0UxZzg0S1VvTnljSkQzUFhF?=
 =?utf-8?B?bmlzQk92R21ENkppdTFFazg1dnRRZVQ1bllMaktGQkRRQjc1YXk4Z0c2NjZw?=
 =?utf-8?B?Y2JwRTZERi8rc000ckVaaHBQTFE1bkxLK1IyMFdtOTlLV1lIWlliTVI0eHd4?=
 =?utf-8?B?ZlkvY0VzbnZUK3hEV3hWZFc4V05jVmRBL0g4VFhqTWt4NmVMV25pYWVhWWJK?=
 =?utf-8?B?QXlzUUY0K0xhc1ZxMUJRcFhmeHg0MnNKNHBOdUM1RFBJalY3RnQwc29aNlRG?=
 =?utf-8?B?Q3BIUHRrRDlZalNQU2hYZ2Z1TWVtM2tDdnJmUTR4ZnBaT1BqTzJINEZ2djRS?=
 =?utf-8?B?YnJiSGNzcy9wOTFRTnJtWnpNamJHTFc3MXdST2VZNlF2VFprL1BFWkRGLzRC?=
 =?utf-8?B?TUc2YXppek5TcWdRZW1xY1I2RUcxQ0hpQ2lKaFRKL3dqSmZUMW4yekFQRUsw?=
 =?utf-8?B?UitGUk1hQUtxWnVCdzRRK05ya0lHRTdNSnlTdHpwOTJYMjJYMjNhTE8xT2lF?=
 =?utf-8?B?TnA3VCtkTExZQVd6TEVCRjNwN2YzQjA1RDVsdkI3WXQyWGlRUWY1MnhaOVZI?=
 =?utf-8?B?bk8yRzJsUEw2QTNxZHNwenI5ZFJVWVZFNVAzL1dJYUpwaEl1WjZpenBaZGNM?=
 =?utf-8?B?ajMrMUtkZ3phOHRLclFvZVF4Vit6dTY3bnBxNXZPTzU1WmMxbTBjaEJUTno3?=
 =?utf-8?B?UkVSbWgyNS9GUTV1dUJCaFVFQUlNazlqTEZhYXh1WjZJeEhjUUhjL3dOd2hQ?=
 =?utf-8?B?eW1rTFFRZTlFcEVFTDQ3Q2ppaXVjYW5Hb3FhS1I4YWRMNDM1TW9pdThWUE8z?=
 =?utf-8?B?NnhZRzJDb2VKWlBoMVo5ZFpUY0dJSEx3NzdtZ3oxQnUybTE3RjVwcDhOcXBL?=
 =?utf-8?B?MWlseTVHM3U5c1IwZVhRRjlSMlh6YVJZWDM0NEVtQ0twaTU3ZUZoc1ZleXhl?=
 =?utf-8?B?WlVUMXpDQTJnZWZyS3hoRWJJZ2F5dkU5TlJXeGcwNE5URW5wanFpRHJoQW94?=
 =?utf-8?B?SjQxWGVTTzZjVG9GVlZZUDI3eUhEUEdXUnNnYVI2MkxFOERrME9yWGRhdjNt?=
 =?utf-8?B?TU4rY0FMUWt6S3JPeFZrWVdTU0c5UFc1aEFmKytiUFhWWXJtOHZLMDN6b3J0?=
 =?utf-8?B?OFlRY0xOQngzbDNYRmN1OEsvdkpnSGZqUnNma05qMXkzTldpRk4xSjNHQ2Jl?=
 =?utf-8?B?UWxHYWxORThIb2UzYmJNSnBMaVBJMUI4ejNsd2QrOWsxa3ozM1NhK3I1NVpD?=
 =?utf-8?B?dzRnbnVkdnhMWi9SZ2U2MU52bmZnaFFLYTg4WmlHTFdxM2drM01manBUTllz?=
 =?utf-8?B?V2x0SHp5QWNUTGROSHpHL3U3SWh0ZmhJUWp3N01NOUVPT2ZUakhxUEpsSFc0?=
 =?utf-8?B?OFc4SmdBMjV0UXhLYkdnOE5RTG1lUUc3TGFTY21ROTdHUXI5dkR3dk8wRG5w?=
 =?utf-8?Q?OVMvIAbdsyVQIMEENROgjBHA8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b49836-d91b-4d20-580a-08ddfc47cee6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:25:50.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqyMtjhrBAEP1iUv3Rp6x2ghcTpP1OFp1GhXhV1sDPq2nCF4uzDbjfIJGi3afMeCEIzJNP9Cjc7O4wphp6+egA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

On Thu, Sep 25, 2025 at 02:52:38PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 24, 2025 at 04:51:16PM -0400, Frank Li wrote:
> > On Wed, Sep 24, 2025 at 11:52:29PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Sep 15, 2025 at 06:22:46PM -0400, Frank Li wrote:
> > > > Add MSI doorbell support to reduce latency between PCI host and EP.
> > > >
> > > > Before this change:
> > > >   ping 169.254.172.137
> > > >   64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
> > > >   64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
> > > >   64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
> > > >   64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms
> > > >
> > > > After this change:
> > > >   ping 169.254.144.71
> > > >   64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
> > > >   64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
> > > >   64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms
> > > >
> > > > Change u64 db to atomic_64 because difference doorbell may happen at the
> > > > same time.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > change in v2
> > > > - update api pci_epf_set_inbound_space
> > > > - atomic_64 should be enough, which just record doorbell events, which is
> > > > similar with W1C irq status register.
> > > > ---
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
> > > >  1 file changed, 136 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > index 83e9ab10f9c4fc2b485d5463faa2172500f12999..06c13f26db1c6e55d23769e98e2cfd80da693a20 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > @@ -36,11 +36,13 @@
> > > >   * PCIe Root Port                        PCI EP
> > > >   */
> > > >
> > > > +#include <linux/atomic.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/io.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/slab.h>
> > > >
> > > > +#include <linux/pci-ep-msi.h>
> > > >  #include <linux/pci-epc.h>
> > > >  #include <linux/pci-epf.h>
> > > >  #include <linux/ntb.h>
> > > > @@ -126,12 +128,13 @@ struct epf_ntb {
> > > >  	u32 db_count;
> > > >  	u32 spad_count;
> > > >  	u64 mws_size[MAX_MW];
> > > > -	u64 db;
> > > > +	atomic64_t db;
> > > >  	u32 vbus_number;
> > > >  	u16 vntb_pid;
> > > >  	u16 vntb_vid;
> > > >
> > > >  	bool linkup;
> > > > +	bool msi_doorbell;
> > > >  	u32 spad_size;
> > > >
> > > >  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
> > > > @@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> > > >
> > > >  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
> > > >
> > > > -	for (i = 1; i < ntb->db_count; i++) {
> > > > +	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
> > > >  		if (ntb->epf_db[i]) {
> > > > -			ntb->db |= 1 << (i - 1);
> > > > +			atomic64_or(1 << (i - 1), &ntb->db);
> > > >  			ntb_db_event(&ntb->ntb, i);
> > > >  			ntb->epf_db[i] = 0;
> > > >  		}
> > > > @@ -319,7 +322,24 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> > > >
> > > >  reset_handler:
> > > >  	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
> > > > -			   msecs_to_jiffies(5));
> > > > +			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
> > > > +}
> > > > +
> > > > +static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
> > > > +{
> > > > +	struct epf_ntb *ntb = data;
> > > > +	int i = 0;
> > > > +
> > > > +	for (i = 1; i < ntb->db_count; i++)
> > > > +		if (irq == ntb->epf->db_msg[i].virq) {
> > > > +			atomic64_or(1 << (i - 1), &ntb->db);
> > > > +			ntb_db_event(&ntb->ntb, i);
> > > > +		}
> > > > +
> > > > +	if (irq == ntb->epf->db_msg[0].virq)
> > >
> > > So doorbell 0 is supposed to trigger the command handler? Is it documented
> > > somewhere?
> >
> > I missed my very old patch in drivers/ntb/hw/epf/ntb_hw_epf.c to use
> > doorbell 0 as trigger command handler, this path should never triggered.
> >
> > db 0 is not used in ntb_hw_epf.c
> >
> > >
> > > > +		queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler, 0);
> > > > +
> > > > +	return IRQ_HANDLED;
> > > >  }
> > > >
> > > >  /**
> > > > @@ -500,6 +520,90 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > > > +					    struct pci_epf_bar *db_bar,
> > > > +					    const struct pci_epc_features *epc_features,
> > > > +					    enum pci_barno barno)
> > > > +{
> > > > +	struct pci_epf *epf = ntb->epf;
> > > > +	dma_addr_t low, high;
> > > > +	struct msi_msg *msg;
> > > > +	size_t sz;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	for (i = 0; i < ntb->db_count; i++) {
> > > > +		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> > > > +				  0, "vntb_db", ntb);
> > > > +
> > > > +		if (ret) {
> > > > +			dev_err(&epf->dev,
> > > > +				"Failed to request doorbell IRQ: %d\n",
> > > > +				epf->db_msg[i].virq);
> > > > +			goto err_request_irq;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	msg = &epf->db_msg[0].msg;
> > > > +
> > > > +	high = 0;
> > > > +	low = (u64)msg->address_hi << 32 | msg->address_lo;
> > > > +
> > > > +	for (i = 0; i < ntb->db_count; i++) {
> > > > +		struct msi_msg *msg = &epf->db_msg[i].msg;
> > > > +		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
> > > > +
> > > > +		low = min(low, addr);
> > > > +		high = max(high, addr);
> > > > +	}
> > > > +
> > > > +	sz = high - low + sizeof(u32);
> > > > +
> > > > +	ret = pci_epf_set_inbound_space(epf, sz, barno,
> > > > +					epc_features, 0, low);
> > >
> > > Should this new API be used in pci-epf-test also?
> >
> > Needn't, because pcie-epf-test default set system memory as bar's space.
> > switch to MMIO when enable doorbell and switch back to system memory.
> >
> > size alignment already consider at bar initilization, and we can't change
> > bar's size after bind now.
> >
>
> The memory and size are allocated during pci_epf_test_bind(), I agree. But
> that's for memory allocated through pci_epf_alloc_space(). So if the MSI region
> has size restrictions (as taken care by this API), it should be handled in the
> pci-epf-test driver as well.

pci_epf_alloc_space() is not only allocate memory, but also set bar's size.

But we can't change bar's size, for example allocated 64K at
pci_epf_alloc_space()

but MSI map only require 4K. Current framework can't change bar's size.
still have to use 64K for doorbell even MSI just require 4k.

>
> Otherwise, we will end up with different implementations between EPF drivers.

pci_epf_test is special use case for doorbell. No one switch a bar to MSI
as doorbell dynamtically. Generally, allocated a dedicated bar for
doorbell.

pci_epf_set_inbound_space() and pci_epf_alloc_space() should be exclusived.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

