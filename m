Return-Path: <linux-pci+bounces-40205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58EC3130B
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 14:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4943A26C4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06DE2FF172;
	Tue,  4 Nov 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ulQGWR5o";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="w1fr/8sl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAE2FC037;
	Tue,  4 Nov 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262228; cv=fail; b=YBsiuQTa+B3G8uyCHSTZEXJ9JWT8BGzBydHN4PzneLgtceeqy+azzGVJ7g2NpyGs56fhyxgR6XQzHzEiNatvwt7tMzOwhuyvCShY7ZL3dxIOPXfdkZ6Qh3BZHQOmNCmVD1WIwWJGRzvAEQihc4ziMGHnmDJcg4gSqwReJGWEI/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262228; c=relaxed/simple;
	bh=ZOBBpqswuMRl1RWSyOF0Xal5BxXz3jERuGb6xiBhoGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J5tAJ9NaCiEOiDVpmZHoxh499aJtyBKa756K5TnFlrMrEL7dwkg5hc70X1AWkF8vsnDaKKOfTIdwYiIB0vVD7eIYm5LndlJy/wYERbvuFGz2888PbdjI3otgCVRuGZFrm4j4SvXeZ52RUptelHIBIKcvaOm4Z+FXZvJIbnI+sB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ulQGWR5o; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=w1fr/8sl; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A49Qqiw1663922;
	Tue, 4 Nov 2025 05:16:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=3T6nMPSeGnIMFC6pN6e7eQFmttaxtCycKizrSKCcM
	Xg=; b=ulQGWR5oAJnoLDcoP+IbcPZAyOHHgidaPTsN/SMBqg/KiejIFQgWv7gkS
	/o/4hZNHt/Tn1z4PMQOSov0WhYjv8RCNJ3YZL0epmYGFymWhyJsm1hyd3WgwfPhg
	Qr7SCa4J/CwpGuMvmu47DHE5j86WQxhBkCJmMbIhhdm9S11FeNDBT0Iw/vFqP5yY
	iZX9BVCwMgo0gVCXPH8ocRF9R2XxzhGqwdMylGuFAAkmownZmao59zjfAcZWz62j
	27S4GN/Bi+b2L2hYRqT3qFuaFnq9bRw2ry/+eF90vnWQC6BHu5+MHCZsqIh0sE3f
	fhrpvajreyEq7vVUnjj9Df8Vv9OoA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020118.outbound.protection.outlook.com [40.93.198.118])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a70ccje98-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 05:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lH7M9/9KqBYZ+G+8O39fBN/R+NjXKf/JRP3zTU6NxiY/wLSRUDvphsuePMGkkj71dSSD5bGlTWooOBwKZoSEneYfRvoLge/gGK9MN8t1+IraX9jqW8I1q2soSGJm/FDEK7Y7bIpHnd3wVVc8Utr0fybK2U6sJMulOQ26+r1hsh+n5S9zZPpyUJqFWlBt+QzxtaeYjgJbAUNCH9GwWglGa3CoKPTPn8H9SHcjga3VeaDfjTjJX3swiGIOwlVcfpDbAxRAF44FTXI7A+TD5uhJ+y289pNht8jzZSC+EMnEaEbj+yfp/i3olmUdrLnA/8dKUdz7thWD0wxrJKwRXIH0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T6nMPSeGnIMFC6pN6e7eQFmttaxtCycKizrSKCcMXg=;
 b=n4btkZZeFAuPCyWaRXl9WpsZWt0/5enZb/yspfSNaJFNCXL43NoGE6CTu5jDg9sgvSdlg+W9JpXwds4zrCnlY/el8Ax10c1i/CmU12gg/lV+1tjRkEpu+gBa0DNC3qIEDzCN1P5c1SO5Ba3SoTLa8nJwRrBvx27vTTQ/Ih40V1RsVfg+cW2joTHNVzMhnT+iEADYsAlw1ugILakzx5OH7w7mU0n992HXXIOKiIE9cx4PGbLl+twR+x9KBLij7BHAZmkLRuneK+7kkA5Luouwl42E+3eawlk278pHVUz9fBFLXArHAUqSfGVWbRGSdw7LU5xxmvRGdBD9SElqLbgY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T6nMPSeGnIMFC6pN6e7eQFmttaxtCycKizrSKCcMXg=;
 b=w1fr/8slpMUUK0dS4RvVrymZwnZYNagMLTaWNAAeyedJh89MP/Ny9sfalBRyW8wIjQvF6EjXV7rY0OnktHIhKtOnVGoXgCaXONRtyzpgkCTLThGipxGBAYCSfATiguq+byPnZK1u++jn5fQObHJpoDTAyXXuh7WIH5Szrxx/HjFIwCnaDoOYBIoyE5CgVivYVmy6V/fKHLpcAKIZRunhWrtyirWMbqyHxdk1zPVvh/I47Lu3m9+bi6o4SJ8LjlvwE4Kmsl+0cCoLo7e4qoNmnxcqWAuhTrIGPTCjo2ieFXNnn33fTieo9VTjvdlsXPPgSc2JWS7KG36U9lP6C/0bIg==
Received: from BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27)
 by BL3PR02MB8889.namprd02.prod.outlook.com (2603:10b6:208:3b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 13:16:56 +0000
Received: from BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a]) by BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:16:56 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "dakr@kernel.org" <dakr@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] driver core: Check drivers_autoprobe for all added
 devices
Thread-Topic: [PATCH v3] driver core: Check drivers_autoprobe for all added
 devices
Thread-Index: AQHcQ0yBkmhUGrxFW0CniTlztFj747Tik/CA
Date: Tue, 4 Nov 2025 13:16:56 +0000
Message-ID: <5DE9D002-5348-4510-B975-7B558DCD6A88@nutanix.com>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
 <20251022120740.2476482-1-vincent.liu@nutanix.com>
In-Reply-To: <20251022120740.2476482-1-vincent.liu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5016:EE_|BL3PR02MB8889:EE_
x-ms-office365-filtering-correlation-id: 546137ce-c985-4543-1be3-08de1ba46dbb
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FcKjS9c0i5XqfTd+MKLLeRsRFiEpBU77UWEQgUK+zlF/2Tu6NQCHTFivpeMc?=
 =?us-ascii?Q?1ED/1BgTMnWnFeCg7Zc1k3oAay4Gx2/YhkFosrxp8Yh6vvM+Hrvy90leAcBx?=
 =?us-ascii?Q?uE4rfWB2zCa5wkKDV2CjWs9LxDmRdxSHCotWJ+VnVzpCeOC96I0/L/QEIQCr?=
 =?us-ascii?Q?TYtVtXyuEAfhU3wDF+r0yz1t50JZBShEZT0Iqv4n+lvzRaU655C135m7RbjX?=
 =?us-ascii?Q?ur3KBeKkard2WLRW+RIVuQGPk04iCagSZpB83beybLgRYsudNboQ8yrvilxp?=
 =?us-ascii?Q?EcDGcCHYnCS0EtqnD/RPIZXBIIaCfkEpNXImOeOYHEjI8enxqXbY3NNOnYZk?=
 =?us-ascii?Q?KWWt44+jI4wBMhislxtrki5qiTbXxQHHgKeTf25U8Uksiv+ppRwfEkymSNWh?=
 =?us-ascii?Q?bjPmZXm+qYaz5wT1F9tpEt73AFFBv/HfU3MomEUbkWMM2OyD+91gptstPhwt?=
 =?us-ascii?Q?WwmB0SYPb8LJl12MdCPwhxFa0JL6Q5I4Om0oxZxrpjewhseBwd4xeJIyWMoN?=
 =?us-ascii?Q?RiObmL2IAjaM9GOm4VjX9Qo+0uwYS+yf+ebfVf474PS2dbVGoHMEXMAb+686?=
 =?us-ascii?Q?F0qHedFGxIrJ7ih3U2u5Edf08Xrq2tnE7hShFTRor/NZZw3y6Co6TK9dpkOK?=
 =?us-ascii?Q?nIoZHPfGNQYTcffG5aZmICppYEEivMz/6g7/MgRXtohn4+SA2o6PXjxVj7ys?=
 =?us-ascii?Q?+09crPplSYf3VlUBXpgia78TKyEnWwr6lkP9HJd9uu7H/KoWdenFA52Ix4E6?=
 =?us-ascii?Q?YMO7mOCDcHr1u19SpV3EMdq2pDUqEi4PKyhIC6de0knStFZ6yla6uXkCF1gT?=
 =?us-ascii?Q?S1EkqdDTAYZ4akuy72SGFxr32hAxFBFbkMF3bLWnZRuaS5Cnz9WuuVhdOvuQ?=
 =?us-ascii?Q?bBGE/1omHTfpguCtviFHXkgQT8RRsCrpo2qFsj8BL9IUxYeyElb+f91K7IAt?=
 =?us-ascii?Q?bQGjQdrHrTlAEcTu76WZKVzNRkpea0xuJfkr97X0bnyhTPIGijDS0s56sQCn?=
 =?us-ascii?Q?x51ntxauvbkcN7aI3cXqldhcykr4wgH/kGlO2mnY5byBJGBJKyCIp1G+rklN?=
 =?us-ascii?Q?7MvODm1ZYXGREqkqt4gP/RZVE0w1nVBav9ftjRq9ip58LPWShuC1C+ETbSx0?=
 =?us-ascii?Q?JFVVq5+pM8EuJXd3/+s+2UGPGJS6i49nzPR04Gb72NOeP5dk2y21C3+sm9nu?=
 =?us-ascii?Q?bH6pdi4GDeJ7yLtqCE+O1At36DNP9DekjyTY02hXtyxA4r/7fqpRRfU8AbUJ?=
 =?us-ascii?Q?+WM49sNpTj2PjUDBSs0mOSQQQh8tN+JL7Wya0o/giSaJIMttejOEyfRNXpW1?=
 =?us-ascii?Q?7jtIAUDnIXOiseZMujajeSy6RGoDTHjRpcfhADWggn+O8Xn486bOUjaaqP75?=
 =?us-ascii?Q?DNLFCHtkEM11HRnAe7IOWrN0QtaAQg9z8QgGzaYIRGy4TDTi05wEBy9H6hNs?=
 =?us-ascii?Q?63zcCSqSYUC/2VdjcArMzNLmWDALY0nblqs867jfgAC7JYc+kVZg8A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5016.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FgikjVWrjdEJSzdu1JrgS6o2riUWBOi1kMEe23VRZoppMe9CxzY8UHs3IWjH?=
 =?us-ascii?Q?l/URVx+tT0pNyy2uFmfW2VneKsQ8yY8wKbfnm8ZNcxyuU8LN/AoVpwREWwux?=
 =?us-ascii?Q?Wx3Bw2SDxYH6bjeYocStWoi17mwZQtiBg90b5Iy7gkwoGnOB1Zd/XeAgPP1r?=
 =?us-ascii?Q?MtPSJMoFhPSGPMjSKjKLLTjDpHvuVDWTfHJAbn7NEvsA5Viye1+m+ST9WibC?=
 =?us-ascii?Q?ZD+PFH/7Cf5IsLrfWiHa7dKbY8TeRZCM8chgIlAPwcO1kaKhJ3V4Eh6ULn1X?=
 =?us-ascii?Q?zt8Ef25DjSKf33HtoTgx8XbACHW0gnsel+KrzKbV///TYyRN3f2AWe5u48lh?=
 =?us-ascii?Q?MY1Lq5OUbeP2m94+Qh66DgDTIRUraAHanPZms+f/p43bF8GH6laBWrf4avNT?=
 =?us-ascii?Q?gBLf4irZl2ztzQNM1txmbtS19r5yKk5MAYNo/ej2pz+LkilU6tQ33ss4NmKs?=
 =?us-ascii?Q?u34uk2SayBu3sbI+0whNXqvKorTYqYROQQThTF32Rjo/g/E2pMJHHVW7IM/c?=
 =?us-ascii?Q?DaIPqFZtpIV/JvN5TILe3uDIsCkdAsbO4xkIjpZ6U3ajE3N04u2OcuBuPvfj?=
 =?us-ascii?Q?cN+LS+loifhLbPMArQ8dlqYaLNtgp6Q9FnSTRkvkR5LJIo1vNy1FOuXh0w4H?=
 =?us-ascii?Q?TL5HzMNnc1jMRVqg7MvmLatkgGSrIgOYT9S3ORL95GD5+YH3af1B7IcZNogr?=
 =?us-ascii?Q?jhuumBdxwd/ivk1vPIQd5SwljeoUmh3pt79SQDR11/Chi73j3sJbfFL8jtiV?=
 =?us-ascii?Q?JfnKXzlhx3O/4EMoV3eiTBK0kjcbPiteAyM04BBsmaKWTDJhpOFAxbREv/ec?=
 =?us-ascii?Q?rjdR1VnHWOMrupWi1PYhFcxyUD/LDPXH72KETVDiQb7K7J7NiQuZrMDe+N24?=
 =?us-ascii?Q?s8wl5yvqQ3GxVFa4pWu0pab3/F3HWS3EXmtdPRVssYeAtgAwLZT8dgC3ITDL?=
 =?us-ascii?Q?Wk70zWYk8mI2qQ/xmSnA4f0NIxj/jvEy8OyqWMVzs9yotxp6b2ydkKYfBAfY?=
 =?us-ascii?Q?sxX1ta+KsX7udSp4ADbZGJN+N/43Y8OFkFJUjJacvAPqrHaDqPNRRvxBgVAc?=
 =?us-ascii?Q?SM0hnX3yGY7Ox3+K018HOwQyrUYwcawx4/pa9nNlUEhlTXaus/i/jIq25vbe?=
 =?us-ascii?Q?Sc2qPf0zwSFll3LqHutO+8zyz6536gTPCnz9uU7C9MLEDJKh3aqSypDZxcIt?=
 =?us-ascii?Q?Vz3Ii2OICz5vSC8/VRwzu1mhYpvBOW8CcLJYI1vbJFVfPrkEyDRrXZI+AdlF?=
 =?us-ascii?Q?Thnxj5Fd1XFrQSIhRa9kLvVIlqzLU+Qe+zpxzOaBh0nRJy+optF9pnlpFp8C?=
 =?us-ascii?Q?vv0+VmaEJlhnXTIO4Zd9LelaWx2/6QBnzqBTK0qczE6zID4FfHEu9tRrdEa5?=
 =?us-ascii?Q?nwibD1k95Efu9UsjkRM4wkbPnEucARyLcix/mQhEAP3/Ln2WRbrLL+CAx/rR?=
 =?us-ascii?Q?8SpNkYWla6E5Ng/KMPyd1NDRJzFN1zGchVu1flhEsrBP4Cegzqd6Cx8riT1E?=
 =?us-ascii?Q?aXq0FLLyi5WFAolhlOMktOTSG603de33V+v/P0voO/ZXfnagEc2pFS1ZKQsL?=
 =?us-ascii?Q?p/zE/z/Lgs4t0ZgwspqUkDvN5vOn4iGA1Md2deV9PH3WveqCQRMT/5xR1PUx?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B719EAEF6AB7F5498BA4DCA4739D7A34@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5016.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546137ce-c985-4543-1be3-08de1ba46dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 13:16:56.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOngc5tzdzM9EQfh/qwknTcKZ9HkvJJB7JMJO6Z64ZAF/Hmtr/niSFwv7QRZxLOWNWmIetFtB7mNWQntHYc+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8889
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDExMCBTYWx0ZWRfXytgEYGByE+i+
 K6/QxGpZA03Q87b0jHHgZDZIIjm9Q9Z3EsSFltUgj3NxmMwKxuqw7tyM8G2vwB2QM9nRc/4MXp3
 7MfEik9FxNZ8H2dkbLooI2Vhc+OfP7TnikOCNKbNuvuAtOvkYFonid1GRGh0+71qRHubb3zpwCy
 cf4ivLP7zq1u1mXGbqhbYvBBSgTww7I0X1mROb94FFd2+rR5wlgQ/Gc/ssulCw57/dwWFRHjZRj
 drktUtToap5QOKaIKp7y9GH5hcQdTQAji921NDSs5rH1wqsDjPksbrOgvwp1JpnHQPK04qLmMa3
 sWARsU4ed2r/pjPi1nN+FMt1pkX6iqga0Lvm+SdSCsch2RJQact4raT9h5BBwW0T1tTFIAjVTVw
 R9gppccXEbP82OXU627lr29FeVmUVg==
X-Authority-Analysis: v=2.4 cv=C+TkCAP+ c=1 sm=1 tr=0 ts=6909fcca cx=c_pps
 a=LryC7IEqKcSdoWktnkYnkA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=ASD56r5LZhFdw999gYMA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 6y55XLyU73cxLKHeEUzNHc1JcoWXVG7d
X-Proofpoint-GUID: 6y55XLyU73cxLKHeEUzNHc1JcoWXVG7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

On 22 Oct 2025, at 13:07, Vincent Liu <vincent.liu@nutanix.com> wrote:
>=20
> When a device is hot-plugged, the drivers_autoprobe sysfs attribute is
> not checked (at least for PCI devices). This means that
> drivers_autoprobe is not working as intended, e.g. hot-plugged PCI
> devices will still be autoprobed and bound to drivers even with
> drivers_autoprobe disabled.
>=20
> The problem likely started when device_add() was removed from
> pci_bus_add_device() in commit 4f535093cf8f ("PCI: Put pci_dev in device
> tree as early as possible") which means that the check for
> drivers_autoprobe which used to happen in bus_probe_device() is no
> longer present (previously bus_add_device() calls bus_probe_device()).
> Conveniently, in commit 91703041697c ("PCI: Allow built-in drivers to
> use async initial probing") device_attach() was replaced with
> device_initial_probe() which faciliates this change to push the check
> for drivers_autoprobe into device_initial_probe().
>=20
> Make sure all devices check drivers_autoprobe by pushing the
> drivers_autoprobe check into device_initial_probe(). This will only
> affect devices on the PCI bus for now as device_initial_probe() is only
> called by pci_bus_add_device() and bus_probe_device(), but
> bus_probe_device() already checks for autoprobe, so callers of
> bus_probe_device() should not observe changes on autoprobing.
> Note also that pushing this check into device_initial_probe() rather
> than device_attach() makes it only affect automatic probing of
> drivers (e.g. when a device is hot-plugged), userspace can still choose
> to manually bind a driver by writing to drivers_probe sysfs attribute,
> even with autoprobe disabled.
>=20
> Any future callers of device_initial_probe() will respect the
> drivers_autoprobe sysfs attribute, which is the intended purpose of
> drivers_autoprobe.
>=20
> Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>
>=20
> Link: https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutani=
x.com
> ---
> v1->v2: Change commit subject to include driver core (no code change)
> https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com
> v2->v3: Updated commit message to use PCI and include history (no code ch=
ange)
> https://lore.kernel.org/20251013181459.517736-1-vincent.liu@nutanix.com/
> ---
> drivers/base/bus.c |  3 +--
> drivers/base/dd.c  | 10 +++++++++-
> 2 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 5e75e1bce551..320e155c6be7 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -533,8 +533,7 @@ void bus_probe_device(struct device *dev)
> if (!sp)
> return;
>=20
> - if (sp->drivers_autoprobe)
> - device_initial_probe(dev);
> + device_initial_probe(dev);
>=20
> mutex_lock(&sp->mutex);
> list_for_each_entry(sif, &sp->interfaces, node)
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 13ab98e033ea..37fc57e44e54 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1077,7 +1077,15 @@ EXPORT_SYMBOL_GPL(device_attach);
>=20
> void device_initial_probe(struct device *dev)
> {
> - __device_attach(dev, true);
> + struct subsys_private *sp =3D bus_to_subsys(dev->bus);
> +
> + if (!sp)
> + return;
> +
> + if (sp->drivers_autoprobe)
> + __device_attach(dev, true);
> +
> + subsys_put(sp);
> }
>=20
> /*
> --=20
> 2.43.7
>=20

Any further comments regarding this new commit message?

Thanks,
Vincent=

