Return-Path: <linux-pci+bounces-28316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EC6AC1CE7
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 08:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641251B6522E
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 06:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82118FC86;
	Fri, 23 May 2025 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O9gGmOEc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AS69TbWX"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D36634
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981416; cv=fail; b=RTzE/mPz0859Hr/QAukKirhM2LTIcg+3dqG/EfePfGzuIb7os79tVTFzfIIpHaMufXZWSozEmDT8hTun5GGiTNg9CT8h4os8Lm7YxmQSHuxZ6JrHxXShbVbpx1lCGQ0or5maC/kIMl6Lf/ZbGIdsXXKPOuwkVxAf9mup9Y8W0Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981416; c=relaxed/simple;
	bh=xusR1CVlhuK/dLQHgEohQlXv/bH/EZBTDegwkEdzVdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GTv98u8cCFJY3CSLuvkImALWOgntVhetGiZw+b89sJ7aGnnCvfy32VtzQVYlqcbIIgdBA3aivEs0MqGEIu3dt5T3KTsuHyQ48dFjvYMfy3oI9GCl0ZhhBBpWW6Xkr2OZkigPSqpODQtHbfmxN1cRTs7PT6qVTOzIFLnJd8C3dM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=O9gGmOEc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AS69TbWX; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747981415; x=1779517415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xusR1CVlhuK/dLQHgEohQlXv/bH/EZBTDegwkEdzVdI=;
  b=O9gGmOEcDCx40+dPNFS0dGf2lTl0cHxvFaEfOl8E9htREqE2KZj5umpb
   uwOeJNO1KdDqszEfJjW3OksAWJgWiAvGZUQryOaUbcDn/1KZQPQaRzy3/
   /Nf4sHvAxqmNS2wkvccH/VS72ojEZ5y55Vp1fyUlN0KHpIVXa0bXNMs5f
   WB/QOV5n8BMyBX4qiYVzixBoZ+WohEA1VyoBYpviD0t/ZeL87TifLhaVr
   2LvolvcE+/KJU0eTvvj6Rkv/AqUv/qqZNSNmFvhuZC4WPpVQ3yuo0mVjM
   2j+q/OAoE0Ubmp3GmxOUCzmCRECpU1xuProko9p/I/0STWelI9RAZIYh7
   Q==;
X-CSE-ConnectionGUID: ECbE37/VQP2NsicEAIedUQ==
X-CSE-MsgGUID: O3cAE40lRfC8hyDDL1EvRg==
X-IronPort-AV: E=Sophos;i="6.15,308,1739808000"; 
   d="scan'208";a="82318750"
Received: from mail-co1nam11on2042.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.42])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2025 14:23:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2zooGvFYcDQ3/0BdxCXxvTKS0QORwfE4vMLgraZLGy5/JVwKUVG/THmCi7HBKeI/zj/PXegzt4WXR53I16n6vtoySLBlCAKuz6woS35dNJXM6BkWugLqkG5ZHXMT+jkUTBdIdsJMRki69yCVNQJpTEo6JLsAQxITbrtvOqG40lT6M443s919f3mLC2lzslNdN5xKeuk+jYfCMb6pMZJGT/9Zt/0czVGEiXroXXQDS65sIOfztPDCGkd96JhsvPyecpnKBVlNewzGQ0Q9pU0jjd49kYSRUKpXkIBBeXrXpDpnBZE+epNmbLcTyQ3C2pH2gwfnkGlwe2GTY1HxoLzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xusR1CVlhuK/dLQHgEohQlXv/bH/EZBTDegwkEdzVdI=;
 b=WCcoOWlb2j1+CJYSQxFv1Ca1+DuSVxDKA51UZnCy2Eqq/XO/MnlRnMboN+kkr7dXeTs3367M4QsuYNIXn1sawlOZXGzyqqYM/6/CNDJY7HRUQir5Tz7d/bb3JQFavrocnZG1e/YgdpaB8HvLrdeWWEH447MiPWcF99J0jIZiOtvSttXjVzvcyP6QIbpqgZcy7Dniw5jeOdQCIbenQDOrROayH8jVZP8CQa2mlWhZUKXSfft7CU62UUnFE7pNHrrf2qwCGb0G4dcfOvMF3gr+bcKzX5VLsdZCCcNXGxuo+dxJC8Onrpr1To04OZlPwLRvyqyp+dB2DuvurSu1h9xucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xusR1CVlhuK/dLQHgEohQlXv/bH/EZBTDegwkEdzVdI=;
 b=AS69TbWX+tLT22ikwTX5ZEM0sY0COzjcGjRcF+E4sX/pmNVPq0AjmEeL6l24aCNOhzd8gDCVzQs/IbZWDmnIdZ8YSiAVzwWMPGWdl0Vxqg6nbVqgFeVpyJLtxj9P18AA+mzwbAoW+53sx8Pa3RnPmnmo463YEUP/G5psd2v3jFM=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by LV3PR04MB8966.namprd04.prod.outlook.com (2603:10b6:408:19d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 06:23:31 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 06:23:31 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "lukas@wunner.de" <lukas@wunner.de>, "cassel@kernel.org"
	<cassel@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: reset_slot() callback not respecting MPS config
Thread-Topic: reset_slot() callback not respecting MPS config
Thread-Index: AQHbyzVhisCTrJczKES6+eV+2grOxrPfsfMAgAAOCQA=
Date: Fri, 23 May 2025 06:23:31 +0000
Message-ID: <708d9dec971141ac43ad66d2d305086b652d5893.camel@wdc.com>
References: <aC9OrPAfpzB_A4K2@ryzen> <aDAInK0F0Qh7QTiw@wunner.de>
In-Reply-To: <aDAInK0F0Qh7QTiw@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|LV3PR04MB8966:EE_
x-ms-office365-filtering-correlation-id: eb8955f2-e2ba-429b-b48d-08dd99c256ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1NuanpSMkJldkx1aVJmMVUwRklkMmlTQnU0c2l6eTlSbExEZ1J4K294WXEr?=
 =?utf-8?B?bFJYRmMySjdERzdKemJKWlZNQWJiaDM4YjR6eHZRQmNHeERaSFEra1k1eVVv?=
 =?utf-8?B?N2lZcmNGNVgxWEl4SGt2aUFTSTFLdWdlTTVuaVYvM2V0UGdtMExIUW9ZZnEy?=
 =?utf-8?B?NzdPMDM2Mkd4Y3h1d3Q4RVI1R0NOTmZQR21ZWnMrWWdRTElIdElsd3B6TnhL?=
 =?utf-8?B?NW1wT3dUUXJsdGlhUlBFR1RlYWZRUG1vYnpXbWFSQ1FTSklmZitvaXVZZWti?=
 =?utf-8?B?WDZCMm9BbXc5aDc0VzV2RU1qMjYyejgrUmhZUHh3aDdBLzJWT1FaNkN0eGdh?=
 =?utf-8?B?QXVkRmh0SHJ0SENDU29JbzB6WGdJcytMa29tNXBkNVNKL3M3bmJtSlVadFB6?=
 =?utf-8?B?SnFZVUd0OElQcVdvYTNIeHZTWW9qRndUOXhwbmthU0JubFU1Uno0cVJEQ1l6?=
 =?utf-8?B?UWd1cnpTdW5ReGVYOVdzZzJ2T1dTN1lLU2JYT0JnWnQ3YkZRQWJ3UUxvTUg5?=
 =?utf-8?B?NTRLU1dXWVRGY1k5a2FKcHBKd25CZ1pjRVA1SVpRNENreEhHc1BxV2hvZVli?=
 =?utf-8?B?RkRsb2ZuVUZmWHVJUkZER1ZDT2lMZGpJK1pqNlRiNlBnWHRvcjJGVjFjd1R6?=
 =?utf-8?B?ajhyb3JLOWtPeVoxS1pqOHdkUWo3c2JTdGdQeUNJSEhWVmxJWkpLMWZOR1FK?=
 =?utf-8?B?L252QXN6aGNFRjNtVTlQNjc5bWtKbDdIWWxZWHcreVBNdXloL09JMXJvWitl?=
 =?utf-8?B?Rko0SVA0Y0ZlY0U5S1pnVVREK21KNElmcEM0ck4rQUVqV0RMY0ZtOGlSTEsx?=
 =?utf-8?B?TWRuMThjc1hkZndjejlqUkpGTXR2bWVzVW5BQWVQMW93ekt3RjJMY0krLzk2?=
 =?utf-8?B?bXR2Vi9pV1laelFxNEUyRmlHd3A3Q1k3V09ISDNoNEJhcU03V0MycW5TWFpK?=
 =?utf-8?B?SHpnbmZKZ2h6cElTdUtGc1ptbjc3dngzMC9kOUp6blJuZVpXRVVyK3U3ZG1W?=
 =?utf-8?B?LytGTy82N1p2VGNSOWlFbHdPZDR3MkpreElIZVBadkl4L1BrTjgrbVVhWGxu?=
 =?utf-8?B?SC90YS9DMThMQjFwNUhEVUhVVmhvN2NSZUthc1lKRkc1MzNzbmZCSytyZHVX?=
 =?utf-8?B?TVM2ZlZGa2RFaEkrV0tSWHJYN1BITTRaOHlQelhaMFZ1WWxaS3B3RWZYekxB?=
 =?utf-8?B?R2hqVGhPRUtxUDJ3L0N6V0poTHU1c3lGaUJ1TThqWEdjOXlTS3NrSm9iREhR?=
 =?utf-8?B?clAxSVU0YmpNWEI4bDJzcmYvUUN2UnpsUXk3NmIxakNhZFE1dkQ1bXd2aWNK?=
 =?utf-8?B?TWZ4REpQVUZhVEMrRFlkaFJZTVczVCttdEI4OHduanV3OXVrTUk0ZlZDMnVG?=
 =?utf-8?B?Qk9uUjVZNkltdDZtaXU4UEFOUEw3bWYyZmN1T2RPUitYVWt1QXQvYUd6aWtB?=
 =?utf-8?B?WEJNTXhhU2VqRURNSENwcHNlSUUwNmFUV3hDc2FmWEpCUG54NlErS0M0RG1B?=
 =?utf-8?B?elRBM0JjZjRTS3J4aXZNaGF4dDVzREJvN08xNFBjWXI1d0NxOWNnTVN6S3Q2?=
 =?utf-8?B?L0F6bElTUlJlbTRDQVF5eldCL2g2MkZvTDJxbHZtejdVaUJwODV6eEQ3NXk0?=
 =?utf-8?B?dnBDa0tEQXZSQmZsWnNMMnZzT1RvZm1ncXJBVWpMdTFOKzlnUldRRnlHR3V3?=
 =?utf-8?B?VTU0NWoxNkM5QTA1eGdyeE1IbGZ3OGxoeWI0dGZOVGlkcjhHemJyT29jTGJU?=
 =?utf-8?B?RXFDQXgxeFlyL2RPdEZ4UkNSdXdlVHpObkcwY2lvNU5HUTZXNk1zOGZROWw3?=
 =?utf-8?B?bWUvcGtWd0dVQVdlRndlK2hXZS8vb0thTXdpT1VxbVBWTFNTMExyQUVOTjZT?=
 =?utf-8?B?QkFtWDM2S1V4ZDM4QXFyZnRkYjA0aFNKRDdFQ21rbWJDcVQzaHE1TVNvQWho?=
 =?utf-8?B?UXMyYmQ0T1YvQ2pvSGZTeVRXRTFpZ3ZqR3FCUGV4d0VTWEE4VVFKekh3UVJ0?=
 =?utf-8?B?TjFMa0R0MlRBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGRSeTNMTG9hcFMvd0d6WXFicS9uQVJXWk05ZE9lKzlvTHFpZmpwM1FnRG10?=
 =?utf-8?B?YVhNZ1RmY3NRVXhlczNRUDNjakVvSlhQMEN5MWk1Y1FLR2hkeTNldDNKYlZr?=
 =?utf-8?B?MU1ndWFubE9VWmM2b043TVNKTjU0VTBJSDBOMmtSUitTYkFZOFlDQ1Jia0pO?=
 =?utf-8?B?YVppSVRIRndrQlB1VnhlRmVGcGZ5bmo5TkxXTUtYSzFUVFpaa2ZIZERZcWlV?=
 =?utf-8?B?SjI4eFBJWWFmcXJmajFwT3VRTEpEdjJtSmNQeUU2WUQvQnB5SVoxcEE0U0lv?=
 =?utf-8?B?WHU3Vnl1K1BRR1BoTzBSRzJiUUV4a2xwTVpyTHF6WnViNVkwNEkvakVWQTA0?=
 =?utf-8?B?YURwK0lnU1VoMW4vREZJUGd2SDRjeGQ4RDBWNHJqQU01aVc5eCtSbk02MzMx?=
 =?utf-8?B?cmNTQytpS2dqSUVHSTNyaFc4eHZMMEhTNSsvdzhwYzdBaDhkaURXYVQrRUhu?=
 =?utf-8?B?d3lXNkdLSVJsKyt6VUF2K3ZPeTFWTG5ub1BVTUlpUE5INklrSXBRRFpzbmZJ?=
 =?utf-8?B?MTNLUTFxaXhveFRyK0luMW5JRmVwS25oNlJDemdvY2J6SElXL1J0RFFoY2Uz?=
 =?utf-8?B?dFpkWjh3UEl0T2ozdDc0MG1MeVQ0RUdPaTYzUnNlQ3RVTVhQRzFYV2F0dnc5?=
 =?utf-8?B?bVRlOE5YeXZBVzZUMWM2bzUzeU9tRU1kUE9MemVaVVBWQURvSDd5eUpXZCtJ?=
 =?utf-8?B?NFA4QURSdGJIbUxnbFhkNW5XT0ppQUppMkVSWlBBVURuaDBJTUhhZ2p0RWxs?=
 =?utf-8?B?SUJFbWNZN21JRjRQeHRlVjFvakdHUjczd3pleWhrWmttV2w3K2VGbllHTHpW?=
 =?utf-8?B?NXFGWmlBNVdvWDVKRWR3bTRsZGErV1YyWjIra1MzbWxINkJ6T2xTVmFlVVRC?=
 =?utf-8?B?cDRldEtCL1IrMU1RVkllZCtnOUhwNHR6clk1LzBoMk5QMTNlSUVMM2ZqSzhK?=
 =?utf-8?B?b3M4L3VYV09sd2c5WXNrWnY5eFRQQi9DWXphRjcrQllQUnFsVVpmZ1BlWUFT?=
 =?utf-8?B?eldTbkswQ0dHWnVVNmk4aUFIL05ra2Y3MXQ1SU11dC9IOVpHL2pmWU5Eekww?=
 =?utf-8?B?OHhJajRFb0VENldTZXZ0MkdsS0FpQVczNGJiUWxuZ2tHdkIrQTcweExmYzQw?=
 =?utf-8?B?RDIwZHVaVjQwZk5WYzNhUmdoa2R0ZGxUUThxdktzb3pIenZ4T0pVSEJqWGpr?=
 =?utf-8?B?SUpVckpGNTk5NkUyM255WEVjelh4SU56dFk3b1EzWFVuRHZzdVd6WTBxQldD?=
 =?utf-8?B?cnNPQmxmcDFFalNicVhiSU8xNFJqdE15QXEwVGJYa0RrY1FRMk1aTjcyekRu?=
 =?utf-8?B?YkJOMnJGVnBGZy8vOHcrQkZySm51WGVFcmxTTFYwS01rWWpzUUt6Nk5KRUtK?=
 =?utf-8?B?dVIvSFY3RHFGY3NqZ0pFeHRCS3FXUUltbGMvekF4VURZOHhVQXJsSTZBTWRO?=
 =?utf-8?B?V1BlenJhOW1zdzdpRkJPcENqKythWHA0NkMxTUZZYmNzVnFRd1VFbExMY1hH?=
 =?utf-8?B?RUxKRzFUQ3doWDlERjcydlIrNEc4Q3h3T3FrSTNHc3Bkbk1qbk81NnNaVDMy?=
 =?utf-8?B?aHVIREI0Snp2VVZBTExwcVZKbzlQVjhieXQyUVpTb1Noc3VKUnVjZXo1cGN3?=
 =?utf-8?B?eEJXODFsTkJJZkVpdDA0WFlWUlg0aTdhRWdReVlnOWNxa3h4VG0zalgwTWZl?=
 =?utf-8?B?S0RIdE84Zmg0b1dXZWVXQzVIdXQzV2ZyY0JMbkg2dDV2WWpYalo1STZBTmlX?=
 =?utf-8?B?Z2F5b0hUWHpUSC85WXAxUFovR2hPNVFnVXY3MFJ3Y0tFOC9JQTVOS1orRUJx?=
 =?utf-8?B?cUhWdzBKUzZMUG5UQTdqeHdlVG5FZjBveFl2VW1JU2hscTQ4TU8xajFMeVEv?=
 =?utf-8?B?UC93c1FCZnNwZmNBVGxRZFRCTHFvZXFtZU9VWXEvN3JEZWxXeWt1R3NLejF0?=
 =?utf-8?B?ZWJNdkNkWWFnVEZaRFpDZUxmZWdiL3NCMDU2TVI3U3FMdnpsSDAzenBmdGN2?=
 =?utf-8?B?V242akdDZGJ4UlNmZmovekd4U2M5Zmw4VWNWVUFTMjZuZDkza1JnQnNrZEow?=
 =?utf-8?B?QVJqYm1IbFI4RGM2dmFtN0hxVExBLzBXRmdlQkw4VlFOVWJZcnp3cDFTWWor?=
 =?utf-8?B?LzVIZUswQ0hEM2N6bU1qT01sT0F0VjFNQVV0K3loZU0yVE1LOVFSdGx6dldZ?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0DA16DD9CC60B43B334BB81995DB4BF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+TqeSdDhIkW4uXt2lqJAyi3uamHHV4rAQKAIHQUNJQs8CtixPzlLMFTLKaIv4RVNcG7lDO/wJBpJm9GAMliedjeSsQgNEPyIt2aKftge+rcYCtfvg/a30a/jXbtbT2mEY83vIsZzjmj+LJipnifc1mTAi1+C2gojQSfYtzjxU/PV3kfe3h+HR1MNX/vUy7qXCEULe/ki56O3eorcampl5bFXk5fIa1X+PaGJrSUoZKR3ejKfmWMiZ4OBwAFhXjxrIZV8Cx2Qm5vSfpfYDnm4A+GQnHN+g83+Tlwm2Evjg8NSW2KpzDLD69PGT4uNL+NAIA1t03kC8lUXH8fIScJD2mCU479sDOYLcjmhct8GtO6CFIryQo3eTpQeLfaBE+MBCFAFNMq9M5cUSZ8B6qrBMUSruMr1/P4fA+E59OB5z1TBQKCnK05OZoRD032p1wro5NLG4Agk6x0WAyfHalZUD0JdyYd3YA7ufsCDlpOZ7uFEaGE7TOn6/nCZUbYYcMgVVyeBR5AKff4ZRJLM2jT1gmIzIvZuWrFU6EXkwjELE2UsQfLDud9QogpAoLhR+GGLVF95VvamPba5VW+yqjOD9Q9L5kwgFOqlBaUNR2Hpzi53NOuR8hrdrNL4r2Etzufg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8955f2-e2ba-429b-b48d-08dd99c256ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 06:23:31.3221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dUOYMgfmNhtX9a976WgyxjCSydLS6hZu0Zg3IfXcMFFEJAqom+7thVotqhLCsgKZXYu2C1DMmZEtlAcFCTF1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB8966

T24gRnJpLCAyMDI1LTA1LTIzIGF0IDA3OjMzICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IE9uIFRodSwgTWF5IDIyLCAyMDI1IGF0IDA2OjE5OjU2UE0gKzAyMDAsIE5pa2xhcyBDYXNzZWwg
d3JvdGU6DQo+ID4gQXMgeW91IGtub3cgdGhlIHJlc2V0X3Nsb3QoKSBjYWxsYmFjayBwYXRjaGVz
IHdlcmUgbWVyZ2VkIHJlY2VudGx5Lg0KPiA+IA0KPiA+IFdpbGZyZWQgYW5kIEkgKG1vc3RseSBX
aWxmcmVkKSwgaGF2ZSBiZWVuIGRlYnVnZ2luZyBETUEgaXNzdWVzDQo+ID4gYWZ0ZXIgdGhlDQo+
ID4gcmVzZXRfc2xvdCgpIGNhbGxiYWNrIGhhcyBiZWVuIGludm9rZWQuIFRoZSBpc3N1ZSBpcyBy
ZXByb2R1Y2VkDQo+ID4gd2hlbiBNUFMNCj4gPiBjb25maWd1cmF0aW9uIGlzIHNldCB0byBwZXJm
b3JtYW5jZSwgYnV0IG1pZ2h0IGJlIGFwcGxpY2FibGUgZm9yDQo+ID4gb3RoZXINCj4gPiBNUFMg
Y29uZmlndXJhdGlvbnMgYXMgd2VsbC4gVGhlIHByb2JsZW0gYXBwZWFycyB0byBiZSB0aGF0DQo+
ID4gcmVzZXRfc2xvdCgpDQo+ID4gZmVhdHVyZSBkb2VzIG5vdCByZXNwZWN0L3Jlc3RvcmUgdGhl
IE1QUyBjb25maWd1cmF0aW9uLg0KPiANCj4gVGhlIERldmljZSBDb250cm9sIHJlZ2lzdGVyIChh
bmQgdGh1cyB0aGUgTVBTIHNldHRpbmcpIGlzIHNhdmVkIHZpYToNCj4gDQo+IMKgIHBjaV9zYXZl
X3N0YXRlKCkNCj4gwqDCoMKgIHBjaV9zYXZlX3BjaWVfc3RhdGUoKQ0KPiANCj4gU28gZWl0aGVy
IHlvdSdyZSBtaXNzaW5nIGEgY2FsbCB0byBwY2lfcmVzdG9yZV9zdGF0ZSgpIGFmdGVyIHJlc2V0
LA0KPiBvciB5b3UncmUgbWlzc2luZyBhIGNhbGwgdG8gcGNpX3NhdmVfc3RhdGUoKSBhZnRlciBj
aGFuZ2luZyBNUFMsDQo+IG9yIE1QUyBpcyBzb21laG93IG92ZXJ3cml0dGVuIGFmdGVyIHBjaV9y
ZXN0b3JlX3N0YXRlKCkuDQo+IFdoaWNoIG9uZSBpcyBpdD8NCj4gDQpIZXkgTHVrYXMsDQoNCkp1
c3Qgd2FudGVkIHRvIGFkZCB0byB0aGlzOiBJIGRvIGJlbGlldmUgdGhpcyBpcyB0aGUgY2FzZSwg
aW4gdGhhdCB3ZQ0KYXJlIG1pc3NpbmcgYSBjYWxsIHRvIHBjaV9zYXZlL3Jlc3RvcmVfc3RhdGUo
KS4gTXkgaW5pdGlhbCAiZml4IiBmb3INCnRoaXMgcHJvYmxlbSB3YXMgdG8gZG8gInBjaV9zYXZl
X3N0YXRlKCkiIGFuZCAicGNpX3Jlc3RvcmVfc3RhdGUoKSIgaW4NCnJlc2V0X3Nsb3QoKS4gV2hp
Y2ggZG9lcyB3b3JrLCBhcyB5b3UgbWVudGlvbmVkIGl0IHNhdmVzIGFuZCByZXN0b3Jlcw0KdGhl
IERldmljZSBDb250cm9sIHJlZ2lzdGVyICh0aHVzIE1QUykgYW1vbmdzdCBvdGhlcnMuLi5ob3dl
dmVyLCBJIGhhdmUNCmFsc28gdHJpZWQgdGhlIGZpeCB0aGF0IE5pa2xhcyBzdWdnZXN0ZWQgYXMg
d2VsbC4NCg0KQ2hlZXJzLA0KV2lsZnJlZA0KPiBUaGFua3MsDQo+IA0KPiBMdWthcw0K

