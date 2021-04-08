Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1861D358CC6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDHSiv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 14:38:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:18766 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232841AbhDHSiu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 14:38:50 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138IRJ0Y025265;
        Thu, 8 Apr 2021 11:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=m+/ppC1PeCMmXoRyA1HZXf51xfwNsIqTMr5oskG37IA=;
 b=W8E5w0d5ZV/jB9wWx0osLzvNN0aE104syUWWq0obOuNzuHHy8U0LOYH9/TXdFUe3k9Wo
 HSTHlyPoJEM59x0NywI9h3JMaI3YrPn2nvI9xaDpPNyrLxeT2ZMSrxG0h22qAuAXG77P
 1gGrPrGsbSGtR+8cPGbwhs/v3weLWfI8c/YhTko5VvaGySkD22Y+CpjfXNkQ1BwyYgtG
 Waqh5QyWUUlMdC0D8lY3zZTDHuxlbRqY5xAejtGLHenq7yZC0xcBKxGohV/7+ylylPLo
 2LXLc8ozvqOHfF+iJgzIAkuXEHh8cdNcgZdwDqHDUZzqWfa9gdgqvNrEoty2ZV0KisGh Hw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-002c1b01.pphosted.com with ESMTP id 37sqyea3s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 11:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/8lGZ9HalY5T2Bl2Yr0XoPOlIhIVhm1GyVArCqJDc30PlWdGhlFcH9/taevFHOrC12aIjTs/SI85h1inFPQ3mJeYA2F83SLg3i0IHa6HXZvmmDd58UKbFm2bE6rJkO9qcghr+eBt7NaJ0KRAJ2OJEJ3zVkbw8Wc+ca4eAxE9iBiS2fX6BH/dzLE0mcKctOEl5C/li2i7SPyfJ+Xv2zLY33b+L5t0gVE5ET365jcKWS4Uf6tU4bIkp4+ClnXaxoCZjZSAN6lH3K+dBgdmdywB0nQ5td9HxzUqfhgGgqOi8ZyUkIz27ExjdxjXcxBhrdRWVOa6CCPKHmt5gKwelhQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+/ppC1PeCMmXoRyA1HZXf51xfwNsIqTMr5oskG37IA=;
 b=jf9B9AkEydX8Z1uMSUBkq6J4xeABCXo3gR+7F4Vq/1umrUCi+3qi83e1pxF9Vkqboh+eZJPmJMtWvX1FDm8aGSn3DBCAFgzXehJGEhXhfyflzznnGE7qhDX3E7rD2BOhEbSEjAtiYkRlUqJWkHL4ASih095dEKAW6elNuoj0eBITWMNC83aESKV0c02EykPArcW5Qj+wRgiMs+jk7TvEZXMiPf26FDGAp4tD9FNL32SvZll5oN4A3+CoxYrx7wp4oOQWbvbNOXeJORreRQNVzugNHFCdK81s16fUCb7xggRvIc4HTMsBFK8235zzQ2vOvXmj4KK+bmtZtEFZsRbl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN6PR02MB5280.namprd02.prod.outlook.com (2603:10b6:805:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 18:38:31 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1%4]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 18:38:31 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        "AlexWilliamson@archlinux" <AlexWilliamson@archlinux>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: merge slot and bus reset implementations
Thread-Topic: [PATCH] PCI: merge slot and bus reset implementations
Thread-Index: AQHXJrkTV5QyceIJbEKfiTx8AA1Ka6qfl1qAgABLDwCABCJuAIADjJIAgAEfDICAABDMAIAARPkAgAAJ14CAAAjEgIAB5myA
Date:   Thu, 8 Apr 2021 18:38:30 +0000
Message-ID: <20210408183821.GA12374@raphael-debian-dev>
References: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
 <YGW8Oe9jn+n9sVsw@unreal> <20210401105616.71156d08@omen>
 <YGlzEA5HL6ZvNsB8@unreal> <20210406081626.31f19c0f@x1.home.shazbot.org>
 <YG1eBUY0vCTV+Za/@unreal> <20210407082356.53subv4np2fx777x@archlinux>
 <YG2l+AbQW1N0bbQ9@unreal> <20210407130601.aleyww5d5mttitry@archlinux>
 <YG21k6/4QQNrw41S@unreal>
In-Reply-To: <YG21k6/4QQNrw41S@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [24.94.68.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 133f8fe5-80c2-453a-ef4f-08d8fabd8221
x-ms-traffictypediagnostic: SN6PR02MB5280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB528085C35E3B818212E89C1CEA749@SN6PR02MB5280.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYuBsQWC1X8hwj7ENe8xt6/7446tGRAUkTbG/cA3bCozlz2l0g7Msv/9UJtePeWvSJw/v/lfLcRMGeISEo/kP4TaN+iQHYDCEgVvJlm0mVDlYYFWW8zy+WsiNMdDOIg7BKXuAWWwMLsk0VFCUd/fyIgpbHAl9jnWoKYIRoUQwR2VF3BJYVW/0jmKyfS96Qi6sLmH6Nq9WTYF/hv1oHMfN4/MMsFNFQb1bdebHW+7Gywbgip+EJDharuZl6iBCwmIN844xQyhLM9CqHkqchK8B0dyyhAIc/Azqz9ia0Ss+4WozeLUh2lEoIs0haRQwNhBd+kv3YaRdRoO5bdXmpuwwitNaMwWGMH45i5QIVIyfR4ruSZ4zOVYMjVhSdurh0vv8FkRm5w0C/YK875KZthky4r9YbJupNO5wg5bBVGwVAdMDIBF41xl3K2oiWdgv9Ofpqfx/2/OXd1/kVixHbj+XnqR5fngZDZ8HEsF3lOrtWNYenOSzIZUNLEhEtbhNiNq6+zP2rAaCfxS5kqxk8hsTXm4W/3zYbtK+78DW9BqSKogu+/K1Waqmsl9mWjNsSGJOpCXJ3dIakv2G1IiEGKB5OvtUbpv2AOh+9xp9GTNNQUiiUVTAGaGr9Oyq6OLfyK9hwQWTvpy2roVDLEUsPa5OY2iq4Vsn4rxmlTAPuDbcCsaUJlbkM/IGzSX2DSCtCdHibUj1Dpj6DdXBwW3UH6ApRuGDdrF+o8X+LhaxjxffvJZDguXUy1RjmNq6WiCli48
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(376002)(39860400002)(346002)(396003)(136003)(8676002)(33656002)(83380400001)(54906003)(4326008)(1076003)(316002)(186003)(2906002)(64756008)(38100700001)(66476007)(66556008)(6486002)(91956017)(8936002)(76116006)(6916009)(86362001)(966005)(66446008)(26005)(66946007)(44832011)(6506007)(5660300002)(71200400001)(9686003)(33716001)(6512007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dwdjq9DTorb7VId/cgyf1hlV4orDt+7+q7Fwoh9753m3WG6rQpYX+QKX6M0/?=
 =?us-ascii?Q?atHyjsrmEHh9FxJ9pu439Ty72YnK+cXnr+5DFgtQUU8AisbpEgjYStSHY0zZ?=
 =?us-ascii?Q?1PBQw6SRHUa6hdr3AVyLbZTa86fIAfNpdAxAXD7ZOp+kD7uR8KJxkQ/xvWsA?=
 =?us-ascii?Q?1cywINym6pp9PNRzalZkMFugPVDLMPhbOjJ49hHL6p1IZqtN+ZuxD8G9fJsc?=
 =?us-ascii?Q?rJKIC8l+roXMp6szFyGZviaXJy9Id2zwfy1a4des9AihwEa9o3uuiBNwThjU?=
 =?us-ascii?Q?/yX73MV5mlG/vP1inF+BF2jXFe6PZczGmJR7GBsAYAcE3q1aVFNg8+biBUzG?=
 =?us-ascii?Q?gyefQIdY2KL/LBU1ACLAZbUbYLg59sYqcYyomI9+ojrYfZPAgAdMV8+cSFZt?=
 =?us-ascii?Q?0D7XR5BocWvlzXPOh2/ZaV9SQ2Kih02+vP4ckQ+mlSnAOuwMI7yj0kDtS7tK?=
 =?us-ascii?Q?485lRrQVC5DrzvoUj5ObOqKsPvuyFavKlcfaTVn9ZUZvETYaktn7CYQ2Trs7?=
 =?us-ascii?Q?Z/IL+GcPZBxCKcYYZC8MGKGX9AF2Pg+tsZEx/n1AAG8IIiQNLPxNLgTrkBT3?=
 =?us-ascii?Q?Au+vxAoy+KVcC33bgR4K+ZEd917gy0D5vTZWY38aRE1ix/extGZCkOEO+Y3I?=
 =?us-ascii?Q?o+v7PW6S+WW88duGmXbut+EH6yIjDmASR+c41WtJPlDZc+SDU7u/Vlpa4DGR?=
 =?us-ascii?Q?T5xLDyxuboKxS0lGOKxUUsxsR/GktqMsvKeretN6kNKQesJ15WmeK0RDve+e?=
 =?us-ascii?Q?5Vf1sf9nlrGwsH88PElPOmCLvG0PldTeBVYrO5kjE47SyOEbVHtD6Bogs3tY?=
 =?us-ascii?Q?em7l1XoaGtf4bfqLgGPBlLUpL0j2hvzwBQl+IRN/ihdMZQ3BwcPqKesar9CM?=
 =?us-ascii?Q?chA5y+tlxO3YDid+mWPNjiqHChNvzUYg8Yn3P+zC5WdNfi5EKNNDuY6jIMc+?=
 =?us-ascii?Q?DxPeouVniMp4vRITPPW/ZNET1HFyb9awqFkdcW0rf6LxHRHl1m6cNsG0s+ox?=
 =?us-ascii?Q?+WGO7c7q3pi/VhGbmOYeLmI8uDK5e/DG2zpr3Jbbo6SZ8C9To0XBu8I4KxSC?=
 =?us-ascii?Q?Qct7YwBvInjUk+PPmfxVLc+AWWZNIaw9h+2NiVEO2jCKRTtpU2jL3dXSutuD?=
 =?us-ascii?Q?VaVQAUxkwpmdLb/tbQxHJWYUr7OTkqyXI/Nwa3J/v19eSR39wT1V+trs4pDg?=
 =?us-ascii?Q?H1Ry3h5HOTO//gwmXji93Qt+9CfKphIpMUbMDr6knQy4bhtdfrqb3JpW3F27?=
 =?us-ascii?Q?KpT/KUTfrKkeTezOjZs/BeKioSyul6NghxvXR0trj2Sx1zqLkH0RZP+cZhMx?=
 =?us-ascii?Q?c1mzgJDiQhK/npLrEsgWA4no?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F8269E7421E524FBFDFD50C75E76F5D@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133f8fe5-80c2-453a-ef4f-08d8fabd8221
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 18:38:31.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIdW+kM2QkozwOAwXQnn6pHXldfwAekS2iaS2PK4ZdnX1y7Ye3p9wXPo9lyDwHnQ3UAk3it9/BQcPMKbnLyAXDm5vrQ3pP/3CwyaWfJOg5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5280
X-Proofpoint-GUID: DvQoNGi09CTo8fYKRqs-i-j7HLEsIRRI
X-Proofpoint-ORIG-GUID: DvQoNGi09CTo8fYKRqs-i-j7HLEsIRRI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 04:37:23PM +0300, Leon Romanovsky wrote:
> On Wed, Apr 07, 2021 at 06:36:01PM +0530, ameynarkhede03@gmail.com wrote:
> > On 21/04/07 03:30PM, Leon Romanovsky wrote:
> > > On Wed, Apr 07, 2021 at 01:53:56PM +0530, ameynarkhede03@gmail.com wr=
ote:
> > > > On 21/04/07 10:23AM, Leon Romanovsky wrote:
> > > > > On Tue, Apr 06, 2021 at 08:16:26AM -0600, Alex Williamson wrote:
> > > > > > On Sun, 4 Apr 2021 11:04:32 +0300
> > > > > > Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > > On Thu, Apr 01, 2021 at 10:56:16AM -0600, Alex Williamson wro=
te:
> > > > > > > > On Thu, 1 Apr 2021 15:27:37 +0300
> > > > > > > > Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > > >
> > > > > > > > > On Thu, Apr 01, 2021 at 05:37:16AM +0000, Raphael Norwitz=
 wrote:
> > > > > > > > > > Slot resets are bus resets with additional logic to pre=
vent a device
> > > > > > > > > > from being removed during the reset. Currently slot and=
 bus resets have
> > > > > > > > > > separate implementations in pci.c, complicating higher =
level logic. As
> > > > > > > > > > discussed on the mailing list, they should be combined =
into a generic
> > > > > > > > > > function which performs an SBR. This change adds a func=
tion,
> > > > > > > > > > pci_reset_bus_function(), which first attempts a slot r=
eset and then
> > > > > > > > > > attempts a bus reset if -ENOTTY is returned, such that =
there is now a
> > > > > > > > > > single device agnostic function to perform an SBR.
> > > > > > > > > >
> > > > > > > > > > This new function is also needed to add SBR reset quirk=
s and therefore
> > > > > > > > > > is exposed in pci.h.
> > > > > > > > > >
> > > > > > > > > > Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
s-3A__lkml.org_lkml_2021_3_23_911&d=3DDwIBAg&c=3Ds883GpUCOChKOHiocYtGcg&r=
=3DIn4gmR1pGzKB8G5p6LUrWqkSMec2L5EtXZow_FZNJZk&m=3Ddn12ruIb9lwgcFMNKBZzri1m=
3zoTBFlkHnrF48PChs4&s=3DiEm1FGjLlWUpKJQYMwCHc1crraEzAgN10pCzyEzbrWI&e=3D=20
> > > > > > > > > >
> > > > > > > > > > Suggested-by: Alex Williamson <alex.williamson@redhat.c=
om>
> > > > > > > > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > > > > > > > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix=
.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/pci/pci.c   | 17 +++++++++--------
> > > > > > > > > >  include/linux/pci.h |  1 +
> > > > > > > > > >  2 files changed, 10 insertions(+), 8 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > > > > > index 16a17215f633..12a91af2ade4 100644
> > > > > > > > > > --- a/drivers/pci/pci.c
> > > > > > > > > > +++ b/drivers/pci/pci.c
> > > > > > > > > > @@ -4982,6 +4982,13 @@ static int pci_dev_reset_slot_fu=
nction(struct pci_dev *dev, int probe)
> > > > > > > > > >  	return pci_reset_hotplug_slot(dev->slot->hotplug, pro=
be);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +int pci_reset_bus_function(struct pci_dev *dev, int pr=
obe)
> > > > > > > > > > +{
> > > > > > > > > > +	int rc =3D pci_dev_reset_slot_function(dev, probe);
> > > > > > > > > > +
> > > > > > > > > > +	return (rc =3D=3D -ENOTTY) ? pci_parent_bus_reset(dev=
, probe) : rc;
> > > > > > > > >
> > > > > > > > > The previous coding style is preferable one in the Linux =
kernel.
> > > > > > > > > int rc =3D pci_dev_reset_slot_function(dev, probe);
> > > > > > > > > if (rc !=3D -ENOTTY)
> > > > > > > > >   return rc;
> > > > > > > > > return pci_parent_bus_reset(dev, probe);
> > > > > > > >
> > > > > > > >
> > > > > > > > That'd be news to me, do you have a reference?  I've never =
seen
> > > > > > > > complaints for ternaries previously.  Thanks,
> > > > > > >
> > > > > > > The complaint is not to ternaries, but to the function call a=
s one of
> > > > > > > the parameters, that makes it harder to read.
> > > > > >
> > > > > > Sorry, I don't find a function call as a parameter to a ternary=
 to be
> > > > > > extraordinary, nor do I find it to be a discouraged usage model=
 within
> > > > > > the kernel.  This seems like a pretty low bar for hard to read =
code.
> > > > >
> > > > > It is up to us where this bar is set.
> > > > >
> > > > > Thanks
> > > > On the side note there are plenty of places where this pattern is u=
sed
> > > > though
> > > > for example -
> > > > kernel/time/clockevents.c:328:
> > > > return force ? clockevents_program_min_delta(dev) : -ETIME;
> > > >
> > > > kernel/trace/trace_kprobe.c:233:
> > > > return tk ? within_error_injection_list(trace_kprobe_address(tk)) :
> > > >        false;
> > > >
> > > > kernel/signal.c:3104:
> > > > return oset ? put_compat_sigset(oset, &old_set, sizeof(*oset)) : 0;
> > > > etc
> > >
> > > Did you look when they were introduced?
> > >
> > > Thanks
> > >
> > that code trace_kprobe in 2 years old.
> > If you want more recent example checkout
> > drivers/pci/controller/pcie-brcmstb.c:1112,1117:
> > return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> > which was introduced 7 months ago.
> > There are lot of examples in pci.c also.
>=20
> Yeah, I know, copy-paste is a powerful tool.
>=20
> Can we please progress with this patch instead of doing
> archaeological research?
>=20
> Thanks
>

I don't have a strong view on the style guidelines being discussed here.

I just sent a V2 replacing the ternary function parameter with your
suggestion.

> >=20
> > Thanks,
> > Amey=
