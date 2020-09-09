Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4892624E7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgIICL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 22:11:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:19284 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgIICL0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 22:11:26 -0400
IronPort-SDR: KAZyyehycIKcfW2jKx7Ne/XMi2sAFEODE4v4fYI7W6vK8gOfpNNnNkqSg5/O1fL2KV1z9l4jMO
 JDjmC+sCMNvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219814111"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="219814111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 19:11:25 -0700
IronPort-SDR: fTs8dYsUPiAwAELgtlD26Amd9EW9YrFei1MolUmc1Y5G8vvpetZVnp+eRDrvPBn4d+ddjw/6Bu
 WePWyxc6EKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="449025029"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2020 19:11:25 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Sep 2020 19:11:24 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Sep 2020 19:11:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 8 Sep 2020 19:11:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Sep 2020 19:11:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E11PcxJHRGcnt8kGQvNsJ9XMYWc3ZmEhx1PLNVWKVaDJ0ZgMZmO44N/d/r7G4ccQYzVsug9rJOoiKs4W2QSA+vzYH840yfS0X+IbOZNKWfTOmQ/pYsRSD5qwwubPjjoO4jfhk/N2TGtR35PKaDY6J6WNmb2pUghD0VT+q1Rpw9Oop8YFT34MNwyxfFvensmVlQQcMNl5d+NRQI4jH55c9arW6EbvfbSOEvPxgQFzqiq+NxOlt617lAThR29IDL8ikXovx9QhP2xD3o1PSudzNpfgkRBo2Og4OWD09CwIG8Ckp89QHL5Es07QxcAts3CDrL/RIk5k/CZKARX63oh3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuNxSBY7CPed9i3mXfhow1JAfzhldSDsHzBriPa1LY4=;
 b=oV9M1dCLDlafchnuqUUXA0cpvsH4KT0KepAN4ebTGUgYsd5jRDuPnZMYg/h8ZxJCU8a1/uC56+IelwB+gCdrt+kpxcXTvRHJ/0EI6aoHIGzvOIB6onwK/nz6v/VS2QBkZsJNVueWLk7wSmgFfd/FcAK0CVXULlBievCujx7oooAewvXydb9QtPgmaGze2Z02Pj2jb0HV+oJIZQcv1aUiaV6HRK068hY3Ctduxhu4w2NU2m8N/JTE6Pw8qiNr4X7gTc5ShZVQwmAREcwSN93MHcHbucZv/JnuxuxP13jgOj8X/C3iflt325JhRjr0BpdbmSJM6ri82z+r3y1nr+zQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuNxSBY7CPed9i3mXfhow1JAfzhldSDsHzBriPa1LY4=;
 b=jDg2ELw1Ksax2iutF0v9A5AymrsM3KbM1TJ/b4gDrQdfUhtiyZbn8mYY3ARRROBPNWjqbGM8uPq1G3gq4WlUArmTzVKLe6P1T7240erUxlPssY4QKsc3BEKvui8gKwYIAenNSL47qyzK7msBm8yQLLaKv7dGakDJt4WHzo9CGvo=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR11MB1998.namprd11.prod.outlook.com (2603:10b6:300:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 02:11:21 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::ec4a:90cc:bdb4:5a5a]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::ec4a:90cc:bdb4:5a5a%9]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 02:11:21 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, ShanshanX" <shanshanx.zhang@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>, Ming Lei <ming.lei@redhat.com>
Subject: RE: [PATCH] Revert "block: revert back to synchronous request_queue
 removal"
Thread-Topic: [PATCH] Revert "block: revert back to synchronous request_queue
 removal"
Thread-Index: AQHWhbUmn1JF/TbogUavgTta1QMeJqley0QAgADEb6A=
Date:   Wed, 9 Sep 2020 02:11:20 +0000
Message-ID: <MWHPR11MB1696A6C649BD434390418FE797260@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200908075047.5140-1-haifeng.zhao@intel.com>
 <20200908142128.GA3463@infradead.org>
In-Reply-To: <20200908142128.GA3463@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8147c4ae-d3ab-4877-119a-08d85465a51f
x-ms-traffictypediagnostic: MWHPR11MB1998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1998C149AD1BEFD62AD1C30D97260@MWHPR11MB1998.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4sa2OdkWRA923H5Q+jc9GfdgF2SYktMqoD7GpvFCRBUInCaAriVcZirj6xmrx+RSYiR6S4pbGzcet7RhtKd+POOQd+tYsBScsc38g3xjmh+x2P2zlgY+o5yzCFAv71vJFn0msznFr7oa6yBcmgY2CcjnC5eF5SvxCJYoxHiff97NNuFYIly3jUWsB6/IssWZFhodark2ou0Xj+I7EzDKet33JUPyvRtBPcl/X2/uRcWs7XD7kzCpeQSA51Ka3N9sq3vAGZjL0Ns1dw7axoOLAGYbpsRvR8frUk9galUuJRLXVkE0eew6I8jsUE/g/mo8WGQdyKKtzCThAuorGRcfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(71200400001)(86362001)(54906003)(9686003)(83380400001)(55016002)(30864003)(478600001)(6916009)(8936002)(26005)(2906002)(4326008)(52536014)(8676002)(7696005)(33656002)(316002)(186003)(76116006)(66476007)(66946007)(66446008)(64756008)(5660300002)(66556008)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hvULMYz38bREe1xRTiHUAXJdqOE0CzG6PowUfYi0xzJcVfTRFV2bxGEKuakW/OXm3A4TkdZyJjfDY72WVLSDbEEPuxvw0LLYpHVUkPOave4fObFObjNj5vFOgu6KTipuj1FFVTYFSLlggJ7q3fS8B3flRUrLps8O8kv+HpBzUeI1Hc+hafIeEkKW0snvhJDUjPyYMtrPXVkTV7Fx7XEtUliZ0H+qnsHedELLKkNNjbdQjmZuUy6B3M0kjEg2Gxz8T0sc+443ExPlMYMWn++WdBQATl0UHkwb/Fsn4jQfViHE6nVGB1pYTJHopVT+TcUfAwCcIyqDef6Yp8F06LZE/bFOoHQcp9IQA+7nHOc+pNA8a9NDSolChWHBhbjWHF/Aqmhn3Wjo2cspOAxli+lzu66+8+lTeDPY5JNOGaqLLoUCsj6jFwBPp9saAWIDPymn1EbgrIUqXG8mF6Ra6dS1OFrj2JJVlQuZroaQZpBDlhwsYU1MF1QiFdnnuFOGVIaGwlJWzIenmL7hTBuZGH/X+PJVFQnvdbTCWBx1yBime79u79himCKZCQpWQRgrMRwNOlAUGcqNqICnJU/eFXyzF9a1fZMhKKdHKRQBomwdRbWmNrxolFndMOhuO1D3JtwtTDw8LYNfrOChx3pHMBQb2Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8147c4ae-d3ab-4877-119a-08d85465a51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 02:11:20.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhx52CkNIIXcmT18a+t7suvAoDCjMUba9XkqW+DsKhchHCQ5TRi5V2YwDTdBD4YgyBMBGBC0CQO/L07ZnKXvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1998
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ming, Christoph,
    Could you point out the patch aimed to fix this issue ? I would like to=
 try it.   This issue blocked my other PCI patch developing and verificatio=
n work,=20
I am not a BLOCK/NVMe expert, wouldn't to be trapped into other sub-system =
bugs, so just reported it for other expert's quick fix.=20

Thanks,
Ethan

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org>=20
Sent: Tuesday, September 8, 2020 10:21 PM
To: Zhao, Haifeng <haifeng.zhao@intel.com>
Cc: axboe@kernel.dk; bhelgaas@google.com; linux-block@vger.kernel.org; linu=
x-kernel@vger.kernel.org; linux-pci@vger.kernel.org; mcgrof@kernel.org; Zha=
ng, ShanshanX <shanshanx.zhang@intel.com>; Jia, Pei P <pei.p.jia@intel.com>=
; Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] Revert "block: revert back to synchronous request_queu=
e removal"

On Tue, Sep 08, 2020 at 03:50:48AM -0400, Ethan Zhao wrote:
> From: Ethan Zhao <Haifeng.Zhao@intel.com>
>=20
> 'commit e8c7d14ac6c3 ("block: revert back to synchronous request_queue=20
> removal")' introduced panic issue to NVMe hotplug as following(hit=20
> after just 2 times NVMe SSD hotplug under stable 5.9-RC2):

I'm pretty sure Ming has already fixed this by not calling put_device from =
the rcu callbackm which is the real issue here.

And even if that wasn't the case we generally try to fix bugs instead of go=
ing to a blind revert without much analysis.

>=20
> BUG: sleeping function called from invalid context at=20
> block/genhd.c:1563
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name:=20
> swapper/30
> INFO: lockdep is turned off.
> CPU: 30 PID: 0 Comm: swapper/30 Tainted: G S      W         5.9.0-RC2 #3
> Hardware name: Intel Corporation xxxxxxxx Call Trace:
> <IRQ>
> dump_stack+0x9d/0xe0
> ___might_sleep.cold.79+0x17f/0x1af
> disk_release+0x26/0x200
> device_release+0x6d/0x1c0
> kobject_put+0x14d/0x430
> hd_struct_free+0xfb/0x260
> percpu_ref_switch_to_atomic_rcu+0x3d1/0x580
> ? rcu_nocb_unlock_irqrestore+0xb6/0xf0
> ? trace_hardirqs_on+0x20/0x1b5
> ? rcu_do_batch+0x3ff/0xb50
> rcu_do_batch+0x47c/0xb50
> ? rcu_accelerate_cbs+0xa9/0x740
> ? rcu_spawn_one_nocb_kthread+0x3d0/0x3d0
> rcu_core+0x945/0xd90
> ? __do_softirq+0x182/0xac0
> __do_softirq+0x1ca/0xac0
> asm_call_on_stack+0xf/0x20
> </IRQ>
> do_softirq_own_stack+0x7f/0x90
> irq_exit_rcu+0x1e3/0x230
> sysvec_apic_timer_interrupt+0x48/0xb0
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> RIP: 0010:cpuidle_enter_state+0x116/0xe90
> Code: 00 31 ff e8 ac c8 a4 fe 80 7c 24 10 00 74 12 9c 58 f6 c4 02  0f=20
> 85 7e 08 00 00 31 ff e8 43 ca be fe e8 ae a3 d5 fe fb 45 85 ed  <0f>=20
> 88 4e 05 00 00 4d 63 f5 49 83 fe 09 0f 87 29 0b 00 00 4b 8d 04
> RSP: 0018:ff110001040dfd78 EFLAGS: 00000206
> RAX: 0000000000000007 RBX: ffd1fff7b1a01e00 RCX: 000000000000001f
> RDX: 0000000000000000 RSI: 0000000040000000 RDI: ffffffffb7c5c0f2
> RBP: ffffffffb9a416a0 R08: 0000000000000000 R09: 0000000000000000
> R10: ff110001040d0007 R11: ffe21c002081a000 R12: 0000000000000003
> R13: 0000000000000003 R14: 0000000000000138 ... ...
> BUG: kernel NULL pointer dereference, address: 0000000000000000 PGD 0
> Oops: 0010 [#1] SMP KASAN NOPTI
> CPU: 30 PID: 500 Comm: irq/124-pciehp Tainted: G S  W  5.9.0-RC2 #3=20
> Hardware name: Intel Corporation xxxxxxxx
> RIP: 0010:0x0
> Code: Bad RIP value.
> RSP: 0018:ff110007d5ba75e8 EFLAGS: 00010096
> RAX: 0000000000000000 RBX: ff110001040d0000 RCX: ff110007d5ba7668
> RDX: 0000000000000009 RSI: ff110001040d0000 RDI: ff110008119f59c0
> RBP: ff110008119f59c0 R08: fffffbfff73f7b4d R09: fffffbfff73f7b4d
> R10: ffffffffb9fbda67 R11: fffffbfff73f7b4c R12: 0000000000000000
> R13: ff110007d5ba7668 R14: ff110001040d0000 R15: ff110008119f59c0
> FS:  0000000000000000(0000) GS:ff11000811800000(0000)=20
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 00000007cea16002 CR4: 0000000000771ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> ttwu_do_activate+0xd3/0x160
> try_to_wake_up+0x652/0x1850
> ? migrate_swap_stop+0xad0/0xad0
> ? lock_contended+0xd70/0xd70
> ? rcu_read_unlock+0x50/0x50
> ? rcu_do_batch+0x3ff/0xb50
> swake_up_locked+0x85/0x1c0
> complete+0x4d/0x70
> rcu_do_batch+0x47c/0xb50
> ? rcu_spawn_one_nocb_kthread+0x3d0/0x3d0
> rcu_core+0x945/0xd90
> ? __do_softirq+0x182/0xac0
> __do_softirq+0x1ca/0xac0
> irq_exit_rcu+0x1e3/0x230
> sysvec_apic_timer_interrupt+0x48/0xb0
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> RIP: 0010:_raw_spin_unlock_irqrestore+0x40/0x50
> Code: e8 35 ad 36 fe 48 89 ef e8 cd ce 37 fe f6 c7 02 75 11 53 9d
>  e8 91 1f 5c fe 65 ff 0d ba af c2 47 5b 5d c3 e8 d2 22 5c fe 53 9d =20
> <eb> ed 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53
> RSP: 0018:ff110007d5ba79d0 EFLAGS: 00000293
> RAX: 0000000000000007 RBX: 0000000000000293 RCX: ffffffffb67710d4
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffb83f41ce
> RBP: ffffffffbb77e740 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffffbb77e743 R11: fffffbfff76efce8 R12: 000000000000198e
> R13: ff11001031d7a0b0 R14: ffffffffbb77e740 R15: ffffffffbb77e788 ?=20
> do_raw_spin_unlock+0x54/0x230 ? _raw_spin_unlock_irqrestore+0x3e/0x50
> dma_debug_device_change+0x150/0x5e0
> notifier_call_chain+0x90/0x160
> __blocking_notifier_call_chain+0x6d/0xa0
> device_release_driver_internal+0x37d/0x490
> pci_stop_bus_device+0x123/0x190
> pci_stop_and_remove_bus_device+0xe/0x20
> pciehp_unconfigure_device+0x17e/0x330
> ? pciehp_configure_device+0x3e0/0x3e0
> ? trace_hardirqs_on+0x20/0x1b5
> pciehp_disable_slot+0x101/0x360
> ? pme_is_native.cold.2+0x29/0x29
> pciehp_handle_presence_or_link_change+0x1ac/0xee0
> ? pciehp_handle_disable_request+0x110/0x110
> pciehp_ist.cold.11+0x39/0x54
> ? pciehp_set_indicators+0x190/0x190
> ? alloc_desc+0x510/0xa30
> ? irq_set_affinity_notifier+0x380/0x380
> ? pciehp_set_indicators+0x190/0x190
> ? irq_thread+0x137/0x420
> irq_thread_fn+0x86/0x150
> irq_thread+0x21f/0x420
> ? irq_forced_thread_fn+0x170/0x170
> ? irq_thread_check_affinity+0x210/0x210
> ? __kthread_parkme+0x52/0x1a0
> ? lockdep_hardirqs_on_prepare+0x33e/0x4e0
> ? _raw_spin_unlock_irqrestore+0x3e/0x50
> ? trace_hardirqs_on+0x20/0x1b5
> ? wake_threads_waitq+0x40/0x40
> ? __kthread_parkme+0xd1/0x1a0
> ? irq_thread_check_affinity+0x210/0x210
> kthread+0x36a/0x430
> ? kthread_create_worker_on_cpu+0xc0/0xc0
> ret_from_fork+0x1f/0x30
> ... ...
> CR2: 0000000000000000
> ---[ end trace cedc4047ef91d2ec ]---
>=20
> Seems scheduling happened within hardware interrupt context, after=20
> reverted this patch, stable 5.9-RC4 build was tested with more than 20=20
> times NVMe SSD hotplug, no panic found.
>=20
> This reverts commit e8c7d14ac6c37c173ec606907d38802b00302988.
>=20
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> Signed-off-by: Ethan Zhao <Haifeng.Zhao@intel.com>
> ---
>  block/blk-core.c       |  8 --------
>  block/blk-sysfs.c      | 43 +++++++++++++++++++++---------------------
>  block/genhd.c          | 17 -----------------
>  include/linux/blkdev.h |  2 ++
>  4 files changed, 23 insertions(+), 47 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c index=20
> 10c08ac50697..1b18a0ef5db1 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -325,9 +325,6 @@ EXPORT_SYMBOL_GPL(blk_clear_pm_only);
>   *
>   * Decrements the refcount of the request_queue kobject. When this reach=
es 0
>   * we'll have blk_release_queue() called.
> - *
> - * Context: Any context, but the last reference must not be dropped from
> - *          atomic context.
>   */
>  void blk_put_queue(struct request_queue *q)  { @@ -360,14 +357,9 @@=20
> EXPORT_SYMBOL_GPL(blk_set_queue_dying);
>   *
>   * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
>   * put it.  All future requests will be failed immediately with -ENODEV.
> - *
> - * Context: can sleep
>   */
>  void blk_cleanup_queue(struct request_queue *q)  {
> -	/* cannot be called from atomic context */
> -	might_sleep();
> -
>  	WARN_ON_ONCE(blk_queue_registered(q));
> =20
>  	/* mark @q DYING, no new request or merges will be allowed=20
> afterwards */ diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c index=20
> 7dda709f3ccb..eb347cbe0f93 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -901,32 +901,22 @@ static void blk_exit_queue(struct request_queue *q)
>  	bdi_put(q->backing_dev_info);
>  }
> =20
> +
>  /**
> - * blk_release_queue - releases all allocated resources of the=20
> request_queue
> - * @kobj: pointer to a kobject, whose container is a request_queue
> - *
> - * This function releases all allocated resources of the request queue.
> - *
> - * The struct request_queue refcount is incremented with=20
> blk_get_queue() and
> - * decremented with blk_put_queue(). Once the refcount reaches 0 this=20
> function
> - * is called.
> - *
> - * For drivers that have a request_queue on a gendisk and added with
> - * __device_add_disk() the refcount to request_queue will reach 0=20
> with
> - * the last put_disk() called by the driver. For drivers which don't=20
> use
> - * __device_add_disk() this happens with blk_cleanup_queue().
> + * __blk_release_queue - release a request queue
> + * @work: pointer to the release_work member of the request queue to=20
> + be released
>   *
> - * Drivers exist which depend on the release of the request_queue to=20
> be
> - * synchronous, it should not be deferred.
> - *
> - * Context: can sleep
> + * Description:
> + *     This function is called when a block device is being unregistered=
. The
> + *     process of releasing a request queue starts with blk_cleanup_queu=
e, which
> + *     set the appropriate flags and then calls blk_put_queue, that decr=
ements
> + *     the reference counter of the request queue. Once the reference co=
unter
> + *     of the request queue reaches zero, blk_release_queue is called to=
 release
> + *     all allocated resources of the request queue.
>   */
> -static void blk_release_queue(struct kobject *kobj)
> +static void __blk_release_queue(struct work_struct *work)
>  {
> -	struct request_queue *q =3D
> -		container_of(kobj, struct request_queue, kobj);
> -
> -	might_sleep();
> +	struct request_queue *q =3D container_of(work, typeof(*q),=20
> +release_work);
> =20
>  	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
>  		blk_stat_remove_callback(q, q->poll_cb); @@ -958,6 +948,15 @@=20
> static void blk_release_queue(struct kobject *kobj)
>  	call_rcu(&q->rcu_head, blk_free_queue_rcu);  }
> =20
> +static void blk_release_queue(struct kobject *kobj) {
> +	struct request_queue *q =3D
> +		container_of(kobj, struct request_queue, kobj);
> +
> +	INIT_WORK(&q->release_work, __blk_release_queue);
> +	schedule_work(&q->release_work);
> +}
> +
>  static const struct sysfs_ops queue_sysfs_ops =3D {
>  	.show	=3D queue_attr_show,
>  	.store	=3D queue_attr_store,
> diff --git a/block/genhd.c b/block/genhd.c index=20
> 99c64641c314..7e2edf388c8a 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -887,19 +887,12 @@ static void invalidate_partition(struct gendisk *di=
sk, int partno)
>   * The final removal of the struct gendisk happens when its refcount rea=
ches 0
>   * with put_disk(), which should be called after del_gendisk(), if
>   * __device_add_disk() was used.
> - *
> - * Drivers exist which depend on the release of the gendisk to be=20
> synchronous,
> - * it should not be deferred.
> - *
> - * Context: can sleep
>   */
>  void del_gendisk(struct gendisk *disk)  {
>  	struct disk_part_iter piter;
>  	struct hd_struct *part;
> =20
> -	might_sleep();
> -
>  	blk_integrity_del(disk);
>  	disk_del_events(disk);
> =20
> @@ -1553,15 +1546,11 @@ int disk_expand_part_tbl(struct gendisk *disk, in=
t partno)
>   * drivers we also call blk_put_queue() for them, and we expect the
>   * request_queue refcount to reach 0 at this point, and so the request_q=
ueue
>   * will also be freed prior to the disk.
> - *
> - * Context: can sleep
>   */
>  static void disk_release(struct device *dev)  {
>  	struct gendisk *disk =3D dev_to_disk(dev);
> =20
> -	might_sleep();
> -
>  	blk_free_devt(dev->devt);
>  	disk_release_events(disk);
>  	kfree(disk->random);
> @@ -1806,9 +1795,6 @@ EXPORT_SYMBOL(get_disk_and_module);
>   *
>   * This decrements the refcount for the struct gendisk. When this reache=
s 0
>   * we'll have disk_release() called.
> - *
> - * Context: Any context, but the last reference must not be dropped from
> - *          atomic context.
>   */
>  void put_disk(struct gendisk *disk)
>  {
> @@ -1823,9 +1809,6 @@ EXPORT_SYMBOL(put_disk);
>   *
>   * This is a counterpart of get_disk_and_module() and thus also of
>   * get_gendisk().
> - *
> - * Context: Any context, but the last reference must not be dropped from
> - *          atomic context.
>   */
>  void put_disk_and_module(struct gendisk *disk)  { diff --git=20
> a/include/linux/blkdev.h b/include/linux/blkdev.h index=20
> bb5636cc17b9..59fe9de342e0 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -583,6 +583,8 @@ struct request_queue {
> =20
>  	size_t			cmd_size;
> =20
> +	struct work_struct	release_work;
> +
>  #define BLK_MAX_WRITE_HINTS	5
>  	u64			write_hints[BLK_MAX_WRITE_HINTS];
>  };
> --
> 2.18.4
>=20
---end quoted text---
