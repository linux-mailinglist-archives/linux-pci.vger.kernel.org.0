Return-Path: <linux-pci+bounces-5610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED45896ADB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4211F23420
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6D1350C7;
	Wed,  3 Apr 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hMfvKx/8"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC19839E1;
	Wed,  3 Apr 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137237; cv=fail; b=uzVYNYupm2PUaa6G1XeCPnZvgD7nHLYGOxuNC/Elm/OjXAvznNHFqFlXA9K2LcCzt1Lgii4MSAmTsim+PzhqIejT8TpabINs5E1FfFZ/jvdPd7WKUylxiqT660n2+gZavn8YVJWZ/JPz1T7kmaYRntxvTBZnOz/RVGxM6f1fkYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137237; c=relaxed/simple;
	bh=LfIb3ulmcQeH/Vy/mGbqYdiI8CNCzUjxr5XI2MFC9BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Si4fFwOsaZmMkqryzAWR/sL25rJn31oUp2oMFpWfqHQe1vRGcCMICVJXGIcH4LiQmpiQCrOfQxLaA57BZci/Uityxrh3aZn8A6GFwYtBrYFZ8BjXMEWLkYEqoosFCbyZaeHFjtDKS4icLvjLQ7xSF7Jw+mLzX13xPAfS5LN7LAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hMfvKx/8; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712137234; x=1743673234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LfIb3ulmcQeH/Vy/mGbqYdiI8CNCzUjxr5XI2MFC9BM=;
  b=hMfvKx/8R8QM7hkBsPe+oF1pn3cUSWHZCQp94EG6JtguasmKI3vYmnn2
   4BXPOr4E6Qx9wz9myc2RiSALfhKDwOS7gbuHLPDp50HzFcSi8C/ub2FtM
   xz2cmd7EIbcKnkwwcbsIAYTpOlJ5f5Yuowtc1JWpWQ5QXzLDV/FhqkCqI
   PYiRs6bqOdTg5XvdzmcBdLDKFjOjF8lk3wwStziW3XI8vNB7lyIbxBiAG
   wF79FWI6QdZUWhhIsmj2wyhDOa/HfSb2B8w9zXmmhgiRWFdK9XqYSEFR5
   FG3Lu/EvrspIy6I1dNjzJiINn7QCaSohGrBtQfvSQz4WeXinanR+0Zpdr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="115772272"
X-IronPort-AV: E=Sophos;i="6.07,177,1708354800"; 
   d="scan'208";a="115772272"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 18:40:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=girllIv/L13o2Rvtz/Hd2DOC4QjUFgGI6xcLbrd7lFA5FNzatZ8HMzHFa8TsYWlrrAHcNR4CtPXySBJrPCAG4FMWQ9mWM96S2VLy7jhOCmAs5c43nj+r7Znw1HEwCs297EggTbPkAeh9yI0MkjoqcFsxebvIBIyZFp6n45ZjDmXcBrSiuatbpBnrJh5STWZUr7gOZHeIp6z1h6jHEV5wxBsUvCD96rKjHb0l4Y/sZ/pspMQCzqS1xGHvNbpwaizoT00a5mVtmfUjA29oH26qpT43R+WuciCPUSG8/yNJSOQ41srrZP29Fg5je7KI+bxP22vAuFWSvFMHnFa5XM6++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjdGsqOXNFQ8wpbEwjdvmPZuB5dpl3iATP8Zh0hm4zw=;
 b=EqNx0vRs0Pravbz0+KmTn8no7v3m+qdW4PYhaIhL/t4hWVl0TXomLjKUzcHWiXvoDflyRfdBMBF1M/pWULiVWvC5vJ80nAeppy871udPw3viEM0UTgp4l8GsRM05XON4tJBzg6zGiRifp9eRlbctS7yvMp911YlDPyobPzK7mbAiGP7S7vMI7K3mmseGHqCrPegtEYss9RTUzXQXj0ux4U1zWAZcSysvzZZygZDPacfjUQwvfYYpA9+GXXkY8sbOpAd3uoN/HtyI05IGc7Y+jnke2em3AOODKToYXHj8Reuc65YhA+lKahVEMNn3pJJ4zSiu9XLSklMF3TgMr0Otrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSZPR01MB6726.jpnprd01.prod.outlook.com (2603:1096:604:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:40:27 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:40:27 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>, 'Dan
 Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Thread-Topic: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Thread-Index: AQHadFPBx8nrp1zF/UK8IxmlbTRGybFKhXmAgACiphCAC0FrgA==
Date: Wed, 3 Apr 2024 09:40:27 +0000
Message-ID:
 <OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
 <6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <OSAPR01MB7182912D196E74F55BE1A55FBA3B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSAPR01MB7182912D196E74F55BE1A55FBA3B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=b90f59c5-1030-4ab2-a67b-dc4b5044fa84;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-27T08:38:29Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSZPR01MB6726:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J9hvnsAncjEvhJIsxI9KmyzqjXrmnsrGTbygCXZJm7JHjzkvt2Wbzs6GRHBDB3FoLPowYPjUhVOYDnw0Ykten4vjtENZEtOCLv57rhLVEw6dqiUj42XxNJuiafE6p0YNg/EG+WfxU4CSl2YF3+HM0wXVcv6rG9J1vP+PeJZWlePuK80dS5L0pyUQxbE2J3UV39jqaU9VhYtgcntGAj2usiB/xWmNIzN2eHqLKvNeIRgdXMaFXu3HH7BmfTHDfdOE2DW1/9j7BV8vgTO1lJ7TYHeLkgKI31mb9uR6TmeN/4Xbh90jMq1Q+hMw+zhD75raLEucPO7fIaarhLZFjVHVIryVZRNhMnx9uwZ1tnl4cFdNYAN994lKdO3XP4HSUPz6EjZwCtLH1HWH7UC3IxTVQo9Uj5ftHZqzyUzCVcyGmQlAlREwQ/VESwRDCT/eyoajUd3FpU/gPK2PvIDbSAUSvSYBfnCNM1SXEOVtZe5Vcz1ivYm5hhRpE/7whAePSUnwVlsQDcCqeXSM6cOk6Jf23dMmHdl90UAqOGDp+TLueaZBtGjtN3wrEb2cvA1mBkvOhpyx1FSVtbjTYElsjzZJVd9PcIDsIT5YrD0GH7NQXJp/PiQtr8/pskpGZoS2c4+CwmbnQ1aRklnuLVE8tpZC9ZAQMe//VD++FxH1EI+LjMy+P8hWQGuMXURv4TWq3FDe38Hacz4r9Muf42gxBLHGCw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?T2dzbE1FeWdEc0p3TWlud2RUWUNFUmt6c0EvYWFaMjREYTY1VmtablJ6?=
 =?iso-2022-jp?B?ZGlzOGQ4N0VPTFR4c1NZRHFpNVZzblNkU2ZmNk5qdUZDWVRiN2Nsdm5N?=
 =?iso-2022-jp?B?WkZmRE1OQlZjcG1JOHcxSXFzZFBWYnhmSmNnKytLTDR2eCswOGNWL2Zq?=
 =?iso-2022-jp?B?Q1hjdFo5Vk1jc2MxL0VScU1TT1k5S3V6UCtwMFlDd2NQZ0xGL0NzV0xt?=
 =?iso-2022-jp?B?Mmh1TkQwemg2QTN5bGIrbFMxd2pCdTZkS3lzYXFBa2pvbmVscDJzdzdt?=
 =?iso-2022-jp?B?Ty9jZW9FNkZYd29kdDFWZGlyYlo3VkdhREg3V2dYTmhUc011bGhMcmds?=
 =?iso-2022-jp?B?aWVtbEV0aEhxL0drV09DM1ZkaHNDZ2FEN0xiQ2RCWWFxclNmdEJYS2wx?=
 =?iso-2022-jp?B?YWVNS1hUL0JpZDVpdzVOaUFIRTlUMWg5dXpSdTRCRk52SEV1TEF3Mk9z?=
 =?iso-2022-jp?B?clpRR2w4bkVHUEdiQnFPWmg0anBQRDhjZHUzNHFtbllobnhuRGxiVGta?=
 =?iso-2022-jp?B?V0FsQytKZWR4aGduZTlORjNuK1NZR2NWTXViZytXTFNlVGJreVNuTHBh?=
 =?iso-2022-jp?B?RVZ4Rlc5ejVJbnIzZjhFaTdQMlZscks5bHZvS01uKzYvOWoxMTRQVmh6?=
 =?iso-2022-jp?B?UmFQNy9rM0FCUjlybDk3SjVaUTRic3dqR09JeVJmdnFNNEk2cWgrNE1F?=
 =?iso-2022-jp?B?RGdEeU5vOHN1YnlJQzBRU1lQMTFDVkpxK3pmNDg4RC9XNUhBQ0xEbVp3?=
 =?iso-2022-jp?B?SDdDdTFlOHF5RXhPWGhQSmNkN0t4VHRMWC9JTDFzQXp0NWhXNlBsYW9U?=
 =?iso-2022-jp?B?UEhybEtQVHlBZG5ic3lkdERZTjJadDFSUXo5bnI3ek94MTFqM1pZMmNJ?=
 =?iso-2022-jp?B?M3BPcUplZXFvTUl4NHZoRzJpRGduVzQrRDlzbGx6ZWJJVnZOdy9xczBU?=
 =?iso-2022-jp?B?KzBkb0doUUE2MVAyWkRDSlFsVi9lMXdYZ0tKazVHUkxhMS94MnNvMDdX?=
 =?iso-2022-jp?B?cFREanVheGxEbXFkT283WWpTb3NuWVlkTUVPQWtzM202NG9jamRIbS9w?=
 =?iso-2022-jp?B?U3QrUzZxNENjNjI2LzMwRUtLT3ZIM1YwR1g2VThnZDk4UE1uTjhwTC84?=
 =?iso-2022-jp?B?TnQ4djdmS1B5OStBMGdBc2ZFRDcwRDhjK2d6K1hvd1doRU85cHp5dU84?=
 =?iso-2022-jp?B?SkpMRVhNQ2k5aHZFd3cycHREcFF3RW14WFJla1RzeUprZS80dmRFZWti?=
 =?iso-2022-jp?B?Zk82Ky9MVys2UkRqSnlhOHFLTmRJYy9WRmNpYlovV0ZpUjE1SGNmTTNl?=
 =?iso-2022-jp?B?VjVnYkFuSE1kU1JHbUg5VFRjT3dWTGRCdXl1cy9XRnZiT1hWcHpuMDlL?=
 =?iso-2022-jp?B?NGhsL2VwcmVlSDQzL3JDbW40MmtwMlg1WmpQRER0MzgrNUUrb3RnUmxD?=
 =?iso-2022-jp?B?SFRlY09OdXpnV2dMalRJYktmVkpTOTREbWpKbjlIZ1dBNTNPeURtbzJu?=
 =?iso-2022-jp?B?ZndQZEtSaVNwUmtCU0d2U3JzNVd2UGxJQzBNSXQ2Y0VKUVpiMUlxemd1?=
 =?iso-2022-jp?B?dmNKS1VsOEpTaFdOdDc2ajNrYU9zNUE2N0tPNWNGWEVUNTAzc0NmMml3?=
 =?iso-2022-jp?B?R2hvcUVNY2tSMGxIT2FyQkx1Y2VmdHFBTmErbU1lMG8yaGtxNmJJMVlD?=
 =?iso-2022-jp?B?QUdEYmtxamFKb0FTRUs4QXcrcVE1VmYwOUVGTWIyVFRuMGx6TjZhSWxG?=
 =?iso-2022-jp?B?bmQ5U2FYcEpDME5rWVZQbWkvek9xOVVES2xDSzRxRTliR014d1BoL3dG?=
 =?iso-2022-jp?B?TVZqZkl3SzBNWHptQkFGOTVFRFgxc1lOSUtxSzJpamloWGh1Sm9LOVkw?=
 =?iso-2022-jp?B?TU1ialhTSG94ME1Td0hKeGp1cE1BeEZXUG5Nd0tuN0hBQ01kMDk1ajJa?=
 =?iso-2022-jp?B?NVNoSk9JNFVkRjlKbjd3aUFCWHdZZmlYa2sxait3WWlPcW42Ukg4b3Rz?=
 =?iso-2022-jp?B?ZVlxbHUzK2VmRVZFVHpDMlBKVVg1a293OGlJR2syLzJrTTdrY1l5LzJ5?=
 =?iso-2022-jp?B?bHFjQUxqelNuR2dtanovYU1td0lyZGRlc0lRbDA2UWxSakNjUjFXTWR0?=
 =?iso-2022-jp?B?SzR2bUxmRFkwT2FxbG9CalZ4eTlkRG9TYmhTRHpGSmdGN2F3c0pMQm0v?=
 =?iso-2022-jp?B?RHZwbVJadVVabzVQa2pXM1JDRnhnZE1nUG9ScUlUSmxrUEQzWTRWbmFN?=
 =?iso-2022-jp?B?RjIwTnAyN1FyUjBTVGdsK05takE1eEExWGZwMlpQU1FTcnBzQVZ5ZDFU?=
 =?iso-2022-jp?B?emVpT2EvK1gxUVg4R1NISG9ycm5JTkRBY1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jE9MyzByQIkoNcft+dKyq82ow1jmxiI0sT3HlA+ptWbVzcCGzeup8M59qopJsalshfOMiC95pOyfTt7n50nSi9Urc6qJhs4CyjrsWY0/Bz9REkSYCJT4Lf0a9DG4B9DT5E5fBxyHVRT7qumqwssCAgh2bucrmssEnMrIK3V2HLtLP7b8gd9iZD59aWw5trZXdajxTn/T7bKgBSJBjqWthW5W10HZQamtb0pPvM0ZdcUuotZIDB3Qoc4H+BmEdgXDLMQz/8pkulPBeIGiZ1LcPbd4L9K+2K3iXwF0VltX1zim1AmNq7cAiosMVlDaLvmeTpB8ptKRIsyVZaA1ofuG+j4WmlkTRR1gqPdIimCOkVotPV/vsfc0Z8788EIgvRAaVv2SeXXJrrGeyfGU0fylSfDNV6v/xpS0hLcmV7DL+g1yY7fSqMcQ77A8ofSZt9vsgHTELNfg/3JFwc8a/CzCBehoAZMtqtNLFdm4mr1LXYloGdNwKbBmOj1376HO13J/Yp0g6pxqm4ajKd9seJEJ3kmSjXArL6Gw1RPIw6sFTajBL8KALlvO4MMYpTjvhhizC48KEoSo7knaY2JqpTXPk28APezaOrnz6VQfM1utgKNjUZOnJoEkGuzToY6YDW4y
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddad578-6c21-4751-0ed7-08dc53c2183c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 09:40:27.4922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAQzFXgF8VMLcQPiZgCq3TnV17/0O2HHlXEjm1Oxo1pc/l7wNq+Kvet7OBRLYJgU3rPo6355v/c9K7L955ceYjzBPQzX3cqQA8y8lFiNz5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6726



> Dan Williams wrote:
> > Kobayashi,Daisuke wrote:
> > > +static struct attribute_group cxl_rcd_group =3D {
> > > +		.attrs =3D cxl_rcd_attrs,
> > > +		.is_visible =3D cxl_rcd_visible,
> > > +};
> > > +
> > > +__ATTRIBUTE_GROUPS(cxl_rcd);
> > > +
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct
> > > pci_device_id *id)  {
> > >  	struct pci_host_bridge *host_bridge =3D
> > > pci_find_host_bridge(pdev->bus); @@ -806,6 +995,9 @@ static int
> > cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (IS_ERR(mds))
> > >  		return PTR_ERR(mds);
> > >  	cxlds =3D &mds->cxlds;
> > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
> > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
> > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);
> >
> > No need to manually call device_create_file() when the attribute group =
is
> > already registered below. I am surprised you did not get duplicate sysf=
s file
> > warnings when registering these files twice.
> >
>=20
> Thank you for pointing it out. Remove these calls.
>=20
If you are aware of the cause, I would appreciate your insight.=20
In my environment, when I removed this device_create_file(),=20
the file was not generated in sysfs. Therefore, I have not been=20
able to remove this manual procedure at the moment. Is there a=20
possibility that simply registering with=20
struct pci_driver.driver.groups will not generate a sysfs file?

> > >  	pci_set_drvdata(pdev, cxlds);
> > >
> > >  	cxlds->rcd =3D is_cxl_restricted(pdev); @@ -967,6 +1159,7 @@ static
> > > struct pci_driver cxl_pci_driver =3D {
> > >  	.err_handler		=3D &cxl_error_handlers,
> > >  	.driver	=3D {
> > >  		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
> > > +		.dev_groups	=3D cxl_rcd_groups,
> > >  	},
> > >  };
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >
>=20


