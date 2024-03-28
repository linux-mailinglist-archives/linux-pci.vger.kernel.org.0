Return-Path: <linux-pci+bounces-5303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D003388F4DF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 02:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AED1C27DAB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 01:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7078F6B;
	Thu, 28 Mar 2024 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WpGhIvKM"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230151804A;
	Thu, 28 Mar 2024 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590505; cv=fail; b=BaaCXr+pvWbrFq6hcFy24pKOFBz5fsmo6TLNMZfTybmCksGtoo+6dNSV3zE5KOP2egzqUNZoKgkSUGaxtRKUj5r9661Zh3pJfEJg5IxVWJ5dCDA7LyRNnag21E7CkLATUbn47W7eaqbp9KPjO2qCpIX1YYy0MWqeVRK/hSu/oMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590505; c=relaxed/simple;
	bh=It5HcSfNPMHif0mjnnjtg6l7glpAzXnbzeIJHMdtqUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DbC3BJwV0krGtHZyTQn8Ut8e6OXdz+d238EUd15ToxBXZMUAmyzZv2eqWo3IWf5gw2VuxTiQSFOWX33lB84x/WUoXK2XPfLYn9bJzGtwL0qBMMla8q5Sc10vByFf+eNn0/vnuEdv9KoB/wPnMdnLu5ED5OsXIVFFZ0Vzu4gSRZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WpGhIvKM; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711590502; x=1743126502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=It5HcSfNPMHif0mjnnjtg6l7glpAzXnbzeIJHMdtqUI=;
  b=WpGhIvKMhG8a1tTwfhMKwDdWRLLEV2yu/vQVlT5vroiFN3XNILEUwDtu
   AceC7fQRXunaa2z/vrAUhjY4Xts5XngzUOP83U2Fn4D/GIUW6i+A6dE3R
   xLZdUGYZ5i6taIH7YbkUN5IEAajRQ4GjR8CE6juuD+yt0WbkOcbaSQ75t
   BdvXfwNLUx4/C8/UVwKBJliMUVYGqMKeVbUTKbMAGWHJWtioAQP9yNG2k
   aC3ZxiJ1DTDCRgG2EW+0k46U/wk6B6zSb5qyNp95Nj5BgefeGvzGOz7GA
   2v/atpKXlrP6o4GIsTioEdfdCrsB+VIM0wVtRVMzwQnQM4HK9q7Q2vE3L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="115394395"
X-IronPort-AV: E=Sophos;i="6.07,160,1708354800"; 
   d="scan'208";a="115394395"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:47:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjI24CSmxCQTpovdimB/v/Ppvvw1WDMDZrUZeXCuTxTmUwi4uorKeGHV86XDt/hJ06wtDTaD57Tq2HOFnrdZaeHh7Xc/sKbx7xRjc8hzgjzgTkshMyPr9XfLA3pSwRcilpPz1rCqrf2Ii4CCRWpj7zI0Q0AKRvFvh0zUBnjlGhxVY6YC38Oj9ezET5rR3tgRVJS/ocl94sqKpaz+G+HH3qm/5+DEfLSQWZxW5YCImWiiPTiySAFzSsmdnjyf8Z5AViTsdOM2u2oCJy/Smfc72VFJ+y3xdvCb0dbkD/m+B/VuG4yCE2I6a7DxVIE2BChS+Dr0+5Aw5fCXHAo8loR8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQ573rW97l5ZpRMjk07I6lXhng7Mz7lx2yRCx3JA4Aw=;
 b=L/DdXoXRE3j+t0lJHxocY65Q26IRxGcwwXGaGs4sKI8NNd6D++zIAeJ+RFK9NrAOBl1iny+H8t/hlIq9c64b9dJxGoSxVpeWJ5NFDvMSHRv/fgA97XMGBF2XQJERH+TkGZ7GRp9w50bFU3stPBj7/J563kT2oQNOUAdpO29sLWiiuoinJYHyUwahoC4W+I4Ye+cnZfMdJOIinpqm/0NvHyMaRWRH59QxrCCS5xy0BRyGv0YS95cBanVo7eGTwhk+WchddQXWayCqRcyxVQG8jgmBPrCyCB8yjug7EBZGt+zU5dLJr3/178A7D7//SamqPNvQvXHke5NUUWmQetcM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB5757.jpnprd01.prod.outlook.com (2603:1096:400:46::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 01:47:03 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 01:47:03 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Thread-Topic: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Thread-Index: AQHadFPBx8nrp1zF/UK8IxmlbTRGybFKhXmAgACiphA=
Date: Thu, 28 Mar 2024 01:47:03 +0000
Message-ID:
 <OSAPR01MB7182912D196E74F55BE1A55FBA3B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
 <6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=b90f59c5-1030-4ab2-a67b-dc4b5044fa84;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-27T08:38:29Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB5757:EE_
x-ms-office365-filtering-correlation-id: a800fdda-e5a5-4542-e734-08dc4ec8f76d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x1kxwX+8rXVbLEI5LVTTmeazn44sbtyrdOBn7CyIK6p2cFRBv0OfPcVFCHW8jWK6awnFlupaDVOrBto7yoAe9fPOWrwxjLPNH6Ja4chNFXgBHeUQ86dOc5XQcj7Ssg5xR4wii11v3GqPEwKKNoNG+kj4nKlFtSlxhE6MWuQ6IHSfyMzWrYX8arkz7/QvyVS7PydoKMqgM91V7kupPN74h4UN4p7+yVWpkZt+o555RIN95qO2t1T4cMNy2bEWqp6UO6JHBpPmrpOXI168z70UzxORHKnMShtA22onxIFrK+nri/C0t7vm8SHrmnTLMWmGiP+icAGBic0dh3ZU8ev/Wr5BhHg7dv/ERCnXAZzQaKhOjwAv9cWIjGOcxG6o3jeWdLzgKF9N5Sc59GM/DtkMQHo6emw3LmVZ4cV4s+dbhBTRTnBiH7feyUljRCOvETnDu2h9C7fgkNN6KjetTzIkHS3HLm5XPWwqDjZiq0t2iQaw55z0w8QuzcnKJw8qZmY0iRGpFnOYVEWd14aUlqe1vwMuBPAwPNBeQq4abDuaK170ksOCc7wLnFKgKDRUJGIAinM87X0FqEI6K5TW3NC8tbHK2OBvO9miaxAoMUaZ5HyLcjj59BvVmiWbIXIppTXFrSJtZ5f1I2TUaY/69oUYsr+E0kQFgo6h9fPtuk3lJqHAUu2n7t5BYkBRXQ2hH8BxiEbGH/CoAY87qnW3JAGew4AW0hT6AxaaGCJx1pDgBH5cq8bQcqwaP4b0596kCl6p
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?YWFXZjRNb0d1MTd0cTl6cWZwd3pNUlh2MXoyUlpPVmZBYnZXWURhWC9v?=
 =?iso-2022-jp?B?NVNvQUN6S2dmUFBQVlVvKzVlZVRYSUk4cktYQXM1N05IQ1RFVlhsRjIx?=
 =?iso-2022-jp?B?OGJVU0hIRGh5TXBXV1NVdDN6OEl5STluWEI0OVhKM2dSREsrdXQvd245?=
 =?iso-2022-jp?B?elhNdXJWb0hwdlRTWEpXOFluQlloSVhVN3dCNzI3dHZiVldCa0tNbGpU?=
 =?iso-2022-jp?B?QzhxU0prWkJwMm8zd05kOW9zbmVHMk1zTVM0b3hqRlovTUJpUTg5TkNO?=
 =?iso-2022-jp?B?L1NxSE5pT2JpS2hDVVNHY1FnV01lN1VFQ3dWcmpFVTJMbzBpU2dPM1hy?=
 =?iso-2022-jp?B?enBWeG45L2VBNitwRjgwVlRHOGVKZ2s2Wm1VZ0IrSFZqVk9yRkJNeEdi?=
 =?iso-2022-jp?B?UjEwOTJBSm90MmtvMWVTRHk4amlsYzI3WGtvWStFMGlzb3NHaGVmeExW?=
 =?iso-2022-jp?B?ZHY2ZUxaenZCajVHcDkySmJmWCtYOWRoWlA4OHZCZ0dXODh6c0kyZTlj?=
 =?iso-2022-jp?B?aFNCZkhyVFJHUFArRXFuZUJrUGxCaGcyMHZWKzltbk41MUdZbWFNVUxi?=
 =?iso-2022-jp?B?UWt2U2RXTmJoUDRXbWE0dGZRK1FkUUxWVFlXS3M1TTIxYVlGdlRsL3k5?=
 =?iso-2022-jp?B?cDVDMUg0dDRBelV1d0Frdjl4SEJyTHVrWDBPV280bGRSNHpJV1NQY3Ev?=
 =?iso-2022-jp?B?Z0hlVUxRZG13UjJCNkFOeEhPbkhadzljUFZvV3BsSWVDenUwM3MrWlRJ?=
 =?iso-2022-jp?B?VUpHTlg4bkJWMXlGSGNOYno4Uks1NWowUWFKVDJqMERsMVMrWEFNSEl1?=
 =?iso-2022-jp?B?NFlvK1dVRWo5R2YwNG5wUmFrcGVHeVdaV1FMcXRodG1vVW9ZditCekc4?=
 =?iso-2022-jp?B?eVhPdjZuT2lVZ3Zkd1JJUUFBRzgrODcrRW1BVFcvUGdxMkh6ejRLZkY1?=
 =?iso-2022-jp?B?Z2RrSm93bTNCOW1mczNubE5zd2U0dmpKQWtRaDR1WFJqT0NrNWxSdkZu?=
 =?iso-2022-jp?B?dlUyWTRKR2RiMkluTCtEUm1UaTZZM3UzSVYyWXAyQ3ppQmJvcW9JWXQ1?=
 =?iso-2022-jp?B?c1hndHMyMmtJUTZPdTQzcXB6K3ZXUFJnRjVZbkQzQk10M2pFeHp5YkJV?=
 =?iso-2022-jp?B?YVMzV202cXVxMmVjRTh1dDBtbExLL2diMEtzbzdzQlVMMGJ3SFNuTDg2?=
 =?iso-2022-jp?B?cHJzS0U1bjdwVEhLbi96Mmt2YmZGTXJyY0V2R0Fja3MrNXV2bklIVHRu?=
 =?iso-2022-jp?B?c01YbFNPNDRIU3ROR0Zpa0xIS1NjMVZzejhnWUNsQVNFTWt0SGk2QnZ5?=
 =?iso-2022-jp?B?TGpRR0dzdHFWd2IrKytBa1dpSFh2SFRHUE8xKzI3cTVwK1kycTFhSDNM?=
 =?iso-2022-jp?B?VWRQVVlhV0s3Ti9KeFEwcGp5cHBhcnowaGZJRWF6ZFh2bUR0T0ZFcVlF?=
 =?iso-2022-jp?B?a093aHU4VHdxZmZKYUtXZW9aZUlGSERzWDRjYlRxdXQ5WmJZWnpDM1RB?=
 =?iso-2022-jp?B?WTY0ckZUc2hEV2syTVNTM1ErSi9KUGtPUDBrczJLeWdHcmlaRWFHVXpx?=
 =?iso-2022-jp?B?RVdMbHIzcnRXem0zTkRvVUE5Y25mVDNuNE5tNjAwL3ZOWnJta1Y4VU10?=
 =?iso-2022-jp?B?cUVHL0E5dGc1ZVNGc1BsOS80bUVmc2JrKy9CNlNmS0dCaTNnczJDV25n?=
 =?iso-2022-jp?B?a0xkdUxIVXVnUUYxeEVyRjdzMWJ5dWJrVVVya0k0VXlyQ1BCdXZNeWRl?=
 =?iso-2022-jp?B?NnF4S1RnbUNhRHhHVWlHYW83bUNySEtobUp0UjRVeWdVdGxGSEsxQklp?=
 =?iso-2022-jp?B?bDJyMDlpMW1RTkVnYzNnM2NnelQ2eElsOUFVQ29tOCs1Qnd4b1gvcUgv?=
 =?iso-2022-jp?B?dXIyZWhsTlJITGs1VW1QVEsrdkJIcWRtQ0VFL3l1RkJUV0wvMGNKR1FJ?=
 =?iso-2022-jp?B?OW00YmE1Y1dHN0FHVDF5N2lrSlZpN1NKWm1wSnVUQStKZEgyQnhEYXdr?=
 =?iso-2022-jp?B?V3hPcWc3TU5rb2Rac1lmc3dtQldJN1dUK2tJRjRTZUFhUDlFSVYrdkYr?=
 =?iso-2022-jp?B?dXA0akxSaDhuVnA2blRGTGpJakU1WXMzZVpzSFRhMFowaThONmJnTHRz?=
 =?iso-2022-jp?B?aG41SDA0QTVFZlZvOXArVkltYWdYRTJvK0prY2pZK3lkRVg4NnZyclV3?=
 =?iso-2022-jp?B?bjV1T2pEM1psSzZzcTV2MzdpQWxMQ3R0ak5MbzRpWmwyVUZkZ2JPY0JR?=
 =?iso-2022-jp?B?TTVsWkFRWXI4RzJxSlVYcklIK3VnSklqbHJpRGJNbzRuZlg0MHlxVXFq?=
 =?iso-2022-jp?B?VFV0emlnYklma3JCRElndXUrc0FxZnFtbnc9PQ==?=
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
	AtcOykPPX8+4LAaohpxstKV6bNpd21ZJ1vV8GkwioGmkf7CaCOo52zx8dYbCzYW/82L+TxKlREH1fvheVAbkXkiemjDxG9IES+ZRxbthCCMsnpnethnGm655FA+F3HoNmibLe/QSS6G48Ym2segZsVgNNYB0+dGw8Qitip/oZ0eaiyDNcf2ICadMmr0CogY+JpnKfUAfjWqr3sPpsEFAzx8bsgcZoxQd9hyUJYxmHRwpqOae97NafthhAXE3q1pwn40TSaXPW3TKOZ9c1G1B+fjI72fHIUUHnmx7I2Lea7bqW0AefB965/GOEM6AmIDUsKHt4rRCGSkliEDHknAt6ZwL5X/W2g9aWtFMS42g2EzO4fwON39ncLl3wUmQ4bWJQWoy4L3azFiOVWvrZ5HfIyPWH+BQS+RPWiNXRxnUGLYEQba8EOR/prsyZMMZxOabkviXdtyOXhpn2AVtKPMlAtBHdk/FDhBQ155E5FK8tYquw5pvwElsbiOCNQiy9+4mZtExTZRe5Zr8upQkEZUzAXQYpyidcK7wOP+zMPCje6dvVKDfL2sgaKnKpcSo15SgHreE1zwOVuwzqLNmCFCq5ReLbSzLkAM0RnVr7P92sg3RysypHRXAvrzltPTLqMYN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a800fdda-e5a5-4542-e734-08dc4ec8f76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 01:47:03.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOTp1HBqi9k1ST7FUHVZ6htQ/qQFHbeeIjOMyIBbVADOZxWPwAVyKdo63BL+KclJOcZc5a08z2plw3x63dWuRlJdGhyxneGtCAtjzwec47w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5757

Dan Williams wrote:
> Kobayashi,Daisuke wrote:
> > This patch implements a process to output the link status information
> > of the CXL1.1 device to sysfs. The values of the registers related to
> > the link status are outputted into three separate files.
> >
> > In CXL1.1, the link status of the device is included in the RCRB
> > mapped to the memory mapped register area. This function accesses the
> > address where the device's RCRB is mapped.
>=20
> Per the comments on the cover letter I would rewrite this as:
>=20
> ---
> In CXL1.1, the link status of the device is included in the RCRB mapped t=
o the
> memory mapped register area. Critically, that arrangement makes the link
> status and control registers invisible to existing PCI user tooling.
>=20
> Export those registers via sysfs with the expectation that PCI user tooli=
ng will
> alternatively look for these sysfs files when attempting to access these
> registers on CXL 1.1 endpoints.
> ---
>=20

This message will be updated in the next patch.
Thank you for your helpful feedback.

> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > ---
> >  drivers/cxl/pci.c | 193
> > ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 193 insertions(+)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
> > 4fd1f207c84e..8f66f80a7bdc 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -781,6 +781,195 @@ static int cxl_event_config(struct pci_host_bridg=
e
> *host_bridge,
> >  	return 0;
> >  }
> >
> > +static u8 cxl_rcrb_get_pcie_cap_offset(void __iomem *addr){
> > +	u8 offset;
> > +	u32 cap_hdr;
> > +
> > +	offset =3D readb(addr + PCI_CAPABILITY_LIST);
> > +	cap_hdr =3D readl(addr + offset);
> > +	while ((cap_hdr & 0x000000ff) !=3D PCI_CAP_ID_EXP) {
> > +		offset =3D (cap_hdr >> 8) & 0x000000ff;
> > +		if (offset =3D=3D 0) // End of capability list
> > +			return 0;
> > +		cap_hdr =3D readl(addr + offset);
> > +	}
> > +	return offset;
>=20
> The location is static, so there should be no need to lookup the location=
 every
> time the sysfs attribute is accessed. I also think the values are static =
unless the
> link is reset. So my expectation is that these register values can just b=
e read
> once and cached.
>=20
> Likely the best place to do this is inside __rcrb_to_component(). That ro=
utine
> already has the RCRB mapped and can be refactored to collect the the link
> status registers. Something like, rename __rcrb_to_component() to
> __rcrb_to_regs() and then have it fill in an updated cxl_rcrb_info():
>=20

Add processing to__rcrb_to_component() to change the implementation
to cache these values. As you say, I think these values are static,=20
so it's not efficient to access the RCRB every time you access the sysfs at=
tribute.

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h index
> 534e25e2f0a4..16c7472877b7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -651,7 +651,12 @@ cxl_find_dport_by_dev(struct cxl_port *port, const
> struct device *dport_dev)
>=20
>  struct cxl_rcrb_info {
>         resource_size_t base;
> +       resource_size_t component_reg;
> +       resource_size_t rcd_component_reg;
>         u16 aer_cap;
> +       u16 rcd_lnkctrl;
> +       u16 rcd_lnkstatus;
> +       u32 rcd_lnkcap;
>  };
>=20
>  /**
>=20
> > +
> > +}
> > +
> > +static u32 cxl_rcrb_to_linkcap(struct device *dev, resource_size_t
> > +rcrb) {
> > +	void __iomem *addr;
> > +	u8 offset;
> > +	u32 linkcap;
> > +
> > +	if (WARN_ON_ONCE(rcrb =3D=3D CXL_RESOURCE_NONE))
> > +		return 0;
>=20
> Why is this a WARN_ON_ONCE()? In other words the caller should know ahead
> of time whether it has a valid RCRB base or not.
>=20
> ...oh, I see this is copying cxl_rcrb_to_aer(). I think that
> WARN_ON_ONCE() in that function is bogus as well.
>=20
>=20

Yes, as you mentioned, I have copied cxl_rcrb_to_aer().
However, it seems to be an improper implementation.
In the next patch, I will modify the implementation to cache the value,=20
and consequently, this part of the code will be removed.

> > +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> > +		return 0;
>=20
> This is awkward because it may collide with usages of the RCRB, so that i=
s
> another reason to cache the values.
>=20
> > +
> > +	addr =3D ioremap(rcrb, SZ_4K);
> > +	if (!addr)
> > +		goto out;
> > +
> > +	offset =3D cxl_rcrb_get_pcie_cap_offset(addr);
> > +	if (offset)
> > +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
> > +	else
> > +		goto out;
> > +
> > +	linkcap =3D readl(addr + offset + PCI_EXP_LNKCAP);
> > +	iounmap(addr);
> > +out:
> > +	release_mem_region(rcrb, SZ_4K);
> > +
> > +	return linkcap;
> > +}
> > +
> > +static ssize_t rcd_link_cap_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf) {
> > +	struct cxl_port *port;
> > +	struct cxl_dport *dport;
> > +	struct device *parent =3D dev->parent;
> > +	struct pci_dev *parent_pdev =3D to_pci_dev(parent);
> > +	u32 linkcap;
> > +
> > +	port =3D cxl_pci_find_port(parent_pdev, &dport);
> > +	if (!port)
> > +		return -EINVAL;
> > +
> > +	linkcap =3D cxl_rcrb_to_linkcap(dev, dport->rcrb.base + SZ_4K);
> > +	return sysfs_emit(buf, "%x\n", linkcap);
>=20
> This and the other ones should be using "%#x\n" so that the format of the
> number base is included.
>=20

I will fix them. Thank you.

> > +}
> > +static DEVICE_ATTR_RO(rcd_link_cap);
> > +
> > +static u16 cxl_rcrb_to_linkctr(struct device *dev, resource_size_t
> > +rcrb) {
> > +	void __iomem *addr;
> > +	u8 offset;
> > +	u16 linkctrl;
> > +
> > +	if (WARN_ON_ONCE(rcrb =3D=3D CXL_RESOURCE_NONE))
> > +		return 0;
> > +
> > +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> > +		return 0;
>=20
> ...the other benefit of centralizing this code is that we do not end up w=
ith
> multiple copies of similar, but slightly different code.
>=20

Are you saying that caching values simplifies the show function?
Then I think you're right. I will change that the value should be cached
in the same way as the component register.

> > +
> > +	addr =3D ioremap(rcrb, SZ_4K);
> > +	if (!addr)
> > +		goto out;
> > +
> > +	offset =3D cxl_rcrb_get_pcie_cap_offset(addr);
> > +	if (offset)
> > +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
> > +	else
> > +		goto out;
> > +
> > +	linkctrl =3D readw(addr + offset + PCI_EXP_LNKCTL);
> > +	iounmap(addr);
> > +out:
> > +	release_mem_region(rcrb, SZ_4K);
> > +
> > +	return linkctrl;
> > +}
> > +
> > +static ssize_t rcd_link_ctrl_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf) {
> > +	struct cxl_port *port;
> > +	struct cxl_dport *dport;
> > +	struct device *parent =3D dev->parent;
> > +	struct pci_dev *parent_pdev =3D to_pci_dev(parent);
> > +	u16 linkctrl;
> > +
> > +	port =3D cxl_pci_find_port(parent_pdev, &dport);
> > +	if (!port)
> > +		return -EINVAL;
> > +
> > +
> > +	linkctrl =3D cxl_rcrb_to_linkctr(dev, dport->rcrb.base + SZ_4K);
> > +
> > +	return sysfs_emit(buf, "%x\n", linkctrl); } static
> > +DEVICE_ATTR_RO(rcd_link_ctrl);
> > +
> > +static u16 cxl_rcrb_to_linkstatus(struct device *dev, resource_size_t
> > +rcrb) {
> > +	void __iomem *addr;
> > +	u8 offset;
> > +	u16 linksta;
> > +
> > +	if (WARN_ON_ONCE(rcrb =3D=3D CXL_RESOURCE_NONE))
> > +		return 0;
> > +
> > +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> > +		return 0;
> > +
> > +	addr =3D ioremap(rcrb, SZ_4K);
> > +	if (!addr)
> > +		goto out;
> > +
> > +	offset =3D cxl_rcrb_get_pcie_cap_offset(addr);
> > +	if (offset)
> > +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
> > +	else
> > +		goto out;
> > +
> > +	linksta =3D readw(addr + offset + PCI_EXP_LNKSTA);
> > +	iounmap(addr);
> > +out:
> > +	release_mem_region(rcrb, SZ_4K);
> > +
> > +	return linksta;
> > +}
> > +
> > +static ssize_t rcd_link_status_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf) {
> > +	struct cxl_port *port;
> > +	struct cxl_dport *dport;
> > +	struct device *parent =3D dev->parent;
> > +	struct pci_dev *parent_pdev =3D to_pci_dev(parent);
> > +	u16 linkstatus;
> > +
> > +	port =3D cxl_pci_find_port(parent_pdev, &dport);
> > +	if (!port)
> > +		return -EINVAL;
> > +
> > +	linkstatus =3D cxl_rcrb_to_linkstatus(dev, dport->rcrb.base + SZ_4K);
> > +
> > +	return sysfs_emit(buf, "%x\n", linkstatus); } static
> > +DEVICE_ATTR_RO(rcd_link_status);
> > +
> > +static struct attribute *cxl_rcd_attrs[] =3D {
> > +		&dev_attr_rcd_link_cap.attr,
> > +		&dev_attr_rcd_link_ctrl.attr,
> > +		&dev_attr_rcd_link_status.attr,
> > +		NULL
> > +};
> > +
> > +static umode_t cxl_rcd_visible(struct kobject *kobj,
> > +					  struct attribute *a, int n)
> > +{
> > +	struct device *dev =3D kobj_to_dev(kobj);
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > +
> > +	if (is_cxl_restricted(pdev))
> > +		return a->mode;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct attribute_group cxl_rcd_group =3D {
> > +		.attrs =3D cxl_rcd_attrs,
> > +		.is_visible =3D cxl_rcd_visible,
> > +};
> > +
> > +__ATTRIBUTE_GROUPS(cxl_rcd);
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct
> > pci_device_id *id)  {
> >  	struct pci_host_bridge *host_bridge =3D
> > pci_find_host_bridge(pdev->bus); @@ -806,6 +995,9 @@ static int
> cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(mds))
> >  		return PTR_ERR(mds);
> >  	cxlds =3D &mds->cxlds;
> > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
> > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
> > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);
>=20
> No need to manually call device_create_file() when the attribute group is
> already registered below. I am surprised you did not get duplicate sysfs =
file
> warnings when registering these files twice.
>=20

Thank you for pointing it out. Remove these calls.

> >  	pci_set_drvdata(pdev, cxlds);
> >
> >  	cxlds->rcd =3D is_cxl_restricted(pdev); @@ -967,6 +1159,7 @@ static
> > struct pci_driver cxl_pci_driver =3D {
> >  	.err_handler		=3D &cxl_error_handlers,
> >  	.driver	=3D {
> >  		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
> > +		.dev_groups	=3D cxl_rcd_groups,
> >  	},
> >  };
> >
> > --
> > 2.43.0
> >
> >
>=20


