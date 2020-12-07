Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7232D08EB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 02:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLGBtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 20:49:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgLGBtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 20:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607305788; x=1638841788;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RajiDd6t5V2JAk9xQ/5uvBBjAi2ZgzkTowzBTyClIjM=;
  b=qM7jbN6A9RqBBuzbVvt3/edRoKM73+oSLTdc71vzCwfSp5DW01iEJsY4
   71+xVM89JkdE/wzrjQ+3Y3SFzWtcayZXnP2X3BziK0Ke3pYQTWjGlhW3e
   cPdQAG9J+VjMJcrJNTKDGIGMtEr+wGZEAhEFO9rmoUh5nQh1CR3FMz8bZ
   EzhntbvxZXhtXMSn8iKy9pULBv02MQZ7AyV7xo/Nn15loWvN4ivvlLd/c
   idSjnQGqvXWm8aJY8K7u8qbN5OelB2vqUWknAgHG6ksDZ4X8EGC7DcJQU
   YXBFHIlyA5R7OWJ6XFQ1jZFWBSwx4mi4XNxqG8L4auV1LdCVGwNuJb6SU
   A==;
IronPort-SDR: d5BDLFPgxbOMzQVBUO9HwRCe6QROSZxJ1NXb5BRa/pXptqasvnpx8gBmDTp1+rpc5llb0sQLGo
 sbTZGOgm6+f1kG49JvqnkPYcVRQY5pam+8I6OtEEKvWLetjxBPUteZxTgxFZDl9+R4OQe3LXfk
 WZX6SFjy8lVFoeXDBcKIr9LNt9ohy+VWLI5w2owAKJ4MuWKUXrLuMKYQ5IW6apBo76NdAuDrMA
 ke1jqAM2ISOQjJrFid3Frxq0LhIe4cNWM10TBdUN3DkmzfXAAHHfWEb18SXsHxLjcjIX9Oltyh
 /Gw=
X-IronPort-AV: E=Sophos;i="5.78,398,1599494400"; 
   d="scan'208";a="159019293"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 09:48:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhkguw/ezz3op/QF9YjQVwaa/h6IAvcGgAZWsElNTjexu/x4J+Nz61UiSQpq8hT9kuSe3WqzvsjoFElvOaP5Un9t5ukDzrgvGNgI0MgUK+2mE0SAT8JeBJZtY0PDMHB6o4oxU0cFwI75vIZ75ZrPU4nrCNzHAVi2MBpeKvW6mKEnAAf0zQsiMlRBIkI8hKD0e+1roXdb8GgARLzt2X4rYFr6NRhfuSSJgmwDNAzoD6EeR8bxOpD5O7Xy3uqvpJe6J5a+avW2U6AH0BmnwzbhQIHzq1ZOjaC+Y915N/iBQpDCJB4ncfoc7afD5Lu+AcZRF1S+eiUiz5kU+Zb0nhekXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9lXNHytRumpLi9ouVnPMcO+/2UtjgGVAOvh3PkTWA8=;
 b=dKpXBx4k87BwkpFk6LK6HbawWh4VFUE+jhXrLtCsQ8rnL7dotDqVeuLvGKQsP0n6ZGsX1Wz1pzxovQQK+XVuYLHmWBh7zVW9dbq+rqO9RomzTuBiYyS16WxL8myWufbuwptGQJL+jDp/Cri7k9Mejk9QEv017CuHyaY5vzMJB+nRhok4VVofZdAGtKsNezsr2GdRdHstzelMkOJlQXfYA3j4n3HLBCd6W4unqrldM9uCSW9+V4lSG/C/wvTgLRqJcVMRc1fgYYEWKuo+DmW8VAZd5OgFgWaPMolYDsn+HDwpBptXzqbTTXdaxo6PyB9yNpgaiIC44JE0LXWrVXWFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9lXNHytRumpLi9ouVnPMcO+/2UtjgGVAOvh3PkTWA8=;
 b=bVqelF0MXMNNma3QiuINyn32fgUMBqc2sDcJqG2faHbWsUX0ZTdwgxLb0ARYXNomkjktLoluTRccFzp1Y1Ur+IR+vb4YaSyfl+4aY6Sg0bWzUeRhY7zOTG9Dqn/pWs0nvpPtk8VHV+MSHNqSECYOWnB9vmUln2kz3uDaIR8HjhQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6867.namprd04.prod.outlook.com (2603:10b6:a03:22c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 01:48:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 01:48:41 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Puranjay Mohan <puranjay12@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Thread-Topic: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Thread-Index: AQHWzAhI9dB/zhTwEkK+svNTv+xS0Q==
Date:   Mon, 7 Dec 2020 01:48:41 +0000
Message-ID: <BYAPR04MB4965B160F84F31303855501C86CE0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201207012600.GA2238381@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ecd96a0-3df9-4dc9-0147-08d89a523954
x-ms-traffictypediagnostic: BY5PR04MB6867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6867E5FB80B4A501B02A72EC86CE0@BY5PR04MB6867.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsNsdLlzTSRPDJx/p+NEHX5Rq0Lk+1ucvFDMLoIumupm8fsvVGPNlQvBFGGMYB/O9MGoUZU0WHrfy9p66KaK0MvApVTIh9ddgv7BUGOC76B+vDQI7+3LExSb/Hsk33UgQosbEQSJMLXonJcBvcFJ7N8gnbUpuTVnWScqxk9uEc7Cukl0Jrk8PRbWFJpWwn1jOGKGMLOuus8OQP0rgQJXEataLKjRrVmN8oBm06Akz0pNHu9MDhkUUDqheO3obFgyvvqyicMOvDDgqahxgy3ESNjn/pmsuthRvkHnq6XLJ0pori8jTIvPIliOh5n4OV/8j8aB3Z8PIeMQqLa/piigqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(71200400001)(186003)(55016002)(5660300002)(478600001)(9686003)(8676002)(6916009)(26005)(4326008)(7696005)(52536014)(8936002)(4744005)(316002)(2906002)(64756008)(54906003)(33656002)(66476007)(66446008)(66556008)(76116006)(6506007)(83380400001)(66946007)(86362001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hWQgouZOsXTiPK+hCXlHj4UR7cBdFnW5Amx0QUrie8xkF3fxqkhS2ae812n3?=
 =?us-ascii?Q?5uIAPoTKn/WXUPY4AG7PSA1q8TMZ5voQeob++2kOproM2eZ3HfikiOGmpGpx?=
 =?us-ascii?Q?WyVA/rg5blBTBhbDD3dpWmjghU0mmzhIOIV+bLBc9uqyuZ+rhgWWs6DonSl8?=
 =?us-ascii?Q?iCl8FkNlDIUeIa80VtdruBMi7uPWMk9hA2p18T2jQd2a3gfeQ9207IgZKfuq?=
 =?us-ascii?Q?yH0+NWzpofDis2mSe1o0BrvWuMYZbQmkV1A8axR/UYKejmKHi0/UDHQk3rH3?=
 =?us-ascii?Q?a13AGGzQN5waGgO2RSzWm2CUz8k+0R3F105eiLeqxJ5w/u6hCpQvK18jz1/o?=
 =?us-ascii?Q?4i5uznPAQ0+d0WB+HVfB5rByRYDTR0d42PtB4Koiw4whIa009GkP9fo64xgc?=
 =?us-ascii?Q?3fNUmLrvea1m6M4h9vYepgO/eSc80Oib34N1GZ29aJS5CI8UF8A7/aptUpDk?=
 =?us-ascii?Q?tjx49SxSWuaejudA+B95wH9Z88InLg5U95UQGgajS7KclDgOn/7fgP8RGUWt?=
 =?us-ascii?Q?4SDega8Si5sqDAqoDfj4bJS4xeCDu74ru2zTymbYNSivSOh0RzAzJo1LaNk3?=
 =?us-ascii?Q?RIzrlPbmvPWjFhEhmuLyIATz/d2UbdSoXofT+VHV2gBOy0iGQsQdOAS+zkX9?=
 =?us-ascii?Q?INjNo0009DdKgZVZEsq5PnjErxIzl7KB+e3MWU+otRYqWe1a0v8gGzdA60ln?=
 =?us-ascii?Q?dLli138LtBM/SAxcb21JSjyZ0pGNkqmGRYbyEuhznVqN/KMsYGRIIV7DZU/3?=
 =?us-ascii?Q?XC5F2ckfGov96uH+tDOs86BWbKyDWfILkLLG0ExJOrCk2JlR4iLogdsyaMex?=
 =?us-ascii?Q?uUxKRInQmxgOe7E5v79W9HHLktH8Hs3l5qKarBkqJWEoO7dm279GjIpOwwZ2?=
 =?us-ascii?Q?Xm62z/VdxcAQ8vBwmg4qxaoy1JDuN4SL++qfzlFCQKTkY1DZC3vWthMMyhCz?=
 =?us-ascii?Q?FlUezzY2EXrWmjOk2/bShuqg0pfzR1gsHQCHZ1QSycBCfYhBEmNkznt31otE?=
 =?us-ascii?Q?3j+w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecd96a0-3df9-4dc9-0147-08d89a523954
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 01:48:41.1838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKtqmBgS+uIz5kziGIThA3PtrCds70qlPUwh9FcxaqI242fu0Uk5ZlE9hIL5kvL3MGh05+8fuWYuV8AArYOpIsKqYR1ks9JnhjawHxXxirQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6867
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,=0A=
On 12/6/20 17:26, Bjorn Helgaas wrote:=0A=
> There's a patch pending via the PCI tree to change the return type to=0A=
> u8.  We can do one of:=0A=
I did not know about the pending patch, if that is going to change the=0A=
return=0A=
=0A=
type then this patch makes sense.=0A=
=0A=
>=0A=
>   - Ignore this.  It only changes something on the stack, so no real=0A=
>     space saving and there's no problem assigning the u8 return value=0A=
>     to the "int".=0A=
>   - The maintainer could ack it and I could merge it via the PCI tree=0A=
>     so it happens in the correct order (after the interface change).=0A=
If we want it in 5.11 then I think PCI tree is a right way go about it.=0A=
>   - The PCI core interface change will be merged for v5.11, so we=0A=
>     could hold this until v5.12.=0A=
> I don't really have a preference.  The only place there would really=0A=
> be a benefit would be if we store the return value in a struct, where=0A=
> we could potentially save three bytes.=0A=
Totally agree.=0A=
> Bjorn=0A=
=0A=
Whoever is going to apply please add :-=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
