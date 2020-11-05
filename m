Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221FA2A8607
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 19:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgKESWp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 13:22:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:53071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbgKESWo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 13:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604600548;
        bh=Pc5dbaOido24NXVb8HZQjU9gpMX01LN8EOHWxl80a84=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=BFWGCTu195qaD4Xv4Rn8gKgigHnyGgo/1Aqq/TAJFaynGfiIHy9Lw4lUQwZKj6Y6S
         BIUO8eDrNfhFCc/av2fv+XZujyKclHLdJDDtV54nJk55bBzVCtaceROj1rY8KhxK72
         SLw07C6KN2NaxSP3INreQTHfKbhqlKwM8uOEF6TM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.147.34]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1k3cD53Mkh-00dX4I; Thu, 05
 Nov 2020 19:22:28 +0100
Date:   Thu, 05 Nov 2020 19:22:25 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
References: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] PCI: mediatek: Configure FC and FTS for functions other than 0
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     linux-pci@vger.kernel.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <B6B7543F-E57F-469A-A4FB-C4B4E98345C0@public-files.de>
X-Provags-ID: V03:K1:CcBqTaMual05Jcwtvw5hBu21DlgbPmbjcZcpR7jddnT/v//uArp
 M8xkGEG+pb/dajrE0rlzGwzpP2IezhLUX5fdzjoLuWLuGeZO+jqWOHvgEdPc5A3LjyOmR6u
 qzXnTdCNL0yDJaWJIkwHsSqhHFiHkzdGGH9giA181eA9Y2xB32Qemg72m9qTneTCJycKtSz
 a+hjvSubA9bWs+T4aKgQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F5MTwzFoSuI=:a9D71ezL6d0ls2dfKDUfi+
 gEdLyxDg6omv2WsqNd6xYdG0k324fYXKZaOSY0ILES8cHy8OZDFiDt3atMNp2fCiwKllzJvUU
 pj2Ej45bpEfRZj680ATurbAtgAKiYmi1qtBRnG6Lmdkg0xXr7sNAMoH5jLbXjcwd2U5NkBMB3
 9xwk91WAqp2uAM/aW7A/dXD9euexCRP/fkBRyo00CvO6I78rwtZot5muujx6lJPuqE/mHAzwy
 NNagoeOZIKmq3MNjUSsXsD3QEWkAoJEYupYe2r69ke5Pn/sew9zL8Ev58cOszNbDOYHjEywoP
 xfRY8cKRBnOYRY8bO5Rp+cxVsp/5DyxWg5vt+iNh7jXrbmty77fMuQDTteyUFct9zPx/TBWSz
 Ar1wQ0y/V/dx22+DMnBzebZowUEFha5PwFLZjUDzv8PCRwYrANteX+7KtjAtHRkJmYJtwjjq3
 aiDqZkQdtg6frSpfsQfERhvwmg1bpOFuT6X7/Bx9zuWY579WYFRDb0BptGHSVwKCPSaZJdl3C
 xLZv6QvEAv05fdegKCz9x7UMr/rEPC5f4TPnjoAZoCz0Xk/VpicpbgISBkuMJO54aKpVM5si/
 sXuhjmWz2WIWj1RPtaXRFMzU8ONfnnGzVose5rO8DQnyPAs7OJpnur8eTEpuezPYIjOkLU6dB
 HJDA4BixbhBmeYDdz/5T1TzjapOHVMgKbro0MAjRlKwxTJ+EASzluLVTNW05NlQX+vF9l8edf
 XVwVLdUfu0qqJbJCOTd6rx9PuVXkm8Qpafj50UULul8YHBSghK7uBOXgNmvmNyYuLtQ8z3WUU
 9aOKUBYHEgOstReZ4Gd7ir9OCyiGw8cA1vVyfe27MxurnbyHRG55vaiUaua7y+qgoBanmtWIl
 j10B75qb1baRL+NVxM/w==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

How can i verify (triggering bug without patch)?
regards Frank
