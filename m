Return-Path: <linux-pci+bounces-5230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4988D916
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD444296F93
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445C832182;
	Wed, 27 Mar 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZTihj3Bw"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034633995;
	Wed, 27 Mar 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528011; cv=fail; b=Paw7DpPKNorJSP0a1stOXmlMsWIaMLm3x28u++/kjOpoH+dK7MN9ud6O26+U12/10aSVYifH+C/IZcL+0Qe6Un6vCEN5LsHRzVUZDGIB+9um08b4Xsc3Ut48VyR1HOyBRbpX6vg0bb8LjzRR8RvFDQMBQg42SSxOK1SxVbRcnds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528011; c=relaxed/simple;
	bh=81/Ey7MvaZmJpU6zAWBZBFe53I8d4j9qmw2ZYDu6dCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cvhcVJuK9sbMrmjLgZ6CnJnFyyJgHOwL5xD7TMLJSg1Gb5aNr03alYCTu7xkZ/QDC8nf3sevq+x2QqYls2Prks+JzTRvdUGEk6LZks9jU9Nq/SRx3z4Kj3R3lhXiMsKhvENP1is6/LaoydGCIdmGq+0unyRv2JpmQy+imLCn4q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZTihj3Bw; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711528008; x=1743064008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=81/Ey7MvaZmJpU6zAWBZBFe53I8d4j9qmw2ZYDu6dCM=;
  b=ZTihj3BwPu4PhJ88Q6G0NhL4/hZx7dmODkH3LWwatlkisvIox4IKrr1I
   hAePI9pUxBcitXkZq+Q5PPgx7LMGjEAJzvbjLixJcuMLgR1AsbOg+TPmB
   QvGwSkyNy4TQNX5FToOeqJY03DMM52CZjx/U+d4sdpaf7WpEK21Y8Ixw8
   cLlZQZqZUz30q6XYox6JRJDyuHyaDpwWILVcv6zUwU+hhSvEFrnNS//qx
   hrgUPoXX/1C2VoggTqdbiuQ0gt/LNPy8J9d0k55Vyfd4v4d2Bd8TbcofH
   L1Mq2MWRxxdhAdnisffJqEK8Jq8TuVmZUjJyJwAD48OVCqnEyMq4KAxO4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="26238182"
X-IronPort-AV: E=Sophos;i="6.07,158,1708354800"; 
   d="scan'208";a="26238182"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:26:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlPvOSXZqNoxwjfE64GZho1S/+i3JWj/2tm0eIV0zdKE+7+Bg3b4OC0bJdED9JATJ8u1Zg6Oc7FocLy5YV3BPcZB6do/sQmLQTP8zDusawSBTMPwFa1s5L4HhPVpeQnm/OLTrUjQEtdnH01/HyPJq/7VUgswFm1Ay4jQDSNGuzZuItkGzRRVfbXwajj2eKkAWh9Nt7SRQ/DZsiM5ZsNbeA0KfZ9BNngRbE4ERPsGNNEzRvxindCjla1Nt0GCSgA6hdKj4sMVzuivg/HLMY5nEe1Kp/rpRMnR4WLTO8W8WwXkZ6yz9EDwAE1dmvTjYlKm+0EfGTtRJt6b5ECuNTppaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81/Ey7MvaZmJpU6zAWBZBFe53I8d4j9qmw2ZYDu6dCM=;
 b=aK2ciqafkXs55veBFR42L7ILLC2sSDaYy3kFDDEXk5ute17ip4M8zaAIs1uQ/zGiHn6aY/XOr5JezqKryO5Zkw5xoSVRdlYJf4FkVkrFg6nlFf+dXKy4wjzjMlREl/zGM/FTLosz9xM0exMns4RvsNUyapMioitH/DY6ans48w4hHEFE6N2DzsGo0bu0K8NjqHGvI4ftibvEO/siuPOtH0U/KKjUA1eQ3dcW/9hLigcobbIeK7/PsGs7VDFCuj7QNYFtk0T+Zh04lCNirSKBpJSdUXgHFBbdp82FT4YvKWY57U6RbTLmUVS+EDwt81wAxx75GpyK5HneN0QTeLWD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSRPR01MB11617.jpnprd01.prod.outlook.com (2603:1096:604:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 08:26:36 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 08:26:36 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 2/3] Remove conditional branch that is not suitable for
 cxl1.1 devices
Thread-Topic: [PATCH v3 2/3] Remove conditional branch that is not suitable
 for cxl1.1 devices
Thread-Index: AQHadFPDgcRkKifIoEOYRNBVq13j4LFKh+6AgACaiZA=
Date: Wed, 27 Mar 2024 08:26:35 +0000
Message-ID:
 <OSAPR01MB718259250AAEDF0013E83597BA342@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-3-kobayashi.da-06@fujitsu.com>
 <6603296f71d1f_4a98a294a2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <6603296f71d1f_4a98a294a2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=cfcc6543-a152-4f5c-a604-a0a1fdb3f8ab;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-27T08:26:27Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSRPR01MB11617:EE_
x-ms-office365-filtering-correlation-id: 417359d0-47dc-4802-a15a-08dc4e379deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jLns6MFb0rHbXMbkl8CkVLiXL2ZeaSR23mipPzvmDnbiX8I+Vo21DuQFSaG4IaZXLpItVQpQirsE/Xc7ruEhFvVd2FGiXGYPQ4hqOQa3bqv6FHcakDcDvslLS5GJiDxZdfc/k3r9vOtmkZsBsHXK5FciQ1wYCdmt3Y9b9Tap8NFQz6NlN+x9SUTN96atKkG9RpsMqOY59Hbkf72CJG0GMY82YIQbfLenQJad0WWMgtLeavy1Rp9FoqhM2eykFo+6W4LWbl+T/cFx+IHgRIOV24w8xhTEN/Z1ZAdgHM7gce4uukR1SGPd2C19j0FEjMBb5WTRIGgvdbcyCeh+NQM6LS/Fs53lqbGlaHcuZA68g956uCYSfQHavk+++x45t7F/y1U52PoGTmFU5kPerCIeO4ulNroGHREq+y8XvkR7WrIabUJ7Tv3/9csQrCEtOqS4W8DVh5yxK1gYlxvQZJNC4ZvfN7ZVDLI6+fQzMjGCDkxLatEe7Mc+CjiuVj+pIzc7E0SB/2e2EI/V3qr7t0NWoJMSo74uQ+mJGtPTCORjcz+W8lwCWwz/U31HoaGk/tDCFwoiZCF2fptNw8TB5bVsWZnOJhMs//zC5VxvTOnsNzusSPV6tgFtIz0qmVSAYDmEAceHPTIZMKhlRB2XPe2aRja623PLWoX+Th7CCBOI/nuuq7NzhdoTrsLbqDQXuhOJ9ayRdp5HSdW3ob1gSv8gSkNZfWYaNTiEwSXXtkwWPAfTW22lPhb9LJ7OuNShb1JK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aFkremJCZ0JHeHN4RC9QR081YjlTeU9kVmEvNnJJK2UvM0I5QkRHVUFL?=
 =?iso-2022-jp?B?UStGbVgzVWsyYnNIM2hGb1c5blJCN1F6QlVVdlQrcThJOXoyMXNYYnIv?=
 =?iso-2022-jp?B?VXhZZk1BUURKN2dSek5MeVpmU2ZrTWttOCtacm1HeUVJdk8yVkxSRlFm?=
 =?iso-2022-jp?B?N0xzcWhsVHVabXVZU2pEY1NwNjBpYUN3empXUHBKWDVKYldzYWJjQUR1?=
 =?iso-2022-jp?B?QWZWMzRHbFUrZit6Q1puMXJvMTJBdTF5dUV0WWdSMVdOUWRML0xoSnNm?=
 =?iso-2022-jp?B?bFFoZXVaMTJBYTZ1VG5FWCtsRzFUOUlOZlFvUG1qTzZESjB1MXhwTmhP?=
 =?iso-2022-jp?B?WEJqd3ZTbkppR04rb3E3VkhQTktYL0NkSS8rdDQyY0RLMmVnK25FSExo?=
 =?iso-2022-jp?B?by9RTTcvK2xiUVRnZzhKckJkMGxCUzJoSkdtdHdpclJGR2N3Wk9BVlIx?=
 =?iso-2022-jp?B?ZUxKZzAreWNIRVEzV00wZ2Y5Z0M3S2xHMTREOSs1NjhkOHpuOWxPZDBF?=
 =?iso-2022-jp?B?QzZRWlJGOXZ0R3hPT0pJUHVaczdId0tsQ3FmL2FjY2pNZG50aUExWU9M?=
 =?iso-2022-jp?B?Y1grQzVHL2VuTjE2dVBGcmFEby96Smp4VWE5SjFNbkFkWFFQYjhZM0Ev?=
 =?iso-2022-jp?B?NWdyV1FmelRoVlZuVE4yR3lJR1lBenhuczMxQjh4b3R1cGlFallxWStp?=
 =?iso-2022-jp?B?V3RobkxSYVdNMDJTY3RKQk9SSG9EN3VxOWZXbmZ6akt3UVhoSDR5dU1L?=
 =?iso-2022-jp?B?WFpoYjNBdkpOb2RLNm5GYlJWKzdiUFI5K2luV1RrdWNRbzRZWlhhR2dp?=
 =?iso-2022-jp?B?U3hYUXJBSmJxbW9pSC80Y0VLUW1JRmpiNk5nNWJ5aGxRRDhYKzhCN3A1?=
 =?iso-2022-jp?B?Z3gwTDdxSml1dXhjNXMzbFE0M0JPM3U5WkhSOGJBMlFvME91dmtuZERL?=
 =?iso-2022-jp?B?ZTBieXVFVEw1ZEhtOGZucEJ5MDVsQXQydWJTUklzNnJ4UXZMMzNQbEtW?=
 =?iso-2022-jp?B?VVV5OUJzOGpKdEkvZ01yL1VreVVlbFluWnlka2RsMUsrYjZNMkp4LzlK?=
 =?iso-2022-jp?B?VmI5ZTk5UE1yeWE5NDhiUDRFMlM0MWFUdklwZTJuZGcwUFN0eTFxYlJi?=
 =?iso-2022-jp?B?Q1NFcU5zRGJMQ3A5c3RaQTNXVFBQOTFlZVQzSUVnelJ4SXkvYWZjQXpL?=
 =?iso-2022-jp?B?Y2VFZXByWldZRnNZanhHeWwwNUZEYkcydzlTa1dtL3ZxRHVKeTVKdWhQ?=
 =?iso-2022-jp?B?eml4TzUwd3JOL05jakpLWFAvWEhwaTZua2g2emc4eVlpV2pDdVZyYk4z?=
 =?iso-2022-jp?B?YzhwdWlyTnhjOElJekpINS9WNGFBVVlyRXdhMGZrdEpaZktnNjMxMWhi?=
 =?iso-2022-jp?B?RTNjNVhHZlNOa0VvVC83T0tXeTR3MkF4TFIvNjNuSDlCbGRLVHUxck9K?=
 =?iso-2022-jp?B?MlJIUmJPUVNpMldDRU55SFRuY0F0RXROcVBKN3VmNVVmSGo1MGwxbERr?=
 =?iso-2022-jp?B?Q2tRNzBuWm45U3JyTFBmbjd5UzVqYklYZHJwZzZtRjN5RkZLWWw4N2VE?=
 =?iso-2022-jp?B?ZHdzZytzVysyUU5HWTNYTC9zWUwyZFNmWFNwV3EvTGlnVnJFRlZTaUpt?=
 =?iso-2022-jp?B?R21MVEwya0Y2aHRIL3dJZHFJSS9KRVBSZ3RIYXBJV0lXR21BOHIxaDBU?=
 =?iso-2022-jp?B?Zk9vYlZpdzZzWWlCMFB3VU5DSHMxdWR2TDNVckZ3SnIyaEZmUC81djBv?=
 =?iso-2022-jp?B?c0Y1bVZsZjNsdkUxYnpVdU5aaUVidHdJMkZxNndnazlVZ3NqL09pUUFH?=
 =?iso-2022-jp?B?ZjhWd1lvbndpUXJ2ZUh3alAzdGp6SHZadTlXRkEvYW96NHpFQmphcWFl?=
 =?iso-2022-jp?B?eHY4UVNNR2JJb2Q2aUFuRXh1UjZ5U1BHQTJGczdUY04xRVNPUGdJQzhl?=
 =?iso-2022-jp?B?RzJBM21MczdDR2dxZ2FUeFNIeDhhV1NkWWh3ejdmZXIyV0dwa2xEb1Nx?=
 =?iso-2022-jp?B?bSthRFBmYUlEM3REb0Iydk1ORFhFMUF3T3l4L2drVFBWck9lNmI5OHdl?=
 =?iso-2022-jp?B?YTFWMkpGTXZ3S3ZSYlRFci9SSnhXMU0yZzM1a1NpV1VQdktoVDhaaytM?=
 =?iso-2022-jp?B?aVNvUFZnOTNuSzBWSDhmdnpBS1ArMWNjUDhVVUhFbGpUQWY0Q3Q2MndF?=
 =?iso-2022-jp?B?Nk9NdjFWU3NoOUNZRDA1c2pjbDhZSWJienlqVzZiZkUxY1ZaM3JQWDhT?=
 =?iso-2022-jp?B?dkFGM0dGTkt6d282Vk9zTkplaTN0SE5EaExORzZCcy9tVFRuMTVUTjR6?=
 =?iso-2022-jp?B?WGwvUG9MaHU2ZEtWOU1iUnNRR2xkRmxNcmc9PQ==?=
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
	5CnQ8EiWSccC0o8eJ5khod+n0zqRqrqRWT7fuZbzF+lhSQ5uifcDDEluvAoQhKcXK01Yxi25qGjMPEqG6c99Xd1GldZtRInNFBA5kFvQx7aiM+C1CyXJiMqe3ZO7IVIdOD7L1DFhl+rGG8F6j5dmkh1K8RiAlDc5LCxzqta0ORVjfAWG+mMgm+OzlGy+C+qkGg4G5hbLYFWV1733/6+PgZnLuIEhCn40h3AvRNHSaKjYinnZQhtC74OiWjdLsF7xHEOKQu17sOM8+hVtIJ2vG/FuA5pr+2BDy148wLmXgwqDipB8PpTFsZ41PWnPA4xUfZLEXXqb50dTl8vARAP2cKhR3Dx3eox17Nis7z5i6wy83JykGkU95pPm0nd1qNgi3oe8SZBLnB+xRYgzif3PndX9kjeiKf/EU8Kk1INq/lTGZz3eyCZeptZrNq6ruw+sq41pGNE74Ma6JPjS//m2ZWTMtf8CaQ1spioEsABF0NSA/W9FUMkwPUMPFv/Ng/Zdqg47G1GO0REvgyU5gwrf9XzkE9nbelRdiFQhb99uSBgsHE/UYzua81pImoXLrSHllkH4IpWH7Zzy6+ht8yR0mqmWAmIpC4KPxf0Y8LUsTaIrr+YRRkph5DVjBl/MPqCY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417359d0-47dc-4802-a15a-08dc4e379deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 08:26:35.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMRdwtnDnVbRKvBNNcH2GTINd/hFJSttlJzHMCPFSswHTBMxUyXEawlQOuVsiofnUnvoHarGWma7FntGOptDnsjLJ08mdXrvaba1rEOyHZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11617


Dan Williams wrote:
> Kobayashi,Daisuke wrote:
> > This patch removes conditional branching that does not comply with the
> specifications.
> >
> > In the existing code, there is a conditional branch that compares
> "chbs->length"
> > with "CXL_RCRB_SIZE". However, according to the specifications,
> "chbs->length"
> > indicates the length of the CHBS structure in the cedt, not the size
> > of the configuration space. Therefore, since this condition does not
> > comply with the specifications(cxl3.0 specification 9.17.1), remove it.
>=20
> No, in Table 9-21 in CXL 3.1:
>=20
> Base: If CXL Version =3D 0000 0000h, this represents the base address of =
the
> RCH Downstream Port RCRB
>=20
> Length: If CXL Version =3D 0000 0000h, this field must be set to 8 KB
> (2000h)
>=20
> The size of the CHBS structure is always much less than 8KB.

Thank you for your feedback.=20
After revisiting the specifications, I realized that my understanding was i=
ncorrect.=20
Therefore, in the next patch, I will revert this change.

