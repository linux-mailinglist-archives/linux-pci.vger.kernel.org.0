Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4739F325
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFHKHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 06:07:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhFHKHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 06:07:14 -0400
Received: from [192.168.1.155] ([77.7.0.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGhi0-1lcrUf1vYQ-00DrOa; Tue, 08 Jun 2021 12:05:07 +0200
Subject: Re: [PATCH v7 0/8] Expose and manage PCI device reset
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <abcbaf1b-6b5f-bddc-eba1-e1e8e3ecf40e@metux.net>
Date:   Tue, 8 Jun 2021 12:05:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608054857.18963-1-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RGaOtZoJIxkoDyTURXqBMhsPOVpaQp6wbfZz3Q4JDHlJQ7lr7qr
 2qXRe7Gb2Tq7dP0TWzswxs+ZWpp+kncTUhK4S068Tm67+w3HejHdTMIfSF2RZxrX2mCjG4/
 nabyAXczLtKuM6SHqt2XFCf3oxnlpIHCUBze78jueZ5EF7JsoibG3qKgOQ/5dakcbFJIhc2
 jkRCa2pB0KKyLLvhDqCXA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oRflVmLBle8=:kcMMOWT0PKcbm1aw0D/mNW
 +Gc+qYffe7XOw0UFh6dE2sKOZ/B+fAOok4O/HZwB+gSSN49P5huCcC4z2JczhAg3+veMD7lss
 nafitkcG6vXQE30Sz6vkKbjVAtlY+QS4FZP9Kgp+MuJfuX7gWR8ZK+yqu2WN1cezWC+uszk8M
 flI40De/BSsFrwgAXAiEEz7kunlrBjdLw0raW4cAbLrN/9ySnh/Zn2kCvqBoQEAfKLlSZ1tVD
 bmV3Uqg0ROmC2zl+tYOizw6FCptwHmga3J+jLBtOZwPseHW3Lyt3PHxFohGFedL6mUhQ8krOC
 g14GyDjZt1Qlj7GlroJ0NT5znX+utloTdE/svjtdGxWyBEYpJ0Occrzal/8XgWCaEzX8OebbT
 431ZPlg5BBmeyff/QFGddLj+55H7RNglWHR5IjXSYg7LcNtJ3Zz9bfPZ6iRMN4eXsyNjeXxWL
 dDsgo6FJdBWLeZtBEutlVOwoGDsKkudgMOKHAcBZnAFOABUrmsmpuwfL0T2kpFq0liTb8sgSc
 ffupm2Q8zBIQOoh7AiU7B0=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08.06.21 07:48, Amey Narkhede wrote:

Hi,

> PCI and PCIe devices may support a number of possible reset mechanisms
> for example Function Level Reset (FLR) provided via Advanced Feature or
> PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> Currently the PCI subsystem creates a policy prioritizing these reset methods
> which provides neither visibility nor control to userspace.

Since I've got a current use case for that - could you perhaps tell more
about the whole pci device reset mechanisms ?

In my case I've got a board that wires reset lines to the soc's gpios.
Not sure how exactly to qualify this, but I guess it would count as a
bus wide reset.

Now the big question for me is how to implement that in a board specific
platform driver (which already does setup of gpios and other attached
devices), so we can reset the card in slot X in a generic way.

Any help highly appreciated.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
