Return-Path: <linux-pci+bounces-39872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB925C22AEE
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 00:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19D2B4E2531
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995AB3A1CD;
	Thu, 30 Oct 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIDsVUJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277029CE1
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866181; cv=fail; b=e6Jn58IXQ+E6VvDKCtPhuPHRy8Ydj40iKDzksj0wPlX7FuPU27AL0nuAy4bPgl1V+7P3ak5YDqxa1Yv7AmVY7ur6r+nIcxXjyQvswTJXKK+C89t3sUy+mw5dWzQxEvhErK233ZJVMPLbfg/BjzqBGlgBbJvq0CWM6200qG7bfTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866181; c=relaxed/simple;
	bh=gVUlXtGSVdAxL3nx3RZGXcLGtAi1uxysK3+CByRefvE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=oAwkzFjN7D9gpKnE7XZFPG9uJd9kpDrdPiDDtbRAegXpYqVk+qpBnxX5SUIEfR8/a77aP3+Opp4Jx4Tt7ArO3qreQcPE1On3aGhM3xjVLyTSQWFae3+m27mATGcSHpw63dOWbtU/dWjECorwW19m//TF18Of7GMlyQIpkBUw9uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIDsVUJS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761866180; x=1793402180;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=gVUlXtGSVdAxL3nx3RZGXcLGtAi1uxysK3+CByRefvE=;
  b=TIDsVUJSb4mk1eRCCAxWZgi+omEBR3+Rf7ttpUUIGwhc2AQN8LCD3AG3
   qIaw5F7foY+GfmFRG1Gdn8fVs4mP1C+7gSVwUMQIUYBc3V4h14k42T+Ar
   NY+wh4z3kwsU8sFE501cZXfMOzYfPgxN3r/8zg9cumNq5ADoMN1AWclYv
   F1XpqAz6xEA+8Z9UNGRfLRFifWQEoX1pUXIWc3ctbt+peVqQDL5XupOAj
   Z+ubvLFQVzC/AqZRbsx9lirfgM512lajaHUkwhdOaP/vo+VuFmxKdRTLy
   48LvQry+HRyugOUyVGHviF302fyJtznslHBUEZXflR/gDUw1frvkPY4l/
   g==;
X-CSE-ConnectionGUID: L1Bwbs1WQfizIup6eCIfyw==
X-CSE-MsgGUID: 7xFn+914SxCpTtNV27uKVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64172651"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="64172651"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 16:16:20 -0700
X-CSE-ConnectionGUID: 9PyLxTr/S+WatqWkFq4ykw==
X-CSE-MsgGUID: vbKqN7kQS/yuEjYP+uJGVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="190432443"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 16:16:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 16:16:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 16:16:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 16:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNET74b5h0pbf+gj6CFnRUOLetwt/MAmd1mA6/8Ln2jTv2DYYzTCyK+CSnCgcQ73cn6ByEfdf8aQQX9evgJe4m1F2IPA+0JFRh90SxyJa6ICH1DpQNBnR7P0H0MNj0dwTYsrPMneDqGKQcMuxeoS5y2/wgenQCBxgyXtwAsIyv9V/add98gS4lXE2r93Pd6YnZxR+rYHdJeft4HM9oQvZ5/P9T+5iJchNAlY5B0v8r3CQt4h96sQUMgxUnO1D6I7aJ9q67SCb/vqv4g54rkEOTVsfYnA4kwvGiFgj2f5agUYm3HpSR0/fqJY5qMQQQ5FXkzUWFbJEAGGSrVIf/QzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVUlXtGSVdAxL3nx3RZGXcLGtAi1uxysK3+CByRefvE=;
 b=FxjwzkKlLIvgoXpTG2+5J60ObHhg+dsBdGOLHmldYLvIygTGwc7HOKvoCGPvNgYCl6k0TY5+XIAUdW5YW+9rdrgDAzFNY8LzxjLzsmz1bwVW0XJoSV7OO3fwvgJsFQIj+JJX/UFWCcO5gs2V2PIPDHFdBMbx4z8MXOc4VYH1ZNfo6PlyW53U5pigZxCZBMB4fZMWX+WBi/xCbBVhz8uqu0wzsC4QgZLpmHa5cvNliMD26kzwh6ZKQRc8v4swZAMipWSLo7o0aBqK8Ctysqn6PHYzMSfD89PcRxixmh8XGLytLlFKy6zXxm/uUBCt5oGeL/ZH30rsge5uoIJd5mtg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 23:16:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 23:16:16 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 16:16:15 -0700
To: =?UTF-8?B?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <aik@amd.com>, <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<bhelgaas@google.com>, <gregkh@linuxfoundation.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
Message-ID: <6903f1bf4c4dc_58c191003f@dwillia2-mobl4.notmuch>
In-Reply-To: <74df9e1d-69f4-43e6-89fe-3290b94ab8dd@suse.de>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-2-dan.j.williams@intel.com>
 <74df9e1d-69f4-43e6-89fe-3290b94ab8dd@suse.de>
Subject: Re: [PATCH v7 1/9] coco/tsm: Introduce a core device for TEE Security
 Managers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8e0957-34cc-4bda-e07c-08de180a5399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1JxVzJTaTNMVk1YMk45WkdCZFd4MFF5T1d6dGlaNEwzU2NYd2JWYXJORUN5?=
 =?utf-8?B?WktnWnJlMnp4QW5ycWJsZTJRL2h3M0MwKy9CV3R3NE0vWE15eWlWTmVnTmRw?=
 =?utf-8?B?Y1VSNzlzWWx3bzg1ZnBGV2t6L2t5VTU1bzdyQ2dkZTFOM0FxQ2JPUjBYOUtx?=
 =?utf-8?B?QXFtbUJOYk01TE5LZUVvaGplUWtERE1MMStjWkwzSFlzU2pWazV6Y0FFekNG?=
 =?utf-8?B?VFRKWWR2aWVpbW4vTDl5MUhBUHhjSHdHU1BzY2d0NGwwSGd6dDh4bEwwVWNC?=
 =?utf-8?B?VzR2WXJYN21MR3BwbXBKVFliMFJlUzFhenIyNnhzL0pDYUp6T2EvbVg2dzUx?=
 =?utf-8?B?bm1HTm9Yb2c1TDRlU0RqNnkrY3BJbE1oTndHQzhGOTVLZ2RJVGlWOGV2cnFE?=
 =?utf-8?B?c2xaelZiZkYrMGU1VGxBbytwQm1mYTJvNk5DZEJvRENSVVhxU0R5RjNVOHhk?=
 =?utf-8?B?ODNkUjdZU203S3RJLzNIajVDdVgxaTlxcXN3aTVOdkFJZ0RiT3FMOWtRbEh0?=
 =?utf-8?B?TXlWMm9ITlYvRi96ZXdHQ3VWUDlDdzJGb2o5ampKQUlkc2Y4RG04eFE1WVkv?=
 =?utf-8?B?c3B6emdTMkdIZmtZS2ZxcEF2Q1ZDKzdMQys3bVJkZHhkeUhFUU1LbnJrM0hZ?=
 =?utf-8?B?ZGlWRms0cmZaN2kzdk53c1pLRk1pOTUvYW9wSDNlK0xpWERGNWZxd2F5eDAr?=
 =?utf-8?B?UEZRN0ZtWkxXaVhhVURFM0IyR3FsZ1BUbjMzUE9sU2hNVzFrSGgzMHYybHhT?=
 =?utf-8?B?bDJmZ1ZnWnU1bHVJYUtPRGp3dW5CenlFS3VuSlNZb2RRRFlzajl1Y2tEcUVh?=
 =?utf-8?B?ZXRoc3M0MEFhbW03QUZoOFBrMXZVUExzVDhGTXAvL3Blb1BpdEVaQWZjMFJr?=
 =?utf-8?B?VWtpYmYvMXBFU2dmSzR6VzlyTkU2UlZ5Sjh5SE9BdEtWRE90cmV0b1VhMDBy?=
 =?utf-8?B?U1FQODZjUGNYSktvNHRudnZMbmtHanFDVjk4d3p5eU56UUl2OVd1MjdtNlNP?=
 =?utf-8?B?eFBUeG9CVnl6Z2FjTEx1Y0EyVVhabHk5Snk1T1NiQ0ZHdFNsYkZ6SitjMFo5?=
 =?utf-8?B?MGRUL3pFdDVGVlQ2ZnR5VzYzRWdSc244ei95WFJNQitvb1pQTWlFT1JUdE1S?=
 =?utf-8?B?M3JldmlnNjFIQjN3Zk5NTGJjWGRrcGFzUURBaFJrK1JNd0RLMEJEelJmcy9B?=
 =?utf-8?B?VHIxa0hTYVZXb2pxMVE1T3llZUZxeERIelU4cXRGTjBKYmh0NzdOTDFJMGpB?=
 =?utf-8?B?NDNjTHZHVWh1UjFwWTI4dnMxMVc3ZmJ1TUozQStNTVIwRXRGSkdiU2RMdUNV?=
 =?utf-8?B?SWMzWmtsRkN4dDRua2Z5Zy8rQkNkamlqb1VMdk1tUEpMTXBFQ093R0NPdXB1?=
 =?utf-8?B?aTY1cmNoNDBvZkNlZHg1TkVLK1dLVS9QaXZyakNZQTBVeVBhVHVQbU0xU2Iw?=
 =?utf-8?B?WXRPSVoyT3dJMWovOXhtWldoYzhFMUhxNDVkMWM4OXFEQmt0ZStuQ081eEYr?=
 =?utf-8?B?VnJoeDc4SWhoMGt3ak9DeUNKakk1UjhqMi9kNUdqNnpQaDUrTHJDUkJ2REQy?=
 =?utf-8?B?aHlWRHNYVk9wR1hJVGtPU0dBT2pvelJmMm56dHhONUdmQnR1WEhUQWRmU0hB?=
 =?utf-8?B?RUd2TzJJYUxkaW1lMTB1ejRzY09ORzdpN2ZjaG9ZRFovL0U1SndLR2xWY2kw?=
 =?utf-8?B?OEtST0R4QlZzeUtLNGZzaEJyV29mTmRQckgybmJSbHJHTkpmY05iZUhCekxC?=
 =?utf-8?B?WVBwWms1N1pSVW10eDdOeXladEhnQWVyMUVWS280bnJ3VDhMQ0hBNjJBRGlQ?=
 =?utf-8?B?SXV0bjRvZE5PUVVuK2p0WnZrcDY0UlVLZCtpc3NxaU0vaCtEYXU4OTBCMUpJ?=
 =?utf-8?B?T2lhRVhIOWhoa3IvZFk1Q2doQnRoMnV4QVprZHpYQzIzMUJNM05tclpJdElo?=
 =?utf-8?Q?pg25t1r1Xlzqq9M/v7r4CWqOUGA+N33k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3IycVdSbVlnU0NQbmRIMnpUdkpod0RIak5hejRTY2ROVytQVmFScm9paFR6?=
 =?utf-8?B?MzA4MmVRTFVBaWY4T1dVZTdsNS9OTyttOFlodkRlSm1NRDhDdm9La3prR1pM?=
 =?utf-8?B?WnZWbnRXRlJMK1lBQTg3VzRSZ2tXRXZuSW1pR21iK1VoRThkQVVnZzE2TCtl?=
 =?utf-8?B?Rk5NQUdFUjN3WTFPWGZxS25kaUtKbFg1NnphMXkxUmhBMGN0OFpzVDlYellQ?=
 =?utf-8?B?MFhQTVJuSlgzR0I1SnExU0dITzlYM3dRK004WjI5QVdXekIvVUtVZDYvUFVB?=
 =?utf-8?B?TDZaYWJvaFZuczlGU0RZV3U4VFRsaVJSdS9BKzBMc3ZkL0MrU1JuRnpOVi9R?=
 =?utf-8?B?bENkaU12QWx4WjlDczM5V3RYRzl1UWJvTTFHMjlVK09NNHhwZlhhNndxZE0y?=
 =?utf-8?B?VmFwbEtHZzk3RndHS1ZuTXlVZzQ1dnpXV2xoSklaRkJpQU5KcDdBbVpaR2sz?=
 =?utf-8?B?RHZHYjlSMmFBemRTdlRWdm5udm10Uzl5Smg2YkJmeVhUMDJQYlY0VUdBb2Nn?=
 =?utf-8?B?UUwzNnF2RjJPcTFLT1hqUVkwTDd4enlKS1N2ZHZBejNJMXRzOG5tYXJab0dI?=
 =?utf-8?B?MHJXQjFPQXJCTzArM2FWb0d6dUswcXh5eXk4Qk5tZEY1aE1ESDU5OE4vWTBz?=
 =?utf-8?B?dlZHandVU3o2bS9halMwTVJUbHNUMXo1VjJxZkRhQmR0MW0xQThMcCtqbXp5?=
 =?utf-8?B?ZFVNTENycm1pcXZyb2hoNm5VWHU3Q1FYYi9uVTJYVHY4STdpVjFOVFJnUFhN?=
 =?utf-8?B?Wk03L3NpaDkzNUNqSnFxbHpOQ0llTUh3Z2VheUpqNHlBU0EzdldTVTh5ekZZ?=
 =?utf-8?B?a3VLVUlDQlBpRnZ2cFRGM3A3eGc3b0VxVG5hWjRpd1A3YW85L1ZtZVE1NUto?=
 =?utf-8?B?eEVDVjFtSzdRZlg5UWJRRWQ4TllxcFRydDJPaDY3NG1CRHBKeElYUWdra3Rp?=
 =?utf-8?B?M2o0NFlaN05xVWpjdzNnaWoxeUlGYW5TYVhDUUxIUmN3d1ZwYlN1MTQrWHdT?=
 =?utf-8?B?MVpBL1hIOXJ2YWphdjM4RWxRMmNEMm1jVXM5TUtuQmk4VHdpMk4wYkdlRVJr?=
 =?utf-8?B?K2VZa2h0NFQ1R3pxVDJ3RFdqN1I2K09GWjJaQXNycmNIWDFuSkgyYnRTUFMv?=
 =?utf-8?B?T0RTanF2RElCUnV1dzNJRjBWZXNqUlhwbVBSclpNT3ptR1JtaU1FejVxUDlV?=
 =?utf-8?B?T2tKdnhhYXJ2RnhZc1ZIWU9RZDBvRW0xNzRjeFZkeHJIbHo4R1N2UzNqT3lD?=
 =?utf-8?B?b3FOeEdZYjloNWFURHluYks0RHk2K2doY0tGT0NMWWdWSXFpZ05ka3hNZ0lm?=
 =?utf-8?B?Q1J1ZWFHTThZbVpnMG5BU0xJSWNUbTRQTk5zMXNuUHlvS1JIYWwyckZGWm9x?=
 =?utf-8?B?cGdmbGg1NDBPblJGTWlDWWxUaERHZUNuNzBhQk9rdW9mbWEzeDZMVXk3VTNr?=
 =?utf-8?B?bi9DSjh3dTVwRTlHcEYxdm1wQmFFMzdJSmFUNXlIQkxqZFhkL3VpNHZmOXBo?=
 =?utf-8?B?bC9QeXUzY0VWM29oOC94RXB3aGVRQjRXTU81cTdQNzVsTk8vRkd4OWJBN1JJ?=
 =?utf-8?B?eVZFRjUzLytYcWFMTFlQeW5URkQ1QnBoZzlJRXlQb1NQbkNBYThCNDJFeTZn?=
 =?utf-8?B?WS9MWkU1dDBrV3IwTDZVNzhobW1nbkV4MmM5MGthL1pRaVM0ZzY5VHZGRDZP?=
 =?utf-8?B?UmphdGVjNjFYQTN3NkRXeUtyN3I1aXg3b0Zob2tDS2FpN0pGVjE5emc0dHJp?=
 =?utf-8?B?ZWFYNHJiS3Q0YmJZVVhxdWZsRXRDckdlTDlaOHhQbGQ1QUNKN1NyTWtpemN0?=
 =?utf-8?B?L0hZbVdheTQwdmNxU0JKYmVocHpKR25IeUhQNXRUTFhrTUZraEZFODIraW4v?=
 =?utf-8?B?elRaMlRMQWU1Q1dkZVR1SGdiZVpHcndGV09DSDhNRzgwUnFWcnRqQk9DRXFw?=
 =?utf-8?B?QmMrMlNzZHNvQUVHTmZqcStCMlFia20zdVh6Y1dCeFVaQ2tvQnJST1cwOWE5?=
 =?utf-8?B?ZDlQSXl0YWFLR2hRa04zWWdTOCtJdm1DanAraDhFZGc1c0RHTHRESVV3TU5I?=
 =?utf-8?B?bzc3WGlnVW1hcE9EOGhpV2dDRUk2TDNZKzNHdzIyaSthZkVSTmpXaExaMEE3?=
 =?utf-8?B?cG5SK2J4SWFCeUJnWEFuUEJLRVp2Si8zOWFnUUlLVHlvWTRWK2ZVUExya2Q4?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8e0957-34cc-4bda-e07c-08de180a5399
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 23:16:16.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j5nC30KTwzUL3Y+T/6tojVjNGe1kHwc6TSlzQk40mlQFQ5TB+ulK6oyO40j9wmm/BpMCvb1QQhxadOqE7RbETCCFYcDKTR58F/J60KixYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com

Carlos L=C3=B3pez wrote:
> Hi,
>=20
> On 10/24/25 4:04 AM, Dan Williams wrote:
> > A "TSM" is a platform component that provides an API for securely
> > provisioning resources for a confidential guest (TVM) to consume. The
> > name originates from the PCI specification for platform agent that
> > carries out operations for PCIe TDISP (TEE Device Interface Security
> > Protocol).
> >=20
> > Instances of this core device are parented by a device representing the
> > platform security function like CONFIG_CRYPTO_DEV_CCP or
> > CONFIG_INTEL_TDX_HOST.
> >=20
> > This device interface is a frontend to the aspects of a TSM and TEE I/O
> > that are cross-architecture common. This includes mechanisms like
> > enumerating available platform TEE I/O capabilities and provisioning
> > connections between the platform TSM and device DSMs (Device Security
> > Manager (TDISP)).
> >=20
> > For now this is just the scaffolding for registering a TSM device sysfs
> > interface.
> >=20
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.=
c
> > new file mode 100644
> > index 000000000000..a64b776642cf
> > --- /dev/null
> > +++ b/drivers/virt/coco/tsm-core.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/tsm.h>
> > +#include <linux/idr.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/cleanup.h>
> > +
> > +static struct class *tsm_class;
> > +static DECLARE_RWSEM(tsm_rwsem);
> > +static DEFINE_IDR(tsm_idr);
>=20
> The IDR documentation states it is deprecated and one should use XArray
> in its place. Is there any particular reason to use IDR instead in this
> patch series?

No, not really. I forgot that IDR is not just an xarray wrapper like
IDA. Will switch and would not say "no" to someone teaching checkpatch
to flag new IDR usage. Save others missing that note in
Documentation/core-api/idr.rst.=

