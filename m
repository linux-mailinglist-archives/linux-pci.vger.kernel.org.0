Return-Path: <linux-pci+bounces-45275-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKj1GoOrb2lUEwAAu9opvQ
	(envelope-from <linux-pci+bounces-45275-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:21:23 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5E47577
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BD7A9C5C75
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4444E027;
	Tue, 20 Jan 2026 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0PdJOML"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612C40FDA3;
	Tue, 20 Jan 2026 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921684; cv=fail; b=JGLryeIzig1qLmVcWAydlFXPRSSEqktMDQL3WglWhdZNaABmkQ578RUmnFwidHz0HAtuWNVMDckmr6QEQyw/zf7cCIWw1rfd8feo+zu2iBaM7N49vTblshNiq4h8EkwqSD5ff9XBICayINFG3rBzcSn5zTPUkNfGDyEmOh48VRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921684; c=relaxed/simple;
	bh=fUiJ+nmQr10MUKgDv9segLPv+DPaEs742TfuIzYIljo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OR9MBC/nL805USMUJ6t+2XK88YaMpauYqhnGjShlfQk8c447kTqVqpN0w3ocrqFj2/bTMryFadsDCGzVipj6+k9AXmA1eem15Wrv/iFOT2ikgoFkCVZIRKPRxZjD47e+y4DZyTQIjICUGeVLa/qMIlbkfwHt1M3QxuUTRyRok3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0PdJOML; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768921682; x=1800457682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fUiJ+nmQr10MUKgDv9segLPv+DPaEs742TfuIzYIljo=;
  b=J0PdJOML0dqzUxEi7d5gju4/X4VH3DVToB7pv/9CKVG3t/aaqnLw6GoN
   NYP8X/hQrXtgcQ8Z/IE9tARd5n/fMEW/IiXK0LsLiD8tNtrWtDJhH81BU
   OVek5qwTEdHTe1sJ6V7J2NEnJpxUao9Y2t6RuG4sP5ykakWuHfr1ZXv+B
   wlnq7p9A8f9OSpkcKZ4PSj1cwLv8b+FQ785a7IuqCAjj/g+b0Rns4JB+F
   ngU9cl42xESwtj52y8aMr4oT/rkRwK31m0evamF1rlUoEhGsdMBTtTkw6
   Ld1o9FL1HSgy/dPmSNG7QhJEEfZkZ4JPSNdP1rtPAZRchY9hsgRAHqr0n
   Q==;
X-CSE-ConnectionGUID: tmEZIujXQQyO9TeBPaKpSg==
X-CSE-MsgGUID: j5kPQ+4yR7mjK4DrOMuimA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70224173"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70224173"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 07:08:01 -0800
X-CSE-ConnectionGUID: dMgp+EpUSkqFkHu7inPqQg==
X-CSE-MsgGUID: Dx+pMC8PSIy+vspNO2CHoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="236824233"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 07:08:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 07:08:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 07:08:00 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 07:08:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPUHOuRCaoMSUDexnKre9fl0DUzSTrOneGIYVFnVC5m3CWtA/YRQP82DSdGigu+Jq+FjY9Cab1jJF8MKxVbzshN9Yb8EBQ8t573wn95SJrAE5SRBeT7yTkqX42od8xCJZkmUn57QAOOz1gncQ6h6df2UTL4+YLz4Ubnf8ZEJbbsbt28Yg4jl7hQWRyiG0OEF3Nv1iNi0arPGV9Dv8vwZjyTO3RICDR2zKw96M0t9N565tFwtM3p8izJimcRaowY/QYexyOWYYKM8+g91wf8cZc3o2bXRGSvILyZCURSaV0c6p2iUMWLajWWdhG97hMmXYaH99NUUlk9vF3W6/bYs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUiJ+nmQr10MUKgDv9segLPv+DPaEs742TfuIzYIljo=;
 b=uV+bCjreZSDlr5aAO9Jx0zyqcFE2WgRcLYDQFBy7KhdmnHK76ry3hzeUwsEWw2blroTStBEehCymI07zSXTBe9tTH63Pv0QxPMfOeWoTKuFBVCm9C0q4u4X1gJ090ksGnsLW5HoQkRDgfiv9Vx36uIeGvhO9zfm3EwUm4JzVpURBxsFlqd8dm+1c4yynr0/DWjHPDJ1xvgNUiyHloD470GHH6tqcu9gbWGep2exan+KEITaq9M6jtbUFKquJsU+ZEPO36HU8KJBBHvb1nJIOvV2eOw4DHuBFMb3rq/Ebh7pAnyyfuVMOrgPzuGesM4+PQwmWLN0HBMfNr6h3piA38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 15:07:51 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:07:51 +0000
From: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
To: "Nilawar, Badal" <badal.nilawar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Anirban, Sk" <sk.anirban@intel.com>, "Jadav, Raag" <raag.jadav@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "Shankar,
 Uma" <uma.shankar@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Gupta, Anshuman"
	<anshuman.gupta@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Poosa, Karthik" <karthik.poosa@intel.com>, "Gupta, Varun"
	<varun.gupta@intel.com>
Subject: Re: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
Thread-Topic: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
Thread-Index: AQHchKo81Eb9JYFcLUSOg4KLHyrMCLVTTCgAgAAQ24CAB7rngIAAG9aA
Date: Tue, 20 Jan 2026 15:07:50 +0000
Message-ID: <75d22740108e26a78e2069b7e03e3235f12e8fa0.camel@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
	 <20260113164200.1151788-20-badal.nilawar@intel.com>
	 <64894565d5eace99fd65f290ee807dabaa2de04f@intel.com>
	 <aWkG5cEapt_attfS@intel.com>
	 <431ce6be-b083-4002-8dc1-4be8e557d07c@intel.com>
In-Reply-To: <431ce6be-b083-4002-8dc1-4be8e557d07c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8430:EE_|PH0PR11MB5143:EE_
x-ms-office365-filtering-correlation-id: d02860c2-cb71-4469-d24c-08de5835ae57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?STgzOFdrdjZrRzJZNG91NjR5MDZLdEkxS3ExaDQxdUVBdVJpQmVMRkZ0TWQ4?=
 =?utf-8?B?RDNlL1BMZ0RSMmdRdlhScU5naHRFUFB5aTIxRXBUbzNuN3p1S285MHJSZGdn?=
 =?utf-8?B?WUxZVCtrMlhYeWVvSmtERWJ3YTdmRDBKQXQ0d0lzVWp6U3QzeEIwMEo5L0NP?=
 =?utf-8?B?RldlVUlGUEFMcWhSMEtXWXV4dlQvcU1oK0hiQ0tpNjdrOFJwSTRLYmtiUHFw?=
 =?utf-8?B?QVVlam92b0FtOVloVmoxVWVzd2hRUHhXM0V6SXdaSHo2cUxGWksrRzB6Q1Zk?=
 =?utf-8?B?MkFZMG1POHFyVW1oZ2FtRUpTdG41Tlh5YlJZMXEzbTBObVJSWVlkUWNHU0dq?=
 =?utf-8?B?QytuWDdNaDUzUXVoRE83NkhsWCtLdkV5VGNwc1BJOWRsVUhwWGtWc3RnZ1JQ?=
 =?utf-8?B?QVNpS09CL3laWW54c0xMb3FBU1ZPeXJNNkRISDNhNjExK2dZSlFDeVJQRjRq?=
 =?utf-8?B?b2Z6OERBcGhCVDBJMmJVRlVDWkRTTDBUYzZ4QlpxdnovczZnVDFjcHRJTE9U?=
 =?utf-8?B?YzN0azlKSmlOVHovR2ozVkxxNk1sM0VaQzJDUFluUlZBdVV2dU8yTlo3NEth?=
 =?utf-8?B?bUFUY2tVMHJQZk04dmEwM0dncW1DVFR6TzVlc29FWW9BSndqUjNUSE14OHo1?=
 =?utf-8?B?am1Ea3hvSUxuZEN6K2Yzd0IxZm5xekMxRTZXMXM2eVNPa1F6NUdzdHpqR01u?=
 =?utf-8?B?NWkxU1NWVlFWWEszamNuV2g4eTIxZEQvTHBUazZ2NVZTVFVPYzRtbUJQaitn?=
 =?utf-8?B?VFRDbEZhOWp5czlpUU90MTZyTk1LanFiTUFLVXFRZmE0N0lCUHlFUXVsdGtx?=
 =?utf-8?B?VXk0Z3cydE9QSTZsOWhCNkhqZGFKUUJaY2hSUTFHbjRpTm1HN21lNlFaZlRQ?=
 =?utf-8?B?VnlaelVINmVsODd3M0xaalN6dEtpd3E1MzNUTytFdTNMVEllaDZyZCtJdy9p?=
 =?utf-8?B?UUNuYllBaGlxUkh5UDVEMlp6WVhrMlVMbDZOMVAzQUdnREFaTllsSzVLQjhQ?=
 =?utf-8?B?WHFzekZlb1plMFJQSVRMTE9GOUw2OGpTUkVxZXdhYWxRcWZZd3Eyc0pWZVYv?=
 =?utf-8?B?WFRtVGhETFEvOXFRNjc5dmcydGtBcjIzZHRpbkVvVzB2T2JBOE5OZUJJczlU?=
 =?utf-8?B?Q0RsaElJUldPSmI3MHk5dFdEamJLYlF1dUM5NTVYODlkK1NDK29sckZUd2pi?=
 =?utf-8?B?THhtNUd1a1N5RUVqS3lIbVNxUTVqYy9DNDgwdHVORDVFTytlMmRvdGxOMHF6?=
 =?utf-8?B?d2VwUmxTbzRtbDdiOE5reU9zVTkzVUdZa08waFRjY01NOFBYVXZNNXVGRUow?=
 =?utf-8?B?VzFCaDJKRWxZY3RvczZHajRmaVNEaTdYVDJ6MkYreFBzemI2eldSUkFrdnBa?=
 =?utf-8?B?N2hmZU12RmlzZTQ3bE5pcXllVCsyTGVNVGJsbW95ZWRsOGl0alJYcFFWbno4?=
 =?utf-8?B?UUJleXRYajBYUEF4dElRdzZuUG4rNEJVMmlFeTRHbU55clFKbytybVRqRFZP?=
 =?utf-8?B?UEo1ejhKb2tkWEVGU2MybGcrSVcvVzJvVnE4Yk5lS2VuMnpYbEdldnBRczYr?=
 =?utf-8?B?UjhEajZmemwxV1M3eHRoaTQ0ZDVXK0p1THU2eVVVcFJZdStLVDNnaVd2enFn?=
 =?utf-8?B?NGRhRE5ibHduR25nbm1pMWJ4WE1UVVFJdXB2bVNmSU5NYm1hQTZ2Um9TVlV5?=
 =?utf-8?B?SlI1dDBGS1d3SUlnVTBBVEw0bzA2NTJLSjd6Mm1VU1FkaktLSTJkd0c3RzY2?=
 =?utf-8?B?eXNYdXZMMkZrWTNrbGh5dEJSdHZkUUs0aVFNUkpYSjgxdVMwRFhPb2JmeE90?=
 =?utf-8?B?NWxLVkRsaFlDOUsxaVdpcTZCRldjaVF5RFFKdEJMWjkrMUtmUnE2RW0wdFdj?=
 =?utf-8?B?K1BocXZzUTJtSTV0bW9PNUlPZEx1WUUvRTZjK1ZIWUxML2FMdlVTYmQwOTFR?=
 =?utf-8?B?MFZsVlNmSkV2UE1RSTAvb1JzdVJTbHcrZ3M0bG9SNHNKZUF2T3pVQzRKR0Jn?=
 =?utf-8?B?WCtRMkdUN1ZMYmR6MGlLQkxwbXViSkd6amxQZW1zSmNQNmFZZHc0bGhHU2d3?=
 =?utf-8?B?OXNLWGlBNDQ5VlEwQTlBZUlYZmNqRkx0YW5rN2Vpdk1ZTjNUaEVReFNuV3FW?=
 =?utf-8?B?V2VxMjNab3NEbGdiNWRkcGo2a0ZrcnhicnRlMmczL1ZyaWdBamlXa3lnVkxO?=
 =?utf-8?Q?1umPUVvbgotS3Rg8mMsqlcI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWpvK01GeEo0R1V2QWVYQkpPSExDelhORVB1dHA2OWRJa3cvWndkQWtqeDR1?=
 =?utf-8?B?RSttY2ZiQ1VOZ2ZKcDJ0ZnpXeWdRL1dmbTg4YUNDWUZVTXNmZW03bUtxK1o5?=
 =?utf-8?B?Y1owWnk3bnl4a2g3eW1FTVpvaHcraWsxZTBkVWJabXM2K3lYczJxeGVFRVpC?=
 =?utf-8?B?L1MyU1dPUlNrQnBFbktNZG5nTW1RdmlFenNnbExoTlV4eDkvb2ZKR3NkRmFS?=
 =?utf-8?B?Z3J1b2JSVDRGL1VFSVlNY3FtcXRRL1VNTDVtSG9WOE1JZDhPaDdPU3MyR0NS?=
 =?utf-8?B?RDZPVnM4dEJ0enpyRS9nWXVoQkhBVlRIUi9LN1N2L29RVC9zZEhLUVlsYWFr?=
 =?utf-8?B?UW1Tc00wN0NPcGwwT0srUFNjTC9HdS9xNDU5aG1DcEF6di9iV0hkeEJQL3V1?=
 =?utf-8?B?RlpGWVVPMVpjTUVpOFpLOHlxcGM3REJJTUxjdjJXR1h2V2JjYmRQWW1lOU0y?=
 =?utf-8?B?TEp3NVFoT09JNzFIcjVvSXpTd3orMTNsYjExR1ZOcjVmOW1DNjc3SnIzTTJp?=
 =?utf-8?B?SUlzeHQ1WDZPbjV2NjFOWmdKQ2VMNXRPYU9Fc2h2aVFUZWVtMC9ETzNXU2pU?=
 =?utf-8?B?TEoyYzFtL1BHZVN1RTVJQnlaM1ExQTltejMwWW5jTk11QmR0cW1qR2ZCTFov?=
 =?utf-8?B?VjFvMFV3MTNNY0RGenhxOFNMNDhNRWkxRzl6bEdIZ05tRmY1Sld2UEUzNHpm?=
 =?utf-8?B?K1F2NExiUk56eEJrV0Z0bWoxeFVZcFY0b2k4bkRKMjJzSTlZTTE1anFKZU9I?=
 =?utf-8?B?bUg5R0RZVWkxWUFmUk1oUTZJZVlaeDgydHBUb1VXTUZRQ3k5U2U3UXY1a3c1?=
 =?utf-8?B?MDFBNXhqRENkMmllNnVMcFdES3VwRUtZeitxNkVFRDFMWDJRREI2S0pqL1JR?=
 =?utf-8?B?VFNEKzlTejZXdWtGT3p1UklpR3ZiVmptUkJkcWdLWHoxeXlnMkxkcG9LOVlX?=
 =?utf-8?B?RFl0eGx5ODVsMFh5dXpDMVJTWUVoUFJhMndSaWd3MXN0YysrV2duWGhsMDhh?=
 =?utf-8?B?VnBSdUcrcUN6bTBJaXZNbGNMYmlicndSOVN5L0FWL1djWjRGY1p2clAxWWE0?=
 =?utf-8?B?TmQvcVAvVVY3WHJqZGhRVzhWZENlSW5NOGJ4S0lWeUFnUWxIL0xaTnRKWXh1?=
 =?utf-8?B?Si9ZVWFFK1k2VXNEZE90TW1sTDdNZmd2QThuc2NPWGl2NEgrRnRRcmlLSFJh?=
 =?utf-8?B?c2I4TW5jblJ2aXdQOEd5dFJVd2FjKzB4NVlZWHVpeFpQS0VlcmtFcmlnelZq?=
 =?utf-8?B?QlUwVzNhNlpQZUZLSWpuK1p6My8wdjdDeDQrSzRmUExqRUZEWnhMeDQrVHBG?=
 =?utf-8?B?SzZOOUV1YU1IdGlQSXJsZGFtemtCR2Jzdy93N3FyMjFlRjdJSUpSd29INFR4?=
 =?utf-8?B?cjB6UDJLYXMwd1FEemZlUEVyVEEzQ01sTnY2eDRwV0pqWWlRQ1pRTXY4S3Nh?=
 =?utf-8?B?SjlEd3kvUnVJQlc4eGpzSk1uZllHSmRaZFJQOTN1OUN5eVZBc0ZNeVorTk5E?=
 =?utf-8?B?TXRoSW5iRENRSVJrTWVyVFhQVGlYc0hDWm5XQndxdGkxV1pDY3VZdUorK3Zv?=
 =?utf-8?B?WE1PY0JyNUhrNmk0M2tlYWhSVDhLa1N2cTJXQzFuYUUyS1BKcGRFenhNSGF5?=
 =?utf-8?B?RFNRem8vM2lkL1Z6RE9HSnVUc0ZZRzZ0SklQeVhhbDYvQXNoSnJZSkU3cDlR?=
 =?utf-8?B?ZmZyaVczemxHd0UvKy9HcHpYTVdNZklDeHA5VjI2TVdlcXhNNHFrMUo1VFJs?=
 =?utf-8?B?ai9sUHQ0VStWSWFjNFVsMEN0UklrZWNoNGp0c2ErdVBVamdpK0FlaEo3bGZ2?=
 =?utf-8?B?SG41YVFOWXRpdFdIcmxiSElURzF5MzlIN1ZrblJqNVJ5a0NHc0Y2VEhBQkJB?=
 =?utf-8?B?TGIzcFNqZ2Q3cW50d0NWQ2ZEMEpKNmU5TjJBZ0JMU1BmUVcyeDg0UEZjV3Ra?=
 =?utf-8?B?TlljamRzSGxWVG1Cc3N2cFh2d3B0a3pBU3BoYzE3VkZUSytIeXBaZlVTZkhY?=
 =?utf-8?B?U1ZGR0xRNTdqUVpNeWdLbmRMYmpvNlBOQnFNb0IwZWpVdk5UVGFmaXl6SVBZ?=
 =?utf-8?B?WjdrcUE1a01EVjZNWUNHeUE3SzVHRHlEQXM1b21kWHB2ZzVpOG96c3NvWWxp?=
 =?utf-8?B?YThmbVFydGJjRXNlQXVjN1lPRUtWWmxka20xTktCaWJCQTMzRUF0TGhQMzAz?=
 =?utf-8?B?TmNuSjN2Wk40V0haZDBPT2haQkFJUnZRd3ozYUdVbGFVc3ppdnllc3dGYXpl?=
 =?utf-8?B?S3lOUzYzMDFLY0RSejFWTE1LcXdMNXByOHJGZmZqTUQ0b0hhc3FST2s5bC93?=
 =?utf-8?B?SXZHTVo0MGNyMm9FYVhXSnRnMHdKemFKUFBRTWRFRERjeTNPYnF5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <479277D4E519F8439207499D12E908FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02860c2-cb71-4469-d24c-08de5835ae57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 15:07:51.1487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61EUYnfEdoJbcwwyclclGio5vyY4Icf/HyrtuBxU6b9Bfc+BI9DkAnSjM5hfjd8CzqTtEq25ZSIILHjI1gy8EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-45275-lists,linux-pci=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rodrigo.vivi@intel.com,linux-pci@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pci];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A0A5E47577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAxLTIwIGF0IDE4OjU4ICswNTMwLCBOaWxhd2FyLCBCYWRhbCB3cm90ZToN
Cj4gDQo+IE9uIDE1LTAxLTIwMjYgMjA6NTUsIFJvZHJpZ28gVml2aSB3cm90ZToNCj4gPiBPbiBU
aHUsIEphbiAxNSwgMjAyNiBhdCAwNDoyNTowNlBNICswMjAwLCBKYW5pIE5pa3VsYSB3cm90ZToN
Cj4gPiA+IE9uIFR1ZSwgMTMgSmFuIDIwMjYsIEJhZGFsIE5pbGF3YXIgPGJhZGFsLm5pbGF3YXJA
aW50ZWwuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IFRoZSBWUlNSIGZlYXR1cmUgaXMgdG8g
ZW5oYW5jZSB0aGUgZGlzcGxheSBzY3JlZW4gcmVmcmVzaA0KPiA+ID4gPiBleHBlcmllbmNlDQo+
ID4gPiA+IHdoZW4gdGhlIGRldmljZSBleGl0cyBmcm9tIHRoZSBEM2NvbGQgc3RhdGUuIFRoZXJl
Zm9yZSwgYXBwbHkNCj4gPiA+ID4gdGhlIFZSU1INCj4gPiA+ID4gZmVhdHVyZSB0byB0aGUgZGVm
YXVsdCBWR0EgYm9vdCBkZXZpY2UgYW5kIHdoZW4gYSBkaXNwbGF5IGlzDQo+ID4gPiA+IGNvbm5l
Y3RlZC4NCj4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgeW91IGdldCBmcm9tIHRoZSAxc3Qg
c2VudGVuY2UgInRoZXJlZm9yZSINCj4gPiA+IHRoZSAybmQNCj4gPiA+IHNlbnRlbmNlLiBQbGVh
c2UgZWxhYm9yYXRlIHdoYXQgeW91J3JlIHRyeWluZyB0byBkbyBoZXJlLCBhbmQNCj4gPiA+IHdo
eS4NCj4gPiBPbiBhIHNjZW5hcmlvIHdpdGggbXVsdGlwbGUgR1BVLCBvbmx5IG9uZSBjYW4gdXNl
IHRoZSBhdXggcG93ZXIgYW5kDQo+ID4gdGhlDQo+ID4gZmVhdHVyZSBpdHNlbGYgd2FzIG1haW5s
eSBkZXNpZ25lZCBmb3IgdGhlIGRpc3BsYXkgY2FzZSAtIHRvIGJyaW5nDQo+ID4gdXANCj4gPiBk
aXNwbGF5IGZhc3RlciBhZnRlciB0aGUgZDNjb2xkLg0KPiBUaGlzIGlzIHRvIGVuaGFuY2Ugc2Ny
ZWVuIHJlZnJlc2ggZXhwZXJpZW5jZSBvZiBwcmltYXJ5IGRpc3BsYXkuDQo+ID4gDQo+ID4gQnV0
IHllcywgdGhlIHJpZ2h0IGV4cGxhbmF0aW9uIGZvciB0aGUgd2h5IG5lZWRzIHRvIGJlIGhlcmUu
DQo+IEkgd2lsbCByZXBocmFzZSB0aGUgZXhwbGFuYXRpb24uDQo+ID4gDQo+ID4gQWxzbywgYWx0
aG91Z2ggdW5saWtlbHksIHdlIG5ldmVyIGtub3cgd2hhdCB1c2VycyBjYW4gZG8gb3V0IHRoZXJl
LA0KPiA+IGFuZA0KPiA+IHBlcmhhcHMgd2Ugd2lsbCBoYXZlIHNvbWVvbmUgd2l0aCBtdWx0aXBs
ZSBjYXJkcyBhbmQgZGlzcGxheQ0KPiA+IHBsdWdnZWQgaW4NCj4gPiBtb3JlIHRoYW4gb25lPyEg
V2UgcHJvYmFibHkgYWxzbyBuZWVkIGEgZ2xvYmFsIGNvdW50ZXIvZmxhZyB0bw0KPiA+IGF2b2lk
DQo+ID4gYSBzZWNvbmQgb25lIHRvIHF1aWNrIGluLg0KPiA+IA0KPiA+IEJ1dCB3ZSBkZWZpbml0
ZWx5IG5lZWQgdG8gcHJpb3JpdGl6ZSB0aGUgZmlyc3Qgb25lIHdpdGggZGlzcGxheQ0KPiA+IGNv
bm5lY3RlZC4NCj4gQXQgcHJlc2VudCB0aGVyZSBpcyBubyB3YXkgdG8ga25vdyB3aGljaCBvbmUg
aXMgcHJpbWFyeSBkaXNwbGF5DQo+IHRoYXQncyANCj4gd2h5IGNoZWNrIGlzIGFnYWluc3QgZGVm
YXVsdF92Z2FfZGV2aWNlLg0KDQpUaGlzIGlzIG5vdCBteSBwb2ludC4NCg0KSW4gY2FzZSB3ZSBo
YXZlIDIgZGlmZmVyZW50IGRldmljZXMgd2l0aCBkaXNwbGF5IGNvbm5lY3RlZCBvbiBib3RoDQpk
ZXZpY2VzLCB3ZSBjYW5ub3QgZW5hYmxlIFZSU1Igb24gYm90aCBvZiB0aGVtLi4uIEJ1dCB0aGlz
IGFwcHJvYWNoDQpoZXJlIGlzIGVuYWJsaW5nIG9uIGJvdGggb2YgdGhlbS4gQW5kIHRoaXMgd2ls
bCBicmVhayB0aGluZ3MuDQoNCkFsdGhvdWdoIHdlIGNhbm5vdCBrbm93IHdoaWNoIG9uZSBpcyB0
aGUgcHJpbWFyeSBkaXNwbGF5LCB3ZSBzaG91bGQNCmJlIGFibGUgdG8gb25seSBlbmFibGUgVlJT
UiBpbiBhIHNpbmdsZSBkZXZpY2Ugb3IgbmV2ZXIuIEhlbmNlIHlvdQ0KZG8gbmVlZCB0byBoYXZl
IGEgZ2xvYmFsIGZsYWcuDQoNCj4gPiANCj4gPiA+IFNvIHdlIGhhdmUgeGVfcGNpX3Byb2JlKCkg
LT4geGVfcG1faW5pdCgpIC0+IHhlX3BtX3Zyc3JfaW5pdCgpIC0+DQo+ID4gPiB4ZV9kaXNwbGF5
X2Nvbm5lY3RlZCgpIC0+IGludGVsX2Rpc3BsYXlfY29ubmVjdGVkKCksIGFuZCB0aGF0J3MNCj4g
PiA+IHRoZSBvbmx5DQo+ID4gPiBwYXRoIGFuZCBwb2ludCBpbiB0aW1lIHRvIGNoZWNrIHdoZXRo
ZXIgZGlzcGxheXMgYXJlIGNvbm5lY3RlZC4NCj4gPiA+IElmIG5vdCwNCj4gPiA+IHRoZSBkZWNp
c2lvbiBpcyAibm90IFZSU1IgY2FwYWJsZSIsIHdoaWNoIGlzIGp1c3QgYSB3ZWlyZA0KPiA+ID4g
Y29uY3VzaW9uIHRvDQo+ID4gPiBtYWtlLiBUaGUgKmNhcGFiaWxpdHkqIGRvZXMgbm90IGRlcGVu
ZCBvbiBkaXNwbGF5cywgZG9lcyBpdD8NCj4gPiA+IA0KPiA+ID4gSWYgeW91IGJvb3QgYSBkZXZp
Y2Ugd2l0aG91dCBhIGRpc3BsYXksIGFuZCB0aGVuIHBsdWcgaW4gYQ0KPiA+ID4gZGlzcGxheSwg
bm8NCj4gPiA+IFZSU1IgZm9yIHlvdT8NCj4gPiB5ZWFwLCBpdCBsb29rcyBsaWtlIHRoZSBjaGVj
ayBpcyBpbiB0aGUgd3JvbmcgcGxhY2UuIEl0IG5lZWRzIHRvIGJlDQo+ID4gY2hlY2tlZCB3aGVu
IGdvaW5nIHRvIGQzY29sZC4uLg0KPiANCj4gWWVzLCBWUlNSIHdpbGwgbm90IGJlIGVuYWJsZWQg
aWYgZGlzcGxheSBpcyBub3QgY29ubmVjdGVkIGF0IGJvb3QuDQo+ICpjYXBhYmlsaXR5KiBkb2Vz
IG5vdCBkZXBlbmQgb24gZGlzcGxheSBidXQgVlJTUiB1c2UgY2FzZSBpcy4NCg0KVGhpcyBsb29r
cyB3cm9uZyBkZXNpZ24uIEkgYWdyZWUgd2l0aCBKYW5pIGFuZCBVbWEuDQoNCj4gDQo+ID4gPiBN
b3JlIGNvbW1lbnRzIGlubGluZS4NCj4gPiA+IA0KPiA+ID4gPiB2MjogTW92ZSBnZW5lcmljIGRp
c3BsYXkgbG9naWMgdG8gaTkxNS9kaXNwbGF5IChKYW5pKQ0KPiA+ID4gPiANCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogQmFkYWwgTmlsYXdhciA8YmFkYWwubmlsYXdhckBpbnRlbC5jb20+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFuc2h1bWFuIEd1cHRhIDxhbnNodW1hbi5ndXB0YUBpbnRlbC5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2Rpc3BsYXkuYyB8IDIyDQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4g
PiA+IMKgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZGlzcGxheS5oIHzCoCAx
ICsNCj4gPiA+ID4gwqAgZHJpdmVycy9ncHUvZHJtL3hlL2Rpc3BsYXkveGVfZGlzcGxheS5jwqDC
oMKgwqDCoCB8wqAgNSArKysrKw0KPiA+ID4gPiDCoCBkcml2ZXJzL2dwdS9kcm0veGUvZGlzcGxh
eS94ZV9kaXNwbGF5LmjCoMKgwqDCoMKgIHzCoCAyICsrDQo+ID4gPiA+IMKgIGRyaXZlcnMvZ3B1
L2RybS94ZS94ZV9wbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA1
ICsrKysrDQo+ID4gPiA+IMKgIDUgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfZGlzcGxheS5jDQo+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9kaXNwbGF5LmMNCj4gPiA+ID4gaW5kZXggODFiM2E2NjkyY2EyLi45N2M3NDI3MmZiMTkg
MTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
ZGlzcGxheS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfZGlzcGxheS5jDQo+ID4gPiA+IEBAIC04NDI2LDMgKzg0MjYsMjUgQEAgYm9vbCBpbnRlbF9z
Y2Fub3V0X25lZWRzX3Z0ZF93YShzdHJ1Y3QNCj4gPiA+ID4gaW50ZWxfZGlzcGxheSAqZGlzcGxh
eSkNCj4gPiA+ID4gwqAgew0KPiA+ID4gPiDCoMKgCXJldHVybiBJU19ESVNQTEFZX1ZFUihkaXNw
bGF5LCA2LCAxMSkgJiYNCj4gPiA+ID4gaW50ZWxfZGlzcGxheV92dGRfYWN0aXZlKGRpc3BsYXkp
Ow0KPiA+ID4gPiDCoCB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK2Jvb2wgaW50ZWxfZGlzcGxheV9j
b25uZWN0ZWQoc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkpDQo+ID4gPiA+ICt7DQo+ID4g
PiA+ICsJc3RydWN0IGRybV9jb25uZWN0b3IgKmxpc3RfY29ubmVjdG9yOw0KPiA+ID4gPiArCXN0
cnVjdCBkcm1fY29ubmVjdG9yX2xpc3RfaXRlciBpdGVyOw0KPiA+ID4gPiArCWJvb2wgcmV0ID0g
ZmFsc2U7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwltdXRleF9sb2NrKCZkaXNwbGF5LT5kcm0tPm1v
ZGVfY29uZmlnLm11dGV4KTsNCj4gPiA+ID4gKwlkcm1fY29ubmVjdG9yX2xpc3RfaXRlcl9iZWdp
bihkaXNwbGF5LT5kcm0sICZpdGVyKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWRybV9mb3JfZWFj
aF9jb25uZWN0b3JfaXRlcihsaXN0X2Nvbm5lY3RvciwgJml0ZXIpIHsNCj4gPiA+ID4gKwkJaWYg
KGxpc3RfY29ubmVjdG9yLT5zdGF0dXMgPT0NCj4gPiA+ID4gY29ubmVjdG9yX3N0YXR1c19jb25u
ZWN0ZWQpIHsNCj4gPiA+ID4gKwkJCXJldCA9IHRydWU7DQo+ID4gPiA+ICsJCQlicmVhazsNCj4g
PiA+ID4gKwkJfQ0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCWRybV9jb25uZWN0
b3JfbGlzdF9pdGVyX2VuZCgmaXRlcik7DQo+ID4gPiA+ICsJbXV0ZXhfdW5sb2NrKCZkaXNwbGF5
LT5kcm0tPm1vZGVfY29uZmlnLm11dGV4KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldHVybiBy
ZXQ7DQo+ID4gPiA+ICt9DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX2Rpc3BsYXkuaA0KPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfZGlzcGxheS5oDQo+ID4gPiA+IGluZGV4IGY4ZTZlNGU4MjcyMi4uMjA2
OTBhYTU5MzI0IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX2Rpc3BsYXkuaA0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2Rpc3BsYXkuaA0KPiA+ID4gPiBAQCAtNTYwLDUgKzU2MCw2IEBAIGJvb2wg
YXNzZXJ0X3BvcnRfdmFsaWQoc3RydWN0IGludGVsX2Rpc3BsYXkNCj4gPiA+ID4gKmRpc3BsYXks
IGVudW0gcG9ydCBwb3J0KTsNCj4gPiA+ID4gwqAgDQo+ID4gPiA+IMKgIGJvb2wgaW50ZWxfc2Nh
bm91dF9uZWVkc192dGRfd2Eoc3RydWN0IGludGVsX2Rpc3BsYXkNCj4gPiA+ID4gKmRpc3BsYXkp
Ow0KPiA+ID4gPiDCoCBpbnQgaW50ZWxfY3J0Y19udW1fam9pbmVkX3BpcGVzKGNvbnN0IHN0cnVj
dCBpbnRlbF9jcnRjX3N0YXRlDQo+ID4gPiA+ICpjcnRjX3N0YXRlKTsNCj4gPiA+ID4gK2Jvb2wg
aW50ZWxfZGlzcGxheV9jb25uZWN0ZWQoc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkpOw0K
PiA+ID4gPiDCoCANCj4gPiA+ID4gwqAgI2VuZGlmDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0veGUvZGlzcGxheS94ZV9kaXNwbGF5LmMNCj4gPiA+ID4gYi9kcml2ZXJzL2dw
dS9kcm0veGUvZGlzcGxheS94ZV9kaXNwbGF5LmMNCj4gPiA+ID4gaW5kZXggZjhhODMxYjVkYzdk
Li41NGVkMzliMjU3YWQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS9k
aXNwbGF5L3hlX2Rpc3BsYXkuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUvZGlz
cGxheS94ZV9kaXNwbGF5LmMNCj4gPiA+ID4gQEAgLTY0LDYgKzY0LDExIEBAIGJvb2wgeGVfZGlz
cGxheV9kcml2ZXJfcHJvYmVfZGVmZXIoc3RydWN0DQo+ID4gPiA+IHBjaV9kZXYgKnBkZXYpDQo+
ID4gPiA+IMKgwqAJcmV0dXJuIGludGVsX2Rpc3BsYXlfZHJpdmVyX3Byb2JlX2RlZmVyKHBkZXYp
Ow0KPiA+ID4gPiDCoCB9DQo+ID4gPiA+IMKgIA0KPiA+ID4gPiArYm9vbCB4ZV9kaXNwbGF5X2Nv
bm5lY3RlZChzdHJ1Y3QgeGVfZGV2aWNlICp4ZSkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlyZXR1
cm4gaW50ZWxfZGlzcGxheV9jb25uZWN0ZWQoeGUtPmRpc3BsYXkpOw0KPiA+ID4gPiArfQ0KPiA+
ID4gPiArDQo+ID4gPiA+IMKgIC8qKg0KPiA+ID4gPiDCoMKgICogeGVfZGlzcGxheV9kcml2ZXJf
c2V0X2hvb2tzIC0gQWRkIGRyaXZlciBmbGFncyBhbmQgaG9va3MNCj4gPiA+ID4gZm9yIGRpc3Bs
YXkNCj4gPiA+ID4gwqDCoCAqIEBkcml2ZXI6IERSTSBkZXZpY2UgZHJpdmVyDQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUvZGlzcGxheS94ZV9kaXNwbGF5LmgNCj4gPiA+
ID4gYi9kcml2ZXJzL2dwdS9kcm0veGUvZGlzcGxheS94ZV9kaXNwbGF5LmgNCj4gPiA+ID4gaW5k
ZXggNzZkYjk1YzI1ZjdlLi4xMWQ0YjA5ODA4ZTUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS94ZS9kaXNwbGF5L3hlX2Rpc3BsYXkuaA0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0veGUvZGlzcGxheS94ZV9kaXNwbGF5LmgNCj4gPiA+ID4gQEAgLTM3LDYgKzM3LDcg
QEAgdm9pZCB4ZV9kaXNwbGF5X3BtX3Jlc3VtZShzdHJ1Y3QgeGVfZGV2aWNlDQo+ID4gPiA+ICp4
ZSk7DQo+ID4gPiA+IMKgIHZvaWQgeGVfZGlzcGxheV9wbV9ydW50aW1lX3N1c3BlbmQoc3RydWN0
IHhlX2RldmljZSAqeGUpOw0KPiA+ID4gPiDCoCB2b2lkIHhlX2Rpc3BsYXlfcG1fcnVudGltZV9z
dXNwZW5kX2xhdGUoc3RydWN0IHhlX2RldmljZQ0KPiA+ID4gPiAqeGUpOw0KPiA+ID4gPiDCoCB2
b2lkIHhlX2Rpc3BsYXlfcG1fcnVudGltZV9yZXN1bWUoc3RydWN0IHhlX2RldmljZSAqeGUpOw0K
PiA+ID4gPiArYm9vbCB4ZV9kaXNwbGF5X2Nvbm5lY3RlZChzdHJ1Y3QgeGVfZGV2aWNlICp4ZSk7
DQo+ID4gPiA+IMKgIA0KPiA+ID4gPiDCoCAjZWxzZQ0KPiA+ID4gPiDCoCANCj4gPiA+ID4gQEAg
LTY3LDUgKzY4LDYgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+ID4gPiA+IHhlX2Rpc3BsYXlfcG1f
cnVudGltZV9zdXNwZW5kKHN0cnVjdCB4ZV9kZXZpY2UgKnhlKSB7fQ0KPiA+ID4gPiDCoCBzdGF0
aWMgaW5saW5lIHZvaWQgeGVfZGlzcGxheV9wbV9ydW50aW1lX3N1c3BlbmRfbGF0ZShzdHJ1Y3QN
Cj4gPiA+ID4geGVfZGV2aWNlICp4ZSkge30NCj4gPiA+ID4gwqAgc3RhdGljIGlubGluZSB2b2lk
IHhlX2Rpc3BsYXlfcG1fcnVudGltZV9yZXN1bWUoc3RydWN0DQo+ID4gPiA+IHhlX2RldmljZSAq
eGUpIHt9DQo+ID4gPiA+IMKgIA0KPiA+ID4gPiArc3RhdGljIGlubGluZSBib29sIHhlX2Rpc3Bs
YXlfY29ubmVjdGVkKHN0cnVjdCB4ZV9kZXZpY2UgKnhlKQ0KPiA+ID4gPiB7IHJldHVybiBmYWxz
ZTsgfQ0KPiA+ID4gVGhlcmUgd2FzIGEgYmxhbmsgbGluZSBiZWZvcmUgI2VuZGlmLiBQbGVhc2Ug
a2VlcCBpdC4gRGl0dG8NCj4gPiA+IHRocm91Z2hvdXQNCj4gPiA+IHRoZSBzZXJpZXMuDQo+ID4g
PiANCj4gPiA+ID4gwqAgI2VuZGlmIC8qIENPTkZJR19EUk1fWEVfRElTUExBWSAqLw0KPiA+ID4g
PiDCoCAjZW5kaWYgLyogX1hFX0RJU1BMQVlfSF8gKi8NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS94ZS94ZV9wbS5jDQo+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3BtLmMNCj4gPiA+ID4gaW5kZXggM2ZlNjczZjBmODdkLi5lN2FhODc2Y2U5ZTAgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9wbS5jDQo+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS94ZS94ZV9wbS5jDQo+ID4gPiA+IEBAIC05LDYgKzksNyBAQA0KPiA+ID4g
PiDCoCAjaW5jbHVkZSA8bGludXgvZmF1bHQtaW5qZWN0Lmg+DQo+ID4gPiA+IMKgICNpbmNsdWRl
IDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4gPiA+IMKgICNpbmNsdWRlIDxsaW51eC9zdXNwZW5k
Lmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvdmdhYXJiLmg+DQo+ID4gPiA+IMKgIA0KPiA+
ID4gPiDCoCAjaW5jbHVkZSA8ZHJtL2RybV9tYW5hZ2VkLmg+DQo+ID4gPiA+IMKgICNpbmNsdWRl
IDxkcm0vdHRtL3R0bV9wbGFjZW1lbnQuaD4NCj4gPiA+ID4gQEAgLTM4Nyw2ICszODgsNyBAQCBz
dGF0aWMgaW50IHBjaV9hY3BpX2F1eF9wb3dlcl9zZXR1cChzdHJ1Y3QNCj4gPiA+ID4geGVfZGV2
aWNlICp4ZSkNCj4gPiA+ID4gwqAgDQo+ID4gPiA+IMKgIHN0YXRpYyB2b2lkIHhlX3BtX3Zyc3Jf
aW5pdChzdHJ1Y3QgeGVfZGV2aWNlICp4ZSkNCj4gPiA+ID4gwqAgew0KPiA+ID4gPiArCXN0cnVj
dCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2Rldih4ZS0+ZHJtLmRldik7DQo+ID4gPiA+IMKgwqAJ
aW50IHJldDsNCj4gPiA+ID4gwqAgDQo+ID4gPiA+IMKgwqAJaWYgKCF4ZS0+aW5mby5oYXNfdnJz
cikNCj4gPiA+ID4gQEAgLTM5NSw2ICszOTcsOSBAQCBzdGF0aWMgdm9pZCB4ZV9wbV92cnNyX2lu
aXQoc3RydWN0DQo+ID4gPiA+IHhlX2RldmljZSAqeGUpDQo+ID4gPiA+IMKgwqAJaWYgKCF4ZV9w
bV92cnNyX2NhcGFibGUoeGUpKQ0KPiA+ID4gPiDCoMKgCQlyZXR1cm47DQo+ID4gPiA+IMKgIA0K
PiA+ID4gPiArCWlmIChwZGV2ICE9IHZnYV9kZWZhdWx0X2RldmljZSgpIHx8DQo+ID4gPiA+ICF4
ZV9kaXNwbGF5X2Nvbm5lY3RlZCh4ZSkpDQo+ID4gPiBTaW1wbHkgY29uc2lkZXJpbmcgdGhlIHBs
YWNlcyBpbiB0aGUga2VybmVsIHRoYXQgY2FsbA0KPiA+ID4gdmdhX2RlZmF1bHRfZGV2aWNlKCks
IHRoaXMganVzdCBkb2Vzbid0IGZlZWwgcmlnaHQuDQo+ID4gSSBhbHNvIGRvbid0IHVuZGVyc3Rh
bmQgd2h5IHRvIGNoZWNrIHRoaXMgdmdhIGRlZmF1bHQgZGV2aWNlLi4uDQo+IA0KPiBBcyBwcmV2
aW91c2x5IG1lbnRpb25lZCwgYSBjaGVjayBmb3IgdGhlIGRlZmF1bHQgVkdBIGRldmljZSB3YXMg
YWRkZWQNCj4gdG8gDQo+IGRldGVybWluZSBpZiB0aGlzIGlzIHRoZSBwcmltYXJ5IGRpc3BsYXku
DQoNCkkgYmVsaWV2ZSB0aGlzIGNob2ljZSBpcyBmcmFnaWxlIGF0IGJlc3QuDQoNCj4gDQo+IFRo
YW5rcywNCj4gQmFkYWwNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IEJSLA0KPiA+ID4gSmFuaS4N
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+ICsJCXJldHVybjsNCj4gPiA+ID4gKw0KPiA+ID4gPiDC
oMKgCS8qDQo+ID4gPiA+IMKgwqAJICogSWYgdGhlIFZSU1IgaW5pdGlhbGl6YXRpb24gZmFpbHMs
IHRoZSBkZXZpY2Ugd2lsbA0KPiA+ID4gPiBwcm9jZWVkIHdpdGggdGhlIHJlZ3VsYXINCj4gPiA+
ID4gwqDCoAkgKiBEM2NvbGQgZmxvdw0KPiA+ID4gLS0gDQo+ID4gPiBKYW5pIE5pa3VsYSwgSW50
ZWwNCg==

