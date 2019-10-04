Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C925CBB05
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbfJDM5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 08:57:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:43195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388061AbfJDM5r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Oct 2019 08:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570193838;
        bh=F50AMpOHbd4s8eFO36ofoZZBUtaiW9eDG53Yk4hhqkc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k00IkPP6PXIfU2PIpXY5/q882r8kjeXHjpWS4CKN0QLq6wHSxLNDonO4dgOtXxkRS
         KXk24xQ5wkU+NiITzw59Olum17QPajbSqCUtKCg+cQjK2CahQkTxQx6tBE14FW4REJ
         xHPo7dx/2U3zSGw3tUMtcDuJuyLBKssgQbsQuWuM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([79.229.35.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1i2T9h1QVH-014zdD; Fri, 04
 Oct 2019 14:57:18 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id 1179712016F;
        Fri,  4 Oct 2019 14:57:22 +0200 (CEST)
Subject: Re: [PATCH v2 0/2] PCI: Add missing link delays
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
From:   Matthias Andree <matthias.andree@gmx.de>
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Message-ID: <811277ae-bec1-1724-23ce-c13407bd79c5@gmx.de>
Date:   Fri, 4 Oct 2019 14:57:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:jC6TDjq4L1myf+H9+sgI8I3U5Xx9AeoyV/bcuj80tVdcc9HvHUf
 LjfYiH1GhRWt2vrc+kXILZIZOlkk0Sld9c2lIp0dwzlPfVHvkWt43IowGUIkgrNClumrDZE
 lXsaoMy2zfEP79Xm7vwkzqJyWbMpWwZtdk3q0NPahFmx56ICCFixG9EaB3dSLIJ+VHE4tyn
 5QeSnQ+9VIjhyIfoUyD5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJitIYKQzWw=:3+j+kN590mna7RSVZ4G4p6
 cI7O6l05lUEe9OSywGzWbQvCJa1Z2LaKbmvPstEwRl1xESuTRfOfq1llPaNvTbQ5vXN6MtnJ3
 WvFAYxBVjN8wGqZ/n7ihclgrATasaO/Y/Zp3L9NnirlPxvbjBNMvVuExsjq92/pgorJPb0qQB
 x/5Mh/cZtgGdHsdBgaQ2xx89br417WDVtouynurhyEiH07KqU6lFLK5N4QwwfBvd7wgTDkgrc
 oYzK53NjB2YuStseHVhaMhDjGoBU3Q2tHgIxhIU7pxVViVXHRQLeerEx5Qd5iAx1REuNS0gXo
 +Dm/VnwT4pXC/m7rCeI+LZ0t23daAtBXrocAoyiJDM4WpCOqRUQTkI7JI9LFQEPF04+3uKv1I
 KmIFI91oscWfYq36w9OeH7BsfQ1UpN+cWdQYjAMKJ06SywEKN5cM16gpWpYg/6zI4+q4fmbJH
 KK/WVmKV4wJ0F2uGzKjS7NI+rJmPk/fi6/UZK32EhDzqtQCbkua8BUA/f/1mdSZr5C7jbcW0r
 s8Zltj27yxHdS+FCOTs8XoqIR7t9d0LOqSSYVZlqmtfOwXD9OdERnpHFbBP9Uf8mmmcE/RUct
 qCVtcwiaSkQYGyTgEFtykmifyIwc4Y7wm7E77mB9YLdeScYxFFbEVZ1cgdRArbjdWo3O5ptVZ
 VIyY+vCHMoEbGfYAHxR6tw1ZTlMFVZ2IUUDDuRf/adsDU27T7HnZ5TUXTgENqcYxEbi+19QP+
 RAF/Q3r1BHhSQoB/m0dcsnrdH+CkV5Jh0vb2u40nsI881OtW4DeE01X/VRkQBMkvQ/MW3KRrL
 0PAmO/v75UiQok6kgMbBBAj0mgVkYYrWSmz8eLugpHhRi0ukfW5bw3zIinXLP2WaGmGN5zd4r
 O+rzQhl6Vs8LBaTg2Hkrq88EusRKWa7+LdcWbEpqP1sus8CDKToRZQNa7Ypgp+hGWLoTZdvit
 DRAzTl4++jK6O3wkKomzb/P2TUk/+b+86ZtYh0MhEyloDq8nCz9MXd0rn9Z9fHZ3QLXVV41Z6
 MyzkuCZy/FDilutiU9ykTRPTUvwHW7Qlg/fhas/ZFFlC3kgJx2ViSOW8VwzT/olwm6trxbNGo
 g8VJPTR73O6EAI8XSgy6DV6Fk63xGHulJnhLbztvoQhcJRCuKGYOKPyGtAVO3LVpF8bIa+mBa
 Oopdxzts7w2ztXYlh/MPsnHda/EbiXYLC15zfIFYsM3CRzk0XpfROt8lmRPIe9ihAORFFAgd5
 N71fjnBOzFr1zBDYzhJNowuio8Lt2EDGL8onyvpto5DwLhu5DQQxfZA2AyuI=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 04.10.19 um 14:39 schrieb Mika Westerberg:
> @Matthias, @Paul and @Nicholas, I appreciate if you could check that this
> does not cause any issues for your systems.

Just to be sure: is this intended to be applied against the 5.4-rc*
master branch?

