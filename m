Return-Path: <linux-pci+bounces-8180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD288D7CC4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 09:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FB8B211D3
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282D4CB5B;
	Mon,  3 Jun 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oOlLGBK5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1034AEF2;
	Mon,  3 Jun 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401066; cv=fail; b=K+gdncRbJYJFZ0omzNiEyFgUkJvrzmrTq0z72UF8kTofygghKi8kTuFyXi1fHSOrcHgvamhY66/xWsDK7H6yeHZ7XzBzUHT/tNL1ey61dKBYEkib00MSrKE3jddiohHU6FEcmCTf1zR52zaG86tpwYTkT4A8t8seGBFa9b0mutM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401066; c=relaxed/simple;
	bh=lfyDCCcHer3KClTAJU9v+KR/iqF6PHVCKUTCAB45HMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H8s1JBp5LXVV0V/F5hPvV5EHG/24Ee3qSxLS18jupFj5WOhDYBpxuaUP5szud6/iC5RX/yHNNOlNc7O9wYm9+cVtKX1Bgw0vlK7bdIJPl1AikSt6jcloEjC2wRPmCFzfPGzQzbXvWpoXmTA7l0s2PoMkiTkw/BiBUIpm+ENmsMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oOlLGBK5; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgxw08C+hX98j1mr6hoY4i9guF3ClE+Dnz9hubZiTrNwVXPsLLIK8c+n5UY8nCpK9DMdSeDu1Na+ITwr/84G/wPdkqVwWNNc0Qo0HuhniM7BsN7mmRXT2MNnMUcLZsrWlagSXwkFqNPB/MSERxK/04AEISZNZKdkSd7QELJ5pcoHL6PHpGI56ypKdLctqQ2MwQoGoqwXnGGVDcVzQWM9u7ghXuttplCj1sNu7SKxkTMJQb+doL8+I5580WWpBgdc4URmFPsGbOHHpYMVKVQXpE9U9iPcEILO1870hKxJNLU+fS9cLb4SObM8F6jtuX/ztFVXH+rREfn4FDpD8cP1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/4zBSW1/4+Biu1Wh5nF2ssQIO9Tu2xH3n6YIvIR8D8=;
 b=hCh3NIlxkjh8DWFH83Cmd0IN9+zExXdBaJAXPQMbOwd1tPl+Hz9RwgftoL9TgSj7KIQTYyQAVXYDJZB5syLg4u8JAakDH5Fia22aJP7CWwjJrdllvQlZnQ4wxbz6BIlKtirE870hCUrloCXi20iJ0k4XGdfX5C9yEOxWMGs6MrlQ445WjIzZdpjR+CUd3DUQ9IrNCN4bRGtoMO/KgyknZgbViz/UHzYOTNNSEFivUhgojA3ia9ZuRWhaCIWXaCgyq+KpAUY5EoX2enYRPLcpBxYMt/WLt2uFRMvkY3VAhIaojRaAs+UDHTKhYHbzmqTG8iNP1IomHNo2Yw7ikhe5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/4zBSW1/4+Biu1Wh5nF2ssQIO9Tu2xH3n6YIvIR8D8=;
 b=oOlLGBK5HALRdSamTueoAhQO4hP+2rS+yLjK9ozivlsDcS8E7z1hcKNWQjkMOhU3OXwr7laTk/WpqgtuPG7l6yQIQ83+1QcPcNjZgw5KaDx4uIstjiNK7c5FWLx3gxYAjc5uOcXQE6/FhAUjpxA3dxrfEthVGWL3gzs0oaLAfQWRqlQe1iWvZQqwzjBxFCoBrdGLE/lehF605oOqJ++eyigPKZJU20aeckLAxdtfaQDxeQuQqKK2TaWu2RAuNYtXmBab2oqggckVe7Dd91oanCF01eqLz2zK7VQwOeRpgXgMbz2vdPhOFckAC88hG/IzAeI0h/11tM1neVTbfXwJrg==
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 07:51:00 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c%5]) with mapi id 15.20.7611.025; Mon, 3 Jun 2024
 07:51:00 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Gal Shalom <galshalom@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Thierry Reding <treding@nvidia.com>, Jon Hunter
	<jonathanh@nvidia.com>, Masoud Moshref Javadi <mmoshrefjava@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Jiandi An <jan@nvidia.com>, Tushar Dave
	<tdave@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krishna Thota
	<kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH V3] PCI: Extend ACS configurability
Thread-Topic: [PATCH V3] PCI: Extend ACS configurability
Thread-Index: AQHarNt+aNbsAVmh9EuxtikUDxoII7Gk6fAAgAAEm4CAEMzwAA==
Date: Mon, 3 Jun 2024 07:50:59 +0000
Message-ID:
 <PH8PR12MB667431B8552D271F906F8F4BB8FF2@PH8PR12MB6674.namprd12.prod.outlook.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240523145936.GA118272@bhelgaas> <20240523151605.GP20229@nvidia.com>
In-Reply-To: <20240523151605.GP20229@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6674:EE_|SA0PR12MB4432:EE_
x-ms-office365-filtering-correlation-id: b2d75e41-8784-40ec-3669-08dc83a1e8d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YO1SgsvFXOgHtiPQdxMDr2k5HF/Jb+Hspt7rimnCv7AsCEw5oNl9+HZCw8zo?=
 =?us-ascii?Q?gyWHa7VgIenuBIEnT/IrHfOdjfX5s6+n3Ue0RkaO7+GAsecjC/H8e+aV2YGl?=
 =?us-ascii?Q?zt7rt1H4TmZ+tHQ8wL/HxNReX005bcVMlkIJWZGfYR4qDFf93u6em93jnEmr?=
 =?us-ascii?Q?yqbHmoJY9YNiCyYZ174L6vkxCGMntRkF0Quqcfun92tSy3fjJ13Nfmeg1WNW?=
 =?us-ascii?Q?I80DJ0d3hqwqNJKwy/5npLuAKgwXCGF9fvP6QGj+8a8ND9197SJzoky5+wGz?=
 =?us-ascii?Q?zh11FnRKo/SIONw9vFnGH2X22i+1anJq53+0RfuzrhvutnCfkvU8ST0IzwbR?=
 =?us-ascii?Q?fS3O6iAH6oAvR1U6sXDlAN1GW/orTEaO6/bEyhsvPGX1jLh6JFH3z3sqNEfA?=
 =?us-ascii?Q?m4IYNZi8BgfE9ZV42XLJG/afu5eWOvQE5aN0QWoyJ/e977lfWwYC/CYXp2a+?=
 =?us-ascii?Q?gjYtyMaHzdrCmNxTCBT0U/Idvri+ZZ+ha0MXgoFP0DPdyWWLKVLbueKnqL55?=
 =?us-ascii?Q?HkHEcfU4569tpLYXLkSj8+V2gWHHP0uc/M1YyVqRSa5lXT3ZSY38OiZZL+rV?=
 =?us-ascii?Q?TFXuSeVjQu/+UzjT3ve1OelW/4jmxV8dTuaFM1NJcJiYdPpmtEE9fct+lpUB?=
 =?us-ascii?Q?UB6lsip+uTjgmO+w+MCzW70I95f/9pfQBrqg/g1b8r1Fynh32ECxWzS4gvEU?=
 =?us-ascii?Q?AFYmnRAq7tt4czJH5+Npgst7F5bq9jJA2PrZw2VgFBT8LRJvDeod8Dkfshes?=
 =?us-ascii?Q?HSyi/fIHLRgyP2/3D1a0n/TRDFa00A+Uudz/DnnmhNKeG5Pmbxg79UtYHzAa?=
 =?us-ascii?Q?4FOPtmmTNY7so0xvS6AsaGnegzqVwowX4MooJLr9M2RlyciztiL3Klnx98tt?=
 =?us-ascii?Q?2LVdIIChbDBLCdANkhdcu2sLVL00WQW6LBECGIgMpcDDe2BIbsOPqHrCxwvl?=
 =?us-ascii?Q?/BGflRbnO02LDOWgwJ/UInYwDbdTcH3BNS7gLgb42uH8NXWrFsiEH/nTPruP?=
 =?us-ascii?Q?yaxv+zfx230IDmKKUpXjprAf4JU4Ry5PEf4oIOXpIyZ1EC3u0I8K4NdMeNOq?=
 =?us-ascii?Q?rIFfGerBbpQ0Tcs/RwNQ9ErAGH9Dd/VnBgM2Tk0JexRToLmbXgK9cqOYKcVr?=
 =?us-ascii?Q?2k7yf7DpPAVup88jLnJc9lFGMaz7PZ/PLnUeocaAU1G+WQVmeYmRSthp+l30?=
 =?us-ascii?Q?fROcAq0HjO0wi58/SUY+3RauoFMv4BwuiLf0DXNL2h+j169nMP3GZw4PFK0H?=
 =?us-ascii?Q?eyDL7E/aOvF+75Pfk7zf+mzdxFSpK/A0p+kobYudvy0peEwRlOd8FW5t6K5p?=
 =?us-ascii?Q?mGsKerK1UDfoRmX63WukTCa1ose0lQb1eUVnHLIdpfLiig=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HctwYmh1LrQAa19T8KyuBdbATa96hfN3zTh0leHPZfPQ61NXxw7BbrP4GEy9?=
 =?us-ascii?Q?+GrlfVLfMxZJrAtAMdRZ2oqJ9qhMnP5a+7r1ZdArQNO7Mhm2+AAmEFrY2N44?=
 =?us-ascii?Q?5e82PzgqW8xknZ/8xYW/ubRpfUeMxZ434d1Z6kgY0jGdYj1J7FQGi3AN6vyK?=
 =?us-ascii?Q?gL8qbR9YCWAV0OAs3JjpWPqfgjJfIVhzlDPH4CwYS4Or5q48J4On6U1MsQN1?=
 =?us-ascii?Q?IbMzH50bK/h2/bnuS4VR9kXNLGzvhTslN6wo04XkpBmu1g4rKZ8i1SKBgDLX?=
 =?us-ascii?Q?Ulu3UaSjwW3hwJVXOTVh1+l7qVSF81AJGWKZYqOxLT1jxev5pummyyZTyLcW?=
 =?us-ascii?Q?/r609ZoHJHNpbpuUVLL9egADk3ViZMLrsPPJHm5O8H0Oj4rCo4DImZEHyszn?=
 =?us-ascii?Q?GoWGRxoq/YIDdikEVjDnJLxUTBM2CVrZe6QkhVVbdiYOBxzYgvygYdQxgwN3?=
 =?us-ascii?Q?uc0jTjJLoBA1y7lKsxKE6vMwy12/9KdqtqB8sLsO3QwbUzOw5El4wOQJRLyg?=
 =?us-ascii?Q?1C1DnWMGwmHnHhqjGRbJPwlp9W4o6UK0qALGyVASmnt1F79gAlqI0aNlyzN3?=
 =?us-ascii?Q?gLXpKgCzMuwG4oI3cJx3Hc2m5adjShdSbujJjArdNV1MR0ad9tDfh1n0Oo9J?=
 =?us-ascii?Q?YBDX0/gfmDyqJTJ8Ycvpz+gIKoo8VZ00TjOBUWhPhRuZER0OSeV/MIoFSOge?=
 =?us-ascii?Q?K3ihmSNvVLPgcQeoCMY7+CY0d+hbByIWg82KsJkPt1avwjxmEmPVl5dZ8tjI?=
 =?us-ascii?Q?f0FfCqrAMCOcgDyJ8Z6gVK+9c29C8zG+lR6IwlaSwu22GxzNqagrhEp6PrY5?=
 =?us-ascii?Q?Ic2ZGLBpSVGDj90jyFJwyZ8zRcY1TbyIfmhsmHM7HWYDDukzJm206NGoZ7xU?=
 =?us-ascii?Q?16XJbvT/FDeTzR4hd0XW7D/6w26IyCcsgTv3IIN09CwTT4ZuDbz/73URDHoy?=
 =?us-ascii?Q?E/tQQ20Msf4rNntKayHv9qS31ityl5Gx1r2du8xX+A+VnmWaREOd3yFvcpHe?=
 =?us-ascii?Q?Lyf4czjLkUBobdEPqM64+bhsHDrP1a306MWvk9wHYva6mvS5jD3PdVB/peJn?=
 =?us-ascii?Q?anXh/kExFKdCZ6U9Jb5AT5wU9TLN58IdCdgfuuXX04D2tLT6Yv5dvu/tocoK?=
 =?us-ascii?Q?3s/TjWmnNb2l5VkPTp3dv9lXSkgACfeKSq3Poed79L0IW/a0TqQ4xlVpCVcO?=
 =?us-ascii?Q?TVSGnWbx7cXQrKbklg8JdvScujERq0B3sr0ql986/p+5H/QxtKUKIl+NKeJ4?=
 =?us-ascii?Q?vRmGGPfArJ9F/RVE1kTIkDvyjQTsd0WJZLxzBjnJJAWvNV7n/OTYvojncBPJ?=
 =?us-ascii?Q?ODyg2l98HiBTyU16MrEH+gE7vdldDvZ5HEV3bw02jbLbfIziNGv5BDAiKq4l?=
 =?us-ascii?Q?/FphU3EziAGmXHTlXWj5XrJjw7WlaClUq8BvjUjpgHgEvFrk9ozUxj36AsRx?=
 =?us-ascii?Q?zgsG/2ewnUh6uulI+6irPuhQbXehtGCKjn1VM3//3OgNccTNpfZ98ycDB2Ym?=
 =?us-ascii?Q?BZ7D9HbVl/gDYsdNaJnZp40oa0KPtxEeqsp8O1VjAG5yGjI3Q5eM4h92N1IR?=
 =?us-ascii?Q?8VQViJVh5a0Hc+L1qH0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d75e41-8784-40ec-3669-08dc83a1e8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 07:50:59.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flK1psFOIiRhrqJ/TxO1PI0epzwrJCywBfU7/sZGCrljGG8i6FssMPFACNeI1DeVhLrMutg1zr3CRABmjgBNzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

Hi Bjorn,
Could you let me know if Jason's reply answers your question?
Please let me know if you are looking for any more information.

Thanks,
Vidya Sagar

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, May 23, 2024 8:46 PM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Vidya Sagar <vidyas@nvidia.com>; corbet@lwn.net; bhelgaas@google.com;=
 Gal
> Shalom <galshalom@nvidia.com>; Leon Romanovsky <leonro@nvidia.com>; Thier=
ry
> Reding <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>; Masoud
> Moshref Javadi <mmoshrefjava@nvidia.com>; Shahaf Shuler <shahafs@nvidia.c=
om>;
> Vikram Sethi <vsethi@nvidia.com>; Shanker Donthineni <sdonthineni@nvidia.=
com>;
> Jiandi An <jan@nvidia.com>; Tushar Dave <tdave@nvidia.com>; linux-
> doc@vger.kernel.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.=
org;
> Krishna Thota <kthota@nvidia.com>; Manikanta Maddireddy
> <mmaddireddy@nvidia.com>; sagar.tv@gmail.com; Joerg Roedel <joro@8bytes.o=
rg>;
> Will Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>;
> iommu@lists.linux.dev
> Subject: Re: [PATCH V3] PCI: Extend ACS configurability
>=20
> On Thu, May 23, 2024 at 09:59:36AM -0500, Bjorn Helgaas wrote:
> > [+cc iommu folks]
> >
> > On Thu, May 23, 2024 at 12:05:28PM +0530, Vidya Sagar wrote:
> > > For iommu_groups to form correctly, the ACS settings in the PCIe
> > > fabric need to be setup early in the boot process, either via the
> > > BIOS or via the kernel disable_acs_redir parameter.
> >
> > Can you point to the iommu code that is involved here?  It sounds like
> > the iommu_groups are built at boot time and are immutable after that?
>=20
> They are created when the struct device is plugged in. pci_device_group()=
 does the
> logic.
>=20
> Notably groups can't/don't change if details like ACS change after the gr=
oups are
> setup.
>=20
> There are alot of instructions out there telling people to boot their ser=
vers and then
> manually change the ACS flags with set_pci or something, and these are no=
t good
> instructions since it defeats the VFIO group based security mechanisms.
>=20
> > If we need per-device ACS config that depends on the workload, it
> > seems kind of problematic to only be able to specify this at boot
> > time.  I guess we would need to reboot if we want to run a workload
> > that needs a different config?
>=20
> Basically. The main difference I'd see is if the server is a VM host or r=
unning bare
> metal apps. You can get more efficicenty if you change things for the bar=
e metal case,
> and often bare metal will want to turn the iommu off while a VM host ofte=
n wants
> more of it turned on.
>=20
> > Is this the iommu usage model we want in the long term?
>=20
> There is some path to more dynamic behavior here, but it would require se=
parating
> groups into two components - devices that are together because they are p=
hysically
> sharing translation (aliases and things) from devices that are together b=
ecause they
> share a security boundary (ACS).
>=20
> It is more believable we could dynamically change security group assigmen=
ts for VFIO
> than translation group assignment. I don't know anyone interested in this=
 right now -
> Alex and I have only talked about it as a possibility a while back.
>=20
> FWIW I don't view patch as excluding more dynamisism in the future, but i=
t is the best
> way to work with the current state of affairs, and definitely better than=
 set_pci
> instructions.
>=20
> Thanks,
> Jason

