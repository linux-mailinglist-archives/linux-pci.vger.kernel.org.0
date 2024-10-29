Return-Path: <linux-pci+bounces-15541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098C9B4F1C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980CD1F259BB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4FB1DC745;
	Tue, 29 Oct 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBCj0vhO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB41DBB36;
	Tue, 29 Oct 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218541; cv=fail; b=UEDK0T0/nqAq8fIU21sYb7AMzNPTDMrDZTlLwEUkaU9/V3xsZjsAOdqUGFjvrbVzTQrCYHVh5UugaoKL0tIfu3W/zl0gpzJ98IvTqrzsqEyC/MhhV4lcShr5YCNSndVLtYKbh2X6EOq+0N7AtBsZw5JuU2725GdyTjiZFrvzLYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218541; c=relaxed/simple;
	bh=oOHzsdEyLQVx7Ll+l4js0Gz9y+njUCIkdw/j5GFPZKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gIC4pcHGBcSxxFWnq0EV3X8HdCqEfMMpajThMfd+ZA1m6eD6KbbjaGFWnFilMNxUNNF0LlIVIJ/DCeI1PwadL7q8u+gQtg/nwbBmFdMlEeaUjYhrKpNfddweRwzZqjnNAdX1t0zNstZ2NcoZOF93QbMwxuBlARJgG57SSAYnkuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBCj0vhO; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730218539; x=1761754539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oOHzsdEyLQVx7Ll+l4js0Gz9y+njUCIkdw/j5GFPZKA=;
  b=jBCj0vhOXkVUfCpxJBZMD0wVXX6CE9WsLbYIy5ohmq3GCZAGxS50Ek6l
   CSTAUZC1KD9S8cREuv7VXZC+Bf8zJD+dgDPiv/mya3RKy6PYb1Ktpojd3
   SdOXtkcC4zpuhaXiPPCZd+wuFDJpzefarmEh2xgVIDpP1gxH/mJDP9jCd
   Jpl2b5bO8vsXlM6Jp5QW0DNbWeMhu/yppPSfQVJyVrLTlRUfMLw3DtjjM
   04kdT0MH69no+Q3BwhqyplpDmKcaVS2IHKEI8XQZpKE0BN+VpaPuD2Crr
   RIIGCi2qrvPSVIL3XtQXAxFC9/NDFNaFa0hPKP7ild3bVmWvRndIqRpH4
   A==;
X-CSE-ConnectionGUID: jcwh9oOQQ1uzNWkDOAwhsg==
X-CSE-MsgGUID: OmrWD83fSfGO7tG21DPT7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29771000"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29771000"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:15:38 -0700
X-CSE-ConnectionGUID: izGZDiqIT2OQAE3dQ+f1Ow==
X-CSE-MsgGUID: 3r7wAmkNRSewsgK6pDOgPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82162287"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 09:15:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 09:15:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 09:15:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 09:15:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFAyKq7CSO7NDpS6INlLok+7Q5MDX8CPsmDr8oZFK8T2QtAb2127S5Tr40wtc55Ag9zE3/S2c/qvAjmeQpxM8wTRDt+UjcnkuftRyMPiNnAsLNH5PkrspFDcNYlHZpMILIVRi6u5+41twe1rNk6OqUuZLl9uOrk+v2vKurEWUG36DJxrSz+Spo3caFB5rHudku4h3NCnf091KsOVSD0wWLpQFQngxZ3I0scm8SFJUuEPAXg3SSByUW04x4Q/OcActNrUb/+fTQN/+CWYvLmvYcZY9jfBKJ0nQ9zPfbrRPxdZzjb2rX5KnzrCQyqCUmc1ZhvkwsoMbip//C4fCeyDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOHzsdEyLQVx7Ll+l4js0Gz9y+njUCIkdw/j5GFPZKA=;
 b=jw6WxkbrI7ihraZfyRVCBeWGIEPEX1FdIhRkqAej8uZVttEv73rI8izdxf5jSgwqdP2/Dipb5ATXW0fpRrXmtWEPac5UQeruTc70kwDp9JUxOOuIWAT6Emc/E9CDSbMCz53EyZWKDrwfGC7MlreHoNBZ8BOyFqpnL+2hws0YtSvRbqOAtFsfg3MPstHgokr4GQAD36ZUNk/Y/A5J+xsCwwQRhzZtQLbSKWNXJSSNUF9d2lECeGqguCjxDRWkvDxRaPjJxFjUEvCFb7u+LZdQS+Ax0pcmsyXz4pdu3X0M7AW017VzCcCtGXkmnqk72UcqKL0Ecgm+XjAc7E3EpK2qIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 16:15:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 16:15:33 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "avadhut.naik@amd.com"
	<avadhut.naik@amd.com>, "john.allen@amd.com" <john.allen@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Shyam-sundar.S-k@amd.com"
	<Shyam-sundar.S-k@amd.com>, "richard.gong@amd.com" <richard.gong@amd.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "clemens@ladisch.de" <clemens@ladisch.de>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "naveenkrishna.chatradhi@amd.com"
	<naveenkrishna.chatradhi@amd.com>, "carlos.bilbao.osdev@gmail.com"
	<carlos.bilbao.osdev@gmail.com>
Subject: RE: [PATCH 03/16] x86/amd_nb: Clean up early_is_amd_nb()
Thread-Topic: [PATCH 03/16] x86/amd_nb: Clean up early_is_amd_nb()
Thread-Index: AQHbJXAgVisWI0AOqkmwEpCqLiVaKbKXopgAgAYzPgCAAAgxgIAAEZtw
Date: Tue, 29 Oct 2024 16:15:33 +0000
Message-ID: <SJ1PR11MB6083AA7B2E28F2DA24E4B456FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
 <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
 <20241029143928.GA1011322@yaz-khff2.amd.com>
 <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local>
In-Reply-To: <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7603:EE_
x-ms-office365-filtering-correlation-id: 0afd0d92-55f1-4131-fc7d-08dcf834ea4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VkJZSW5WazhZRWpscUsxREVxc09qWVdqbmxIczBKTFpkempPV0ZidEkxditn?=
 =?utf-8?B?aFhYNWpqUXdtZ0pnZFlIUjVXVGgrQk1kUjcrRURqVlJlb0tZaDlWVi9YQThE?=
 =?utf-8?B?OHQ4VldhZVB3a0psSTk2b3cwbytGcUJiRHFSQkNtbHVldVIwNHVUd2c5Tk1G?=
 =?utf-8?B?VnQraEFXaDVmRmRSZ1dnckk2OFE1dG9OaTl3eCtKTWRVckhYeTJKd1pSb3Vu?=
 =?utf-8?B?eVZkVnQ0MTB1RTFMVUlwM0pwMUJnci9uM29FSGRhZmVGK1UySWkxM1JjdzR1?=
 =?utf-8?B?YVY0ODhtVm5kbXU2c3YxbWVQQW5nanZGbGpsSGpEb0lPdS9rZUk4TVFZcCtG?=
 =?utf-8?B?VGwyaTlndkVRYk80K0xNSVdjSkxpYzBEUjZidkNkT1l0RkpyYjQ3REliMXdn?=
 =?utf-8?B?UDNsZEhLaVJZYXpnbUF3d3JuSVRXUjA1anRPMTlGTlIxOUJ1UmlvUUZhTmk0?=
 =?utf-8?B?U1U3aU1reVh6ekx2MmVFL0FrcW9CV0hDTklKQ0E5bSszSjBPZ1VoT0kzeGlF?=
 =?utf-8?B?SlgzUU1tbDB3K3d1VFdTcWhlSlN6N1E4d25DRDdjamlCMWJHQ0swcW1Nci9J?=
 =?utf-8?B?amdFTS9DTXlqN0tXdlRJZExXWW1Fd1h6VEhwcUNjYVBoSFI4YjFKRDlVM0JX?=
 =?utf-8?B?RWxyRm5xQnV0QkNLakFmT1E1SXJXL1VCWDRheno0NG9jWEFTNjN2cThNeDJV?=
 =?utf-8?B?RlBBR0RMV3dRQWtRZ096UnA3dm9hUGM2MWJnM0NpQzlyN0I1RUlTckcrN2dm?=
 =?utf-8?B?SityWG1LWFM4RWFwdU1WWG5CVTY1eGx6ZGNaVEU0YS9hYm5NVDZVZkoyRGJD?=
 =?utf-8?B?aUNtSmJiQnZEblFmamdzbU82ZHlZN1RtUzFZelFndERCb1NXVEwrcFpTVkRC?=
 =?utf-8?B?NEZBbCtERW1HTlpxNFBKMlIyemFZWXhUeWNYMi90MVc3SDYxSVk4clRjTlU0?=
 =?utf-8?B?TGhBekkvWWE3aFhleFpLK21iRmFpZ3BwZHppSHlyR0t6aVk3RWpmT09GR2xw?=
 =?utf-8?B?UVAyd1czbU1pVExJVjhEbExaQzdMU2xRYWtZL0dXTjNrN0JGdFkzUEpiaHFR?=
 =?utf-8?B?V1BNN2NQS3MyVHJLZE5ydm5Jb2xCdWdQbVV4ZXk2OHIwZXNuWEVNYWtNTmRN?=
 =?utf-8?B?bkRhOWFRU2xSbnhHMjdORldIUUluL0N5Q3dHSlpvamN0NGw3dlRBUnVIRXlX?=
 =?utf-8?B?cVVZU000YTFRUmhFYUtsUmJEZFgxanVDUWl0a3NwWTVmcW0yN05TL2RkTkZj?=
 =?utf-8?B?VytMeEpEMDhiVzFGbzNhUkduRzcvMTJ5b0RKOWN3MnQ5a21weFVMN0lZei9h?=
 =?utf-8?B?MUNtZjNsQUE1ais5aU9WYkNQanNyOEhBaUFyOFUyL29EbW9nRURDY1NSd0Rj?=
 =?utf-8?B?RGxpZytpcG1hVHlCNTVVQnBCUzhTUlpkVDA4WUE5cDJ3T29wWnJ5U0QwNEla?=
 =?utf-8?B?RzZOVmJrbFBOdFVJb1U5bVdHRlFXY0NRQnhvdEVqUGU1R0x5MEhNbUs0c1ZC?=
 =?utf-8?B?VEdoTUpjbk9NU0U3WU96d0thWVZxbFZMMzNUNUdRdGZhOGRJSmtLalVtbVMr?=
 =?utf-8?B?dktRaThDc09EdnhWa2xsUEZ3akpodWFLbXU5OUdjV0s2bDBtay9UaVQzQ1VR?=
 =?utf-8?B?TUNBWDdaZTBSaEZ4QlZIRFNqSjFjbFlCNmJvNmlKZjBIMEdnSmh4Tyt0cjNO?=
 =?utf-8?B?L1AwbXhCQlhuZ054V01mWEdkTEpBK3BHcEw1cERNaXZzSU9Od3NaK0JFY0Zk?=
 =?utf-8?B?eUFIWmxEQ01wNXJ5THJJdDVqWlNuMGI5UDM0cmJDTElkVG9hbTd3QjQ1N0lR?=
 =?utf-8?B?SUcxU3lqcXphL0p3V1N2NTQ5Q0M5b2pNVE5oZEliU053NG82Q0VXdkhLOXN6?=
 =?utf-8?Q?YJ6Bw999IVOcP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEQ3RWFQazROUjNTaCtIR25odFNtRUpHOVhXYTFLeDRPYnZZaGc5SUNYYmJu?=
 =?utf-8?B?RFI5Qkh1ZGpySk13NjBZcmJJazBRNWd5dG5udmI0cVBjMVlCN3kzZDJqNU9h?=
 =?utf-8?B?QnkyOWJTVGQvVi9lbVZUNkowUk9YVGRvUzhsTTE1MENEeVJ2UzdONXhpcDRq?=
 =?utf-8?B?RTdzMWRjK29XemtMU3Rta1dybUNuenZHdHRDTkJud0tXNFIwa3ZUTDVvOWU5?=
 =?utf-8?B?WW9lTnlnOUhSd2V0a00wUTNycnhWWW91elh1UTFIZGFlM3FPMXMxZmo4YkZ1?=
 =?utf-8?B?V3BWSE1ZTWUxTTdtbkg3bjUzTFY1OEYrNk5LZEtJNDJsL1hhdUxlM3BiSlUr?=
 =?utf-8?B?MlNqQTNKdkRlbDErcjc5UlBUK1FTQi93U1ZNaDVPSXF6ZHRFR1NNOGJQS0k2?=
 =?utf-8?B?SzZTY1UzeC9hVXNFZFlxVkViQ1NXVm9LUkdhWWFTTzdmNkFrRHBTWENsKzRW?=
 =?utf-8?B?b1dra3FlVXg3YW5kZjNGQWJQb2FCOWtXQVNFQkdDQU9wZlJMTFJ5ZkptM08x?=
 =?utf-8?B?UnR0R0JBZFBpUHlGU054MDZPSWtwbHl4ZlhEa1pEbDZEM2NzSTFHL0U0bkEy?=
 =?utf-8?B?eVhhZUNqcnpXZkJ6ZzV6M1Bhdktacy8zUUFWNm1NbExvNFlJOVlkdVo2ZjdK?=
 =?utf-8?B?aWpUYUYyQ080dFlDMmlJVm1rcWZDSUJva2s0TURPbHhwN2RDVXVEUTJUaU1R?=
 =?utf-8?B?N0l0MFFlaUVIbGRhU2JwZkNNcCtVN3pRVGw5VmNWTEVTbHFka2Z1NTk1ZWVQ?=
 =?utf-8?B?MlBZRFA1NjI2RGhiaENWL3Rld3djQ1BoaVhLOWxveU93TEd0R3phdXlQMlg1?=
 =?utf-8?B?M3lVcC9WZ2tuRFRyQVVqSTE3Q3piREhnU1J3TGh5SEQxaW9VclR4U2dhVUQz?=
 =?utf-8?B?dUExUHo3M0ZTWUlMYzdtV3pUZCtxUm5XU3FZQVByRThNQklVN3UrNjZzaTlC?=
 =?utf-8?B?Yk5UTitXVXdmQ3NlNWUrM3hXZCs2R2Vha1JVaXgrL1lORUFrc0pWRVVUbHZC?=
 =?utf-8?B?NG4wRHR0eVZiUExwTEdIWXhkWU5SdzdERmU5eWpBbElVaGlSWWd2QUc1SnNJ?=
 =?utf-8?B?K2FWSkNnRkJPQTRKNHhpT3lEOG5WbnVTOVJjTFJmcE10blFTTkc4dllGSmI1?=
 =?utf-8?B?eFY3T1RoYnNUMUlLT3VaK3d1L1hMSm9Hc0VPd3JmVXlxajY3Tkp3bTFaVTN3?=
 =?utf-8?B?REp1RnZOQUdZOXlma21ZdytubTMvajlHM2hTYVBkMWEwSmRmUHc0ZkNhTVcz?=
 =?utf-8?B?ZVczMHFrSGc4cFcvN21iWkZuSnliUmRlbEhYTExTRGx3UjkrQTR3REJqZ0NH?=
 =?utf-8?B?SCtNNng1REc0V2d2RmtVbWMrVEQwWXlUU01zQlFIVStQMnhERnFRUytPN3hZ?=
 =?utf-8?B?WmkzeGlIUGpEM1JGczJOWUNtN1lOQnVSRjFBQWtGSTExanorc3diWmVNM3h3?=
 =?utf-8?B?RUxqeDJHK2NBY0RxVm1zSy8yTG0xRVZ1NmFRelhEN1hlOG9wR3FyMWVlZ2hl?=
 =?utf-8?B?cFZNMGl5ei9Pbkl4a0wxcDNRNW9uMUhHTjdNY24wSjU0WlBxRVQzTVFyclBG?=
 =?utf-8?B?aHdhZ1U4ME9oYVVEaDBDWElUaFp1OHRvNkxabDAzZTBic0IvSjFDbFlaaXNG?=
 =?utf-8?B?elJwTWxnODloK2svZGYwMjUvcWZEK0lTZWNheUlhSmhLQTJ6dkNGaDZEaXV6?=
 =?utf-8?B?SFBZb1k3dkoxeFhrOEtXMjhlYXNZRjZpR3hrQVJDOW04RnV6UHI4UmhBSXl6?=
 =?utf-8?B?SzcwYzlkb1Q3bWlTRkV5OTJ6RC9HeEE3eGtiWW5xaUtOa09rb3dlU1l2bXlE?=
 =?utf-8?B?NjV4SlVoVDBrLzRkbmJDQWJ6K1NweWt0VXc2WVdaWWVDNGhHS3pVbzcvdnRI?=
 =?utf-8?B?ME4wU2N1MU9DdlNyUm1pZHZ2bFRPWUpiZDhKOUxWc0o2VFJTdXBLOHZiL1FZ?=
 =?utf-8?B?MThRazNGdFJqUDkwOFRNSDV3RStzSmhYY2NpcituVTJqZWhHd1IxS04yQ3Vl?=
 =?utf-8?B?K2NZMkhsOWtMYnRuM05JaldCd0ZqVWVxVDhSR0FSZHRES3N2cXNqQXl6NmVj?=
 =?utf-8?B?WHY1QVhvakNBZ1ZNUCtuNkt4anc4Y3BHNm1TQVVraC9QVXcxUlpRRlNuRHlR?=
 =?utf-8?Q?VHWqjcYZnSlHoWroxjS2175yy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afd0d92-55f1-4131-fc7d-08dcf834ea4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 16:15:33.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9KLssew+dsLOkdf6y54BeGeFrS8bhhz83h3Mzl4TXt/21y8Qxw4CPepJU/Y/oJV+NasQ4obo+jD1/FvlKo4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com

PiA+ID4gPiAtICAgICAgIGlmIChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRP
Ul9IWUdPTikNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIG1pc2NfaWRzID0gaHlnb25fbmJfbWlz
Y19pZHM7DQo+ID4gPiA+ICsgICAgICAgaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9aRU4p
KQ0KPiA+ID4NCj4gPiA+IGNoZWNrX2Zvcl9kZXByZWNhdGVkX2FwaXM6IFdBUk5JTkc6IGFyY2gv
eDg2L2tlcm5lbC9hbWRfbmIuYzozOTU6IERvIG5vdCB1c2UgYm9vdF9jcHVfaGFzKCkgLSB1c2Ug
Y3B1X2ZlYXR1cmVfZW5hYmxlZCgpIGluc3RlYWQuDQo+ID4NCj4gPiBTdXJlIHRoaW5nLg0KPiA+
DQo+ID4gSG93IGNhbiBJIGVuYWJsZSB0aGlzIGNoZWNrIG15c2VsZj8NCj4gSXQgaXMgcGFydCBv
ZiBteSBzaWxseSBwYXRjaCBjaGVja2luZyBzY3JpcHQ6DQo+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2JwL2JwLmdpdC9sb2cvP2g9dnANCj4NCj4g
aW4gaGVyZToNCj4NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvYnAvYnAuZ2l0L3RyZWUvLnRpcC9iaW4vdnAucHk/aD12cA0KPg0KPiBidXQgaXQgcHJv
YmFibHkgaXNuJ3QgcmVhZHkgZm9yIHB1YmxpYyBjb25zdW1wdGlvbiB5ZXQuDQo+DQo+IEkgcHJv
YmFibHkgc2hvdWxkIHRyeSB0byBwYWNrYWdlIGl0IHByb3Blcmx5IHdoZW4gdGhlcmUncyB0aW1l
Li4uDQoNClNvdW5kcyBsaWtlIGl0IHdvdWxkIGJlIGEgdmFsdWFibGUgYWRkaXRpb24gdG8gY2hl
Y2twYXRjaC4NCg0KTWF5YmUgSm9lIG9yIEFuZHkgd2lsbCBmaW5kIHRpbWUgYmVmb3JlIHlvdSBk
by4NCg0KLVRvbnkNCg==

