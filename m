Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2402F2E9D42
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 19:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhADSnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 13:43:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:44956 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADSnw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 13:43:52 -0500
IronPort-SDR: 76wBC9sSlD1Q5RX0J23J8s5S7QMIgvDuhxLCljUhJGqJrEG+t5tUNjRiv4UVe3XN/uK7XY64VK
 iSELCxb8s/bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156185418"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="156185418"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 10:43:10 -0800
IronPort-SDR: XXKS6mpEkrs0HlArVYqk5SU2ji/YRw2RT5uDc+KwxfPiSqULEa8bTRahscAN6LhTwtFl2CEhKv
 Lu4B3sDf/4lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="350041553"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2021 10:43:10 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 10:43:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 10:43:09 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 10:43:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzCKD6MyWtIbtB9CM0mprdvxUGi6QFdUI+HhKWxHtwVxsj4Ass1J7ZHVd5izLb2Z+d/JWuCMg+QmZIc9R7TJ6l/XBvZ4Hd8/YuonOy0MafikDMNNnRvnwHcS7tT8sWA3XmJ0+pJm5mG7wwqy6R6USm0STUCriu++Io03HsDelAxU6lfj+4KkzYCTMkESyhLuQQXfyKzVSj+sbN+oL/AoT8Tj4iUsWKcWuXY32ur03/caW0d5/vIe84D0BXl9zFIMeOXMLo+BFrGKkgumC/SCo8/BQE3tFn7zSsuCAbOhwTPoplPqV++GYdlsHnUoLk+In0zozrh0KwRKRiv1ngYyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DolI/jmfJjitcmaqrsegAulb9mFCzC7N1WpeSAwlUXk=;
 b=hePzUyiSP9mueOGgbfAY/Ub23XEQz4qRWoFVmdBPxSL0Id20PVPWNnUZmtFFc043H72sJiMUExd+rbTY60M3EZOofn/R4l62lVtrRfF97y9UkdniWGer89f6tOT8GU5sRXkS9UjKrz23FFol1RalAMxo+dfdkdLA7kJJYrVxZ2z9J3RdgU/Js6SeR4idkoN4VGnwEaXuiG2Y2DL2PvPkxcMHE9pDI+UnWKorxqbmpW6cHA9WuN5Quc23vgVlf8Uk4O9SeWBBcHka0UJRRqB36zeFiv3X9wxHL5dH/vZVjsNK/3+Wi09eq49db0tB+WjPpUunhoeJTyhbqEq07KqhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DolI/jmfJjitcmaqrsegAulb9mFCzC7N1WpeSAwlUXk=;
 b=inrCINDjb4vDIGMTSUeu6m8f7xKceJdUZg2WuyqbKqGkzGxzyovq/sSVkxusqa935XYuajuyVDoCKJeV4neqGlgWwDT+Blff2+T2U4K4Wg8TfCrfckKovMFU+4QJpszh7eKXpVOlNGjZ8jZoY9mXVuRMy08ttvN+xSou5JsRS0A=
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by MWHPR11MB0063.namprd11.prod.outlook.com (2603:10b6:301:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Mon, 4 Jan
 2021 18:43:07 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf%3]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 18:43:07 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hinko Kocevar <hinko.kocevar@ess.eu>
Subject: Re: [PATCH 3/3] PCI/ERR: Retain status from error notification
Thread-Topic: [PATCH 3/3] PCI/ERR: Retain status from error notification
Thread-Index: AQHW1JhSQ7zZ5YDdCUOeP2FWQ3IO6aoX6bGA
Date:   Mon, 4 Jan 2021 18:43:07 +0000
Message-ID: <A7EF1D77-1FBC-4B8E-8720-7D33F127CFFF@intel.com>
References: <20201217171431.502030-1-kbusch@kernel.org>
 <20201217171431.502030-3-kbusch@kernel.org>
In-Reply-To: <20201217171431.502030-3-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1264292-598c-481a-bf48-08d8b0e09425
x-ms-traffictypediagnostic: MWHPR11MB0063:
x-microsoft-antispam-prvs: <MWHPR11MB0063D99EA8D9F0B6FB5336C6B2D20@MWHPR11MB0063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKdaA/rKe8zI2HsXUPNWx9zn9TbYILhGMfFDC5GFW8eDzXrTZuKFUthUkVoPjtOI07Ub+bmAwfhKYVAuBBGN51P59gP7iI3LPm3Xkaa4lJ7IG9b49OsFmKyBKMqYQ5r7r5Y45VBRykk32wPPJXdIAWbXBb5OhttZjvEJOTzDakpfDGcoFqXlpvu6A14frSonIsgdF0qD2IiLz+tjUyOjUasanhnLS4jovZXzAlI5QBZc2wxATQZGt6pDzyXHa3Bxie4OLL51zswH8SjJ/nTUiQEeJ/cimckvS/pVxUKPOKhRKFVQQdyRt+ePMv5AOcSj+tNqAoLT3f7+bwW6O+3GRsqoISDr45gjKE+7ly1t9+tND9Q7d40ur0CiDpAopNBNMquWApje9885QQqUDu3ixnG904EhKOakTyhb/WiTRy0IoWg6gShO1Vq7nJwHMWEK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4929.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(6506007)(26005)(8936002)(316002)(86362001)(2616005)(2906002)(4326008)(53546011)(83380400001)(6486002)(186003)(33656002)(54906003)(8676002)(66476007)(71200400001)(36756003)(478600001)(6916009)(66556008)(15650500001)(76116006)(66946007)(6512007)(5660300002)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DmOxEEgFj3Bqb5gw/2JGzPnEgk/G6gOYp8XEeSbLwH897oCDNjIG6jtlxW4W?=
 =?us-ascii?Q?CWhFFItx0ZyZJ+ibgJSYGs/JgZdu5CWJnSl5uUCH4SPPetk7bqNVdFRb+iM5?=
 =?us-ascii?Q?XJmqQ6pD6ZsZjobH/D7QBwHfqlAMJB0wWTZ32mY7sUy6ErvZcs0sHrUeastl?=
 =?us-ascii?Q?GrrKchQDdOEaF8rOupczHTRSRXTzjfcxYnNhNLJ9PQtCpJkmrh1uKJcuRFS4?=
 =?us-ascii?Q?uUC+zJeHLQRYl6kYjReN0V1yhTrjosJFhuWP9A8A9FOtb5Ue4cKdbFczzBZV?=
 =?us-ascii?Q?rnyrkFMiWEHfbHwGUbv0oEeCV2Beh5i9aQPqtodqP3XRmBnbMMX7ykX/VaNq?=
 =?us-ascii?Q?yapWkHPrtjHhqulo3HaYYVJTUEsdAEburlcJ8GQ1aicOV0NoRPcXQn6P8Abo?=
 =?us-ascii?Q?uOLce8paoekO1DwsD7bVO8NgM666PdxCakvBA/r8z3z40Ppt08y+08GBLQ/n?=
 =?us-ascii?Q?2ne0balhF1c0PzCE0d6nLyefLXTGL89+bm1P/jd343LVxV/HdMbzVMqdQDRh?=
 =?us-ascii?Q?GyZ4o4uvl0n711gya81a44znvKcD/KTcPAeyVDgHf6TP0lfG/ZLhb4b5SfrB?=
 =?us-ascii?Q?raNCFvcSDmLUGDlfeadnIloM/5daDap3/kxeZYS8UYYkv3tvGBWWIprZL1ci?=
 =?us-ascii?Q?WsKqLBUncbNeRcYy2pBlOZCuxKm+lI7Lq8raGK0GyiBfJ3ipgOumrSg0BASr?=
 =?us-ascii?Q?vepmqcE39iYPAQ5O8b4G+KY3M6u4/YW2S11vo3EIM9vy7auyjBls8M6FSD+u?=
 =?us-ascii?Q?lrF3tuAvfjIVhBd5wTPqHGCuoRJQIaRFc3ZKJmQOr2fHAeBoXYjDliucj03u?=
 =?us-ascii?Q?wCofKKqHqreobPy6IlXdgRdxQmI7elmqoa5bSd7OrZVWkgqkGaVHpVhVGngB?=
 =?us-ascii?Q?WZUIuad7riRu77YT9ov9kUiDf46nCjsmnWDhmKcPWcr55V7svAo21CBTdvc0?=
 =?us-ascii?Q?tIqI1FmBiD1XXg8+99MDl7lGfT/I3QNSz/o1944BBH+tbjWxGS0Ug8s7jTtw?=
 =?us-ascii?Q?VNO6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1918DC86D1F2494C875A64359772E60F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1264292-598c-481a-bf48-08d8b0e09425
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 18:43:07.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/tRMMgYazoN7wd7Q9SOL4OglDH0TGMmA0j9fhrsmpaF2VS0dW1wMDIRY0K64z/LhWDHSLbtImFVUKqHvQMOxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0063
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Keith,

> On Dec 17, 2020, at 9:14 AM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> Overwriting the frozen detected status with the result of the link reset
> loses the NEED_RESET result that drivers are depending on for error
> handling to report the .slot_reset() callback. Retain this status so
> that subsequent error handling has the correct flow.
>=20
> Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> drivers/pci/pcie/err.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index a84f0bf4c1e2..b576aa890c76 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -198,8 +198,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev=
,
> 	pci_dbg(bridge, "broadcast error_detected message\n");
> 	if (state =3D=3D pci_channel_io_frozen) {
> 		pci_walk_bridge(bridge, report_frozen_detected, &status);
> -		status =3D reset_subordinates(bridge);
> -		if (status !=3D PCI_ERS_RESULT_RECOVERED) {
> +		if (reset_subordinates(bridge) !=3D PCI_ERS_RESULT_RECOVERED) {
> 			pci_warn(bridge, "subordinate device reset failed\n");
> 			goto failed;
> 		}

This was an interesting scenario for Hinko not getting the NEED_RESET.

Reviewed-by: Sean V Kelley <sean.v.kelley@intel.com>

> --=20
> 2.24.1
>=20

