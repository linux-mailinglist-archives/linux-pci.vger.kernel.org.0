Return-Path: <linux-pci+bounces-20501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA6A2131E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 21:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E62165AE0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 20:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD631DE88E;
	Tue, 28 Jan 2025 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j6sdhNb9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6413632B;
	Tue, 28 Jan 2025 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738095964; cv=fail; b=axHIZe6JqoLGZJuo8yrzOkgWzpb8jq2VtDn9WiZfLb+Xqi8Ssj1VbgAutAtdeQeEjsuNFY7lAldA4JFGa5GajQVHYijdrAHwACAD20XyxZlD0QaZCvFYKNnbwM3zjPtfMNw4IJ1SOUNifVxro9ppxQ+PpI7LGFk3V310umm6J54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738095964; c=relaxed/simple;
	bh=nG/Xyj3lwzBxe1fqiLjcCx5nFsDeY/CYzNbj8WgMU+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WsI0icqBlf9wfBw6DyJEw9eEuU/Gk/Ro2I7iuWS4C6ZWENeStnMjIa11Cgp8iGZYPoQpmG5cgZQOcmJLl0hNsilUA7QuufY3qbawI49Qi6PqsamIZoX8lv02XMlZxsXFFZWl4+XYq0OIYp5oBFy/nMMdfQJjEQeq+CiXZ7EYjuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j6sdhNb9; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKeLvp77BgTJ7Ch/ZfLOF6FOdqpzruNq+ypFr8hfChygRA0pUB2dqGDRWB7MNczrs7G4ENsf0cmz1Y/QmpXYJaeK+99HC3mD8dX1K9fLmKrEhjV/YAwYkVLOOID6eWNkhJGXj7aCRqvIYUqB5NTJTrQgBV7rlsqMesOrXMLJghoRV0ZwY4lDO9GfoT2amOWP4NmSu5Nd19Qnkt0qAkJJouenAvH8iLW6UXSmlJwDz/B5tvEeAlmM7uuggBD4ohSscewE27j+7fANME3dLnBPUS+R3BgxBdDZXbjYurqag9fOedVRhUe2/3q3DFnG6RvG2QMskgwjZpkkxuF2BGhPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFkKA6+zXLOsi9ByxOkpvYX96dZq3mscXkh0SJgX7y0=;
 b=dADu5r9SSWEUzNwAo6Rt3D3Tps5xAMi+A2Y5wt3OU4mKHWbXrGOUJDigCGSugkm1bm5/akmppm9F+8S/etW6QZKug+xZX+250v+UjAVs0Uh57CjlXG02kvEEMv6dvARWB1GI4Oul41PXr3Gf9+NwtrF7erMunHT3ZC7UZVprfukpwZQWeY8pdXbBH478GkBuQ8Bc3vWF+5DeSjzHjLCyipUi0z7OoxdO/xZbuz2RR8ABwdNi2IOxVmmunLmQ1mAvW1JoEAN9s1CWpyM5/0+RTdNQNK9xwyukFazJpuy8gmAeSJW7pBhkXL6ElyRr8YnK1nNygvVf5y6qoMbZa+VWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFkKA6+zXLOsi9ByxOkpvYX96dZq3mscXkh0SJgX7y0=;
 b=j6sdhNb92hkmcSxiE0zQmy1UTGGIHnPnksDMZIi+W7yh4z7j1a7/k5PoPuWwmX1CG1THDjVjS849SWZIip5rE2rMH/+Tuwy2mcO2pzOdexnkD59U9upSYrqgqbl95y0q+F02dz4nE2kOaJe0MNbnNn6Y8EfeqoKiWmq7AjwdoMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.18; Tue, 28 Jan 2025 20:26:00 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 20:25:59 +0000
Message-ID: <f9194caf-9dbb-4b2c-b4ac-71bdfda38dc5@amd.com>
Date: Tue, 28 Jan 2025 14:25:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/16] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe Port devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-7-terry.bowman@amd.com>
 <20250114113208.00006d08@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250114113208.00006d08@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:806:6f::22) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3d8918-4595-497d-0d46-08dd3fd9fa30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXRtODhXZ25FcEVvRUVLVWQ2NnpvMUJSWSt5OGt5bVRHU1FYQU5LVGdLNmd3?=
 =?utf-8?B?a3JIWUlUcDZBWE9BbHl6eHE2YXBFakhqYU93OWJsVk9lY0ZzelJMcExXNnlz?=
 =?utf-8?B?a1cwWHVEcGVNQmZiS2t4V1BQazI0SWk1ZFgxYTh1UG5jSmNiVmNzUXJiV2VR?=
 =?utf-8?B?aTByNmtmUy8zVGVJRTZKK1VPQnJNTnNodGZEUXFQQ0luR1ROSkRvUGVIV2Fz?=
 =?utf-8?B?dWtMZTgwQmxXcFcvSkJYNVV2L3hPbDB5R1MwQk51WGlPNnlvVmlkRjF6MlIv?=
 =?utf-8?B?OTV6YUZlMWFVa0JvS1dHb1hsMndTd0JMUXR0dEtMZCsyei91WHFGSTVWQzU1?=
 =?utf-8?B?QVdoWEJEdXorTG1BaVZ1b2JvSi81OTNwa05DMTA3OWZaOG0xaTFCeVg3L3hU?=
 =?utf-8?B?NGEyb1ZUNWFJZFF0ZjJYN3hOT2pqL0tiazJsNm9oTDdYbVBoalNtakpvYWlq?=
 =?utf-8?B?U2lCU0hkNkwrWDk5TS9uZGhPWEZ3a2NOMlNhSUQ5RUpiR3FvdVRkMXdQSkRl?=
 =?utf-8?B?TmY0SEptZ2FkcWRXd1BXN0RISGsyNkpNWklTUjZ1dC9xZitnTmtBQ1l2dWRY?=
 =?utf-8?B?L1lJN21IbVl5eWJ5SnkrUFhoaWZuQVVmT0NCSXRxREFRU1kwR05FTkRDR0VK?=
 =?utf-8?B?VGFZY25UWXdGWHNIZFF4Qk9oVVZzK3ZUS1lCTE4rVWRPUHBLU0w0dHY0U1FL?=
 =?utf-8?B?cWVLT2RkdzhFRURoUVJLTjR5R3liODdaQ1M2c084VUJ4Smc5Y2FRdU5YNDlS?=
 =?utf-8?B?Qmt0cWNzaHh5N2RkbWMzR3Flb2hpdHJyOENuREpZbWpUeHM2bE90dzcwRUdR?=
 =?utf-8?B?L3VEMHZQcUVuK0JLbmtnUVdOVk0za0czY2NRL1c5SCtzeHBmZ0loVlRLdlpZ?=
 =?utf-8?B?dGsxVkJrRUppR3owajNjVXdjOXorVVZDQmRhYzFaRkswaVJIU0JzSVVrak5W?=
 =?utf-8?B?QjFnRXo3M3BlYXpSdkRnZysxVVEvc09TUTI5SXZuY0x0MHlRVUxhR21CN3Qv?=
 =?utf-8?B?QmZWY2JuRUVPdCtxeFdJN3hDaDl5SXI1Tjl2Q1lxYUhYZG1XWXFGUXpwMGxF?=
 =?utf-8?B?dDI0c3ZwZnBLUGNEUm1iV3ZyS0dkeTkxMFMzMFN3WDNFMHhaVVVXMGxVY2Ix?=
 =?utf-8?B?VFlldC9XNjltdWNLTXYwVmJ6SnlxbWUwZS9TeFRVcEFmWDlUbFhFQlNrWXFL?=
 =?utf-8?B?Mk1SYjB4Rkx5MnZhZmNVNm5COVZWSi8xaWMxVm1RcEttZGgwZ0F0cVRmVlRp?=
 =?utf-8?B?a3Q0VDlXMkRkZDVrSEVMZHVOUUcyUXVRdGgvb1RubjBSd2lteUlDUFo5N1VS?=
 =?utf-8?B?QUtRWHU0eWZ5TDZCQ2tLaExMNlBvQkk0QW5sYW9HZ0VKTnhyYlFveEtNZG4v?=
 =?utf-8?B?ZVRjWlFud1o0Qmk0ZFowWnFTUFQ0TnVIcUFON2l5cFNSOUVhQkJ6bFV3NmJV?=
 =?utf-8?B?czhRalpocHJsSlhaOEpvQzBiT0tLYkdZUXJNcldtQkdRdVhSYmVnNmdxcXdI?=
 =?utf-8?B?bG1yQmJWcUlsaVJ0WkVKSDl3QmRjN1ZxUURTbFdNZGhUV3gzZFcxTXlEOVg3?=
 =?utf-8?B?N1VMdzEvK3hhcldhVVFVYS9OczZ0anF5Tnh5ZTlVeGlpQ3hjdUhXMFF5WG5B?=
 =?utf-8?B?THZkMVBRaS9nM0xnS0h6U3JxZE12VHlvbTJDUitxM0FKS0xFUXcyKzBkUWtF?=
 =?utf-8?B?R0tLaURoWnBRU28zREJaQ1ZuSXpoYUwxQTkrRmRXUGd6TCtRTDVaWUxDK3hk?=
 =?utf-8?B?dFZUaTduZit2b1dkZVh1ejNiUjdDNHkvRnJwbDVyY0dITTBvNVhyNU8xUVFS?=
 =?utf-8?B?S1RUbDZZc3dvalNPL3ZncStUMUpNWG9JM0FDVkcyWG51bVJDNlc3b0llOGRs?=
 =?utf-8?Q?kiyoBWDqikmbY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm40SzhmYW1FbUtEcEE3MXlFVE5yY0RWa0ZQOGxocWdnYkMxVWFKOVQ1T0FV?=
 =?utf-8?B?SlAwTWd0S2xwK1hOTDZvYVM3RU1kQ1d5cEh4UTFBYTJvc2dZeHM1L3M4cTNU?=
 =?utf-8?B?NjZ2L2RVMWNpM3NCWU9oVkVFeVg3K1JWTmlrcS8rcnJlbTZvSTNHdlZkYk9G?=
 =?utf-8?B?R24rTlEzZFRONjdnZSsvaEtHMWRIZ3d2K1ZJNWFvVVpUQVNKM3JUR3BTaDI0?=
 =?utf-8?B?czZ0RmdhWjgyRlNPUjNNam9pTElKNzRjNFBSUFpORHVBaC90RVh3UThHREVE?=
 =?utf-8?B?bVNWZE5yNTNIZmNvL2duQXA5RysydytjNVRFSWFZc1llN29rcWlxaVl5bDJl?=
 =?utf-8?B?TUNoS1JkRUFSMWRkckxzbzJNanA0MEJKZ1BpUS8rbENpYW96ZzRsNFFQUnRG?=
 =?utf-8?B?cG5oSG02TVdQZGlDN3pqQ1FITWRQNkNlNEkyU3kyTGtoRkhjODZPWEtqUWF0?=
 =?utf-8?B?L0VBLzczaHorNElreS9jOGNrTDBJWkhGQkVZa2pxeFVyOFRaQ2hGL0Z4SzNi?=
 =?utf-8?B?amRBRW5xQUYrWGZHZm9hQUxzTVRPb1lCcFp1TWlxZDRyc25tK1BuL3ZJOFlt?=
 =?utf-8?B?eFJmMGxjOFliUWJTdi9SbkNmU1I1bldSYkxCTDBFcHBxTXd1L2ppNDNoc3Vv?=
 =?utf-8?B?U3lYMkZpcE1kVDlGdzI4Sk01WjU2MGhOSDVRbjl4MEtRS09WY1JaUnB2bTNN?=
 =?utf-8?B?Y0lzZElNd2k1T2tRazJrTVpYSWVRb3V1RzRmd2g1VXRDby9rbEZybTN2UGg0?=
 =?utf-8?B?b3A0MUY3WUVGNE1PQi9kR2ZaQTVjSHlCdHdzQ0hLeFlLZHZZWlFOZnpEeWkv?=
 =?utf-8?B?bzY2R2dKeGM3MWVkb2FIUGxZd0J3eUk1cHlCNTJjZjJvNzRlc2hubURicDZq?=
 =?utf-8?B?WXlqQ3BvWEVhTzNDT29sVmNNRjBESHB6c3Y1eGZlZHVpZDRzYmpmOG4xZGFH?=
 =?utf-8?B?NUQ0cjRYa28yTUFuUjVUTHhrQ0xCZXIzRkFaSFFEbGhjMXVEK3QrdmJmVk50?=
 =?utf-8?B?ZjE1aUhOOHVhTHlqQy96L1ZGdGVySkZHS0h3ZEFPYm52WURpeS9kVk1vM0kz?=
 =?utf-8?B?NndINEZSUlplMDB2c1VtemE5V0JTTDBMRC9Zbm81YUZGR1FWU003VjRiZ2ZW?=
 =?utf-8?B?VnVQN3RFTTdJQnp1d000VWUwMjZIRUZ6T2RrK09PM2lZSHhQazRwK2hiTHZ4?=
 =?utf-8?B?ZFpSY1l2dzgxaWlWOUlqbGdFanFRTm5QdlVnc09uMUJSc2UwcUlNUWtYMTlH?=
 =?utf-8?B?VCt5Um1lRGpncmZRNVFzTmZpVG9PVVVmUFplMTI3MmxGM3BWUWNqWDV5TnBS?=
 =?utf-8?B?SnV3RGgxdTdpN0JaT3l3N2JQN2hpcmVnbVlnbWtpcVhVSEZDdy91dVFYYW0y?=
 =?utf-8?B?OXoyU0JzQkxNNUQ3cU85UHl5Q1liZS9CTmhGYnRiZ1BZQmJMUmgzWWZaTUF4?=
 =?utf-8?B?M0hTUFhQRjJFSkJzUWNWTVk3Mmxnc1Bic0J6ZFBqdUtyNzNqZS9Pbi9SYjdw?=
 =?utf-8?B?ZDRoQnlmcHJZZ0ZuNVZnRDdTM01YaFZyYWVDRkF3WmlCUmZiUFJpM1ZUWmNM?=
 =?utf-8?B?MWZ3VFN4dG9USXNGMGpyN3ZxYW0yL2ptbXBFb010dlJJTW4ybHI1UHkzK29i?=
 =?utf-8?B?QlI4ckIrYUhXZERSRlB3ZmdwekE4QWpWZ0R3alBBUmVKeWxLcjJCV245aVNm?=
 =?utf-8?B?N0hQZjlLaUdVRC9pMFVnajlpTWRBd1VsK0tZMjBIZWxmNUFRVFhrQXNrWHBG?=
 =?utf-8?B?NXNIaVJseVplSEwyUnJIY242eVVJVmtIMFU2ckdiOUtDSkt1QU1lYkluM0JU?=
 =?utf-8?B?bzFrZUw0VDE0M0JJQWtvRDhGakFoMDMyUUUzQ0M0akNuVFBXVnYwOHlQdEQv?=
 =?utf-8?B?MXBtZmViQ2RHTDNLelF4MnlnTnpzd1NQcXVjTEQ0NW9zRGpzbkdTbnYwbEl5?=
 =?utf-8?B?ZnE0TVZxelRwU3ZOcERCZUFPN0FRZXJTbGVuL0s5UHpmeXZtT2ZZMkQrd1l1?=
 =?utf-8?B?N2lqbzdWMENVbFRaejcxczdWSTFBQmtBbmFsWUtnSERLNHNMZW9OUndFMCtX?=
 =?utf-8?B?Mll4TXBkQlJ5RHNUOXpXYTBFeVhOZ1FPVVVMYUFpZmNlRWxoNHdRcEVJd29F?=
 =?utf-8?Q?+L/3/GP+poWVN7uGVICyj1Rtz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3d8918-4595-497d-0d46-08dd3fd9fa30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 20:25:59.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST7MvP9w6g0VduvvXBuFLlzN7E9lKSJC9G8VlxUosvZ/k+rhG53dornsxrJPUMqKccvdIban5hTlUNv7dZkLtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827




On 1/14/2025 5:32 AM, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 08:38:42 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER service driver's aer_get_device_error_info() function doesn't read
>> uncorrectable (UCE) fatal error status from PCIe Upstream Port devices,
>> including CXL Upstream Switch Ports. As a result, fatal errors are not
>> logged or handled as needed for CXL PCIe Upstream Switch Port devices.
>>
>> Update the aer_get_device_error_info() function to read the UCE fatal
>> status for all CXL PCIe devices. Make the change such that non-CXL devices
>> are not affected.
>>
>> The fatal error status will be used in future patches implementing
>> CXL PCIe Port uncorrectable error handling and logging.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> This clashes with Shuai's series adding link healthy checks.
> Maybe we can reuse that logic to incorporate the condition we
> care about here?
>

Hi Jonathan, et. al,

After looking at this closer and considering the situation I believe
we should remove this patch from the patchset and defer adding these
changes to log USP AER and RAS UCE.

I propose we reintroduce this later as a RFC or RFT in a future patchset.
This will give more needed time for testing.

The only downside to adding later is in the case of CXL USP fatal UCE. AER and
RAS will not be logged but this was the AER driver's existing behavior and as a
result isn't a regression.

Your thoughts?

Regards,
Terry

>> ---
>>  drivers/pci/pcie/aer.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 62be599e3bee..79c828bdcb6d 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1253,7 +1253,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>  		   type == PCI_EXP_TYPE_RC_EC ||
>>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
>> -		   info->severity == AER_NONFATAL) {
>> +		   info->severity == AER_NONFATAL ||
>> +		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
>>  
>>  		/* Link is still healthy for IO reads */
>>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,


