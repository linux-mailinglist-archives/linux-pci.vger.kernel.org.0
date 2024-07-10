Return-Path: <linux-pci+bounces-10099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65592DA2E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B328C281958
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA01974F4;
	Wed, 10 Jul 2024 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCj79uVv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8819539F;
	Wed, 10 Jul 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643746; cv=fail; b=ObkhPlpOj9clZsbSNMoyMRi0eg1agbMQ+w7Nw2x2yjqLp0xXF3E1pFO57Y2OQliHIRrGFrGMWtMSSHmBaRKVGGPAN/Vhth3UqYx/pHtGp7ufdNgBzvK9UfZXPTpwR+nc9Q29/Btss8BZ8BAbIOI/F4Jz7KzZn1cXWlev086j5II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643746; c=relaxed/simple;
	bh=ng12j2gIwprcOfdMlt4RQxzoCNREnlOD0SB01gPyek0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4D6ns1F1zm3ihHE2nErI0aJBPQv8Z1gb00D8ww5x0x+/3T2+d4LkYvZynEzffj2vwewLbE0wPrnS+8GVGqP4IB+2EXq1gISDHgCXkKHKaRn4UzgRl832jMb49It9v+x9swKEgS0CFySkkUMQxRW7WeYsoQ/Hl0DKFziqhpoRuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCj79uVv; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720643745; x=1752179745;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ng12j2gIwprcOfdMlt4RQxzoCNREnlOD0SB01gPyek0=;
  b=dCj79uVvjRXYc5r5HLORIVFfoPkOPVZdFizmpdTsXR2PPZkmmP/dF7Gy
   BNuMg/DN9kTjbMsk2Zj0FGufyQb3R0IDXRwgUn+BoLfip2nJRt6rTdSxr
   ZOZIUrDEJdgLmpeNxPpeQEQ1fS+yfTiXqRIWeDzaVg0S3qqIDxozeVcgu
   H6jaMkZ1eDIHsNEOJ/6jcgJM0UG11k23gKejkOE3PJdiwbiP2HCWYWsQo
   qxPgHfjpuGNqhbNb7UlTxfUTNQjysrlefAMFoCtZ7PDywIHP32YJ8lLA5
   8B40daDRI0tX0T+9mK32n7v3a8OEJuAy/EATnMBgCvWX6R6EDNgVHuEKA
   A==;
X-CSE-ConnectionGUID: HlfG0UW/TT+9uAGwUbSdAw==
X-CSE-MsgGUID: yn6t+at8T56ylFfe8XokTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29152439"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29152439"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:35:25 -0700
X-CSE-ConnectionGUID: ckcX68UgQaCRMEexInheSg==
X-CSE-MsgGUID: VfcfCNXtThmQomcHgPi+VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="52724696"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 13:35:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 13:35:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 13:35:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 13:35:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvPb4OnjjKM4+PafthiKfYs/b3qLpW/kwiHt6V0ruuSoCNuUKnleGTZIquU9CWQOgRzepJuDatrtp+xTem/EldNW6Ctcuqc4KHxsOYNI7fb6+vvTRFpcfmH2I+ltlIenPzh3XkY277G9V0G/fVH/RxKxZpXa4pJMdzO7O64UGGBx7E4JtAkoyxe+eiKq4Rby/ABUez9Yi+8fu/Zcuv39mTFDwzTffR4jMCznfddfhtbT6aZZA1jMn4h2pmL6KhLxnRsO3bERtku5TgyCRiVqbzr6LjT7nHOIjMgMy/lsJIT5LBnfroh71a2u2+lwHAGpaur/VfUB7Ae7WCSk8G0g7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCs3S+Am8ZIjrvMSuu+EfA17+XMEHf0FRQRRYKP5Au4=;
 b=KF4r5BOYGx5F9Mso+OlOvsAemAK/DkqdjpHJo71UG2QytHVWsciVB5o9kQZ9FaXXZMWbcVfntA5NC3UbHG8eV3bXHkpeaqqPqxx7hkJ5rNPFGAT5T44DLYjfFq28fOzrJcvRTCFclpA2z330YUh8NJGEVoc/YDQ429yrcRkZwueTTY+KsuFZcQjs8l3LzHJ48XpEiJJuPjCyZllwIxPNo9RG8lI6uFFTIYdW7MUAAK7PFR8sRQKvU/KeGiXZEuzRcL0KXmVsvgSTs43VPizYLi7TYpCokOMLHpphpOxDqew8NPWmrFQlZ+1ahnYqh6uNe+96gggBjBq11l+ogAr1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 20:35:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Wed, 10 Jul 2024
 20:35:20 +0000
Date: Wed, 10 Jul 2024 13:35:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, "David
 Howells" <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal
	<dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani
	<dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, "Jerome
 Glisse" <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 09/18] PCI/CMA: Validate Subject Alternative Name in
 certificates
Message-ID: <668ef0845f787_6de22949c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
 <8504d6303fac89d2d3a9c0661176d9cd1bb676fe.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8504d6303fac89d2d3a9c0661176d9cd1bb676fe.1719771133.git.lukas@wunner.de>
X-ClientProxiedBy: MW4PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:303:b4::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 8844d311-fb84-431d-44a0-08dca11fd11b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?17GOunAdHG8pdqq+ydV+sO02prH2UCjsyjvAmGFqIbcblrPcsBFXP+iFC1LP?=
 =?us-ascii?Q?oTlcniCk44DuS1rTFCGJViy+rN9Vhp/z6dvjan6qCGFCQ1uAK+OFuATwKFFU?=
 =?us-ascii?Q?EYLOL63+C3rokmC0Yf1cWoowufNHodnAmAunLULMjn+NsaWKWZlZNP13RboN?=
 =?us-ascii?Q?jtp+iU40yKWW4RcDtwDGCaWdI1orkGfH+uJ0DF3O7YXOqDptjC07HJ4vs4r0?=
 =?us-ascii?Q?E1ceWQIaCkcQxpy1K/9zg4Z0xJAW4IYsJ4TAh22/mxQriOplaFwl+DxKIDM+?=
 =?us-ascii?Q?ea9SzLKwm/mFGAsO2M7MBSY7G5KHUL8YhNzX1o/pQboO0cSYgBaJlcheiDDZ?=
 =?us-ascii?Q?l8KKZiic4fB6kjWRhMP0EeIIV3jpZcvwSkTIStTPgAaW6XkIYCV/ajgrHdCy?=
 =?us-ascii?Q?//rNbB7dAStboqPG4CNqVpRvjoSEaOa2EhFLEq2tmwAtw5OzVYyxixYAFbGN?=
 =?us-ascii?Q?jPLsbQ22PWg0v2co9LBzrcCU3ZqRRckOVzvrAPLMk8rAo0yd+9vV9LFR55X6?=
 =?us-ascii?Q?yVdzuLyfhFUhS39ZGpLilp965DTwGEHenaLNrY72AqPMrat5aEfNM678QYvM?=
 =?us-ascii?Q?Oc5a+iuhzbHUK5j/hgKef7v6ZZw9klHp1g/gN13Nitf6D3wD8QFaaqcE8AjF?=
 =?us-ascii?Q?efYQFALznTXeiA0vgMPSTqjBS9Pno6TUUWZoRswb+emJnq0nF4r+e0miI5L2?=
 =?us-ascii?Q?uPVuJoVgb6vLw7XNc8W9wPQMeutB6Xar0D1vC2pwc+NPsmCxnUZvpdun/Ejt?=
 =?us-ascii?Q?7hwF3IL4a3xH1JihXco/uUGy6iwSbQwJeii8/no1qFo45a9m0VytH+75VSLD?=
 =?us-ascii?Q?KX/eOUwtOuPcFiYzsoB2yOLF84NFBMTa0fkjZhxd5kGxKcj3z9a8YJFIe/zL?=
 =?us-ascii?Q?HgoBYmGj6tp04a2Fd88KGpaDT2O9HxNh82zcVZDILHE4d8f1Vknlr/PYh10I?=
 =?us-ascii?Q?z3S92OmYd7r6vEq7x4uxgAOmCAfdOD3ZogCXwdsejyWepMlcCd5cSE77NrSf?=
 =?us-ascii?Q?C/ndEOkCZ77roGAU/4pEK9NoGFRQ6dzE3dydtb3jNcxfGmYmZIJQmib0098y?=
 =?us-ascii?Q?WJ0ahKXBuAJrhsatsRy+D7AzkHLS4LkRODB04GKrT05SfQgVHGWZF+iuH1Tf?=
 =?us-ascii?Q?Rgx+QgJDjjjLo48MsRE5O9n50Epq9aJPmn2GNHdKQSDKOiDGs+YVbw+TW19d?=
 =?us-ascii?Q?CQQIwk36jcTc/ucBz9SUzM6iR62ARmqdapJK2903IEbK8rfPg40ujENA26BO?=
 =?us-ascii?Q?jg2ymzpf46W5T4vqYnIgqCGOa8wXb0XmmPnx3tumyMzgxJaXZIN1A616eFHp?=
 =?us-ascii?Q?s3LJdfcd2WrT0+KTpQ/hpFH2/GL1SJuICLdffe9cDCCDLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGwTcve+5hxuEwW+1PrJSaXH8D66BTgfmbkScq3T8do/qHxlXsBbv3fnu8Ug?=
 =?us-ascii?Q?ujEchK05o4ZND9JzRpOVlnxIZDO1aGhDaHz71MVkGshLUVY3R46fim8cubAP?=
 =?us-ascii?Q?1S2GaF+M21V3Oex7tIUapKSNCY8C+T+GiYQUgnyBANYqUTqZEU0VxoCvd9Nl?=
 =?us-ascii?Q?9p6CtFURSciHhgPk9H9Y5/yQ0reK0NAuhBN1UjZk5vplddYEep+1sRE2XGvb?=
 =?us-ascii?Q?1hoLMIaKL9eeEbWyG9NFHeRDyha5eMsC6qfSMgiaovf38TvvpuSkVBgaZtmq?=
 =?us-ascii?Q?iKaGGxCDRUYgsPctkVk2T/9yhTYO42OD2RsRCMf2yOCopYHji6MZEgE/nlU0?=
 =?us-ascii?Q?OUu9cRa126AJG4tQ797G78+v4xN1vrXZAtRyymDDmfIlfKKrjr3U3jfOVMw3?=
 =?us-ascii?Q?JCCa96tRZtQojYKKkO5c03ehXlEkrqE+Iog8B2dgltGPgWddkMQgZkubd7QI?=
 =?us-ascii?Q?ZqdaLvRS3hnAPGDGJcbmxfG1uDCIBnyviZY18g6tneVYcqRw7S+7crMpQ3ax?=
 =?us-ascii?Q?EEApPffpqlllO6HE2HHTq7AVm01XX2Wycza/2mRyGz2dF/9IY+EnVGH4Siod?=
 =?us-ascii?Q?3gAr+9f/wTMvsadxDXKm2GihlEHwpdYKHtWFeV83n78B9+11uMqVt9mdpB9g?=
 =?us-ascii?Q?vDY8IlDxhz8++OBmdhc7Ob3CQl0RLZegzLMdLGx5YWGuU6sXwAtJ0a3LCyHs?=
 =?us-ascii?Q?+yQ46D5zhOKWC2wRg0pAe2sOFRxFVx0ka0Rukxo5p/a0RK4K9jwTZh4wrfFM?=
 =?us-ascii?Q?+VOWKF32BjFAISwaEeP0SwSJLbYqGPv4b2X/jOq4pXrMe6T7JCRYPjF5Ua9q?=
 =?us-ascii?Q?wChz2IvN4oW9ZStUi6pedt63iXtli1eWfaPL8/g7mx20WEkeiMsc1Vid91My?=
 =?us-ascii?Q?2OnbPpoJHrW/GCtGF288g0AGF89hTUHunzsgIM/ioi6Vd+3lPjVoAeYYF38X?=
 =?us-ascii?Q?EmVC1fhS75GgzDeuI87BXjfCN99plmc4GXR6Bkg925Am3wZ8MAJC/+IXhMAD?=
 =?us-ascii?Q?1sA0rtfATRGnbMgr9ApGV5uHCrKjJBGBnI+YVFbwtbVwMtATLm7ho2fD99nW?=
 =?us-ascii?Q?QrN6imb29FQjU6/c96iXaXIupzGlkgM5vjk2pCWD2jWHBoJwj7VuC5dg4+Mr?=
 =?us-ascii?Q?n/xlQzaeYYsKMoF6q5e3+myroSRa3IIKYVW/ej+DMoSXcGTWAPfPmaig6zDl?=
 =?us-ascii?Q?O01kId/8psJZOGLszH9yV3Rn7I6IS5ysPzOmtV+aFEKNRBdVo22DLwVI/PjP?=
 =?us-ascii?Q?Va543iBoKOy7B5T6HXn2cjxQv7NvboHrnFZgIHwCv1+f1pU5UCQabAMhzkN0?=
 =?us-ascii?Q?W4nYpGrg6uwepRgpFgkTCLDmi51+y9E5kasxkl5LUeU6C7su6/mDOe8O11nO?=
 =?us-ascii?Q?CUxNa4Q98/XbOCxCC06krKC7O3Vu6QjWFKdpWN5Gb7gl2fA7yLF/1y4WoRdE?=
 =?us-ascii?Q?4Tq9dwZXNMPbU0tYalyUeBJagiF/RO3zsLHCo/WGwKR3JjO6Z1eIdVNmDQHf?=
 =?us-ascii?Q?cjaYvjBW5l7DA8GwAicytJK8VtUZgzB5PHu3jJAWylHOB96CMLDlYe5o2D8s?=
 =?us-ascii?Q?jc7/PCtcTV8MKTlBqbPYZ/ZTZXA2/1pqBOtB3OKzvlzP6eSMQPtsalx7PR/X?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844d311-fb84-431d-44a0-08dca11fd11b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:35:20.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB/2ci1TS6ZOYgylyUqs3aw4SNSzGP6abAz0927WXvm8vLloTULyTiaXcdoqKDxGOZIURAltiXg9puhZZ4KAdGGnoXSyJ6la0yMDWngBRMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> PCIe r6.1 sec 6.31.3 stipulates requirements for Leaf Certificates
> presented by devices, in particular the presence of a Subject Alternative
> Name which encodes the Vendor ID, Device ID, Device Serial Number, etc.
> 
> This prevents a mismatch between the device identity in Config Space and
> the certificate.  A device cannot misappropriate a certificate from a
> different device without also spoofing Config Space.  As a corollary,
> it cannot dupe an arbitrary driver into binding to it.  Only drivers
> which bind to the device identity in the Subject Alternative Name work
> (PCIe r6.1 sec 6.31 "Implementation Note: Overview of Threat Model").
> 
> The Subject Alternative Name is signed, hence constitutes a signed copy
> of a Config Space portion.  It's the same concept as web certificates
> which contain a set of domain names in the Subject Alternative Name for
> identity verification.
> 
> Parse the Subject Alternative Name using a small ASN.1 module and
> validate its contents.  The theory of operation is explained in a
> comment at the top of the newly inserted code.
> 
> This functionality is introduced in a separate commit on top of basic
> CMA-SPDM support to split the code into digestible, reviewable chunks.
> 
> The CMA OID added here is taken from the official OID Repository
> (it's not documented in the PCIe Base Spec):
> https://oid-rep.orange-labs.fr/get/2.23.147
> 
> Side notes:
> 
> * PCIe r6.2 removes the spec language on the Subject Alternative Name.
>   It still "requires the leaf certificate to include the information
>   typically used by system software for device driver binding", but no
>   longer specifies how that information is encoded into the certificate.
> 
>   According to the editor of the PCIe Base Spec and the author of the
>   CMA 1.1 ECN (which caused this change), FPGA cards which mutate their
>   device identity at runtime (due to a firmware update) were thought as
>   unable to satisfy the previous spec language.  The Protocol Working
>   Group could not agree on a better solution and therefore dropped the
>   spec language entirely.  They acknowledge that the requirement is now
>   under-spec'd.  Because products already exist which adhere to the
>   Subject Alternative Name requirement per PCIe r6.1 sec 6.31.3, they
>   recommended to "push through" and use it as the de facto standard.
> 
>   The FPGA concerns are easily overcome by reauthenticating the device
>   after a firmware update, either via sysfs or pci_cma_reauthenticate()
>   (added by a subsequent commit).
> 
> * PCIe r6.1 sec 6.31.3 strongly recommends to verify that "the
>   information provided in the Subject Alternative Name entry is signed
>   by the vendor indicated by the Vendor ID."  In other words, the root
>   certificate on pci_cma_keyring which signs the device's certificate
>   chain must have been created for a particular Vendor ID.
> 
>   Unfortunately the spec neglects to define how the Vendor ID shall be
>   encoded into the root certificate.  So the recommendation cannot be
>   implemented at this point and it is thus possible that a vendor signs
>   device certificates of a different vendor.
> 
> * Instead of a Subject Alternative Name, Leaf Certificates may include
>   "a Reference Integrity Manifest, e.g., see Trusted Computing Group" or
>   "a pointer to a location where such a Reference Integrity Manifest can
>   be obtained" (PCIe r6.1 sec 6.31.3).
> 
>   A Reference Integrity Manifest contains "golden" measurements which
>   can be compared to actual measurements retrieved from a device.
>   It serves a different purpose than the Subject Alternative Name,
>   hence it is unclear why the spec says only either of them is necessary.
>   It is also unclear how a Reference Integrity Manifest shall be encoded
>   into a certificate.

I think this analysis is sufficient to justify the Linux requirement for
Subject-Alternative-Name. I agree that it seems odd that an FPGA that
changes its id also does not have a way to provision an updated
certificate at the same time. Like I would expect if the new bitstream
is signed then it can also deploy an updated certificate in the same
bitstream.

Unless and until commericial devices arrive that violate the expectation
with no way to update the certificate would Linux need a workaround, and
even then it would appear to be an explicit quirk.

I can see debug scenarios where it would be useful to relax this
requirement, but that can be achieved with local hacks, no need pressing
need to ship that debug facility upstream.

Acked-by: Dan Williams <dan.j.williams@intel.com>

...don't feel comfortable offering a reviewed-by on ASN parsing.

