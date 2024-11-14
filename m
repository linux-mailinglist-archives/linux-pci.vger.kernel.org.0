Return-Path: <linux-pci+bounces-16798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A239C9563
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 23:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0509C2832C2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 22:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1C1CABA;
	Thu, 14 Nov 2024 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ncltcj/x"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013042.outbound.protection.outlook.com [52.101.67.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D88018B464;
	Thu, 14 Nov 2024 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624778; cv=fail; b=IvJGCrw2V/1QP2bnrCcsl3+F3lGR7nH3qmyk2oSRdMZRtpPwjlsBItOdaSkZ4ydCm7hdfsc7rJNE0zPQrzc+QvWcky2wXylxxA0xt8fy+kPgqWRObZw9npREsX6qkOPOW9E92nVLR9CvHy1v1goLmi7xThPxM2+ZBPJqMxWZbPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624778; c=relaxed/simple;
	bh=ulQGXi1yIK/ntnlII+cu6+O4pVuCk2wjHjuwBbJVrKI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PWCwVJW5BhazN1K7wlsPFSnB/4jdnZ8GYFg0wk5VzG9UL72rN8xpiaB8BTfDh2fK74kmytVol6kfeV/KgoCiy3dryJD+3Yr/jgAmzrFdvEO7ybBYAbTCKcDKO7qz5UIQDSMsTprq/i1cS7f09VQ5Ht+KuBYEhp9fVz5A74dVcsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ncltcj/x; arc=fail smtp.client-ip=52.101.67.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0RC4F3xBQWXfnll86QVj6Dne1JBUl//Q9ELQBEkRuB6sSvWrxcJoBaQ8pMZ21Dqg9WUSJRJsFEIPmsmalmQTCV1riQKSj/tBwyNDmWbJHNtl68cT+yREfdc2ITtAyPmHBS0JMeV238gHfkM7DTfwQ0RtLEHkE5P3QPUzUanIUpLcwW+LH8lRkIFnfI5BnACLhcvOOsZwJq8HByhk+U9Cpyo5NXG2/x0MwRjD3bq3h+O4/p7k42mI+pFGSk1Xa0VmIHvdYzN6uSiqIUpkuo+mIbiY60I++RuK/6iTIVTj0PjK48TFdkg+mqu28Yec0pMz0a8Q5LovzUCK/Xc9uoNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eflMD8lWFtvSQ0Iakep7p2aO7cQnB2JKh3TU5wN8MZU=;
 b=CiV4BAXte2MUA9C+Bb6HaLemnVZ8AUTXwsz8P5A0G45FC85yBqDzqnp59DzvWp1J5qI8qG1ccWc1aoPuIW5d8eJrRlrFfMs58lnZdPGG8bjc3+E1OkpuQzX8+H2tbI8RxFMP+RmdFOQBMrUR3oYTPcHqb0dOXEHXZioGb8HDF4UegZ9MUs9XnOV47Z3kBozmQZmumbSLdPrA3y9wHvtRTp66l7s1A5xkoejW7n9PYXBZ3ZQR6Nt19ApdjOPt3uW6PndtVkr/nbvTGxw1YH/ghANe4xWwo9eYcUCz64d8EjKVV4lF706UipW9QlQsnCIP/ZU6+FhCbTtX5+8ClVt70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eflMD8lWFtvSQ0Iakep7p2aO7cQnB2JKh3TU5wN8MZU=;
 b=Ncltcj/xJk39ovOhgr9ycVIPOV62+lRvne9265J4ipn107FGJR0oc9j2fTD/vcWZCV1rBL4HjFWj+8+/umPcL20OYnPPE9E9rWhnQInlGDVx6bVNuPA0qeuZFBH3bkB+E7ObGQqpf0bcc25gX0rNHK/m8OaV9cxRG0eAmEXX+T9lWse5QdJqP8Nlf9Ae4+mQBzqRnvggjGGG8gJ7RAf93fd/Y9K3zkD8OJPtYP3xgjQmyM1CLAJop4mTtpXBHQ+0VkgOympdO+o0pbBEFvkI5k0bRQ6uOdIFCJSnmgrid0awFYYLJvReNfqtGaimam4MSUIFMsVMPPVr7ud5fkwFGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9967.eurprd04.prod.outlook.com (2603:10a6:10:4dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:52:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 22:52:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 0/6] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Thu, 14 Nov 2024 17:52:36 -0500
Message-Id: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADR/NmcC/1XOSw6CMBSF4a2Yjq3p7YNSR+7DOOjjoh0IhBqCI
 ezdQgLC8Nz0+9ORJOwiJnI9jaTDPqbY1Hno84n4l62fSGPIm3DGJTBgFFv6TpGWTnrrhHDgkOT
 HbYdVHJbQ/ZH3K6ZP032Xbi/m65pQa6IXlFGPwZfGQuHB3uqhvfjmTeZAL3dIwIZkRhp0sDwY4
 3h5ROqPgJUbUhlZkEaBZ4ExfUTFDgHfUJGRVJXRnKPwfPe9aZp+Zmn0JTkBAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731624768; l=6761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ulQGXi1yIK/ntnlII+cu6+O4pVuCk2wjHjuwBbJVrKI=;
 b=h0ltCrHMIWqWyVNoixRcDQdknq9MHrBSrAsBEK/NvOnFt3jObjJRSI3gv/wAQMygiYqOeaokJ
 xzXI5R9qteKAI0mR0MXXjR41lNzW9IFj0Ah+qEHqvCYeDAY2wFSl/Bk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9967:EE_
X-MS-Office365-Filtering-Correlation-Id: f517831d-5524-43ac-ea6a-08dd04ff11de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkZrSzR4VFpVRk1YVFFCajNPWTV1RnRiWHMyOHBYc2loOGVYbkVqems0MHB2?=
 =?utf-8?B?MkUvNVQwVVpNR3VTNVhTOGlOcC9DOHhNL3YvdUVwVHhjRHFPYmpOcnNFY2lk?=
 =?utf-8?B?dVozeUpsTkNRaXdLUUhPenRua1RzMy9rUTZoSURiMVVOOFVDUSs5c3NFNXdr?=
 =?utf-8?B?WWxJT245TWZZL1FGUFNsa1JhYzFacktzYXY5S0V0UFVzbTlUNXpzMXVnSzR4?=
 =?utf-8?B?Z3BLR3VCbHNXSkljeVc2dUJaaUo3TXphY2dlR1Z3ZytuOHBpSWl3NkI1c1FS?=
 =?utf-8?B?L1BzdjlmWE5ULzNmQXIwRDMyclVWSDJqMWdDalNYOXhGT3JMdXkrN2c5TGw5?=
 =?utf-8?B?MkF5NWljMGZYeFc5ekpKeXMzVEtyem43NWFxKzN2M1kxcmQxUE5nNzVDM296?=
 =?utf-8?B?dHBRTFNlN080YUtOV2ZjakdHOXUzWkZ4MWNvWGlQY1hWTVlabUNRcHQwQ1ht?=
 =?utf-8?B?Vzd0ZDVIRnhqbVZ6QXZWWlNBejZiZzJ6Y1JPbW1IaDM0TlVRazRRSERVMzB0?=
 =?utf-8?B?RDFuK28zM2dTaDUxZnRrVXlyblNUaVJXem1jTm1UVmlzbmZwVk9kbE8yR3Fz?=
 =?utf-8?B?ZVdHVWlyRHY4ZUpzYThCamI2TWtYTHJTQ2FQbWVZQWVJNVBsM3ZJZFRyR21O?=
 =?utf-8?B?RFI0RDR3WTlBazI2bzNvdkN5TXh4VjJ3UDgrdnBjVG9oTEhIYUc2RzZUcitJ?=
 =?utf-8?B?eCtZY0NZeTdSQVFxUER1aURVeHlhMk15Q0ZzRm5HTE9qQW1GNFArcGF0SElm?=
 =?utf-8?B?ZnBmWEQrVWF0bDRlTXZzWUcvclN6RFpSVVNkc0ZNZXVpR3hWVWVqZHZ1Umdk?=
 =?utf-8?B?M3ZxUEt4OWJZL2dWYTVFVTREZCsvS1pZcHYyMTRLSnBSYmwyaFJ1Ny8zNEZn?=
 =?utf-8?B?eUJKZ2pTMDh0aHUxN2dZS29Ra3FySW1FSDUyMjRacWhzYkR4dlFYS250eHd3?=
 =?utf-8?B?Y2pqelNxUjg1UGIvUmxlSTEwUjhtWUVEcEkrMGZHSzgwdW9NUjdLNXhPRDlR?=
 =?utf-8?B?ZXk2V256SmMxRnNieExHVW91UkRTUFBhdTJFLzhxS3ZaaVgvbmRUTkxheEk2?=
 =?utf-8?B?ZjQvYWZZaGpCRkFyN2tUUmF5SHM4a1FKZ2RNOW50azB5MDFpVWYrMklqellu?=
 =?utf-8?B?SC9Ka1lKK0dTdWF4cFAzM1N6VTJFVyt5U2VsM2o5cWU4cmZsdG11a1NUcFU3?=
 =?utf-8?B?MU9Ub3doR3QvdkN1ZWNkNTBmVVF6RkM1a0RDTTZDUGZHYWZiMy9Pc0FkSER5?=
 =?utf-8?B?L3dhU040WmI5RWR0aklrcU1oK3NSdkxVNFFOZmRESkdMRU1jSHBYMEpjYmJE?=
 =?utf-8?B?VjV6YnZJZW5aM0FINmlML2JwVTlWNWhNSUg5ODFpUDJXa3FHRk43UDRzNjVy?=
 =?utf-8?B?am9WaFdvVHo0dHJTREJRRlhjR2lBM1p3QWo4NzRIZDRpalB0MW5IaSt2Y3Rs?=
 =?utf-8?B?TndZYktud0lUd2JENUgwaVFydmR5ZWRWQkhKSnJDNkd0MHRlMk40UHJES1Uy?=
 =?utf-8?B?WUhtaHl6dFpueFFsNmtVNkpqUko0Y2sxcmhpdEZQbjRyT2FHV0hGRktNZnRH?=
 =?utf-8?B?VkRkcGFYUGVWT294SW1WRERnUk1tL3BSZ2FZb1ByMlg3SitQQVkyTVNZUURq?=
 =?utf-8?B?amZ0TFRVV0gxT3BYQmxWK2VkdXA2aFNTNzBjdmovLzNGUmtadklqbm9vdEs1?=
 =?utf-8?B?NHRsZ3RCZVFhYmt5ckhKVHJvOVBQM3N5LzdIK1hmaGxvT3JHNk1wcWpmUEIw?=
 =?utf-8?B?N2RFb2RzZnJQTmlqZnhzTHlqZUJNcXF0NHczZ2tWeVA0amFEbCtlZmc3MFVB?=
 =?utf-8?B?WmhVeGprcGY3MmhpZ2pIaTdYY1RJWWZvV1dBNjhFSzJSQWk5blZlZGh5N2p4?=
 =?utf-8?Q?97wTyLQamii22?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjVvdml4MCtOWVMvYSsvY0F1Z3dwWnVHcUtOWDJPU0VxU21OcG52dndZdXZ2?=
 =?utf-8?B?bnhVTldPa1JtQzRvb1QzNG1XdDBTdnJ3bCtTd2hkR3ZXR2ltaE9kdHYrOXhX?=
 =?utf-8?B?b3lPL0Y1cnVpM2ZvNHdUQ0dGYWJNcHI2MzlUYzBEWEtnT2tUTlZ0SVBiL2I2?=
 =?utf-8?B?UTlHSWJyeStkOGFaTXNpRldrVzZxYzlqOW5aRlpWN3NKbldWZFBPQkxMMU1h?=
 =?utf-8?B?VXVyZzhjZ1k1MEdzY0FWa2pNeW85ZHlIVUxhWlI2VXB6TExuWGp5TGtaa0E0?=
 =?utf-8?B?UzJMdUdFaEVSdUIzYTFMdDBSWWN5TVVwSzVETzZXb0Q4STkwU29aUTZ0M2lF?=
 =?utf-8?B?WFRTZWd1YjFCbk5iZy9vRFp6NURDZjJVaDFTaVkvZ2FKeW9nS2hwcVZrMmVs?=
 =?utf-8?B?djNDUHhrRXUzV2NuVEZXWGtMV0ROaFkzbUVKYjI4Y3ZDZzNqOEFLQnhQb3JN?=
 =?utf-8?B?dURubHJQVjN2VXBRRW5HbTFZT09GNm9RYjNwOGVBQ3NKbFpKNG1mTklBM1I4?=
 =?utf-8?B?TnVGK0htNUxpMVFLZHppT2dqRS9uU2d0cU1tcUZEQWphOVRJQnJIb2VybXNp?=
 =?utf-8?B?aHFHQ01XZ3VhTGRnbk5xOElhU2xmK0ptaEU5MTdXTTI1aFp2SjFtQ2JiN0Q1?=
 =?utf-8?B?d3B0dWRPWnp6bldqTnJRZGc1ejNhcG9URzU5UXJCUGFHMGJ3cXppSG8xdVl1?=
 =?utf-8?B?emIxTWxHa1JDVk9xM00xL3FGUHJJbkJLK2orTnR5bjNRaWhnaFprekpQTGJ3?=
 =?utf-8?B?MjF0bkpzZjhkSEF6d2VvL3ZaeTZTS2pRRUFqSHVNMW1xUXkzenlibWEvRjdQ?=
 =?utf-8?B?RjdvMlBKVHNkYnJ0ajB0MStMcWxOejI5dGpZbFRLRmU2bUxYMVpyMlNhRWlk?=
 =?utf-8?B?cU14alFhM2RyMmRyVjdHR0VsdEFJSXZwWGJyVzU5aEQyM3BRbUpUS1k5WjlV?=
 =?utf-8?B?b1hlanFNSkZKdW1aREFiS2U1TDZnYWZ6K1Z3OVJiaGVBMlEzZU0rZ25OZEJt?=
 =?utf-8?B?TFB6MHMwSFFDZm1kaWl5WHo3ZkRXTXdtWE5iNkdZN0xnQzJudWwrVHZkUFln?=
 =?utf-8?B?Wk0zSzRJZmFrdE1PcVRkTGdmSjNMUmhVR0h6bTgzcW1jOC9XV3pPOE92S1o3?=
 =?utf-8?B?UURJdmlEcG9nakxhYnRudlpaamh0R25zdFVNZWlaRmpPR1k3cy9rSTVnRlgr?=
 =?utf-8?B?RFgyR1F4Y0pSRFVoamhHRFZZQWp0bW5LK1NoRjgrMDQwVDlrR2lMQXdWa1g4?=
 =?utf-8?B?N1JmZEJ6VVNNZStnWGJIZzhZZlYrSjJ2eXRScFZONHMxY3lQRzRpdXc3Q0ZM?=
 =?utf-8?B?SXd0cU5pTStTSWpVWW1SUy82a2w5cWtKSnF0Q1pFNUFDTzhhcjV4eGhRUjZr?=
 =?utf-8?B?Qm8rWTJIWFQyamJNUTlyNUlPb3hpODdxUDE2YVptSkFXY3ZCWHQ4S3dsdTBQ?=
 =?utf-8?B?MjdVdDJBMU5CYXdETlFvOVNFMXp2YUpCeDkrYjZwcXNab2k0SjNNdlFYS1Uw?=
 =?utf-8?B?RWZ0eHZZb21vQi9GcmNRV2dMRDhxejExZWRFM0JuOEZXQjdqeHZ5VWV0cWVm?=
 =?utf-8?B?UEtNaUNyU3U0K2VNZGd1Q25WY3pvRjd6b1N6VWtOOVFUMHhSUlZ6UTZYemU1?=
 =?utf-8?B?VTBjVHVodCtwNElJTDFCU2pIOFdpK2hhSDhiNEd5WHNCOERsMjZWalVMY1BN?=
 =?utf-8?B?NVNENEpkUEZsOThlNFJGeGM4a0haSWRIQjEvMW92Q3R5M1pMMzhaR1FTV2Y2?=
 =?utf-8?B?WWZWbmpJc0trMDNZVHYzdmIzWHc3T1NvRUd1Ly8vTDFzQW1tVEl2d1pMY0xz?=
 =?utf-8?B?dWc3RkJlUWdCdFJiWkpzbk45RzRyUzVadVhRZ2ZHMEN2d0c3ams2N0Q2Rnpz?=
 =?utf-8?B?TEFBTVl1RW5RbVY2WjV6Mmt1aWRQYUNXc0tPdm1WK3NuSWp0NDdyaS9URjV0?=
 =?utf-8?B?UlZXc0tUVHdaREM1Zit4aEtjZ2xzSExyME1UWjlIZmtyQnZ6dHB4Q3ZJL253?=
 =?utf-8?B?bkVZb0hqLzduOW5EWWIrZ1hWcEdIVnZ6aENKN1dHaGc4ekwvMXFVUERnOCtz?=
 =?utf-8?B?TXlqeFpKdityblkzVXNaV2J4YnMwVWJTSlhCeDE4TmNnbU1TSzFjSmJoUzla?=
 =?utf-8?Q?TOYE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f517831d-5524-43ac-ea6a-08dd04ff11de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:52:52.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fl9ib7iqRwolJNWXg+Auwzn9ixquKVwfarFWDQgeLNblKnGrRP2m9ec6sULXM3upzi3WumdCoI1pua+ABkOJcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9967

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: cassel@kernel.org
Cc: dlemoal@kernel.org
Cc: maz@kernel.org
Cc: tglx@linutronix.de
Cc: jdmason@kudzu.us

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: Add pci_epf_align_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/misc/pci_endpoint_test.c              |  71 ++++++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             |  99 ++++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  23 ++++-
 drivers/pci/endpoint/pci-epf-core.c           |  39 +++++++++
 include/linux/pci-ep-msi.h                    |  15 ++++
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |  29 +++++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 +++-
 11 files changed, 410 insertions(+), 4 deletions(-)
---
base-commit: f5373677e13177cfc7875f44a864f9a1db751df9
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


