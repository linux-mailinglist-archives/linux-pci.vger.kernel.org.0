Return-Path: <linux-pci+bounces-18682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C09F61D6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D0B16F861
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23019E994;
	Wed, 18 Dec 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F1wtdQ3i"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071319E98D;
	Wed, 18 Dec 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514221; cv=fail; b=cy/BX6wGZB/locH++V4FUKIfMym5kkEQAV8czcUAFVdywBF1CHfk9jVy6QgLDyYyjioFXOsXvPy+/301PG0pdcEt9IIUD5uOvif3FGHIaa0zvCLkmQXzi8LjNU3utsmYmtyNjwhSpv4nMSJmiZQdCx0P/8y1zdnLpeIH46FHf84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514221; c=relaxed/simple;
	bh=ja2mPRQW5Mr3gtK6F57Fw4aIyr/IG7firQ/d1bQBF0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUGgZNxUhsd0KiadnD2TUY1g+9hdznQJbfVSbhZIHcLvSiJR8IDzVLWeyZ9WnTzmoghqGEtuoZtV9iK/XN3hu9/hmhCj9t8L1OgAN7yMvZlufA7lvXTsv6u3CPvBpg7v226fVRVDTteU/GGkZHyPHUZXHIh+1keQlI9VxJvtB+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F1wtdQ3i; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIjsWAWF1bQZg4AUcX5Jek/NpnuiK9mNJ0rwfC47lH5FJnpv7IcxyZRGYcl1Na9yiWOwWwCBtHJcMEOfQjuherpVgVbiLZja99KSw7dH+HBgrPeQTgFZFI78Tv9wa2uSBNGbBEKf2/TMnZ9gtSve5UWTWBBTB/eXyvJ06Ttw5bCOO5xYybwMjyKIfxtw6pX5k+RjhjPhs8iQtbadEeJYwGqNo8pU5fB6jwCIoMZLH6o7JQ67X9KDxTlH26JASL5xJOB0Oy4cYQrfXxNTakeG7Ph2+CLTQnM2b+x+r+nm1VEES0z0d9LKOr0gSWTyhHlS4AuU0cNBxh07SOOWkjtDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Rbi/fBq8Cy4cJaqgcQZ7VFbq7fGo1tqsEWgtssQm9U=;
 b=g3G2EmKyCqe0XYTYn7+JakGt2wvg6MP/C8ZmpKeQywrzRiOxDeL3PbiaTikvYUur2hoSVWilUP5q7jZmuq1cY3F1rQDdVfEAK7lELHTPkhhi66iDASlvTwE55KdXpiq0hyBrumIVP6pmf49i86ZGT+0omTF2Dvc2vV1jBANEfPOGUWkjhBWuxGGFF1xC7Hsp1a8zu4EN/OnHXkG1K+CFWoCSjuNkbF2cQ00bUaxArxZPUsU0/H/Li+QdrXWZFKScBBIRa+Gwpeo40Di9qiGNhdPcVTFjT7asTJ1XnyW/io40OHbeA8OXk2UAf8/pzO2IFQWhNAMu/suMXZudfugJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rbi/fBq8Cy4cJaqgcQZ7VFbq7fGo1tqsEWgtssQm9U=;
 b=F1wtdQ3iaKq9gPrSyByZanMELJ3Gih3haJdA7VnOwcKQy9zly+73iJIxC678SINPswsF8Mn59PZ/GxfUM/nloROh1ISO13MwOqL8ZxovNkCYhGK51k3xH+7E36i/r9/1PFlY8+Mxfqdi474BiumQi4xrxMDFORrNDxH4kZAYKbM=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 09:30:17 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 09:30:17 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "Simek, Michal" <michal.simek@amd.com>, "Gogada,
 Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [RESEND PATCH v5 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb
 slcr support
Thread-Topic: [RESEND PATCH v5 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb
 slcr support
Thread-Index: AQHbTSoFYVLX1yudd0SjNvzX50qzvbLqjqEAgAE1jsA=
Date: Wed, 18 Dec 2024 09:30:17 +0000
Message-ID:
 <SN7PR12MB72019397436F94C7E2D915118B052@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
 <20241213064035.1427811-2-thippeswamy.havalige@amd.com>
 <20241217150058.GA1660852-robh@kernel.org>
In-Reply-To: <20241217150058.GA1660852-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB5819:EE_
x-ms-office365-filtering-correlation-id: 19f7cff2-1274-4826-bd22-08dd1f4695ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f+8K+VMUXx4wRe1WwvlUW364wCyLcLENXQABH27zQmbKzpZ+Hob4r8pD3cDc?=
 =?us-ascii?Q?GPhLXLA+0gVIVUdabFxL8EIGaQ2x4ygm6Sr/MLFUQBppGfeyMcjirecb3ANW?=
 =?us-ascii?Q?+siIZcvx48loFQLApc1KFgQ5sBbk5qaWAadjBVzRBx09CZW5I6yJw6daatJM?=
 =?us-ascii?Q?6Jl7K+8bVnU1tqbjQSc6B01WrZMevodTjWEfR44BS3+aUiZ1DnJqtCmO2DOR?=
 =?us-ascii?Q?T/SiRmNYR5qQvVWnB8nH2mLaPObtUJHAhhg/q/Ziwu3d9Gj9Li0Ol+vzcmZT?=
 =?us-ascii?Q?YHd68kGiNehBh7VGnA6AV7z6dQpR6Dk0ygvD2M2ZxUSi37rqyjE1zPX1E1Ni?=
 =?us-ascii?Q?ii1h/lRBNtn6++08da+UfjWIeE3nygRFnt7o00cTk6ynq4JN/bkZ4fMYzvjT?=
 =?us-ascii?Q?vioTpRqKXvBehwKpkxUw6JjG7hcIXPBVAWODFwI8BG+IlMztcNmecy9DIjux?=
 =?us-ascii?Q?WaFCS87VBN/0bQnA4Y2yf8+9SUVD51ry817icHT4zDt7BstMVluOcIGma5AH?=
 =?us-ascii?Q?KsBma428K2e0nkdvQVPD7o5znfLKSswoQLU1Jd3NG7AE1oiTDKqJaF765Hz3?=
 =?us-ascii?Q?pV1fqxLLHMf0Z500EU5+vqDvVy9yoDGXeWh8xVeE8pKM/oHd9E+UhemzQfID?=
 =?us-ascii?Q?hUC8Lh8fARchfxr9PgRrhYpJDtpkoU9FqDlMsZJXzhPfO/0Nv6s6ZlMHj3ZF?=
 =?us-ascii?Q?N4ZCMz6aOzuo4QMpWuxLxu9cSIS4C0sql+0/RUBf+hyheCcJAtVgdow1K9gQ?=
 =?us-ascii?Q?8TN0fv597gq5S3Vh4/2b0MWCGxv7jQDC/6egkYqXuK3xBYOh6OmvsrRoDkYC?=
 =?us-ascii?Q?8PQW4zQVGUNmkmq6MW+u0CcARFpg9aayTHDARaZ0CJuGKTmrrngMCmkuc0mb?=
 =?us-ascii?Q?ojQ7Ux8v9kvWYu30yvdsZHqqaZuF69qzsemtXEl4bU+9rJOkzjHaYOJmhiSm?=
 =?us-ascii?Q?P/yqxDlYJUj3Ivdz6HmZnnZqRguJ/1Cz30KGzSJsHEbicoIxFu8HMbVOUHP3?=
 =?us-ascii?Q?4c1JUQjWf8ZrN7g+NCbi4ev4uJeKIT3EFq1RaaWZUn8an6cvbDTTPYDWa/Qa?=
 =?us-ascii?Q?sAgkU4gXvJKU5PgEJLo+gRBEF4QgQdeKYWK+iV8AnnEx8hpZiARph33BOYSO?=
 =?us-ascii?Q?24Wr+hJ4lTA8Pk4/02tdzG3SGtwulM+scwTPCv3n9JdqeNL6MhpF8SLhDwRW?=
 =?us-ascii?Q?ShARm6Kuu6U1yPn2B8T2fpv5DulzUXFNSbzSLewHb9sbrn1waY5VwyV43sFU?=
 =?us-ascii?Q?H7kJBGiuPPY7uHtaI8d6GuPWaUR55I8RngVDodI+DWx4rSNkvmKVO1D/sHVA?=
 =?us-ascii?Q?CsWvVQz1EZHBK88aj66GeA1MdBlSENeyTx1NnJc9F9hmAh2dQV9Vmacu9854?=
 =?us-ascii?Q?atYmXVxNO/pK85VaFxJrRXplcD6JMSi3HZlJhsy3VeC5VB7CjFYcriDhPKR5?=
 =?us-ascii?Q?ZrJ+u+vVEewUu7YDQu9bkQN/rMIlRzcr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ROJ2QYdYeEsQz88ceGV994DaONy/fxWg0a6rEz3FC3zhuzkak3AN+iTL9LkA?=
 =?us-ascii?Q?W2vNSS0YkUk7V1DlIAGKWIEwtzsIDMQh6QrSQRNaN4ZRB0bjDet+/18uSa3c?=
 =?us-ascii?Q?969cjpc25q0j8vqRQhSBkHBS4fKrml9dc3fNwBXyANIsjDl5djvE2Ypl8UoL?=
 =?us-ascii?Q?ipHYPlwv8my4779N46EpK/bGBmE/TPqAS5uKBe/zH/Jmx4t25LKuoRc79n7b?=
 =?us-ascii?Q?/hkrPXsr2fkgMyJMov0VXKsHskk6rv67Ne0tjPd5L0KfeX2BO4wEJ+yKHBzU?=
 =?us-ascii?Q?8r5/1aFe5/QVdTJQd0jXJrhPxe+2WfPNmi5gu7IkSE1xLe01/LP/Kb3tY5pS?=
 =?us-ascii?Q?Nw9/9ve+l5yTSqbn5O6jeoQwzaSpqyLicoI9Q6+KgVOwOp6pNucmBRIHFUfh?=
 =?us-ascii?Q?FdV5FolkaWVXuI64vcxaXDN1oPMa5FWlR7kaEsotIUt4c881Ex7U2kWfLWIz?=
 =?us-ascii?Q?DrltqBRDIShURTyJYK0IiAhXAyRVb4dg0Tspb7X10d1YycsOpsCdXF6GOLWB?=
 =?us-ascii?Q?KZHrWoDKExsJ5w1sFJBpMZ2LJmnO5QBjh/PQF7K7aYvwlqrVbXQcMvBvXIxb?=
 =?us-ascii?Q?fKUP04P0JB/GiQ2kvWz3vt7WJPTk7sqtSo//3m03S7QfVbC0kx90DoE8UoIk?=
 =?us-ascii?Q?eZ593fARzqfbRJyJfzxeGJOxxg5z9fxvLm1763nAgwyQbKKIQXaBj6lieFOW?=
 =?us-ascii?Q?b0AozCJ/B7Z4lquMDeTPFUm3HSLW7Y8EdGGS0m4+jljvtSRAY5ZfhBvZqEE0?=
 =?us-ascii?Q?KNU0OWRWwHf+dl2vEtr//VB0YarmGtRjR40lyIIBF/acaoHS6mo2kGA4OCTO?=
 =?us-ascii?Q?3KmVPw9ZZKIbCuhHrj3dVH/t0+Yvz6YHuumTW54/joFbJWGNHutZfdDxx0cp?=
 =?us-ascii?Q?pR/V7cW13adPQkJdQZh9Wt2ZK3YdW6IDgAaX4OWgmOk/9VNLCGxQOfhBXAod?=
 =?us-ascii?Q?KWR1OdZ3+iYce5AsoFX5JvppjFwUgCKJshdUNyEvBjD3xViWx1n+K2K0RtBH?=
 =?us-ascii?Q?MfxDqNjmXO5rhbvpsQQX15D/XXsTS3Mixwhy9HYDKLdec5ZUx1k5/+5hQ/rY?=
 =?us-ascii?Q?p9bfvOyYH8JH5Hc8Xiru3fiYQgnTBOSoBRB1Kqtj9PKyzDZbdIGLu+gmBGJo?=
 =?us-ascii?Q?V4vvbqDdF05hamnKi5LUu6qpqkEcGfav8Cy3kC0UlK5GNT3zTtVmtYz2zgmR?=
 =?us-ascii?Q?FbiEXyT1hlum7Tvo26v9C548cPyyx8vP6i9F7cKyEOxQhXe+999KGISPJmtQ?=
 =?us-ascii?Q?tcVCNCGa2c+McDWbLkJ//Ws4zoHIOoONb9Z/ejLuETJkF64JaJTpIOS6wObu?=
 =?us-ascii?Q?MLmPUYJyPL0TbyC23PYaWOmM36aXKNLAd2UyXIfSWp7yGy/wb5lJxnr9I0Ka?=
 =?us-ascii?Q?wwIJV9kt+BA3sJIbMH8vQ+Xk8/bz56R0g0nHjHMUUTCfcfrzEDI3K5Kxb5Bp?=
 =?us-ascii?Q?pmbuCWFeA/v7B1Iu37YI3YbAzZcrVoDi6Gma8VuQ7j5WYdcjHSLpwcCQslZn?=
 =?us-ascii?Q?IcHU+yg7sxKH0/N2PPH2xuKbgNCbwvNS/fOHk9ovywG7F+t+7z/i67zNWqpD?=
 =?us-ascii?Q?m1v6hLJZX3HOq/KcQWA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f7cff2-1274-4826-bd22-08dd1f4695ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 09:30:17.7757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +LqfgctH/Oh3jtg1u+GAvmItGcbnDzA8qEnKziXaHYnjM1qDzzakyqNfCX2yYBOyQS11913YWIwtR4N8U6bjEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

Hi Rob,
> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, December 17, 2024 8:31 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; krzk+dt@kernel.org; conor+dt@kernel.org=
;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [RESEND PATCH v5 1/3] dt-bindings: PCI: dwc: Add AMD Versal2=
 mdb
> slcr support
>=20
> On Fri, Dec 13, 2024 at 12:10:33PM +0530, Thippeswamy Havalige wrote:
> > Add support for mdb slcr aperture that is only supported for AMD
> > Versal2 devices.
> >
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > ---
> > Changes in v3:
> > -------------
> > - Introduced below changes in dwc yaml schema.
> > Changes in v5:
> > -------------
> > - Modify mdb_pcie_slcr as constant.
> > ---
> >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > index 548f59d76ef2..696568e81cfc 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > @@ -113,6 +113,8 @@ properties:
> >                enum: [ smu, mpu ]
> >              - description: Tegra234 aperture
> >                enum: [ ecam ]
> > +            - description: AMD MDB PCIe slcr region
> > +              const: mdb_pcie_slcr
>=20
> Including the block name is redundant. Just 'slcr' is sufficient.
Thank you for your comments, I'll update this in next patch.
>=20
> >      allOf:
> >        - contains:
> >            const: dbi
> > --
> > 2.34.1
> >

