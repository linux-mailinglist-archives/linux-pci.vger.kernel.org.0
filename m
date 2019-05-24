Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357DC29E73
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfEXSu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 14:50:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33100 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfEXSuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 14:50:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so9585738ljw.0
        for <linux-pci@vger.kernel.org>; Fri, 24 May 2019 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOpX777PdKYx2FzNZIOtxcAjmxm00VhvM8DiVIi+gic=;
        b=Kbigf6+x+ocH2AyNwOQs10+zTlWsKMDO9/R3dOcVtJEsfBiTdREjTIWj0JV6CHVW+P
         0bdYxs0w5RFKDgoUO42v7CMvChE8nv/xYh1q2Pwve6NgLoq5FqSTUgD1HUm1NblF3zzo
         BjoFzOiEbYKqPd3c1BR5RbEaQi/NryGeokfcK84JXj1XAGhH9MoyYskyhgnH8RaQ5CLj
         WR79xxBWypA2Q46vSqio9b+1968KuT6l05TTPXDmyXuLIWiHRatJxbPHbSsn6J0rCafx
         di0JDLlRn6HJQZ0l2MVpuMDllwCLWJhHUj1Dq8BE8n0Ik7OugIwaEmocHbbgpECtINYi
         FFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOpX777PdKYx2FzNZIOtxcAjmxm00VhvM8DiVIi+gic=;
        b=pfk8rt7jmUgdRiRF+QN4bj5N8xHwGbufk2EgkpLC635HPz4+OZ49CpBXfKAQCQ6owd
         V2+yNHWrZNFVJh3Imb6XBB50m9FTVU/xrFcpbz0aVB7k7xTeQbTvi94GrpaSGkPLuEeL
         z9iN0ky54XUGfrZq72ggmTh2bLr8H3mWDeojIprpUpeqQl6y4rJzq5lreZoC41v30kT7
         p83fQgUKGBwSvUQEJNdkLUfxgTpZuDp7PzMqeJFWyKpfoLEUHckuKUo7yfIDaubNZQ30
         vo/FjZcQ1JD9iqEl9h5XqcClisAL1pEHaapHAYLUx+c25yPrbkKiopdiWx+r/4s7RmVu
         AS0w==
X-Gm-Message-State: APjAAAX0HK0m3nZHwY/mg/USxawRmSarPwFrS/dLQOf6n1nGDp2C2n52
        ClQLUiZLDkzYuj0xdBpSkvNTcOj5RWsBQG+XrQKrXg==
X-Google-Smtp-Source: APXvYqz/OD3h7LRiuXDBvHSt/uffjWkPCJB8DeQ107a3CO6oNwjqh3hQPyFQHG0JlC8k7s8e1Xhc+GQxDqy1yZ0LoCQ=
X-Received: by 2002:a2e:8587:: with SMTP id b7mr42887354lji.101.1558723852754;
 Fri, 24 May 2019 11:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <1558648540-14239-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGzHkt4p_byEihOAs9g97t450h9-Z0Qu2b2-O1pxCNPX+A@mail.gmail.com> <baa68439-f703-a453-34a2-24387bb9112d@ti.com>
In-Reply-To: <baa68439-f703-a453-34a2-24387bb9112d@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Fri, 24 May 2019 11:50:41 -0700
Message-ID: <CABEDWGyJpfX=DzBgXAGwu29rEwmY3s_P9QPC0eJOJ3KBysRWtA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: endpoint: Skip odd BAR when skipping 64bit BAR
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        gustavo.pimentel@synopsys.com, wen.yang99@zte.com.cn, kjlu@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

Yes. This change is still applicable even when the platform specifies
that it only supports 64-bit BARs by setting the bar_fixed_64bit
member of epc_features.

The issue being fixed is this: If the 'continue' statement is executed
within the loop, the loop index 'bar' needs to advanced by two, not
one, when the BAR is 64-bit. Otherwise the next loop iteration will be
on an odd BAR which doesn't exist.

The PCI_BASE_ADDRESS_MEM_TYPE_64 flag in epf_bar->flag reflects the
value set by the platform in the bar_fixed_64bit member of
epc_features.

This patch moves the checking of  PCI_BASE_ADDRESS_MEM_TYPE_64 in
epf_bar->flags to before the 'continue' statement to advance the 'bar'
loop index accordingly. The comment you see about 'pci_epc_set_bar()'
preceding the moved code is the original comment and was also moved
along with the code.

Regards,
Alan Mikhak

On Fri, May 24, 2019 at 1:51 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 24/05/19 5:25 AM, Alan Mikhak wrote:
> > +Bjorn Helgaas, +Gustavo Pimentel, +Wen Yang, +Kangjie Lu
> >
> > On Thu, May 23, 2019 at 2:55 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
> >>
> >> Always skip odd bar when skipping 64bit BARs in pci_epf_test_set_bar()
> >> and pci_epf_test_alloc_space().
> >>
> >> Otherwise, pci_epf_test_set_bar() will call pci_epc_set_bar() on odd loop
> >> index when skipping reserved 64bit BAR. Moreover, pci_epf_test_alloc_space()
> >> will call pci_epf_alloc_space() on bind for odd loop index when BAR is 64bit
> >> but leaks on subsequent unbind by not calling pci_epf_free_space().
> >>
> >> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> >> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
> >> ---
> >>  drivers/pci/endpoint/functions/pci-epf-test.c | 25 ++++++++++++-------------
> >>  1 file changed, 12 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> >> index 27806987e93b..96156a537922 100644
> >> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> >> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> >> @@ -389,7 +389,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> >>
> >>  static int pci_epf_test_set_bar(struct pci_epf *epf)
> >>  {
> >> -       int bar;
> >> +       int bar, add;
> >>         int ret;
> >>         struct pci_epf_bar *epf_bar;
> >>         struct pci_epc *epc = epf->epc;
> >> @@ -400,8 +400,14 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
> >>
> >>         epc_features = epf_test->epc_features;
> >>
> >> -       for (bar = BAR_0; bar <= BAR_5; bar++) {
> >> +       for (bar = BAR_0; bar <= BAR_5; bar += add) {
> >>                 epf_bar = &epf->bar[bar];
> >> +               /*
> >> +                * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> >> +                * if the specific implementation required a 64-bit BAR,
> >> +                * even if we only requested a 32-bit BAR.
> >> +                */
>
> set_bar shouldn't set PCI_BASE_ADDRESS_MEM_TYPE_64. If a platform supports only
> 64-bit BAR, that should be specified in epc_features bar_fixed_64bit member.
>
> Thanks
> Kishon
