Return-Path: <linux-pci+bounces-30793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81470AEA203
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495FE3B1C01
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA22EB5C7;
	Thu, 26 Jun 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eQozZ/ZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2107.outbound.protection.outlook.com [40.107.92.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AD2ECD0D;
	Thu, 26 Jun 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949636; cv=fail; b=ORF47SOtoir6bmNtiG1RaX8VuBvyzMGLfljlpbthKh8z32aaEewvVzLKIvqz1+AYVz82S84SeAoONMILEPJZaGoQiBrmW6e1nIQesJN+WIgLbn5Bnh1MkC2izhBqoED6mdEHvI9M3PNQkTTZLgs1StpOw+ZllFhBiJnacms4zdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949636; c=relaxed/simple;
	bh=+LBiafbO9WoSEcUQxNcx+bs6w+/YRa1toqZDPIPB6zI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=oyvLdh4e/oI9r1WyXYkh+uXZkxZB1y/BwMxfckuLNSKghSlxwHn7TTye8mRvA3skTR7oJkPL5pO0zFwd0f/oH1tS8I6iIqHV0ei7jkQaUW7Gj9XgC1t1G4gSxPXnpzZLwLOVnRpV4akg6+Cnc8Rx2F4BapeUqDfjB+alAz4cAsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eQozZ/ZB; arc=fail smtp.client-ip=40.107.92.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfS9uzxBvTPxKyQW5hMLZkFDBZ2MrQI0wyC+41fm0lxMBwktMIMc32/mlCc8d3kxm5TxoEPNxBJp7EsvHd3cvZE3Nwqwnqj5/DD9seZ03DYO2WXIXK/ceCKn6QPaGWwRC8is/G55Lp/Yk0rRaj9OW9UIZSRLtaiP7oCSH44e8uWA5NF+XJCbP1AWuA0H6DY36CH8CTd+xep6PBZV9gnUsldtignBl6dhDSOSmdjXMszqs4MTirYT9bUXUI7GbFCQfNzKuJ6vCy4NfY9qZpc3YYh0Y01qVWQEXIL/m79VC8/mBflltw45AFcYqjmPWtEf3yUwqmUIfIVfBCKEs9tr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxHvD8JEBa9G5hNTJk5sbent4kvSgL5Sqb8P5c8w2/M=;
 b=NNxfr4Aca/c/EOA5psxhzIK9egbgT262kFPdh1vNHc/dFca/N9OX7w67rkbHhnezJNXPNQVYgBjNeyf1i4TOoBTy0lUHw6aSNLl7uwsYgBi75BIWqDNe1eBDY0K7larlS64x5V3dwy/hp8L8/LcU7WFfpWdDBkih9hsRzhdO4s9BAPAp0fEZvyMJ1d7gnVor03J3E1ghWFD6x+gik4bXjXjmFIg9G75UGafeICsDWfER5zFhSN/6/+LQ1FWWs8q+5y7tWhtG93mgp10ob30UhBTnLrcuttgEcYzE9JvQnnHEZZIcYM0c19ccb3x9ttgmluNM1SA2VjlaaqUparVBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxHvD8JEBa9G5hNTJk5sbent4kvSgL5Sqb8P5c8w2/M=;
 b=eQozZ/ZBsqhfluSFTeljMxU/VkpcY9s+hn8W/Cm38uzAYiGdOFQtajjILxNFqtHHutZJ8QzstctDQ/MCAt7T46Vkk8QFY0zPHYK8GKyx1Vq/Nbj1EcTRo9Ty/k52KEnG1AhUPdI5xKYf/6eFL8BmtBjdrbfyDyMGmJLn36MCpgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 CY3PR01MB9248.prod.exchangelabs.com (2603:10b6:930:100::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Thu, 26 Jun 2025 14:53:50 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%4]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 14:53:50 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?utf-8?Q?Micha=C5=82?=
 Winiarski <michal.winiarski@intel.com>, Igor Mammedov
 <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Mika
 Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <8f5e28dd-9e21-0381-5b32-0850f9f039ca@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <86plf0lgit.fsf@scott-ph-mail.amperecomputing.com>
 <e20e3171-7aa5-0646-7934-e6b10cdefc4e@linux.intel.com>
 <86ms9vlfxr.fsf@scott-ph-mail.amperecomputing.com>
 <8f5e28dd-9e21-0381-5b32-0850f9f039ca@linux.intel.com>
Date: Thu, 26 Jun 2025 07:53:45 -0700
Message-ID: <86jz4ylfk6.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|CY3PR01MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b72e64e-5b58-41e2-8184-08ddb4c142d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWFjVnVlY00zOTlrMVorejQ5aStCQmphYXZWVWhWVHd1UklYaDd3NjNKemdX?=
 =?utf-8?B?d1dEZkpSMzVMQ2VSSTV1aUtrRk1oUFVCNFJRaGdlcWJnYjRDR08rRGd1TGNC?=
 =?utf-8?B?MlJaRWJkckF4ZnRscTJRcVVIU1VCanN4bGJnZ3oydmQzRVRsQW9ueTBaQ3g1?=
 =?utf-8?B?VHFjencxd0QwSW5yNGtjdWlXTkk1dVlTWXU4dXkzbmxrSThGdTVELzhudXhO?=
 =?utf-8?B?VFBpclBEdm9lNXZXUk1KNTMxdW9nZDJEYjk5dkZuZEp6dUlEaS81Y3huZXU4?=
 =?utf-8?B?NzJYaDVoSVpJT2tvM0JQWXA1TXNqNDJZVDd2YlM1ZnZSMUVGT3R6aENlM21H?=
 =?utf-8?B?eHhrRWJLZ3FMWkJjWEpQUWk5ckpKNjdxNnpGeTUzRHI2VC94UEczTDZ0dnJv?=
 =?utf-8?B?eGpObzEyNG4vNlRuamg2cWpTMWFvM1Y5Tkw0aDBpVS9XdHhyQ0g2NG1xaVB6?=
 =?utf-8?B?M2Rrd0xOakZBVm03L3RpRkR1MytXRGdKdEV5cjBzNkxuSE1oWWtUeHg0ZGVD?=
 =?utf-8?B?aWU5dVJXRnFITktqa0tGakZ2RlVKckR1dk9GSFV4MWhWbG5jRHpGR1ZDSHFK?=
 =?utf-8?B?NExGYjJ6R0FxTWVrZGhPQUNaVHNFVTFzaDBlOXFPUU5JalE3WjBDSzhtZFI2?=
 =?utf-8?B?eE9WbUlEZnhoNlVEamZpcWh6WnJVYS9lN0YwaXoxVEQzZERCTTRTVS9QQnJr?=
 =?utf-8?B?d0psby9Hc3ZpWkhCUDBhbUE5Q3paZXBuYUpUNXlkdXJNK0lXM09kOVJObCtl?=
 =?utf-8?B?dUUrRVZSVVh5UDIzRzE0TnpJaTJDdFJBMm9YeEVmSjZPZ2dUTTF4MjAvYmZo?=
 =?utf-8?B?bmIyUnd4aVRhTDg1cVozRTdndG1nai9KVm10MlZ4RU9UU3FoQU1zcElJdUti?=
 =?utf-8?B?YThUWmZaY3NLZlcwWW11ZzkxTm8yZithYzI4TlBTN3o5WGROVGpXYnFuelBu?=
 =?utf-8?B?NFdMZW9yRHdESUdDSkRibWJHZGt6a2dlaENta3JBUElkL2phWmdRZGdxTHE3?=
 =?utf-8?B?UDVDRVJUOXdKUlJ3Q05pZW0yV2lTWGVRMXRNMnV0UW5YeTRKenk1c1JmeDlF?=
 =?utf-8?B?Mno4ditYV2NwSFBWemtKWGhBMUpPY0lDYWZRdy83SUpuSjVrZ1UvcksvaGVj?=
 =?utf-8?B?MkcvcDNvYTd0UjhSYW9BSUhuMXdZR0hLOUlFMFFPV0pKS0tra1N0Z2d4MEVi?=
 =?utf-8?B?WWtiWDJmWktlNy9nRVgxQnpBY3ozc1VhbXpOdEQvVGRzT0syUlIrdmVxWGlN?=
 =?utf-8?B?Zk9WUkdySDBkbFlnS1F3bUtBZVE0UjlJeTV3aHZ6MWU4bndweEl2S2xHUGVX?=
 =?utf-8?B?cThpdnhLMzhyOGdOeitCTTZGZW5EM0N6MkVmY2d3WjZvdGNzckhYck5hSVFz?=
 =?utf-8?B?aTZiRUt2MXlqOUg4M1hOYlVrLy9yN0lIVFVzNmQvamFhNnljSmdOdzFnZm9J?=
 =?utf-8?B?ZHh2N1NsT3VEWDlPS2JLVVFRa2F3S3hJMkd2TzBuK0NaeDhjSlROWW1obnc2?=
 =?utf-8?B?dnNtYmoxZFJQem9IL0M5bzJpOEpYWnhEWm1Ib2tyRWY2aDhLNUNTb2doU0tU?=
 =?utf-8?B?Q1RIK2xSWmdGMEovcGYrREpNSXFybm9veU9oUlEyT0NWaFMrTElDR3RvZk14?=
 =?utf-8?B?Y3p2bTdtQk5EaFdBVXllbmxJcnJlME11VlVwKzNCQjZWZFV1S25VNkdWZVJo?=
 =?utf-8?B?U1UvSWg4ejFBTnQrRTFWQm5iSnJlMTdkWVM0am91a0J6TWdPNGVoRVozRjQv?=
 =?utf-8?B?MVpzanU2eDFjMlplc1JPUW5Za01SYnJCNVN5dDdlWm54ZXpJVjQxdTZYSXhy?=
 =?utf-8?B?dDBMR3c1REk3Q1hET3RqZlFqQ3FxcTk1b0xMTzlnS1JGMi9HdlRySDhlbTlT?=
 =?utf-8?B?bVNRbUtwRlc2eWJyd3ZHUjFnSGlzTEJkajhQenloUnFHd3RrTEVWMjFrSFRJ?=
 =?utf-8?B?Z1UyNUZwejNidm5WdjZKV3NGY0U0N1NtdGE5ZVMyY09qdk5Od3pjVVJEV3Mr?=
 =?utf-8?Q?X2ARGTt8J7fxwXgSFQ5awuJrVGJL5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnIyd3lEaGoxVTZ0Z2JKcXNVSU1lbzZqRWhwaHdtRlFxeXFxQU1YNU1jSXVs?=
 =?utf-8?B?ZmhIWTlNVXZMUkt5Vi83aGNXODFNaEJaazlvbnFkaFE5b0pBMjJlMWFydnRi?=
 =?utf-8?B?SUZUcmdTbWNDWGFmZERrcG1qWnAvT2N2L1h6TVBmNHd0eVQxeittMEJyVmRu?=
 =?utf-8?B?VVJ0cVhuNDFlRTM4U0thMjU5VExBME9qYWpmZVVnVzQ0aEpkT2Q0dmUvMENn?=
 =?utf-8?B?bXRHMVRicStZWVlrYkdMazhVUldua09SemM4bG5KQ2pxZVBDNWdYMnpXTEFM?=
 =?utf-8?B?SUhtZFRDM0lCSUJFT2lYUHdzOHEzOFZqb05LSHhJSmIxSXBxdXdwS0llbjZR?=
 =?utf-8?B?cUJIU1FycjNjSW12RU5Jekw0bnV1OGVRQ1p6WHZVZjZWL1NldjZEY1luaG85?=
 =?utf-8?B?cHNhNUk5cGJaVDVOLytQQXdtZmd5aGFqZzlnaGZPdEludjY0WVFuakJDQ0VY?=
 =?utf-8?B?WVkvSDNJeHdFOFZ0RnNrdjNnTms5bVFnbnpHTjVJWTlVcnlDb2NtMys3WnZ0?=
 =?utf-8?B?WmVhY0ZJS0hPdlBmb0Y0VHdvdjJkNTMxN3dOamVDTzhveUsvcVl3TUJ5SVJJ?=
 =?utf-8?B?SWw2ZkpaZ0JHcVYwRmxQVWRKVVFjTGM0YWc3ak1ZNnVrZFBUSDVjSnhnc0ta?=
 =?utf-8?B?Rm5TNFdhK3pEMjRBRVlYTExMdGk5TysrUDZNLzF2UVRVa0drbXZnZUt3Rllk?=
 =?utf-8?B?R1UwNTJaY3ppcmlxQ0laRmJVVTFYeVl5YUZ0LytqOXFmbFVrVEtVN28yNWdS?=
 =?utf-8?B?VlVnSDhlVFAxN0FNRDZYVzJqSVdKUmtQZjRDbFhMT2hZbThRbmhIeUlVRGRV?=
 =?utf-8?B?aUg1QnhQaHRORkM0QW43ODFYRG85ZjFzMlI1OGdGSnVkOXJMWnNSVEVFSkNS?=
 =?utf-8?B?d1Y0dlA5K2NTMjZqUXkwZFZqM2R3WFFCVVJ1RFRybmRnRG5rQ1hHeC9XV282?=
 =?utf-8?B?M3hNb2tidmFVSGx0R3NYSG14ZEVOMTlaODZXL2xNbjFENE9vdmZ3UnpGeHBt?=
 =?utf-8?B?TlFYSmNvYkR6Y1VrRXNBd0c0YUcxdkFmRDFRSnhIdXR0RFJlM1JLSlA4SjRN?=
 =?utf-8?B?MEJkaWVwdzByMnVkb3Z5ODVHVkZocjlXMW9PMjg5eVhwc2FwdFN6enVLcXVa?=
 =?utf-8?B?NzdMODlHclBOU3djZVlkakxJcjVMalhmTWNpV1dYN1ZQUkhkYURsbW9Gck01?=
 =?utf-8?B?QkQ4bVJ6NC9VRDBmUzNDTENKendHRWoxMTZEc2VZSWZBd0hXOEpDZFF6VUxI?=
 =?utf-8?B?UDBod1BJQ0ViaXZCb1IyZ1crSHJ1Q1RRN0Y2UTc0YXFVQXFTeEVBYWF6M1Bj?=
 =?utf-8?B?bTdGRGRRV1VkRFpMckRTMGVVYkhiMkMyTUJpVVA3QjdERHJZNXorUVZMWUta?=
 =?utf-8?B?Q3JhLzNvMm1nSi9KUlFOQ0JnRWVITzZuMDcrRUV1UlF6ZDJxTUpKNklndmVL?=
 =?utf-8?B?blpSazNjbm9tTGZZNWNqcWVyTnpxZEVpbmlaVzJCM3h1L2pDczkvTDc2dG9h?=
 =?utf-8?B?eWNESW1iRExSbFdRcjFJZXNTdHhZMUFmdjlRa3RtWWJsN2lmU0xzUzhXaVN0?=
 =?utf-8?B?TExWNHFRUU5jNFJLTDN5OHNONjgzOVYwZnc3RnNaVHY5Z0lISzUzNEpDRThZ?=
 =?utf-8?B?SXNuWDdmWS80bXM1dldaaFNVazVxS1RFcmlRbUN5Ti9xTmFwdnRXYmRidmZS?=
 =?utf-8?B?R001Qkx1TEhqTWliUUNISzNvb1BpNEF4Uy91SDBMUzZ4cDQ1SXRPNzkrdnZ1?=
 =?utf-8?B?d2xzYVRVaVY3MWFtL3ZpYnI2S0FSMG5LSXV3cjI4WExac3hHNUZJZkN4NTZD?=
 =?utf-8?B?elltbEV0MDRVaHVtbUEwRi8vMERFTDVCUDRFWUZkK3lGMmU4aFJwbnVXS1VZ?=
 =?utf-8?B?TUpteVBJazZlZ2ZGdDBjL1YxekhYUUdjVGlKajFCaGE2dks1NDFiZ09FMW53?=
 =?utf-8?B?TkhhT21uNXh0ZUd5OUwrdlR1VStJNGNoTGFkQ0RhNDVaaW5JQ25Kd0tvMWJk?=
 =?utf-8?B?bjQrbzJVWk1mMDFnaTErNVhVSTV6UzBEUVpHeUdvZVc4aDA5eSt4Qll4R2tF?=
 =?utf-8?B?bnZrWW1WM2libWk2cFJjM1NhOWpKUS9hdGJJWmh3MS9LM2xVL2lYMXY2a0Nq?=
 =?utf-8?B?Z2krTDdXbGJETVpwUjBSWWhsRUhRaFdDdWJHUCtwQWNyUi9Qdk16VW1VUGhN?=
 =?utf-8?Q?tuyk41K+VsTDIYRW6V2w0t0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b72e64e-5b58-41e2-8184-08ddb4c142d6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 14:53:50.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAKV03+QBTuUAu5ScTuJb6+NlEiQn/y/n7oHEMs1Zs5pXZper4Vw9oLygMpZzMmAuGNOh3bAdyMabOcrtn8jysn9DsN4lPB/+jTeJcyw6GeRvhr0Sz7AG6AIavmOYeUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR01MB9248

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> On Wed, 25 Jun 2025, D Scott Phillips wrote:
>
>> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:
>>=20
>> > On Wed, 18 Jun 2025, D Scott Phillips wrote:
>> >
>> >> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:
>> >>=20
>> >> > Resetting resource is problematic as it prevent attempting to alloc=
ate
>> >> > the resource later, unless something in between restores the resour=
ce.
>> >> > Similarly, if fail_head does not contain all resources that were re=
set,
>> >> > those resource cannot be restored later.
>> >> >
>> >> > The entire reset/restore cycle adds complexity and leaving resource=
s
>> >> > into reseted state causes issues to other code such as for checks d=
one
>> >> > in pci_enable_resources(). Take a small step towards not resetting
>> >> > resources by delaying reset until the end of resource assignment an=
d
>> >> > build failure list (fail_head) in sync with the reset to avoid leav=
ing
>> >> > behind resources that cannot be restored (for the case where the ca=
ller
>> >> > provides fail_head in the first place to allow restore somewhere in=
 the
>> >> > callchain, as is not all callers pass non-NULL fail_head).
>> >> >
>> >> > The Expansion ROM check is temporarily left in place while building=
 the
>> >> > failure list until the upcoming change which reworks optional resou=
rce
>> >> > handling.
>> >> >
>> >> > Ideally, whole resource reset could be removed but doing that in a =
big
>> >> > step would make the impact non-tractable due to complexity of all
>> >> > related code.
>> >> >
>> >> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> >>=20
>> >> Hi Ilpo, I'm seeing a crash on arm64 at boot that I bisected to this
>> >> change. I don't think it's the same as the other issues reported. I'v=
e
>> >> confirmed the crash is still there after your follow up patches.  The
>> >> crash itself is below[1].
>> >>=20
>> >> It looks like the problem begins when:
>> >>=20
>> >> amdgpu_device_resize_fb_bar()
>> >>  pci_resize_resource()
>> >>   pci_reassign_bridge_resources()
>> >>    __pci_bus_size_bridges()
>> >>=20
>> >> adds pci_hotplug_io_size to `realloc_head`. The io resource allocatio=
n
>> >> has failed earlier because the root port doesn't have an io window[2]=
.
>> >>=20
>> >> Then with this patch, pci_reassign_bridge_resources()'s call to
>> >> __pci_bridge_assign_resources() now returns the io added space for
>> >> hotplug in the `failed` list where the old code dropped it and did no=
t.
>> >>=20
>> >> That sends pci_reassign_bridge_resources() into the `cleanup:` path,
>> >> where I think the cleanup code doesn't properly release the resources
>> >> that were assigned by __pci_bridge_assign_resources() and there's a
>> >> conflict reported in pci_claim_resource() where a restored resource i=
s
>> >> found as conflicting with itself:
>> >>=20
>> >> > pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0x340017ff=
ffff 64bit pref]: can't claim; address conflict with PCI Bus 000d:01 [mem 0=
x340000000000-0x340017ffffff 64bit pref]
>> >>=20
>> >> Setting `pci=3Dhpiosize=3D0` avoids this crash, as does this change:
>> >>=20
>> >> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> >> index 16d5d390599a..59ece11702da 100644
>> >> --- a/drivers/pci/setup-bus.c
>> >> +++ b/drivers/pci/setup-bus.c
>> >> @@ -2442,7 +2442,7 @@ int pci_reassign_bridge_resources(struct pci_de=
v *bridge, unsigned long type)
>> >>  	LIST_HEAD(saved);
>> >>  	LIST_HEAD(added);
>> >>  	LIST_HEAD(failed);
>> >> -	unsigned int i;
>> >> +	unsigned int i, relevant_fails;
>> >>  	int ret;
>> >> =20
>> >>  	down_read(&pci_bus_sem);
>> >> @@ -2490,7 +2490,16 @@ int pci_reassign_bridge_resources(struct pci_d=
ev *bridge, unsigned long type)
>> >>  	__pci_bridge_assign_resources(bridge, &added, &failed);
>> >>  	BUG_ON(!list_empty(&added));
>> >> =20
>> >> -	if (!list_empty(&failed)) {
>> >> +	relevant_fails =3D 0;
>> >> +	list_for_each_entry(dev_res, &failed, list) {
>> >> +		restore_dev_resource(dev_res);
>> >> +		if (((dev_res->res->flags ^ type) & PCI_RES_TYPE_MASK) =3D=3D 0)
>> >> +			relevant_fails++;
>> >> +	}
>> >> +	free_list(&failed);
>> >> +
>> >> +	/* Cleanup if we had failures in resources of interest */
>> >> +	if (relevant_fails !=3D 0) {
>> >>  		ret =3D -ENOSPC;
>> >>  		goto cleanup;
>> >>  	}
>> >> @@ -2509,11 +2518,6 @@ int pci_reassign_bridge_resources(struct pci_d=
ev *bridge, unsigned long type)
>> >>  	return 0;
>> >> =20
>> >>  cleanup:
>> >> -	/* Restore size and flags */
>> >> -	list_for_each_entry(dev_res, &failed, list)
>> >> -		restore_dev_resource(dev_res);
>> >> -	free_list(&failed);
>> >> -
>> >>  	/* Revert to the old configuration */
>> >>  	list_for_each_entry(dev_res, &saved, list) {
>> >>  		struct resource *res =3D dev_res->res;
>> >>=20
>> >> I don't know this code well enough to know if that changes is complet=
ely
>> >> bonkers or what.
>> >
>> > Hi again,
>> >
>> > Thanks for all the details what you think went wrong, it was really=20
>> > useful. I think you have it towards the right direction but a more=20
>> > targetted seems enough to address this (this needs to be confirmed, pl=
ease
>> > test the patch below).
>> >
>> > The most correct solution would be to make all the resource fitting co=
de=20
>> > to focus on the resources that match the type filter. However, that lo=
oks=20
>> > way too scary change at the moment to implement, and especially, let i=
t=20
>> > end up into stable (to fix this issue). So it looks this somewhat band=
-aid=20
>> > solution similar to your attempt might be better as a fix for now.
>> >
>> > In medium term, I'd want to avoid using type as a filter and base all=
=20
>> > such decisions on matching the bridge window resource the dev resource=
=20
>> > belongs to. I've some work towards that direction already which remove=
s=20
>> > lots of complexity in which bridge window is going to be selected as=20
>> > there will be a single place to make always the same decision. That ch=
ange=20
>> > is also going to simplify the internal interfaces between functions ve=
ry=20
>> > noticably (but the change require more testing before I've enough=20
>> > confidence to submit it). That work doesn't cover this resize side yet=
 but=20
>> > it should be extended there as well.
>> >
>> > So please test this somewhat band-aid patch:
>> >
>> > From 971686ed85e341e7234f8fe8b666140187f63ad1 Mon Sep 17 00:00:00 2001
>> > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.=
intel.com>
>> > Date: Wed, 25 Jun 2025 20:30:43 +0300
>> > Subject: [PATCH 1/1] PCI: Fix failure detectiong during resource resiz=
e
>>=20
>> detection
>>=20
>> > MIME-Version: 1.0
>> > Content-Type: text/plain; charset=3DUTF-8
>> > Content-Transfer-Encoding: 8bit
>> >
>> > Since the commit 96336ec70264 ("PCI: Perform reset_resource() and buil=
d
>> > fail list in sync") the failed list is always built and returned to le=
t
>> > the caller decide if what to do with the failures. The caller may want
>> > to retry resource fitting and assignment and before that can happen,
>> > the resources should be restored to their original state (a reset
>> > effectively clears the struct resource), which requires returning them
>> > on the failed list so that the original state remains stored in the
>> > associated struct pci_dev_resource.
>> >
>> > Resource resizing is different from the ordinary resource fitting and
>> > assignment in that it only considers part of the resources. This means
>> > failures for other resource types are not relevant at all and should b=
e
>> > ignored. As resize doesn't unassign such unrelated resources, those
>> > resource ending up into the failed list implies assignment of that
>> > resource must have failed before resize too. The check in
>> > pci_reassign_bridge_resources() to decide if the whole assignment is
>> > successful, however, is based on list emptiness which may cause false
>> > negatives when the failed list resources with unrelated type.
>> >
>> > If the failed list is not empty, call pci_required_resource_failed()
>> > and extend it to be able to filter on specific resource types too (if
>> > provided).
>> >
>> > Calling pci_required_resource_failed() at this point is slightly
>> > problematic because the resource itself is reset when the failed list
>> > is constructed in __assign_resources_sorted(). As a result,
>> > pci_resource_is_optional() does not have access to the original
>> > resource flags. This could be worked around by restoring and
>> > re-reseting the resource around the call to pci_resource_is_optional()=
,
>> > however, it shouldn't cause issue as resource resizing is meant for
>> > 64-bit prefetchable resources according to Christian K=C3=B6nig (see t=
he
>> > Link which unfortunately doesn't point directly to Christian's reply
>> > because lore didn't store that email at all).
>> >
>> > Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1=
@linux.intel.com/
>> > Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
>> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>> > ---
>> >  drivers/pci/setup-bus.c | 26 ++++++++++++++++++--------
>> >  1 file changed, 18 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> > index 07c3d021a47e..8284bbdc44b4 100644
>> > --- a/drivers/pci/setup-bus.c
>> > +++ b/drivers/pci/setup-bus.c
>> > @@ -28,6 +28,10 @@
>> >  #include <linux/acpi.h>
>> >  #include "pci.h"
>> > =20
>> > +#define PCI_RES_TYPE_MASK \
>> > +	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
>> > +	 IORESOURCE_MEM_64)
>> > +
>> >  unsigned int pci_flags;
>> >  EXPORT_SYMBOL_GPL(pci_flags);
>> > =20
>> > @@ -384,13 +388,19 @@ static bool pci_need_to_release(unsigned long ma=
sk, struct resource *res)
>> >  }
>> > =20
>> >  /* Return: @true if assignment of a required resource failed. */
>> > -static bool pci_required_resource_failed(struct list_head *fail_head)
>> > +static bool pci_required_resource_failed(struct list_head *fail_head,
>> > +					 unsigned long type)
>> >  {
>> >  	struct pci_dev_resource *fail_res;
>> > =20
>> > +	type &=3D ~PCI_RES_TYPE_MASK;
>>=20
>> Is this meant to be `type &=3D PCI_RES_TYPE_MASK`? If not, then I think
>> the new `if` check below is effectively just `if (type)`.
>
> Yes, it should have been without that ~. Can you test the change with=20
> that changed? I'm sorry about the extra trouble.

Hi Ilpo, no trouble at all, and thanks for your effort in fixing this
case. With that change to ~, the patch keeps working for my case.

Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
Reviewed-by: D Scott Phillips <scott@os.amperecomputing.com>

