Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21D2E9D44
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbhADSnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 13:43:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:10336 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADSnh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 13:43:37 -0500
IronPort-SDR: oL9RuXmGpMsp8JOLjfZq09EndBdr7xbixY7oy64leFJ3i55soG1+CQQ3n+L0vJl72FGNVrkaMI
 TdbNqi+WnE4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="177093500"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="177093500"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 10:42:56 -0800
IronPort-SDR: 3CmGvzBPKxH11JHCfYQ+N5hIEcvaI5rlVAXXcQ7GD6EPP8l9DZBHMSHS1c6OPYr9jWUTY3huxF
 n/DMK0VwNipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="565189547"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 04 Jan 2021 10:42:56 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 10:42:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 10:42:55 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 10:42:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jfa5H0kML3N1r3hxcUGQgLqECdLc8K/q7FlnE0qeQy2TB1tJqcsyOU6oYEieVpN3ZShLhINTgNRIyvgy0WTBjKBRZt6GHVY30+prXt3is7r43EHfOQwnOcn6awFHYy4m3WO/PGaDsXAKDbVujAyv+frusrfaNrK6a+oqbYh7aC8AsVVzHWAiOUb4IlGhq0hga6jXKqeZEZ/w4luOVYbiv1c6u2RZEG6g0r0occ0djUvztlZoJpzrSzm9jeFOo9PAq5Run32chQQlvPwr/Pzn6U3LwTQDaX4ljKiCaFMXLEcK0Mo2gyiavnLfZZUlTvtMHCVLOSH9lNXHxaDmkZH2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo8PoLbRr7ctth9vhms8GfuIpy3lKs2PGvrFgkGY8Jk=;
 b=awTSRZydpXaSHtyjADNaenqudeClSIkYrMBf3ygAYEZw+piMbd0TLu9S+ENdcKYYpdPcncXChQgOAMQSWs0/jm++lgmqNl0E2kWX5zxfHQFO278gt1SoTx0eUk7ndbUGZq32PAuaQX35B8AFADSnLima8U7owq9mpZ3RGSlpaSyHvNbju3xrpnmJCTGz+SaRRQbq/KhNWwpUH4n8nXJ7kEk+v9W8Rpfwhkjsi+lKsVjZ3jfBwANeEsW9SqksYFsbeIbyl3QU4DYUP2iIDFxrgehscZKotkUYuthuvfcLP94dcBanmzsxeXf6MJOukbZJir0RUw34mgf1FcAq8UwRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo8PoLbRr7ctth9vhms8GfuIpy3lKs2PGvrFgkGY8Jk=;
 b=sedksogr3Uo71kzd71j12KXZkwuwTAj3p7LEh/IEQVIS9A+cWPnwxOTvzfSvVVGBhz2M+fUcNV+SX1cnNA5TBH9tOwV+dddetCK+bjq/Uj/ojDfF42LRdAtfKahiSVzgUFKK7M4wJ9myElrmywp9Ag9FhMatapFvsydTV+iMDT4=
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by MWHPR11MB0063.namprd11.prod.outlook.com (2603:10b6:301:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Mon, 4 Jan
 2021 18:42:53 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf%3]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 18:42:53 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/3] PCI/ERR: Clear status of the reporting device
Thread-Topic: [PATCH 1/3] PCI/ERR: Clear status of the reporting device
Thread-Index: AQHW1JhS83Oik9x5NE6eskpIl9h0qKoX6Z8A
Date:   Mon, 4 Jan 2021 18:42:53 +0000
Message-ID: <FB1BE1FF-7B41-4EA7-9180-1DCFCF25C39F@intel.com>
References: <20201217171431.502030-1-kbusch@kernel.org>
In-Reply-To: <20201217171431.502030-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb755121-f798-4420-d10c-08d8b0e08b97
x-ms-traffictypediagnostic: MWHPR11MB0063:
x-microsoft-antispam-prvs: <MWHPR11MB006396E3B3079525DC97A749B2D20@MWHPR11MB0063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejvJUSRkCCcOOYt8lS+XXWFRV2bRy1+MbMfmJ5rIQVNHjbrAAsqU+vPIMlsDPc/jjwFAYMueYRtOzntYfalAW2bZhC3yQU4zSLBCa9mUuEBiJbSObatzz96nGlas/x+6cgZTsNrVaJQhuIvZwaUZWtBgiq9+omgdafwQguQcVOMUylsB5jnur2d58otKSQwNpspaNQll3edSHEwe8bY/wwa8URys1PPNo4j9Da27+ULobz6u0sAXjmV9HHbx5tt+pdiiiCucHK5/P6jqaV8H22/7KXn68QA9Bdk1xrTJ6mPB1PlGTXsdLM4LKJGRBzbo5k/1nZ++YMm+IGKNKzBh8dei3kwLIshA8hJS1kD308KlXa30uZ+0cKRudZmyc2QzuSNEiSJ6TYm2sji4XhUk4UQHO0cz+faSuakAfWDp59MLzdWOsh8d/MxsrAAQkiDq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4929.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(6506007)(26005)(8936002)(316002)(86362001)(2616005)(2906002)(4326008)(53546011)(83380400001)(6486002)(186003)(33656002)(54906003)(8676002)(66476007)(71200400001)(36756003)(478600001)(6916009)(66556008)(76116006)(66946007)(6512007)(5660300002)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K7B1S1PbSq1UjHDft/mPHItpaZQebo2uBuAisFMJVcQCZXE895seAaXFn+Fs?=
 =?us-ascii?Q?p3FmZEBqCYi1yi5Z3SL1xRtazoK9cp3CKtqKUzfGPYss0ns97iM7bCiDfDHl?=
 =?us-ascii?Q?puBb5WCkObVbqPYxtw0Wx/wHko+lNKOqab7eBxsJ+UNl61ENdYKmO2Jvf9Y7?=
 =?us-ascii?Q?fmGi9gedx0qX7fLIhAh4Jd9nBDQD9/EMKccH5B52HuOZcM0EpTHWnST+7BXy?=
 =?us-ascii?Q?pUY01ElNxsh/QCoQbsaMy6Rve+FVnTyrFVf2dAiNz33Z7ZKPJtblUA9pJLYa?=
 =?us-ascii?Q?ugywUCwEP9bwTAlPrDqSRw7fiv0R9wRrGvEozShk1Y4YaLXN/Dr9BVvTQer2?=
 =?us-ascii?Q?qjXBcYhDzyFZlKWuh/MjxVWG0gy2MrzMH1tk46sjx0tUlgN1TVg3eG1YYcVn?=
 =?us-ascii?Q?/DEqoSc+xGjGddczL/5vH9p+RuZVCFwheFsyghefzBgheNicO+lC2udhy9gL?=
 =?us-ascii?Q?5wPeQwzkz7AWo1FbP4r/ZeHQXQMXC3OyHONoi/55OJ+EsEK8SUTLaXGbnsbN?=
 =?us-ascii?Q?OohcSRtuKyY3L6tiV9XKj0gLHhUu32BpGcZvPoHj9ToYFcI38zBbhx3n/obx?=
 =?us-ascii?Q?AsZSEqjHfw29T4vXSGsah6ujmNOU/S4g6RxZzU12lRFmVwscr15/teEk2Tez?=
 =?us-ascii?Q?wXqdoDw3tlU82Af3Tn/9MR7OraLSy4HNreU+v34EO2N6f6GshUMfwEjG06Lf?=
 =?us-ascii?Q?aDupyfHS1C/227bEzOQDzjs+xZ90Iq6lK15TktkJEJinEuj5/QMWVdoagSdI?=
 =?us-ascii?Q?HT/ineHDZMdIxK8KHec6sxYeVPF4LyOb1pf8ieVH35zIqdZJ/9OVxmmyt+9s?=
 =?us-ascii?Q?B7jaY1hT/2eDOzMBdk0bzLOiJOaFudEh+FtyqjD+CYmkqLKHzMYQO1450eWr?=
 =?us-ascii?Q?9lACYN/Rus6LN7lSSMfgHf5GhJthFB0yJA5FpEloVkTZJUDVgqwbtiVHCe0k?=
 =?us-ascii?Q?utntDSR+EUCyzRxrw8R6QzuAIc76DgqZqqFVqj9f6VRssUJSYkXm07yeEJ53?=
 =?us-ascii?Q?oQM/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1778329ACD1F44449562C008581E0FA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb755121-f798-4420-d10c-08d8b0e08b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 18:42:53.3363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQ4MydGqfWEb//FVVCi+6tzpgHqx0VSmVMrXztkfgdNFFyUjyTqc8wnZQ85kCgegwhayemDX4i+3dPNJ6fXLjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0063
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Keith,

> On Dec 17, 2020, at 9:14 AM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> Error handling operates on the first downstream port above the detected
> error, but the error may have been reported by a downstream device.
> Clear the AER status of the device that reported the error rather than
> the first downstream port.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> drivers/pci/pcie/err.c | 13 ++++++-------
> 1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 510f31f0ef6d..a84f0bf4c1e2 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -231,15 +231,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *d=
ev,
> 	pci_walk_bridge(bridge, report_resume, &status);
>=20
> 	/*
> -	 * If we have native control of AER, clear error status in the Root
> -	 * Port or Downstream Port that signaled the error.  If the
> -	 * platform retained control of AER, it is responsible for clearing
> -	 * this status.  In that case, the signaling device may not even be
> -	 * visible to the OS.
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> 	 */
> 	if (host->native_aer || pcie_ports_native) {
> -		pcie_clear_device_status(bridge);
> -		pci_aer_clear_nonfatal_status(bridge);
> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);


This looks good to me.

Acked-by: Sean V Kelley <sean.v.kelley@intel.com>



> 	}
> 	pci_info(bridge, "device recovery successful\n");
> 	return status;
> --=20
> 2.24.1
>=20

