Return-Path: <linux-pci+bounces-36732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F8B94280
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 05:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42CC440947
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 03:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB820E005;
	Tue, 23 Sep 2025 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="acLGzm4i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16B20C47C
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599554; cv=fail; b=T9An1U8IS/siTMjJ1JPv7tGx4eWUQ4BnFM1Emh/kK3MiAhegoB+6lEwlJH0tdFvN/WOazLpRIcrfRj5wSlgXiVd7EB954sCijKg82aRcO5kVxNjGk20BtuRxMvXCfI4XmxhEfAsqb7lDASwtp8JrUEV0iAMmD2OGORWKvhn1u+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599554; c=relaxed/simple;
	bh=lT/hSAj+zgifJmbnoDuOterGP15gConS2/4hQpCua54=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HSLBwyV3AZ23T8kI/IT68DzlPBgfvTWP8ZtRiczUKyAjZpWtg38BSf/aKfUD5FjCPZMw3l1vq5uD67+E2W7LPpb5D7ixwNkXvaaAX8mVXZzWDkFYTys5wNWxNWyp4VEzDOIFVCgyp4zKNDn6Xcxpl6ab28c6CT+mrHwDuNgEeMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=acLGzm4i; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58N30PML1433055;
	Tue, 23 Sep 2025 03:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=lT/hSAj+z
	gifJmbnoDuOterGP15gConS2/4hQpCua54=; b=acLGzm4iPq+pw49bhMhdyz+9V
	PCRDf4rwAI3lNoLPHwljHF/b2Z03fjCJ65OsAss5dBTS3qAvChAT3gSSSNn8ZJCf
	FaFUOjrs7Kx+t2ooRFvPs9ROn+Wy4wsqwfk8B56Psc2Sgw7LYwfdj/4GRemeHTjr
	869142BRqElm9OZ40j6siATqkGzQQezvYdNXRhLQqRQ54IKGdrTmG8/PjXoLGdmg
	fNwJwO/7VVo/jANadXge7ieqU2i89Cuuv31lyY+XMSClxNEjrnVPEXgmKdyXRaSa
	UGfuzBwuWwjByEYyIDQK8Pyiy7G66MOKyS3VyclaKp29JUYaWVm5ncqFEtDRg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499k89aku1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 03:35:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL1Ubk/AqPys6boHDLhJ4N7I7Vw/oK4tWtZk3vAN7VejCIHlTCBlqw4+i1dbUaTXQG513ho1XnoAEAfGAW++l9giqYu76GASiQCBZK5Bs55RYjxMsvTwJNxIcNUrP+Rdlr5YOIB/rng8zF5QUAi3AJruRcn6eX2fmhmUmTKEgHBGrLGVXzZLqlyiKqmD/0k/ZE7kjlNevAlHCyhYs3QCCZsEiHhp64apl9ixu6D70Hj1UiH2fpQ+Gw9+qZM/F3sJPZBxzrH8yWfq8CTbWYcm/a6jlqFdFIcPNn2A9Z5HG//d1/rA27JbbphmBPfMX8tf5dIGp0uvW2Q7LC2lBsgsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT/hSAj+zgifJmbnoDuOterGP15gConS2/4hQpCua54=;
 b=BvwdcSgK9Ht6RHFtxRm557NLzk2l7Sbi1PYwrCT7HqZI8V36CysskOIdQpu5HEWYfEtI3bHMHkG+IDcXpiV+kWE0BuPAXLXDMJjVfTN7PDUzUUc4yYtPVCpp6jPptKA4JBholMb0C37VUzEzwM+StXEjAeeHkruePaGz+3B5IhNGR5C+LmPY9oRn7b1KmBIBqqHt4utPgRpQ5KGeGbIWPhid8YH1hHkWLRLSIni9d+pGjMbh7Jv0U2RJcr+dczlT2HOQ3aXpk5fyWKhc1wlEvE4P0RaJDayJwNgOjcpprYlKDlGUyu2Igv7K5UsHBRjzNXkQG7j3DUXeUSGhSxCJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by DS4PPFA2144AAC3.namprd11.prod.outlook.com (2603:10b6:f:fc02::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 23 Sep
 2025 03:35:57 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%6]) with mapi id 15.20.9137.017; Tue, 23 Sep 2025
 03:35:56 +0000
From: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel
	<p.zabel@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com"
	<linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "Wang, Xiaolei"
	<Xiaolei.Wang@windriver.com>
Subject: [i.MX8 PCIe] PCIe link fails after kexec
Thread-Topic: [i.MX8 PCIe] PCIe link fails after kexec
Thread-Index: AQHcLDoWCHKSsTl8kU6/ZHTMf2OTpg==
Date: Tue, 23 Sep 2025 03:35:56 +0000
Message-ID:
 <CO6PR11MB558624C238AA9C39C9C6A936CD1DA@CO6PR11MB5586.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-09-23T03:36:05.830Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5586:EE_|DS4PPFA2144AAC3:EE_
x-ms-office365-filtering-correlation-id: b0e9b465-ef08-49da-609d-08ddfa524e7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?MEFmekFDZzZSM1RvYmFpeXRRZld1YXZibFZMK0hZYzJhOWFBTDFIMW5vNUxT?=
 =?gb2312?B?dkNFZzJkZVNPRDJpU29BbVRQbXJwWTF0bVhreVFGUGg4L0kvc1BzbjdCS09O?=
 =?gb2312?B?MmFFakg0MmFraUo1RTNRNWtJdTlORnZjTktTdFgzSDlaWmhPbUlWcnpVajZw?=
 =?gb2312?B?SVJaWVhJajlENTlMODVoWWdEeEhFZEg1eUQ1aXVCOXlnL0JRSUd5QlRNY29E?=
 =?gb2312?B?aUV6MkFVQU0yYkRZUlhoSUxWekw5S2puNGJVS3hxOGhLQWVKNTdhYm1IMytl?=
 =?gb2312?B?WUJnNmVaWmVBWUdBYmRGdzVxSW5IMHZ6Mk5yUnNzNVNrZ1VBcVZDYU1NUXFs?=
 =?gb2312?B?WjZvY21TREtvb0luMkpkM0dmY0kzeGhHdkhPSXFHTlcyQjZ5U1Z6aDROWjFj?=
 =?gb2312?B?ZldzZy9rWDBhQXE4clEyK2Q1c1daTVhCNitZNzhhQTFOby9XbVIybW14cnZl?=
 =?gb2312?B?Z1VXOGdMdHZaSHFIdGhTMStBOUczNlU3RWVSNUkyQUswNXkrV2pQalRUMnlh?=
 =?gb2312?B?MzlvU255OCt6cXAwSktiejFocENFbFRHZWtIeXFuRmlHUGNjNXR6cG9WT05Z?=
 =?gb2312?B?dVViSDRzdDBNWUhtWVphRkIwTlpNYnFsSy9nVk1pbDR2RU9nVkNvbHJSSFJl?=
 =?gb2312?B?Tm9OU0p1WTkzLzJtSUt4S2tEeUhlbWNPbkFTVTlYMyswVnoxd0c1SzFxUjg1?=
 =?gb2312?B?UU5HbmQ5RmwrWk0yMG5wK21vTm9jdTBDa0hld0FFMmc4TlQ3cklGNHhkOGEz?=
 =?gb2312?B?VXYrVXJWbXVPTnVZdXI4RGdvWWd6OWZNTTR5KzRGT3NHdXl2UDF3RTlhamp6?=
 =?gb2312?B?TkQ1Z2FpSFNkb1hjSm4xYVhicnZhclJ2SDFSSXJYb0IwKzI3K0hhUGJTWE9p?=
 =?gb2312?B?cUVDM1pETjZ5TzUwOTNlZWdDcGlTMklFdlVJVk45TEhCSEpEdit5R2RodEk1?=
 =?gb2312?B?dHl3TEw4eTRPMEFNMWZvVE9OSEh3a3FzR0cvZ1dzcWF6d1RXd0QyaCtGTUVM?=
 =?gb2312?B?blEzQndTQmVwcFA0cGo1L3d4WitJSXhtS1pZYzhtSlJjQTFjaGxESUh2UGN1?=
 =?gb2312?B?bHh6OGFwSnZvdll1akJBUW1RTzNjd1RpZlp1VXhVQkgxVmtIYWFVNFdCQXA5?=
 =?gb2312?B?bmlvc2xoYTJaY1hLU1Z5MXg3aENzekdlajFzS0I0UUpBc1hpMlZRQ3VRUXBj?=
 =?gb2312?B?R1JwdXVoTEhkY2ZQQmZnZkx1Z2ZtbDIrV0VZZ0JwWWtMT2hqZFdsV0ZIYlJk?=
 =?gb2312?B?NUsrT0N4eGZSYjlqVGhoclZlMFVpZ09CQkZpMDNjUUk2bUtlL1dDU3luNmNG?=
 =?gb2312?B?aGlhbk5aTkZPRTFxZkZMQnFDSzlqd1U2d0RDa1JTWEhyY0JIQUNkZzE4aEpl?=
 =?gb2312?B?Sjh0Ui9GanN5ZGp2UUxhakduVldvS3hWNm5TekkyZXNRQ2VJOFpUOE9YcmVQ?=
 =?gb2312?B?MWluQUNGU240aEsrOUx3dnpTQU1mcy9neGpQZGcwT09qQk5Ycnh0eWRsSVJB?=
 =?gb2312?B?SFEyMDhxYzRuUXF6cXZiZ0t4NkExNlFQQjgxZS9MVEpBdVhVSXVFTitTeFh1?=
 =?gb2312?B?WmoyeWtOK0d0SlNNc0x2VGgzVkZQdktDOFJRSGZ2c2tDYURrTmwzK1pvTDk1?=
 =?gb2312?B?cVNMTHEzT2dpRWk4WXRRcWlYbE9NRXNta1hnT3RzQzFpZWd3NGJjU2IxQ2ha?=
 =?gb2312?B?MUU3UEczUm5ISnpKQ09tV2IzTzhoRTN0dytCSWV6WUtLajV4dkJHMzRZUTJF?=
 =?gb2312?B?dGhqQUZmdWZ4NWREVHFOemZNci9ra1B2dFFZRmcvZy9EVVhmYnVuYmJtbjdk?=
 =?gb2312?B?c2NzV1NKRkk2WWFBTTJNMTNPM0xseTBhUkxVUkZXb0xtNnpWeXpNNFJOL3Nn?=
 =?gb2312?B?N1hvSkp5L1UvZEJPN3d2dzlKWnl3YlpFY2FLWCsxZ1RzT0FjdGZYLzduWXJH?=
 =?gb2312?B?OEFQbWhhejVlR3ZYZUZ1dittdEN5UUxyT2JTc1dvd0NPYkxDSFZmZ0pvbTc3?=
 =?gb2312?B?SDNZUTJ2WVFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SlZmV2o3cTVpRyt6WE1OMTR3TVBWcUxFbWorMFZPUWxZc0svc3BvekNpbG1R?=
 =?gb2312?B?c1hvUVplM0g0YWJ4ZC9rQzJ6aDIxYUsxS3Z6dmJWd1ZCMFptYnQrQVRiWEJh?=
 =?gb2312?B?TFEySytiUm5VZmlZWTNJai92SkN3OVFycG9aUUpiWGVrYk82Q2hITjNrVnpW?=
 =?gb2312?B?Nzlxc2JFbktJY2x3TitKbmZtbDBLN25PY1ZHMXo1Q2wxZUtGTXlyY1dseHls?=
 =?gb2312?B?aDF2Q08zK1NEMkxtRm50RkcyM3FzWitIKzZSOERUSHlEWFNZaDk0citiaE5C?=
 =?gb2312?B?TWxWRDZvQUoyVDgyeUdzUGhpTHNCYlFUbDRaV2tUNlZ3b3hoN3JtUHJ3ekcx?=
 =?gb2312?B?WEU3NUk3dVo0clZBZjZmKzBLL3BBV1doMXJIcUwxK3l6YUlaVXRWQWNOWFhi?=
 =?gb2312?B?bVp3a1NRZXEzOTJHTUZSQXdNR1ExWEQ0WndIRTY4dEN2SDFUOWx0WnJ3dG80?=
 =?gb2312?B?RHlXcENlRnc0MEg1Ly9KbmU1Vmw3U0t0eTk3bG1XQms3WFpLS3J4MVNGN2Ny?=
 =?gb2312?B?TzN2K0diZ3dOcTgzNkJ0TXRUWU5Db0g3ZUdFbFNaSkRyOFAvMUJlRUhsc2Js?=
 =?gb2312?B?bEJSMGhrb3FWZjBNN0E3NmFVWi9Wak04SlNRY0ZnWHNKeW4ybGQrMFY3c0tl?=
 =?gb2312?B?U241czA0NUxtOEcrMzZ5QThFKzNpVExrQzVtYklpZmdTcEhFMDRpZDQ0U1No?=
 =?gb2312?B?d1J6N0pWMDRtNWEranFJV2xnV0F2dWNzUkZOaGNQc1U0YTg4ME9rNUIvTlBJ?=
 =?gb2312?B?L0JmTzBFZnJYT3lGYmFiaGhYcGxkTHhLNGJYWmNsYldqVU5LakRmMlp3cmVv?=
 =?gb2312?B?ZFRPWUNOTFphQy9DcFZYaVE2SXZDdU5VM2VWSkQzMW1MUCt1R2ZMV0VpdUZp?=
 =?gb2312?B?dHdYUjF2Vmh2czhaUjNzR1E0UnpKcTE0QU5NR3FGWTBRcXN1ZE8rVkQ1N0Va?=
 =?gb2312?B?RTgxQnhoVmljY2hqWkNRSS9TVUgrSG10SmIyajV0emVjSGFLd3YxOXFOb1Y0?=
 =?gb2312?B?cVhmV3YxRy9nNUlYd2lucXlPSzUzTTE0MDNLTmFwbjdCMnZtS0dBNnJBMWtS?=
 =?gb2312?B?Sjg0c3pLMDkvazlidnNQTDV1SlR4bTVtSGpUeFFQaWwzMEpHMEUrbzV6VHVC?=
 =?gb2312?B?UDFjaGhWam9yME5BSWpVekRmWXpZL3NmS21GbS81OFpNRTZ3aHQvRVFDYUFO?=
 =?gb2312?B?THVQcnhIOGVwQ0xzdTBZaFU3RW05R3lvQUtXRll2MXZxUTBTY3RwV1pJenJS?=
 =?gb2312?B?cDRpVXc2enlpL0ptRTd6SG1HSzVmSUhjZlBycXBZNlBCTGt1OFp4QS8rYUtE?=
 =?gb2312?B?d2tDc2c0R2laaDFZN1k3NWw5WjZxbmFwMlpXTGhyUUdiNVg3cDZKa2ViZFZm?=
 =?gb2312?B?eEdYNEUyNzJtY0JLMmxhczc1M3l0OVJpYW9RR3pSNVRWck41QjRtdjNCd2JK?=
 =?gb2312?B?UDRCVkZxSHk3d21pWHpyVUlzVmx3V0U2MmFlTlNLLzhIdngxR2I0WDVBeUhq?=
 =?gb2312?B?cnJSVWxITEFPcHBENXNNNzI1eGQ2bmNFMVNBL25OWVdiQ3llT0J4a3VUNkkv?=
 =?gb2312?B?bnh1UVhLSERTajBkTjRDUVQ1K1EzMnQwSTVKckRmZDdUUTVseVZxZzh4bkJ2?=
 =?gb2312?B?bEIxOTZTM2RybmxEblFQWWZ6ZDVFVFlwL3FGSlA2UWt4WDJKamNMN3lXS1ZQ?=
 =?gb2312?B?azJ0V2t5YUVhU0NqcDV1a2d6NTRMaXd1L3lBcU00elQxTjBhODRHRDNhcTZv?=
 =?gb2312?B?b3Ayb1pGZHVKQ3VwZTF6WnV0Sy9sZVh1VXNCQ0M4VU9PQVhaa2pYeGFCRVJN?=
 =?gb2312?B?WDZsdkhDODBQeG1WeThCMTBNTVdiRlVrYlp3Z0RTZWYwcVhGSlprV0F4blFR?=
 =?gb2312?B?dkhMVEd0MTFmOVptMDBYb0E0U21Eazd3RThHSHVMdGtadTZrKzRIeWhzZEpz?=
 =?gb2312?B?cWR3RFpVaUlpOGR2L01JTkNucXMxTTJQS0tVbjdQb2NQVXVyMTdaMURRWHpj?=
 =?gb2312?B?R0JXRHRyUTBLM0dJd0pSZWV5OHc3MEZEUlUrem1MZjRHVWF0Y01iOEs4OFFn?=
 =?gb2312?B?QmxZU0pQdWJCMXRsNE4xZGJaY0xvdFBsZkNsZStMMWY5RWdXZlhvZEVFN1I5?=
 =?gb2312?B?ZytaVWR0WGlrdlVnM2o2d1J2OE5KSWFjZ1RQeVM1SERCOWE3c2IvN2RFZUEv?=
 =?gb2312?B?VUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e9b465-ef08-49da-609d-08ddfa524e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 03:35:56.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edT1oFoZBtWKBsFw32uq/S8/iRhGMrkulFP/QRRbwUuQvsFauoVBbPhUSXwxR6ukVdcIq4/pMBTM1c2WhtMRAxxiS4WJk/PsO9dgTs8F0F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA2144AAC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAzMSBTYWx0ZWRfX0mqWocVzlkdS
 bhzNhifxtWRaXnYWP5T6oYNi3MccnvgpGA5SPQemjfmMf6p4+n6U76/VCge9hOYJ0RsAeDZVwCq
 Av9KO9V1iI9QL16iSzbU+WYum5DRCYzddHu103rEna3GrrA1swZxdsV5nlf7uNN1RLMSXPL/3cs
 EbA66WnnKRIOtTyZ9w/8zyBnUrPzwU7+Z2p171nd8/EThxzl93Cm2xI3LoMV4Ba9Klk0WttG9yk
 76RtQXsdhWrGp+5t4UQNajmn6xv04obkQ8xyQsoseckp9kLjDa+Zt7STGy9LEp2oIR6vS0xKxnx
 fhCKPiBfrZaDVHkBuJRAdWrpDACCqbg9QCLbU9oNowYmwUW3O5OXb28+U0OSc4=
X-Authority-Analysis: v=2.4 cv=YZS95xRf c=1 sm=1 tr=0 ts=68d2159f cx=c_pps
 a=WfYMUjdTTdEkkNza/pHfSQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=_l4uJm6h9gAA:10
 a=yJojWOMRYYMA:10 a=5EqqrzS2ax7udmLLzWYA:9 a=mFyHDrcPJccA:10
X-Proofpoint-GUID: EyM7TDXv8gYntcLYGvzHWp9jERRXpn6W
X-Proofpoint-ORIG-GUID: EyM7TDXv8gYntcLYGvzHWp9jERRXpn6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

SGkgYWxsLAoKV2UgYXJlIHNlZWluZyBhIFBDSWUgaXNzdWUgb24gaS5NWDgtYmFzZWQgYm9hcmQg
d2hlbiB1c2luZyBrZXhlYyBvbiBMaW51eCBrZXJuZWwgNi42LCAgCndlIHdvdWxkIGFwcHJlY2lh
dGUgeW91ciBoZWxwIHRvIGNsYXJpZnkgd2hldGhlciB0aGlzIGlzIGEga25vd24gcHJvYmxlbSBv
ciBpZiB0aGVyZSBpcyBhIHJlY29tbWVuZGVkIGZpeC4KCiMjIEJvYXJkICYgU2V0dXAKTGludXgg
dmVyc2lvbiA2LjYuMTAzLXlvY3RvLXN0YW5kYXJkIChvZS11c2VyQG9lLWhvc3QpIChhYXJjaDY0
LXdycy1saW51eC1nY2MgKEdDQykgMTMuNC4wLCBHTlUgbGQgKEdOVSBCaW51dGlscykgMgouNDIu
MC4yMDI0MDcyMykgIzEgU01QIFBSRUVNUFQgV2VkIFNlcCAgMyAyMDoxMzozNSBVVEMgMjAyNQoK
TWFjaGluZSBtb2RlbDogRnJlZXNjYWxlIGkuTVg4UU0gTUVLClBDSWUgZGV2aWNlOiBJbnRlbCBD
b3Jwb3JhdGlvbiBXaXJlbGVzcyA3MjYwCgoKIyNCb290IGZsb3c6CiNzdGVwIDE6IEluaXRpYWwg
Ym9vdDogTGludXgga2VybmVsIGJvb3QgZnJvbSB0ZnRwIC4Kc2V0ZW52IGlwYWRkciAxMjguMjI0
LjE2NS4xMjAKc2V0ZW52IGdhdGV3YXlpcCAxMjguMjI0LjE2NS4xCnNldGVudiBuZXRtYXNrIDI1
NS4yNTUuMjU1LjAKc2V0ZW52IHNlcnZlcmlwIDEyOC4yMjQuMTY1LjIwCgp0ZnRwIDB4OGEwMDAw
MDAwIHZsbS1ib2FyZHMvMjkxMDYva2VybmVsCnRmdHAgMHg4ZDAwMDAwMDAgdmxtLWJvYXJkcy8y
OTEwNi9kdGIKYm9vdGkgMHg4YTAwMDAwMDAgLSAweDhkMDAwMDAwMAoKCiNzdGVwIDI6IFN3aXRj
aCB0byBhbm90aGVyIGtlcm5lbCBvbiBkaXNrIHVzaW5nIGtleGVjClJlcHJvZHVjdGlvbiBzdGVw
cwpyb290QG54cC1pbXg4On4jIG1rZGlyIC9tbnQvc2Rpc2sKcm9vdEBueHAtaW14ODp+IyBtb3Vu
dCAvZGV2L21tY2JsazBwMSAvbW50L3NkaXNrLwpyb290QG54cC1pbXg4On4jIHNjcCBnaGUtY25A
MTI4LjIyNC4xNTMuMTUxOi9mb2xrL2doZS1jbi9pbWFnZXMvSW1hZ2UgL21udC9zZGlzay9rZXJu
ZWwgICAgIC8vdGhlIGltYWdlcyBpcyB0aGUgc2FtZS4KCnJvb3RAbnhwLWlteDg6fiMga2V4ZWMg
LWwgL21udC9zZGlzay9rZXJuZWwgLS1hcHBlbmQ9ImNvbnNvbGU9dHR5TFAwLDExNTIwMCB2aWRl
bz1IRE1JLUEtMToxOTIweDEwODAtMzJANjAgcncgcm9vdD0KL2Rldi9uZnMgbmZzcm9vdD0xMjgu
MjI0LjE2NS4yMDovZXhwb3J0L3B4ZWJvb3QvdmxtLWJvYXJkcy8yOTEwNS9yb290ZnMsdGNwLHYz
IGlwPTEyOC4yMjQuMTY1LjEyMDoxMjguMjI0LjE2NS4yMDoxMgo4LjIyNC4xNjUuMToyNTUuMjU1
LjI1NS4wOjpldGgwOm9mZiBzZWxpbnV4PTAgZW5mb3JjaW5nPTAiCgpyb290QG54cC1pbXg4On4j
IGtleGVjIC1lCgoKI0FmdGVyIHRoZSBzZWNvbmQga2VybmVsIGJvb3RzLCB0aGUgUENJZSBsaW5r
IGRvZXMgbm90IGNvbWUgdXAuCiNLZXkgbG9nIGRpZmZlcmVuY2VzCgojIyMjIyAgYm9vdCAoYm9v
dF9jb2xkLmxvZyk6CmlteDZxLXBjaWUgNWYwMTAwMDAucGNpZTogaG9zdCBicmlkZ2UgL2J1c0A1
ZjAwMDAwMC9wY2llQDVmMDEwMDAwIHJhbmdlczoKaW14LWRybSBkaXNwbGF5LXN1YnN5c3RlbTog
Ym91bmQgaW14LWRybS1kcHUtYmxpdGVuZy4yIChvcHMgZHB1X2JsaXRlbmdfb3BzKQppbXg2cS1w
Y2llIDVmMDAwMDAwLnBjaWU6IGhvc3QgYnJpZGdlIC9idXNANWYwMDAwMDAvcGNpZUA1ZjAwMDAw
MCByYW5nZXM6CmlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogICAgICAgSU8gMHgwMDZmZjgwMDAw
Li4weDAwNmZmOGZmZmYgLT4gMHgwMDAwMDAwMDAwCmlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTog
ICAgICBNRU0gMHgwMDYwMDAwMDAwLi4weDAwNmZlZmZmZmYgLT4gMHgwMDYwMDAwMDAwCmlteDZx
LXBjaWUgNWYwMDAwMDAucGNpZTogaUFUVTogdW5yb2xsIEYsIDYgb2IsIDYgaWIsIGFsaWduIDRL
LCBsaW1pdCA0RwppbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6IGVETUE6IHVucm9sbCBGLCAxIHdy
LCAxIHJkCmlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUENJZSBHZW4uMSB4MSBsaW5rIHVwCmlt
eDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUENJZSBHZW4uMSB4MSBsaW5rIHVwCmlteDZxLXBjaWUg
NWYwMDAwMDAucGNpZTogTGluayB1cCwgR2VuMQppbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6IFBD
SWUgR2VuLjEgeDEgbGluayB1cAppbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6IFBDSSBob3N0IGJy
aWRnZSB0byBidXMgMDAwMDowMAoKI6H6IExpbmsgdXAgc3VjY2Vzc2Z1bGx5Cgpyb290QG54cC1p
bXg4On4jIGxzcGNpCjAwOjAwLjAgUENJIGJyaWRnZTogRnJlZXNjYWxlIFNlbWljb25kdWN0b3Ig
SW5jIERldmljZSAwMDAwIChyZXYgMDEpCjAxOjAwLjAgTmV0d29yayBjb250cm9sbGVyOiBJbnRl
bCBDb3Jwb3JhdGlvbiBXaXJlbGVzcyA3MjYwIChyZXYgNmIpCnJvb3RAbnhwLWlteDg6fiMKCgoj
IyMjI0FmdGVyIGtleGVjIChib290X2tleGVjLmxvZyk6CgppbXg2cS1wY2llIDVmMDAwMDAwLnBj
aWU6ICAgICAgIElPIDB4MDA2ZmY4MDAwMC4uMHgwMDZmZjhmZmZmIC0+IDB4MDAwMDAwMDAwMApp
bXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6IGlBVFU6IHVucm9sbCBGLCA2IG9iLCA2IGliLCBhbGln
biA0SywgbGltaXQgNEcKaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBlRE1BOiB1bnJvbGwgRiwg
MSB3ciwgMSByZAoKaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBQaHkgbGluayBuZXZlciBjYW1l
IHVwCmlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUGh5IGxpbmsgbmV2ZXIgY2FtZSB1cAppbXg2
cS1wY2llIDVmMDAwMDAwLnBjaWU6IFBDSSBob3N0IGJyaWRnZSB0byBidXMgMDAwMDowMAoKI6H6
IExpbmsgbmV2ZXIgY29tZXMgdXAsIG5vIFBDSWUgZGV2aWNlcyBkZXRlY3RlZC4KCnJvb3RAbnhw
LWlteDg6fiMgbHNwY2kKMDA6MDAuMCBQQ0kgYnJpZGdlOiBGcmVlc2NhbGUgU2VtaWNvbmR1Y3Rv
ciBJbmMgRGV2aWNlIDAwMDAgKHJldiAwMSkKcm9vdEBueHAtaW14ODp+IwoKCiNRdWVzdGlvbnMK
QXJlIHRoZXJlIGV4aXN0aW5nIHBhdGNoZXMgb3IgcmVjb21tZW5kZWQgd29ya2Fyb3VuZHMgZm9y
IHRoaXMgc2NlbmFyaW8/ClRoYW5rcyBmb3IgeW91ciB0aW1lIGFuZCBhbnkgZ3VpZGFuY2UgeW91
IGNhbiBwcm92aWRlLgoKQmVzdCByZWdhcmRzLAoKR3VvY2Fp

