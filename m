Return-Path: <linux-pci+bounces-32781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC72B0EA0E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 07:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC431C863E6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 05:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C72C248F4B;
	Wed, 23 Jul 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nFZmNC4d"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55451B87E9;
	Wed, 23 Jul 2025 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753248609; cv=fail; b=fB9A+rq7DjgpSSTpb2DuvFALy1L5IBdc5q6WG+oMkQLO3mNeh0Ygnt0HXLv8X3iLtleichPFQSaTdUdPN9nQQD1qMStRFwHCRFO4F16o7m5RpaTZbYHQuy42IkIMZD/pe8mUoPPhgnP1sZ859Fnr0s/lFw0EQyEr5+eheCj8O6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753248609; c=relaxed/simple;
	bh=hj+/75c1dU1ok4fEcIOpG69NzlKfdcyDY0sb04jqkCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=inY36yM51Ry0wYfZfAZH27ogcda4bfMRI3oKkifc9ECnBuXNbWvQA/WFMMk3FCbvWC4L8JuhJnzqiUZpTy0uUnYZpvrJ4LTlbYm8AlKqLuMQSuueyIE5ZbVN1JJ3BIII3UjF33hr+f3ncz9InXAZ820I8sdBlPjLJciY+d1DPys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nFZmNC4d; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWLNHY4W/9FOaxgQmxqHD1EXsSwdNBvjeiI5Rrf1BTEXl1TINW/VUBKBtb2DhWBK4p0+dqaEPAAVNOBPyxw36IFwf4XWTJLQjDziNYCPmVjJC/wrpophHHZtOqOabJ1WNxCXcluCc54fFW4QmNGJY/k4bIhLApdLv26C+ES8Dy0qiiLkD9IF+oEdKZDNHCI5g7PbqK6NjBcTGdNgy7h1Y4g8MJRRvFyEIOXMDwkWt6ymMMCbUSB5vfGR2FJuquGDptDOaHa5mUDlOejduLVGNVNj61A3lLZ7eMyuH/OEx+nI8xLD0tDrCM+wFF7yPrGS7/+YgfZl5RNnhKYOhJyDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DEY73vkht6uWgTVx2X7C54h1Bsi7U8n0brSaHtHvAM=;
 b=aOZ44jhydqy3/eXyXFUKe0K9KIRM9/Cmchl/b4fcS1g2VXX+ldVfUUPohf9giN1YxiLNBmydyTTZ9ODSJSj4F9vSLdYvjMlOkIX9HqDDw0K+eYpa5db9ZDIR86+6GuYzdod72vEV9/1MxouMu9DHrKuWvIfiRhKk9gUsUdht56gHhwup+nUB0W1HTKY3QwwuwRzw7DtDbfI2F4jCofr4nvSLtXBa4Yn6su6WNxVtMMw54W5ESi5mLcO57uj8F3JIMx6RnGoYSzMRFs/uopqUhI6zUB6uSv1myeUjpWaBqBKabxN25KAcjoCcUKnnzGoVjxUvhO2TQ4qiWKDm/woITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DEY73vkht6uWgTVx2X7C54h1Bsi7U8n0brSaHtHvAM=;
 b=nFZmNC4dWe5Y3XoneJmlgoue+K51PtN4fppN0nfMyyOQCS6x0lYVCvEsyw8AnmVqZTSPNxuGv+iZux/3jOn60g+U8YfiSbW+mINDVByhls37oZzY+i6oo9Zzzgy57p89Wwqkia4cXGWXq9Vw7fGKl/3QEdjC/6rptxTFHEQOlUU=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.28; Wed, 23 Jul 2025 05:30:04 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 05:30:04 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v6 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Topic: [PATCH v6 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Index: AQHb+Fqp7orOAj6ukEWcrZvP+mNzCLQ9I3yAgAILoZA=
Date: Wed, 23 Jul 2025 05:30:04 +0000
Message-ID:
 <DM4PR12MB6158E76993108CAC83D127EFCD5FA@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250719030951.3616385-3-sai.krishna.musham@amd.com>
 <20250721215457.GA2756536@bhelgaas>
In-Reply-To: <20250721215457.GA2756536@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-23T05:09:05.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|DM6PR12MB4266:EE_
x-ms-office365-filtering-correlation-id: 67d9e8f7-aea5-476a-a54e-08ddc9a9fa80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GM3XxTM4SsFhJsGl/kHz54r8YRz7YhEwXoX3PR3VIjNv2YS6G9l/gcTOOdRr?=
 =?us-ascii?Q?VwA8qDOJYCt11GtPE9qYRPgnz1VdZsCb1gKg3cXrnCCc7GlUth1JgwGKk86M?=
 =?us-ascii?Q?nM1YGvxYxjVGooh9LXo51kX4zuRzhPVSZSuW3oJkTLOcvD1Kf7H/CGpoTLR7?=
 =?us-ascii?Q?Rk8zWXm2UPmSErZnNf4dafPB741Xvj2E7AK1MhLe3lyxdrRiog9bisM9Y5JH?=
 =?us-ascii?Q?/zhvtgax6CrMnyV4Gj8z+0AcsOacIYTIgkWO5OkyKop5fQMGrqyszFxCU5Q8?=
 =?us-ascii?Q?GP3U5tOFl3AG/J97mXIsWIzSeAD2o0HlXLxwr+vH6BoMYeXuWgQe8DiYIonl?=
 =?us-ascii?Q?j3VcMJykE+VB1nZ9AUer30d11hV6XRzK1gV8EiHW558x3luO79n3/AI0Zig8?=
 =?us-ascii?Q?Fvtyp/WZKMu5LqIQ271yFOnq5hMZ1NWN37tDf8SRNynOcr6zyl9+F/+Jn88/?=
 =?us-ascii?Q?aDhlC+j+XNJV8rtAgbr/VtbCLQYkuF+VP/zfMKZMona3VQ8yu423VBcsaZwt?=
 =?us-ascii?Q?0jmdVMmWjscBc5T0HYE3MNlbdszriFhKTlu7OijMHl7Urc3mJboLVbU1dBQs?=
 =?us-ascii?Q?CeZsUFbb/kqTg1NP7RkXGAcrplrYrJTteKPgeglwrbdzTmwO/FzM1jlK+93u?=
 =?us-ascii?Q?ar2eJinxJL4hncI9I16q8qLhVjBdSDr65C/huvqaI7lQ0bbtu0dkY9BNVYVa?=
 =?us-ascii?Q?FoXDhlzVGJnTDTF77p46JY0l0veYf0FHYfSotqplnpIliyVmqWdRn7syTzXd?=
 =?us-ascii?Q?9j1ohx7uSEvrXEz3Ltegp/mqB/LXSQ+8ldjU9JVjZRvWRXYBjXF0qav3eMTd?=
 =?us-ascii?Q?5ANjXROqZBpO18SE+yMXwZ89GfQIfEplbRTKES4+m2lBxosDiiT8PgZ7AB1e?=
 =?us-ascii?Q?nADG0f0sXvwGWO48EkgZOEyZhjFcM94MxxoVm3YgyhUkaW/0qPWr8SffQeIr?=
 =?us-ascii?Q?c0djvhQO1lrLvTqSqO/f+u98pFuc0oTp/Z8Bu65YeOOxg18OUKG898JMH8EE?=
 =?us-ascii?Q?wb7lsiDAA0gOJIkeoG5sBMElHG/Vg+9mwUAP5a9xYRPkK74Jf07h5/vSqtXe?=
 =?us-ascii?Q?boYRUnPFinvfYHqihOGa2zQmTfJ3mOQu/nQCREHPYO1/GN8XKx6sxTBNPmLu?=
 =?us-ascii?Q?IXn8jnDfp/27+ANSe24UEar/iOILvfJhRp63ASoGXG/WSnbri5SyPfEikqZH?=
 =?us-ascii?Q?cH8JRKuZn3GsSxVcrAlpD0YiEWDRnPQlIs0lMLiHP4L7GBoLbMuxZZzodY4Y?=
 =?us-ascii?Q?3Afivzb788GUGzfZRE2rTMqb9GAgrrxYe/g62b32a/y7jJCLcAwsNetd94Q9?=
 =?us-ascii?Q?NDu6CjawswAfTpGSe4/d8ey2TXD27O6U7BT2kcF5M4d6S+I9iIdvKgK8H+3L?=
 =?us-ascii?Q?lIDJ/6nXtycM58U+zYzW36e2tPQZo7IbTModYETW134WdJG4uExDGwG+/LVJ?=
 =?us-ascii?Q?4WlTk5S8rbNKJGMJkcnjR21ZqnFnoqO+bqZAzcl1kARY2htw5DBh4Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?92WzqRs2UgG34Ui/LiZOWIiaKgz1Cr7DZaZTIShusZwgs+Rz6p651zfqBQbK?=
 =?us-ascii?Q?rnXWSIIN3nQuxzVLHMNcjFWIQvtkaU4VwsfPKhwYjjKl8UOpBZ6rtDRrReiz?=
 =?us-ascii?Q?MgHOiMecKVCy7u9LknJmVyS4Jgb5kr6c2ConYcDAp97Pikx7wQf9pSA/fB8f?=
 =?us-ascii?Q?ugz5CNC7+8q+wtfARKrpe+s0StC+3+uZSySgVMD+LVOOshGCf92pefzEhv9Y?=
 =?us-ascii?Q?Sonn0HtJL45Ju4r8fnqi41sAiDzA4YhicI5KAOnulfxUJFLaDkA+wTRsczwg?=
 =?us-ascii?Q?IFV9T/7Q9RBPqOQZWe7/FUaMunbQ/XJ7IxjdKexNoTKGauVfkQVHlaX6hP1u?=
 =?us-ascii?Q?EZtE0m3HEmSpxBIu46SbHV+3xQrm/KxwQnkVsBTITDgA53xtPeAeq10kRtjF?=
 =?us-ascii?Q?rbtybmsMAj9McPlSjP2Ej+/H52BbEfOOqBb/qN8+y3q4aA4pMQMIdL2qJfJ/?=
 =?us-ascii?Q?QusIOI8gEvgbBTiyY6oKr36DFhe9awOWLT9uu7QeFeMjRmVm83N1adicpXWy?=
 =?us-ascii?Q?s7B3hEHJPFdLshptmswZHrBihM9YXtZ1H5bz0FKWgbgwCyO05ur+yodVl3A3?=
 =?us-ascii?Q?Hc12dwunEzGk9P7eUhKKaR080ZBmAygOCZzejbRO6IJ6oUTC7V/4mE6IHy4k?=
 =?us-ascii?Q?zrfmT0symWRFSk3XjB3b96aTf9SHONmNrale1+Jr7c+kKowYJ+NWzyV2TwUn?=
 =?us-ascii?Q?ZX+WLNgW1P7oZ8SIQsaJsCQM2sSogWvo50oK3BEXs9mTLxIg6MXCNSIRk457?=
 =?us-ascii?Q?DCZXJerthTNGLVx1v6nQzlkjRVfb741/Bwb+Ds/rvcv2wz+dKiUNytRz+YPm?=
 =?us-ascii?Q?cn+KyUY2OBsL9/wLi88aLVDVf7i3IM+b8kUH/lyIMKBdrqVu+BXzMsSqcPeK?=
 =?us-ascii?Q?8vstoM3+2dgQ+RsL5/ml46gCxmVpLJbc2iu8mnIQDELW6byqlcZxRrkt/xEz?=
 =?us-ascii?Q?8z/dYiDkO1wwg6XqrFzL6LuaS3f3bSt9uGVc3c98RzBaXabqd2nra9haxvTk?=
 =?us-ascii?Q?1bVRi1NS/njSCxYPUzStMhmADF3eC1v+xmI/oAaDbN/a5OsAVvcwkHmnmWAe?=
 =?us-ascii?Q?GCWsAdBvWtJHURkVypQXJ8/DvMRF44NZZ1g+pLYgLtBHNpxQCz2busSE6eh4?=
 =?us-ascii?Q?qN6Ukg+DqC3UJxn1rKu2ztuYN4icOvgRz+ZeJSAezg7ljGOqJ8emk8ZaSqyF?=
 =?us-ascii?Q?IamL/kZvt/QLJIg0hK08J6sPjqogsyM21XvCyzbg++QVYegSPux9WiJJ6aBD?=
 =?us-ascii?Q?blUm5k7wtDSJq8o59LUceas+YlOYtfn66/xXiyC2sgiYhtiUfYwmQiGg3A0L?=
 =?us-ascii?Q?LaoB7u7HuiQx3UJmZWLKCB7GdYUo7RpnIJ7PoXBFxEQDx0g7tKXQa3rrCxhF?=
 =?us-ascii?Q?0QQAFqjlufJYl/CGOaELg+cVSfPhBObIMG14rcw8sssmV0pUGmqY/JVNw3cT?=
 =?us-ascii?Q?XcVuEO36PpOk/K8ymcVdmM8Vw4RzCSNS84/dK7HXIhocGyD/Tf1x+V5dzNdz?=
 =?us-ascii?Q?OqaHue9gR6om0fCcPztlCLOyR4l7wS04L3qELv0zFSFVUogKYT9j/norc4xx?=
 =?us-ascii?Q?p2bIHXWhd9dWLykqQ6g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d9e8f7-aea5-476a-a54e-08ddc9a9fa80
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 05:30:04.5314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpgArszVkw00z1v6uU4WthmLoMCFA3BlDFmhS73xU4XU3ogT/0lDfMAWU/cxXTi3EneDqxtz2b91PbfHV3UgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, July 22, 2025 3:25 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; mani@kernel=
.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.o=
rg;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bha=
rat
> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: Re: [PATCH v6 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
> signal handling
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Sat, Jul 19, 2025 at 08:39:51AM +0530, Sai Krishna Musham wrote:
> > Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> > signal via a GPIO by parsing the new PCIe bridge node to acquire the
> > reset GPIO. If the bridge node is not found, fall back to acquiring it
> > from the PCIe node.
> >
> > As part of this, update the interrupt controller node parsing to use
> > of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> > node now has multiple children. This ensures the correct node is
> > selected during initialization.
>
> > +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> > +{
> > +     struct device *dev =3D pcie->pci.dev;
> > +     struct device_node *pcie_port_node;
> > +
> > +     pcie_port_node =3D of_get_next_child_with_prefix(dev->of_node, NU=
LL, "pcie");
> > +     if (!pcie_port_node) {
> > +             dev_err(dev, "No PCIe Bridge node found\n");
> > +             return -ENODEV;
> > +     }
>
> Sorry I didn't notice this before.   I don't think we want to emit a
> message here either because existing DTs in the field will not have a
> Root Port node, and we will just fall back to the 'reset' in the PCIe
> node.
>
> There's really nothing wrong in that case, so no need to annoy users
> with messages they can't fix.
>
> IIUC, PERST# in the DT is optional anyway (you use
> devm_gpiod_get_optional() below).
>

Thanks for pointing that out - you're right. There's no need to emit
a message when the PCIe bridge node is missing. I'll remove it
to avoid unnecessary logs during fall back to the 'reset' in the
PCIe node.

Regarding the use of devm_gpiod_get_optional(): since the optional
variant for fwnode isn't available in gpiolib-devres.c, using
devm_gpiod_get_optional() would only check the PCIe node itself,
not its child. That's why I opted for devm_fwnode_gpiod_get() and
handled the optional reset GPIO manually by assigning NULL when
'reset-gpios' is not present in bridge node - please correct me if I'm
missing anything here. Thanks.

> > +     /* Request the GPIO for PCIe reset signal and assert */
> > +     pcie->perst_gpio =3D devm_fwnode_gpiod_get(dev,
> of_fwnode_handle(pcie_port_node),
> > +                                              "reset", GPIOD_OUT_HIGH,=
 NULL);
> > +     if (IS_ERR(pcie->perst_gpio)) {
> > +             if (PTR_ERR(pcie->perst_gpio) !=3D -ENOENT) {
> > +                     of_node_put(pcie_port_node);
> > +                     return dev_err_probe(dev, PTR_ERR(pcie->perst_gpi=
o),
> > +                                          "Failed to request reset GPI=
O\n");
> > +             }
> > +             pcie->perst_gpio =3D NULL;
> > +     }
> > +
> > +     of_node_put(pcie_port_node);
> > +
> > +     return 0;
> > +}
>
> > @@ -444,6 +483,7 @@ static int amd_mdb_pcie_probe(struct platform_devic=
e
> *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct amd_mdb_pcie *pcie;
> >       struct dw_pcie *pci;
> > +     int ret;
> >
> >       pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> >       if (!pcie)
> > @@ -454,6 +494,26 @@ static int amd_mdb_pcie_probe(struct platform_devi=
ce
> *pdev)
> >
> >       platform_set_drvdata(pdev, pcie);
> >
> > +     ret =3D amd_mdb_parse_pcie_port(pcie);
> > +
> > +     /*
> > +      * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that =
the
> > +      * PCIe Bridge node was not found in the device tree. This is not
> > +      * considered a fatal error and will trigger a fallback where the
> > +      * reset GPIO is acquired directly from the PCIe node.
> > +      */
> > +     if (ret =3D=3D -ENODEV) {
> > +
> > +             /* Request the GPIO for PCIe reset signal and assert */
> > +             pcie->perst_gpio =3D devm_gpiod_get_optional(dev, "reset"=
,
> > +                                                        GPIOD_OUT_HIGH=
);
> > +             if (IS_ERR(pcie->perst_gpio))
> > +                     return dev_err_probe(dev, PTR_ERR(pcie->perst_gpi=
o),
> > +                                          "Failed to request reset GPI=
O\n");
> > +     } else if (ret) {
> > +             return ret;
> > +     }
> > +
> >       return amd_mdb_add_pcie_port(pcie, pdev);
> >  }
> >
> > --
> > 2.44.1
> >

Regards,
Sai Krishna

