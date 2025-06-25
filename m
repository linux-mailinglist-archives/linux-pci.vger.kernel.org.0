Return-Path: <linux-pci+bounces-30657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A5AE8FA0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 22:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD555A3E23
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7042D8762;
	Wed, 25 Jun 2025 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FQEEonD6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2118.outbound.protection.outlook.com [40.107.101.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC020E031;
	Wed, 25 Jun 2025 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750884186; cv=fail; b=F7BNj0yTuZHxTpJQ9UAGHujZXItbaZkqBydVj4adSnhHDYpV61VMdXHa8I2Qeq820kepdU4EMvyLXPAWpq9ModRyDwYoyYVR8hQlmH5i8MWPRyNQy8SdaPkeIr0bpC97Z8fNsnAhzPksAwRHf4ygvp7OMRR1ShKJFwSz0dtwASY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750884186; c=relaxed/simple;
	bh=IgGIU3rg2sYhRNu6SaB8dPR82MdNrwuRzGHKF79EWdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=VGWkWA2011ZICVLMiSQOUAz1uqFe6T8Eq7v7jWblMy8va4YJlM09hTGONQptVjntq7FpjFj6J+bIVpLRUtJ0T3irXnIRmUrQ6RqOmFnp8YOwA7X+isOVYvRalXUM8zAEaxzXiFQGlNTcZwgcbWZsN75YlLT3DpeOln7IsPHmpFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FQEEonD6; arc=fail smtp.client-ip=40.107.101.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFyzZL+eP/Bpgu9/6MPlLJgq+Wx3Uu6P4BKGoawaD6lC60ns40hP1L3VVAcaA3FidY9W5DjTVu568j4TOtNjoHbAY0TMOw1TfkJT5vUoVTvYnkrrjqwkzPeq6v7e4p5aV9tndqpewegoLZjNGTeQp4YhNBa4H0jk0ARn4SjsJ//+Jxw+/4DtObZx+0BjgZLVijaDtyOtYNBFxyTBQpp0YbgQmi0pXeZoW6vtOQrDqyoOIctAWQ/WBZ9FOwHdqWaVZjyPuZwIMWUjNNYr6kwpjxlD9UlHGtDH2CdhtFpezUKD9lzkYM6A5zi8nhcSel31WoLyEWSo6BwTXYnSO9UKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ji/Q+Cl2MhmQnfxQowgBH5dHffmLJ/MyVx1UdBSfW8=;
 b=PSV1Q7TKWKhVFyKDh7uVCdptigFjvz7VtifBWOJFGG6Gnbv76Hfs+sUPgYe7EX4ZOK0nFAK29QaVJ5aTGC0A3f7ut3KTjJuB8wlS+twQNwa4x7J+mB4BACiOtqem8GaJdzBfZuVyy03lPEoQ1eihAt8tN5R8v9OttF9iftu54XNA9yu8rlmxjCdOup7zsKUS7aoNAAeN4Y1m0PPgVi2X9Uj86gFi6FTdMra1hI7DsELrjH6/M5ACXHZZPPdnH1wmtZ9eaiNe41f3Hv4Spz5hrZh4lgbL2TV8Q2uTfeqsRcI/0CMafVVp4tn95/jNm/fV/NGLZcMl/G0K0ogKpGyKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ji/Q+Cl2MhmQnfxQowgBH5dHffmLJ/MyVx1UdBSfW8=;
 b=FQEEonD6Z1T1hEO9124LpX9F3hygdChCrdUuSZpHn3gJULPFfYkC7WFJRVFJ4HeLut9zecZcP/z+zGcp1L39P76HxNUpCnHrdel4i2/5UHcrKFzu56cwU9GVEXI7Vm3FQ0nsMuH955Hz1lbAv3CjEHI2hZ+EsMbkGTliIBtfXg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 PH0PR01MB7927.prod.exchangelabs.com (2603:10b6:510:289::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Wed, 25 Jun 2025 20:43:00 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%4]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 20:42:58 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?utf-8?Q?Micha=C5=82?=
 Winiarski <michal.winiarski@intel.com>, Igor Mammedov
 <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Mika
 Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <e20e3171-7aa5-0646-7934-e6b10cdefc4e@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <86plf0lgit.fsf@scott-ph-mail.amperecomputing.com>
 <e20e3171-7aa5-0646-7934-e6b10cdefc4e@linux.intel.com>
Date: Wed, 25 Jun 2025 13:33:20 -0700
Message-ID: <86ms9vlfxr.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|PH0PR01MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 04191941-0e12-409c-ed50-08ddb428dec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FuOElMTXJjaFQrYkcyblU3ZlFjS3JkcDlpc0M0RUduMkRtbEUwL2dBRUxY?=
 =?utf-8?B?VGYxM0NTTERCdEdiSnJjODBIL3FiUTFVaS9OcUVhdlJYcVJVK0t3RHdJUk5S?=
 =?utf-8?B?NUEreFB1QnhCSmxlZ2lySDZaaU9ZOHMwa0ZFeVFKQ2JkdmZzZklpZzcyd3Zt?=
 =?utf-8?B?OWxXNkNORC9yQWZORnZmL2FLM0ZmU3MzZ0FnM3NQVjF3akkvSURoanBqSlM3?=
 =?utf-8?B?eFRvTWhzMEhiWWgrbVlYSDN3ejAxYm1wdG5HRFdJdTVTT2Zkc1BmWVp3TWFz?=
 =?utf-8?B?cmx3NjMxUGRZMEZrdjZic0MxK3drbU9RRlU0V3A5NW0vUWlZWmVaWGFhejE5?=
 =?utf-8?B?TmtmTXVSbHhONW12bWhGWkRZYUtxY0tRODJGZVQxTWVsYVp3ZmszZGxKMjVQ?=
 =?utf-8?B?YXc5ZllPZzhXcVhIek9YRk9pbThNWnIyc2Jmb2V0cG5RQS9HUDVzZTJrSVFx?=
 =?utf-8?B?aFVrZFJmUUs3VmM4T1hsSXR4L1JBOEU5WGV2eDdMbDFSQlBEdWpzc3o1KzlJ?=
 =?utf-8?B?ejNZNVF5dnNoU1VvU2lPY0FKU3NFOThrM0hjbE9iWk1PSzFVYnZobFNKTE1O?=
 =?utf-8?B?N1MwV2xtZ3ZaWGxqRnJodDQxUGF4dEpkU1B4OXlRdzNkNzZDeVhMZ1JIZHpL?=
 =?utf-8?B?UjZQeTdQZmFxSEVKZ2dQY3NFK09HbU81ZjQ4bFpTTHlxZEtncGtUUzEzUFdV?=
 =?utf-8?B?Ymp5em1iaDh2eVBpdmxlc01WNzhZc0wxdmZ5Q1dmc2NWVytZUHZvbUJxWmhk?=
 =?utf-8?B?M3B5d05aYm9qR1BXWHptbWNNL1liMmR4T28wTnpmcmFtamFjNVVhV2VhdUdt?=
 =?utf-8?B?dkxvSlFzRHZMUHVlZU1aNFRocVo4L0dQbEtnT2xHMHh3Y054bWN2dG9VeWpp?=
 =?utf-8?B?MkN5Z1pYMGRSU2FnZWF6YW9HUjdvV1dycThBdlJOalJxNmp0VDNiQzZLMFow?=
 =?utf-8?B?WlJnS0J3MFUwRUpYZjFKUkk2TW8zUnBBWm5URlBPeGRvNHhpcUdranlOZjhv?=
 =?utf-8?B?c0pkNEYxd1YxQi9sSXBnWEZNK0w5VVBJQ1lseHdIUTlFSHRSKzhjOS9OWmpl?=
 =?utf-8?B?bm4wWDFZUjRVU3JvazQ4WEJ5NkJkTWJVVU1jclVRdGs4eVRRVVlaQ2g1WTli?=
 =?utf-8?B?NTk4SXhhTmszRWdVNkVNVWlxVFZVaSttMVdLc0gxQUg4OHUxVEF2eFpUQVJU?=
 =?utf-8?B?OGYvUDJrLzFqb0JNWTJPMStpaCtTTHI1RjVtazlXRDJXQTAzc0J0QU1xbktx?=
 =?utf-8?B?M29rWlJyYmlYdmRiTmJFbkdNS3lreCs3T28yUnFjZEVQdXdiQ2JNczhZS3VF?=
 =?utf-8?B?YkVuczltK2grUVhCc1Q1TWgwcXJyWGx6d2lIR3BVVmVIeXZBMHlINjZBaGtP?=
 =?utf-8?B?eWplaUNZMk1ndzI2NFJuemlMbXFzbGlPNUFtRjN3K1JEVWI4RjZ2Um5CUytZ?=
 =?utf-8?B?cmxyWkNDSkhqMGxWd0ErV2pYSE5mL2VjMURkbm5NOEdVd2N5YytQTHVmd1NG?=
 =?utf-8?B?NzZUQVkyTXVTcGp3cXhjOXZPdU5Cc1dEc2t2VEhDSUwvWUdSRHBqcWFFSlMy?=
 =?utf-8?B?YTlCMEtBbENRRkhiQmhXdVZrR2o4NU1uZlkxRW1XSytIa09sSkRERGZzbUZv?=
 =?utf-8?B?eUlBbC8veFlycnZKck5QTnBvMWV1OWhKb3JoK2lTSWxWQWJtNTVuNVl6anRl?=
 =?utf-8?B?WXJUWW5FcTFENHBwRExqengyRFBVRC9rZkMzcTZXcmUvUDM1cm1sUW9Nd2F2?=
 =?utf-8?B?d3N4LzRSVWs0ZXJDVTZJTHp2SGNFUHdLS05zem1Mb250dkpWUE94cHF1RTl2?=
 =?utf-8?B?eUNpdW14MUJIT3VaR2VUSE95SEpZYzlkYTNmbklBb2dLZkltNXpSTmY4ZzRK?=
 =?utf-8?B?eGhWMCs0Rm5JR1hpWE03S1JaWWJuSzlVOGdjNENvN2dINm5YeUxuM0ZYbkJW?=
 =?utf-8?B?L2R5OFRUT0pucDNaT2l1UFJBbGNQcW1pY1pLcDlXYnBYOUhPclIvbkZkMHZu?=
 =?utf-8?Q?hXgKmCen6ccDevkSc0Wru0XqYavNKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di8zQSt6dUFwaGFXR3J1djN2UVM3YjM5N3RoUDZsb0xwWDBPTVFhM21maWJ2?=
 =?utf-8?B?Y3Q1aVlhV1FiK1hhSGFyRmxFZmdhOWdBeHFpcDU2QmN5L2MweDhPa1JEYi9N?=
 =?utf-8?B?N3pwbTJaZUFwWnQ5RlRFV1YyaFR0UEV5RWtZKzQ4V21FZlhHa2hkWFlLSW9j?=
 =?utf-8?B?bzlJMG9nVUpxVFhXN1FlS2ppbG1VR3FWQ1UyNHJFMWJyNGhXSHFsbkhSL2Nx?=
 =?utf-8?B?ZHNmVVR1ZFRuWWdSdThyYXcyZERkL1lXWWlOU3NMRWFiNzlzTHB6dkxmSGVh?=
 =?utf-8?B?Y3FWcnJRNkJ5SHIyWmpvcmNvL3hHTlhLN0VRVHptMjRLRkh6YzJwam41Mmhv?=
 =?utf-8?B?VHdscHorS1BZWFhjRW1ZY21TbXBjREdkNFZBODV3WVlUbS9BVHRWaFhJT1lP?=
 =?utf-8?B?Ly9BZUZoVE1NaytiSHY0c0dYcUtNSHFwMDh2ZmZkZmZkbDFmYWpqRE5EMGZq?=
 =?utf-8?B?WUhYcnJuc2dDRHlVT01mL3JjVkNzdjVSTkxvWDlETFlUTnozcWFaZEpabldv?=
 =?utf-8?B?c1g5WjFhN3NTemRCZUk0NzdLT01hdkFHd3NMcU1sRnliTlU3eWk4SDQrUzR3?=
 =?utf-8?B?S29SWkdTc2Z2SzZTS0xyVGRkWFRyWFhWclhlRWljSzdZcGtmckNRZG5QODl3?=
 =?utf-8?B?OXFTNFBDVi9xaGlRd2VnNmRkM2UrMTc1aXFHWkd5YTRXL2FyUDJFbm1kMmRt?=
 =?utf-8?B?SW1XUkFaNzV2UytGbGhIckJvUEh2bkVXaUVxYmZVQy9RKzJVcEVLK2JZSHVQ?=
 =?utf-8?B?Wk5PZCtjZ2RSNWZRKzZrUUtIODRyYllQZHhxM0o1OXp0KzRjREJpNVNEaFhQ?=
 =?utf-8?B?UXBLK3V2NXFFNGhzS05PbVVQUXliR3NGRU5MbVVqTXYxZFBpcUVESXlQVDg1?=
 =?utf-8?B?Vm5STytvaDB1N3ZhSWVSNjFrZCswRkVjQStpdkphZ0U3bkJ6WkVyd3NTVWhu?=
 =?utf-8?B?bVZmV3lYRDB2QUFZeWkvTElLSjhydjd5YkI4S2lWdFRIYytuZU5SQ0wvV1RH?=
 =?utf-8?B?MWhFRnV2eC9nL295R2JPVmpIS2ExM3d4ZWwvVFNuS1ZsN3c1NU9TR1NrU2RC?=
 =?utf-8?B?Nktwdmk1VTlQRFpQcmZ2K2FBYUVGRm1LREZPL3ovblYzSUJDUk1wUTlIWEpa?=
 =?utf-8?B?SkRLdHFOckNVelJJZEpKWjNLQ2tNd1d3d1NIV0FnL2Vic0FFWitJckNxckFQ?=
 =?utf-8?B?S0J4d3dtL2J1VlFDOHlDM2V4M0Iya1p2U08vT2lDUjNRMU1jNnNkZXVXUGhG?=
 =?utf-8?B?YlpqenN3d0h2dExoUHJrUUN6WGpyNWNiODlPVmV6Tk9MV0gzaXd5MFV6THFU?=
 =?utf-8?B?WGNqNUpZTUVuSXNDTDc1UEluenFtN08zQ3dhYThybEsrWndwSkovdGRVcHJa?=
 =?utf-8?B?OHVMR0VDNUcvdTk2Z1ZncUNCUjVPWXFOMTh2QXAvR3Y2VFRqRDBiMnVUUmF5?=
 =?utf-8?B?enFUMG4zWDl6SnZxb0Z3U2ZkaG5neDRERlBqREpSUlZaaW9MQ3VWcG1Pdkd2?=
 =?utf-8?B?RzJpWWViNWlhbldNdVg2dUVoV28yTGVYYXJ1SFp2Yk42c2R1aXZVdklRSUFK?=
 =?utf-8?B?Rzc3QWNwWDRjejRhUFZnL0gzVWZ5dGRIYVIwWWpRTXFBbFlsNUpzQ1hKRTdK?=
 =?utf-8?B?OTVuNHJac3htRzJ6dlN5TUZYS3p5eWdDT3ZRcStrcEhKTUladUIrQXBxYnFE?=
 =?utf-8?B?T25EZVJScUdHZk00ZjE5NkNSbXFuQlFXM0FjSE1LV29nS1NoYTBzSXVzUWNE?=
 =?utf-8?B?Z2dwYWsxZ2FsQ1I4UHNxT1FUaXVsZDV5aDVzd3U2VTNyYlAvbzBrQVloSTdy?=
 =?utf-8?B?a3QzS1FQdDNvQmZzcUV1bmtoTm9EWVgxN01KVE1BWkdlcGcwQ0ZxOTNMT1dB?=
 =?utf-8?B?UHRJc0h3ZHBPeHdiMjZSTXJRbzZJSktzUDBhQjZ1b3dyVXYvRW1RdWhwMWNK?=
 =?utf-8?B?SHYxV2RsckRyR2NEZzFGbDVyS3RNWjNPTVhhbEFDOFY2M2IwTHNxTnRWNmpk?=
 =?utf-8?B?bHNEeG1TNzVkaE9yWHBQMkIwd295cmt0RHpJUTFMQm9YL1hsVU1yTG9ITFhk?=
 =?utf-8?B?TGgvNlg4YzBxaE84YkJJY2pxY1ZQN1IwUUttNExad3FSeFRmWUtJU1RiRjEv?=
 =?utf-8?B?M2t6VjdPQzdzNUptOWZrenEvSTJFOXN5S292Y3YzL0taUFdreGUxMTNKaEZO?=
 =?utf-8?Q?WjQWAzUMZOv5+wtEO4SJxMs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04191941-0e12-409c-ed50-08ddb428dec7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 20:42:58.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ewy2b75twgerYMybPVyNr3Eh/2nIH5Aw6WEQtOhECn6TKeS3FaqFvkjeT7qMhIPsfEuVTMXx/tlxngR+BPHtbq/k5oqXDm36jpCcIgBKaRcMmMruEiWmUVZK/qtq45RN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7927

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> On Wed, 18 Jun 2025, D Scott Phillips wrote:
>
>> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:
>>=20
>> > Resetting resource is problematic as it prevent attempting to allocate
>> > the resource later, unless something in between restores the resource.
>> > Similarly, if fail_head does not contain all resources that were reset=
,
>> > those resource cannot be restored later.
>> >
>> > The entire reset/restore cycle adds complexity and leaving resources
>> > into reseted state causes issues to other code such as for checks done
>> > in pci_enable_resources(). Take a small step towards not resetting
>> > resources by delaying reset until the end of resource assignment and
>> > build failure list (fail_head) in sync with the reset to avoid leaving
>> > behind resources that cannot be restored (for the case where the calle=
r
>> > provides fail_head in the first place to allow restore somewhere in th=
e
>> > callchain, as is not all callers pass non-NULL fail_head).
>> >
>> > The Expansion ROM check is temporarily left in place while building th=
e
>> > failure list until the upcoming change which reworks optional resource
>> > handling.
>> >
>> > Ideally, whole resource reset could be removed but doing that in a big
>> > step would make the impact non-tractable due to complexity of all
>> > related code.
>> >
>> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>>=20
>> Hi Ilpo, I'm seeing a crash on arm64 at boot that I bisected to this
>> change. I don't think it's the same as the other issues reported. I've
>> confirmed the crash is still there after your follow up patches.  The
>> crash itself is below[1].
>>=20
>> It looks like the problem begins when:
>>=20
>> amdgpu_device_resize_fb_bar()
>>  pci_resize_resource()
>>   pci_reassign_bridge_resources()
>>    __pci_bus_size_bridges()
>>=20
>> adds pci_hotplug_io_size to `realloc_head`. The io resource allocation
>> has failed earlier because the root port doesn't have an io window[2].
>>=20
>> Then with this patch, pci_reassign_bridge_resources()'s call to
>> __pci_bridge_assign_resources() now returns the io added space for
>> hotplug in the `failed` list where the old code dropped it and did not.
>>=20
>> That sends pci_reassign_bridge_resources() into the `cleanup:` path,
>> where I think the cleanup code doesn't properly release the resources
>> that were assigned by __pci_bridge_assign_resources() and there's a
>> conflict reported in pci_claim_resource() where a restored resource is
>> found as conflicting with itself:
>>=20
>> > pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0x340017fffff=
f 64bit pref]: can't claim; address conflict with PCI Bus 000d:01 [mem 0x34=
0000000000-0x340017ffffff 64bit pref]
>>=20
>> Setting `pci=3Dhpiosize=3D0` avoids this crash, as does this change:
>>=20
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 16d5d390599a..59ece11702da 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -2442,7 +2442,7 @@ int pci_reassign_bridge_resources(struct pci_dev *=
bridge, unsigned long type)
>>  	LIST_HEAD(saved);
>>  	LIST_HEAD(added);
>>  	LIST_HEAD(failed);
>> -	unsigned int i;
>> +	unsigned int i, relevant_fails;
>>  	int ret;
>> =20
>>  	down_read(&pci_bus_sem);
>> @@ -2490,7 +2490,16 @@ int pci_reassign_bridge_resources(struct pci_dev =
*bridge, unsigned long type)
>>  	__pci_bridge_assign_resources(bridge, &added, &failed);
>>  	BUG_ON(!list_empty(&added));
>> =20
>> -	if (!list_empty(&failed)) {
>> +	relevant_fails =3D 0;
>> +	list_for_each_entry(dev_res, &failed, list) {
>> +		restore_dev_resource(dev_res);
>> +		if (((dev_res->res->flags ^ type) & PCI_RES_TYPE_MASK) =3D=3D 0)
>> +			relevant_fails++;
>> +	}
>> +	free_list(&failed);
>> +
>> +	/* Cleanup if we had failures in resources of interest */
>> +	if (relevant_fails !=3D 0) {
>>  		ret =3D -ENOSPC;
>>  		goto cleanup;
>>  	}
>> @@ -2509,11 +2518,6 @@ int pci_reassign_bridge_resources(struct pci_dev =
*bridge, unsigned long type)
>>  	return 0;
>> =20
>>  cleanup:
>> -	/* Restore size and flags */
>> -	list_for_each_entry(dev_res, &failed, list)
>> -		restore_dev_resource(dev_res);
>> -	free_list(&failed);
>> -
>>  	/* Revert to the old configuration */
>>  	list_for_each_entry(dev_res, &saved, list) {
>>  		struct resource *res =3D dev_res->res;
>>=20
>> I don't know this code well enough to know if that changes is completely
>> bonkers or what.
>
> Hi again,
>
> Thanks for all the details what you think went wrong, it was really=20
> useful. I think you have it towards the right direction but a more=20
> targetted seems enough to address this (this needs to be confirmed, pleas=
e
> test the patch below).
>
> The most correct solution would be to make all the resource fitting code=
=20
> to focus on the resources that match the type filter. However, that looks=
=20
> way too scary change at the moment to implement, and especially, let it=20
> end up into stable (to fix this issue). So it looks this somewhat band-ai=
d=20
> solution similar to your attempt might be better as a fix for now.
>
> In medium term, I'd want to avoid using type as a filter and base all=20
> such decisions on matching the bridge window resource the dev resource=20
> belongs to. I've some work towards that direction already which removes=20
> lots of complexity in which bridge window is going to be selected as=20
> there will be a single place to make always the same decision. That chang=
e=20
> is also going to simplify the internal interfaces between functions very=
=20
> noticably (but the change require more testing before I've enough=20
> confidence to submit it). That work doesn't cover this resize side yet bu=
t=20
> it should be extended there as well.
>
> So please test this somewhat band-aid patch:
>
> From 971686ed85e341e7234f8fe8b666140187f63ad1 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.int=
el.com>
> Date: Wed, 25 Jun 2025 20:30:43 +0300
> Subject: [PATCH 1/1] PCI: Fix failure detectiong during resource resize

detection

> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Since the commit 96336ec70264 ("PCI: Perform reset_resource() and build
> fail list in sync") the failed list is always built and returned to let
> the caller decide if what to do with the failures. The caller may want
> to retry resource fitting and assignment and before that can happen,
> the resources should be restored to their original state (a reset
> effectively clears the struct resource), which requires returning them
> on the failed list so that the original state remains stored in the
> associated struct pci_dev_resource.
>
> Resource resizing is different from the ordinary resource fitting and
> assignment in that it only considers part of the resources. This means
> failures for other resource types are not relevant at all and should be
> ignored. As resize doesn't unassign such unrelated resources, those
> resource ending up into the failed list implies assignment of that
> resource must have failed before resize too. The check in
> pci_reassign_bridge_resources() to decide if the whole assignment is
> successful, however, is based on list emptiness which may cause false
> negatives when the failed list resources with unrelated type.
>
> If the failed list is not empty, call pci_required_resource_failed()
> and extend it to be able to filter on specific resource types too (if
> provided).
>
> Calling pci_required_resource_failed() at this point is slightly
> problematic because the resource itself is reset when the failed list
> is constructed in __assign_resources_sorted(). As a result,
> pci_resource_is_optional() does not have access to the original
> resource flags. This could be worked around by restoring and
> re-reseting the resource around the call to pci_resource_is_optional(),
> however, it shouldn't cause issue as resource resizing is meant for
> 64-bit prefetchable resources according to Christian K=C3=B6nig (see the
> Link which unfortunately doesn't point directly to Christian's reply
> because lore didn't store that email at all).
>
> Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1@li=
nux.intel.com/
> Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/pci/setup-bus.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 07c3d021a47e..8284bbdc44b4 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -28,6 +28,10 @@
>  #include <linux/acpi.h>
>  #include "pci.h"
> =20
> +#define PCI_RES_TYPE_MASK \
> +	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
> +	 IORESOURCE_MEM_64)
> +
>  unsigned int pci_flags;
>  EXPORT_SYMBOL_GPL(pci_flags);
> =20
> @@ -384,13 +388,19 @@ static bool pci_need_to_release(unsigned long mask,=
 struct resource *res)
>  }
> =20
>  /* Return: @true if assignment of a required resource failed. */
> -static bool pci_required_resource_failed(struct list_head *fail_head)
> +static bool pci_required_resource_failed(struct list_head *fail_head,
> +					 unsigned long type)
>  {
>  	struct pci_dev_resource *fail_res;
> =20
> +	type &=3D ~PCI_RES_TYPE_MASK;

Is this meant to be `type &=3D PCI_RES_TYPE_MASK`? If not, then I think
the new `if` check below is effectively just `if (type)`.

FWIW, the patch in the current state is fixing the problem that I've
been hitting.

> +
>  	list_for_each_entry(fail_res, fail_head, list) {
>  		int idx =3D pci_resource_num(fail_res->dev, fail_res->res);
> =20
> +		if (type && (fail_res->flags & PCI_RES_TYPE_MASK) !=3D type)
> +			continue;
> +
>  		if (!pci_resource_is_optional(fail_res->dev, idx))
>  			return true;
>  	}
> @@ -504,7 +514,7 @@ static void __assign_resources_sorted(struct list_hea=
d *head,
>  	}
> =20
>  	/* Without realloc_head and only optional fails, nothing more to do. */
> -	if (!pci_required_resource_failed(&local_fail_head) &&
> +	if (!pci_required_resource_failed(&local_fail_head, 0) &&
>  	    list_empty(realloc_head)) {
>  		list_for_each_entry(save_res, &save_head, list) {
>  			struct resource *res =3D save_res->res;
> @@ -1704,10 +1714,6 @@ static void __pci_bridge_assign_resources(const st=
ruct pci_dev *bridge,
>  	}
>  }
> =20
> -#define PCI_RES_TYPE_MASK \
> -	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
> -	 IORESOURCE_MEM_64)
> -
>  static void pci_bridge_release_resources(struct pci_bus *bus,
>  					 unsigned long type)
>  {
> @@ -2445,8 +2451,12 @@ int pci_reassign_bridge_resources(struct pci_dev *=
bridge, unsigned long type)
>  		free_list(&added);
> =20
>  	if (!list_empty(&failed)) {
> -		ret =3D -ENOSPC;
> -		goto cleanup;
> +		if (pci_required_resource_failed(&failed, type)) {
> +			ret =3D -ENOSPC;
> +			goto cleanup;
> +		}
> +		/* Only resources with unrelated types failed (again) */
> +		free_list(&failed);
>  	}
> =20
>  	list_for_each_entry(dev_res, &saved, list) {
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> --=20
> 2.39.5

