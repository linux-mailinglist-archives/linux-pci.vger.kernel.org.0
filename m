Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4640123280F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 01:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgG2X0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 19:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2X0h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 19:26:37 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE87C061794
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 16:26:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so24045179qka.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 16:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dclWewewLkTP04bmYZyewwOCC5F2QPW1bIlRnVcKlKg=;
        b=aI44Vh/F7d2okdDRVOSDabHppJpRqIelvQMZqN/B2Z7HF3ZFuKLxEnoE3hiKByN5rR
         bX3e8aveNwaxjMoDjVmNSiNDwSDWi0XvERlKAb7ORaYVVeGDFoeT/nKMsA7YWSH77Dh9
         aT36NHqpyWyOdWskQItmpczVSvqdIvg1rDVYhYpJElb50Z0g4JRvxiEbMUI4hiv2MMGw
         AMcGX76UtikEzy6JyMzeu2m/iLYMWBdBrh/e3NVrQAVf+AUA7/TY54EI86WbRGVuAb2n
         aZ75vE8OZ4CxxR+AYFdTAhLf1hcPaLXlb3CY497RGkw2NEUQTqGWwF4Nr5xf4+YYgWvc
         lbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dclWewewLkTP04bmYZyewwOCC5F2QPW1bIlRnVcKlKg=;
        b=nfQpxnOQoVnw+rzgnQr7Xz+LmdcHWnLu25xy/WEHagARhPTgQIbE13nYfmph5LTFmQ
         UsZZkkdVufRcXbIlrPubkIDrakU0y2CXlUkxePE/Y//RPYYuXms1G1WCkShX/pwQu2SN
         qnlT5HoaouJDPNd1js37P/FoP0xQ6TxpL3ry2tJC/jOWHjbVKJyHWSmzQXNmJ2yRKcVL
         wjA/8jbKR/VK68PLLlBwbuc03ZorCtX8gZsSHO5IGm31VkDBhMQb1YPU1jk5FgXOhhbs
         cOiSfRt+a2n0eq1Nh+G1z3z/NPXQ4MkgmnxJoZqD11DrYdKaQ5Gpy2RHB6uXDopG89Xd
         0cNw==
X-Gm-Message-State: AOAM533R3hyJXQ/Y2e6PANGrIWfbSDTbU0Fo6U57dwioOEe1GYwizhau
        7viIH29ekcxG+ZmaC0yATk00+neoVwVzRWmuNHqnjir6mnc=
X-Google-Smtp-Source: ABdhPJwlUVyV6cxoe0W2q9f8rAWp5zqflReAWKWgeJAA507CKPdHv2AUvjAoQOrCE50A+fFbybHzadZF5ta7QYIrqow=
X-Received: by 2002:a37:8fc6:: with SMTP id r189mr34224500qkd.159.1596065195902;
 Wed, 29 Jul 2020 16:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZvJQge6ETwF1GkdvK1Mpwazh_cYJcmeZVAohmt0FjbMZg@mail.gmail.com>
 <20200729224710.GA1971834@bjorn-Precision-5520> <CAA85sZt7xHJc85Ok8j2QDmB-E_r-ch5kBKqYeUe1KnA6Gt-iDw@mail.gmail.com>
 <CAA85sZvL4_mR=w2MU7JUx5eksnCt1yBZD=jbhAMoMVz38OJ5aA@mail.gmail.com>
In-Reply-To: <CAA85sZvL4_mR=w2MU7JUx5eksnCt1yBZD=jbhAMoMVz38OJ5aA@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 30 Jul 2020 01:26:25 +0200
Message-ID: <CAA85sZuQchm20C4v9V+TnOx+GZ4DJ13jX4g7fPdDB0QJN2Ot=A@mail.gmail.com>
Subject: Re: [RFC] ASPM L1 link latencies
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 30, 2020 at 1:12 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Thu, Jul 30, 2020 at 1:02 AM Ian Kumlien <ian.kumlien@gmail.com> wrote=
:
> > On Thu, Jul 30, 2020 at 12:47 AM Bjorn Helgaas <helgaas@kernel.org> wro=
te:
> > > On Sat, Jul 25, 2020 at 09:47:05PM +0200, Ian Kumlien wrote:
> > > > Hi,
> > > >
> > > > A while ago I realised that I was having all kinds off issues with =
my
> > > > connection, ~933 mbit had become ~40 mbit
> > > >
> > > > This only applied on links to the internet (via a linux fw running
> > > > NAT) however while debugging with the help of Alexander Duyck
> > > > we realised that ASPM could be the culprit (at least disabling ASPM=
 on
> > > > the nic it self made things work just fine)...
> > > >
> > > > So while trying to understand PCIe and such things, I found this:
> > > >
> > > > The calculations of the max delay looked at "that node" + start lat=
ency * "hops"
> > > >
> > > > But one hop might have a larger latency and break the acceptable de=
lay...
> > > >
> > > > So after a lot playing around with the code, i ended up with this, =
and
> > > > it seems to fix my problem and does
> > > > set two pcie bridges to ASPM Disabled that didn't happen before.
> > > >
> > > > I do however have questions.... Shouldn't the change be applied to
> > > > the endpoint?  Or should it be applied recursively along the path t=
o
> > > > the endpoint?
> > >
> > > I don't understand this very well, but I think we do need to consider
> > > the latencies along the entire path.  PCIe r5.0, sec 5.4.1.3, contain=
s
> > > this:
> > >
> > >   Power management software, using the latency information reported b=
y
> > >   all components in the Hierarchy, can enable the appropriate level o=
f
> > >   ASPM by comparing exit latency for each given path from Root to
> > >   Endpoint against the acceptable latency that each corresponding
> > >   Endpoint can withstand.
> >
> > One of the questions is this:
> > They say from root to endpoint while we walk from endpoint to root
> >
> > So, is that more optimal in some way? or should latencies always be
> > considered from root to endpoint?
> > In that case, should the link ASPM be disabled somewhere else?
> > (I tried to disable them on the "endpoint" and it didn't help for some =
reason)
> >
> > > Also this:
> >
> > [--8<--]
> >
> > >   - For each component with one or more Endpoint Functions, PCI
> > >     Express system software examines the Endpoint L0s/L1 Acceptable
> > >     Latency, as reported by each Endpoint Function in its Link
> > >     Capabilities register, and enables or disables L0s/L1 entry (via
> > >     the ASPM Control field in the Link Control register) accordingly
> > >     in some or all of the intervening device Ports on that hierarchy.
> >
> > > > Also, the L0S checks are only done on the local links, is this
> > > > correct?
> > >
> > > ASPM configuration is done on both ends of a link.  I'm not sure it
> > > makes sense to enable any state (L0s, L1, L1.1, L1.2) unless both end=
s
> > > of the link support it.  In particular, sec 5.4.1.3 says:
> > >
> > >   Software must not enable L0s in either direction on a given Link
> > >   unless components on both sides of the Link each support L0s;
> > >   otherwise, the result is undefined.
> > >
> > > But I think we do need to consider the entire path when enabling L0s;
> > > from sec 7.5.3.3:
> > >
> > >   Endpoint L0s Acceptable Latency - This field indicates the
> > >   acceptable total latency that an Endpoint can withstand due to the
> > >   transition from L0s state to the L0 state. It is essentially an
> > >   indirect measure of the Endpoint=E2=80=99s internal buffering.  Pow=
er
> > >   management software uses the reported L0s Acceptable Latency number
> > >   to compare against the L0s exit latencies reported by all component=
s
> > >   comprising the data path from this Endpoint to the Root Complex Roo=
t
> > >   Port to determine whether ASPM L0s entry can be used with no loss o=
f
> > >   performance.
> > >
> > > Does any of that help answer your question?
> >
> > Yes! It's exactly what I wanted to know, :)
> >
> > So now the question is should I group the fixes into one patch or
> > separate them for easier bisecting?
>
> Actually this raises a few questions...
>
> It does sound like this is sum(link->latency_up.l0s) +
> sum(link->latency_dw.l0s) of the link vs acceptable->l0s
>
> But, would that mean that we walk the link backwards? so it's both sides?
>
> Currently they are separated - and they are not diaabled as a whole...
>
> How should we handle the difference between up and down to keep the
> finer grained control we have?

so, this:
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bd53fba7f382..18b659e6d3e8 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
+               l0s_max_latency =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -448,14 +449,18 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)

        while (link) {
                /* Check upstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-                   (link->latency_up.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+               if (link->aspm_capable & ASPM_STATE_L0S_UP) {
+                       l0s_max_latency +=3D link->latency_up.l0s;
+                       if (l0s_max_latency > acceptable->l0s)
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+               }

                /* Check downstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-                   (link->latency_dw.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               if (link->aspm_capable & ASPM_STATE_L0S_DW) {
+                       l0s_max_latency +=3D link->latency_dw.l0s;
+                       if (l0s_max_latency > acceptable->l0s)
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               }
                /*
                 * Check L1 latency.
                 * Every switch on the path to root complex need 1

--- vs ----

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bd53fba7f382..74dee09e788b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
+               l0s_max_latency =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -448,14 +449,17 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)

        while (link) {
                /* Check upstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-                   (link->latency_up.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+               if (link->aspm_capable & ASPM_STATE_L0S_UP)
+                       l0s_max_latency +=3D link->latency_up.l0s;

                /* Check downstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-                   (link->latency_dw.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               if (link->aspm_capable & ASPM_STATE_L0S_DW)
+                       l0s_max_latency +=3D link->latency_dw.l0s;
+
+               /* If the latency exceeds, disable both */
+               if (l0s_max_latency > acceptable->l0s)
+                       link->aspm_capable &=3D ~ASPM_STATE_L0S;
+
                /*
                 * Check L1 latency.
                 * Every switch on the path to root complex need 1

----

Currently we don't make a difference between them and I don't quite
understand the upstream and downstream terminology since it's a serial
bus ;)
