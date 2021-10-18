Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD643166D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhJRKuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 06:50:09 -0400
Received: from mx1.uni-regensburg.de ([194.94.157.146]:57750 "EHLO
        mx1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJRKuI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 06:50:08 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 06:50:07 EDT
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 9070D600004E;
        Mon, 18 Oct 2021 12:40:51 +0200 (CEST)
Received: from smtp1.uni-regensburg.de (smtp1.uni-regensburg.de [194.94.157.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "smtp.uni-regensburg.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by mx1.uni-regensburg.de (Postfix) with ESMTPS id 71B1D600004D;
        Mon, 18 Oct 2021 12:40:51 +0200 (CEST)
From:   "Andreas K. Huettel" <andreas.huettel@ur.de>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [EXT] [PATCH v1 2/2][RFT] ACPI: PM: Check states of power resources during initialization
Date:   Mon, 18 Oct 2021 12:40:47 +0200
Message-ID: <5521425.DvuYhMxLoT@kailua>
Organization: Universitaet Regensburg
In-Reply-To: <8835496.CDJkKcVGEf@kreacher>
References: <21226252.EfDdHjke4D@kreacher> <8835496.CDJkKcVGEf@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5773348.lOV4Wx5bFT"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--nextPart5773348.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: "Andreas K. Huettel" <andreas.huettel@ur.de>
To: Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [EXT] [PATCH v1 2/2][RFT] ACPI: PM: Check states of power resources during initialization
Date: Mon, 18 Oct 2021 12:40:47 +0200
Message-ID: <5521425.DvuYhMxLoT@kailua>
Organization: Universitaet Regensburg
In-Reply-To: <8835496.CDJkKcVGEf@kreacher>
References: <21226252.EfDdHjke4D@kreacher> <8835496.CDJkKcVGEf@kreacher>

Am Freitag, 15. Oktober 2021, 19:14:10 CEST schrieb Rafael J. Wysocki:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To avoid situations in which the actual states of certain ACPI power
> resources are not known just because they have never been referenced
> by any device configuration objects, check the initial states of all
> power resources as soon as they are found in the ACPI namespace (and
> fall back to turning them on if the state check fails).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Andreas, please test this patch (on top of the [1/2]) and let me know
> if it works for you.
> 

I see no negative impact (actually, no impact at all) of the second
additional patch. The network card is again working fine now.

Boot logs (unpatched, with one patch, with both patches) at
https://dev.gentoo.org/~dilfridge/igb/  (the 5.14.12* files).

Best,
Andreas

-- 
PD Dr. Andreas K. Huettel
Institute for Experimental and Applied Physics
University of Regensburg
93040 Regensburg
Germany

tel. +49 151 241 67748 (mobile)
tel. +49 941 943 1618 (office)
e-mail andreas.huettel@ur.de
http://www.akhuettel.de/
http://www.physik.uni-r.de/forschung/huettel/
--nextPart5773348.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAABCgB9FiEE6W4INB9YeKX6Qpi1TEn3nlTQogYFAmFtTy9fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEU5
NkUwODM0MUY1ODc4QTVGQTQyOThCNTRDNDlGNzlFNTREMEEyMDYACgkQTEn3nlTQ
ogYfKw//S5bt6q9nYvhToeuPtf23hVN0zT0fxyKHkKyaXRBSm7dBNbOd5ohEMNc7
FQ7c2cOSgimJcQDBGzWn63X6T5XhzV8A7O9ITfq+UUfWxn7Xi0v4gCI3jubWjkep
eFc2McLw67yngcnaDPFKaS0nejuWnoiRHA/4jUr36aoIDaGTYPq7IIxnEuhIGuzK
Fu4m5NPOKcbhPtT5Bzut+fklzllD/ClKaNVZHToQmQkdkzaltTkFCwcGQTu05Q9j
s4oxtPfwISCugoMQOJOVcJfqD2JRhw7yt2/c871G0ALhd3Yr6ZQMCZmw5IaP+p4E
6NQL/9qU9a68Qrq+/XZ+AwGkIVKxBQuYMoazb5yw2rxhqBm9PDqriFZKmmxNZGZw
OvmldGYFUc+5xMZ5OL1pTikS5OcIv6hHLsT5rUJJ+lN7izaQuWngrWHcdB/P5Bds
RAf5wV3bWCKGBzfDF6c9IA3YCmUGlumfx0Sr4TigYDBOlpFL7H0aEsQ4PLsCB8WL
drkAI5SZ3PUJf6ZyTfPP3SLEkKvgJFfn/0ujOzKlDZqjU9iQYAtho45BAOWiWC43
g81MZrFbOTtw5BFZbv79cZj8abDKcdcZP6cKyIzbEXH0z/qOH2wmE9Yp9iFRJBjG
HFRyCoP8iKL1m1wWk63uFlnP4FpEFkgwAghyCRRynuVxd5r8CBg=
=O5sO
-----END PGP SIGNATURE-----

--nextPart5773348.lOV4Wx5bFT--



