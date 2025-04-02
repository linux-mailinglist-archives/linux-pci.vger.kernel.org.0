Return-Path: <linux-pci+bounces-25148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA23BA78C71
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD5316F46A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B1A235360;
	Wed,  2 Apr 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnF1LzMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9222AE77;
	Wed,  2 Apr 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590029; cv=fail; b=Nqyn/EOVJG5SllPHoSBCQ9KskZuJgfUGltO4Ssf1KrXJdoDvIhn3+iuCpnGjitC4OfaIxftMggcQI9YiFde7P5ACdOfDDq/btfUhWr8cvOuS7x9VhgXbERzpdJ0NITg0vBPcI0d030E+57yKgO0xM9tEaviQlOPLvH8Hkq5K1Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590029; c=relaxed/simple;
	bh=rs82H3sQR8Vp0G/9jpEBtIUh8BoeO+cJimcJfPaQFMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=um2taNh7qh7Nhc7X4lAIzlI+KWkI6ub5OjQ9Yr/MluZNdkZc7edqMUM2GqLpcZGZ3hNLr3CzOea9zRjfjdhUGF6azveA51/j3lv+Ua0zXl1N/HSi2OnZ9YwEpCTlUbkJZHQziDTDVKgYmpUkl6MXuj8eePuKrICPnve2nURFboM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnF1LzMk; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743590028; x=1775126028;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rs82H3sQR8Vp0G/9jpEBtIUh8BoeO+cJimcJfPaQFMQ=;
  b=SnF1LzMkCv7kXsN/GUfNKFdLU66AYU40GXLCu0wJNybCJkTC4olKg+Gm
   sDxeqQAERaE8Rj/YgBqwE1x9oWtfbrdYZg4SarI7kFOf2ybhPyeHUvxSy
   3ei8EpWPzXOSbuXCKHa+KIiMhrfpqJleoeYPGUncxfOncxlQ/Mv1VdC3H
   Q/kaT7QJ2wJFcgApfaxdqkOW2sa9cxozA9NihlQZ9zf9FJpp4XbKc7xFX
   izLPB559s9tytmMP4QB9cjNmJUqGL+mstJUvxPDGFm4EfwR28RxF8Ovp8
   E3yNGyhDStpaO+XmwlFjk/BF4BLXXd7VaxazVx0oxiNpUuGgvT1x++tIr
   g==;
X-CSE-ConnectionGUID: UE/X+jFsQM27Cqr9ktJueQ==
X-CSE-MsgGUID: 8C3WLt/MQailtlM4uvGRYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55575473"
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="55575473"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 03:33:47 -0700
X-CSE-ConnectionGUID: sQ2Sv8kjSX6GWCIf92YfGA==
X-CSE-MsgGUID: fALNdtvCROmOhY+KdjM8uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="130778890"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 03:33:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 03:33:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 2 Apr 2025 03:33:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 03:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmalfJglWncPiO7BYuduxBcEQmDAvJh7dVdW6CRcp089NnYbkY48CIyeyzlmelvysmYMNMbb3h/CoVXzx43FKtRl8Ru3aSNswP1WmX2af1n7Rcpdnb0bL6EwK+ORwRZtih1dL5r2FSTM4rTMaxSXAiUB8RiwXBdKfkL/Pjbzc752hBTxa4b7gRbpJqhss8k6XBI3k4bCJaftykV3o7Akcy3qmVvQiAqLslXJfvSoQtTy5emCLmfuYL57EBrWcDNHxHyim5vxngnERlQKtpL1pjiPIGx8kuKMCT/hReHrID5R1bXK1ANq9hpNRQBLxno11Io43F9X9zeBDXMWxr3p1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb+59lafVZ9yE3o7zksU4IZ3UH/zWrklaeUiHe1QD4w=;
 b=vLAAlvLUdoGW9I0/NRBQ8HXkIzLpO6T2prd/ONoT08PefZ87RU0wXCej0gmXo/0tf4+JrRgTOZNkuBGFnqPazAqAiEt1Z0iI2lr7vMdAZNffeLkpO1Xcv4SW5StMbNOQuAhNxHEi2l6WcbQ8rFtEjIaJPCT0DdP0vlPPSpBUVAGBPZZ3AwYeDtcCUS7X7scgNJQ6ymP+AKU2YZSf5Dy39mQxwvSBZ3boFXldL4sUVKeZGOYwLylgL8uwqVnjK4JeQtfK7HEbhBsfP1fEqF8t36edTEFJuQ8g2TuZUMotr7N2UqyebpFmW0CdcDu9/xL19fooEHjmxzoWSZAhULE8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 PH3PPF4E874A00C.namprd11.prod.outlook.com (2603:10b6:518:1::d1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Wed, 2 Apr
 2025 10:33:44 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 10:33:44 +0000
Date: Wed, 2 Apr 2025 12:33:40 +0200
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>, Christian =?utf-8?B?S8O2bmln?=
	<christian.koenig@amd.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>
Subject: Re: [PATCH v6 4/6] PCI/IOV: Check that VF BAR fits within the
 reservation
Message-ID: <pfwjnmsnit7s4vlz2n4zv4hrra262o5cap6vabalqqg6eud7t3@lzwqijbijs4p>
References: <20250320110854.3866284-1-michal.winiarski@intel.com>
 <20250320110854.3866284-5-michal.winiarski@intel.com>
 <4959d675-edd8-a296-661c-6a7bd22fbc0d@linux.intel.com>
 <77a5558f-fe6f-cba1-4515-c8597ae3c9bb@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77a5558f-fe6f-cba1-4515-c8597ae3c9bb@linux.intel.com>
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|PH3PPF4E874A00C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad1326e-2acd-4658-58d7-08dd71d1d7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0ZrVU1CcVNKSk5MSS94SmtEVmdOR042QklRSW1vbFZSblRzRFcycjRuN1E5?=
 =?utf-8?B?WFpFV0pNWUFHRUVXRVUySHVMWSttQUEvZlN2Z1YxNUVFSzc4RUQ3KzRRTm1D?=
 =?utf-8?B?bDdrNEsvamloRG5kTWorRnZFakVzVXN6K3NMRTN3ZU9aMmNTZFdic1k4bWNF?=
 =?utf-8?B?VmV6c0ViamwrU3B2TkpnbW9ZeFFCRzY0cnhDTHJ1Z0hyQ1B1MXBZc3pnYWJB?=
 =?utf-8?B?VC9rd2NTSDQzVldLRVdBQlkzdjQ4dDgzakovdHhudWh5cnVlMWNOM0ZxUkJD?=
 =?utf-8?B?R2pBQ0tGbW9GOU04TmNzVHpVZFNFcDlqbzR2Ujg1Nk9vZWlrUnpiSkhoWXVT?=
 =?utf-8?B?eUpBUWZITytXOHFTQ0RjV2JMWkd6TzlFRHNMRUFIUldFVUkzNDlmblpGditm?=
 =?utf-8?B?dy9xTk1MbzkwbW0vNGpFc0xJak1ldmNiYnB3OEsxK1dCZ01ueXpKazVQYkhh?=
 =?utf-8?B?c0ozTDB1ZGpqUUkvUTNkMStXc2FyNTVib0tRNnJqVFVGNnE0ZEhOMHFCZUVU?=
 =?utf-8?B?dDdudHBRQmYxYjhVWXc3dmNNbWxTK1l4b0F5TmNnOFVhYjd1Z05vNno5SVZm?=
 =?utf-8?B?QStObDZiMVhhaDBjZlU2ZDdvblIxMEY1SE5XMUdrUTdUc3NpaGNqZGk3M0kr?=
 =?utf-8?B?ZTZiNkZTaUZ4Z2ZUU1NGWFJ2OXVneGZCbVRXU3B6bmZQNExiVDV2cmhpMDNz?=
 =?utf-8?B?UDZ4MktYSDNsSC9GSmR4NG01R013ekxMcHRXYkptZGZMSmVGUG1tNC90c01s?=
 =?utf-8?B?TnlxNWQwT3kyUDhuZ0ZJaURRY0w4SEZKKzRrZTdscTdNYmlMcXA3bEM5T1dp?=
 =?utf-8?B?S2dEZWlrREpiV0xaZFVGWFVkZDlBN1BMbjV0VkdTSHNsaDMrU2lZZW5oTUhh?=
 =?utf-8?B?TGthMjFQYVNRb2Z2ckdEVHFuZGhYNWVNb0REQTVBVG5uRTYwbXVwQ1BGWm9E?=
 =?utf-8?B?SjRWNjFLajhyN0JOZTZiMmRjT3NhK21PcUNGUGxoVll3Q1FJM052dlpVZEEx?=
 =?utf-8?B?TlMyWGFHeVFOSFhCR0lhejZFb1J6aVVReHFNYUVUVWNTeHZHbUhKd1dvamZK?=
 =?utf-8?B?SUtNTk83WkZNTGVWaUFzVWVTQjBTVmY4MjJib0tOREpuaXJ4aEhyQnNTdUlS?=
 =?utf-8?B?b2tjMlhDd296Q3VudDJ0UmVVSXRqMHh4ck5BVnJLR2ZDNUs5YWN4ektZWnBY?=
 =?utf-8?B?SFlBV3A4UU1WR0c3U3pwaE5KSDNGU3Z4M1R4Y3dYR21ib2U3c0t2WFQxdjlN?=
 =?utf-8?B?WVVOVzB6dFVDWG9OTlhjY0R3UEhEL05VMEJZY1hLWFY2WkRQQ1lvN3diMGZs?=
 =?utf-8?B?djlKb2NzVmlJU2VMaHY5V0l6WURLNlRVZnFUSlN1WTJGRzdJVk05NWJldkY3?=
 =?utf-8?B?R2NxcVRRMW43QzRVemE1Z2hzMmEzUU5ITUlTWVhKTmNWZzZrb0grYTNYN054?=
 =?utf-8?B?Z1o0SVRrMTV3MCsxRExlUmpLU1B3aDQveWdidXJLVUVTZCtIUHRkQ3hYbk1B?=
 =?utf-8?B?eVkwL05NdTRCY1NmL05TeThFWkpha2VVTjdRMDlZQjZscjBwaHhZNHNxWElZ?=
 =?utf-8?B?QlBJUzJwQTBnRUw0UTFzc2t0cnAwbDRITFN1ZkVLS01WVUVIMjNrT1dLeVBm?=
 =?utf-8?B?TXFFNGVhQmNsOWpTTGVtY0V1NnNpK3d0N0lKL0dvVE00LzMxQlFqWTZyOE11?=
 =?utf-8?B?aDFpc0cxWGNxTTg4cjJXZmhpTy9lVEhvMktSdXpGNDJxcFhIT1RHVDYwbWlG?=
 =?utf-8?B?NXJBWUVqbHVITE5Vb0tzeENTRnJtRjBjd3UrdmxNQ3N6a3p6UHIrNkdGTWNs?=
 =?utf-8?B?d2ZBTmV5UDNSS2lWbStUa1ZEcFhWU0ZHVnhycnovTGtCWkxVWEVzNjVBdGxz?=
 =?utf-8?Q?YzKIy2QBsNjqk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmQ4V3o3RFI0TkZ5Uk5WQzJ6VEV6Mzg1MHh1eHEvNzY0NkZBU1dxVW1zTEVF?=
 =?utf-8?B?dkp4bmRvdERiZENXS2RQMXNzRHZ2UFdCdVpwUXc4Mm1NU1ZROXBWNVVsS1RJ?=
 =?utf-8?B?ei9HU2Rjc2E3SFpaTG4yYnFtcFlzRUtqNlZvWmpFRVdEWUZ1VXpQcnBNdktU?=
 =?utf-8?B?K29mcG15TzZXRkJFaE82TWZLZEVIaXFLQWF2OUplQmV0UlE4d0pTalRiNzRQ?=
 =?utf-8?B?TWlRU2duZTFJWWVvcjl3K1FhUWx1N2dRZ1VsWVVXQ1FyVWZ3OVFHVWpCeThZ?=
 =?utf-8?B?bE9zN0gyaFRVZitFMnIwb3FTT05YUXBUaTVoNFJIR2kyMkRWT3hpamR2cW5I?=
 =?utf-8?B?Z2I5MHZ3Ty9sWDNJZDc3eGZNcUp6ZzBGQVRPZUxLNGgwVVBTK2NlRTVnNjBE?=
 =?utf-8?B?akVSNlMxRVpqdkovZVlXZVBNOHVxQ3gzZ01BTVI0UW10VXdwNk1pRjZFTWho?=
 =?utf-8?B?bFo3SDdmdDZtSGQwZytTL3FBN2VEU0pSU1JPbXEyYUtBdUNYekJaNktlbFZp?=
 =?utf-8?B?Q2IvS0tXakdrbk1TSWgyazJ0UTRYTXNsdTVpdXovMXMwNmREUHEzTVZtOVlG?=
 =?utf-8?B?M1NENFRqNHBsOVFGc2lUckozK29SbUJ4bUdIY1ZLK1VvTGJVbVI2Y09GN0R1?=
 =?utf-8?B?NWlDeFlySVZ5M2FGVUxZbU55ZmxFN1czSGFSaGdLeTlMWFRiS1psU21BYlZs?=
 =?utf-8?B?L0dXRjhZS1JWVlY0STFhY1pkL3dsQThoVVRTUEdla3hhSXJ4a1V0YWpZdU0r?=
 =?utf-8?B?b0NvMStkNHZoNlpqdzVMQzhCTWRva1RydEY2RHEveWFDNktrSUhMTkFydk1n?=
 =?utf-8?B?VFFOSnZYSldRSnc2ekJRVXFxNVBCKzBVbnllNi9VTk9tczVWQm9jMWdOMXJu?=
 =?utf-8?B?dzZLR1RZb3FqL3pKa1AyVHRGUFJNbHV2d0dmL0lkbzFhRGFpRHpUTk93Y3dp?=
 =?utf-8?B?bFV1cmw4VlhkOE5pQUFzYlg0NmEySm9tY0oyaVpWT0NXVkJBU293bUpXdzdV?=
 =?utf-8?B?bzZNd0hPNVN3a2w1Nmxjc2dPSTI4djRFc0dXZjkyR3ZmZXNlazdOeUN1MU5s?=
 =?utf-8?B?UDhNeDlOTUk0R3NMWHltdllKc21nOHZJaGltNnN6RE5QYzZoUVFnWURCM3VY?=
 =?utf-8?B?VnVTTkRaNE40NXVJZytwTGdoNnYvaTQ2MHN5S25LY1kyLzArUW5ZZWd4SDUy?=
 =?utf-8?B?YUN1V2FzSUJYcWN1TlhlT29IV3hycmpkVURJVVdaZzRBODRrRnlZdHc2ejVO?=
 =?utf-8?B?eTZuWjRIeVNYMm90TkMrcGprWmdoTGVTQlgwYmdDZW8vZDkyby9tekJpZ0JR?=
 =?utf-8?B?MzQyMTFHQlJUR3MvV1lvSHJJT283RnhkUVk0QS95VzFTbzhrYU5hUFdYUmJn?=
 =?utf-8?B?WERUQWQveTVFdG1MNGhvUzdlNjJDYVNaRXB3blNSdTFqZzhORWJPZksrd1kx?=
 =?utf-8?B?dG9LQ1dmNTdCQTNudlFDMSt3eFI2b2FWTmxaZTJxbXI5RTdXckY4Ykp6bHpL?=
 =?utf-8?B?TzJuTFM3c09jeUZ6SlFCM01RazZLVGxMTWFCRGZKVXZHdTQ1RDhkMFBObFVl?=
 =?utf-8?B?VTl0SzhUc0U0eVAzZ3RBcWZYVFRBNVpOVVplQ3M3L2x1YjllY1ZmdDFiMlFF?=
 =?utf-8?B?aktYQmVzMWorSHViUVlGOXRVeXJKV1dSZC9yRjczaVduaDB5R0x5cndvdDFE?=
 =?utf-8?B?d2ZDT2E4TTI2OXBFcjg3VmtxT0hHWllwaUFKSGVvdlhlL2N4STdLOTV2MEdp?=
 =?utf-8?B?NTYxY0s2aW9KQmREZnJ0d0MvVEhWcHcxclpXTkl2U25pVDZ0Z0F1WWVJM21i?=
 =?utf-8?B?d2YvN1hlbk5SWTRMWW5GTjhrYlBVWGNGUjFTR0FQeVZHZ2oyL0kzd1ZrZEtT?=
 =?utf-8?B?OGVNVVdEZGwvaTVLMzJkQ01kTHVkRXRzYU1ITFBBcjlSTERJSWpCSzhhc0ZX?=
 =?utf-8?B?NGtGVExZZTlvb081YitxdERjaENMbkNRS1Bpay9wejFBcW9oSjZjRENJbllj?=
 =?utf-8?B?V3M2aHlNUUJ4cnE1bnFjMHJuUnhOemg5R2xnZ21aWnZzeGdpWktyL0ltbVVP?=
 =?utf-8?B?YzcyMUNqK0hCa0cvUG5hckxXSkpjeHJUTzNUT293cEZiQnRBZzgzWnF2Um9W?=
 =?utf-8?B?WlNWRkpBOGxUUldhVnN6eDRDN1NITURoNW5zUzhXOUdJdDBycXpRZTMyeFVL?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad1326e-2acd-4658-58d7-08dd71d1d7cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 10:33:44.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO568uYni8fNeoripc7jvicV0os4pLe0cnmhxT2QV6msAIGZlv/dKRWGHP7bAtWXWrzukOyUMvnBoVvYLe+zq0zlb/Tfrczhv7DhtmEDOEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4E874A00C
X-OriginatorOrg: intel.com

On Fri, Mar 28, 2025 at 06:39:29PM +0200, Ilpo Järvinen wrote:
> On Wed, 26 Mar 2025, Ilpo Järvinen wrote:
> 
> > On Thu, 20 Mar 2025, Michał Winiarski wrote:
> > 
> > > When the resource representing VF MMIO BAR reservation is created, its
> > > size is always large enough to accommodate the BAR of all SR-IOV Virtual
> > > Functions that can potentially be created (total VFs). If for whatever
> > > reason it's not possible to accommodate all VFs - the resource is not
> > > assigned and no VFs can be created.
> > > 
> > > The following patch will allow VF BAR size to be modified by drivers at
> > 
> > "The following patch" sounds to be like you're referring to patch that 
> > follows this description, ie., the patch below. "An upcoming change" is 
> > alternative that doesn't suffer from the same problem.
> > 
> > > a later point in time, which means that the check for resource
> > > assignment is no longer sufficient.
> > > 
> > > Add an additional check that verifies that VF BAR for all enabled VFs
> > > fits within the underlying reservation resource.
> > 
> > So this does not solve the case where the initial size was too large to 
> > fix and such VF BARs remain unassigned, right?
> > 
> > > Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> > > ---
> > >  drivers/pci/iov.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > > index cbf335725d4fb..861273ad9a580 100644
> > > --- a/drivers/pci/iov.c
> > > +++ b/drivers/pci/iov.c
> > > @@ -646,8 +646,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> > >  
> > >  	nres = 0;
> > >  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> > > +		resource_size_t vf_bar_sz =
> > > +			pci_iov_resource_size(dev,
> > > +					      pci_resource_num_from_vf_bar(i));
> > 
> > Please add int idx = pci_resource_num_from_vf_bar(i);
> > 
> > >  		bars |= (1 << pci_resource_num_from_vf_bar(i));
> > >  		res = &dev->resource[pci_resource_num_from_vf_bar(i)];
> > > +		if (vf_bar_sz * nr_virtfn > resource_size(res))
> > > +			continue;
> > 
> > Not directly related to this patch, I suspect this could actually try to 
> > assign an unassigned resource by doing something like this (perhaps in own 
> > patch, it doesn't even need to be part of this series but can be sent 
> > later if you find the suggestion useful):
> > 
> > 		/* Retry assignment if the initial size didn't fit */
> > 		if (!res->parent && pci_assign_resource(res, idx))
> > 			continue;
> > 
> > Although I suspect reset_resource() might have been called for the 
> > resource and IIRC it breaks the resource somehow but it could have been 
> > that IOV resources can be resummoned from that state though thanks to 
> > their size not being stored into the resource itself but comes from iov 
> > structures.
> 
> I realized reset_resource() will zero the flags so it won't work without 
> getting rid of reset_resource() calls first which I've not yet completed. 
> 
> And once I get the rebar sizes included into bridge window sizing 
> algorithm, the default size could possibly be shrunk by the resource
> fitting/assignment code so the resource assignment should no longer fail 
> just because the initial size was too large. So it shouldn't be necessary 
> after that.

Yeah - and even if something fails in the resource constrained
environment, I think the flow used to reassign the PF resource (and
bring back the ability to create VFs) should involve remove -> rescan
(not just VF enabling).

Thanks,
-Michał

> 
> > >  		if (res->parent)
> > >  			nres++;
> > >  	}
> > > 
> > 
> > 
> 
> -- 
>  i.


