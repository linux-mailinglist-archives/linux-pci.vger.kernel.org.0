Return-Path: <linux-pci+bounces-22376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4E5A44973
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 19:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FB617A5DE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD919DF4D;
	Tue, 25 Feb 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByfYF57m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653B19D88F;
	Tue, 25 Feb 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506416; cv=fail; b=kotB1Zzmw8Maq00vj5nVosPIRBNjb6AemC+pcColSbJNdLP/gdOhMlXthsqPqRcnZddhHVS3f/wyjT2s6Nx22YLxrwPHVOyr+YX7CbsKrrQn5XeB18uNani/eAzMFUG8JWse7uoQBEJeiCNZL3jXCk1tsr87T7uC5k4TdGmJesA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506416; c=relaxed/simple;
	bh=RqldS7uPul6WdHNGNndeYu8KNx2redRZXQeqn7eLEDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vort8xESuX88UQcqLRMgD5uOtFrkWas/sGyjZM6QG1SyUnALylOcclU89lSH1R1JLprtM87tYhOqrfheLO2Cb7VNfFZAyOKyRP28EewLhgZjXS6ulPfTtvCYi9NQ3YfaIwDV6skdNhNrDTlSvePyFqAfwI7a1Rex7mOJYNE4NNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByfYF57m; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740506414; x=1772042414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RqldS7uPul6WdHNGNndeYu8KNx2redRZXQeqn7eLEDs=;
  b=ByfYF57mD+YmiW9TcDpidoK5C68R6qUoOMa2Ex8saEVZWCNqXGQZz868
   2YNqpBwIHtPMVqIA5upAQH6YYdobpuaJFOkuLE92CXTPIeCBfSTF5qgJ2
   KLcacR1in0/yDTK+uFDBEmo9sVsaydxHQ9zYJ1iN9aifVe2jxz/BFNetD
   XmbsWlImPRn1mrJID0727VUqAdEq9YsMj4loQyeugNGF8A44DwHsB3/FG
   6dbTlIGtH/ET/B1jY+rHkMFo+LtmAZhZ/JLkvgjFRYVhegIDVg0pa/Dwn
   OD1iz6w3+WW0PijV2TVmgZIkiVWWBbhatd8eoodVA4Rp6iQNzXE+ZEVnl
   A==;
X-CSE-ConnectionGUID: U1djUz8RRcK0O2fPLQPKrA==
X-CSE-MsgGUID: uT4oF8sTSLGRzU/Qy/FrWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41579325"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41579325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 10:00:13 -0800
X-CSE-ConnectionGUID: cUPpu3nEQtezNThD4BwQAw==
X-CSE-MsgGUID: kYq317NYS7uMWeg8MEBTKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="121073732"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 10:00:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 10:00:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 10:00:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 10:00:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plL+7Sx+SxyaGbvs8H0At5ICOjWREPymeaiw01TGg04Guf6aGFS7BlpuWKd4BTtOYOytGnIXGYR2V+WV0hPJcbezlNG5hW8QcdUvLvo5kN3l2WM7jgUR4ZQnkYyPkiCrgIqTvdqHLs7WHVmLRkk8hXjTSWlmH0+IN56bxdplI7xwaL2kLH3SVz+P7IjApaXCSBzsELDKfqW6Tu4FlbotW895HLaeboMqgIoyg/pyUmXLYUiSyEJUpMQkmU1b8IR6vYnEROswqeHJEjek2ZHdnQfqcyMcEYifmreL9CyogMVnTYiYyRIy7cunj3WYkcb74XmJGs2SfwLXM2hTctzh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyTrMcg5OJBJuenHLp7gPlhL2JViR3PXsm7qP1CbO9o=;
 b=p0/cqfsP5kLNKMl1sMTbwKlYfBe1qHsBbzcYsVjEI4NwvXBcdCt5W7Hop7CD5wyEE4YSCXJPTM9OKfsA78/XPE8/jDvMXUWfpuGV2/e0SCNkvyuVu4WWPkA4pXNa9iHhTLeOlvDTSt2kfij2WGOpfg2jSHoLP9h+cDpwExvyyIc73A3gPlURekd22DavldMSolCxicXcGaOiUV87XkfbK0oefZHD9gcIP4qhcRNj3XIMjBEeS3b1g/Klf/KKIIbMJHp/DEqIbzQqQbNqGL0XvQ20yz6gEnw09IE8AZv73VQd22woyXIHG9EVgeAcEeCSk4s0GAuW+V6N0Bs2pqOznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 18:00:04 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 18:00:04 +0000
From: "Gupta, Anshuman" <anshuman.gupta@intel.com>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>, "Nasim, Kam"
	<kam.nasim@intel.com>
Subject: RE: [RFC 5/6] drm/xe/pm: D3Cold target state
Thread-Topic: [RFC 5/6] drm/xe/pm: D3Cold target state
Thread-Index: AQHbhtw508BN+pqy6kWMoXxiN9OHALNYTZ6AgAAAs+A=
Date: Tue, 25 Feb 2025 18:00:04 +0000
Message-ID: <CY5PR11MB62113ABBF2CDB9F621B1A92595C32@CY5PR11MB6211.namprd11.prod.outlook.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
 <20250224164849.3746751-6-anshuman.gupta@intel.com>
 <Z74Cv8EneHF1frww@intel.com>
In-Reply-To: <Z74Cv8EneHF1frww@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6211:EE_|PH7PR11MB5862:EE_
x-ms-office365-filtering-correlation-id: 7b15f757-2a19-4452-9c01-08dd55c63b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MbYmqWLAnAfz9PYM5bzaZTu2r3yl8NEFuaxUvqFGgkkmTP2U96+xqL569Q?=
 =?iso-8859-1?Q?LYVMgYiesSgOk5CJlDL2ASTakvo/Nma24vBPaoiK4O3znXNb/0fNHPN4dG?=
 =?iso-8859-1?Q?Hj82d4XKJu76wPl61BDeLarq3uls3Kf4DLHnxmlbz9suf7NwW/ISp4X2FU?=
 =?iso-8859-1?Q?cMSg5Z2e4s1iwGmsiVdtagay6e02e7ncLoM7gUFA8nkilvgkean6D5Vdf9?=
 =?iso-8859-1?Q?9X8dg7BLcw3y5PFseWHnSB6hjplLHjd0bx8wjE4H3YFF2PXh3a642vfgs4?=
 =?iso-8859-1?Q?Q11h7CM+oRHm3Rxs1n764AcCvbp1FY5h7FC3f8Z7U5luDhyigIYUYbJIFi?=
 =?iso-8859-1?Q?YI1ZIQGGIKOVKZPsfQoURCuj114HVnuoTbkLSmaVVc4j8LvEBExWiaOOtw?=
 =?iso-8859-1?Q?Q5hrcTlwPfshGA4menf1gInVlQ8TQCi15Ltg633Ax8D+He5XBVjq3P2OsB?=
 =?iso-8859-1?Q?IYkieiqAsOsEssaR8ofYPYv1PXAdCBtuN8dihrHJDFkMhmibXRXyrwkOZE?=
 =?iso-8859-1?Q?opyzwnOY2F2XbX8R5HJIzxfp1B8ofuD2WSmHMDg2Lkn2e35ylSId+UYwB0?=
 =?iso-8859-1?Q?k0bY6RIFaUB8PC/PPnrKOHoRi3pIB5OISgffIgCXsco+L/sSaOlFdCfz3O?=
 =?iso-8859-1?Q?cyPae8ljXsLtxeczZ8kazDo6ruSn1GwONK1QK5sAudtwxkKFmLGS5dOylc?=
 =?iso-8859-1?Q?OGYnES36JwD6J/LENCFOQFmxKqCE6Vmc01wHJgMfhBmVhFVNnfkqp53mMV?=
 =?iso-8859-1?Q?h7+Cblm1pBka6HVpV11HHfNhspIMD+WBfKj//ndaYZK8tqZOW8mev/Ba9X?=
 =?iso-8859-1?Q?6Cmkj0AHrg+w+BH7on5SmSdtUM84XS/xr6K7QgXBVm4PMdEysv1En9Jkpq?=
 =?iso-8859-1?Q?joMrENN4MIrlZrwOAcqJkENQlsBeSQgmuxU6FLfviWRtUBY+utSYTQ2B7k?=
 =?iso-8859-1?Q?plZL9TAweV20nCt/58Qw92+muOSrbMY0wFSq06mv4d/GdSht3/zY0aWEVg?=
 =?iso-8859-1?Q?8lnQyCdMDhi2nntzcsuvHSqTvSlloRnVWqPp+E6QJujCGR9F8ikPsSt9bw?=
 =?iso-8859-1?Q?TS1JjC0Z7yscOuvCtODi4yqxrwhskAfhFMiyZ7nW91PASh+T8DLggoBB4m?=
 =?iso-8859-1?Q?oM8zu5JClD69eY4Fozwc2h9KcjnUQ0hr7+39aKebUn6qY9ILk9KGvFcU01?=
 =?iso-8859-1?Q?svNBbxA3NWbTWOmPKMuP2lcMeB2EDVtPDRTOn4unEJ8ZdCYXd+dAKNsFJB?=
 =?iso-8859-1?Q?i42x6DDUT0FRvKlbFyvL2+TWys+Qsy/3D+5MlGcKRjxQru/LfqBvOpcVZ/?=
 =?iso-8859-1?Q?egFPqL3Lwz7lDn3jg9NpMfT7X6pcMFDQgI5YY0bnzcaMv+Tnb9HZ7HhI5e?=
 =?iso-8859-1?Q?NCZpkG3L5QVLC0ElH3Yg565uEAIC4nuU+htnJbd27PojRnY23RXy1srSLQ?=
 =?iso-8859-1?Q?M6/bYyeLancBaL/sOL6z0knQ+Lhi3nAkzGgpsmsi4FxenC5qP2GrmqUkwf?=
 =?iso-8859-1?Q?dH0G8CD1o4JBlBNY/Sr44E?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Nuhe1/+14tpLpUnT0XSrPokVZJ5np1OcJ9UZu5vINKy4zAn4beg7g4YugF?=
 =?iso-8859-1?Q?xbijhdy1wKGCi5zqofpoYFBVBAJeUKGNP+cc+egZEUW178H4KzcQ+2KJaM?=
 =?iso-8859-1?Q?FsVZUGHlQPTmi2C8QLNSlDxBaFjRhd+/iVO1KprFieelCsISdkza2dXKzJ?=
 =?iso-8859-1?Q?92pVtxlCiMh+Ee9WOgdKOHwotxY4ls7xQrU7Eo7YliiW2MzBLfXAhzBCnw?=
 =?iso-8859-1?Q?zlDW1ajHenD2mY0JYCAOIxVWJt7y8BbbSzqidXTkqe5qCyHI3lePHVEg1r?=
 =?iso-8859-1?Q?arfKWoBbm0sbwIN1kHhfiThBqi8fFrPOE6/MNVOQRxOwFDwBb0ZggDcq2U?=
 =?iso-8859-1?Q?rka1oVu4Tb+jEWqyakL/EcXWNicoQBxdMQlfYxeaoaZEriwUzki/B1FCdG?=
 =?iso-8859-1?Q?kIqxRX7Jk4dElRQuzeEZJlAEuCoc/MQmpafcegid9MZK4A+VoVDddJds00?=
 =?iso-8859-1?Q?fme7X+mOmIYnBwGEWqQ3l1tL8QW/hPhcbYTrWHYgh/zeuDGpU/3Z+UeAcu?=
 =?iso-8859-1?Q?KHTK/iZAtUQeSBnUhuptGasFtbtHppOKhLhPSDd8GuafhyqDEb1DUXuASH?=
 =?iso-8859-1?Q?EvllJZYEWTwiFe1/Hjpqo48BhwVMEbiaaiKF9kevBcELt8BiMhK+cO7t+m?=
 =?iso-8859-1?Q?BwoqYiB0mZv0PUMshcK83Bb4/38PdhuSns54ZUGMDa5ns3dyV3ZXGdPXDH?=
 =?iso-8859-1?Q?8iwUuVaYiZ/ACNb1Sh+J5eYgENhzW5n2266nmT2SzquV9690Si2qFF5Vt4?=
 =?iso-8859-1?Q?As41jrA6tG3TtujI4MF1yK8aJyUjNOJSJULlD86cp9b7IlEkc+YKvkyBx6?=
 =?iso-8859-1?Q?omUhz67E932kCfTzZpQHDpTB/LeMspvngiZme+S9l/Vk4muO+hgpzB0F84?=
 =?iso-8859-1?Q?WqAUntBlkSWyNNbadJJOGWn9Ku4b7q/VI1OiL3rcHnyS2wVzKC4XaNTIvM?=
 =?iso-8859-1?Q?5hBFIU2/4jH8LodxDWsL6q2osjgrACr07Nh9xgMYjeY2DtnDq8/NznauMK?=
 =?iso-8859-1?Q?QLAffwz/I1yQVXVCx+Dk6DPG5+b+c2yLy2+RhCWtetnEKYBzo4uEDKWgXD?=
 =?iso-8859-1?Q?RAH2XvM1oql1PU6bs1nEuqBAxLWwXIlCOJO2yILCf5pKBipokKm2XuFIeM?=
 =?iso-8859-1?Q?AWRNT2hOJi+yioKUSbDehu74+b+/SWVuFL1DjNJ2p96a17I1aPWbq65tw1?=
 =?iso-8859-1?Q?6FHeLT16rCZeG1yFg+ANmdSxgnuDkAE/IG8OqNjUYg15X/WkjGSgTaIzoQ?=
 =?iso-8859-1?Q?X2hf/WA29JQ29cuEZIfPaQnAxn/7yiVnlp49ZBxdctJZW6WEYweGzad2gX?=
 =?iso-8859-1?Q?R6PiRNDCZGh75ciBFO9xt+Y0M4TmdsP9bsvHgYozkaZCvydKz6f/WW0XiC?=
 =?iso-8859-1?Q?cSXxwZMF72sFrwAPnRCNqmoWbq1n+Ao1qku1mXZH5p6h8AVd09TWAoWafs?=
 =?iso-8859-1?Q?QLv+faZp6ucT0wXwznrkAa3QdxrD71YDDDV80tVAiUCHztu2cllhhfLtSK?=
 =?iso-8859-1?Q?/W/wRtCuejiNaisTDnrkw/zfYLzk1mpFDfP7/TtQmT55eZu5tjBS9yBMzo?=
 =?iso-8859-1?Q?897iVC12zkksaZ6WW3Ptqgm0388f9Zmors9uLxUPIsvIkWiYbTTNQKOJ9g?=
 =?iso-8859-1?Q?3RnWc2v20PaM0SWTAESXr76M3mCL1e5dGn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b15f757-2a19-4452-9c01-08dd55c63b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 18:00:04.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZfqtcwCiVVaBt0yNcmCczpK8QwlCIfhG00eVmDUdq0uXYbUpHB7Wqu6izx4qWXoEXLzk2zX53/ZsavMZlWHN2hDEGaBt1Zv+zz+lHnaP7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Sent: Tuesday, February 25, 2025 11:20 PM
> To: Gupta, Anshuman <anshuman.gupta@intel.com>
> Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nilaw=
ar,
> Badal <badal.nilawar@intel.com>; Nasim, Kam <kam.nasim@intel.com>
> Subject: Re: [RFC 5/6] drm/xe/pm: D3Cold target state
>=20
> On Mon, Feb 24, 2025 at 10:18:48PM +0530, Anshuman Gupta wrote:
> > Trade-off D3Cold target state based upon current vram usages.
> > if vram usages is greater than vram_d3cold_threshold and GPU has
> > display connected
>=20
> Why would anyone care about displays being connected or not?
As per specs we got to enable vrsr only when there is display connected,
We can check that in probe but a drm connector status can change after comp=
letion of probe. That is the reason to put a check for display connected in=
 idle callback.
Thanks,
Anshuman
>=20
> > then target D3Cold state is D3Cold-VRSR otherwise target state is
> > D3COLD-Off.
> >
> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > ---
> >  drivers/gpu/drm/xe/display/xe_display.c | 22 ++++++++++++++++++++++
> > drivers/gpu/drm/xe/display/xe_display.h |  1 +
> >  drivers/gpu/drm/xe/xe_pm.c              | 12 ++++++++++++
> >  3 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/xe/display/xe_display.c
> > b/drivers/gpu/drm/xe/display/xe_display.c
> > index 02a413a07382..140a43d6b1b6 100644
> > --- a/drivers/gpu/drm/xe/display/xe_display.c
> > +++ b/drivers/gpu/drm/xe/display/xe_display.c
> > @@ -548,3 +548,25 @@ int xe_display_probe(struct xe_device *xe)
> >  	unset_display_features(xe);
> >  	return 0;
> >  }
> > +
> > +bool xe_display_connected(struct xe_device *xe) {
> > +	struct drm_connector *list_connector;
> > +	struct drm_connector_list_iter iter;
> > +	bool ret =3D false;
> > +
> > +	mutex_lock(&xe->drm.mode_config.mutex);
> > +	drm_connector_list_iter_begin(&xe->drm, &iter);
> > +
> > +	drm_for_each_connector_iter(list_connector, &iter) {
> > +		if (list_connector->status =3D=3D connector_status_connected) {
> > +			ret =3D true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	drm_connector_list_iter_end(&iter);
> > +	mutex_unlock(&xe->drm.mode_config.mutex);
> > +
> > +	return ret;
> > +}
> > diff --git a/drivers/gpu/drm/xe/display/xe_display.h
> > b/drivers/gpu/drm/xe/display/xe_display.h
> > index 685dc74402fb..c6bc54323084 100644
> > --- a/drivers/gpu/drm/xe/display/xe_display.h
> > +++ b/drivers/gpu/drm/xe/display/xe_display.h
> > @@ -40,6 +40,7 @@ void xe_display_pm_resume(struct xe_device *xe);
> > void xe_display_pm_runtime_suspend(struct xe_device *xe);  void
> > xe_display_pm_runtime_suspend_late(struct xe_device *xe);  void
> > xe_display_pm_runtime_resume(struct xe_device *xe);
> > +bool xe_display_connected(struct xe_device *xe);
> >
> >  #else
> >
> > diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> > index 81e67b5693dc..6d28aedcb062 100644
> > --- a/drivers/gpu/drm/xe/xe_pm.c
> > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > @@ -198,6 +198,14 @@ static void xe_rpm_lockmap_release(const struct
> xe_device *xe)
> >  			 &xe_pm_runtime_d3cold_map);
> >  }
> >
> > +static void xe_pm_suspend_prepare(struct xe_device *xe) {
> > +	if (pm_suspend_target_state =3D=3D PM_SUSPEND_TO_IDLE)
> > +		xe_pm_d3cold_allowed_toggle(xe);
> > +	else
> > +		xe->d3cold.allowed =3D XE_D3COLD_OFF; }
> > +
> >  /**
> >   * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
> >   * @xe: xe device instance
> > @@ -213,6 +221,8 @@ int xe_pm_suspend(struct xe_device *xe)
> >  	drm_dbg(&xe->drm, "Suspending device\n");
> >  	trace_xe_pm_suspend(xe, __builtin_return_address(0));
> >
> > +	xe_pm_suspend_prepare(xe);
> > +
> >  	err =3D xe_pxp_pm_suspend(xe->pxp);
> >  	if (err)
> >  		goto err;
> > @@ -875,6 +885,8 @@ void xe_pm_d3cold_allowed_toggle(struct
> xe_device
> > *xe)
> >
> >  	if (total_vram_used_mb < xe->d3cold.vram_threshold)
> >  		xe->d3cold.allowed =3D XE_D3COLD_OFF;
> > +	else if (xe->d3cold.vrsr_capable && xe_display_connected(xe))
> > +		xe->d3cold.allowed =3D XE_D3COLD_VRSR;
> >  	else
> >  		xe->d3cold.allowed =3D XE_D3HOT;
> >
> > --
> > 2.34.1
>=20
> --
> Ville Syrj=E4l=E4
> Intel

