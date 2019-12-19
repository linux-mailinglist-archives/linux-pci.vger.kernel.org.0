Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA975126180
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 13:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSMDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 07:03:48 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:55627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMDs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 07:03:48 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MXH3Y-1iBNa345AU-00Yfyv; Thu, 19 Dec 2019 13:03:46 +0100
Received: by mail-qv1-f53.google.com with SMTP id m14so2113644qvl.3;
        Thu, 19 Dec 2019 04:03:45 -0800 (PST)
X-Gm-Message-State: APjAAAXMlQFMB2P/264RYR8qG8bHAqtVvXZiWmueKgL7wxk/lTdZe/Nk
        lOzae+eApQqXFmaZG3jgQSCd8S+cee5xbPRzixk=
X-Google-Smtp-Source: APXvYqyRYAthWWOFbK4JwdbfUGnK3IkCerPrE6//l+bsXhqevvRLK6TVQiG7yBNWDpk0m44tuJY3intXaCEenSLn4+0=
X-Received: by 2002:a0c:d788:: with SMTP id z8mr1183000qvi.211.1576757024622;
 Thu, 19 Dec 2019 04:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20191209092147.22901-1-kishon@ti.com> <20191209092147.22901-6-kishon@ti.com>
 <20191216144932.GY24359@e119886-lin.cambridge.arm.com> <d1ee4579-a3da-6a73-3516-a6d264f80995@ti.com>
In-Reply-To: <d1ee4579-a3da-6a73-3516-a6d264f80995@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 13:03:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a06XLSa-FHNGsN=b10JrddjbOKAvfU=iXdMa+0L43m5fA@mail.gmail.com>
Message-ID: <CAK8P3a06XLSa-FHNGsN=b10JrddjbOKAvfU=iXdMa+0L43m5fA@mail.gmail.com>
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:r6T3/CcYpNS86A2Hvx7bMZm1KM8FiNbjscHFDmZ+OK596/2FHQw
 14vK4BjTgsPQWg4SSBHNWwqS6TU86YPVztPL/xXH5371kxHFXCsOvIde4HG5UNt1u8wGx55
 AWkOYni8+6x1/5B6p+HXnwF3lJ9Q0z5E62HCsdQbWJgy7ex2BMVj4+VbB231e4izNmOxWfJ
 0wGPd+fGDcyCzLxj0dAUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XyO0F0+TXjA=:r/8VdwCanuBYUQ4DTNJuie
 QffNdRqHrA0PKHo66OByfUYaRxiUtIsPRrHvHxTt1zL5lT8EoXHNMPX2q+M8d9+lHMpd1aebu
 Gp/ebIp1FCuP/ZiTLo5vkO8coqiWo6Q9O6dVZhwx0agYKLAjnVdKgaJLpPV2l5YB1jJIi4ihQ
 t2QuYf8cAMoLsLQYJbniTt6Z19W5dGHv3BY3WR76XSOOtdvLKqPn0QLUVSj0zg/UMasDZHG7H
 kW1NCbJmxsUpak2z2DSRSJEGIlXHpCDvxbNTUjdFmjdMYClFdGSWo0kYQM903zK72v4JM5+nI
 0lXxrbubQPRvxq2PQKoOWKD9nQGp4l6CG2QKsh2LQl3Qt3ymNIbPsLNPznGX3b/GNhUWt6tV6
 ijGGsDUWuVKFxgoKuAdjizL2ncUp4pyW1OJwsrLkRB3aeZ6K5ILBlBpOVtMf3yOau4ZeNdUQN
 2ah/h3Zd02t85RB5YOuNQQRZPpMhPJaHWuRVdJWeqekgFmRqHH3DocCIlsP2cB0mnaf0nge0U
 Yt/PKaBs73aspwFTixChOQYD/y+RrY2IBtUJxWm3O6EAV0Tmu3lSsNUc0k1PKvp3+073euJAc
 Gna6Ai5KQoQpszqJIQKDSujU+4sIsk7SJkwAJ9eX4tKVwyXABq9NNxKiK/LMs4zbYewnrA/C7
 x06Jrh2YnaZ4urjdevC9gRfdxkhj5HNKgatjJIG49k9kG9VGsfRaz2Vbgv92VEy5mA08P1RJB
 5YCK/X8cl+tTLVq8kAtzWiXT+OhcTwjeer2YmBM7fapkJhpyvTr0xr0h3yPZHxDEqHXlyXB2R
 TZ6ZmjQOy1aA+uJZkPRzqjjwTdVro8AvcUjbNjRlTZSnOpR78z8Pl/mpb5gQkGLlW+VxQ6JCZ
 QbqpeebYENhYnrghRqrQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 19, 2019 at 12:54 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Andrew,
>
> On 16/12/19 8:19 pm, Andrew Murray wrote:
> > On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
> >> Certain platforms like TI's J721E allow only 32-bit register accesses.
> >
> > When I first read this I thought you meant only 32-bit accesses are allowed
> > and not other sizes (such as 64-bit). However the limitation you address
> > here is that the J721E allows only 32-bit *aligned* register accesses.
>
> It's both, it allows only 32-bit aligned accesses and the size should be
> only 32 bits. That's why I always use "readl" in the APIs below.

In that case, can't you use the pci_generic_config_read32/write32
functions with a cadence specific .map_bus() function?

       Arnd
