Return-Path: <linux-pci+bounces-21531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C648AA3689D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 23:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05F7172B85
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E71FDA95;
	Fri, 14 Feb 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePdBhkrc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42D1FDA93;
	Fri, 14 Feb 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572965; cv=fail; b=L6t5GQN/u7unoNUx0wcLjd3KP2jp3b21sUCUxzlnmoP5TuiiXDmnLf6gttMp+s2T37CVj8O9SGpOAfsJpbPbOeAN5hCvgHFe2l3HaifOyX2QbgUP+a1BWnASZA3yqmZE+akuPavjA9P0PK1UWFxHgnmM3nlV2ahRC/C4DEbd6MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572965; c=relaxed/simple;
	bh=FR6GVcchn3H5A0YQPoSKD3BSEKRzvLkCDgvfqla7ZTg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NMi8CEKDXZIlU63ckYnmDWz5G5QCd5+ZIq8y9284l0ccwjha6l7xaufCLEekZTHudfVJADBUqpoLONudtTunUBCK9UsiD3CjigvLqMyL0H/0F1ORylVi73NT9yxvK6tTOHS6HtdBYxRwLXIDYCobSRyjxOyGWo2Fe1PLo69Ig9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePdBhkrc; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739572964; x=1771108964;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FR6GVcchn3H5A0YQPoSKD3BSEKRzvLkCDgvfqla7ZTg=;
  b=ePdBhkrcvNTHL9kP696/YXy1hsRc3eCfN0xBBASH/bNnLziuqctgeoDR
   UftREUsfiuX9CW+BaLbNmFlz3XLeHPpbvyRWvyI8D6cWPPbr4VYdC8jY4
   lLgrIDC1HCrz3BNS4M3O7wZGybl/hU5u5TlkZ6XRzJsDjCP2atxlK9spk
   08w3dePXLqPlJr1dWN5A+9nOnk+tBwO8R2g1VeZGKNf8ratOhXmTqVSsB
   meHCdI3lstqelv6qf5odD6CapbWjwJdxHb/0EpdyGFTXbmRtNbpGnENi6
   gnbxM9hdgmQORebUhAEg/A9eY6emr7LeIUTrbQZ4vyMdbuEd/MOtYCBBR
   A==;
X-CSE-ConnectionGUID: BFEGEMTqTNGLBkq7vHPiNQ==
X-CSE-MsgGUID: cCGRUetYTdmDBFMDiQ8tPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57740857"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="57740857"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 14:42:43 -0800
X-CSE-ConnectionGUID: XPaqRY9MQxyg1lmjqjeXMg==
X-CSE-MsgGUID: JlCwH8hzQMOFjcArJvFHGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="144429438"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 14:42:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 14:42:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 14:42:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 14:42:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGw+VDT3hmv9nDseLsMZ1yOD10vzZynaKZgQ7PbJ1fDXbz3jgAIimSUPO5lx93X/GG1ETr8ikIXf+DWVWi6gETV2tH7n1gasDAkiay+c3w3u/HBcNP0AnVjS9igXrhXXjU+Y22h9zQ10Vb+Nkm0RBd0fkMPS4WdTniDX+AOE13H45wHQOJwsq8FSvSP1HRMEfkbWJ6cFIm8YSXK8XX8YrlxcZ0j4SQjOI/t/AXDbDHgS56kwv/jGcj4I4SCKMHncFY3DF9HBOqZK8S0pTqo8tsSU9X7LNWdrcGBVzfm9sEm0qk2LOso2wauxNI19Hdkp7mY313jD0TGe260lLfKe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1uqv+RJsXdgqRQU3ZMFdL72yI5N9PxgcsJYwc5M3Ss=;
 b=joy3LcQYIhGvojCinDrnHU9bXxX58MhonPjQs4p+QTM8TEF4QLahwgC8T2hL6/0V7BbJsVUUbpJRIXqBgNFqtdxoblaHHh+8nqOtSjDssFqc0nXSEMdFDEOKT8+wqnzqG2UuBdQfrv2gXNZ3pwOO43Bk4t1uNGrK5m63vj/9iZ8qHYvV+VR7H4qdD8EiQidayBXWKgy+UMU6Zhk595fvFU5XpOCEpxqLDvW4/DhDsjqYMctoWFwN/g/5G9qK3DGbi1pOkZssdfa8QAAKw1yAcwzS4VZ0mwtG+bkBtqdHov75xj4+Z5b2j6moKoJZxJx+Emymo95UhUxo6q/EQQ+qwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DM4PR11MB6406.namprd11.prod.outlook.com (2603:10b6:8:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 22:42:37 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 22:42:37 +0000
Date: Fri, 14 Feb 2025 14:42:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <67afc6d937c0c_2d2c294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-8-terry.bowman@amd.com>
 <67abf81f4617b_2d1e2946a@dwillia2-xfh.jf.intel.com.notmuch>
 <609a02bb-3271-4021-9499-8b281a959f62@amd.com>
 <67afb4955252f_2d2c294b2@dwillia2-xfh.jf.intel.com.notmuch>
 <ba21e8fd-831a-4215-9e4f-60b5036d63b0@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba21e8fd-831a-4215-9e4f-60b5036d63b0@amd.com>
X-ClientProxiedBy: MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::24) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DM4PR11MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 772d72d4-b170-4f07-1366-08dd4d48e14b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFp1SHpwVDNFd3UrZUowUE1PR1hIUjQ1ak1iRERZYTZ1REh6MEpMR3dSNlBk?=
 =?utf-8?B?VlZ2UWxpczR2TnR2L0VyYUFWM0IybDFoYUlhYnBTRkdhNENiMm0rNTNrb1hO?=
 =?utf-8?B?and3Z0ZzY3JuOEJuRjE2akErNFJmeDVjTEFsSi9tWW5VN2w0WEVvUHlPY1la?=
 =?utf-8?B?bnIxci9MYWtzTlRCd1RlN3NxbVFRUi91V0hkcEdDQ04wQVZIdDVjd1F4N2tm?=
 =?utf-8?B?OHNuTnl4WHRackdaYTZOb093SWRtYjlEOFdjVzNWSmJyWlMwUGwvbE5BYXBr?=
 =?utf-8?B?QlViSWxtNXVhdWNlVG81T2Z6MTFrVTNKWGs2bFFWUHhSNzBicklmcEwxWFZG?=
 =?utf-8?B?aFZXSVVtNnMxeHdyNy9GVmJNOHBKLzAvN0VlYUYzYU9rRUdObjFjdkF1ak9x?=
 =?utf-8?B?MlBGUVRuQ1RHNWxoSVJNTGtMWjY2YVczQnJldGY2MHdkL1FKUWhCQXgrWXN6?=
 =?utf-8?B?MTE4VFUvNjlUNkhVNUJJZjZJcFpielAva0FGK1pxM3JvY1p3KzlRMDhUR3dC?=
 =?utf-8?B?ODdjYWhLaENCNzZYZnJCTjVTZGNhMjRCZC9vaks5SzY5cjNCcUU2b3ZESTdH?=
 =?utf-8?B?V0ZwQzVKQ2FGUXl0Q05GYUpPQVBDUC9lOHNoNzFMUnR6dHp5MFhTSTloRkFZ?=
 =?utf-8?B?ZS9JaitrQlBvV2t2U3lvSVlrL0lCaDd2RWYrMkFCY2ZWUmRwdVA5Qit5OVdD?=
 =?utf-8?B?MW9Ra1NCMXY5cFY5ZlA2RDMrR2p1WkNWZkwrVFJuNmZNTkxHV0JlWnN6NGl5?=
 =?utf-8?B?NW9zbk43dE5YcVAzN1Y5L3FFMG5zQjlscVFYZUh5TFdRQkRnakVVVGNranpt?=
 =?utf-8?B?MnN0Um9tdjR1Qnp0L2hCWEVSYXVVZ2M4MkVadnMxRVI1bVg3N1FKdWJlbmtC?=
 =?utf-8?B?bEZnR2hxcUQ2WEFKcXpJQU8wTjJ5WEtQVFNZd0FIT2RjbnNBayt3R0ttczZM?=
 =?utf-8?B?MFlYdlU3VEM3cGRtTXNrMGYrcGlvR1QrUzJQc2JCZVVzVnVjb2tkWDJBRE0w?=
 =?utf-8?B?OXM3TWdVUzhldHo0L1hEeUs2MElXdFRsdEtJMDdiMmdaMkcwRUdlSE96Z2lr?=
 =?utf-8?B?bkd3QzhGOElTQXBmb1Z1eDV3eUp3VHI3N2RVNndYUFRBbFBkUUwxR3V3cE9w?=
 =?utf-8?B?eTlsb1JHamo5NVpjZERaYkJ6cFIxVDV0MmR3ZndZVVBTQzNCMjREZHVGNnNK?=
 =?utf-8?B?ZDJtQUhjd0U1RjA2RHhMWjFocjlxankwcC8xQXlXbjFIWUx3QVZjcm5IRVhX?=
 =?utf-8?B?ZUZ2eHlDOTF0ckxZYVBEeTRNT015bkUweVdaTkJsMFNvTDdPUmJXdEp0V01v?=
 =?utf-8?B?YnlkSzZXYmZXQXp4STYvYUIrR3dzcWlQYll2K0hONkFIVU5JMlpZUVpTWDhT?=
 =?utf-8?B?NWxVemx4UW1KS3l0NXZvTDBuUFIzUy9CaFM5elJWZEpiYWFLUDVNRTd6NzdU?=
 =?utf-8?B?QWJ3bWU3K1ZQOS9JNnFOdjhGUUhVdStZUGMzREU5M3pWRDJvU3lRTEt2czBx?=
 =?utf-8?B?VWI1dHh4SEQ2cWNpK1NmUjZUYlJPb05JenpjemRnL0JoUVVFMjhDUFVrMmts?=
 =?utf-8?B?UWhYUHBwdXk0cUlNY3M2alJwQkpmVk4zRmdKOGJ3d2YxU3k4YXJoS29sT2tk?=
 =?utf-8?B?a0pwbjlpWlluRHhoaVg1blpBVGFlVkNPTG1DaThYUUg5TGdNMDJycUtsVGtk?=
 =?utf-8?B?ME9DTkpraElzZVpPaGpXVVpDZlI0a2VOMDJpWUFyMWtzeUQ2SzhkUlc1end2?=
 =?utf-8?B?WmY4UU4walBub01ZcWtSdGVUTllpcFZxSGxnb3RpRWJjQ1hyS2RUTmhGR0w5?=
 =?utf-8?B?N0hWc2lud3l2a1pIT2MrSEFaNll6R2MwRTJ5Q1lrem5JZzY3TzIxdFBsaWsy?=
 =?utf-8?B?cEsyT1Rjd0FTcXlJTWtodFhUS05xYWpYTkY1czFhNnh3eXJjcE11NlQvaHph?=
 =?utf-8?Q?NME/lFqVPDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME9GQlh2bk0xUjc4YjZrV1FORllqU1hYT3VBUERkQit0Sm9hMzJONWQ1QjJo?=
 =?utf-8?B?K1psd0N5Sm9xRE8rWUx4ejA0TU5uS3orc05YMFZSclpFVjRCQ3RORmRrUjBU?=
 =?utf-8?B?eXIzb1p6NHFUdUdkYUJFMlV4d0lwWVlEclgzNE92c0NRMGFMYUw3QWwvWEYw?=
 =?utf-8?B?Tm9Ya09USWlEVmxpbzZONzVaNzA5dmZMc2ozOS9Oc3h4bHJibE82clVZOWZB?=
 =?utf-8?B?bHFEQWFGdUlxbkltWHdlbGZIbTFoZkJnMDNFZW1ROW5MZ1ZUbThvbi91NUZu?=
 =?utf-8?B?STlReW9zRy95MmpFbGwwYlZDdXBHUVphK0ZPSkt1UXczSDNsVGhzVVRoSnpt?=
 =?utf-8?B?OHZjL0pRVFpRL09XYkFkWURpcmtuQnZMUmdOdERLMDJpbkxKVm94MjVnb3dQ?=
 =?utf-8?B?c2ZCdGxEdHQzaXhYV2ZoV2lhWW5wUldxcm5rcTlSZW5wV2NOZlAydUNyMkI5?=
 =?utf-8?B?c1RreGZCWk9EV2d4MDhWQ3A4UWZKYjZ2Mi9DT0h1Wk95SlBBUTFSR0k0SzBD?=
 =?utf-8?B?ZUUvT0o2cGc4Rm9FdkdtTlZzYm9id3dJNlgxT0p6NGJEM3ZYZ2tIYlVFVVZT?=
 =?utf-8?B?RXAyc3lLdUtqeTdZWHp3ZjhsMVB4WDZQeE1qMDR2dzA0WWJYMEZxeURMUEp0?=
 =?utf-8?B?S3RFUjM3aUtJMG8xenBHd1pUdTAwNGpPNkZZNWZWNXpCVUowdk4wYkJMVWdP?=
 =?utf-8?B?OUxyd01rY0xudGJJTUtvRWtZdlk3R2QxTUxQT2xCVVZsb056TXQ3NkhvZ2xm?=
 =?utf-8?B?U2VyejZWdktEZDR5WHZZZVJyeDBhK2pyQlVzeHlzSkthR0xLM2hlTVoyUUNL?=
 =?utf-8?B?T0VkRTB1M3d1Z3RqbXVISVN1V2JFU1Y4Rm5hQlhyUnVmeEhoWXhxY1YzSmVY?=
 =?utf-8?B?ZmRYY0d6Zllpc0dSMk10OFZOMTkzTU1La3hrbFhraDFKb3hPUFRhUlBVSWlL?=
 =?utf-8?B?TWVpUHZLb1VnNHZqSk5Wa3RwM21scm5DYm85dkhqeUdvejk4ejRQNXRzMmZF?=
 =?utf-8?B?ekJiekJkVmtLVzdpTnNKeExpa2l0UDV0My9uQ2x2VXZUUlNBWktRWG5ZWWM0?=
 =?utf-8?B?T0FBSmlyd0VsSVh6SlhOWmV2b3UrVHBhU3dLdGNWdjNmSGxwVzhpRWE5byto?=
 =?utf-8?B?TGFIQ3lRLzVEdnZWYU1va2o5WitpTXhJQmhGREhPRWVoUmFUc0VnOUpXOFZM?=
 =?utf-8?B?bHlDVG9kcEwwU1lkTUxtcEYwM2hCZ1drbFE3SThPUUU5ZytuY1o5d1picUJy?=
 =?utf-8?B?RWx1NDlMalBVd2tya0Yxc0FDaGt6U0Fyck0yWW5IR0R4ZGMzdlpPWXdVbVd1?=
 =?utf-8?B?U3l0Q0hqS2ZDYms5UEt3VGRUMmc1ZWlOUDhkektad1FsaWI0ZnVsSy96Wmsz?=
 =?utf-8?B?UUdNOXFJcGluNVlJT2tJd3pKcDU3SmJQQTZBRmo1MUNmS3FtN3FXZkFYaUp3?=
 =?utf-8?B?cVNwMG5HL3hKZ2hSVUlqditkNDJTZDJHckpTNnZOV1hMRmNCTHZrRzFaNFYx?=
 =?utf-8?B?UUZ2Nk9KSmhqdDVSSmMwRFgzM3NiVld3VThWT05RQXlmMzAxN1ZCTHYvYzVK?=
 =?utf-8?B?UmVsQzhKMmlnNE9Nem4vNmFSREJtUlNxUk1zTmViMTQ4SGdYVFVhQ1hjVW93?=
 =?utf-8?B?bDNNaVJaaGxrbDBNdkpmYXZrRHJTTzZDSWFUQ0FDOVJ3eThYUGgxR0lIeUQ3?=
 =?utf-8?B?YitIK2dQRWNGTFFxZHp0bGl4Ui81Zk44ZjB5YUlDR091NVVDU2ZCazJVNFVO?=
 =?utf-8?B?SUFTSVpzeGNSanVFQVJ2VHhtMHlDSUdaakl2TU5Eb25IeGtJUEhvOVBGeWlx?=
 =?utf-8?B?L04rNnFQUmtSZGl2Q0oxRjNIMzRKbzgrSWxJRU1wTHhCcXp5VGFCanNkbW9P?=
 =?utf-8?B?YlcydFNLcHoyOGp3bXU2Z2VoYjJGdU9ZUXgxZElnMHFBa0JicWE1bm8vWEgz?=
 =?utf-8?B?YjBZWkNWWWRaZit0VlJBaWE3eitzb0FURlRhNDNKNjhta0NrdEhpc1VSaDRk?=
 =?utf-8?B?TFhWR3FwYitmcGdYT1ptZjFNS3dVSHpEZUZtblFMZTFIVHAzTjlkK1Q4Myty?=
 =?utf-8?B?VWtoQVN3SmlISndaakYySWMwOGhvWFk1SmwxWGpnM0ZUM0VXUWZZdXlkZ0RV?=
 =?utf-8?B?eGw4VGdSZ3lldTZiTEZSa3VvQnVVOU8zZ0orSGdnbWpMQk5zanZGcGxmR0Mz?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 772d72d4-b170-4f07-1366-08dd4d48e14b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 22:42:37.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbPgbcnUAhpTTLSoFvvgRTFpZR7txwGr5BZuPZ8dB1Vdk9eKQdY0pzSxhGEuW0kkbz4hs50Ic6lMEglVJSQvqfB2D54F8c3/ejdKxWjdIqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6406
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> On 2/14/2025 3:24 PM, Dan Williams wrote:
> > Bowman, Terry wrote:
> >>
> >> On 2/11/2025 7:23 PM, Dan Williams wrote:
> >>> Terry Bowman wrote:
> >>>> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
> >>>> registers for the endpoint's Root Port. The same needs to be done for
> >>>> each of the CXL Downstream Switch Ports and CXL Root Ports found between
> >>>> the endpoint and CXL Host Bridge.
> >>>>
> >>>> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
> >>>> sub-topology between the endpoint and the CXL Host Bridge. This function
> >>>> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
> >>>> associated with this Port. The same check will be added in the future for
> >>>> upstream switch ports.
> >>>>
> >>>> Move the RAS register map logic from cxl_dport_map_ras() into
> >>>> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
> >>>> function, cxl_dport_map_ras().
> >>> Not sure about the motivation here...
> >>>
> >>>> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> >>>> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
> >>> Ok, makes sense...
> >>>
> >>>> cxl_dport_init_ras_reporting() must check for previously mapped registers
> >>>> before mapping. This is required because multiple Endpoints under a CXL
> >>>> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
> >>>> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
> >>>> once.
> >>> Sounds broken. Every device upstream-port only has one downstream port.
> >>>
> >>> A CXL switch config looks like this:
> >>>
> >>>            │             
> >>> ┌──────────┼────────────┐
> >>> │SWITCH   ┌┴─┐          │
> >>> │         │UP│          │
> >>> │         └─┬┘          │
> >>> │    ┌──────┼─────┐     │
> >>> │    │      │     │     │
> >>> │   ┌┴─┐  ┌─┴┐  ┌─┴┐    │
> >>> │   │DP│  │DP│  │DP│    │
> >>> │   └┬─┘  └─┬┘  └─┬┘    │
> >>> └────┼──────┼─────┼─────┘
> >>>     ┌┴─┐  ┌─┴┐  ┌─┴┐     
> >>>     │EP│  │EP│  │EP│     
> >>>     └──┘  └──┘  └──┘     
> >>>
> >>> ...so how can an endpoint ever find that its immediate parent downstream
> >>> port has already been mapped?
> >>
> >>             ┌─┴─┐
> >>             │RP1│
> >>             └─┬─┘
> >>   ┌───────────┼───────────┐
> >>   │SWITCH   ┌─┴─┐         │
> >>   │         │UP1│         │   RP1 - 0c:00.0
> >>   │         └─┬─┘         │   UP1 - 0d:00.0
> >>   │    ┌──────┼─────┐     │   DP1 - 0e:00.0
> >>   │    │      │     │     │
> >>   │  ┌─┴─┐  ┌─┴─┐ ┌─┴─┐   │
> >>   │  │DP1│  │DP2│ │DP3│   │
> >>   │  └─┬─┘  └─┬─┘ └─┬─┘   │
> >>   └────┼──────┼─────┼─────┘
> >>      ┌─┴─┐  ┌─┴─┐ ┌─┴─┐
> >>      │EP1│  │EP2│ │EP3│
> >>      └───┘  └───┘ └───┘
> >>
> >>
> >> It cant but the root RP and USP have duplicate calls for each EP in the example diagram.
> >> The function's purpose is to map RAS registers and cache the address. This reuses the
> >> same function for RP and DSP. The DSP will never be previously mapped as you indicated.
> > Are you talking about in the current code, which should have already
> > reported problems due to multiple overlapping mappings, or with the
> > proposed changes? Can you clarify the sequenece of calls that triggers
> > the multiple mappings of RP1?
> Yes, in this thread I was discussing the current implementation. The
> multiple calls to map RPs and USPs occur with the below calls. It iterates from
> endpoint to RP. From patches 7 and 8 (v7):
> 
> devm_cxl_add_endpoint() cxl_init_ep_ports_aer(ep) - Calls for each port between EP and RP.cxl_dport_init_ras_reporting() - Maps DP/RP RAS

Ah, thanks, I missed that. I misread the patch and thought that
cxl_init_ep_ports_aer() was only being called for the immediate dport
parent.

> 
> > Also, if EP1 and EP2 race to establish the RP1 mapping, then wouldn't
> > EP1 and EP2 also race to tear it down? What prevents EP2 from unmapping
> > RP1 if EP1 still needs it mapped?
> >
> > I would prefer that rather than EP1 being responsible for mapping RP1
> > RAS, and a lock to prevent EP2 and EP3 from also repeating that, it
> > should be UP1 in cxl_switch_port_probe() taking responsibility for
> > mapping RP1 RAS.
> >
> > One of the known problems with cxl_switch_port_probe() is that it
> > enumerates all dports regardless of attachment. That would be where I
> > would expect problems of dports already going through initialization
> > prematurely in advance of an endpoint showing up. However, that's a
> > different fix.
> Yes, there is a problem with the unmapping. Your recommendation is a good
> idea.
> 
> Shouldn't cxl_switch_port_probe() map UP1 RAS as well?

Yes, that would naturally fit there I think, especially because it
naturally handles the case of the port and mapping staying alive until
the last endpooint in that topology is removed.

> Ok, understood. I have already moved over the port iteration that was
> in cxl_init_ep_ports_aer() to cxl_endpoint_port_probe(). I now need to
> change the logic that iterates EP to RP to be more localized (just to
> the endpoint's immediate DSP/RP). And from your comments above I
> understand I need to update the cxl_switch_port_probe() to map
> upstream RP (DSP for multi-level SW).Terry

Sounds good, thanks Terry!

