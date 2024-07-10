Return-Path: <linux-pci+bounces-10034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1EF92C8B9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171B11C227DD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F088A17BD9;
	Wed, 10 Jul 2024 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AeZnPZxR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZVJV+lCK"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA817FD;
	Wed, 10 Jul 2024 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579699; cv=fail; b=YVaWNbSuDdjWtrI+orYzyRDY2xuYtm+TLsTVoLu5cK0x0vfqFzHx7io0jVCEP/Z2NR/vuSVSewS9dimZbZl5yBQfIAg5NbZodsN4Tc/wRC7EjT/YtoE5tVhGjqRAa8kG80R3sipYw33Qo8fODuYSL3O8DPzVUr5KEZ8zpJKhiZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579699; c=relaxed/simple;
	bh=IUaIyF6X7y4gdY4KJt9JEgVi60hpBmuThTCgOSC3Xb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sw6Ggm/Qnw1VK9Pc6Pou22ByBnd9/TlfY4nVAUtLm70BIwNxx10Jf01QpMt716XEmoKSwokBPKaY/yUHxbDnfv31KTxxIO9jZLOIXNyphGsI4im4PduYk2sdM2PDR3xhAdQBd5oj3bgfXQY6z0I8A2t9hidXkBNMfOOHGVwopWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AeZnPZxR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZVJV+lCK; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720579698; x=1752115698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IUaIyF6X7y4gdY4KJt9JEgVi60hpBmuThTCgOSC3Xb0=;
  b=AeZnPZxRUhmjZPha7MTlWd5BsNgwp0vsdFrprD/uiPEe1HDHqPBruJJL
   EAPXbsu7ztsWxcknhuNqXczwOhR+bYd4a9RFh8oZc2UjNopNu3ZjGxTpm
   lQt1cAkxBG/Q7ClaB6y1JJjmIyRxxuSoLQeU/631n2883YgUPF1VkhfAl
   o32ReEwc1fr0c7VamU3CysbhtuHrrPL9MzK5sc6wK7n8zO104MG4z+B+y
   W25plZb5yBFDWIfrKQI+w5ROOSgQ/SQgLXT6FZS5/hT92qrp0tO2HF8wC
   8vU0S7sENVLEjkh+vFyiPYXc9DNXj0WR3L+Bev/H9c9CIYUFOHXyhZQSG
   w==;
X-CSE-ConnectionGUID: 8YVN7BZsRhGS6BREg0qC6Q==
X-CSE-MsgGUID: aSvKU/xJRMSz9y7rXfI7Dw==
X-IronPort-AV: E=Sophos;i="6.09,196,1716220800"; 
   d="scan'208";a="20486557"
Received: from mail-eastusazlp17011006.outbound.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.4.6])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2024 10:48:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGNvXIoDr1w2sdU+AMb37KVfyRb/iQ830ixo1ZZJBD6E8UITq0K+NKVqd1C1yMSK2AXF1JB0JSeTFLoOxmenyfYqcNj54YNWMBvekd7cE4d00eLVWuPMCxFKcJLl9IuYiwRWfbP/kz2c0N1b76lHl5hS7qyBIadxxyFjG0KD8gTjBL2nhfRXDCn6lV7sxidw84m3sNiD6hJhjhI/VS4fX15xH3AB2Yj1ovBp1atf3nS/k5x4ZUyrL188nrzTxrfd3onfpHuFLSpcXEfpCOudhWhQ8KsfB0qZit3NeqCcCqKKmT7UluybncbRFdVrzNTABJ4aENwWGguYwlztf0H1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUaIyF6X7y4gdY4KJt9JEgVi60hpBmuThTCgOSC3Xb0=;
 b=oEtugE7vZPiHBbA3N/osIws2JuiS/QE2SHXccYIsVEJ7OI86h1yqXpYU39+GAccf2x5OjK8m15PLqNbg5LvE5IQo7Rgi1jWEQtrLG5KfBxdcb0hrktmP90RWkN3pLugxiqvxYY4WqxAuKx1s9xydCMVczr2Rqp5H0Z0L+JB6y27Jkd8cD+sMp/zPd5tDIyMuHa9/m0X2LgfBrH1i9JEt925Raq+ymZl0HPVYuthlA+GivMu2DGd5glZiAjsnc3VsI+PjS0jXcc1oHPIO0eF5w99P26HZ5mLHSZJqnKkn+5k76F10cqaLQ4/T5BflCkctW343jClk8GYkgtdktxGurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUaIyF6X7y4gdY4KJt9JEgVi60hpBmuThTCgOSC3Xb0=;
 b=ZVJV+lCKoaVuNHEu7CGfWPjL2QPZKD42YGkKg9zoF2TEBUO+1xmHkcM/EKjwv+AuhU3+52fK6IWyZXvON9BsjlLQYdqvAHD1wGyJ/wd+s++JwMpN74CqTKkvDRQ5yv78J+Uj9PmwNKmnwsFB9a66tmgehKTsJnGs20dymPGQ/qY=
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com (2603:10b6:a03:303::20)
 by BN8PR04MB6274.namprd04.prod.outlook.com (2603:10b6:408:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:48:06 +0000
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc]) by SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:48:06 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "dhowells@redhat.com" <dhowells@redhat.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>
CC: "ebiggers@google.com" <ebiggers@google.com>, "sameo@rivosinc.com"
	<sameo@rivosinc.com>, "graf@amazon.com" <graf@amazon.com>,
	"jglisse@google.com" <jglisse@google.com>, "ming4.li@intel.com"
	<ming4.li@intel.com>, "gdhanuskodi@nvidia.com" <gdhanuskodi@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, "seanjc@google.com"
	<seanjc@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "david.e.box@intel.com"
	<david.e.box@intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"dhaval.giani@amd.com" <dhaval.giani@amd.com>, "aik@amd.com" <aik@amd.com>,
	"pgonda@google.com" <pgonda@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v2 02/18] X.509: Parse Subject Alternative Name in
 certificates
Thread-Topic: [PATCH v2 02/18] X.509: Parse Subject Alternative Name in
 certificates
Thread-Index: AQHayyaSNoBiUPvGnUK3nJagTcPAyrHvUN+A
Date: Wed, 10 Jul 2024 02:48:06 +0000
Message-ID: <00c2f75bf979fa9131957a3595ececa5ac584917.camel@wdc.com>
References: <cover.1719771133.git.lukas@wunner.de>
	 <b5e8ede319f374bd7be08c9963487e83cee3496b.1719771133.git.lukas@wunner.de>
In-Reply-To:
 <b5e8ede319f374bd7be08c9963487e83cee3496b.1719771133.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7872:EE_|BN8PR04MB6274:EE_
x-ms-office365-filtering-correlation-id: 90830f14-197d-47d9-3709-08dca08ab9d3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnZtYmVCcUxTakpnUnlZU3ozMitZRC9IZllteFBrUFo4RW1BbC9RN1VKeis5?=
 =?utf-8?B?aDdQckVPUVEwN3o5Sjh0NlBKN0NtQ2VxZmFtcVFIR3k2TTlFZzl3YTY3OWRW?=
 =?utf-8?B?aUFQTXpoQXFmd2ZLdkJKNG1wUFp3c1pNMFY3bHdyRE42U1N4NmJxZGs3Uitm?=
 =?utf-8?B?TStSVENadm5aUSt6Y0g2RVZlTlVsVHk3WUJaL2piTDRJZHJ6RndxM0VPMi8w?=
 =?utf-8?B?SHM1bno0U3IzaDBTUkVUUVFXSWJUUmF5bExmb291MnQ3RnlSUkY3cmRQbEsr?=
 =?utf-8?B?TGNmVTNPbjdaZ0NxS0JmT1N2WGtaa0JLMjNVY0I5OUYxZXg0d2k5SnRaUitO?=
 =?utf-8?B?Qyt3WFVSYWg5ZVUwR1M1c2hyb05YcFlsUG5MTEoyUnM1bnFYSTUrWDV3L0dM?=
 =?utf-8?B?aFJDeDdwdS9uL2ZSQXIvVFNrKzZYL0Q5dnhSNXd1Mk1UbXhoUnlEZ1ZYcitB?=
 =?utf-8?B?cEdJa21Fc1dvOWE1OW5nWlUrZC9PVUhCRVAzUzdLMHNNUnNNVTQrTm5yT2dQ?=
 =?utf-8?B?cUsxQm5CQ1VzNm00NVJ6ZThnNWprVXFoTDBlNXRZcVRVcUNic0tOS0F1U0tp?=
 =?utf-8?B?ZWFtTE9tVlFoSEpWeHJiM0xFWHU1RURneWRrRGg4TEIyMW5HQ1A0QmpOMjlZ?=
 =?utf-8?B?OE9NcmZMcEtEWnRVM0ZQTVVVTXVnbE1iaHA2QUFzVk5lTG9IVjJiaTVGK3Nx?=
 =?utf-8?B?Q2xBK0MwaTV0SHZUVnI1VFNOdlIyMVpJL1EyQVVScXVzZTdrRlliWkxUSms5?=
 =?utf-8?B?TFRPYjFwQ09hVEtPSW85aUNxenZjaG83WGtza3RrMDlINEYvYmlhRFFVZ2Ez?=
 =?utf-8?B?RFhYYWRnSDJmdDFwbHZzRm9qbXdackxLTzl3NnpaekhDU2twTFhtTlNSZXZl?=
 =?utf-8?B?QU50T3owSUkxS2s1NGxrK09wQk82V0Rwc0xFejRVUGRxa0ErYVc2bGlsZTUy?=
 =?utf-8?B?QUszSjRpUUJtcnBFbkllR1AvNWpvSklFQnI4OWRCanhybmZOWlkwSlN2SXJp?=
 =?utf-8?B?YTUxNkpwck5taWVMK0lnaHh3OEhGUjNKUzNYd09JdGxrNWNmd0wrSWVBTjZS?=
 =?utf-8?B?SjZXOXFQc1laNHlUYXdSa1JubmRDTEIvL0ZMdUxiK1FIdGdld2RnU0c3V0Ey?=
 =?utf-8?B?aFNsa0tJaWFHdGsvOHQxaWd3WEJrYUdWbENQcS91WjFPS0dkQTlVdmlZRVJo?=
 =?utf-8?B?VkdyWisyc2JxVHRUTlByRzdDN1JwRGFBdGltd0V2dENJckhlSHdjMXZuaDlN?=
 =?utf-8?B?bmNpb0tQY2ptUHB1RnRReEp1SVgwNkJqeDFBQjNhR2srdTlhUitFQ296emt6?=
 =?utf-8?B?ODc1TDJVQnduMVEzbUI5UFpVaWJMQkRhVlhGbG05QkhIUVh5QnpZKzhZM2FW?=
 =?utf-8?B?TkpidnEyMkVzcVdMbG8rd2Zib29WNWZjTXFqakVQSUtIS09vNHk5N1JSSXpn?=
 =?utf-8?B?UkU3c1VYcXdQYVh3dlgxRnVWc21NSGNmS2dYT2lwVWZaYlY4M1JiSWR5Snkw?=
 =?utf-8?B?T3pxUnpqNzhTSTJ1N3B0N3Vhd3l6Q1g3VE5DK1pwRlZEVFVwZGZheTExSC82?=
 =?utf-8?B?bzcyMDVjeVU1UVpXcVdNN3EzWTlmUUVVL29tV3dRR2F0dkYxa05vRXFxSjl0?=
 =?utf-8?B?elkyTENRTk8vanJkZm05ZVZRVldrbS9HbEZtS0pxcXBvWEdDeVB2NTRERHUz?=
 =?utf-8?B?TVI5R2tISTNtMXpldlhZV2QzRDZ2RkR6RkMrdWU0WUVycVVuV3I0MGt6SVJH?=
 =?utf-8?B?cEIwMURic3hEK0VaYkgzbytzQ1FVVmFuUXY1bHI1eDAzWHNTTWY0UzhYNE5o?=
 =?utf-8?B?SnMrUjhkR3QyQzB6YUNoUVBqa3M3ODB6aEVBaThhS3RTT0pGSHBQY2ZOanJz?=
 =?utf-8?B?WWl4WGNRb1gzR0hneDJ0OE9Pc1JNZUpnaG5pajY1UUs3UnRiU3BUY3lsbEtD?=
 =?utf-8?Q?yyn7iq4KnCg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7872.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REhMSGZwZDI4dFpWay9UZlZ4RGVDTENHU3o1N2JHQ0d0YjJuOG54TXdUVXFs?=
 =?utf-8?B?MHJwQWExMlNCSjNlZzlrdWVtRndEaW43ZmxGZ2IxTUl6d0R0U3BObzlVQ010?=
 =?utf-8?B?Z2dWdlEzWXlUUlNuU1NCYzFnVVZOa1pYYmJ4TEpDUWR4VVFFMEk2YVEzd0J4?=
 =?utf-8?B?dDY2RFpRM0k1NzlnWXN2ZlRQcWtCMk1neUJyYzhMaTZNM1FCMVdlaVhOVDcv?=
 =?utf-8?B?aXIybUQ2VVdhSFRGV25BVVVjR0tXbldxSU13Y1JESGxPSzc4S05LSTFBVTVU?=
 =?utf-8?B?KzRPemZDaFFOY0JGYTAwSG11UXBoek9taXo4TkZ5MkJPcUJiYU9yYUczcUdJ?=
 =?utf-8?B?eW5DWFMwSE92Y1JMSVNncXhzeG04d2xIbUkrUGpXR291RWNvRWcxR1JHN1hj?=
 =?utf-8?B?TTVqMG1MNDIxSDNxSGVpZFlyR3ZLaHdOZjEyWU52a3lQQURqQUhuRlNpSjFK?=
 =?utf-8?B?Z3V3ZWRib2F3UTQyRjEyRStoNG1zcERzRmptU3VsR05vSHYweVVRRXJ6U0ZD?=
 =?utf-8?B?TEQwS1M1MVNLVm1heGRRcDNyNi90MzEzbHByc1pBNXdvOXNMb0gxc2UyVXJy?=
 =?utf-8?B?c29Vdkx6ck1VbGlHbXQvVDFGWFkybGx2bzJSVFdkZUQ2Yi9rbkRudlNEMXpD?=
 =?utf-8?B?S1BHc2NlM2s2Q0xlUnR4dXI5aSt3bSsrUnh4UE9mT2RzYXZlc2Q2eHhzOU5p?=
 =?utf-8?B?eXd0bEl2YWNTbVVvQ2FJZUUwVnBvbU1HdGc5ZFNwV1Q5ZEJRb0JnM1dzUTV5?=
 =?utf-8?B?YTg5dVplRDI5ZTJ6ZCs1c2x2ZnFna1QzM3pFbHlkbisyYW9uazlRN24yTEJK?=
 =?utf-8?B?bWN2dzR6WWVlRDM3SGFwN1Q0U2ZzNmVGWCtxTDU2NGMyL3d3STdxcXRxZVlx?=
 =?utf-8?B?bXhOOTFPdWE2Tm9zMzM0SGN0Yk9VWGFUWGYwaythWVQ3dXpmNE1GZFdpQlp4?=
 =?utf-8?B?Ukg3V3dGVmdNUWhNY2tGamFnZ0pDcHhuTEl6bDFDcWEvbGpjMlE1UlBPb1Vk?=
 =?utf-8?B?bWxlMmRSTW9SbTdyQm5UTTF4NGZXOUxqNXd2YWZRczU5ZE4xSGo4S3F1Q2l3?=
 =?utf-8?B?Y2pEOWNnL1ROd0NrLzgzUGNOWGhQSWFzSHF0TTZQQVlqNWdZQmY1bUtuYks4?=
 =?utf-8?B?MVRhOXJkTkhDMUtVREJXQmhWS2x1QmpqR3RjZC9LZWdTVGM0K0RlL1ZiSFlt?=
 =?utf-8?B?RW1WcytBY2dWbHoxOGlLNlRCdmRXd0JqWEdDeGJLNk16Z1FFZzYrM2trdk02?=
 =?utf-8?B?Vk1VNmh3VnRUWnRQLzZ4K1pFWXdBOXBQWWlLakxvQkY5R05DMktBTEdnS1Bz?=
 =?utf-8?B?WHJPaDYvZTdyQStZZVQ2dWJFcmtkOGtYaTlkUmdsM3FreGdMZVhuamsxd3l0?=
 =?utf-8?B?OUVyN2N1UlVCdU1jcnoxWHlRK3MyUGljVGJnYVhld29MRU55cVN2cnhTTEdC?=
 =?utf-8?B?K2hEUk1Wd3lEcTlrajNhZ2piWXMyWWlCblRZQ1hQRWNpTmpWS0V0SmNJZENa?=
 =?utf-8?B?RnFVVS9RRFdSWjF5N2kza3pCSW0rU016RzBUU0lWSHdYeTJCVEx4SVhuS3BM?=
 =?utf-8?B?TFVpdVMrVFlWQWduNVdLejZxY3hlb3RDdlZUeHBuWnU3OXZHcVVSSWNHQUYv?=
 =?utf-8?B?UXRBSEFONVJDMExJVnkxMHJ1WTRGdnk4MlpWZ3hySlJjVXlGMGg3b3doUXNK?=
 =?utf-8?B?WWlqZUpCOUpFQWViazNVNHFSNGFYYlZWbkIwVFV2eFpqcFRhR3Y2ZHpRVHVW?=
 =?utf-8?B?d1dTKytxVU9QMEU0YUdYWE1INVRoOHNDL3NLdUJxb0dUOURVTHF4OEZYSW5n?=
 =?utf-8?B?VEV0SDFsbzdKaDY0Z0YrSEZiOVhKdW10T0lTZmhhT2tES3B1TDdsOGE2b1hs?=
 =?utf-8?B?WHNTZ0U5SHdlSC83V1YxaTNNTWdqR05wTTkrdkJkT2JmSW4rbjl4VzljeEo0?=
 =?utf-8?B?ZGZyNEdSZXNIbk1XVytGNDNLcmZFOXhsRDA4Qnl3RmpWYlAyVExENDVCZDl0?=
 =?utf-8?B?NEJFbmUxNXd4YWJ5cnlsWGpXUHFTWHE3bXIzcFdxRnBRZEduM2srN1p3c2VW?=
 =?utf-8?B?WmdxU2FnL1FId3NUZ0ZjcEtvUjhsSCtUdDNlbTFvUGZSc1RoVWZ1SHhPeVZL?=
 =?utf-8?B?c0gxRytTMUhrcno1YmdiY3MwWjdKMjhEeTQzUXdlT0kwcW9lUThnekhVTHBR?=
 =?utf-8?B?c0VCY2d5QmQ3eWRISDF2VHR4Z1pqMU1uT3ptVnFPRnlYUGloY1R1S3cwZWV0?=
 =?utf-8?B?RDhHZXl3R1c2aExUbG1tUzdzVmtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4A55207417649408F789BCA464C5D79@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BDlRN4gH9sKSA7tMHSZyAVcJ0GGyxYxFsYzwSJTrU9Y5uPJZGadFC8xAcZtwxaKoBFi4Zg0z+f7Ur9cMGTb4pNCEIhBrjaEf5kjXw0qeo1mcNeC/soW76exvchEeMmsef1jp4LWK94P4KoHKlU+TNa6876mRQsyIJUT52ykLwB04bzyfkpRyEqhe4xzEcL/XBd39xWUaohtbwI6qkcrTwZ7guzyblC6y6kkzoZd6MkWFzR54aboAQbZC4RJZ1O/xjZw/PTFalHrzKEb05vniG3F4G/EI/PtDh91yjYQxv+r0ZrxUElNqxHDa6tuojRpmZW+Kn6QmY2gGrcftYOFIqr+iRc3T/B/hueEHdZ0N62uQJ/4cQ9a7nVEPNVX7lOYEktACcxkwk/VU/2ENCxe8l0jcQNxAb0WBUR8HmfeFGCrCS+xhs/ZCZUBoyDwj+KUC886MRvBmx4WyM0uHMeTVWvMnmUZczDi1+ZUixMLlXIH+fmngYgsr9KYWa0hZbLrBGaphfeHMScR0a6pUnQZouNV/hT7nzR6+V3sNWZojH3o62afxAuTTXu+g9apnCQ9+R6xc+7saja7hcOt2IUQC9pv46CyCd8MpP3KU6HvqZugP+MDO31Q0OMqhysd11/3D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7872.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90830f14-197d-47d9-3709-08dca08ab9d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:48:06.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LvO+sPDiV9aopvlV6fPoePU9icqDa+axHfo/eLNWoP61zfGzAjPpbgKxmgaDlHaQFZ9pwkjwNFBF/4/uRC3IdJYW0StS5G/2kNv/ZXCTvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6274

T24gU3VuLCAyMDI0LTA2LTMwIGF0IDIxOjM3ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IFRoZSB1cGNvbWluZyBzdXBwb3J0IGZvciBQQ0kgZGV2aWNlIGF1dGhlbnRpY2F0aW9uIHdpdGgg
Q01BLVNQRE0NCj4gKFBDSWUgcjYuMSBzZWMgNi4zMSkgcmVxdWlyZXMgdmFsaWRhdGluZyB0aGUg
U3ViamVjdCBBbHRlcm5hdGl2ZSBOYW1lDQo+IGluIFguNTA5IGNlcnRpZmljYXRlcy4NCj4gDQo+
IFN0b3JlIGEgcG9pbnRlciB0byB0aGUgU3ViamVjdCBBbHRlcm5hdGl2ZSBOYW1lIHVwb24gcGFy
c2luZyBmb3INCj4gY29uc3VtcHRpb24gYnkgQ01BLVNQRE0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4NCj4gUmV2aWV3ZWQtYnk6IFdpbGZyZWQg
TWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+IFJldmlld2VkLWJ5OiBJbHBvIErD
pHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBK
b25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IEFja2VkLWJ5
OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXIN
Cg0KPiAtLS0NCj4gwqBjcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9wYXJzZXIuYyB8
IDkgKysrKysrKysrDQo+IMKgaW5jbHVkZS9rZXlzL3g1MDktcGFyc2VyLmjCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAyICsrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2Nl
cnRfcGFyc2VyLmMNCj4gYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9wYXJzZXIu
Yw0KPiBpbmRleCAyNWNjNDI3MzQ3MmYuLjkyMzE0ZTQ4NTRmMSAxMDA2NDQNCj4gLS0tIGEvY3J5
cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMNCj4gKysrIGIvY3J5cHRvL2Fz
eW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMNCj4gQEAgLTU4OCw2ICs1ODgsMTUgQEAg
aW50IHg1MDlfcHJvY2Vzc19leHRlbnNpb24odm9pZCAqY29udGV4dCwgc2l6ZV90DQo+IGhkcmxl
biwNCj4gwqAJCXJldHVybiAwOw0KPiDCoAl9DQo+IMKgDQo+ICsJaWYgKGN0eC0+bGFzdF9vaWQg
PT0gT0lEX3N1YmplY3RBbHROYW1lKSB7DQo+ICsJCWlmIChjdHgtPmNlcnQtPnJhd19zYW4pDQo+
ICsJCQlyZXR1cm4gLUVCQURNU0c7DQo+ICsNCj4gKwkJY3R4LT5jZXJ0LT5yYXdfc2FuID0gdjsN
Cj4gKwkJY3R4LT5jZXJ0LT5yYXdfc2FuX3NpemUgPSB2bGVuOw0KPiArCQlyZXR1cm4gMDsNCj4g
Kwl9DQo+ICsNCj4gwqAJaWYgKGN0eC0+bGFzdF9vaWQgPT0gT0lEX2tleVVzYWdlKSB7DQo+IMKg
CQkvKg0KPiDCoAkJICogR2V0IGhvbGQgb2YgdGhlIGtleVVzYWdlIGJpdCBzdHJpbmcNCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUva2V5cy94NTA5LXBhcnNlci5oIGIvaW5jbHVkZS9rZXlzL3g1MDkt
cGFyc2VyLmgNCj4gaW5kZXggMzc0MzZhNWM3NTI2Li44ZTQ1MGJlZmUzYjkgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUva2V5cy94NTA5LXBhcnNlci5oDQo+ICsrKyBiL2luY2x1ZGUva2V5cy94NTA5
LXBhcnNlci5oDQo+IEBAIC0zNiw2ICszNiw4IEBAIHN0cnVjdCB4NTA5X2NlcnRpZmljYXRlIHsN
Cj4gwqAJdW5zaWduZWQJcmF3X3N1YmplY3Rfc2l6ZTsNCj4gwqAJdW5zaWduZWQJcmF3X3NraWRf
c2l6ZTsNCj4gwqAJY29uc3Qgdm9pZAkqcmF3X3NraWQ7CQkvKiBSYXcgc3ViamVjdEtleUlkDQo+
IGluIEFTTi4xICovDQo+ICsJY29uc3Qgdm9pZAkqcmF3X3NhbjsJCS8qIFJhdw0KPiBzdWJqZWN0
QWx0TmFtZSBpbiBBU04uMSAqLw0KPiArCXVuc2lnbmVkCXJhd19zYW5fc2l6ZTsNCj4gwqAJdW5z
aWduZWQJaW5kZXg7DQo+IMKgCWJvb2wJCXNlZW47CQkJLyogSW5maW5pdGUNCj4gcmVjdXJzaW9u
IHByZXZlbnRpb24gKi8NCj4gwqAJYm9vbAkJdmVyaWZpZWQ7DQoNCg==

