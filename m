Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29289D3CC
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfHZQRJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 12:17:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:33959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731950AbfHZQRJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Aug 2019 12:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566836190;
        bh=s54ttNbPjMmgaywLYl/fIGUCXpGizAY5jyRSfFgH75g=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Xoa0pz2eniMEL5+fk08kJDGQ4OIkoawO2g1GPYzbS3XpqP1gfD+tkLBQ7S+j3Rymf
         T4D3Hl/mnqjWmEy7reYGdVJ84dvqu0RG1rRRM9u0bDqMVHeP4craOUEy7idm9BSlOT
         UqbD+K7zZnCJad5VCh0h4ZJO4xOV4e3BgYIzqyhc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([84.160.52.178]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1hvAvo2fde-00CfZb; Mon, 26
 Aug 2019 18:16:30 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id 14A4312009D;
        Mon, 26 Aug 2019 18:16:28 +0200 (CEST)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
 <20190824021254.GB127465@google.com>
 <20190826101726.GD19908@lahna.fi.intel.com>
 <20190826140712.GC127465@google.com>
 <20190826144242.GA2643@lahna.fi.intel.com>
From:   Matthias Andree <matthias.andree@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Subject: Re: [PATCH] PCI: Add missing link delays required by the PCIe spec
Message-ID: <1880d84c-b8fa-47ca-4fc7-191ccc6f976f@gmx.de>
Date:   Mon, 26 Aug 2019 18:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826144242.GA2643@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:8K+LTxU6Q9TX6ZRRU598LWGuX79LZb5ELp7s0G7h9sGzA0/qdcy
 NQjqitqmf3addJg+sZBu6vFtommkLJ7x8iEepkSabmAS9CCzDNnVUIEZKMKkUPt9FO1m34y
 KeCS9VBqBFHrLOeEprtZ5SUVP0u6LOwwVMJtRD7LubK2x61SD5utppy6p47Jd2ZkkOU1Ydh
 /aIQxWir5hgP265kSqW2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:thTn0Mmxle4=:+CjcXst3Y5rSLAv3z2rmQ8
 CgChpbtY+qYbmmf3alk9RDSUNQzYReWM9KkvQAxe/YRfdg0UGOgoiR7LuDWr8/fWGY87jGvmS
 BzwGJSV6VM/701kl1bMUeJIlzjaSVwLNacG4lb7rl7wumFzJjBD1yfqLDW9nSc9f5kAX5BFs4
 O011ydjVLqdHxg04VpKjyPwlLm5JboqYhHglXo7BEqgKqok9QXOHYw/iPzUKsA8GVyOn29ust
 9WlTBgyXDlwjR9pGaQM8Q7UvfnWLFeo2mSZoFHMiojX8TMYkYlwZhBVag+wC74U54bR/74mBl
 49SXjRxRFjifxQSex98DpubQHQapp41xJmt8yu5D5/O121MKooQ6H9n7kHsdBNge3RBo0qdXK
 CCatuulh6w1CQp6a1PtC4a3yh2qWPBMhvFiOQBrzFLSlqObp3CxVMefCKFc5XRMIDxB9i9+Go
 pvPQ2P5sW9oZqesD2t67zzRlg4iDm5bqvppppfXwAqqluG88Jx9QImee/MpVi8eqLsWrDHkB2
 m273lK9qaUUZcN5LUf0ht/sBPP/hLNjN94iRLnjbkmBri2ULBrV12WOaPUMSeTLtkM2KPoyBO
 U1UZqZDxyTLXs/sSTWG6do0y09RG4fAy6tcncHAzSBYy+doKHptH1rtHzQ2sKaM0b+4Da1OfD
 g+6Rge9GXG2ARfrBcKCPRmn+WICgRBQ+Lgcqtjkeogpxdd320/Opj51d9qhWOaUekmXGaphyP
 mKu82qrN3sSAjRejfPhgI12Ow76v3hMZmoBt6OdbsrZz6Cgje3aOzWCSAXHL/qRT5DBlos8Ju
 BlRTi+pIBtAzWrTSQvEkN3XbsSDIXQ4UX5srb/RkJ5hwtsdfqJ95e1vyTi+JIC1IZBkflIiGY
 Yr+cjUbNGencgG3BPh9pAmN64bwKopPFhOIidX8ZobQXrYCzeOy6C5VYEjYCk+MLnPSDbTzYB
 K9P1bhiXjHJK2w6iBYCQG5LVh1yjo8c1xzCgUAWNAinoOpBGrDEZO5lHK0Gmfg5snP/QlSuFZ
 JwyGMQ4b+Cn78cfGbeduOtX5ad65yVcppbnaXkWjRCr1Rkzj+I8m59lRl9/tKamrVd62OoDuo
 IAhXjUZ9o/4TRWMqUFSjuWgHUC81iRFaYLeGW2GAYSEDx+zVFiKITjfMCtk9arT/QiOHdQkde
 OOrDA=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 26.08.19 um 16:42 schrieb Mika Westerberg:
> According to PCI FW 3.2 the OS is responsible for those delays if the
> platform firmware does not provide that _DSM. So simpler way would be
> always do the delays if the _DSM is not there.

Well, that is

* unless we trip over delays that make other parts of the kernel spin
crazy in unterminated loops because there's this mismatch between the
PME and the readyness world or whatever you analyzed my system PME
interrupt storms for.

Note we normally resume devices asynchronously these days unless someone
zeroes out /sys/power/pm_async.

* assuming we're not seeing complaints from I think it was Nicholas's
system with wakeup/resume deadlines.


