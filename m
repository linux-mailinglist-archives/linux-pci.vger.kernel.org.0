Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF62D8C249
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 22:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfHMUqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 16:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHMUqc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 16:46:32 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DD520840;
        Tue, 13 Aug 2019 20:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565729191;
        bh=VD7sMXa3g5jKV36WcN4HRJExOcbvrg4QBwPRahfXpKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IeVIHF0ZwSJrd8lOx/x1iP3SExjG5HpTVZKO/OmVMeHHCVOz0GqrN8CSqkunNQbjC
         gaLd+mhqbQEjSq8lXYkWzVr/LfBbtqrw2ML/mmfRy3DNH0fKVc+ajiCZsxWA3ql78O
         +sDw3Fy6NLXs6Xc9McLlCCMnt/RHjgoxnWmrvnXA=
Received: by mail-qt1-f173.google.com with SMTP id v38so15427799qtb.0;
        Tue, 13 Aug 2019 13:46:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXQF7GN9s2yRf87+OBTRVzzOO/jI60fp/FYmkR2ymAT3/6ZmDaV
        WS2MR5HhR4npqnszVQ+JRVeBC55STuaWsxyWBg==
X-Google-Smtp-Source: APXvYqybZnW+Hg+qQNH+RYVPpUqUHylPLMJZt9LCqM2Xud7wJshKzEAioy1Zwf6YvkX6LGRHqGbl12cxVpeLYNxEoSs=
X-Received: by 2002:ac8:7593:: with SMTP id s19mr27753241qtq.136.1565729190807;
 Tue, 13 Aug 2019 13:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190723092529.11310-1-jonnyc@amazon.com> <20190723092711.11786-1-jonnyc@amazon.com>
 <20190813153046.GA31480@bogus> <06c198ff2f8f9b1b29283a7b8764ab776c1e574b.camel@amazon.com>
In-Reply-To: <06c198ff2f8f9b1b29283a7b8764ab776c1e574b.camel@amazon.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 13 Aug 2019 14:46:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ME-faxK8o7rq8gyYC8cjtr+yZOz8A47zKMrjYAtmumw@mail.gmail.com>
Message-ID: <CAL_Jsq+ME-faxK8o7rq8gyYC8cjtr+yZOz8A47zKMrjYAtmumw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe
 host bridge binding
To:     "Chocron, Jonathan" <jonnyc@amazon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 13, 2019 at 10:49 AM Chocron, Jonathan <jonnyc@amazon.com> wrote:
>
> On Tue, 2019-08-13 at 09:30 -0600, Rob Herring wrote:
> > On Tue, Jul 23, 2019 at 12:27:08PM +0300, Jonathan Chocron wrote:
> > > Document Amazon's Annapurna Labs PCIe host bridge.
> > >
> > > Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> > > ---
> > >  .../devicetree/bindings/pci/pcie-al.txt       | 45
> > > +++++++++++++++++++
> > >  MAINTAINERS                                   |  3 +-
> > >  2 files changed, 47 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/pcie-
> > > al.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt
> > > b/Documentation/devicetree/bindings/pci/pcie-al.txt
> > > new file mode 100644
> > > index 000000000000..89876190eb5a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
> > > @@ -0,0 +1,45 @@
> > > +* Amazon Annapurna Labs PCIe host bridge
> > > +
> > > +Amazon's Annapurna Labs PCIe Host Controller is based on the
> > > Synopsys DesignWare
> > > +PCI core.
> > > +It shares common functions with the PCIe DesignWare core driver
> > > and inherits
> >
> > Driver details are irrelevant to the binding.
> >
> Will remove.
>
> > > +common properties defined in
> > > Documentation/devicetree/bindings/pci/designware-pcie.txt.
> > > +Properties of the host controller node that differ from it are:
> > > +
> > > +- compatible:
> > > +   Usage: required
> > > +   Value type: <stringlist>
> > > +   Definition: Value should contain
> > > +                   - "amazon,al-pcie"
> >
> > Needs to be SoC specific.
> >
> I'm not sure I follow. The PCIe controller can be implemented in
> different SoCs. Could you please clarify?

All the features, bugs, and integration will be exactly the same on
all SoCs and you will never need to distinguish?

This is standard convention for compatible strings and how you avoid
updating the DT (part of firmware) when you find some difference the
OS needs to handle down the road.

If the next SoC is 'the same', then you do:

compatible = "amazon,newsoc-pcie", "amazon,oldsoc-pcie";

Rob
