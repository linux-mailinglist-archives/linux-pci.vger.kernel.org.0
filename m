Return-Path: <linux-pci+bounces-26720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC69A9BCB8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 04:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CC13B5CB9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00842AA5;
	Fri, 25 Apr 2025 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="nhu/zic/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QZAJjKWe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7A43AA8;
	Fri, 25 Apr 2025 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547494; cv=fail; b=ikk0R9UXH/rGa5h+VzNiPAp87hGLInHC1z6+2yIJtmtsX9piwGPnRYsp/areILgxFb71Q9yZiWH2g++pW2ApYp/fcB3tSpEUqXxVstfyDiW1bCETfT+yuo2YKhiIvHk+bwPj4v1qAOWbFt8Fl58F52EmZjNLGdmsF0BLj2xViDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547494; c=relaxed/simple;
	bh=qOkuomCmUnMKCnv8Yxgh5m67EQa2n84PqczG9K9hFKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WePpp1QO+NIUqgmdKaf7OClSDd78OPvfhYSl6Hy2s9m9Uc1lRahWAn+2lgJus0+tYFAyF9j0ZRsMdWva7IBCxQfinLyRBlLovTeS0h5f83pI2Y8LWmraTu5QbEfp/gMcG/mOyERzeUkHzphvdIKrCemqjsBNBAeAM7l1zs3zAdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=nhu/zic/; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=QZAJjKWe; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OHa6pB023620;
	Thu, 24 Apr 2025 19:17:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=h7GXHGzqKkryVFGO9/uvCDCd6gBXwnGIdt6SaIr+eDI=; b=nhu/zic/Zlqy
	cYPcT0HwSVTVbgcEMyXWvdT0VNt9NZfrmDIyQAbnf4PJ1WeBQiuUOkiDjD4qqaH4
	U6i1ygiCqaXr3MnaSeJ8DUID89E6vDR1mh7l1chuuMU3VZAMxGqWcis+n6/CbZc4
	FL3N5UTzCf9YScoy2+ov0cSu73TAr4ptBZNPE+omCBeRoE5KDyBx3R/2dxFXXUi6
	ppOIIXzvRDeG+XPC9kpvcCKTFsQkLENsdNEWFkLLHv+am3t+VhYN4rcDk1Wgkog/
	YZ/x0AvTLR67JoVEGbMCMjWw4A7Mam1NJJ1wZVGycjl0nKuefhC7hNBz0VqqWonZ
	oG4k4qijSw==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 466jjyu33n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 19:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLXNGyY29HT7Em82RdMyr7OfI9MipQIG9RN+o8qWnyAZRxJKdCGERlwWwBmiGatKuzBm+Xoh0QwuwnA7JMmC8jEStl61I332Ce61+w2AZWX/n21013og6ELJqec1DXHoY4lljqDRjbb0Kxoor6b/xiULKxGL/na4aKYHA1fqs1/sgkl6xIbD4OQT7Wz8ta/5fig+DH7GPxPswoqrHFGl3yZA4frqg3ljrvN3NLcdcf5vVT2XV1cGm+HBQnubuXbQDL2pOj26F+YOTjtiFdPEaWG1+VhIblQ6hqVE//TvvRGxJTkpxc9MD9ax/zvYtIkm/TvgL6AHnSHJ6RZJ8rwQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7GXHGzqKkryVFGO9/uvCDCd6gBXwnGIdt6SaIr+eDI=;
 b=SQGMBZzg0EuggStOYdy2t30sUx2zSywuq3G8t93dqIyWN11qDMYyM8+agy2bVi++2BV2m17ACqhvhKCqvcjEUyvNzfblCkHF83QysEGjrxrMH5xAD8QpvD2YWrQcWxYZjzqtvw4iB5IejBvjKf6w3ZYpObtqvqAsKedMEhrWay5nH1VUT7ZQH6qwUsarujCNirO7xF4meD+0rOJGxOySHaRRxDCUXz6ImebagEzshEE3a0WoSfVfDJ8MO50b1ZaTLEq6Zg1gvmAdAkcTh3dpw4IvTJOAJZZ31pMRpacZYuy3HV/QuXontqUbTIFy0AvPore21kkdA+NUh58Las41iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7GXHGzqKkryVFGO9/uvCDCd6gBXwnGIdt6SaIr+eDI=;
 b=QZAJjKWeiXotLwvm7lqOEB1tV8+vIfRXQTD4aHu1cQSdrJO1K/AR/P4Cvih2X9NqQmvc+s1U7tvrXnOIXrIh6XTtlm1TAXD6ijGtNwt0gJDGZIPKnCWFEHnzxXOC78oQsquSWNifkQzBLS4oR2cYK5hyZ23lEmdmJ0VXlXlfGog=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by BN0PR07MB8973.namprd07.prod.outlook.com
 (2603:10b6:408:154::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 02:17:42 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 02:17:41 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Conor Dooley <conor@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
Thread-Topic: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
Thread-Index: AQHbtLTnbnpkizAVsUaczHiSHbV2I7Oy8fOAgAC0KxA=
Date: Fri, 25 Apr 2025 02:17:41 +0000
Message-ID:
 <CH2PPF4D26F8E1C8414FE9CB9B9CC32F41EA2842@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-3-hans.zhang@cixtech.com>
 <20250424-elm-magma-b791798477ab@spud>
In-Reply-To: <20250424-elm-magma-b791798477ab@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|BN0PR07MB8973:EE_
x-ms-office365-filtering-correlation-id: 5bffc197-6fda-49cf-2a2d-08dd839f5bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UQSpY/bwHM9yu8Ew+FBSxaxbWI8/rdWz29T9uZEk2q25hnprp9ttDEip1hBF?=
 =?us-ascii?Q?gN4AJ8+w+R+Z/Mo9fH4/qM4g/1JogepPf70Bd6VptNGjw0XaGS7y+x6qum9B?=
 =?us-ascii?Q?DzGGXNKHrNNPbW2CERlWM1qKOt6FpvpNvtd84IF43HaafWnk/YHGaZ3dZhNx?=
 =?us-ascii?Q?dyiTAklHqxikujTfyK+p+qmgF3gbia+ucQ0/KhIFdXqmieZnx02NcNn338mY?=
 =?us-ascii?Q?b24qQPc9dXzEa4ZAesGVoSeEPWwfBUQJ984mJrj8TsBUU+P60Q3jYUchqeDO?=
 =?us-ascii?Q?1BoaumXtIlX05sRU1BHWxbXrqGJG5r1UWJutcGq6MRHPi7xqmcoeMx9Hfgir?=
 =?us-ascii?Q?TUUnzKdhNpDH8Aotp1HnYs7KS9+mmCb41rmOhcyjtdoakI2J7YDj7/39Dpq/?=
 =?us-ascii?Q?AaIXVgNNeDjTRqBkdSGe49a2B88+MFW9oFG9OLNrFIz9liMNChydNHuHcsPx?=
 =?us-ascii?Q?elaCHJP05G6pJ71o221WOj1OlwTiu+KgEddjtJuGELhc1kHHehVTk+fOqZ0T?=
 =?us-ascii?Q?7rCDLqQ9zNv5Ry+Zh38SaGj/8CRI09x3LMaoFG9YAxymHZ6tY2j0miYk6Hs+?=
 =?us-ascii?Q?YKi/SL0YymbdKWxjoJQS8Y7Upx7YKEwh/3fY+zRaXv04ZnVElRJ/YtQ5Et7Z?=
 =?us-ascii?Q?n+G+lYiAVRqdn5fW7oFrhVh3uwg9nScd9mQ7zN0TmbIVRkXCx3hjo/xVcvOv?=
 =?us-ascii?Q?5KPSTEQZWtZEVtZuS34SdBZS2F4eg82pgEpYevIuQ9Yz66AUAZhsKR4b+xDx?=
 =?us-ascii?Q?Omn4yYCl8/XQIBADgZHYOlEQ5PnxnBhod5B7Wkgw952YKjexn8fmDeqFZLhR?=
 =?us-ascii?Q?1kcuASvJkVFJSneBl55a6u5dkZAwxcUFbGPuLqm/PIK2CcifDsgN/Kx4AL3s?=
 =?us-ascii?Q?06gPdKGTowgydRa/VdZp3tHbA534CmQ/EgNQ5xYcUDsqRmFkerglsjFG5sGH?=
 =?us-ascii?Q?Lw5HhcgRlZ5yZ+NKtW1Kqm3V58HgXLCZ/nyAd3GA09M485wvXi7dEN3MwvHz?=
 =?us-ascii?Q?Sz6D8HY+CahRyy4ePfUD4ItSGq7SpbKQIFCMBvPhm8NvP5fmkek79KbceWQd?=
 =?us-ascii?Q?m3rKsO4CMO+hRvf+81n1s17+T9+sfOYQs5qbbYSj+zB6Cin62/sC5hkZt6td?=
 =?us-ascii?Q?EIm2fEQZ6dX4wG2wmvsmCqpJfmpv6Vtz3gWw0ZoPLborQJlTv5tM+N2TtTa3?=
 =?us-ascii?Q?Ux0ZgMX5fsBGy66J/3+RtB4R0uQwFE/qfXwBvDbcDAdGN1OdPViINQ6RPn17?=
 =?us-ascii?Q?cMHwkbc+Nsp82l7E5BPIsgVW/tLMpnkkSs7RzyTJfM/2dubqahHU6S5Dwz/k?=
 =?us-ascii?Q?1RnYY2YfpVEvna7WfvbEG5HIrKipd9WHwjCklEIpdC7IPbssmYXWKhvlpK55?=
 =?us-ascii?Q?XWqFLeM1byT4VYv9o5c1Q6d5fqit007b/WRdRKdRW8ZbUnFSJZEcPSwE23ni?=
 =?us-ascii?Q?jzPd50hXqX8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pnz0meAvvKMDHkOJ3XNZYTGmuFmfjQvZDRDotPK+NzkTIcW34pWq9lxr286P?=
 =?us-ascii?Q?Z2IsKVc8ZTGiBPT5g3X6ml/J5319/wO7laJkf+0PKcfJEPFu2brESOdcfhpE?=
 =?us-ascii?Q?b7EJEGlQnPlwSa/P6b5WMCCgy19ny1TFT6uBvA9lCRZFiUbpcwFn8ONR2yct?=
 =?us-ascii?Q?I9Cx2rQG3qktP3XHacjOeEW2BS4U3R+rGvxyASjVNQe34TD/KcjCnY3+qYCs?=
 =?us-ascii?Q?1R35FGxmDoHQGNM1yti5qz98T2RnNWvAkRNt/ptXJvKPWFUAzpleq34VaMIa?=
 =?us-ascii?Q?AmFGUYGDQfzk+Weqs0FJ43rHeXitGYx3H6hcyLGIiKcqcLkwlNltQomGwuzA?=
 =?us-ascii?Q?Z9BGKsBrK76TQ3Afcu1oaza86I3HvQrZrJjxBvW1Al7Z2zBIqi9ikVVodo2z?=
 =?us-ascii?Q?BpqMDaKi9QGiHESTsTFRl4HfQuDLhsxkcV2CjEgyZqlmO+eArQHbKyVTmvqr?=
 =?us-ascii?Q?NtzGREs3Jze8J7yfAhbf1JkFSOhngHx+D51Lb2wLWU8OaJZ2/J0ibWWpJk+d?=
 =?us-ascii?Q?NkvBJSxMdTHOSMq/SfRgRMJZxLLba5oqzNaPM5D1hYkpz2uK2bymSa3mRTdd?=
 =?us-ascii?Q?MxIOk++h5IhzVrWZmnVhbXYhzNs4Ko+p1MGcCWYkLKDOuGTinfo0VkBGKBcq?=
 =?us-ascii?Q?DwJ6qGidjF4O5VeQQFxcKFr+FiVS2PX7cVgWhx1wIME9o5daR0bEP7/wxKV+?=
 =?us-ascii?Q?k3CrDtQsuwygjLPe5iEDjL0E6GTsWyqDbET++S3b/T4wW+WwcrkewFG2p3Zv?=
 =?us-ascii?Q?HnVm4YxTj9hGD4vY3d1RVdYN3DLPzxIlgh+eSrZwaXuduZQ+H3ORW475BV4z?=
 =?us-ascii?Q?ADvLLHiMA/0XoFY4j2tDTGBQdhB4yhSMq3idXuw8YK6R2ycqzs7rUg7dVcqb?=
 =?us-ascii?Q?FQCTY6A6had94e0QFVh76tuZYgjURxjBl6duq6/nUa4Lrd1XXk3HtPvkEidz?=
 =?us-ascii?Q?voHPy5VDyVls1jVezjzSgzSSoTtZMtraQ2iZRCwXQ6pm7qwWMQfriZHSe4rv?=
 =?us-ascii?Q?DL74BvypN5GVnBdNSpfYtf9tgiobFsLY/PGLt8FTLTFHF/fCzZbcI8N9Ad4Z?=
 =?us-ascii?Q?mwo61kPKSoz7RUPcqfsUheU2AFxt+gUcScnqZ8LidO9+vZx7ZcrPMpdmNInS?=
 =?us-ascii?Q?rHiiRSjcJu7pwiOiJa8wxMSZhmeHAH9S7rBIBPP6OVgGS49mlU6kALRuswzF?=
 =?us-ascii?Q?qsSM3tan82GPisv6biMKwWd99qU+pVnf+wPJCZn4+GCb4qM5yKMa/qaw0ch8?=
 =?us-ascii?Q?usrx9kB2sQCMxXOEMEAnbXO+tKb2nH4vkEh+v3OPdbda6Rtkd374zyshV3GS?=
 =?us-ascii?Q?mSjEzRnu+4MmZPloze3pQL9ZaqxTQXmHNCL2NYpH3vnuXF4sqxfST5IJOty2?=
 =?us-ascii?Q?5wMArrSqr/5lMtJZCuy/XWt3RBKB2vCFL1ptzx3McB82pGRIvGQLUcIphkIB?=
 =?us-ascii?Q?Vg+4wdQcS0/9iUBAn3bBPIU5rV89NwgrWbudJTcSLcCz4tzlKEHz9U6ZKjSj?=
 =?us-ascii?Q?D4XnwZK25MQhHcdI3tG3KMW/dx05Suy1PTpmhDVLeSOtORgrZbSU+hnD50c/?=
 =?us-ascii?Q?a4t+PtUwSVyb5wyfoDoCwTtEhTO+zuhmcwIkBYYp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bffc197-6fda-49cf-2a2d-08dd839f5bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 02:17:41.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAXtzfHYDPILxsotE/gC7Q4N8hpzBTA3obaTEY8wDYaVKL+IAwGe79YY6u0BkklndsBd7UcVPsfFDdJfXtWuSSyrTQrhYChTG9ABkMAvaVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8973
X-Proofpoint-ORIG-GUID: qHfCAe-ZLs-I-BpzSbA1e_xwVvaiz5wf
X-Authority-Analysis: v=2.4 cv=bIoWIO+Z c=1 sm=1 tr=0 ts=680af0c8 cx=c_pps a=ox8Ej8V6LcPVg4qe/Ko28Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=gEfo2CItAAAA:8 a=TAThrSAKAAAA:8 a=Br2UW1UjAAAA:8 a=BOLCZAIiBwiiqvYeLMcA:9 a=CjuIK1q_8ugA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=8BaDVV8zVhUtoWX9exhy:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAxNSBTYWx0ZWRfX9qRXrg4Y7EAb J0SUDgbTE/x9klFiDFFXrnJ4BeCLvbj1NSBpi0hyxi3O9e+wMlPeKNSulDMJScHsS0zRtYdrJlq XNUXLxG5Z9nOT+S6jcIs2YTwHR57SiWD0N9BvLHNR/1/WpiCTVGz66lmpRAnko/iUTGxJkB57FQ
 HD90I/KKvLHkBvVvtLhFsiloh0/b9itXeN/GNbs8dPqR874otqcpKfhpawld0eUkaRYOHlJ+Wku acHCsrUXpIDfY5TqZH6pluPbua+0jiMd121ximbeQm90WKBI6TKPwymv9Y97zpLUvyedYPRfZWN iyXPFSnuRU+hBT343jKRWVfQ73O5l80duSgZYASQe52uX9TSu2QDC88SD6+a4rQsc+5fd7nUYba
 xGUDhrFZIbDibjcy/l2BKg27/WWzRrSHG/YDMt1B06mlACrQTHKjNUyQoHMt3YBNGc01/6vh
X-Proofpoint-GUID: qHfCAe-ZLs-I-BpzSbA1e_xwVvaiz5wf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504250015

>
>EXTERNAL MAIL
>
>
>On Thu, Apr 24, 2025 at 09:04:41AM +0800, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Document the compatible property for HPA (High Performance Architecture)
>> PCIe controller EP configuration.
>
>Please explain what makes the new architecture sufficiently different
>from the existing one such that a fallback compatible does not work.
>
>Same applies to the other binding patch.

The new architecture has a different HW architecture and it cannot be probe=
d by the software.
The software needs to differentiate between the new and old architecture IP=
 becos the register sets,
Register offsets and support for PCI generation and feature are different b=
etween these two architecture.
With the existing compatible it will not be possible to uniquely identify t=
he generation and initialize the controller=20

>
>Thanks,
>Conor.
>
>>
>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml          | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yam=
l
>b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> index 98651ab22103..a7e404e4f690 100644
>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> @@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-
>schemas/core.yaml#
>>  title: Cadence PCIe EP Controller
>>
>>  maintainers:
>> -  - Tom Joseph <tjoseph@cadence.com>
>> +  - Manikandan K Pillai <mpillai@cadence.com>
>>
>>  allOf:
>>    - $ref: cdns-pcie-ep.yaml#
>>
>>  properties:
>>    compatible:
>> -    const: cdns,cdns-pcie-ep
>> +    enum:
>> +      - cdns,cdns-pcie-ep
>> +      - cdns,cdns-pcie-hpa-ep
>>
>>    reg:
>>      maxItems: 2
>> --
>> 2.47.1
>>

