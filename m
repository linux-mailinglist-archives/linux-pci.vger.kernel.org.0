Return-Path: <linux-pci+bounces-2788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8703841F59
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676921F24560
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A059169;
	Tue, 30 Jan 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2Bhw1PZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFD60B9A;
	Tue, 30 Jan 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606671; cv=fail; b=t1TJ7kZKm72LcJBiDuQTSRqDQThOkrkKaRpUTOkkCmRdq8/hy7O4NjCgzFxWC7wZ9H26os+EQldxQFllxSF3o4yxuJmp9gfUMfDQmoh4FXRfzfkjlZoWdyVef+G55U+NcLMBykekGVSc96QBlRQPvzx1BKFDsgb/sOaFJL0yrx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606671; c=relaxed/simple;
	bh=uyT0MRBwHJJrqd5Ovflhk2AwVEvS56Vlfn8jVgODWJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eB0dK0pCpc2ZVqhY3VFf5KkQ6nreuY4AMsD8U0U0eOKnPN8Re8jYCZy+Zkgnaly7bb0QY4/a07ejBw0LKl35oy2La7pBlSMz4E7ExS8WT+qcGekT6tRI1XiTBeHkgGkuB9PXCTmMOf7yrDX6Bfb8QjSvf8QfTgqolVLJ2VeoMrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2Bhw1PZ; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606670; x=1738142670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uyT0MRBwHJJrqd5Ovflhk2AwVEvS56Vlfn8jVgODWJE=;
  b=E2Bhw1PZgrbLrhJiJljWQ818PpAgt6z+BZcNY6mkiyJpY6W73/SLD5Hg
   ToLm6ag9QjIqayYeFJ8ZkRcjEX6Eh/UroF/4Wu6rY6wb7emrj32fVPHhB
   x0BHsshbqTUAYFN2p1vbo+sdyptK0FGMgPDIYZfehTk1NeusOJ2yJvBOK
   AyBGSXYdFrgkWdCsI49H9nlAKlQKlv3V4MGunmKIWyRHIOloc5whm05BQ
   mn3lwYIl3iLsFboOvEPN2l0BmpHtEnTgZLccBH59nLhi7btIdEKoUNLD9
   rbG45mASCF2Q4FJWSPBwnMCxyblLGlTVH1eKt9MK1ivk3cSSODiGX74OZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="393654170"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="393654170"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="29843951"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 01:24:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 01:24:29 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 01:24:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 01:24:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 01:24:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOd1EscjfCYJDfkun6DGs5et/p72wTELDZh9JCYc8YxM7u2fBAGqgzKj1kiWftsuoP6y6dQq+p+eiBl/O5nyKbEeAp3bG4IyRYu3sgBI+A+l8pXhLAUQ190gv6BzjAuh+0PsEaQjPBXZ/CVmb5QwK/Ebel8lBzreGJ9xsheNTdFrg0oxfLuSWXMVkwsxoM24ms2UYvrk+iUZTBYpnXpwdXekXBGUDBbguojlHdBfr0464Cy53DOtRxQn4esEyo82LH/oULAnYMw85+cZmHG5n7FToSynP7sVrCE26b0MRW7tqtcOOpChtxSVC7HRYv6ckNk7H4RDFpazM2oiJpj6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyT0MRBwHJJrqd5Ovflhk2AwVEvS56Vlfn8jVgODWJE=;
 b=SRBBHgt6cMIlUgTpDP+jF3DLk3ReWBlB2ZXQxOkjF7nyWDIPmc9EBWdculFZhgxWAYk3x5vSrZJZrHAjUE3DI5xm5+Yfy7XFHxkM0NazxGfNVbZcj/aEYnwhJuR+rt1sYKkJZwnJABWwa29otifMQdq0Pt4XdhfrKPbm0G2hhT8YLG5EdgzDjyOcEgz6nnB3wrwTu7OIix8vI59K7C6SgVo/bFr9pDgkWblMCtn98Kp0/f1tUNPvqkzKdgzfE+W31tePXOO2mTBA/d8xl2ts5Ve0TW2MocB2D6kRkX3fzOR+NQzzgfHO8taVRgA8mmwVrkUHYwVYhd92zQ2U1pq4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5331.namprd11.prod.outlook.com (2603:10b6:610:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 09:24:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 09:24:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Thread-Topic: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Thread-Index: AQHaUmY538BcsBx6UEOae7WqjB1D5LDweayAgAAKqQCAAUzCgIAADpYAgAAkhICAAAGe8IAADpGAgAABNJA=
Date: Tue, 30 Jan 2024 09:24:26 +0000
Message-ID: <BN9PR11MB5276CDBA6ED200319C8455EE8C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
 <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
 <BN9PR11MB527674172BBA9BDC49A004D08C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <56a9971e-7015-4584-89c7-80056b7ec547@linux.intel.com>
In-Reply-To: <56a9971e-7015-4584-89c7-80056b7ec547@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5331:EE_
x-ms-office365-filtering-correlation-id: ed0724e2-7370-4b20-a3a6-08dc2175413a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: om6O9WJUqDxipnvSUT+w9lVZ5S4X5szHdjo1FJS94byCQM4MkQPaf16gnqMIksxMMlEJG5eWLf1u24lSkQ6huFXFCjY/RxNQdXf037WOi7hOeJSpqXQgzf2PjJoVdvu1hQ8NebB0qS5FRibsRrZycZvDcfcv6hQOh2KBGhc8dunZnGJ/vCVckeNb7PTKJ9hihagLx6kLKYV+15414bG34Sr5rZIRYQsnWhKvEW8gPkoZ0PQNRYqW3BiS1Gf0j0XEQTVjQGYmTW7c1tsIpnPnNJtRpFPcAUYUmHSKe4LQj3PhiNMB0lKgGutjS2voSpXB1sgMh4RgcdL7RoA4WnimWiRlahJs+GFN3VuV9dY5BvR07sGfzw5+pmfOdRZKWj+swmxSwvHqEIzEQpgJzJQR+7l9MQOV8ibbYxzDFZegx+4WiqiV0tqTc4Gmc1YFUqDiEZ8E2GzlrYK/9qEx3KmVBBsjAkXEnzf46GjjmloNrEfhJ5zHn6zEN+YPYoGtvQthZzkSZ91YE7d1J6RHEuNGt0JdDp2SBsabxTwaf2yzDCTvOebJP9McV/e6uV1t9ouFo8sgnrbUsQ4gPBF3qrCTBAQB37+aofN4YbYYoDor9WE8aeFyp9QsScBLiNSSTd/+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(55016003)(38070700009)(478600001)(7696005)(6506007)(53546011)(9686003)(71200400001)(26005)(83380400001)(38100700002)(82960400001)(122000001)(86362001)(110136005)(76116006)(2906002)(33656002)(5660300002)(316002)(66946007)(64756008)(66446008)(66476007)(66556008)(54906003)(8676002)(8936002)(4326008)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXVRRUtXc2h4L0J2MHhTbG16emV0S1FvSi9UeXh0dkFNOStBb0RTMERPbEZB?=
 =?utf-8?B?SWhGMjhvcGV5U0ZZQTBtTmNVSEI0M3ZvZkd3TFJ6dmtjVGE3VDFVbW4xODRu?=
 =?utf-8?B?aHpQRE8rMHZzdnM3a3dKWTZKd2FINy9TMlpJOFlkeHFEamlkVmxTMlZDN05U?=
 =?utf-8?B?eDc5QTdMaGNZcCsyRS9ZSlViQTBCSTVnd2Joak0wUnprSW9SUTMyQkdQcGQ4?=
 =?utf-8?B?QUZrcXhWUEZKR3dKbXBOSzg4TFZsK3VSSmw5VlhKUEhJRkNkdjQyMXBTYjhJ?=
 =?utf-8?B?dThEWFMveTcrR3AzZ2t4K0ZHMVM2SFVLZVZkZGJ1TmRna2ZCWTNDNlJFbk1h?=
 =?utf-8?B?bGE3UHJKU0lSaVl4dkRuZ25WT0M3YVFZdVUwOTZsVzFKU0l0VHNzUDFzUWJ5?=
 =?utf-8?B?am1idGZqc0VFRVNJbFg2S0w5b2tGVHJBTUhnbVJOQzR5NjZ1WDNIT1BDS3NF?=
 =?utf-8?B?WkdaRFdvV002UGl6UGF5emhBV2Q2Q0thcWNrUHBnay85VG95cm1iaEFveWtu?=
 =?utf-8?B?U2VLWU9naDRDekIwUVQyY2RPNWs2MlJIVjU3eEdHVjI2UjUrZVQ5ZzFXdyth?=
 =?utf-8?B?ZDRNbmVPMkNmN0ZibCtJemNpVmJ5N2NTRkZhcHhoYWRibmsxcGxaSnpuL0Jy?=
 =?utf-8?B?TEE1LzFQMkR3cCtMNS8xb2pLWlQwVjRFcmFvMVpNRVJTa2dDTEFsMTBiYTdI?=
 =?utf-8?B?Q1pjSTB2TVNTZDEzcHdWT2FkdDhDOVE3UDVycm5uZ1JCQWU3b1ZoQUJEaytF?=
 =?utf-8?B?eldoeUZPaVR6eG1jd2toSHkyQnRFR1VCTVQzcThIdEV6Y2xoUmZRZVlHajBt?=
 =?utf-8?B?Y0RCSGdXYU5DR2tCdnNvSmJFbDdBSlI0NTdKYzdOMWxobk5mdTlSV1RDZW0z?=
 =?utf-8?B?bkhkUUhDVmttYnhKQUVDd2U1a3MvRlNsV1lxQnhoRFFudko5M0xsZnora01o?=
 =?utf-8?B?cElkZnNVTXVqem1CcHFzU3dNRlJmRzVjdFgvS2pTZXozdEhxaVBDNWQzelF5?=
 =?utf-8?B?NjhhLzhUcFcwMkhRYzQ3VXZMNEdQRmltcWs2U01HcVZNY3BHNkVTeWJsN1ZS?=
 =?utf-8?B?U3VtSDllSTFLVmt2Ymt1Yjg4UXZVS1B0Nzl3eW9LOFlVYWNQRExrTXdaRVQ2?=
 =?utf-8?B?TTlGMkJoUDZ0OVg5cm1ENzM2QnowZlVlS3h4TU4yRUhPVnVEaFgrdEFjdUFu?=
 =?utf-8?B?NTFJeE83Z0VPdk1leHBjRVR0STNCR05RQkJ5cS9DQkpiOGp6UTYySmxWS1BC?=
 =?utf-8?B?czEzWE1Pd3RidWFhT2RCSEJMamE0Y2JNa2VxMGNUUnhjTnZMdnUvZHNDMHNZ?=
 =?utf-8?B?Qk1OVnFTdExTK2hHQzE2QjhQYk9YZy9QSVVqTVdsMDlqU2k3NlkyOFJpczBh?=
 =?utf-8?B?bnY4K3RPeXdUY3pLOUNnTlk2c1g1OSs4Z3IydFpqZll6WXlCSlZHNFZRWUxs?=
 =?utf-8?B?V1JXdXFCQzlYYUdJR3RvRUJ1aFBjbGF2K29vYWdTNytlT2VUWlhHcDMycDU4?=
 =?utf-8?B?NXgxWHNHWDlORy81TlJ6VGE5WFZDajBRbEE1Q0hzQUxadzcyOVN2ZFBGWEZj?=
 =?utf-8?B?MjNIaEhKd0t5YlI1eWZGVFJERkhQL2JkcjRWSkhRcWZxWHRMaEM3eHU3Mk9I?=
 =?utf-8?B?RWRBVk02VWEyU0RoSm03L2VqMERRc2E2YzNzc2gvTjVtZGlkd2o4YXJnTzRB?=
 =?utf-8?B?NDE1Wi9TOTB5ekRqUWZjclU0VjN4WnU4bVlxaWpHZnB3Q1I4dW5wYmdvNkp4?=
 =?utf-8?B?Q1hmc25QUk1FejIvRUhEeHRzWG9XNmFkMHh1UlRMeDExWUxHd1dtZllBOGYr?=
 =?utf-8?B?SlAxbWVoZnNxbE9oVEhHTHFBSGI5eWo4UytQamlzM3JXT2h5OHdBVEx2QktU?=
 =?utf-8?B?TGVDSzRkQUIyeVdiMi9zN2I0U0VhM3ZEaVZldGlVSG1hSWpIM3hCQUtQNEsr?=
 =?utf-8?B?OTdQMXBGQUNWMnFKUFhyYmN3S3liaDJsT2RDSGRoS1NackYyV2VNSmE0VHVx?=
 =?utf-8?B?TDN1eWJjL0kvelhlZXF1MEJDVytpdDExNHB1RTRkTGZyS1dBL2Y3bmlVbnBn?=
 =?utf-8?B?d205VnRrSmRlVms1SFBqR0JVeVdoR2daa0pwdE5QdjdVS2RLdzk4cFY4b2dL?=
 =?utf-8?Q?pKv9VcLIWqsSf5/TSj8QGAS++?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0724e2-7370-4b20-a3a6-08dc2175413a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 09:24:26.8833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSMmdM1u79EHKy3u5IVuPpCcdskrBuDpF/TDu12/R6HPcr+hGLFPgEPA9pJEcB6Evm4+JxKBGM2sfa4nlo+KQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5331
X-OriginatorOrg: intel.com

PiBGcm9tOiBFdGhhbiBaaGFvIDxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKYW51YXJ5IDMwLCAyMDI0IDU6MTMgUE0NCj4gDQo+IE9uIDEvMzAvMjAyNCA0
OjQzIFBNLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogRXRoYW4gWmhhbyA8aGFpZmVu
Zy56aGFvQGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAzMCwg
MjAyNCA0OjE2IFBNDQo+ID4+DQo+ID4+IE9uIDEvMzAvMjAyNCAyOjIyIFBNLCBUaWFuLCBLZXZp
biB3cm90ZToNCj4gPj4+IEhlcmUgd2UgbmVlZCBjb25zaWRlciB0d28gc2l0dWF0aW9ucy4NCj4g
Pj4+DQo+ID4+PiBPbmUgaXMgdGhhdCB0aGUgZGV2aWNlIGlzIG5vdCBib3VuZCB0byBhIGRyaXZl
ciBvciBib3VuZCB0byBhIGRyaXZlcg0KPiA+Pj4gd2hpY2ggZG9lc24ndCBkbyBhY3RpdmUgd29y
ayB0byB0aGUgZGV2aWNlIHdoZW4gaXQncyByZW1vdmVkLiBJbg0KPiA+Pj4gdGhhdCBjYXNlIG9u
ZSBtYXkgb2JzZXJ2ZSB0aGUgdGltZW91dCBzaXR1YXRpb24gb25seSBpbiB0aGUgcmVtb3ZhbA0K
PiA+Pj4gcGF0aCBhcyB0aGUgc3RhY2sgZHVtcCBpbiB5b3VyIHBhdGNoMDIgc2hvd3MuDQo+ID4+
IFdoZW4gaW9tbXVfYnVzX25vdGlmaWVyKCkgZ290IGNhbGxlZCBmb3IgaG90cGx1ZyByZW1vdmFs
IGNhc2VzIHRvDQo+ID4+IGZsdXNoIGRldlRMQiAoQVRTIGludmFsaWRhdGlvbiksIGRyaXZlciB3
YXMgYWxyZWFkeSB1bmxvYWRlZC4NCj4gPj4gd2hhdGV2ZXIgc2FmZSByZW1vdmFsIG9yIHN1cnBy
aXNlIHJlbW92YWwuIHNvIGluIHRoZW9yeSBubyBhY3RpdmUNCj4gPj4gZHJpdmVyIHdvcmtpbmcg
dGhlcmUuDQo+ID4+DQo+ID4+IHBjaWVocF9pc3QoKQ0KPiA+PiAgICBwY2llaHBfZGlzYWJsZV9z
bG90KCkNCj4gPj4gICAgIHJlbW92ZV9ib2FyZCgpDQo+ID4+ICAgICAgcGNpZWhwX3VuY29uZmln
dXJlX2RldmljZSgpDQo+ID4+ICAgICAgIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZSgp
DQo+ID4+ICAgICAgICBwY2lfc3RvcF9idXNfZGV2aWNlKCktLS0+aGVyZSB1bmxvYWQgZHJpdmVy
DQo+ID4+ICAgICAgICBwY2lfcmVtb3ZlX2J1c19kZXZpY2UoKS0+aGVyZSBxaV9mbHVzaF9kZXZf
aW90bGIoKSBnb3QgY2FsbGVkLg0KPiA+IHllcywgc28gcGF0Y2gwMiBjYW4gZml4IHRoaXMgY2Fz
ZS4NCj4gPg0KPiA+Pj4gcGF0Y2gwMiBjYW4gZml4IHRoYXQgY2FzZSBieSBjaGVja2luZyB3aGV0
aGVyIHRoZSBkZXZpY2UgaXMgcHJlc2VudA0KPiA+Pj4gdG8gc2tpcCBzZW5kaW5nIHRoZSBpbnZh
bGlkYXRpb24gcmVxdWVzdHMuIFNvIHRoZSBsb2dpYyBiZWluZyBkaXNjdXNzZWQNCj4gPj4+IGhl
cmUgZG9lc24ndCBtYXR0ZXIuDQo+ID4+Pg0KPiA+Pj4gVGhlIDJuZCBzaXR1YXRpb24gaXMgbW9y
ZSB0cmlja3kuIFRoZSBkZXZpY2UgbWlnaHQgYmUgYm91bmQgdG8NCj4gPj4+IGEgZHJpdmVyIHdo
aWNoIGlzIGRvaW5nIGFjdGl2ZSB3b3JrIHRvIHRoZSBkZXZpY2Ugd2l0aCBpbi1mbHkNCj4gPj4+
IEFUUyBpbnZhbGlkYXRpb24gcmVxdWVzdHMuIEluIHRoaXMgY2FzZSBpbi1mbHkgcmVxdWVzdHMg
bXVzdCBiZSBhYm9ydGVkDQo+ID4+PiBiZWZvcmUgdGhlIGRyaXZlciBjYW4gYmUgZGV0YWNoZWQg
ZnJvbSB0aGUgcmVtb3ZlZCBkZXZpY2UuDQo+IENvbmNlcHR1YWxseQ0KPiA+Pj4gYSBkZXZpY2Ug
aXMgcmVtb3ZlZCBmcm9tIHRoZSBidXMgb25seSBhZnRlciBpdHMgZHJpdmVyIGlzIGRldGFjaGVk
Lg0KPiA+PiBTb21lIHRyaWNreSBzaXR1YXRpb25zOg0KPiA+Pg0KPiA+PiAxLiBUaGUgQVRTIGlu
dmFsaWRhdGlvbiByZXF1ZXN0IGlzIGlzc3VlZCBmcm9tIGRyaXZlciBkcml2ZXIsIHdoaWxlIGl0
IGlzDQo+ID4+IGluIGhhbmRsaW5nLCBkZXZpY2UgaXMgcmVtb3ZlZC4gdGhpcyBtb21tZW50LCB0
aGUgZGV2aWNlIGluc3RhbmNlIHN0aWxsDQo+ID4+IGV4aXN0cyBpbiB0aGUgYnVzIGxpc3QuIHll
cywgaWYgc2VhcmNoaW5nIGl0IGJ5IEJERiwgY291bGQgZ2V0IGl0Lg0KPiA+IGl0J3Mgc2VhcmNo
YWJsZSBiZXR3ZWVuIHRoZSBwb2ludCB3aGVyZSB0aGUgZGV2aWNlIGlzIHJlbW92ZWQgYW5kIHRo
ZQ0KPiA+IHBvaW50IHdoZXJlIHRoZSBkcml2ZXIgaXMgdW5sb2FkZWQ6DQo+ID4NCj4gPiAgICAg
ICAgICBDUFUwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxDQo+ID4gICAgKERy
aXZlciBpcyBhY3RpdmUpICAgICAgICAgICAgICAgICAgICAocGNpZWhwIGhhbmRsZXIpDQo+ID4g
ICAgcWlfc3VibWl0X3N5bmMoKSAgICAgICAgICAgICAgICAgICAgICBwY2llaHBfaXN0KCkNCj4g
PiAgICAgIC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+ID4gICAg
ICBsb29wIGZvciBjb21wbGV0aW9uKCkgeyAgICAgICAgICAgICAgIHBjaWVocF91bmNvbmZpZ3Vy
ZV9kZXZpY2UoKQ0KPiA+ICAgICAgICAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBjaV9kZXZfc2V0X2Rpc2Nvbm5lY3RlZCgpDQo+ID4gICAgICAgIGlmIChJVEUpIHsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+ID4gICAgICAgICAgLy9maW5kIHBjaV9kZXYg
ZnJvbSBzaWQgICAgICAgICAgICAgcGNpX3JlbW92ZV9idXNfZGV2aWNlKCkNCj4gPiAgICAgICAg
ICBpZiAocGNpX2Rldl9pc19jb25uZWN0ZWQoKSkgICAgICAgICAgIGRldmljZV9kZWwoKQ0KPiA+
ICAgICAgICAgICAgYnJlYWs7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidXNfcmVt
b3ZlX2RldmljZSgpDQo+ID4gICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2aWNlX3JlbW92ZV9kcml2ZXIoKQ0KPiANCj4gSWYgdGhlIGRldmljZSB3
YXMgaG90IHBsdWdpbiBvciByZS1zY2FubmVkLCB0aGUgZGV2aWNlIGhhcyBhIFBDSV9ERVZfQURE
RUQNCj4gZmxhZywNCg0KaW4gdGhpcyBjYXNlIGlzIHBjaV9kZXZfaXNfZGlzY29ubmVjdGVkKCkg
dHJ1ZSBvciBmYWxzZT8gDQoNCmhvdyBpcyB0aGlzIHBhdGNoIHN1cHBvc2VkIHRvIHdvcmsgd2l0
aCBpdD8NCg0KPiBpZiBzbyB0aGUgZHJpdmVyIHVubG9hZGluZyB3b3JrIGlzbid0IGRlZmVyZWQg
dG8gdGhlIHRhaWwgb2YgZGV2aWNlX2RlbCgpLCBpdA0KPiBpcyB1bmxvYWRlZCBiZWZvcmUgcGNp
X3JlbW92ZV9idXNfZGV2aWNlKCktPmRldmljZV9kZWwoKSwgaW4gcGNpX3N0b3BfZGV2DQo+IA0K
PiBwY2lfc3RvcF9idXNfZGV2aWNlKCkNCj4gICBwY2lfc3RvcF9kZXYoKQ0KPiAgIHsNCj4gICAg
aWYgKHBjaV9kZXZfaXNfYWRkZWQoZGV2KSkgew0KPiAgICAgICAgZGV2aWNlX3JlbGVhc2VfZHJp
dmVyKCZkZXYtPmRldik7DQo+ICAgfQ0KDQpubyBtYXR0ZXIgd2hlcmUgZHJpdmVyIHVubG9hZCBp
cyByZXF1ZXN0ZWQsIGl0IG5lZWRzIHRvIHdhaXQgZm9yIGFib3J0aW5nDQppbi1mbHkgcmVxdWVz
dCBvbiBDUFUwLg0KDQo+IA0KPiBTbyB0aGUgaW50ZXJ2YWwgdGhlIGRldmljZSBpcyBzZWFyY2hh
YmxlLCBvbmx5IGFwcGxpZWQgdG8gdGhvc2UgZGV2aWNlcw0KPiBub3QgaG90IHBsdWdnZWQsIG9y
IG5ldmVyIGJlIHNjYW5uZWQuDQo+IA0KDQphbmQgaW4gdGhlIHdvcnN0IGNhc2UgZXZlbiBpZiBw
Y2lfZGV2IGlzIG5vdCBzZWFyY2hhYmxlLCBpc24ndCBpdCBhbHJlYWR5DQphbiBpbmRpY2F0b3Ig
dGhhdCB0aGUgZGV2aWNlIGlzIGFic2VudCB0aGVuIHFpX3N1Ym1pdF9zeW5jKCkgc2hvdWxkDQpq
dXN0IGV4aXQgdXBvbiBJVEU/DQo=

