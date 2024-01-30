Return-Path: <linux-pci+bounces-2762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF92841BE7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 07:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DF51F25EEC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3F38384;
	Tue, 30 Jan 2024 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8SGKfB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C938DFA;
	Tue, 30 Jan 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595813; cv=fail; b=n3fr52BDUeNhpDt93fVwCn+cvKiwDYb2GiA/Ku362b4RkMJXk8Iw0AmSAUYoOgLJWr5Jk/I/iBs7g4KQHYL4W/FJWBpaCWc7MRS0oXttpcHGp13u03om6eL2xKpHFD6zSPN1+hRoV02tvHhvb9+zYLINzF5DVdymaq9Encsmqd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595813; c=relaxed/simple;
	bh=BFPgxjY6sMQNJ0Qfaek6hupPMkNWuaMHxtoHyl/5SBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kbxJxtjrShURghqsaJUWT049n7cFQ8n3FdgvcrO01JdMLx/k3BuCI35kIybEo+CL5WwjDArt0KUuyDLbbZNc9uFCPOBdNSr+cmvkN1L424Ws75KO83MSfuuHc/oZyl2VWFcxjETrjVV1YPYdiJt4Lqz4indJQfdraLo03qM0dAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8SGKfB0; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706595811; x=1738131811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BFPgxjY6sMQNJ0Qfaek6hupPMkNWuaMHxtoHyl/5SBM=;
  b=C8SGKfB0WqzOtZNcwFwS1M5pVavUXkvd+2p2jbAT3aIbU0hwwLyOL0zY
   gvoNa1GIRqsKa3sjV1WAMaOlcnEuHPgnW44Az2IR0VEY7pknzk9rgoyf7
   XLs/BkL6MO3KR8NJr/EjSQY8hmQR5LEBlYZk4Fc8MQG9AFfko5ypC94ex
   lhGURycH7VRMa9yqXJ+mKto84rCAp/FI2KHW+HiCugd4Ef/rtHdwMmbnz
   emO3q2THvISQygVl8XjISAZYYqflt1SnxKxkRghQtfRujaQ7KKTUm2dpO
   4LYdCri/+XouSNquOpFDi05AsXgSu1BZjuIj1p53gXTMIIShGAilrH/ca
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="21701494"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="21701494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="961153710"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="961153710"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 22:23:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:23:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:23:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 22:23:28 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 22:23:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPSAnvddbiPyzy/k6KtdanV6CekOBY538fGy9PmkALhzjTQTZMZm5XcZVcQQmp36ZdZYPjWx6WJDGQFiG0yp59RBKRHbbps3VsRtMFD5T66qqSow4RLJ4T3DJxfL0tRvqejOUZswQc/iDVi9/n/FnAbY1uFT8/uC+2PrIdR/8vlQLzzmcU8dXJV+AizzeRYOjgWpap0e8Aiudk822czXI7uznMhfpULcMoRWXoJ7K7hXTmGwyDDC0CIBnwjHpwPL66EZjerf8Yu6DKjBGJIsvuDKgMvF0213sYIlSQn+IMRGCW4Nr0B6Ojg8laP45oBt17LHF1Jxu92ZFDBIImGUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFPgxjY6sMQNJ0Qfaek6hupPMkNWuaMHxtoHyl/5SBM=;
 b=C5ODP32sJuHZp3XzR8CM4CFQ9GbL4555YIgP+uhbTgxxO2m60Yl+JHIaRL02usvy6V37Uh5j5T4yqYy2kGqvqXIytVO9/ofA+CPXYTfIpLXUzOMT6XgXKCbLDBsoX3r5x59wLhIBMiOS6MSMpR514gGStHrMFaZqkjv/oDO+PkJtJSPdNSSYeTOxiQn4WugMwmw7ryd/kGfDWd1pd3Ir5HUkSQaLr3s+7a5Y/wyi/Z/BKosFKdq77FrZU2+TWPqp53LafxpZtIsLnrl3jEw5f0TiAyh5v18hajMrRNX0vFg9LhO7OK+/TFQdIMICMZh928BEkX2jh1OgsMv/UXMxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5269.namprd11.prod.outlook.com (2603:10b6:208:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 06:23:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 06:23:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Haorong Ye
	<yehaorong@bytedance.com>
Subject: RE: [PATCH v12 1/5] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
Thread-Topic: [PATCH v12 1/5] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Thread-Index: AQHaUmYyZOQ2PispIkqjAdYF1ImrBrDwey1wgAFZnQCAAAB9EA==
Date: Tue, 30 Jan 2024 06:23:26 +0000
Message-ID: <BN9PR11MB527656E540ECCC77EFE99AF18C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-2-haifeng.zhao@linux.intel.com>
 <BN9PR11MB5276B0ADF497AEE3D990824A8C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <67f6d362-845a-44d7-b4f5-f7d589bc5300@linux.intel.com>
In-Reply-To: <67f6d362-845a-44d7-b4f5-f7d589bc5300@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5269:EE_
x-ms-office365-filtering-correlation-id: 7282dc82-002c-424a-d690-08dc215bf83d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDnl5kpIAMRlbOvCeanb3IIBpcUremarJcDuQvCxNZSGE5T8qHf8JsUahW5RsHc7ohOofl9PbUw5BIjzoCZjKB2GyVT9ovSefp1czFqSXgUHUBB4gV2YBxULirv6sIhwMbeJRgnxkzqGZRtDNGsLRty3DPphy+o8Rr8T3WIk25GUgZglpYJUxR7oKx+PP7brHRR/+dEV33iKeDxrtHdWuDiRnXcE5XrFxU5/iJnrngCD6GLuNSxDHC8FhRDFHV1FvHGAGAfNtvBMKgetQVEhJEdA3f6RvwLzg+3bTSNUz91YNXZMFYIAsdJ9kAMv3cY8c+i0qOmN7rbYWUKe0Mom6OTQmouHmympIemt9q7uvqmrhaKwk1siezTm91b4wXmkHJCaSYuBNlGC3X6Ze2+t6s7IPXAW4dOfzIjIFGGQ7i9XHq+/mNgbKduZHTXQJmmta3iUF6wPD7qV/IuvfDNqZz39VgTSNIa8FHnVSEggvCgePRG36ihYxqylw/RdWhVaU5johNCwYH2+ClwmAneUMumT2+P58iHQeW5KIIxf9MJnhzGzmniqyw3PmtXyOV5Ph8kghKcvzgU2Z8p852v6ZC/gv/rsfiH+h4b0E1HuKzJfDObRC8lo5Bj1Tv68vIr3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(9686003)(26005)(83380400001)(55016003)(316002)(66476007)(66556008)(110136005)(54906003)(64756008)(66446008)(478600001)(66946007)(76116006)(7696005)(6506007)(71200400001)(53546011)(4326008)(8936002)(8676002)(52536014)(5660300002)(86362001)(122000001)(38100700002)(82960400001)(7416002)(4744005)(2906002)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aktLNENrdkVIVjZIVmFiUFo3YUVuYWM4R1ZrS1ZHeW9MNUJYbVI5dEJQdmFK?=
 =?utf-8?B?R1ZKZnNuUU85RnRobUoyeHB6bmdVZ0R0ZmdidHlZRU1hbWZkcm8xMk0zampN?=
 =?utf-8?B?dWNYTEgzQ2hDWkZSK2Y4UXRSUll1TDE4TzFRU04yNzVuZDR6WVUrRFNMWXpz?=
 =?utf-8?B?VTJXQWJPdC85cWt5QUw4aVpzR1FGeUhtZ3VpQm5Xd3VrRG9RSElXak5CRDdZ?=
 =?utf-8?B?ZTR4am1xbnZCVjFTT3BRVjNjK2pHcmFmM1NmUU45R0hMZlByTmNzN2tLaVpz?=
 =?utf-8?B?OEFGNHBKeGdtaVpGNnBSQS9lVWkrc1ZsV0xEYXV5SXV1L1BNbHh1N1ZVUSts?=
 =?utf-8?B?dkRhb1Bod3o4OTN5cTBtVnNYUURvS3hxRjd6dkJZaE1QWU9ieFhsUHQxY25U?=
 =?utf-8?B?U1lwZHlqY3RmOEZwVWJtNSs0REhtZmhJVzJIbTlpVkpqc2RMWVB5eWNMSnFP?=
 =?utf-8?B?ckM0SWlvSWlnaDVTVzRPL0hTTzlzWjBMSGcxMXJOaUhRRjRRWHluNzRGRlg2?=
 =?utf-8?B?Sk5ySXRMUHF4Sy95VkhWK21yQXRFUHBTRUswS0MrZUxqTVZLek41aVhzTFV6?=
 =?utf-8?B?K29mT1F4aHFvZE9SVzNzeU40MzAwT3hNUGxJYlJLdS8wcUZla00yTWhIazNh?=
 =?utf-8?B?ek1aZkdzYy81L3Jac1NFSTZsamd4bDllUE5QRXc5OXdPa3Z6RzQ3UGp1ejRV?=
 =?utf-8?B?UWpSUFd4M1ZvQXd6YVpZOE5xZUNwaVJkYThnTEZqTWluRkRkSTFzKytWWC9o?=
 =?utf-8?B?YXVZQ1FRZ2pVMjVlalVMZ2VHSWJtbUpCQ3lrRGdaU2dqNlE0MFVGWnE5VE91?=
 =?utf-8?B?dzUyOGwvUmNYcVNpYXJJLzBkZ05FRlZzbUVJU0ZOandpRnU5Uzg0ZkhtYlk0?=
 =?utf-8?B?bjM5eFF5UlMvVXJmV1FWcmQ3Y1R1VVREcnFPaEFrODNPanZwNG43WjZQc3Vm?=
 =?utf-8?B?cUpEaHNWZWtOS1FWd09jeUhUQTdkL21ueEdpMGNUNXlpRVRqMHlaQlV4bkZk?=
 =?utf-8?B?c1VTZnlKZTJ6c3FZN1lndVhQSU0vSUQyOXpsS25sTWRJcTNBWjg5MGNsZ0lo?=
 =?utf-8?B?RE9SY2dYVWVOMWZFQmw2U3hZbHhOc0tra0hCMjExS1FqcG9oZ3RtOWpPOU5K?=
 =?utf-8?B?QkhwTHVoZFNCeWQyZEZUNDQ4bVY1NnFnUGJ6QkppUmcvYzJrWFVLdUdxQTFw?=
 =?utf-8?B?elpyRnpkN3E1NEFOYTJ0ZVZEN2pxSmNCYUV1dUkvcnVWazhNUnVkZGkwazdh?=
 =?utf-8?B?WVRRc00ybXMzRU10bTJaTHdxNCt2RlNqV2toUytlVHNoMW1abWNUY3paeUIx?=
 =?utf-8?B?S0lWK1pNY1RzZHJqZGRkYmhnTTZwQ3JxZmF0OFhMYWNlMUQ5UVVET2J6QXpm?=
 =?utf-8?B?Q1dqSWRkNENWS3NZY0NNclNBSmlxM3BwOVR0V1pReWU5Qm1LbmhEZzIva0RV?=
 =?utf-8?B?Nlp0eFB5bkE5bEVMWk9WS0lYUlY2dnZacUQyN3k3dXRURWlXMWFONXV5Zlo2?=
 =?utf-8?B?TWtwSFdJZTljVnAxM3VYek5zT0thdm0rOFYrUDNvMUQ2aTY2UitGQzZJaHhu?=
 =?utf-8?B?dXhGQm5Oa2dOcmgwWXE1SlNOalJQSnZNdWNSK3R1MU5TTm56cE43RFhjRlM5?=
 =?utf-8?B?VndQcU1jN0IrTEJNZnRINWpqaXRTcDZ0RlNtVXRKNmh3bUh1bmRiOVBrOVlS?=
 =?utf-8?B?V0NFU1NnUi9vd1Ixa0MyczZkSks4bFFwMnNXcU9tanFQMTVFeVJxL0VabG5n?=
 =?utf-8?B?RmIxT0hrdDVlTStWVnVzeDVZeFJqcDVqUUdmU1MzYjBVSnU3ZWdaZTBUZHVj?=
 =?utf-8?B?Z200WFptNXpxVEgvMmpvMnFkK1kwVVFtTkVDam0xL0x3M0JyMUZkbmEvbEpD?=
 =?utf-8?B?ZUs3SEhBZDJsNUpaVDkxYlhoL1YvRUJpVHhwdXNkbTRlWUlkSkpiY1JyYjk1?=
 =?utf-8?B?WC8zYUhCY0duQ0U1Y2FrS29VTFpjVlBSVlEzLzdKYWZiRjgrWGlmY1dJR0h2?=
 =?utf-8?B?RzdRNWdzQmJsY2lubXQ1MFh2cUhRNlE0MisrWUs4NDUrUlhrdHVZNnA1MTlI?=
 =?utf-8?B?YVViVm03YUdPdlZ0NGkrK2F1QjZVbmxkb2VwUWJpbjhRZ3c1MFRQMGNWN0pB?=
 =?utf-8?Q?iVwyIxzNvCcb/lkAi3yik0ESG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7282dc82-002c-424a-d690-08dc215bf83d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 06:23:27.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1O1hJCBOiuwVzEv2t098ztSngYEIBQpJUtoBTazrWs4NrBn62NyI7xNc/46/yXEZ6O529b1i0ewa0jWYggKihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5269
X-OriginatorOrg: intel.com

PiBGcm9tOiBFdGhhbiBaaGFvIDxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKYW51YXJ5IDMwLCAyMDI0IDE6MjYgUE0NCj4gDQo+IE9uIDEvMjkvMjAyNCA0
OjUwIFBNLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogRXRoYW4gWmhhbyA8aGFpZmVu
Zy56aGFvQGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDI5LCAy
MDI0IDExOjQ5IEFNDQo+ID4+DQo+ID4+IE1ha2UgcGNpX2Rldl9pc19kaXNjb25uZWN0ZWQoKSBw
dWJsaWMgc28gdGhhdCBpdCBjYW4gYmUgY2FsbGVkIGZyb20NCj4gPj4gSW50ZWwgVlQtZCBkcml2
ZXIgdG8gcXVpY2tseSBmaXgvd29ya2Fyb3VuZCB0aGUgc3VycHJpc2UgcmVtb3ZhbA0KPiA+PiB1
bnBsdWcgaGFuZyBpc3N1ZSBmb3IgdGhvc2UgQVRTIGNhcGFibGUgZGV2aWNlcyBvbiBQQ0llIHN3
aXRjaA0KPiBkb3duc3RyZWFtDQo+ID4+IGhvdHBsdWcgY2FwYWJsZSBwb3J0cy4NCj4gPj4NCj4g
Pj4gQmVzaWRlIHBjaV9kZXZpY2VfaXNfcHJlc2VudCgpIGZ1bmN0aW9uLCB0aGlzIG9uZSBoYXMg
bm8gY29uZmlnIHNwYWNlDQo+ID4gcy9CZXNpZGUvVW5saWtlLw0KPiA+DQo+ID4+IHNwYWNlIGFj
Y2Vzcywgc28gaXMgbGlnaHQgZW5vdWdoIHRvIG9wdGltaXplIHRoZSBub3JtYWwgcHVyZSBzdXJw
cmlzZQ0KPiA+PiByZW1vdmFsIGFuZCBzYWZlIHJlbW92YWwgZmxvdy4NCj4gPiBzb21laG93IHRo
aXMgcGFyYWdyYXBoIGJlbG9uZ3MgdG8gdGhlIHBhdGNoIHVzaW5nIGl0LiBUaGUgMXN0IHBhcmFn
cmFwaA0KPiA+IGlzIHN1ZmZpY2llbnQgZm9yIHRoZSByZWFzb24gb2YgZXhwb3N1cmUuDQo+IA0K
PiBwY2lfZGV2aWNlX2lzX3ByZXNlbnQoKSBpcyBhbGVhcmR5IGV4cG9ydGVkIHN5bWJvbCwgd2h5
IG5vdCBqdXN0IHVzZSBpdCA/DQo+IA0KPiBBbHNvIHRyeSB0byBtYWtlIGl0IGNsZWFyLCB0aGUg
ZGlmZmVyZW5jZSBhbmQganVzdGlmaWNhdGlvbi4NCj4gDQoNCkkgbWlzcmVhZCBpdC4gDQoNCg==

