Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD73126E90
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 21:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfLSUQs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 15:16:48 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40957 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSUQs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 15:16:48 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MdeSt-1i8QQO3hSb-00ZiSy; Thu, 19 Dec 2019 21:16:46 +0100
Received: by mail-qk1-f181.google.com with SMTP id w127so5692441qkb.11;
        Thu, 19 Dec 2019 12:16:45 -0800 (PST)
X-Gm-Message-State: APjAAAVCBWOJvWlZtkw28DNSJs06TRbVIHoF6jld9B1uW+oaib0WpWba
        A4IlWJLPMB2SRLa7A/gjzeKYiteZRLGHxKvgUQo=
X-Google-Smtp-Source: APXvYqxXxzC0hmoU51YHNIOMNlYs2rxhRdB48aYkaWwyXmxmNUKJ8I9t0XWDc0Xh+upH6sOTUc/n5M9fOKJDVFAtE4c=
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr10148528qke.394.1576786604484;
 Thu, 19 Dec 2019 12:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20191209092147.22901-1-kishon@ti.com> <20191209092147.22901-6-kishon@ti.com>
 <20191216144932.GY24359@e119886-lin.cambridge.arm.com> <d1ee4579-a3da-6a73-3516-a6d264f80995@ti.com>
 <CAK8P3a06XLSa-FHNGsN=b10JrddjbOKAvfU=iXdMa+0L43m5fA@mail.gmail.com> <9b40e71a-c18c-a958-84fe-c5a126fe8272@ti.com>
In-Reply-To: <9b40e71a-c18c-a958-84fe-c5a126fe8272@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 21:16:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1pGiUco9DcBSOWbck4_qLTUcO5awPe1+sM9Jun17xsOw@mail.gmail.com>
Message-ID: <CAK8P3a1pGiUco9DcBSOWbck4_qLTUcO5awPe1+sM9Jun17xsOw@mail.gmail.com>
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
X-Provags-ID: V03:K1:GIAkECSiaFGSI5aitAY0nGTi3sD4Yf2xuK1wqRbdEktsae1yNSY
 rmxrTd/569KOel7SISKKcDVSvy0oyYExf5hfCKr5EL5R+7VQwX3hlqUMylke9vl0T5h3Hh4
 /jtPr3nAlRrklfTDAy1coJ9HSjQdduqbxZk3O4V6tXX39+rDyo8UKWalhybe3hd7h/EUP0g
 wxTxGuQMP/3RwJSxQjUHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ceLdhuaFHOQ=:kxE9+xvSYkvzX26JRUrEcr
 /j6iqFzhfGP+V7QuPHILK2D6GTNsOU7ELEPhT7SX082sWmcKzt83MN+Y9OmHR4JL0+J496P2o
 KVXx3+SumCL2jfvx2eMOE7cOlPoTlTtaXE6v9PPNtpBgNG1K4vrATvbSR4pWOFsQHhUo0vkTK
 bfcIeOYGYISV43EUfy/ijuZ51M8a44oCYhUHX0d9DgWlJqSyDasIdYANHy4vR5FhC2f2aeUmX
 LW0KkwqXzNB8mziAbL9p01pYoDcyH9WtuMdH5rBcQ0uECmiC5/Mdj3YN7uBCwbdUoY1amXQq7
 R+r++vSSyLILp5GKVdXVaE3I2zr4qwyuLLoOECnOkLUfJkI4lGyjLn7Bh2IZhVSXZ8+o6dlUi
 DU46/fa02a58Qm/UGZcYuomd63/DNd4JIvAy0xFfGnhvpzu4Sr3NmHxWd5iNbOhMnWEUl1p0b
 8Za7sf0NM31ges/PJvFBCk8qA+kebQ/dAm5dSpSbLq+vqpHZzGKj+WffpJd+YKbIQ4cqqPVi4
 2utrnKQs+Cz3iAwmzofjOqq2nAxYvFL4xU0D9jQ/VotcB2PYie83YUr/RRhcNnoo2Q+oeeSvl
 Jw2aMYXNn6PXXaPfk+RN8yCTqZkLJoqH+tdUjmR1T+syjCM/Pqaw9Qzi7Sm6/ZiP2IiZffL1/
 rRwDaWY7tu1h9FYWfKhN8VN/rGMla95KTCXIdcLlq118H+3kNQDz5CsLAvEt04uTO/hlapkw8
 j+Xin9eS6aW3eE0xLdpKVIaz7/36tmEyyzwNC63+PYB1K1XV1fEaZhghg0rfNotaX3OVEh/8S
 fIN91vcIuSFQ8YzWzE8DSNRKvMcAxlXlcpvMPXQW09r9Kh8AOLaMfQaoLsQ2+ExTqb7aOwzuJ
 Y2Q5jCCxhBwEGRAsPYIg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 19, 2019 at 2:17 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On 19/12/19 5:33 pm, Arnd Bergmann wrote:
> > On Thu, Dec 19, 2019 at 12:54 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Hi Andrew,
> >>
> >> On 16/12/19 8:19 pm, Andrew Murray wrote:
> >>> On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
> >>>> Certain platforms like TI's J721E allow only 32-bit register accesses.
> >>>
> >>> When I first read this I thought you meant only 32-bit accesses are allowed
> >>> and not other sizes (such as 64-bit). However the limitation you address
> >>> here is that the J721E allows only 32-bit *aligned* register accesses.
> >>
> >> It's both, it allows only 32-bit aligned accesses and the size should be
> >> only 32 bits. That's why I always use "readl" in the APIs below.
> >
> > In that case, can't you use the pci_generic_config_read32/write32
> > functions with a cadence specific .map_bus() function?
>
> pci_generic_config_read32() is for reading configuration space registers
> only. The accessors I added here are for the controller IP configuration.
>
> For the configuration space access I use
> pci_generic_config_read32/write32()([PATCH 11/13] PCI: j721e: Add TI
> J721E PCIe driver).

Got it, thanks for the clarification.

       Arnd
