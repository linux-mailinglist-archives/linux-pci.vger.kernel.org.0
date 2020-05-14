Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BBD1D3FD4
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgENVQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 17:16:56 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgENVQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 17:16:56 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N7iKq-1j4yXs04Bu-014jxm for <linux-pci@vger.kernel.org>; Thu, 14 May 2020
 23:16:54 +0200
Received: by mail-qk1-f173.google.com with SMTP id g185so406342qke.7
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2020 14:16:53 -0700 (PDT)
X-Gm-Message-State: AOAM530+k9JkBrvy6jEiyNjIY9h8Zq8Z/17lln4S8toU0r3ZCp9+njJY
        WytLIvBB6RTSLBRxCGjw9fNjQPJFeOBhx6h8fpY=
X-Google-Smtp-Source: ABdhPJwQTPRp+vvySGrK/RcixgqOtWiy7Vk2RQ4+31p/UPXW1FkcIiPzCzHdWZ/9UDOachkIriF8VULNbyI+IY/3KK4=
X-Received: by 2002:a37:bc7:: with SMTP id 190mr364223qkl.286.1589491012867;
 Thu, 14 May 2020 14:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200513223859.11295-1-robh@kernel.org>
In-Reply-To: <20200513223859.11295-1-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 May 2020 23:16:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3pS4GHgGBTcMv6+SGOkJ7kPwoeyd-5PC72NzBOjin2eA@mail.gmail.com>
Message-ID: <CAK8P3a3pS4GHgGBTcMv6+SGOkJ7kPwoeyd-5PC72NzBOjin2eA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Fix pci_register_host_bridge() device_register()
 error handling
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DjRU9VpqYNKIA0EfGjyHLAzM7v9lV+eQZ45bWnrtCrWxXqebg2N
 02yEPfSTP7LkE0+Q/WS+ynUmhGIHgwVA+8q2S0aqB1awi21QPyXkVPAParjHJSG1Nm6Lhx6
 gp3BesZFpu8EWbi1XmPTroHsepo94dDvPQ0Fy2KpzgKFytk5vsz/+2BUtxNdle61vqwBbs+
 A1FSyGwxb8hvpa28bmB7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e4SaKcr3+DE=:f+8ta8BIqQTpxfCMLv6s0m
 ofVp/RzxTHcTFkLFLHOnBcSUwGePVRenooXdtOynh95xfbDRN1OAcDgRY+fcPqrljN/b2NEfn
 368JZsdFcqEuQKDTz3ng2yKnl9K6PxRHkX57lXTnYsOdCQWl0a+suUD4hwjYBaMtFeZuWWU+q
 vnTr6Tp4M5GU/w10HjvQAA0BxSVUhqeDDjqLp7pvES2TlNb2AwL3ZjRjXluGrHQJ2Jl62jye+
 1/3/tDvuRWQpygAtzz7uPDAncWyDG4W4AeDhpssRSubxKtqlMEcZ5jjd5NGNFKU6v8XvNvPnZ
 uSnu0/Jrn5Nm4WPNRqHcOQ6cNjvlQcGyvG3PRn2l4JszPDp0fsCKEvUyMFq5UXd7tqTScp6l/
 1cmSIf8wKVQCJsAx58apb0tNaO4BoB3C54MdWxc0S87DCY452nBN1Gd/EJRqMPP3EO/Uh/ETI
 YirLQD/tjE7l4dclfciONd7dI4Hm/TZN6F7MH+3J3c+9JKCx9bjPGSA9JU2wELgQ+0iFk/lio
 HzMoA1+FtO+mvByfrgFYDcx3zD5bjhHX5f9aEkSlu5hjW16vrcsI3egU9/JHSt7IHpo36IFAi
 YC8EYgyYew29le6H/9A7I1LQ52WCgqHNQCw45Fjib0gx/xrHpYRP90Vmy8XnvHeC/8QSZE3wM
 ePHoCnSpiqUwteOFLq9rcIna/MLlTaA9MMDOhJEWy+3Re50HMUSENpp9e/lrAkd/IPtHh5el5
 mUP0kfbBDVEwnIV+oopmgOv3Z7BhGzjr34JufeKVIfgkZlHjgQSl8ufA1iR6AohiiS3KWO23b
 we32rYr4n43Q1N7j4pbFoXoG6vcw/mRd1lTfT0p/PQ43vZqVdo=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 12:39 AM Rob Herring <robh@kernel.org> wrote:
>
> If device_register() has an error, we should bail out of
> pci_register_host_bridge() rather than continuing on.
>
> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
