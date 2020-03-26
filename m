Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFC193EF9
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgCZMht (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 08:37:49 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgCZMht (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 08:37:49 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MkYoK-1jew1V3tGA-00m4bg; Thu, 26 Mar 2020 13:37:48 +0100
Received: by mail-qk1-f171.google.com with SMTP id h14so6119127qke.5;
        Thu, 26 Mar 2020 05:37:47 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1wVQBRyIT6VSGkaUf+e8UsHW4KXYjsvdskVE8Gf6weFgvwGP1B
        NA83Z6HTtbM2KcK38Rvk74NaCWKxcfsnsE8lW5Y=
X-Google-Smtp-Source: ADFU+vvb7BIXY+D9glCcU91L9kO0tyFWP+EOFEhwVrFka5N8pk0bXgtM967EIkNgE0o5eeGQr3N7S8aDV2fUMF6iRbU=
X-Received: by 2002:a37:6455:: with SMTP id y82mr7866531qkb.286.1585226266623;
 Thu, 26 Mar 2020 05:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com> <1585205326-25326-2-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1585205326-25326-2-git-send-email-srinath.mannam@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 26 Mar 2020 13:37:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1qJv-Euvh06fqFxn4Cx-wkh4gCMOf29DAmQzWKZJji-A@mail.gmail.com>
Message-ID: <CAK8P3a1qJv-Euvh06fqFxn4Cx-wkh4gCMOf29DAmQzWKZJji-A@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: pci: Update iProc PCI binding for
 INTx support
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ot7xNvf642aE99y3X1D3Om+BI+axlz7Ao6JnAZUCUUpSgXuGiu0
 Eg/HMAr5dH3lXK+/GAe1sTRPlBFdoT5OPRPk+bJ9LzYRAMU0rRu5kRKv3SxyhnbBZANdnSO
 cQAF/rz8fn/SL9YjegTlznbHqLT7jEBSwRC6sLGwl57e4PTwCVCAOX5Hdn9GMdd1UDMuRoO
 PMum8CtdQkgvwRGmwAR/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2vmJUh2FWqI=:9dGAP2tgpAktcqDyIkVulo
 uVzX6Zt7+X3fi5UjijyMeapN3PjnBDos3V11g5CXLnnb64KGweykYT2LZC2OW/h0XlmGGn5fy
 PrTfvspkHknApt0EdA61C4K8K+g0TaBtrn+pK6Pd0dJ+AWHnIOlP7Gh8MHwl3aVjNlxJ2J74n
 h63PnAtXaPJbF1LPFBidMki8p9eKi4+noIZeCBCoHkhMXZ9yQjoOgj7EzSdxjgGa8FMDogWZC
 7BWATFy6NVN+MbU8icySGFHzR29aIb0BQsQ5gbHRVkZy+tnoWeW5Ag8+Fr52WKTe64F/m6G6S
 JU2WR7pnYZzWc4UJaPFn7ZFGKjLYkJOb7aQO+ajpLLiSCSjPK+MDw81bcPq+dpdbKa6MXl7HO
 SHky5Fz7SW64mtiKkbLT86uZl3yxEFOCCZr7zh96YTjF6LYQ3rwB/wu2tDBVJkA0I9IX2Ni2u
 XaW2hX2YWXJYg5nPWoon1pm+hkY4LOUX95WEiBwlNgIZa10boeH2jtGe8mY/L5Q5kcssSZTan
 0SxS5H9xndRIVWeEKJBFvBV2clNXeoZrr9e9OpWkBiDZtNQIWhPwSJ6wLxErYYtC080dRoIue
 zh7DwEQsg9fnZeoYD3RVnIIYJWVwvNCNNkqCIygGN4f2kbDfQsHqmu1nvp/tv2/tWpUdCc23H
 qoxNG8dr62N2A89rGWL5jrgVHD6u9bShx6E9LW5BfFecBBRAFbx64K8r8QzGhoI88i8kFbVeK
 7qYT2jtTdnn6WFcV1OKaOKjgvecGfsQwUH1GwJlX/E/CdbixjHqfkZhGgV+ZJNfJpu2PitjlO
 gvQ0I+7TtYL4u7QRUsyIlJdAShYcmi+RsM0GemV7+0Xz08sEPE=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 26, 2020 at 7:49 AM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> From: Ray Jui <ray.jui@broadcom.com>
>
> Update the iProc PCIe binding document for better modeling of the legacy
> interrupt (INTx) support.

Could you describe in the changelog what happens when you get an old dtb
with a new kernel or vice versa? If any combination won't work, please make
that very clear, and give a reason why you consider this not to be a problem.

      Arnd
