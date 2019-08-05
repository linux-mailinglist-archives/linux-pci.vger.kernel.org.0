Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD394820E7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfHEP4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 11:56:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:58929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfHEP4m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 11:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565020600;
        bh=uZ0GQE+bq3tEMwO9TsUWMyD41PI7nE5UCdk1pHOjVzQ=;
        h=X-UI-Sender-Class:Subject:References:Cc:From:Date:In-Reply-To;
        b=d6YDM+3goja/Rv8A2nmj6KEZnRDvP+idpKUmql3cn8Qs0ixnZlZ2jyDAwudusqOpF
         meZBOGu6EAz71j53AnLKgVQwO+aQrfbbxeGi5kMqd35teCTjqj3O2/lHIkYEDjaal4
         j7xeanXsVgP87gwwd2RGcST6ClHYMGKB4MhOH2a8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([79.229.32.156]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7kwW-1iGiRE2acS-00vO3F for
 <linux-pci@vger.kernel.org>; Mon, 05 Aug 2019 17:56:40 +0200
Received: from ryzen.an3e.de (localhost [127.0.0.1])
        by ryzen.an3e.de (Postfix) with ESMTP id 95AFC120093
        for <linux-pci@vger.kernel.org>; Mon,  5 Aug 2019 17:56:39 +0200 (CEST)
Subject: Re: regression: PCIe resume from suspend stalls I/O and causes
 interrupt storms in Linux 5.3-rc2 (5.2.5, 5.1.20) on Ryzen 7 1700/AMD X370
 MSI board since 5817d78eba34f6c86f5462ae2c5212f80a013357, 5.2/5.3 w/ pcieIRQ
 loop.
References: <935c6fd8-c606-836a-9e59-772b9111d5d6@gmx.de>
 <20190805122751.GL2640@lahna.fi.intel.com>
 <20190805124704.GP151852@google.com>
 <20190805130039.GP2640@lahna.fi.intel.com>
 <0d234153-3c30-c0da-7419-220528897fbf@gmx.de>
 <20190805150803.GU2640@lahna.fi.intel.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>
From:   Matthias Andree <matthias.andree@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Message-ID: <910e45fe-7651-8ddc-99c5-a6ac7c19c22e@gmx.de>
Date:   Mon, 5 Aug 2019 17:56:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805150803.GU2640@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:r8gO8Rz1tyR+CBWgSwcfYyAYITYRbSFkwwIysWoKDBWVHm/Ls3R
 qz2gOZNU+FoDP9Hakv9ZD43dJ8QLo4JVEKuzaR4ue5HU2takUugW0BoYrWLXs8zUjFjKIJX
 082LtcmdPmzfl3lyXrMmiYwBm6nCp5SJtdPbQu/9VXN3cB8seSi/HST7jXfxZ+yliRPNvD2
 ijxRvu6rdK0bPYtLDE/RA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NW10YAUNVuc=:TSSaqopFXveCNhYFsdMneJ
 PCInADpLWN3gV8afdUqOHQOs2SAgcgTOIbIyJL6RsPk1oxaLLZk08nuwGQLN6HavnG3x3oIIQ
 eFzOKG4kcW0TxvR5+Gd4d/vqzjXkTsrRpsbCAPqi6o+y7u6SwoI0NhHMhMOYi0yLJMOfswlFF
 4LBHz63NrbUzXzBjjhg/YvUUDJcokOvjwUy1Wuh1gSiaiyMtKo9B9a8XM87/F0okbSvnkEQ7M
 X32tALOcENG+ZBTLpZsJxwYNh79WNaKt175A5pXhzxmFXCu9UZIWQ+BESOVmnsGTUdBS/qBE+
 adClmvzXDtafRHImroxtfeJQLhoWfq5xfUBaBEFIBcUvtAIQLZxO/xC3AmCxLePfePp+eHSF+
 Q7XA/fRB19EMIkh8s/S001hVEW26i6AhzwICwYEkxXNcgUBg8RgxT9mBlS8LpQqCcR8+9iPNF
 u+U1Zj0aIZ2mxfUxY2Tx3bcVEBwtGP6XGQbo96wEO2i9K8UAUSMeE3/d0NvZ901F14w5esqzS
 54j1GnZphcyFkiNGrPaVQ+EoLiUf6TxM1r7rVuhkmF4bII2TnFafrS4DwkUkdQ/rKVuZKY92F
 Idd5lkPtW7ClV8VOFoaLBUzI2vjBAfITADEw6SjfZ8Mqx/iO5GV4gJKIWjeYSNAKBZoxJBOvq
 QTeLwfzpLcYTuJ7fgS7YUyJXkfY8MoFzlifYtGRZkaynFAU51G1UNUxwJ/F14V8zHp3sQvW12
 veTJ3YKwU+7aHP7Pev4JVISlKCgAApMrABNA29c8KbR8azLic3Hl6tZMVBaP8YoeOxPe+jACm
 v7HQrYsnF+Pa0Gxwo2VSMnGRIQphcUNesOJnQsG9vEi25lzmnMbM3iytnitg/tcVg0APSM/ec
 Bp9fKPDYbKc1R/qRn6O4hO4yWOHyYjRKap1Bt2xhkNnhyYLFovrg0eU0hJl4AsB7mwnpVbFFf
 UoDt5VFI86OOgDvyoZgNPvXpq7C5ZEDJRcDUJDSf2khq8unW5ah4O2tNhhTCMnHS1Ytcc9EGp
 Qxq8reeRnFuiJ36bilfq4Bfp/f01Ii7BqGqNDzB05wZd4sVOGLGC1ZeFiNoQsUFfIkeyLGa7E
 v00H9TvXh3NN8Rt2rRytbXY6MPPIjkyPfUsNmdAdqZEe0mXFBbWzQayNXfXPpg4j8PoMEYAur
 Re3+o=
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 05.08.19 um 17:08 schrieb Mika Westerberg:
> Can you also attach the dmesg.txt to the bugzilla entry?

I chose to mail it privately.

