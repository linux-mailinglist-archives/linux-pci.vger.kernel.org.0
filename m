Return-Path: <linux-pci+bounces-26792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237AA9D5EF
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AE29A2C92
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 22:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E162957DB;
	Fri, 25 Apr 2025 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgMMTYo7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0A296146
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621523; cv=fail; b=sSVPmQ+uDR3lYSt4ZU3nCYTlBpBpmNFULj8QAI2znMJpr03RslF0lMAxXwa6owuCd5uw2NNGFisqg/vjzW36qtPX4VU057q/XOz6gnVxKodPjLtmjlTE7ezFhUuum6RUx+aU4tEkPwTxqKGSMm7sLxWiYU13DIcrBWAG4gSa7zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621523; c=relaxed/simple;
	bh=3ZUg6PZvaPgtCVxxZWZlmJpdFf1UCcSu8cSMbt/Xb3k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dR6Fzb5k5Pb3EcrsUX2xEyD7OyUXaQmQtZ9LvoeJhF8viSNTCZvcVsNUalt9TwUc7qsjW2Zh8S9sZ3B83IR/aFWvn+YVPXLm/UG1ltY3CL/BgLWg055acUlOMCHtLvzDDYj1EGrs+TFp5BTsB+FQ0DwdsY1jheAqJgwM/XVG6kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgMMTYo7; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745621522; x=1777157522;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3ZUg6PZvaPgtCVxxZWZlmJpdFf1UCcSu8cSMbt/Xb3k=;
  b=lgMMTYo73gdXyhe3NE9TdTdq6wecUTQWs7zh3In7M3WbtGYCvDQtOX8S
   x+AEydLmSIGEnRJprs/fPDVRqe5U+dziTZ/VIRIJKHh5qT4l8mKkol05t
   DiG3VVHB3w+P1ZE8/5BYhPZvsk4zk8Agp7Uq4DJKrMz0MSssaXSYIcrtp
   BgXDB2/qa0EHGkQUnQldOcQTDuLQCaGknzg0HF6UyI7e9T5AJOp4WbNli
   uilF3nmrzQ1CIu0AkN7vgIXqHl7TlfyG1CjB+NOmhw/diQdFbFqgo/12v
   qNE4fDLx+V/TtqXMfG7MIzCAR5SL9cm6KGU+aPPSZBJpwMx4yFCVA7lhY
   A==;
X-CSE-ConnectionGUID: yOlO1YhlRnqAkOUgRN9B7w==
X-CSE-MsgGUID: XQNnd1ASQIWKBszBdou43g==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="64821807"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="64821807"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:52:01 -0700
X-CSE-ConnectionGUID: qxvWHzBDTKmMj3btQNLTvA==
X-CSE-MsgGUID: GQi9/cuzRxaZG7nQv50XVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="137832023"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:52:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 15:51:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 25 Apr 2025 15:51:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 25 Apr 2025 15:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc3t3H4PlGnuFriZ0y4shOi4jsRfi5E/fWEH2tW1uZjO+pKmkLt82mw4R6+aWU8k5Q/fqtKmA9O9jYxFUbsmOoOr28bh0wveOeJZd4rloVpPfc3pV2/kD71D5qd8VG0zdRuMNfco9Fxk7iWULrDM3UuJ/uuzcD+a54Gs5iYJdoTfHwupB9kkqiE7vxCrdTw1EBTCzxfDTkCe/jIYn+cdliVY/P1gU2gQHYaEywNpsvLG53S+PUTOHEXmlpUDXHhW8arFLoOihdqzEk6DwB4kzQda8n6QBYUYNsLQttePweJS2dvzXvJE1QIMVSxHdNhOEAjwLgcAR3PDQao+QOZQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlytR2HcA143IE43QTndFlYXe2IvNKtKy0F3c3/6sTc=;
 b=Cq5MHDCADinx1WvCvkdSjhDYXakn03jWCTa2E/mz0z8mI7QZlGBrlOnEUF8OgP2rAwBmvUavyIWmCWXx4fdgh6c+NMnZx+dK6H2cXxniyMz94iG0x6PKN5h+sfJOnIhmgvxTRQFbnseuGQzazqg4sYy0bAcVF45y+7LNVqurGqxNw/0Gq/Hy0+3eWgv//q5rV/Kt4BHafZGR+PBfAFNhv+ojdo1c/YcfcfoThQObVja0CuobKCiP4autfA2TcCtE8sCb5/JVbtBVwlEmej12yRg7RMji21Y2e7yrGtG4hlZka2PrUxnHCvDJpnSz9COOvpAye2iLHLfsHskVmOwRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 22:51:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Fri, 25 Apr 2025
 22:51:56 +0000
Date: Fri, 25 Apr 2025 15:51:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <680c12098f63b_1d5229463@dwillia2-xfh.jf.intel.com.notmuch>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107248456.1288555.10068789075179290465.stgit@dwillia2-xfh.jf.intel.com>
 <yq5asem84qmp.fsf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5asem84qmp.fsf@kernel.org>
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: a10730b6-4f49-464f-7ab0-08dd844bc759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3pkcklGMDBpUGFoTFdxSkF2SHg5YXhFOWtZa0I3RW12MERWNXZSZERlWWFn?=
 =?utf-8?B?SFhXYzIzK3hWemwySXJQK1ZTd1JpWkxNK2NVWkZteHFySVM4bEdtQytlMFJO?=
 =?utf-8?B?WXlJSzhCU1c5MEExRWtNV05HYnhiM1NXQ0ZvSWYvSVpUK1ZWME96MVhzL1dZ?=
 =?utf-8?B?blBJTDBxb1pMOS9JWUpkNlpWWU1HNlYyV2hNQTFTVlZRTnFqUTZselh6Tk5P?=
 =?utf-8?B?Nm5jQVVUV01ITVdhWEZqVi9hVlFFSXhjMUxUcTNkMlFEYVd1V3FoU082YXkz?=
 =?utf-8?B?empwa2ZXRGZraFRNaE1jVWx1b3JvUnE3cEg2Mklnak1LNFVzZXFJdWtwR3hD?=
 =?utf-8?B?NUNSMklIbk9tVU9Mc3B5a0VmSTFPeFptOXlQbW5WZ082bVYraG1uZ2Nyc0ty?=
 =?utf-8?B?UkxRdm5UWG41cTNZa3BzTkNETHBHTWtUVGF6WGh5dmxUYVlsTDVrN0JzUXpU?=
 =?utf-8?B?eStHOUJvcGF6TjNuWm96WkYxM3E4NC82SmtYMjZDbjl5NGZtU3dvZHFHY0V4?=
 =?utf-8?B?ZXVlWWxtcVFTeWh6MFlVM1dhVkI1QzNzLzhOcTkvTmFPcDR0MjE5M1UwYmY5?=
 =?utf-8?B?VEFrK3Y3N2ZMOUZFbThDVFdvdDlLbW9TUUtPb0VxVS9LRitXaEJXYndyODkz?=
 =?utf-8?B?WkliVUt5V2lCMll6bTh6c2xvdVRzY1J3b3QwVWRyOUZzZE9vVk1kVXF6bTli?=
 =?utf-8?B?ajAzdHNOM0tPQUpvOStDTlV4MHZtT0tPQkRPWXNQR1h3OUxpUk9Zb2J5YThI?=
 =?utf-8?B?U1NXN2c4QnRnWkdpVHhaWFl1eFRxTXdsRGlNS1FNM0NNOTd2U0p6bENRRXR1?=
 =?utf-8?B?dXJ1dHJtNGxqMWZyUXBlRHc4Q2d5N2k3RDBBS3Q3eSsxVmR1eXptVGxDWk1F?=
 =?utf-8?B?SkYxdDNURzM0THBxV0o3VGJ1amJsbFptMDZ4V0hFL1piTndhRzdiQStjWTR6?=
 =?utf-8?B?UTZvblBDRllEZVRxbFE1dzN3ZFljOGRQdkw4YnBxdm9GdDFJUGVXalpZVmp2?=
 =?utf-8?B?TTd1eEg5Q0JzbWlrdUxzbGtlNS94SzRJeFJMcUllaDA4OUFPTDU4OHJZV2VY?=
 =?utf-8?B?M09PV2ZEaURvbjMwQVFLQ0k5RUduNWxJc1d0MjFFMEZ1ZWEyWjdIUFhxVy9a?=
 =?utf-8?B?RUY2N2FxdHZFZk5wZTgxNXk3OEkzQysrdTFaRkFxdHdPbzVlaVN6T3RacGpu?=
 =?utf-8?B?ZnNnMlRKaDV3cVUrTmVacEt2ZDVPU1FQOXBmYURiSlkySFVrR2RMTHBWbHl5?=
 =?utf-8?B?ZFFBbEZwMFBEcFFuL1gwcG1iVHRkcFp5NUFURFFQajR1MWFaRGJONmdEdGN1?=
 =?utf-8?B?TWRNamRxU2RMRWd2dEZJVG5aeXU1TmRwSUpDZjloeDdFSjJsVXZmUUhZZWx0?=
 =?utf-8?B?dUFUNm1oa3VCOTRER3JVVDFaN0E0WktlZG0wOGRnbmIrdkh6S3o3NGdRdmRS?=
 =?utf-8?B?dFZUUklEQXM0b2FUQ2tUOUxBd3dYb0RqaGJWRVlCVUlvYmdPWHZkTHhzWngy?=
 =?utf-8?B?U2hHUlgzSmNSdUgzVjZqZEhYdzhPTk1CK0JkTWloSXRFb3MwOVJUckREZTdK?=
 =?utf-8?B?eEZVSUx5WHJLSmdKTzZyWnc0QW9iWjRxZzk1MkcycVp3MWxOYWlsdko4emJi?=
 =?utf-8?B?ME5vQ0d3VzJnS1VqR1BXN3ZKM2VndDBMSW9GekE5UitxakxPNDBXdlgzQ3or?=
 =?utf-8?B?eitpUVdlU3F6b0hoT0Q2R09yamQ1Z21sUERWK21VWmF3L2lqY0FCalFDY3ZZ?=
 =?utf-8?B?NEY5R0lIbS9CRFgwaHdqZG1FNSswQmg2aWFSNk5Cem5wNU1jb0c4ODFSOUg5?=
 =?utf-8?B?MXUrWGlyYUNQaEZ1b1JqWWdiZ01JejJORkRoenNpc016TDVTSytWcjZ0bHdK?=
 =?utf-8?B?TGVvOEVJM1c5a05CeHVaci9weCsxSVNoYm55U0lPUlVacEJnaUlGdWlUNzNl?=
 =?utf-8?Q?J18qEyFdwHQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWptaVkva2lQK3ZQNEtqRWlzMnN6RDluUktSRzFVNzVKVE4vSnNYVUpzQ0pw?=
 =?utf-8?B?NWg1RVJrUFJXWDhNbmVPZFVMVFBrYUdFTkVjcVhsWHVIcDVCbVJOZWpqc3E0?=
 =?utf-8?B?U2VIeEJNQnRwYmFjWWZQKzR1UzIwL21Nd1ZXVWFreXZ2aXVkVjRXemNTN0pq?=
 =?utf-8?B?elVhanp5b08zNUZoSGQvU0FTSnNSSVRrNFA1UzJzTisrOXlGekFTNUFUK0ly?=
 =?utf-8?B?WlVBTzhpSFJBdXFPcEQybkpEaE5PYXZ3R0FCOWpNdlJIdzdHL3c2Y1h4bHZv?=
 =?utf-8?B?WWR4c1ZVZGc1bytmZWQ5MnZ2WEVxUElzYklHaEtXZEtHWVFwMWRXOFkyM044?=
 =?utf-8?B?NnBpZjFXS3VvN09yVU91b0p3bXRtcTBZZUp0R2F0b2R1d0RydWhaVWQxcmtm?=
 =?utf-8?B?aHRoRjhMQzRSeUd3YWdWTWZpcUZjQUhxTVFRWElXU0FaWnk5bksvVFlZT1k5?=
 =?utf-8?B?eUxaTGplUEhPZDJMaHpHalk1RW8vd3dpbytHa0JYSThKSjBkUEs0UjlGUC9i?=
 =?utf-8?B?YWhBWHdSNUszUk5qb0N2NzU1TGc4TXFUQVFubTdnd2pGUVVaRG5HdHBMSFpH?=
 =?utf-8?B?M1Ara2U1R3dNZWxPQzF2VzdsTHUzbUpsd2V1L1lTZVJrNFA2cEVxTHRldEVi?=
 =?utf-8?B?enNNMWhDTGZ3ZUkvYXF5Yjhlck9SVHBPZW54S3dsVjdSZUR1TXJ5bDU1aUZS?=
 =?utf-8?B?N01lZ2hNWnkvNWxLZVlXekJERDl6U0NhMHp1QklTZTFuYW5aRVRKV0RIekZl?=
 =?utf-8?B?MUpWTjN4ZkxBY2oyQ2lFV1gzcmhhb0Q3QlY4QlZaZnBZMy9KSGRMcXl3RjlT?=
 =?utf-8?B?dmtwUzdIb1NaZkl2OFAzYXVVMkZoV0l5b294TXVYZEo0S1VKUXRtQlpvdnI1?=
 =?utf-8?B?U3ZReVlGQUdUVU9RdithUnBqVzB4Z1RHcU5IbDlTOERqZzdNMWhsMFZLOXZn?=
 =?utf-8?B?MVM1YVY1Ty9kTEwzc2gyQ2FLOUFVUG5kK1RkVTNIeDZsSlV0bzZHamlHUmxn?=
 =?utf-8?B?Z0dadkkrNFJHQ0EzbUh1TE5HcUltWHB3dUZxdEZxWWYrVEh6WGI1UzViYUcz?=
 =?utf-8?B?OWZaYWJUd212NStENkpLUS9zREZtRFdsTzhzbEhmYmJJQzVpSEIvaUlIQlhq?=
 =?utf-8?B?TWpiUFR3cXR0blJmNnNlVXZFUGk4VUZDVnZzV2FVWkZnTTAyRER1TjRPR28z?=
 =?utf-8?B?bVp3S1A5eDdQeFA3WVRzb0xKT0RWMFBFWVFrd3RseHlOdlZ1dSt2Z29pemhC?=
 =?utf-8?B?U1U3bHNsT2ZWbDFZOXdyR2hsNjdpck0rakdKTEExOGhEL0V2Z1BHNXRZZXBk?=
 =?utf-8?B?YjZGeWEvd0s5NllMd25kNkk4aEZvd2cyK05WVU1NUVovM09FdUZFOWZuRDdX?=
 =?utf-8?B?ajhtQlVnSU1oZC83Y09DNm1wQlpONFE1MXNrczg2K1NJU0Q5RWo0RXlmckF4?=
 =?utf-8?B?am84TGdWYlh1cHdLdDVSaDh2Z0xlSHBTaWxVRGlqckN4UEhXZDFONXlnb2hw?=
 =?utf-8?B?TE41UU80NXZ1TUd3dWlzenJKcS9HVlZDV0tUWEtNVktNbVN6bm04KzgzOHlY?=
 =?utf-8?B?K1BsZVNQSHpZMVRBeUNMOFEvTW9CZndjaVk0ZmRHTzdENS95NFkrUG1iTDJB?=
 =?utf-8?B?SFdYbXREa21lRXNQSFVrZkV2N051WlVJMUJQaWFOYTdodlRNZ1VuY1YzVUJG?=
 =?utf-8?B?R1RYbEhGUmVpbmlXVHc5MUNiZjZ5TUM0MFhpbVIwUS83TU9UNlFBd2k0Ynh5?=
 =?utf-8?B?SEI3eFVVUWM3Vk9KNk4yeVJGMHo2OEVsYkpWUmE2QytZL2dVaks3ZlVNQ0Uw?=
 =?utf-8?B?TlVSeDI2emxCQmJsOG9FN2ZtVm5GOTZMY2ZJZFFsMHM0RnB0K3NuOVpTSXM1?=
 =?utf-8?B?OHdwc3BESVZaaGxNRkgybWV1ek95YkF6K0YwdUVXVXZVallWbmVYQ0JCdEto?=
 =?utf-8?B?SXFsQjB5U0dtWFVmd0RpOEYrTEpLRG9kcDdnNmdpVjNVVVBhTjMvdk4vamdx?=
 =?utf-8?B?aE9pMXFHMFJNenRxQlVRbHd1RG5JZlVwZ2tlcUxmbTFnY2Urb2VRSXplaVU4?=
 =?utf-8?B?TkgxcStJSVJGQVpzU1ZoWGFtb2dBMTJ2YXBRRldkRG5LMEp3YTVrWGlkN3k4?=
 =?utf-8?B?N3RKbDBqODRvSmNZY1Z0bktxYVVLNytGYnNIajN1SDdyMG5IYjNQQk10eUln?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a10730b6-4f49-464f-7ab0-08dd844bc759
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 22:51:56.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDFVQP0RVFZGtIPc9ju3Tq73k7PXkBYyvB8A4sCBwz4p5XfviL78vzq5YPAlFVkdenT0Q/E0EcSTrssm+IONbK0anSAuwphQmP58k82+SeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7600
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
[..]
> > +/**
> > + * struct pci_tsm_pf0 - Physical Function 0 TDISP context
> > + * @state: reflect device initialized, connected, or bound
> > + * @lock: protect @state vs pci_tsm_ops invocation
> > + * @doe_mb: PCIe Data Object Exchange mailbox
> > + */
> > +struct pci_tsm_pf0 {
> > +	struct pci_tsm tsm;
> > +	enum pci_tsm_state state;
> > +	struct mutex lock;
> > +	struct pci_doe_mb *doe_mb;
> > +};
> >
> 
> While working with a multifunction device, I found that adding lock and
> state to struct pci_tsm simplified the code considerably.
> 
> In multifunction setups, it’s possible that multiple functions may
> expose DOE capabilities. In this case, when sending SPDM messages for a
> TDI, should we always use the DOE mailbox of function 0, or should we
> address the mailbox of the specific function involved?
> 
> If the latter is preferred, would it make sense to rename the current
> structure—currently representing the base pci_tsm plus the DOE
> mailbox—to something more generic? because it is not more tied to
> physical function 0

Just wanted to circle back on list for this discussion we had off-list.
Specifically, that even for a multi-function device the SPDM session and
IDE setup belongs with physical-function-0 (per PCIe 6.2 11.2.2). So is
it really the case that Linux needs to contend with non-0 functions for
IDE_KM and TDISP?

