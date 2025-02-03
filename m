Return-Path: <linux-pci+bounces-20647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E22A251DA
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 05:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2AF4162E46
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 04:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4612C859;
	Mon,  3 Feb 2025 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WI580vkC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FA1CA9C;
	Mon,  3 Feb 2025 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738556921; cv=fail; b=CU2H7+tgUMp01VYyAWpn0GAJq10dQX/yFgX6MlLgi/svaV2oi0Xwrhnfv/R6Lm1NMifG7/fgm1lsznseaY/WIYqNJud0jb+2vWhw1BshSM8ym/4AaJtSZDLv0jpOJXs9KY8IiHBJoavm3w1Ebmvc8+S5WwjV2W81uO9pIAWdwBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738556921; c=relaxed/simple;
	bh=MZwVUA5W/O+Yq9rJeesuno+wTksTWfiNnvAsXsQHOY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VSkNSCYWLnx+YdNMupJvqjtdXZJRYVpJqV2DOsVq8LYBnfBuzFsOlftm4XVBDQ7DbNeOo2N9Z00QlgUJXWbi7IQfivy8tXIdGhO8MwjtObSDI+09HLnThuVD807pXQhKkzfQvqhVNF+dIzHV28kRu+aeZEzSx6RRURFxNcDIV6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WI580vkC; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5131QW5h024314;
	Sun, 2 Feb 2025 20:28:24 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44jjdg0avj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Feb 2025 20:28:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOdhpXJbM38wMABObHRekZoJGGmWTQ8kTqru3ydYRZGT8buBXRkGuMBaAAXsTzt/lky3dElomc5w3hJf4TOJhGkFkkS3ideugDfxD6kHjkcyIVqTBw8MMICDbiEmjoNHm9DBaV24AvQsXPCW/aXsOv4ZC25TL35DSItZCnshLINbJMQwkn1VR4/dwugntwEzxnGHF7ZUGAYHNV/Ln9w37vzsTtWlbtlEnJT8QbNDEPWEVyyDrlYBNi6qiQGtQqqvG+UBTOyPbu68j8CqWEtBZon34VQ98Y4JQad+JRdzgkbpb9/NIdx7bF2svMvd0ffvBRntwxGHmJwX09X8cE87RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZwVUA5W/O+Yq9rJeesuno+wTksTWfiNnvAsXsQHOY4=;
 b=rbSfovXn4I4TQwkwL5foOO5v4mHeoH0xKQi2oDVkS21M8nYBjnb/2aRHTWC9+Mp9U4axLP9XUSD4+wfVuoEpydAkKBHPHx5h5n/t1heuTvwyCU4QdZhbU85yMc2lrrDmRCszIwCDrnkAhT50BUOv0tdRJpiJOM+w5/LZahIl1BCG3kP1mkdqLV6NE+OO5/xQEgPal7D8dKU5SKK0bAvdVAo7UhY47Zb7kbXCEXVYti+LOmQkWWMfoAvCbgiCZQ85ulalxrlMi11iqtbYkwHyTbuipWjFOQoPtvYr5iBRo4gCmRpgDBeSGlihmQrIA/1ShHiBmbVZn+JJsnEq7Qevbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZwVUA5W/O+Yq9rJeesuno+wTksTWfiNnvAsXsQHOY4=;
 b=WI580vkCFvXWKOfBujv+3AGOgYVGxU0VAifx46dMAagK4UqtSs38PX11F1y2b2iAfuQpdTo/8SJ+rdysg84FbQO+8lueFcst90VulA8npvIfpQGC8u+g4e7RloENZjtczz9iBqh6eqUSLFGPUiSsY7vYo9GlZQTElCURi2f5i5M=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by SA0PR18MB3616.namprd18.prod.outlook.com (2603:10b6:806:72::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 04:28:21 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%3]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 04:28:21 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: RE: [PATCH 1/1] PCI: armada8k: add device reset to link-down handle
Thread-Topic: [PATCH 1/1] PCI: armada8k: add device reset to link-down handle
Thread-Index: AQHbdfPIAH7kjl8PyE6qwvpi+seqVLM0+7bg
Date: Mon, 3 Feb 2025 04:28:21 +0000
Message-ID:
 <BY3PR18MB4673F20C6253B948C2A5F1BBA7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20241112070310.757856-1-jpatel2@marvell.com>
 <20241112213608.GA1861480@bhelgaas>
 <BY3PR18MB46731FD9009EC4A2443C41F8A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
In-Reply-To:
 <BY3PR18MB46731FD9009EC4A2443C41F8A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|SA0PR18MB3616:EE_
x-ms-office365-filtering-correlation-id: 9a147922-005e-48ab-842b-08dd440b3114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTFLWFovb0NqRmQ1L0tReFpZQXMxSVRDNnpkMDJSblpoUlNjQ2Z5T2MrV0VL?=
 =?utf-8?B?RUVKTTRJUEV5cncvY0QwSEY0bCthcWxTWWFpa2NDTHV2b0t6SUFsVnR0SWgv?=
 =?utf-8?B?a2ZkZVBPZ2ErYkRZdnZPWHNhM3JLTzRUNCs4cVRTbUdEMHJvaC8zajMveHNy?=
 =?utf-8?B?bWR6a1Exa1VoallxVWJHWTE3bkx1WE9XQXN5aDYxd0NBSmJZTEZoZ3ExVVha?=
 =?utf-8?B?b0RvcmRnOGlJOGp5QVIxaksvdDBESWxNTUowZlltRmljcFF3Um93d3I5Uitn?=
 =?utf-8?B?MnJYOG4vbHd2TEpqM3VTOU1lMjFxMFd6d3JhY3dCSVVyZXhyRzl0N0pBQXl5?=
 =?utf-8?B?V2FqZXZaRWZtR1NVMjl4S3Azb1hpaFU1cTRoSVdjdXJIcjIrRjRDNGFzR0Ns?=
 =?utf-8?B?MW9NMDUvWHlPM2xJOUw0NStjVzg1YmFOcnpZTGIrMEk1cS9NUVBIamR1aFRa?=
 =?utf-8?B?YjFBSTBlNjMvMHJ4UCtTM2lKcVVuTWxWZmQyL05hODJEK1hGNDVLNkoySjVX?=
 =?utf-8?B?R0FJaUJKM2RZVUZpRElPT3B3dm1YMU9wNW1qT01ZVFV0L1pIbklmL0Z5U1M4?=
 =?utf-8?B?K3RNUzV4Mm5kV201cFBTdWJyTmFoMEYvZVY5OExXVExvV2RSTXAvdHYrd3JT?=
 =?utf-8?B?RmQzZktKNFoxbWgwZDBmbkM3T0dMbmc1dkhNbk8xd2lERVJmNm0wUEJQY0RN?=
 =?utf-8?B?T09lMjdTNUNKMEdtWmpsdC9kTy80TXk4M0MwbGw5czNSeUpQaTFvOS9EVWpz?=
 =?utf-8?B?ZDYrdW16Qituallxcm1obUNTa2JPcEVIaEh5TnUvVEp6OWw0TjRIMjRQS0lI?=
 =?utf-8?B?V0RpSllVdk5CRGY0cUZ3OU5zbUJNckxTY2NhSVdwVWVDcm5BQ1BmaGxGelZu?=
 =?utf-8?B?S09YL2VvZnVMS3d3QTJzbzU4ckpybnJwQUkzcXJXS1d2WTlQQ2Z3ZWRzS2Np?=
 =?utf-8?B?RVQyN0kyOTRhemtBbVRmejU1WTFncVBXd2lqV3A2OWQ0bVBLYW1TdkFKRnBw?=
 =?utf-8?B?YkhHN1U5alNHWjN3OE5HN0JhR3NjWDF3YTF3UEFrTkZoR3J1SFlVRTFzYlhn?=
 =?utf-8?B?WUF0akNoUDBhL05kMDRoZTRxdlRKbVU3QnRxejNEUm43VWRZcXltYVhzRkd4?=
 =?utf-8?B?cFJhejhOY3Z6ejNrVG5vdEdiKzZQYlduYTdCNVo2MURnZGdJTFpUclltTUhD?=
 =?utf-8?B?eWc5N0NJa1ZKK0t1Ui9JR1M0RTVUYzNZVUxKSjRYSXlGSVQ2dUMreENjVkRm?=
 =?utf-8?B?aG96NmxNTkx4NjRGQk5yV0MyVE9vS09UcmNOekRtLzBocUJJRnhoZ2l2S3hE?=
 =?utf-8?B?WkFoU2VwaHZjWXMybE5CK3BkZXJQZjJhQ0l5dEZ0ZTM1NlgzUHFYd3dXdGNv?=
 =?utf-8?B?L3RhMVhIdFFRV2ZBRXlEUERlbnRFbWJrYmt5b25tMG5JSHhTMFBjNHhWbnBB?=
 =?utf-8?B?KzN4N2gycU54blBWeEZxLzB4QkpGSStUN3VHNDF5WWw3dHFYamQvbXlPNzlB?=
 =?utf-8?B?eXF0bG9ubXJtWERvSEZHN0xXanN1NmxOTW9sU3M5RzBWSkMyTndYRWc4N3gv?=
 =?utf-8?B?bWtOR1hBQ0hzdG10TVY1bWR5OXJBanJQbWhGQUZ6d3I5YTJqMG9GMEE0TWxS?=
 =?utf-8?B?V1ZlenpaR2t3UXNheE1RWG41eHdPQWhlSk14RTg3aDFxUzVOTXZUUEFIV0hE?=
 =?utf-8?B?L21FL1d2SXlCNzNHa2VEcjM1WjB4eUpzZGhOOGhGRCtiNGxoY0VyeDNrc014?=
 =?utf-8?B?VHhPRlMwZkhsVjhUMHVBTTVobHcxbHVpWnhmK283S0FXVVNxMHpELzRZd3BD?=
 =?utf-8?B?Z1lER2YzSlUwM3duK0Q5TlArSXlhQmRiMjUwb1RDdDZwZnJSV1Nyc0VyQVBC?=
 =?utf-8?B?a3E3MjZySmxReXZTWWt4Uk5qZC9aZk1ORzFMNFd0TFZ4YWkzOGNkeVJqOGhF?=
 =?utf-8?Q?WH/ypaoga5UMNghfn7Wgn/hjHCB0KvDa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDlXUThjRG5SU2t1VlpVY3R1NFE5NmN6UitKZnlmOTJqa2FHbHY5elErbnIy?=
 =?utf-8?B?UGhZbnF0VkFHMkdPWWVnOUVFa2hwYWtGY3d6b2dmK2trTU0vMHNhWEltVDlZ?=
 =?utf-8?B?YVRZREF4WTFyK24wcWZ0MFFnRUszMXI4ajA0ZlJQWEJxeHNNTXJWZ1JDUUpD?=
 =?utf-8?B?K0w3UUFqd2tBL2VEMXRSQ09oODN3Wk52MUhGUStQQ3lpVWI2U2phM1Vadkpa?=
 =?utf-8?B?UjBoN1NZNTJFK2tiS0pMSFAzcnR5Q2Vna3luZ1FiTHpUMW9aSnFEMmJzM2NN?=
 =?utf-8?B?VXhlamRqSEtudkhSQ0UyejRlSDVQcVhHWnpmQ0FsdGRHYnZkUGRzVDJJQktu?=
 =?utf-8?B?YlBVMTBJZzlZQ2R0UEJDU1h2TGFmVmYzWXBBczF2Y0hZOGZyeldBZE84TTg3?=
 =?utf-8?B?SURkVUt0QWtMRFFkRXdHNWFCMDBtZ1VQb0pGSmZTSXV6UFJmWTg4M0FTWHNo?=
 =?utf-8?B?TjF0N21JNHBVTWRuM3VNNC9sUHBJUGo3OEUwYm01VGEzVFFOdVpOR292aUZN?=
 =?utf-8?B?T1llbGJ1SWY0TmpKZk02cG4vajRTYlAzbTRjVkVKZ1JPbElEejUrMmw2MWM0?=
 =?utf-8?B?anhmbjFmMTRKSWx6aUNZOEVHdWZJUnlRN2d3a0FJRVp5aWUrQTFSV3poY3U1?=
 =?utf-8?B?cCt4Zkpxc3lwc2ViZWduM05XSFMyczVJYStvUFBYVVFVbjhWdzNHaUJNUk9u?=
 =?utf-8?B?c25JNnRhcGlGY3NDQTBTdTQzRkFOL1FKc2UydDFBZEJ1cENjUWlZL1d1ZlRr?=
 =?utf-8?B?RmsxR2o1QS9Mc21GVEJVSUFpK083RFJsWkhZVThNYStnWGQ4Z0V4NHZxVXRE?=
 =?utf-8?B?RzlBVnlqWFhmN1dMbDJEZGZ6SDA5K1FZQVVBMW9RZ3F1aDdWTEZJMUxnd1dC?=
 =?utf-8?B?T09RS2Qxb0hHVGl1d3gwNGFTK0tKS1k2M3pTYzg0OUxqUUhxMklWaWd5NGlZ?=
 =?utf-8?B?ZzhRQTNzc0U0bjVzSXZVNVc4cE96a0pGZzBveDlsNTV0UjVmVjRxTVRmdzJI?=
 =?utf-8?B?ZCtjV2RsVWEyQ3VXeGlzOW5VbFMzS3hLTlAxZ3VkMkJqbmRjTTJOWitHWk9C?=
 =?utf-8?B?K2RtdVo1UzYyMDkya3d5dkttSUR2eDlrSmFyR1RSd2xRNXJLVnhxRGc2cXhV?=
 =?utf-8?B?VFMwTjJJVlU5ZHJMTHdrUWM1by9NV3dLU1NaOGZ6ZDNyS1M3S09xSE90clA1?=
 =?utf-8?B?UW1TRWtmajByZFBPQ0NkQzIxc2lrajVIV0VNZjZETUczRFZiWm1zWGk0eDY1?=
 =?utf-8?B?OGpwWWR0Sm4wdFJ3VzAvd1RzdXAxOEh4SkRjNkZsb1k3OEthQWk5SGxURGhY?=
 =?utf-8?B?dXUvSDFSckVJKzJvbXFFSzhsby9qZ0tqZnV2eEpKbDlQUXR3aDA1Y0pxT3h5?=
 =?utf-8?B?ZTlXbUIveURiTlFTRmFCTEkwSmx4Z2pPb2VQMmRoSmN5c3ZqNllpMlhkNGth?=
 =?utf-8?B?K1JwSDRLcjF4emdsV1VXcitHMHdNZUhCM3JpNDkwNDVSbS9QQ3lkVVRaSFJH?=
 =?utf-8?B?N1d1bWRNckdEb1N5ai85RDFuYXdIZ0YvWGxXNGQ3TUFGb3VveDltaEhOUU5M?=
 =?utf-8?B?Z3VWeE82YWxIakpoTjYyMEVyRE4walpyQm9zc0dBZHJwTFR3WUJVSG9WL2tl?=
 =?utf-8?B?a1pqQTZlTUg0UkZTT01PaU1QbW82UkM2bjk0K0QxZnFIclF6b3dacWtBK0lI?=
 =?utf-8?B?RXZXK01ydjNPN0V1TlpFUEJ1eUs1cVJSUXpCR3h5MXRDL0VHQ3pqNGdTbzlF?=
 =?utf-8?B?eEZQeTZuWk5ydWhYZ09aM2V3S3JnVlNhUzE1SjJvUXVXbjZPdDc2NjZFQURU?=
 =?utf-8?B?LzlTNFlpUkVHYU4rYlAydnNZb0NKcm5yQVJnTDFCSHhQUk42V2ZzaGw0ZkdI?=
 =?utf-8?B?VU54Wjk4bVRKbzF1eGpqQjA0bVplY3gwUUFDMTlXVmx1M2ZIVUZPeTNsQlZT?=
 =?utf-8?B?UUxRbU9kRlN3NFNuZkpSSm1JMDRTLzRtRTA5cnhrV3pacWFJckxCUzNPbkVO?=
 =?utf-8?B?SE0vd3NZWmJBNmdnYnl2bTByUzU2WG9KeDNvak40Z0JRUmlkTDg3K1dBcmI2?=
 =?utf-8?B?UjR5MDdXci9xWlA3QmxjT0tmTW1UV2wwaWRDbytFNjhzWW5HTi9SQWhzV0ZQ?=
 =?utf-8?B?cndneGwwSnZXZ1hDYy9LcTZsM1g5R0M0a0dCejFjNlNhbjBsZlo4OWdxaXU5?=
 =?utf-8?Q?AIvyAQSOS4M7oYm0wBOgwGtQFNYpP123L5jnJ0ZvTIj/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a147922-005e-48ab-842b-08dd440b3114
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 04:28:21.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQTfCbBnZq4K/jCkl54c0CVsOl+4zeT+W50wwpqDF86PfOeePHn2wN+guZN5BLcoprijO9m7LKjZF3Rf4Jibxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3616
X-Proofpoint-GUID: Qn9FzzhrxaybELjYwZaWDmr256jr0y-v
X-Proofpoint-ORIG-GUID: Qn9FzzhrxaybELjYwZaWDmr256jr0y-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_01,2025-01-31_02,2024-11-22_01

PiBJbiBzdWJqZWN0LCBmb2xsb3cgY2FwaXRhbGl6YXRpb24gY29udmVudGlvbi4gIFVzZSAiZ2l0
IGxvZyAtLW9uZWxpbmUiLg0KPiANCj4gT24gTW9uLCBOb3YgMTEsIDIwMjQgYXQgMTE6MDM6MTBQ
TSAtMDgwMCwgSmVuaXNoa3VtYXIgTWFoZXNoYmhhaSBQYXRlbA0KPiB3cm90ZToNCj4gPiBBZGRl
ZCBwY2llIHJlc2V0IHZpYSBncGlvIHN1cHBvcnQgYXMgZGVzY3JpYmVkIGluIHRoZQ0KPiA+IGRl
c2lnbndhcmUtcGNpZS50eHQgRFQgYmluZGluZyBkb2N1bWVudC4NCj4gPiBJbiBjYXNlcyBsaW5r
IGRvd24gY2F1c2Ugc3RpbGwgZXhpc3QgaW4gZGV2aWNlLg0KPiA+IFRoZSBkZXZpY2UgbmVlZCB0
byBiZSByZXNldCB0byByZWVzdGFibGlzaCB0aGUgbGluay4NCj4gPiBJZiByZXNldC1ncGlvIHBp
biBwcm92aWRlZCBpbiB0aGUgZGV2aWNlIHRyZWUsIHRoZW4gdGhlIGxpbmtkb3duDQo+ID4gaGFu
ZGxlIHJlc2V0cyB0aGUgZGV2aWNlIGJlZm9yZSByZWVzdGFibGlzaGluZyBsaW5rLg0KPiANCj4g
cy9wY2llL1BDSWUvDQo+IHMvZ3Bpby9HUElPLw0KPiANCj4gQWRkIGJsYW5rIGxpbmVzIGJldHdl
ZW4gcGFyYWdyYXBocy4gIFJld3JhcCB0byBmaWxsIDc1IGNvbHVtbnMuDQo+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEplbmlzaGt1bWFyIE1haGVzaGJoYWkgUGF0ZWwNCj4gPiA8bWFpbHRvOmpwYXRl
bDJAbWFydmVsbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtYXJtYWRhOGsuYyB8IDI0DQo+ID4gKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMN
Cj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYXJtYWRhOGsuYw0KPiA+IGlu
ZGV4IGIxYjQ4YzIwMTZmNy4uOWE0OGVmNjBiZTUxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYXJtYWRhOGsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtYXJtYWRhOGsuYw0KPiA+IEBAIC0yMyw2ICsyMyw3IEBADQo+
ID4gICNpbmNsdWRlIDxsaW51eC9vZl9wY2kuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21mZC9z
eXNjb24uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvb2ZfZ3Bpby5oPg0KPiANCj4gUHJlc2VydmUgKG1vc3RseSkgYWxwaGEgc29ydGVkIGxp
c3Qgb2YgaW5jbHVkZXMuDQo+IA0KPiA+ICAjaW5jbHVkZSAicGNpZS1kZXNpZ253YXJlLmgiDQo+
ID4NCj4gPiBAQCAtMzcsNiArMzgsOCBAQCBzdHJ1Y3QgYXJtYWRhOGtfcGNpZSB7DQo+ID4gIAlz
dHJ1Y3QgcmVnbWFwICpzeXNjdHJsX2Jhc2U7DQo+ID4gIAl1MzIgbWFjX3Jlc3RfYml0bWFzazsN
Cj4gPiAgCXN0cnVjdCB3b3JrX3N0cnVjdCByZWNvdmVyX2xpbmtfd29yazsNCj4gPiArCWVudW0g
b2ZfZ3Bpb19mbGFncyBmbGFnczsNCj4gPiArCXN0cnVjdCBncGlvX2Rlc2MgKnJlc2V0X2dwaW87
DQo+ID4gIH07DQo+ID4NCj4gPiAgI2RlZmluZSBQQ0lFX1ZFTkRPUl9SRUdTX09GRlNFVAkJMHg4
MDAwDQo+ID4gQEAgLTIzOCw5ICsyNDEsMTggQEAgc3RhdGljIHZvaWQgYXJtYWRhOGtfcGNpZV9y
ZWNvdmVyX2xpbmsoc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3cykNCj4gPiAgCX0NCj4gPiAgCXBj
aV9sb2NrX3Jlc2Nhbl9yZW1vdmUoKTsNCj4gPiAgCXBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2Rl
dmljZShyb290X3BvcnQpOw0KPiA+ICsJLyogUmVzZXQgZGV2aWNlIGlmIHJlc2V0IGdwaW8gaXMg
c2V0ICovDQo+ID4gKwlpZiAocGNpZS0+cmVzZXRfZ3Bpbykgew0KPiA+ICsJCS8qIGFzc2VydCBh
bmQgdGhlbiBkZWFzc2VydCB0aGUgcmVzZXQgc2lnbmFsICovDQo+ID4gKwkJZ3Bpb2Rfc2V0X3Zh
bHVlX2NhbnNsZWVwKHBjaWUtPnJlc2V0X2dwaW8sIDApOw0KPiA+ICsJCW1zbGVlcCgxMDApOw0K
PiANCj4gTmVlZHMgc29tZSBzb3J0IG9mICNkZWZpbmUgZm9yIHRoaXMgMTAwIG1zLg0KPiANCj4g
PiArCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocGNpZS0+cmVzZXRfZ3BpbywNCj4gPiArCQkJ
CQkgKHBjaWUtPmZsYWdzICYNCj4gT0ZfR1BJT19BQ1RJVkVfTE9XKSA/IDAgOiAxKTsNCj4gPiAr
CX0NCj4gPiAgCS8qDQo+ID4gLQkgKiBTbGVlcCBuZWVkZWQgdG8gbWFrZSBzdXJlIGFsbCBwY2ll
IHRyYW5zYWN0aW9ucyBhbmQgYWNjZXNzDQo+ID4gLQkgKiBhcmUgZmx1c2hlZCBiZWZvcmUgcmVz
ZXR0aW5nIHRoZSBtYWMNCj4gPiArCSAqIFNsZWVwIHVzZWQgZm9yIHR3byByZWFzb25zLg0KPiA+
ICsJICogRmlyc3QgbWFrZSBzdXJlIGFsbCBwY2llIHRyYW5zYWN0aW9ucyBhbmQgYWNjZXNzIGFy
ZSBmbHVzaGVkIGJlZm9yZQ0KPiByZXNldHRpbmcgdGhlIG1hYw0KPiA+ICsJICogYW5kIHNlY29u
ZCB0byBtYWtlIHN1cmUgcGNpIGRldmljZSBpcyByZWFkeSBpbiBjYXNlIHdlIHJlc2V0IHRoZQ0K
PiA+ICtkZXZpY2UNCj4gPiAgCSAqLw0KPiA+ICAJbXNsZWVwKDEwMCk7DQo+IA0KPiBzL3BjaWUv
UENJZS8gKHRocm91Z2hvdXQpDQo+IHMvbWFjL01BQy8NCj4gDQo+IEV4cGxhaW4gdGhlIDEwMG1z
LiAgSG9wZWZ1bGx5IHRoaXMgaXMgc29tZXRoaW5nIGRlZmluZWQgYnkgUENJZSBiYXNlIG9yIENF
TQ0KPiBzcGVjLiAgVXNlIG9yIGFkZCAjZGVmaW5lIGFzIG5lZWRlZC4NCj4gDQoNCkkgd2lsbCBk
b3VibGUgY2hlY2sgaWYgdGhpcyBkZWxheSBpcyBuZWNlc3Nhcnkgb3Igbm90Lg0KDQo+ID4gQEAg
LTM3Niw2ICszODgsNyBAQCBzdGF0aWMgaW50IGFybWFkYThrX3BjaWVfcHJvYmUoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXN0cnVjdCBhcm1hZGE4a19wY2llICpwY2ll
Ow0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiAgCXN0cnVjdCBy
ZXNvdXJjZSAqYmFzZTsNCj4gPiArCWludCByZXNldF9ncGlvOw0KPiA+ICAJaW50IHJldDsNCj4g
Pg0KPiA+ICAJcGNpZSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqcGNpZSksIEdGUF9LRVJO
RUwpOyBAQCAtNDIwLDYNCj4gPiArNDMzLDEzIEBAIHN0YXRpYyBpbnQgYXJtYWRhOGtfcGNpZV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCWdvdG8gZmFpbF9jbGty
ZWc7DQo+ID4gIAl9DQo+ID4NCj4gPiArCS8qIENvbmZpZyByZXNldCBncGlvIGZvciBwY2llIGlm
IHRoZSByZXNldCBjb25uZWN0ZWQgdG8gZ3BpbyAqLw0KPiA+ICsJcmVzZXRfZ3BpbyA9IG9mX2dl
dF9uYW1lZF9ncGlvX2ZsYWdzKHBkZXYtPmRldi5vZl9ub2RlLA0KPiA+ICsJCQkJCSAgICAgInJl
c2V0LWdwaW9zIiwgMCwNCj4gPiArCQkJCQkgICAgICZwY2llLT5mbGFncyk7DQo+ID4gKwlpZiAo
Z3Bpb19pc192YWxpZChyZXNldF9ncGlvKSkNCj4gPiArCQlwY2llLT5yZXNldF9ncGlvID0gZ3Bp
b190b19kZXNjKHJlc2V0X2dwaW8pOw0KPiA+ICsNCj4gPiAgCXBjaWUtPnN5c2N0cmxfYmFzZSA9
IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUocGRldi0NCj4gPmRldi5vZl9ub2RlLA0K
PiA+ICAJCQkJCQkgICAgICAgIm1hcnZlbGwsc3lzdGVtLQ0KPiBjb250cm9sbGVyIik7DQo+ID4g
IAlpZiAoSVNfRVJSKHBjaWUtPnN5c2N0cmxfYmFzZSkpIHsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0K
PiA+DQo=

