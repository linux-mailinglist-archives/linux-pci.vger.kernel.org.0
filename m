Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0E624C0BD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHTOj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 10:39:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46204 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgHTOjX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 10:39:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07KEXTOs049256;
        Thu, 20 Aug 2020 14:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to : content-transfer-encoding; s=corp-2020-01-29;
 bh=8vkwBt/4YEhoEn8LKQ2IVN15+QakSrmeykzU+jcBU6Q=;
 b=CIToX4O3a8L3vRrM7lAPdqrTJKJpsCnugXltQ6XPMk1tKX3qSDtlF2ujRL+rQi65/Jcp
 Cs0pcFQ5DSkVwMS2EqhLeLNPTSpH9gthrHB2r9ufPiQzpqcrb0dzbdAIIDyuE2Zn2yQg
 Fm+n+NYnshUVrdTuRwtQlo6Sd93FfSpcXN1gXCVMU1uZC0Q3i0A485xyOOJCBmM0Ue1V
 07Bx/BFbk57oU6+5LiTYULEfWGHimqdkBe87zWzqGUgzGp4YMGePwcrziguLRNnNjSFc
 q/MSYsAMh5Ja/J+mXa8X9RCpuxBu4nW2vhCQPOBcfSjPoDxoNFFW80y+z0fwmv6Pl1P5 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32x74rh064-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 14:39:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07KEX2bf098374;
        Thu, 20 Aug 2020 14:39:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32xsn1f46n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 14:39:08 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07KEd63Y000740;
        Thu, 20 Aug 2020 14:39:07 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Aug 2020 07:39:05 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 4456A6A0127; Thu, 20 Aug 2020 10:40:20 -0400 (EDT)
Date:   Thu, 20 Aug 2020 10:40:20 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] x86/pci: fix xen.c build error when CONFIG_ACPI is not
 set
Message-ID: <20200820144020.GA31230@char.us.oracle.com>
References: <a020884b-fa44-e732-699f-2b79c9b7d15e@infradead.org>
 <88afdd4a-1b30-d836-05ce-8919b834579b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88afdd4a-1b30-d836-05ce-8919b834579b@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200121
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 19, 2020 at 08:09:11PM -0700, Randy Dunlap wrote:
> Hi Konrad,

Hey Randy,

I believe Juergen is picking this up.
>=20
> ping.
>=20
> I am still seeing this build error. It looks like this is
> in your territory to merge...
>=20
>=20
> On 8/13/20 4:00 PM, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >=20
> > Fix build error when CONFIG_ACPI is not set/enabled:
> >=20
> > ../arch/x86/pci/xen.c: In function =E2=80=98pci_xen_init=E2=80=99:
> > ../arch/x86/pci/xen.c:410:2: error: implicit declaration of function =
=E2=80=98acpi_noirq_set=E2=80=99; did you mean =E2=80=98acpi_irq_get=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
> >   acpi_noirq_set();
> >=20
> > Fixes: 88e9ca161c13 ("xen/pci: Use acpi_noirq_set() helper to avoid #=
ifdef")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: xen-devel@lists.xenproject.org
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  arch/x86/pci/xen.c |    1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > --- linux-next-20200813.orig/arch/x86/pci/xen.c
> > +++ linux-next-20200813/arch/x86/pci/xen.c
> > @@ -26,6 +26,7 @@
> >  #include <asm/xen/pci.h>
> >  #include <asm/xen/cpuid.h>
> >  #include <asm/apic.h>
> > +#include <asm/acpi.h>
> >  #include <asm/i8259.h>
> > =20
> >  static int xen_pcifront_enable_irq(struct pci_dev *dev)
> >=20
>=20
>=20
> thanks.
> --=20
> ~Randy
>=20
