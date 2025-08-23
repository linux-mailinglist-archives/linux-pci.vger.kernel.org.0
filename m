Return-Path: <linux-pci+bounces-34623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B711FB32779
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA24D688180
	for <lists+linux-pci@lfdr.de>; Sat, 23 Aug 2025 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058A227563;
	Sat, 23 Aug 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rmaq7Vv8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751C220F2D;
	Sat, 23 Aug 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935529; cv=none; b=N+naYeJOcgvoT4mx3BuKiX5nb5pYjKniaxu10qwO5j1l+4AbLkcWbR9ebmhrvEP3z2YxptbinEtCYSFS57i4p7L/OADB/Z6YEvWxqVBW3qCfc+fgEc8Olyu8ajdydKzxwKA4WDvn9ihnfRfHbcatDzDK98pUuG3M3mw7a+vWQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935529; c=relaxed/simple;
	bh=5o+0D1n5LzCDGJ5J9EsY1LcJvyZXfSwVmlJ+vDB7B68=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=e2SM22pLrdV9g1JCQelfyV6OgLINhRXUMan333bvZMgNIHx4SF45Vd+WiXjO+BOonXcZjFViCAOVnbWrViXFFxNoHtCbEdZorrJVEoHP1c1om0bhBKMsdrvtGNWoAKtiQZpSooS3wEk2e2x3OGnsiGpba8+m9/EQoFXAf5XgmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rmaq7Vv8; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755935519; x=1756540319; i=markus.elfring@web.de;
	bh=Qf5CVv65Me7qjoCGacaeAjxZYl+0ViIJjRMrCu2vhSE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rmaq7Vv8SfKkzDRXoUI082orawvxAQEjjjVz5Tw6pPqMLx72q+/G2NWlUfud1Opq
	 4i4dPOdepvE+3iDTunI6465TF3nqqYdaEj2kIbP2sD5fiVqos8aqSLMAr8hhQ6pcj
	 LUnLjsShTywINgufNoneLSiNzyLs5nw3rW4K6yTtFO7hUUTuTnRPOH4XO5EDdPS4k
	 IZKTAnDSuXL7PIhadOTmQXsriPDDCemsiveAnJF/Lk4m/8S7xWOPI9I7Iw/YPeEUN
	 g/c9En8XduOYtFXk55LpnfxnjgJCS+waJ84jB3aZpMDzPPNtQUISnnSORG/0LgOnx
	 wHHGs4COJ8Znw38KIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.194]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1v7FvT0TJo-00YlXR; Sat, 23
 Aug 2025 09:51:59 +0200
Message-ID: <599e9acf-886b-4394-86bb-099e062c5b2c@web.de>
Date: Sat, 23 Aug 2025 09:51:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] PCI: Reduce the scope for a variable in
 pci_bridge_release_resources()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:duYpOtCaSJ9Vurg1wzh/YieBGnTVjmnNUubqHzu+MQLF204UkVH
 bbt4P4Oe1LhN4ZZgKmsgJlYQFS6k7IcBvsRU3aW8EWV4Bvj+X/Px9mk8Uzp85htDNDDlz4Z
 5Zyej1e6DqT35Xtw2V2jE4mMhDumHvG4Jng5qK4Sm3bHc4O2oz6RHbC5EIIfbRgcfy/8RU2
 jbFMY5CMN3/zdsjXZqqrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tXto0ZJBJcw=;x5uODBUzBbEinezRc7KorgufjqH
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Aug 2025 09:40:13 +0200

* Move the definition for the local variable =E2=80=9Cold_flags=E2=80=9D
  into an if branch.
* Put the assignment for the local variable =E2=80=9Ctype=E2=80=9D on a se=
parate line.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pci/setup-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 119f97b96480..38bf4e673bd7 100644
=2D-- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1714,7 +1714,6 @@ static void pci_bridge_release_resources(struct pci_=
bus *bus,
 {
 	struct pci_dev *dev =3D bus->self;
 	struct resource *r;
-	unsigned int old_flags;
 	struct resource *b_res;
 	int idx =3D 1;
=20
@@ -1751,7 +1750,9 @@ static void pci_bridge_release_resources(struct pci_=
bus *bus,
 	/* If there are children, release them all */
 	release_child_resources(r);
 	if (!release_resource(r)) {
-		type =3D old_flags =3D r->flags & PCI_RES_TYPE_MASK;
+		unsigned int old_flags =3D r->flags & PCI_RES_TYPE_MASK;
+
+		type =3D old_flags;
 		pci_info(dev, "resource %d %pR released\n",
 			 PCI_BRIDGE_RESOURCES + idx, r);
 		/* Keep the old size */
=2D-=20
2.51.0


