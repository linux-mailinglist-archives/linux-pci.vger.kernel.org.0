Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318C827A545
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgI1Bre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:47:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:48345 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgI1Brd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:47:33 -0400
IronPort-SDR: vTQrMKn4p4NgpTR2o3ApU2rEXW5BN0RFaUvHaRqMUUm+8hebbv06fdbs3QPpMQ7ObNLSJKe7Oz
 SRxrrHQghMQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149701981"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="149701981"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:47:32 -0700
IronPort-SDR: Ncn7eCiwPSYiHYTwoSGabvQO2Q+a+1gBhn4Qo24KDLrPCIsLLot33JEAJ59HF5QaP3SQlkcshV
 1RckJfMjvcWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="514080715"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2020 18:47:31 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 27 Sep 2020 18:47:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 27 Sep 2020 18:47:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 27 Sep 2020 18:47:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 27 Sep 2020 18:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJdO+/Zg/nfH645UDN4h3JcRK91M1iqAi/Fbt5wXKg0QbvRU9Sr3LtH6B4fCdaclOqTecUAQ2aZ4YHIdt8mVF7u+fksA9Uh6LRsSdlJx0R5CKoD8EGkHXMU6XMPRZX+P3j2mhAcgsChSdpqnAeZ8avawbmCcfydTmT/OJegy7zc/kql2jKWRwJdAZS6VdJK8wLIISPlt2p5RFw14DI7M41SoJiikcPyp7ytlo7fTdCAr/J2l9gjPafBYilLAfekIJw++KhN2pUy8nDBAganFREAjBfCO6Ln9Lw/kqu0ipaj1vAbxViLZA3h7CyHgyqwa1QHC2PLOEaL7C1+Ubscq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFqvjLdWyp31+kdNHskUEKnOSt6TTvjBozRd3snBA3E=;
 b=LWTtNhqDuPSrobrl3IB27Pj7lF0S8v/dLbRPc7LOozLNT4F+tOfUJTMT/58zeLkwV6+gyzNZOTtnV5cR9W7l4wm9ypCW1AJ6hN8D4O0p0l7SnaydgvbWuC+Ef63Dkk+kOXEqxiUKQRyBS36Vt5duc3Eoe53jEM460wKqydww4eg48wTEGfMODjfSVHJPZBEswpqqBsxhE/RjtFO1EjWw8vHl8V/rbdb7Ilu6JFc+vPTa/yGMMwwxf1BYoFwt5EKkTX1AR1DA/TdxC5tl4CljJMxqHel2CXaczrWi78mGdTkmSgCDoJDEhGvyVktQe0NlE/iQpCXETzhBJO5sxWK0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFqvjLdWyp31+kdNHskUEKnOSt6TTvjBozRd3snBA3E=;
 b=oQ0KVij616CVQINfF95LT1jMCbMBpqIN1SN7K8CeVP4Yd2Ck4+3m2X1KQUzFaCD5xlqOAyGqyANV9ebMCO0ZURFEoOf9fxKMRzJ7POJ+hJMVg9J2spW089ST6c6O3GeBFiqsi7PS2p7qyXcb38tC3hK61+XynQUa7z7HCghuPMI=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR1101MB2127.namprd11.prod.outlook.com (2603:10b6:301:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 01:47:29 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 01:47:28 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Joe Perches <joe@perches.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH 4/5 V4] PCI: only return true when dev io state is really
 changed
Thread-Topic: [PATCH 4/5 V4] PCI: only return true when dev io state is really
 changed
Thread-Index: AQHWlKhWMe7iZBHjCUK5NURu1wi7Uql8M9+AgAEVUvA=
Date:   Mon, 28 Sep 2020 01:47:28 +0000
Message-ID: <MWHPR11MB169613F1730CF795D8AB20A297350@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200927082736.14633-1-haifeng.zhao@intel.com>
         <20200927082736.14633-5-haifeng.zhao@intel.com>
 <6e7fe17a30e455187066da1079fad0941f5aa5cc.camel@perches.com>
In-Reply-To: <6e7fe17a30e455187066da1079fad0941f5aa5cc.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4f4ae10-a65d-416b-9ecc-08d863507555
x-ms-traffictypediagnostic: MWHPR1101MB2127:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21272F463029280E73FB134097350@MWHPR1101MB2127.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvvp/vkbw271jkYYtrnILcVfCw9ti6Ve7JOzrBvSv3BtRB7xU4U+xNGxjIw9nUASKT0WNpq39gErXkZrUDBoiKwt9CJQsVoFsa2KBZYL29jRqA6gxxvIaVvyIb8RAchatnGGQX7MWMQBGEx4+wETmlGobPMufvMttSORIbVcefRg2WW0+FjqUY6ow8Dnuxs5daj8WTHXIE9SLflKDFff9ey8BTgT2VCVndVVKtewHqpIBAQLxlhPnBlapisQ48FKLhGRu9tmhncW1RnpG572em2ySMV1Ej/Cx7cmpw+/u5otoiPV0YQuGNXVKiFtUVXGTWyOAgVfquM8O9shoL9OueQgOtwUQnCHKSt7xgISGaIuLS/QkHh5x8BMQgeJyAQD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(54906003)(83380400001)(8676002)(26005)(55016002)(2906002)(9686003)(52536014)(4326008)(66946007)(76116006)(66556008)(86362001)(66446008)(5660300002)(33656002)(66476007)(6506007)(110136005)(53546011)(8936002)(71200400001)(64756008)(186003)(316002)(478600001)(7416002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5sQhulJm/tRePOCqApobGkaFDrOlaCxqQS7KIbB2zzHYKopwvhvq/FYi/VqOlzOjGkDIr+JfNDK0Lrd47QBhLfAhZmqFFne/PTRZhFBzgZ0cRTVfLkf4dMiltaZjk1HHC/OpiTetmMjaVWMPykhJejBhWROl/XpicLkieDbIz8ngivoStZCeYUbwabeezw6qlC8wrKHsPVk+RD/xU0jp3wUcqLPlid1f1ZXypsNp4t402K973PhtO71fqbVNIqKu0GmwMUL6YQ7lI+oUqWGpDG8XCTYP4GYKjRUCaiUdIuboCYm6UXezp6wZWo1vAcydhzQLVXDaXIR1wjBzVB8rpGMqEfKQX7UI73u8EoymorGMnnPcxtctvNZwFRJ1cZLXnUHTNlkoBR0g4SZrEcZW8mBE+s/FZ7upi8jb39rfIxlNTNid3pDHUlvWUf59zEoE81GjVQ98Uyi+pW+bIvtdBCy7lhNRXlZO2/soLvGYjwb4eVoTB7F747OGcgyuxHqwAJ/0zBBgQxabf1H5tqBvUUOws8KDar2IRHqLHPeTVBnei3o9reOThc8XgJtdlfBU5qQYKF8wp2gKx6FkFLcOLbsI6uSO0n9LFnPSm541BghTYOpga6nx4R0PtF8w2QFd45xQp00a1i6k3OVcVrDcXg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f4ae10-a65d-416b-9ecc-08d863507555
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 01:47:28.8175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dt4mwoSauL3KPIy/zBrVeLSRme8AFeU+H4v43RHzDJ+kjqbxyjVhGkFQvICqKWL7g6wuj9q2XKh+QjXwSw3j2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2127
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry for that offence, I should ask for your permission.=20

-----Original Message-----
From: Joe Perches <joe@perches.com>=20
Sent: Sunday, September 27, 2020 5:14 PM
To: Zhao, Haifeng <haifeng.zhao@intel.com>; bhelgaas@google.com; oohall@gma=
il.com; ruscur@russell.cc; lukas@wunner.de; andriy.shevchenko@linux.intel.c=
om; stuart.w.hayes@gmail.com; mr.nuke.me@gmail.com; mika.westerberg@linux.i=
ntel.com
Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Jia, Pei P <pe=
i.p.jia@intel.com>; ashok.raj@linux.intel.com; Kuppuswamy, Sathyanarayanan =
<sathyanarayanan.kuppuswamy@intel.com>; hch@infradead.org
Subject: Re: [PATCH 4/5 V4] PCI: only return true when dev io state is real=
ly changed

On Sun, 2020-09-27 at 04:27 -0400, Ethan Zhao wrote:
> When uncorrectable error happens, AER driver and DPC driver interrupt=20
> handlers likely call
>=20
>    pcie_do_recovery()
>    ->pci_walk_bus()
>      ->report_frozen_detected()
>=20
> with pci_channel_io_frozen the same time.
>    If pci_dev_set_io_state() return true even if the original state is=20
> pci_channel_io_frozen, that will cause AER or DPC handler re-enter the=20
> error detecting and recovery procedure one after another.
>    The result is the recovery flow mixed between AER and DPC.
> So simplify the pci_dev_set_io_state() function to only return true=20
> when dev->error_state is changed.
>=20
> Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> Tested-by: Wen Jin <wen.jin@intel.com>
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Reviewed-by: Joe Perches <joe@perches.com>

Hi Ethan/Haifeng.

Like Andy, I did not "review" this patch and sign it.
I merely suggested another simplification.
Please do not add -by: lines unless actually received by you.


