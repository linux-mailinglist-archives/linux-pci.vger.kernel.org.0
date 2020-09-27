Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA65279D5C
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 03:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgI0Bxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Sep 2020 21:53:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:51611 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgI0Bxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Sep 2020 21:53:42 -0400
IronPort-SDR: mvER7ZuVnmDGwuJ0/GAJI53vkL5O5YrIMG8fCsAzhjHwRu+vIbhwWIpBA7pOlPa/o4JYu4Zjzk
 Dakl2Fhm9kaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="161879725"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="161879725"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 18:53:40 -0700
IronPort-SDR: DDuFyKKp65KrYcYRI2fwuvna2Zxcegcbta7/geT3wMxDXqn4vzM9e9o4jZHzkUFjJw+KIYPA32
 yI4YP8zDpd4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="292819886"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2020 18:53:40 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 18:53:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 18:53:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 26 Sep 2020 18:53:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 26 Sep 2020 18:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhVwnIWZmF9sgk2YCsuq42QVXv4qULFrJkTRbxIdLCULbnIeaxbaj4sEnV3hJltY10wLG+qP5daDDqXZGfh97eDHYt5+YEx5aJ3rlo9cbxJUNuG9lOyC7T69FMBRfyy4ZgjM5njW9+M9W8MW4MIsnfKNrqmEaXA4wKK78S1nzN1B2ZhWmcZlCS8fn8O+hxUG1Af3AjINmsn4gV0M7XVbzvuaePJSHiVG8kfbpwqmyustmNq4GERUE4pEZugn0raF9Ko4baGOunaVn9dTRycUNIGFRt17mnjbgONYzGFECGvtjVdj9KrlphvlPM/mAk0K7m37C+bgcszmU+2iJwogNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ak1cN+pEzIhKg6HlsTYKvJfVcpUvF93H96fwSd9KBs=;
 b=in6RzIDaoazzdCVVmJFvHmBdHr/PURLn9trUw1uZ6ArnBxfZWsVCk9ZGxR3mP/bjMhf43LA3MvQoq10a/mObpWzywkm5GEQUWnb3lTsXIiSBTjVujUwjqgvzWajkYKDLAmx4iSCOxS/D84CSo25nJlQAVY5gqjW3YGbZd+4Xquz5+a77qpRI1A68u0PEQjD8aLNirPy1cu0LwgPKZcVhqInsn5Sir6YMzpvCtp+FpEGzUls5xXxI+4lned/7C5jw3TuvI5dJuZxF/DIqqyzWwOxYAhFR63mN3MGALxn6r4Io+vIEzuAWEWH5ZEPzDPSupVkHePhenNMriplvlVbKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ak1cN+pEzIhKg6HlsTYKvJfVcpUvF93H96fwSd9KBs=;
 b=lhTFLhhtXaUjiNhBCxN13DMnmcpVhzui9PbpZtTwz5URO0AXM6tVQoCf92YZaUZolc0aDUe9YlS2ygDXtdIQqyyz5eOHzQ9tUKRCIRkZm4mkydDhacLdMAV5y/Eyq9YMz89tHMIOQZ4dlU+Iq/OjtAoGPoB99Bxdkk4SnsPsKl8=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR11MB1279.namprd11.prod.outlook.com (2603:10b6:300:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Sun, 27 Sep
 2020 01:53:34 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.025; Sun, 27 Sep 2020
 01:53:34 +0000
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
Subject: RE: [PATCH 1/5] PCI: define a function to check and wait till port
 finish DPC handling
Thread-Topic: [PATCH 1/5] PCI: define a function to check and wait till port
 finish DPC handling
Thread-Index: AQHWkuSZzgPhMcakPkKIlL/b1ZMFVal5R+IAgAJt0bA=
Date:   Sun, 27 Sep 2020 01:53:34 +0000
Message-ID: <MWHPR11MB16961E9CAEB0121C339F399497340@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-2-haifeng.zhao@intel.com>
 <20200925122438.GB3956970@smile.fi.intel.com>
In-Reply-To: <20200925122438.GB3956970@smile.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: c35345f6-9fc7-425e-6f8e-08d862882493
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1279C0A70DA69312B401F56697340@MWHPR11MB1279.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rF3/kYxgsOXjNtw6WdvNxveB2/pY3iOAwXRtrhOu6Mic2gn/eGSKaw6FOrD6nvIsSJig+WfU/WvdrRsAINpe+zxsEQ1Dl8o2BBKqGCRfufTFsNCT0zBWNfJHnKA/UMiTdJnYe7kORRdnMwuPAVCIDyfKI2eh4QwzvVkKuFqsBvF72feB7QubSV8KZupHFxeDtvOQn8ikQ6DMbLNGBp4JT0jqfEc++ndxAEPBN8WzW2xtqjGVRO8LCL6SOUlGHMASjvpgy60uOQOiMB2FVkNuHqNHd+MbgpAjUFG0Kgu4terwaqKhtl/vhB6WEkYCmD87MhlzrRGvqkLNItcsuVdXC8VMvZrS9BoMnJA8a5aadh3vJSFkFqmsfLdCv9boQsGI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(54906003)(6916009)(5660300002)(76116006)(66476007)(66446008)(66946007)(64756008)(66556008)(7416002)(86362001)(52536014)(186003)(71200400001)(26005)(55016002)(53546011)(6506007)(9686003)(7696005)(83380400001)(478600001)(33656002)(4326008)(8936002)(8676002)(45080400002)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MfsNyNbl9fbi8Ag9NhqzvSdxS7D2CK7siG316q+qPMDt7x7sDD0VgTkqLcrSAwosXMK7SmbNXh4PrbWQ1iWfMuoerBdhbWTHth+I7t+atCFJ/G8565fYV0l3cOAPvIVEHfpIGdWaCy+ox5zwiVwafCBBHfd03DWmqllG4tCl49vSjgeEgzC+FQuKT+xxffAjCt6LDt2L68+5+fNoabWExdFOMs7MBq2Cqcd/yuXE8OXFx7i6NCmOlDTmtxhC13K2jnkxsi1QAeMoyIHvyyphDaPcyQXTFiCsFB60yAmxtfRxN7bSX4eFirE2/pfD2NUjVHamnlHF7JoIZnKrAFW7TmlsgYz0wMqzJ+ZaxWi680kaIaYZH1tkC45mOBWt9wFiiwUgRExQJ8lE1mBRnNsYd8OOZWuzLJlRuZedkGJ4O6cZkumQQ4vDC2RtKP5f+2cRmrr87gVU6SXPtTqnLwBeDpLdKQKUwEsnXvmMoVjeQs0kvexSAeBn1OjruDxqb8yQTNx2YBR1mczWcaCCoD9w8Vy/jTOFv3f3CfOR+/PvrW8OmvRXhackR8xoS6ZBhCyqkPRdcEEU5Ya8DoeT5w9x3wpgGC0f7p1Wfz2ou3tyFYL1p8xsIDt40rYt8ZOtiBlTtsghFAUESnJmgYkkvX026A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35345f6-9fc7-425e-6f8e-08d862882493
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 01:53:34.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySNDLQGfAjvJmlKtQ8QgzUw0JQyYAKB50trsiBRsX+aGP5yaU6T60OEOkDgKUc5GH5fCSr3Qsdg9Yd4VygwjVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Andy,
   About the header file, yes, to keep the order.=20
   The function was already defined with  #ifdef CONFIG_PCIE_DPC.
   As to ' readx_poll_timeout()' if there is generic one, I would like to u=
se it.
   Seems there is no yet ?

Thanks,
Ethan


-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Friday, September 25, 2020 8:25 PM
To: Zhao, Haifeng <haifeng.zhao@intel.com>
Cc: bhelgaas@google.com; oohall@gmail.com; ruscur@russell.cc; lukas@wunner.=
de; stuart.w.hayes@gmail.com; mr.nuke.me@gmail.com; mika.westerberg@linux.i=
ntel.com; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Jia, Pei=
 P <pei.p.jia@intel.com>
Subject: Re: [PATCH 1/5] PCI: define a function to check and wait till port=
 finish DPC handling

On Thu, Sep 24, 2020 at 10:34:19PM -0400, Ethan Zhao wrote:
> Once root port DPC capability is enabled and triggered, at the=20
> beginning of DPC is triggered, the DPC status bits are set by hardware=20
> and then sends DPC/DLLSC/PDC interrupts to OS DPC and pciehp drivers,=20
> it will take the port and software DPC interrupt handler 10ms to 50ms=20
> (test data on ICX platform & stable 5.9-rc6) to complete the DPC=20
> containment procedure till the DPC status is cleared at the end of the DP=
C interrupt handler.
>=20
> We use this function to check if the root port is in DPC handling=20
> status and wait till the hardware and software completed the procedure.

>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/resource_ext.h>

> +#include <linux/delay.h>

Keep it sorted?=20



>  #include <uapi/linux/pci.h>

...

> +#ifdef CONFIG_PCIE_DPC
> +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev) {
> +	u16 cap =3D pdev->dpc_cap, status;
> +	u16 loop =3D 0;
> +
> +	if (!cap) {

> +		pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n");

But why? Is this feature mandatory to have? Then the same question about if=
deffery, otherwise it's pretty normal to not have a feature, right?

> +		return false;
> +	}
> +	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);

> +	while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
> +		msleep(10);
> +		loop++;
> +		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	}

Can we have rather something like readx_poll_timeout() for PCI and use them=
 here?

> +	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> +		pci_dbg(pdev, "Out of DPC status %x, time cost %d ms\n", status, loop*=
10);
> +		return true;
> +	}
> +	pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
> +	return false;
> +}
> +#else
> +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev) {
> +	return true;
> +}
> +#endif
>  #endif /* LINUX_PCI_H */
> --
> 2.18.4
>=20

--=20
With Best Regards,
Andy Shevchenko


