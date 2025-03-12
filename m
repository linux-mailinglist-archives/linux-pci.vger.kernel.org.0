Return-Path: <linux-pci+bounces-23550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E69A5E7E3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 00:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CBD189A22E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752951F1516;
	Wed, 12 Mar 2025 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHlxDrbe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19271F130B;
	Wed, 12 Mar 2025 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820444; cv=fail; b=u5o51X07xuS2Yw3UeS0rkI18W+2UN6HTfPU9qdJyd2btOZUt9XJcdI/TUmKGqNxZJI3k/RkkjUTet1K+LpJHckC9ydS8OxmSyT6j7CcrTQpCN+vjBy2EGUpnsL6HxVvGlukFSgEZttRrd+aQ3jFQ96PP9cvzaLZU777mzBfhLJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820444; c=relaxed/simple;
	bh=5ccflj1VHcKOfjyrDzXfdAlGhHFlKB+VxPgr21eKYJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igqP9krep/+uB69tJoBUlYuyixZWLUT3sOCNgpU6sDZHLuZI37MRiAL9ud89gGHrSAWTiCxu+paNF93z3c2m272keQpf04ifBaGXnJivHwXjZrtrYGeOGdPYUOZO0wr3e3l6j8oOQBnzMZb3WIxlRSBZHpcwz8sJYKScBzDEmHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHlxDrbe; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741820443; x=1773356443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5ccflj1VHcKOfjyrDzXfdAlGhHFlKB+VxPgr21eKYJM=;
  b=bHlxDrbeHLXWfl2dG2B9n1lWXWYB8t9bCPql6IU59p3thC9CpgJZ6duQ
   RFd1CsgvKQLv4WRvj0Th3M/heg3k3xrWuTiILcFWLhp3J2jSB8ZhCTwcr
   AWi1AdNC2ub0kW8wkNvnFE8oi49WrkgJuwQR1NggFIo8IzHKwwSyYVPnP
   Xn4SjpDB2Qr3DVmPrpdLntPmno83vCuk83t4iRN2+gRyi1JcSS+hBSWD7
   1Vqp7txAgHG//uql3owjNCeY0an95lfzHR1u8YiUVooGtmzhGxsgQrePU
   WLKdVGo+zyOjUoYdgh/dI26RsCtSi3ymmZ3QFvT2NLGTk1euHNMbYlin1
   A==;
X-CSE-ConnectionGUID: 9B11XG1DSdWueA5yu+0yhg==
X-CSE-MsgGUID: TLU9vld+SkyEb8NB950ABA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53571026"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="53571026"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:00:42 -0700
X-CSE-ConnectionGUID: y2s00q0SQsWJ++jEYv+qPA==
X-CSE-MsgGUID: iRKHZwduQRSy9hSFMjx78A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="120580723"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:00:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 16:00:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 16:00:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 16:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY1puAY4ajnyNScfVXl+vKY1bnqNV30ws6GWPloEcRKy2lDCv+Y+BWwdBtDrytTNQLe9QlucpNhmEFspSlUQLSgRwygRpEfwux+ujg5qUknnEyi8/Gcz4xEMuDKlDvNOHnHqIbPL//e4aT/fRlx0Cut3k0LXh3BxKbuIio/BCawtEVxVU+/PQDrfgGaF9RIC72t+3t2AI0yGI7a0us94re8tVgSMthV9fPifhUeQ/3EeUKTouZi3Lojvr7GlAkaOdU0350FlCEUebePwelvP/rQkOPVnU/YVBaa+Lxc4VrpP7WZftcszUdcc9tvEDa9mXqAztGG5zd74QBBW4PcOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD7N/oBNhQfQouJCQNMO5q6eGdIdS73B7N3eQJ+g7Tg=;
 b=FligDR/E21bLwkpxzjaO/FlmxSZRT5AKP0R8fkKbW5rNOXsoBH2zGupmjz/kf7ECm5/pGD+hUjJzuuKpm3zOulnv30wSLYtIAe9/wQUaFC3LssFJ9jdnxL12rOYrNcurAmmCJkvKiNFk0ypWAYznKKCENUdJkKmDOPI8wcG4HFYAdKCRzTwiBzwvCfA3bDom8VXNk7mYqJAn+lZQXUyzwn0XTTnxiw7WnVOQMhrdcZEZpF+AwxC2c3BMA1kOscsC9j29cydkaQGUzKMbnbVFGZD9qQ9H/5i3F+XiHxPsJM6d7In1ug+avaKQl6/qLMfuEUZnysBtmOFkPY+M35OooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 SA1PR11MB6735.namprd11.prod.outlook.com (2603:10b6:806:25e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 23:00:37 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:00:37 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: <linux-pci@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>
Subject: [PATCH v5 2/6] PCI: Add a helper to convert between VF BAR number and IOV resource
Date: Wed, 12 Mar 2025 23:59:45 +0100
Message-ID: <20250312225949.969716-3-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312225949.969716-1-michal.winiarski@intel.com>
References: <20250312225949.969716-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|SA1PR11MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: aa883bac-7b1f-41a0-f900-08dd61b9b3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z05KRTcvL1lPd0IrV2lhL2hVcENwREpuYS9jUlpMWXpKOEx1b3N1VUowUW9y?=
 =?utf-8?B?N29aa0l5eEdMZlo5NjI2dGxZd2c4bnl4K2drZVdMVDJtSGFZYW9QSTFMb012?=
 =?utf-8?B?L01PY1I3WXVJL2ZlRDZFNEk0KzFpc1R4U2ptd0tiNDZVcFc5MGJWRU1wMnJt?=
 =?utf-8?B?K1pLRUpoSGtQZm04OHJkS2RreElEekNoT0FBc0RtSDEyb1FsdlV4VGYrL3g0?=
 =?utf-8?B?aUNPWlpDbmJjMVZoL3ZTOS9udFhmeWJ3cC96UE8zdTFtM3hzQjUva3VOWmty?=
 =?utf-8?B?bmU1Slk5Q1pScktpT05yNUpDSEVQakJTL25DeENXK0JxOXpKd202NGVSRUxy?=
 =?utf-8?B?MjNsb2FFMnF3VElMNFlBWDJ4elFoa0xhK0RvdHdyRVlrUkFxcTBnandJakxj?=
 =?utf-8?B?Mm5tODdnUSszTmIxRjUzc3lyVGZoZEZsTml5R21uQVNNNnBHZnZDS2Urb1BF?=
 =?utf-8?B?bnZ1WUdBVWVVWVZtL2d5VVU1T0xRTkJHK1ZIMHhENmpyeko0d0hMT2wrZEpj?=
 =?utf-8?B?RXArdXdvZDg1UEZtWDYrakhDaENFMy80cU9wZ3k1ZEtWK1Z6ZFhFVmFzQldh?=
 =?utf-8?B?d2dzYWhjMVBNdCtVK0lGL3NRVkd6UllvZVlVZWhlT0JOSWlMcXhjSlZLbHNH?=
 =?utf-8?B?TFVBNW5GeHdvblpISHdrdHhPTm5CUi90NWw3YnlUNGlCaU01UDdDamZ1RXMw?=
 =?utf-8?B?bFBLWEFQakVMTkRWTmRKaFI3K01DV1FiZXlGdGtlK1JuTyt6WVdzSDVUQ2JV?=
 =?utf-8?B?OVFucC8yc3J3RVE3Rm5ER1pLZ1NJdFdROTFHN05VTkNSeGhKRmdRTlhHMC9R?=
 =?utf-8?B?MjVGUW1tem83ZFNUL0RBcEJmSXBKcFZoR3BQdnh5UnpkSjNlWkZ3M01JdDVi?=
 =?utf-8?B?TE1tckE1Z1MyS1V6bzF6cE9TY2ZMUkw0c0JzUm9sWXd1ZXJFdSs5QWVvTHdz?=
 =?utf-8?B?Ymk5bU4xUlVGYWZZdjdpdEZUTWdqKzFFcGZjVWFSNmFHQyt2MTh6MXhQdmRJ?=
 =?utf-8?B?aUxLYTcwUU4zVWNxVGtLZDFVc2RMZTJ3dzM1NnM5aWFRVmVrdS9yQkNCTmJk?=
 =?utf-8?B?NjhJNjBkUXNLd1haZFFxeTZRWU9MVDZRN0tRbFRKUXA4K1Z1a0NtbStYaUxr?=
 =?utf-8?B?RnRUVzRsQXdNdUZmQUlPOUdpcVBUYjMxWmdLd0Rmb2ZnaDVqUDlhbnlHNTZp?=
 =?utf-8?B?cGlnOUFnTkVTWXBPNlhJNXpOR09JcnFiWTdSWE5ncUlJNHErM29obCtXTHgy?=
 =?utf-8?B?OHkzbmplOUZCRUdxTFNBWmZKR0thdVlvdnlzY1NZR1dZU056SE5EMjh3TlNt?=
 =?utf-8?B?amx2Z3NoTW9QRlZpRUNzc2tnZnlSdG1NSEQ3K2h6ZXJRd0Y5cm8vRWs4NHRq?=
 =?utf-8?B?OUhIdXRwU0pKdmZwcEc4dXgxdHN1T2plOEhxbW5WRVRqcHdqZE84d2ZvdGc2?=
 =?utf-8?B?ZGtycnVvYXQ2MlJvcjd5Q3E0MWg0bjJweGFmdEpubjdLQlRIVTViZU9UVnB0?=
 =?utf-8?B?aGhRcS8zM29MUFJuTjBqZWdXd0M2S2lRcDhxcFBqdWxyOWRpSmNaUjc2Qmhk?=
 =?utf-8?B?OFU5MWNJUTY4bWt5Um5XdXNMY0ZTZVR0bEV4L3I0RXlqeEo4VWtzQk9tNVZB?=
 =?utf-8?B?V3JNK0ExcHBNMGcrVzFTcVJkK0VhTnBLOHlNaTMzZXZZenQvVkViYXozamN5?=
 =?utf-8?B?bXVlQmlTbWlINFhkd2ZEaDE0UFdDWmNjNGJuWUhKWkU0NDhKMmtNK2EveVRQ?=
 =?utf-8?B?M3hPY2RuK0JKcXlKYmRoUDNGVnVUMDFxMFNTMDVvZXV0NmhDaGRXeE1ENHJT?=
 =?utf-8?B?S3FTMFBDVjFkUU9HdGdqZktVODhLRW1uSFdIbWEvSktSZVprNTVxTU9PeEd2?=
 =?utf-8?Q?XLfKl8bcUjmsN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWcrcjd4Yy9QelRKZ1Fhb3YzaVNQeWdvNWZzN3IwQjNrUFdxWGtzbUxUeW0z?=
 =?utf-8?B?a3RzeWd6VStPY0h4ZFZPeStBMHl1a0xGbFZzbE5wQWVES0IzSjRHK1NwWmdT?=
 =?utf-8?B?Z3h2ZkVFR200UXBxVXllcjhOMWdLbm4yQndWU0c1cEsxNzdjZys0U0g5RmRQ?=
 =?utf-8?B?UVNXYVR2TVVKc3RaMG5OV2w1LzQxZ2ZZaFhCZ1Qya054ZXQ4MUhYWXNHVHp5?=
 =?utf-8?B?RERIMldqVEdwaExYSVVQSUFmZTNmR1dTckJaakRyZ3dvMFRKQzFva2pFRkxC?=
 =?utf-8?B?OFNtMkJTQVhRdEwwajhzNGdzcUsySUN3emlVZjRUU2ZmMGY1Q3d4RHpYSyts?=
 =?utf-8?B?ZDhZT3BGbmMzeTk4NmF4MS9PY29BaGZ3ZFhZd29kam1CODZwZEZUN0NFVHJt?=
 =?utf-8?B?TGRKbllvemlXSDlKSWpRblFMb0lwOVRYV294ZlkvZWNKckZrVGVPYzlkNWVG?=
 =?utf-8?B?OWwwUXIwVll5b29iTm9zZFdaUi9hdFIwMHFuUnQxVDY2OWxueFg3SHpIRXhn?=
 =?utf-8?B?Z0ppdW0vMHk5V0hta2ZZRytOd0c1NEFUMm5aWldFcDFtbzFkZXFyTW5HVnVq?=
 =?utf-8?B?cXFJOXZxdHlkeHdIY2dMYmRESjUwMUp2VDNienFVbHVqWkNsSG9qS2dRaFdk?=
 =?utf-8?B?RlR4VWJuYllLVlk4bWlRNy9WTXhmMWdJQW5oQi9ZaU5pQzJrZXpRNjE3TENS?=
 =?utf-8?B?T0NGS2NEVkxLUzlKWVZKWHpLMnhwU3V2dlZwYWRPVHlEbW9wYmpHa3NiMm0y?=
 =?utf-8?B?dlB4Titad2lERkZRODVnMk43amY0ZnFONFhGRklZRXRwV1IrcHlyVEVURGNy?=
 =?utf-8?B?ZlltaGZvQWtQSVpKYlg5a09IUklDUlNySldYanRQTDd1d1N1eHRsT0NEN2s4?=
 =?utf-8?B?OWFPd0h5Mm5EVW1hNTMrYlVWd1M3RGJRdUE0Nmp4d3VMa0t0NjhlMy9GeUlh?=
 =?utf-8?B?aW43MnJ3SWRhbUJyWXNmWE85eFUrdzVVOEQ2RGZIL0JnQS9CYUJFUkxqdldT?=
 =?utf-8?B?RDNWZ2Z0c1Bvc1VmOEJtTHNScElpOUkrbUFweW50YnZhQTVrMHFuYXo2aFN5?=
 =?utf-8?B?emloTWs3RzNsemkzSVRxdUltME9lNFhLakJGNmJ0NG43WEF3SlUweTNOdkxx?=
 =?utf-8?B?blpNUUt2RnBtSzhOQWZ6SUhXVmpMdjRIVUM2NW1udHhPYTQvU0hvQTluMFkv?=
 =?utf-8?B?dDdTdjlFa1ZRTEo1SVVpNDk1N0svcXBxa3JQZ0pLZW5XSmp4dXJmZ0JFOHB1?=
 =?utf-8?B?dU5VT2RGQnBYV0RKeHlITGlnMUJ4bGNIK3FmS0tzeGZuaFN4RG95OU9VL1RF?=
 =?utf-8?B?T1BqMTAzaUZ5dmhISU1FQy84akZrSzE4OWgwK0R2Z0Q5R3puMnpFK0x3UzB3?=
 =?utf-8?B?S0Fud2pPV2NVQisreUhCWXl4UmlObTdvVS9lY0Qxb1ZvQkJkUnpjak5iSXVP?=
 =?utf-8?B?NXkwSExBYnVDR0FpQjJYdWo4VVN1enRta1VscldadTh0cllueFJuWk5XVU9Q?=
 =?utf-8?B?RTh4N1hNaWJpNXBpZ3Z6bktJMVpXTUUwdWNJTXZrdnBrMEQ4SzE5N0dWN3gz?=
 =?utf-8?B?ckExbXJiYk9NbHJkOW44MFRLK3ZVK0hyTHNBS3kyMmhvajdmTm9FOXhmVExm?=
 =?utf-8?B?RUJZRWxtMUE0TkM4eVdlOUNTNWdGNzE4emN6R081MHpuelVWa3JHelU2TVRB?=
 =?utf-8?B?NkxHai9IbmVSWFpBT1hXaGxDRUZac3pQVTN2bEp0dGNVanpUc2lueUV6TDBM?=
 =?utf-8?B?Rit6NmRZeGdyY1VMZ2lFWW9SeVBiVzNRdlVZcWF1Y2xMSDU4S1FNakpEa0ln?=
 =?utf-8?B?UmIrSDhOTyt0OS93dGx1YnE4TXgxRzdVaDhyZEJ6c1dHR0hqK1JuSVM1a3pk?=
 =?utf-8?B?eC81V0QvY3Q5YnM2QnpPTURTbUVGUjcxZEdQZ3I3TVE5L0p1OGtKQ2FjL2NQ?=
 =?utf-8?B?bHBqL2dyR09KQUNtSFNKMGc2dnBQVWgxK1JCU2ZUbnFkUHhHUHRVbnprNEVr?=
 =?utf-8?B?czU1d21ScE5lUnlxdjg1WjBSMkQ1eDVWZittWCszUUZqTHgySFRiRzNyWmdx?=
 =?utf-8?B?bDYvRzFvQURyUU5pcGxpVzZXRVorbHAzcEc2b25qUEFYY1A0WWptdDRJeTdr?=
 =?utf-8?B?UmVub3laWGtlMExWQmRHR0dQMEs0TXFsNE5hMlBGdFYwK1JuazExa0k4TWNp?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa883bac-7b1f-41a0-f900-08dd61b9b3cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 23:00:37.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuG4wKqWjO0NMhdjKwjr20JEDUWc3ohv1Lj0osjh8c1n7dIuuwqOWsmbi0qbCzVPi+CfAUOYYhGNXRkH2Ky0Zi993Dz/A5sm/jJTbsJrkLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6735
X-OriginatorOrg: intel.com

There are multiple places where conversions between IOV resources and
corresponding VF BAR numbers are done.

Extract the logic to pci_resource_num_from_vf_bar() and
pci_resource_num_to_vf_bar() helpers.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/pci/iov.c       | 22 ++++++++++++----------
 drivers/pci/pci.h       | 19 +++++++++++++++++++
 drivers/pci/setup-bus.c |  3 ++-
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index eb4d33eacacb8..23c741e9ede89 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -151,7 +151,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	if (!dev->is_physfn)
 		return 0;
 
-	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
+	return dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)];
 }
 
 static void pci_read_vf_config_common(struct pci_dev *virtfn)
@@ -322,12 +322,13 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	virtfn->multifunction = 0;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = &dev->resource[i + PCI_IOV_RESOURCES];
+		res = &dev->resource[pci_resource_num_from_vf_bar(i)];
 		if (!res->parent)
 			continue;
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
-		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
+		size = pci_iov_resource_size(dev,
+					     pci_resource_num_from_vf_bar(i));
 		resource_set_range(&virtfn->resource[i],
 				   res->start + size * id, size);
 		rc = request_resource(res, &virtfn->resource[i]);
@@ -624,8 +625,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		bars |= (1 << (i + PCI_IOV_RESOURCES));
-		res = &dev->resource[i + PCI_IOV_RESOURCES];
+		bars |= (1 << pci_resource_num_from_vf_bar(i));
+		res = &dev->resource[pci_resource_num_from_vf_bar(i)];
 		if (res->parent)
 			nres++;
 	}
@@ -791,8 +792,9 @@ static int sriov_init(struct pci_dev *dev, int pos)
 
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = &dev->resource[i + PCI_IOV_RESOURCES];
-		res_name = pci_resource_name(dev, i + PCI_IOV_RESOURCES);
+		res = &dev->resource[pci_resource_num_from_vf_bar(i)];
+		res_name = pci_resource_name(dev,
+					     pci_resource_num_from_vf_bar(i));
 
 		/*
 		 * If it is already FIXED, don't change it, something
@@ -850,7 +852,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	dev->is_physfn = 0;
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		res = &dev->resource[i + PCI_IOV_RESOURCES];
+		res = &dev->resource[pci_resource_num_from_vf_bar(i)];
 		res->flags = 0;
 	}
 
@@ -912,7 +914,7 @@ static void sriov_restore_state(struct pci_dev *dev)
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, ctrl);
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
-		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
+		pci_update_resource(dev, pci_resource_num_from_vf_bar(i));
 
 	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
 	pci_iov_set_numvfs(dev, iov->num_VFs);
@@ -978,7 +980,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno)
 {
 	struct pci_sriov *iov = dev->is_physfn ? dev->sriov : NULL;
 	struct resource *res = pci_resource_n(dev, resno);
-	int vf_bar = resno - PCI_IOV_RESOURCES;
+	int vf_bar = pci_resource_num_to_vf_bar(resno);
 	struct pci_bus_region region;
 	u16 cmd;
 	u32 new;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4e2ac06db3c47..e3cd9b8f9b734 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -659,6 +659,15 @@ static inline bool pci_resource_is_iov(int resno)
 {
 	return resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END;
 }
+static inline int pci_resource_num_from_vf_bar(int resno)
+{
+	return resno + PCI_IOV_RESOURCES;
+}
+
+static inline int pci_resource_num_to_vf_bar(int resno)
+{
+	return resno - PCI_IOV_RESOURCES;
+}
 extern const struct attribute_group sriov_pf_dev_attr_group;
 extern const struct attribute_group sriov_vf_dev_attr_group;
 #else
@@ -683,6 +692,16 @@ static inline bool pci_resource_is_iov(int resno)
 {
 	return false;
 }
+static inline int pci_resource_num_from_vf_bar(int resno)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
+static inline int pci_resource_num_to_vf_bar(int resno)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
 #endif /* CONFIG_PCI_IOV */
 
 #ifdef CONFIG_PCIE_TPH
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 58f28e4e24b31..384d53be3a5e7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1885,7 +1885,8 @@ static int iov_resources_unassigned(struct pci_dev *dev, void *data)
 	bool *unassigned = data;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		struct resource *r = &dev->resource[i + PCI_IOV_RESOURCES];
+		struct resource *r =
+			&dev->resource[pci_resource_num_from_vf_bar(i)];
 		struct pci_bus_region region;
 
 		/* Not assigned or rejected by kernel? */
-- 
2.48.1


