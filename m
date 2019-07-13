Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BC5679BD
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2019 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfGMKqY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Jul 2019 06:46:24 -0400
Received: from ms11p00im-qufo17281401.me.com ([17.58.38.51]:39879 "EHLO
        ms11p00im-qufo17281401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbfGMKqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Jul 2019 06:46:24 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jul 2019 06:46:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1563014384; bh=OD/Q9EqcER4g2NBgUnv1UvNa6HKJCb9gzMt9UXM18PE=;
        h=From:Content-Type:Subject:Message-Id:Date:To;
        b=Ku/+OjUBsILjsO1h3ykYTQ0JphMLGTJ7n/B9IPQFXgIuaf/l+mul0HsM6KyBpDz4W
         7kmcCkjsVpyXcVV7/P68B0+0I6VaH91oCIsFhLCKyja6P+UWXSvJtgtKDS3NaO9WD9
         20U1XOki0myLMI/38OlZ7Uij1oLUcHYPJGWUsGWZWQCsYgFX1Jqv47rKP6n+Ijocru
         uNaGgaN8UoqH+DL5t3G7oQVC7vz56/04kcGVBJ8TuMl0Z6IqAYyaI2h/f9nrHJYRYt
         b/mkE8ObRroTF8f7KyWP5tQtynwpO1+1dgEfs2d2x2U1Mi/IZvMOCeyffPOYboZWoH
         eprUho6h1TQrQ==
Received: from macbook-pro.home.local (67-198-76-2.dyn.grandenetworks.net [67.198.76.2])
        by ms11p00im-qufo17281401.me.com (Postfix) with ESMTPSA id 6EC59BC09EE;
        Sat, 13 Jul 2019 10:39:44 +0000 (UTC)
From:   "return.0" <return.0@me.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: pciutils: decoding extended capabilities with variable size based on
 lane count
Message-Id: <917430A7-9813-4F54-A135-BB965950EE27@me.com>
Date:   Sat, 13 Jul 2019 05:39:49 -0500
Cc:     linux-pci@vger.kernel.org
To:     Martin Mares <mj@ucw.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1907130129
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I was working on providing a patch for decoding some of the 4.0 extended =
capabilities, but hit a snag.  The Lane Margining and the 16GT/S =
Physical Layer Extended Capabilities only have valid data for the number =
of lanes (up to 32) currently configured. It would be nice to know the =
width during decode without having to re-read and decode, but instead =
grab it from the device structure. =20

Would you support making a change to the device structure like the =
following:

diff --git a/lspci.h b/lspci.h
index fefee52..69912fc 100644
--- a/lspci.h
+++ b/lspci.h
@@ -42,6 +42,10 @@ struct device {
  unsigned int config_cached, config_bufsize;
  byte *config;                                /* Cached configuration =
space data */
  byte *present;                       /* Maps which configuration bytes =
are present */
+  int cap_speed;
+  int cap_width;
+  int sta_speed;
+  int sta_width;
};

extern struct device *first_dev;


Then within cap_express_link, the value would be stored to the device =
structure rather than a local variable.

diff --git a/ls-caps.c b/ls-caps.c
index 88964ce..bf600e8 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -781,16 +781,16 @@ static const char *aspm_enabled(int code)

static void cap_express_link(struct device *d, int where, int type)
{
-  u32 t, aspm, cap_speed, cap_width, sta_speed, sta_width;
+  u32 t, aspm;
  u16 w;

  t =3D get_conf_long(d, where + PCI_EXP_LNKCAP);
  aspm =3D (t & PCI_EXP_LNKCAP_ASPM) >> 10;
-  cap_speed =3D t & PCI_EXP_LNKCAP_SPEED;
-  cap_width =3D (t & PCI_EXP_LNKCAP_WIDTH) >> 4;
+  d->cap_speed =3D t & PCI_EXP_LNKCAP_SPEED;
+  d->cap_width =3D (t & PCI_EXP_LNKCAP_WIDTH) >> 4;
  printf("\t\tLnkCap:\tPort #%d, Speed %s, Width x%d, ASPM %s",
	t >> 24,
-	link_speed(cap_speed), cap_width,
+	link_speed(d->cap_speed), d->cap_width,
	aspm_support(aspm));
  if (aspm)
    {
@@ -824,13 +824,13 @@ static void cap_express_link(struct device *d, int =
where, int type)
	FLAG(w, PCI_EXP_LNKCTL_AUTBWIE));

  w =3D get_conf_word(d, where + PCI_EXP_LNKSTA);
-  sta_speed =3D w & PCI_EXP_LNKSTA_SPEED;
-  sta_width =3D (w & PCI_EXP_LNKSTA_WIDTH) >> 4;
+  d->sta_speed =3D w & PCI_EXP_LNKSTA_SPEED;
+  d->sta_width =3D (w & PCI_EXP_LNKSTA_WIDTH) >> 4;
  printf("\t\tLnkSta:\tSpeed %s (%s), Width x%d (%s)\n",
-	link_speed(sta_speed),
-	link_compare(sta_speed, cap_speed),
-	sta_width,
-	link_compare(sta_width, cap_width));
+	link_speed(d->sta_speed),
+	link_compare(d->sta_speed, d->cap_speed),
+	d->sta_width,
+	link_compare(d->sta_width, d->cap_width));
  printf("\t\t\tTrErr%c Train%c SlotClk%c DLActive%c BWMgmt%c =
ABWMgmt%c\n",
	FLAG(w, PCI_EXP_LNKSTA_TR_ERR),
	FLAG(w, PCI_EXP_LNKSTA_TRAIN),


Is this the best way to handle this or would you prefer a different way?

Thank you,
John=
