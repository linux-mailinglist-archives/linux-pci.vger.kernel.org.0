Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A9156B0D
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2020 16:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBIPhs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Feb 2020 10:37:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42502 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgBIPhs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Feb 2020 10:37:48 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j0oeO-00053e-Kc; Sun, 09 Feb 2020 16:37:36 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AAB4D100F5A; Sun,  9 Feb 2020 16:37:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     sean.v.kelley@linux.intel.com, Kar Hin Ong <kar.hin.ong@ni.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Julia Cartwright <julia.cartwright@ni.com>,
        Keng Soon Cheah <keng.soon.cheah@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: RE: Re: "oneshot" interrupt causes another interrupt to be fired erroneously in Haswell system
In-Reply-To: <87muaetj4p.fsf@nanos.tec.linutronix.de>
References: <20191031230532.GA170712@google.com> <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de> <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com> <87a76oxqv1.fsf@nanos.tec.linutronix.de> <MN2PR04MB62551D8B240966B02ED71516C3360@MN2PR04MB6255.namprd04.prod.outlook.com> <87muanwwhb.fsf@nanos.tec.linutronix.de> <8f1e5981b519acb5edf53b5392c81ef7cbf6a3eb.camel@linux.intel.com> <87muaetj4p.fsf@nanos.tec.linutronix.de>
Date:   Sun, 09 Feb 2020 16:37:35 +0100
Message-ID: <8736bjlqkg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sean,

Thomas Gleixner <tglx@linutronix.de> writes:
> Sean V Kelley <sean.v.kelley@linux.intel.com> writes:
>> So I will ensure we actually create useful information pointing to this
>> behavior either in kernel docs or online as in a white paper or both.
>
> Great.
>
>>> As we have already quirks in drivers/pci/quirks.c which handle the
>>> same issue on older chipsets, we really should add one for these kind
>>> of systems to avoid fiddling with the BIOS (which you can, but most
>>> people cannot).
>
>> Agreed, and I will follow-up with Kar Hin Ong to get them added.
>
> Much appreciated.

Any update on this?

Thanks,

        tglx
