Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2713D081
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 00:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAOXFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 18:05:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49497 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOXFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 18:05:47 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irrjG-0002zJ-VA; Thu, 16 Jan 2020 00:05:39 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 13D65100C1B; Thu, 16 Jan 2020 00:05:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kar Hin Ong <kar.hin.ong@ni.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Julia Cartwright <julia.cartwright@ni.com>,
        Keng Soon Cheah <keng.soon.cheah@ni.com>
Subject: RE: Re: "oneshot" interrupt causes another interrupt to be fired erroneously in Haswell system
In-Reply-To: <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com>
References: <20191031230532.GA170712@google.com> <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de> <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com>
Date:   Thu, 16 Jan 2020 00:05:38 +0100
Message-ID: <87a76oxqv1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kar Hin Ong <kar.hin.ong@ni.com> writes:
>> > > From Intel Xeon Processor E5/E7 v3 Product Family External Design
>> > > Specification (EDS), Volume One: Architecture, section 13.1 (Legacy
>> > > PCI Interrupt Handling), it mention: "If the I/OxAPIC entry is
>> > > masked (via the 'mask' bit in the corresponding Redirection Table
>> > > Entry), then the corresponding PCI Express interrupt(s) is forwarded
>> > > to the legacy PCH"
>> 
>> Oh well. Really useful behaviour - NOT!

Second thoughts on this. This behaviour is intentional to make PCI
interrupts work even when the IOAPIC is not initialized at all.

I don't have access to the document you mentioned, but I know that
chipsets have a knob to control that behaviour. Just checked a few
chipset docs and they contain the same sentence, but then in the next
paragraph they say:

 "If the I/OxAPIC entry is masked (via the mask bit in the corresponding
  Redirection Table Entry), then the corresponding PCI Express
  interrupt(s) is forwarded to the legacy ICH, provided the Disable PCI
  INTx Routing to ICH bit is clear, Section 19.10.2.27, QPIPINTRC: Intel
  QuickPath Interconnect Protocol Interrupt Control."

That control bit is 0 after reset, so the legacy forwarding works.

Another way to avoid this is to use MSI interrupts instead of the legacy
PCI ones, which is recommended for various reasons (including
performance) anyway.

Can you please provide the exact CPU and PCH types and the output of
'lspci -vvv'?

Thanks,

        tglx




