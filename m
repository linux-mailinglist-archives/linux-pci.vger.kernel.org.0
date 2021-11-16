Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15614527F7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 03:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbhKPCvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 21:51:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:40022 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347787AbhKPCtB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 21:49:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="297034795"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="297034795"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 18:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="645317795"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2021 18:42:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 15 Nov 2021 18:42:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 15 Nov 2021 18:42:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 15 Nov 2021 18:42:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILbOJm9Wow0dZf5Xs+NrsFxxgeIcSrfZyWPK6p2BXObqqzXEhjJaDoiwcOmZmGw3xW8CLCFTxJQkEXj4+dx/wnPOmsH4akeMNpoef6h/VesBY1R5gIOYwwb3cMYl408tW6sBDuRn+liGyuVMXgZ4hBLs7DMb0bPRDPoW7zYGUozSo15JQq5Eq7r9qnzTgoctM4v0s183oZT3mgEDCcMLZQgXYuhi1V3xjZN+AJyZD6WVET1JUQyq+ScztI1ZhNj3Cc2PaWRaQr22Mw9hmUdk9NLcR38oG60BHxFsr3H73g7lFJdLKIhfvH+BSqmDq2+l1WD4iPbT5j2okjA67dtgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/WCi4oem+agTNBnWVkU8MZMWKsZDno/9tKLgGwlHlw=;
 b=MHNpd/H1iOAUFc3zzy9qr35sEJ1mibYsZYnyqxWXqkGFTTdJaVZkFkx97F3IRi3TNx2gtHLWVOza75Iy5ykyLO/7xptxkgO24DdV2vOpjlEsuYCJeXgQWyJVPZUxAtaXWBvlAE4NRkAHAWl+ITKDc+OpqoKrbNzVoy52+4tyHDYjeWyIhgKkkLwSgyyplupyOYcf5tnq5Bfal6fF2B0lvTVerCXmBWThKjSV9VJoUIrYNLVB61zq1vEz6pdSp2moTziu7qOB89qn+YPzS0BWmk2eLEm9bvsvaQdt1ohMJEDYsryRYn1GKDyBcyR7thMXVzvYuC2Rf0McT0Q1Tfek1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/WCi4oem+agTNBnWVkU8MZMWKsZDno/9tKLgGwlHlw=;
 b=YEov5eu5dSF3n8y07DGKXX/tGvLDIsFGPke2xcWxVeh2fayi5MrD7UGl03qeF37AociP8QbQHBlHurJTzsFa9jvdc2H6HX3wbmpwjf/Jk5UQso+2Zzrh5TBVBdgjsOLTOCH64d+fedzms+cBu+bVqyB2MMHc2rtyKrMNAD0mB6I=
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 DM6PR11MB3084.namprd11.prod.outlook.com (2603:10b6:5:6c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Tue, 16 Nov 2021 02:42:20 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849%4]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 02:42:20 +0000
From:   "Bao, Joseph" <joseph.bao@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        "kw@linux.com" <kw@linux.com>
Subject: RE: HW power fault defect cause system hang on kernel 5.4.y
Thread-Topic: HW power fault defect cause system hang on kernel 5.4.y
Thread-Index: AdfPm0b60GGT2vlORua28HBxsdiYnQKu4l6AAA1f3jA=
Date:   Tue, 16 Nov 2021 02:42:20 +0000
Message-ID: <DM8PR11MB57020A22195E69295C5A9B8886999@DM8PR11MB5702.namprd11.prod.outlook.com>
References: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211115192723.GA19161@wunner.de>
In-Reply-To: <20211115192723.GA19161@wunner.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45d7009e-20d2-4f65-1a8e-08d9a8aab675
x-ms-traffictypediagnostic: DM6PR11MB3084:
x-microsoft-antispam-prvs: <DM6PR11MB3084AE4EA933A4A12B15826E86999@DM6PR11MB3084.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqBSc2nBQM/1bdOhwA5Z72LSYW6GfP/68BxlvpPH5FhA0OiG2fGycifPe2C1fEL9d/juAVA4ttRQdnUbkcUnWF3PeEl1lkgBYps7rBBqk9kCdGLYwdl4iuYut9BDmXowfVX1ql/FOv/LpoEfieNqS3CQ9MwXKrNHg6yBnql46oy534MQGEawsJuhFJjUbVQhdoDTrEhlzI5up0I8Vqtd+LODjv9mWC6U+6hK+mNfzyNffTfwpyOAdfKnAXeEImxZJ3/Y1rxjMMtL+abM0+kc8j4HlN0oiL/1LwC/irtH7G9a3BJbvGh+Z5X8137V5hKyx3j61D7+uUHZaRPakcSCO3SA3o4DJ0jmHSj/a8XQovR2Sbt4SGDpm53d5rhapAmVASaQzvHC/ZLvaBEgROaOMN4I1otfLRG4UEBSWTHzbCccKGoESYhbRcVzNFt5xPVFRf7fw6MBUx2DqNfBnq9nvIaHL0vhDnqkd4y+rJ/1XRfGWOmo8UvFqK2KyrI87FVtZ78Ipgqr79XDI5q8Tb9eayQ0JFwHLE0e9yTUfRBQ3IKLO9ESoeHfVQhN3/J6cgePC/Q6yiYd0VOWf3u8QOeyuxYnKYtGU3XmLw3hAPgH1/+FMOCJfY8lOeLahMUJGeiRZjpYOxSvW0RIO5lif1IPModAh0VgRsEwXoGVSGGIrsC/FV3xGRdlyxiBM2k9E0h5UVzmD3Do/lkJisBp4TieXon2a/2Ikgo93kxHue+DzUwoFP6ejbVBDzRHyLiQZLV/H9hJ3iUZjdmYQKgoc9DrEff9C25XpFOI1jBxqoDSG+X4dvG5UeMxgmpOVZePja4yel2ewHG2bWZrUf1rySUzTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(6506007)(53546011)(55016002)(9686003)(7696005)(86362001)(122000001)(26005)(2906002)(38100700002)(33656002)(64756008)(66476007)(66446008)(4326008)(186003)(966005)(66946007)(76116006)(83380400001)(45080400002)(8676002)(8936002)(508600001)(316002)(54906003)(52536014)(71200400001)(5660300002)(38070700005)(82960400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mp5CxkkilWj/QG/wHcRR7hJKw//f9t99XCZeq9lxER6FE0KyZaCFiGRLGOo8?=
 =?us-ascii?Q?t95PosAFo4i1lq3OdXAxQnMrCwsx96S7gqLoUwh8FJwBGeDltQlTrSaIGq5x?=
 =?us-ascii?Q?EaUqj4/k/tbIJIEAXMZg1ukvlgQKwo8rkd3wTYVqJMmQeqLsN+RiDAbrdCXx?=
 =?us-ascii?Q?7mN/q0Qe/K86ETKfnkfoT+iNiUBxrnDIKfBB0qQNt/xJkNlb1uQdnC0MIQoG?=
 =?us-ascii?Q?Px+i3nQ9ScruH0i39mLXbnNg8z4wqzNqIXLvsQobsXNaI+ApH6z5dmz8sRfe?=
 =?us-ascii?Q?vNgDTMgAnK+fu3ghAOmNOAFvH154seyTq6MZJAbCaMhowVwoy9OAHLUbCdVy?=
 =?us-ascii?Q?L+tSbRVU+8YGpOVt31xlMFzCRfBnRcG3IFCasIXTt6CRBAS1/w7ezc4JXSkA?=
 =?us-ascii?Q?Ksx2b+f5q8H+vOld6X8S88K45JNXa4Vy4A4duULsp4L0GHpabO3vKdaB9OQb?=
 =?us-ascii?Q?oOxh66ykO+vPxnTzP7DBm00CF9tF+7MFuSr5bcFb/4sLxhVVpV6dGwbAFyiE?=
 =?us-ascii?Q?Rdyy6fzy3vYJJfHEgeO4qPAqNsyQKgp7c1FT1ZhP4Ge0y1QbfoGoLpKAXMcK?=
 =?us-ascii?Q?rOcBHd9aHuOOQEi4Z2kYoTRejOrzbetKQyx3gnZMrhmk28WFy5Gnef2WGzOK?=
 =?us-ascii?Q?hLsN/Uqyu3yhxXKOp/5e8+0/lxrYODKH3tlr5co7sRl0dst9ejSs8cu17tUI?=
 =?us-ascii?Q?rolKeokk/2JCThFfjY3T9tvlBf0ckYVz4pvtrNDnNhvAt/l/1g6rIGVWlzL1?=
 =?us-ascii?Q?kUxOe/3WRADn8kTRaPoG9L2HALTEWNdBsoH0WqcB7ZAg31InW5KZHrulRvRA?=
 =?us-ascii?Q?6zF5ZaPJlrikKGFDvekOLtO+V6ime6xabQb8pFhEMKkUu8YzPdYQFy4VSZDN?=
 =?us-ascii?Q?uQuPSkQZCVhftefgmU9OyJXlh9BnTdnuBbo6yLXo++WdFInf253LNZg0kX2I?=
 =?us-ascii?Q?q+fq96DFIb3CTLR7/NCjdpNKRMJMGQz8nXrOYLlTMXTi4yABvy8+EcDbcKDc?=
 =?us-ascii?Q?S+lMfP719w5kca64q1vfq3Fc0YPeiJDVI2Ou4aXdwXD1E+YmUNQYuPJbcB5l?=
 =?us-ascii?Q?px0bwyzLS+bbUo4G8cUoFriBTz6Imm/YsmblXMzCgB1PTlO6JX6IPMBDy8XY?=
 =?us-ascii?Q?QP0UlYIKIp+mQq3p8GSIbNkRWr0J/OwYLpQpRpJ4sl6Wf6AcGzAa49QSio5D?=
 =?us-ascii?Q?EDXcoAUpHAXtOuejUziaDoHj1n+0oof6ulKZsHPSivWgm7ZZ0w1jCsKZYCY8?=
 =?us-ascii?Q?FjPLMMMu3y/uQq+G5gX4HWC3Po4Y0BNKa/1f+hYCzLA1K6msmKbSyJGKPGrZ?=
 =?us-ascii?Q?VbqQEHgzArvWaaWxPCqboL5SDmSr2c5RD3Lb9UVtAP6GadSBsSmVTVKX5L+L?=
 =?us-ascii?Q?fpQLcy+kmjreIRLULjjSvqxOXR+bP513ultv4K7yedSuDHbaVgKZ0Q5KyN7Y?=
 =?us-ascii?Q?Zh3AlH2wXEaSSfAnVP9mK/zJRvJMr+Th2prmfUQRz98mjVpS11STRv+UuTLk?=
 =?us-ascii?Q?t4d2uVBmnBbdCNts9seiOFkHRX9m9t1HI6i+YLkXab1Dc16W12nc+c6gO0Ry?=
 =?us-ascii?Q?WrUEe8m4gEm02cZBLEZNTro6TIb+TZqA3qRI8rmF2wm3Iqo1fC8KJ2TKbv5G?=
 =?us-ascii?Q?DxCznER2xJ6OZDaWfJZoDlw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d7009e-20d2-4f65-1a8e-08d9a8aab675
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 02:42:20.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrqF/+cyicf2nk4nYvGUrnvj5g9kZPBqb3YOUuj1ZIbEhgOC3SJUV8FnLyHxkPriglv7nw5oEELjVxWaqZZFVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3084
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I've tested this tentative patch, and it fixes the issue.

And current kernel behavior of only changing the LEDs may come from spec se=
c 6.7.1.1, which indicates that the adapter should not be removed when enco=
untering a power fault event.=20
Based on the description of sec 6.7.1.8, I think it's the power controller'=
s responsibility that power off the slot -> wait until the power fault stat=
us cleared (latched by HW)-> power on the slot again, not the kernel's resp=
onsibility.
If the kernel reports a power fault log msg, there must be something wrong =
with the HW, #1 (current case) the power controller circuit has some defect=
, falsely trigger power fault even the slot has correct voltage. #2 (seen i=
n our factory) The slot has some defect, pulling down the correct voltage, =
so trigger power fault.

In my opinion, only the infinite loop bug fix is necessary for the kernel, =
neither the cases I listed above should cause a system hang, then we could =
get power fault log msg/indicators and know something wrong with our HW.=20
Otherwise, if exists the case that power fault is not HW-related, then mayb=
e the kernel should interpret power fault as a surprising removal or do som=
e power cycle retry to recovery, but I do not know such a case yet...

Regards
Joseph

-----Original Message-----
From: Lukas Wunner <lukas@wunner.de>=20
Sent: Tuesday, November 16, 2021 3:27 AM
To: Bao, Joseph <joseph.bao@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Stuart Hayes <stuart.w.hayes@gmail.com>; kw@linux.co=
m
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y

On Tue, Nov 02, 2021 at 03:45:00AM +0000, Bao, Joseph wrote:
> Recently we encounter system hang (dead spinlock) when move to kernel=20
> linux-5.4.y.
>=20
> Finally, we use bisect to locate the suspicious commit https://git.kernel=
.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=3Dlinux-5.4.y&id=
=3D4667358dab9cc07da044d5bc087065545b1000df.
>=20
> Our system has some HW defect, which will wrongly set=20
> PCI_EXP_SLTSTA_PFD high, and this commit will lead to infinite loop=20
> jumping to read_status (no chance to clear status PCI_EXP_SLTSTA_PFD=20
> bit since ctrl is not updated), I know this is our HW defect, but this=20
> commit makes kernel trapped in this isr function and leads to kernel=20
> hang (then the user could not get useful information to show what's=20
> wrong), which I think is not expected behavior, so I would like to report=
 to you for discussion.

Thanks a lot for the report and apologies for the breakage and the delay.
Below please find a tentative fix.  Could you test whether it fixes the iss=
ue?

I don't think this is a hardware defect.  If I'm reading the spec right (PC=
Ie r5.0, sec. 6.7.1.8), the PFD bit is meant to remain set and cannot be cl=
eared until the kernel disables slot power.

When a power fault happens, we currently only change the LEDs (Power Indica=
tor Off, Attention Indicator On) and emit a log message.
We otherwise leave the slot as is, even though I'd assume that the PCI devi=
ce in the slot is no longer accessible.

I'm wondering whether we should interpret a power fault as surprise removal=
.  Alternatively, we could attempt recovery, i.e. turn slot power off and b=
ack on.  Similar to what we're doing when an Uncorrectable Error occurs.  D=
o you have an opinion on that?  What would be the desired behavior for your=
 users?

Thanks,

Lukas

-- >8 --

Subject: [PATCH] PCI: pciehp: Fix infinite loop in IRQ handler upon power  =
fault

The Power Fault Detected bit in the Slot Status register differs from all o=
ther hotplug events in that it is sticky:  It can only be cleared after tur=
ning off slot power.  Per PCIe r5.0, sec. 6.7.1.8:

  If a power controller detects a main power fault on the hot-plug slot,
  it must automatically set its internal main power fault latch [...].
  The main power fault latch is cleared when software turns off power to
  the hot-plug slot.

The stickiness used to cause interrupt storms and infinite loops which were=
 fixed in 2009 by commits 5651c48cfafe ("PCI pciehp: fix power fault interr=
upt storm problem") and 99f0169c17f3 ("PCI: pciehp: enable software notific=
ation on empty slots").

Unfortunately in 2020 the infinite loop issue was inadvertently reintroduce=
d by commit 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt
race"):  The hardirq handler pciehp_isr() clears the PFD bit until pciehp's=
 power_fault_detected flag is set.  That happens in the IRQ thread pciehp_i=
st(), which never learns of the event because the hardirq handler is stuck =
in an infinite loop.  Fix by setting the power_fault_detected flag already =
in the hardirq handler.

Fixes: 8edf5332c393 ("PCI: pciehp: Fix MSI interrupt race")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D214989
Link: https://lore.kernel.org/linux-pci/DM8PR11MB5702255A6A92F735D90A444686=
8B9@DM8PR11MB5702.namprd11.prod.outlook.com
Reported-by: Joseph Bao <joseph.bao@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.19+
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_=
hpc.c
index 6ac5ea5..fac6b8e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -640,6 +640,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 */
 	if (ctrl->power_fault_detected)
 		status &=3D ~PCI_EXP_SLTSTA_PFD;
+	else if (status & PCI_EXP_SLTSTA_PFD)
+		ctrl->power_fault_detected =3D true;
=20
 	events |=3D status;
 	if (!events) {
@@ -649,7 +651,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
=20
 	if (status) {
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
=20
 		/*
 		 * In MSI mode, all event bits must be zero before the port @@ -723,8 +7=
25,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	}
=20
 	/* Check Power Fault Detected */
-	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
-		ctrl->power_fault_detected =3D 1;
+	if (events & PCI_EXP_SLTSTA_PFD) {
 		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
 		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
 				      PCI_EXP_SLTCTL_ATTN_IND_ON);
--
2.33.0

