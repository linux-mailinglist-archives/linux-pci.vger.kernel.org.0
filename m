Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7571B279D4F
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 03:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgI0B26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Sep 2020 21:28:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:45502 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgI0B25 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Sep 2020 21:28:57 -0400
IronPort-SDR: ETJLov9cqP7+0uvkhFcPbBElYHLhUON0K867TzTvQpbPmd6iWDCGxOK5Yp/1Tt9lwvKgaIqPZH
 5c3M4EsIvhAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="223414664"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="223414664"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 18:28:53 -0700
IronPort-SDR: yb0iWlvgjM9+tdxpaKKhjBNtkFX6UK3OkHo7FRL0O/MV10K1LbhNvH4NIIrEkKLvy0PslCgQN8
 Di9N0liqakzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="384038056"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2020 18:28:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 18:28:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 18:28:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 26 Sep 2020 18:28:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 26 Sep 2020 18:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNz4T+qFH9EPyk0BMA0udzJ/1yxdcJlbAdGg9xo1Jj5uDnYX3YxAInJwwCFCw8+8MUdeHrk/OW5TapIvbDCAO1fhhs0IDP+KL19PHloHOZ6rC8bkyc+mj0ovFGDclh0BRFVgJWKImBtq2+Pffkz5kpouMVAcbH/CWhBQ0TA0HbTHAuvw7M5YILxXRIzvGhjVSEiG2zhq2+MNhICsuYKzyOCoVwcTnE3HqoD4gBFNwrreSZB+x57P7v10MR4VeNm7Fxzs4kicyjoqC5VCGOkNcCj9/zee71LRH6jPx3SeQzxvYg+kG9YoJ85T1mszSGp9rELlMiFgrLC8XfVmxTbAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGrcuthCL7xUTkNX1ucKlWibITDzMNDJsQJZxkmnnTc=;
 b=hWWTbwGR+t8qXj8eHW+89A6RR6xiOiDrrAb1Lb4an7mI7kFvuKkWVLAGE6PjFCooxVTKqs8tmSVDUHTnHmz/cMaVrbqvYY8fBjpAG26EaGW5on+hizC+gMI5WaFx/hfmjqfgZn3iEyBDBcidoLX4JOblLEFL9zn8rKauqfLSh/PdQWahQ64SxxGjuFkp6yegNasa2SG2R6PrKDf/4HQdUqz8vSO6mPcd1SIsjCJXAHPR7YZVs25ruL7B4/DnVFSq7Q8NPPryJFgZwmhGValXpySw8ygN9pACydtKTE6SqmP1MAk36VJ2ZhMR/QRP28hPiGTneVffbycY/v7upsUoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGrcuthCL7xUTkNX1ucKlWibITDzMNDJsQJZxkmnnTc=;
 b=XbBx7unvb9f++LrLgRPpq8XJHqgwpFN0uqnHEOvoNS9aJTpdfDkwCW+ioz3cGpdrClU97Fux1YUDu+eoHOZxbQcT7lM23o4yKmvup4CDj4W7XWe1HPgSIOhKNrTYo6leJfFhNQXraOC7sIlKw2+PSZz/8C3gKZzQD5ZA+b+z6xc=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR11MB1837.namprd11.prod.outlook.com (2603:10b6:300:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Sun, 27 Sep
 2020 01:28:50 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.025; Sun, 27 Sep 2020
 01:28:50 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Subject: RE: [PATCH 4/5] PCI: only return true when dev io state is really
 changed
Thread-Topic: [PATCH 4/5] PCI: only return true when dev io state is really
 changed
Thread-Index: AQHWkuSfPEiEZuxyNk2KL6NQhHM8Fal5S6UAgAJpmmA=
Date:   Sun, 27 Sep 2020 01:28:50 +0000
Message-ID: <MWHPR11MB1696D14DAC8C5C796C526C4A97340@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-5-haifeng.zhao@intel.com>
 <20200925123806.GG3956970@smile.fi.intel.com>
In-Reply-To: <20200925123806.GG3956970@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 857357a8-3b19-446e-6018-08d86284b02c
x-ms-traffictypediagnostic: MWHPR11MB1837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB183773AD1407DB987B3DED5C97340@MWHPR11MB1837.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QXUKvanEoFwGqbmpg3maZS4FXVkihb3DimQlW01R+1crxj4rCf4XXyX8HT6PDTIwgKMMJ/Mww4DmjMcc5hsu0DC4MQkkzA5iLynXIjeS+9l0acml1QUfX8gxij9OgdrBp9lWLkNc+I2ynaExUMhJT0r/+E0F7m79aWUWa68w5nlpN6DOg06J6D4jv6e5I/L807nOkFGFZt9tTe7SoHJmOh/xSDNqbcNMI5qwQeu37YCuuaB26zBEclHM2xdr7l0jBIJuhZPvuCDPfNl3fkqavPX+/GXuNLXzAZltY70scPiBLVzB1n6Tsiln1K+68nGegcxhNQwUMfbesTXv7g1Js/RFYbUXcX8GNkYhvIskhp97LbPL6doxS6S7RBbpnx+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(66946007)(83380400001)(54906003)(33656002)(478600001)(26005)(86362001)(7696005)(53546011)(6506007)(76116006)(66556008)(66476007)(186003)(5660300002)(316002)(52536014)(8936002)(55016002)(4326008)(2906002)(9686003)(6916009)(66446008)(64756008)(71200400001)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qOgMqTHHthiJhwsNNyollsOf2G5mevHMzznUPoQvYoD1tjIAHYd7RES5RpMSo4aE6Iv5ffx3iW9RRw6F3ZMCVdskfBUty8TcNtK0n38VUHWGWksUg6fUORDCSHQKj1ZoVM4MavS02MUzpqBS0b/38P430UV2JlSb0JSycGH7ICOT3fku5KpM/N4BLqCIXuu0TDPVwubHD+ofDaz96vU2gV2uYssK/fK6V6Nl2Rs1jRcRn6WzxTV0Rq1quC4pZaUJGzfo0yTKNNUzweq6zBN++hAjRCvLdql9Z2uCXQ/3KbEu+aIGLcbs/b/qASXaqZFsxZdsDhfHuJFidxw19OFcmaX5mDY+/6xoE0EtOLk5sp7bg8T0V6E20xhZx6PE96iPycF5Rmo1OpvhhPk+O2Zn1+czkp+FT9cbjX5fk60qmguk9xZifwktlaVKvnH84Ei04pdrs+SrJN5CzJ/cV+Jz05Dq7LyAGlhCS87TD3837FaNtHlsogGDO7STQLB7SCDgTx9wSHIXr6e/UqHxWO1kLuAMOsrWZBYORU5Eo1Q2H35x7FBmOydb3sB3Wc2GIYpbdLGUAm+2EPVHgKT7ajCGXK2OZAJ0VsLwwF7zyzxSgOV57FxIDsxSmzXCde/itPyCm/IDLX0NzNDbR0B3J7ND1g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857357a8-3b19-446e-6018-08d86284b02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 01:28:50.1769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/CIX+2xFkBpry/MJ3cDvj10eGvr8KeAO8seC0iTpSu9U1VMx/ltP+fwrEJnd0bjNzK9ZvDtcy9Y4MXz0kHiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1837
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yes, better !=20

-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Friday, September 25, 2020 8:38 PM
To: Zhao, Haifeng <haifeng.zhao@intel.com>
Cc: bhelgaas@google.com; oohall@gmail.com; ruscur@russell.cc; lukas@wunner.=
de; stuart.w.hayes@gmail.com; mr.nuke.me@gmail.com; mika.westerberg@linux.i=
ntel.com; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Jia, Pei=
 P <pei.p.jia@intel.com>
Subject: Re: [PATCH 4/5] PCI: only return true when dev io state is really =
changed

On Thu, Sep 24, 2020 at 10:34:22PM -0400, Ethan Zhao wrote:
> When uncorrectable error happens, AER driver and DPC driver interrupt=20
> handlers likely call
>    pcie_do_recovery()->pci_walk_bus()->report_frozen_detected() with=20
> pci_channel_io_frozen the same time.

Call chains are better to read if they split like

   foo() ->
     bar() ->
       baz()

>    If pci_dev_set_io_state() return true even if the original state is=20
> pci_channel_io_frozen, that will cause AER or DPC handler re-enter the=20
> error detecting and recovery procedure one after another.
>    The result is the recovery flow mixed between AER and DPC.
> So simplify the pci_dev_set_io_state() function to only return true=20
> when dev->error_state is changed.

...

> +	if (dev->error_state !=3D new) {
>  		dev->error_state =3D new;
> +		changed =3D true;
> +	}
>  	return changed;

Perhaps
	if (dev->error_state =3D=3D new)
		return changed;

	dev->error_state =3D new;
	return true;

?


--
With Best Regards,
Andy Shevchenko


