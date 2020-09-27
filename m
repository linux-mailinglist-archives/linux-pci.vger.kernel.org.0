Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F703279D58
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 03:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgI0BuS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Sep 2020 21:50:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:47813 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgI0BuR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Sep 2020 21:50:17 -0400
IronPort-SDR: MS3Xv4NO/ZToaZWs5Rq3kdiP8akUqFFjqxXt59Ly23H5yTWjgMiHpIllnJ/Vzk2KY9K61aOzfG
 xGOcjhvLTyxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="162720784"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="162720784"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 18:50:15 -0700
IronPort-SDR: uOw3p9SBp4dZvolWo2ve9ZV5w1yRsFakmqb7MI8qiNV4/tETqjAiQ9zIhe/sQt83JOAGoXEUCw
 IS6VMysQC92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="340017697"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2020 18:50:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 18:50:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 26 Sep 2020 18:50:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 26 Sep 2020 18:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXo1rKZVtmaUA0ddNji3uhrNF3qHcELCz+VoKzF5UO7/K0Bk1tjdoNlg/DfopIHXh+dMoxOnDRPdglhTgca8fN0+4dBzCOZD8fndw6XM2U/Jm87SrmY4gvHnPkO2tn5lDYjsnIZycRSLeSUhe9RwKmcrR138FkVNxi1PzzKmY3IsvWwtD5I4/IapKLMoth6Y69K/DgHJGZrzfrFBjjeEdM3+I/LoW6DOegkJ6pdiKoPhwG2XINbs+MO2eoTMcgw8c488pYIbXoJnRIMgkxgihrs3EUb7l6CGIofmyC/zPMEwMFtlB0q0znn/dyzF/0OSZ4QCoiGmCyq7+osVQfptWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4EX8l92pQfOwMVPzzwbKuIc9FFY3bcTDb6hu6FpLFU=;
 b=HJdzitclzIz8VJfWrFk/k3sB1Lkx0bGCbXA82E3QyKvsDdCeXhX79bj790JpqlX+0LCWXbM/boL7IJeOrli3V1guZyWSwDp37xhRYJg1wZf7vjf6iu8ZoyFrgzz2XFd20Y2lUt7zLrwQmCrT+aJthX1lTOnBwDZVABJGWtACrH/sQRUs0wMaYtWNjQzhA88TfGGYliiY2IoS1rYvO7C6b06/FU8vin6XuQnv0HpvP/fXVeChqF6Z6hen4fUkOSbASfY7SF873vpxMCGCLIJFzs5J/bytymtN+OyCnTpLyFEmDmetJIleCkmaPgff4gb5G5vNxXhHIeEvbOuENuQxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4EX8l92pQfOwMVPzzwbKuIc9FFY3bcTDb6hu6FpLFU=;
 b=NbUVsnLUklLmciP2/Y4IcFa0HnRt2bZkUxfsniRytya0e9C857nt+ujt3X5zNBfIoJPZ4szKbY64Ogri34h438v8xKYxVhf6DHyJ83ByQErPnZVoPtD5oBh3mymHCARd4E0x95o/21CrYmDNNyL9wiw00GJ1RSmFiaNp64OSiLo=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Sun, 27 Sep
 2020 01:50:12 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.025; Sun, 27 Sep 2020
 01:50:12 +0000
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
Subject: RE: [PATCH 2/5] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
Thread-Topic: [PATCH 2/5] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
Thread-Index: AQHWkuSbMWrHf0m/L0CZsBz9VaItsal5SiMAgAJwWxA=
Date:   Sun, 27 Sep 2020 01:50:12 +0000
Message-ID: <MWHPR11MB1696AD2B55AFAFA5B2DE6B4B97340@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-3-haifeng.zhao@intel.com>
 <20200925123242.GE3956970@smile.fi.intel.com>
In-Reply-To: <20200925123242.GE3956970@smile.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: a4aa3f31-94d0-46db-7eaf-08d86287ac56
x-ms-traffictypediagnostic: MWHPR11MB1518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB151868225A088CF2E5CD53FD97340@MWHPR11MB1518.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUpXlywMrPx7QFMe/OpEgQh4QzdsWESe7kyvd7pzEdVytiQ0gqyMEYFdbIFJsgoWVUsPBSV4qmWqGls9xvWPyXut/WmEGzpSKtQ1GUeq+Yt1L3jr+vBG9V8POPoeId1EbXsjsipvONfvrNGBTA/jpf0MOA7WefGwODbb9CsIhB0a3tIZGyloeKzehbNJgmuAKXlA2Li8EnxyRBRSZJxpsYggm2bXngJ6H7CLzj/UBkaGQzR7ogozZf6h1wUywRE7p06s6I8fARmnSl04lwG+s74U1mPucL8/+jBw91gI0+2eWadQHIX3DOYyMeaBdhAAvsc3c0d9uOIww5Itcah54BnjVjAlQALrrebgg5Lf0Z1cSK8VFA3SUpoNGN9i3zat
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(9686003)(52536014)(55016002)(54906003)(6506007)(53546011)(316002)(26005)(4326008)(186003)(86362001)(33656002)(66476007)(66556008)(64756008)(66446008)(83380400001)(5660300002)(71200400001)(76116006)(478600001)(45080400002)(66946007)(2906002)(6916009)(7696005)(7416002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Af2ktw+nZqDIKuOyjBV/peRta41WVLbMRmK0KV6GfLCWQI1DfkuhS5OecLrsXJGtRuxl89kmwGI3Fkv4BEjIIo1g3BlOdSm/W7rMjDcsMxPcT8zwKSbW1noj9tj3E8uiVgbbtB1HgUQWNs0cfw0xvkbPNaw/6MTa/Dz6SMSX4CEM2oFk3GzedSKN6zNwbSAfPSWK0zFBUgjVIIPb3w7uMvg9Wh6FNsOhOduZdl4EzB+MFeZzLDK9TX8p61LI5iiKMY5kyfFjLh+ern1bmRQAc7nQKzq8u6b6L0MfHiFTQ3rSnhfd5TxMytKmfePRUWZ/sxE1VGCin1ni8M307tQAhqtZ4LYfyds+SRceIxXp5jvvnL/hBEC+DPWf7FsR8fzkQRF2ENYeuipOS4dAyD8LIz9hDho0AfkGDg7Kr8b7kIUZolz8AeENEGu1mSHVmsEJfDm861UxUQ4F1ZbrDv7Nc04LAPqk8zH/absv8JWVXcnFSJAZIHbHioF0+rUzPONDhKXSToDOixnBVLYssP/lktErDXN42vANH78ywpFJ+zJeI+qcYelWUlWuAh0sE0nk2F/J5zzP2JJIJh+TNjMjEZz+bh/06NJMqT3EBSPmWzJZt70s00BmKqH+UYE16DgFqzKaQKDMignKD8c/Z+MjJw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4aa3f31-94d0-46db-7eaf-08d86287ac56
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 01:50:12.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfkApItJVY04M7QXtVTTM2z1nHn0WHKOGWp5LoUQDo1W1VhejusxdjAApuIcvpmvrr72mlSKD4SX9uUTa5FG4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1518
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Andy,=20

    About the ICX code name, I will align it to public documentation in nex=
t version.
' non-relevant information'  about the crash, I'm not sure what's not relev=
ant.=20

Thanks,
Ethan

-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Friday, September 25, 2020 8:33 PM
To: Zhao, Haifeng <haifeng.zhao@intel.com>
Cc: bhelgaas@google.com; oohall@gmail.com; ruscur@russell.cc; lukas@wunner.=
de; stuart.w.hayes@gmail.com; mr.nuke.me@gmail.com; mika.westerberg@linux.i=
ntel.com; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Jia, Pei=
 P <pei.p.jia@intel.com>
Subject: Re: [PATCH 2/5] PCI: pciehp: check and wait port status out of DPC=
 before handling DLLSC and PDC

On Thu, Sep 24, 2020 at 10:34:20PM -0400, Ethan Zhao wrote:
> When root port has DPC capability and it is enabled, then triggered by=20
> errors, DPC DLLSC and PDC interrupts will be sent to DPC driver, pciehp d=
river at the same time.
> That will cause following result:
>=20
> 1. Link and device are recovered by hardware DPC and software DPC driver,=
 device
>    isn't removed, but the pciehp might treat it as devce was hot removed.
>=20
> 2. Race condition happens between pciehp_unconfigure_device() called by
>    pciehp_ist() in pciehp driver and pci_do_recovery() called by dpc_hand=
ler in
>    DPC driver. no luck, there is no lock to protect pci_stop_and_remove_b=
us_device()
>    against pci_walk_bus(), they hold different semaphore and mutex,
>    pci_stop_and_remove_bus_device holds pci_rescan_remove_lock, and pci_w=
alk_bus()
>    holds pci_bus_sem.
>=20
> This race condition is not purely code analysis, it could be triggered=20
> by following command series:
>=20
>   # setpci -s 64:02.0 0x196.w=3D000a   // 64:02.0 is rootport has DPC cap=
ability
>   # setpci -s 65:00.0 0x04.w=3D0544    // 65:00.0 is NVMe SSD populated i=
n above port
>   # mount /dev/nvme0n1p1 nvme
>=20
> One shot will cause system panic and null pointer reference happened.
> (tested on stable 5.8 & ICX platform)

What is ICX (yes, I know, but you are writing this for wider audience)?

>    Buffer I/O error on dev nvme0n1p1, logical block 468843328, async page=
 read
>    BUG: kernel NULL pointer dereference, address: 0000000000000050
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page

Please, try to remove non-relevant information from the crashes.

>    Oops: 0000 [#1] SMP NOPTI
>    CPU: 12 PID: 513 Comm: irq/124-pcie-dp Not tainted 5.8.0-0.0.7.el8.x86=
_64+ #1
>    Hardware name: Intel Corporation Wilxxxx.200x0x0xxx 0x/0x/20x0
>    RIP: 0010:report_error_detected.cold.4+0x7d/0xe6
>    Code: b6 d0 e8 e8 fe 11 00 e8 16 c5 fb ff be 06 00 00 00 48 89 df e8 d=
3 65 ff
>    ff b8 06 00 00 00 e9 75 fc ff ff 48 8b 43 68 45 31 c9 <48> 8b 50 50 48=
 83 3a 00
>    41 0f 94 c1 45 31 c0 48 85 d2 41 0f 94 c0
>    RSP: 0018:ff8e06cf8762fda8 EFLAGS: 00010246
>    RAX: 0000000000000000 RBX: ff4e3eaacf42a000 RCX: ff4e3eb31f223c01
>    RDX: ff4e3eaacf42a140 RSI: ff4e3eb31f223c00 RDI: ff4e3eaacf42a138
>    RBP: ff8e06cf8762fdd0 R08: 00000000000000bf R09: 0000000000000000
>    R10: 000000eb8ebeab53 R11: ffffffff93453258 R12: 0000000000000002
>    R13: ff4e3eaacf42a130 R14: ff8e06cf8762fe2c R15: ff4e3eab44733828
>    FS:  0000000000000000(0000) GS:ff4e3eab1fd00000(0000) knlGS:0000000000=
000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000050 CR3: 0000000f8f80a004 CR4: 0000000000761ee0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    PKRU: 55555554
>    Call Trace:
>    ? report_normal_detected+0x20/0x20
>    report_frozen_detected+0x16/0x20
>    pci_walk_bus+0x75/0x90
>    ? dpc_irq+0x90/0x90
>    pcie_do_recovery+0x157/0x201
>    ? irq_finalize_oneshot.part.47+0xe0/0xe0
>    dpc_handler+0x29/0x40
>    irq_thread_fn+0x24/0x60
>    irq_thread+0xea/0x170
>    ? irq_forced_thread_fn+0x80/0x80
>    ? irq_thread_check_affinity+0xf0/0xf0
>    kthread+0x124/0x140
>    ? kthread_park+0x90/0x90
>    ret_from_fork+0x1f/0x30
>    Modules linked in: nft_fib_inet.........
>    CR2: 0000000000000050
>=20
> With this patch, the handling flow of DPC containment and hotplug is=20
> partly ordered and serialized, let hardware DPC do the controller=20
> reset etc recovery action first, then DPC driver handling the=20
> call-back from device drivers, clear the DPC status, at the end, pciehp d=
river handles the DLLSC and PDC etc.

> This patch closes the race conditon partly.

Not sure if Bjorn require to get rid of "this patch" from commit messages..=
. In any case it's written in documentation.


--
With Best Regards,
Andy Shevchenko


