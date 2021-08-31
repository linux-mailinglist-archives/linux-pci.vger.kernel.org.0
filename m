Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30513FCEEF
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbhHaVF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 17:05:28 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:37847 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbhHaVF2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 17:05:28 -0400
Received: by mail-oo1-f49.google.com with SMTP id k20-20020a4ad114000000b0029133123994so171495oor.4;
        Tue, 31 Aug 2021 14:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6X3lAPOMxLN3rTFAzVGKXhE+6Wf53mp+fiu4u2XkFqk=;
        b=l94qxI8GPiiFcg+4t6FOez3yPmStzocSni52ewodhI4HJwPmCfsolPEN2cz9YzDWt9
         +qUHJ5qD+finlVxfptk2DoSINrlrvYZfHmLe6eNlP5F/8L1001/NrzLfnpw2Hl426qRc
         X1IC+cTDIL+xzWDSoSFqkcEP/ULJt2eSZs1/K0k0zu324I3RFvUk/62gSeaUNmanSmy2
         sWGzg9mMwAsyv6Pw8r2NsDZuzNQsTKPmTZ+lWyxCda3HRt0dw6E1Xk9XCrSHOMAFFymd
         UTX9kmhM5XlZ3Wro3Xx7JfLyjLRN/MAnhUTjTHxHWRMlONK6lWks74dWpylHf2kUh13+
         U0Ug==
X-Gm-Message-State: AOAM531wsFUK4aYMBPqMVOvOtfSL5llpfAt5EVXelZTTRdDwG7hE6yeh
        PFNjtQceiqZK0KotXd90uA==
X-Google-Smtp-Source: ABdhPJy+38wLNdyakfjq94b8uvfK2Po7YdP3ly0uds0JQwpVUySa5ejGfx0wM2mvRMMEx74jC64xjg==
X-Received: by 2002:a4a:b502:: with SMTP id r2mr13715589ooo.70.1630443872079;
        Tue, 31 Aug 2021 14:04:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l44sm3971442otv.81.2021.08.31.14.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:04:30 -0700 (PDT)
Received: (nullmailer pid 643668 invoked by uid 1000);
        Tue, 31 Aug 2021 21:04:05 -0000
Date:   Tue, 31 Aug 2021 16:04:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        kettenis@openbsd.org, tglx@linutronix.de, maz@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, nsaenz@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jim2101024@gmail.com, daire.mcnamara@microchip.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: interrupt-controller: Convert MSI
 controller to json-schema
Message-ID: <YS6ZRSDjRQBt8LbG@robh.at.kernel.org>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-2-mark.kettenis@xs4all.nl>
 <561420d562d3e421@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561420d562d3e421@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 27, 2021 at 09:15:11PM +0200, Mark Kettenis wrote:
> > From: Mark Kettenis <mark.kettenis@xs4all.nl>
> > Date: Fri, 27 Aug 2021 19:15:26 +0200
> > 
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > Split the MSI controller bindings from the MSI binding document
> > into DT schema format using json-schema.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  .../interrupt-controller/msi-controller.yaml  | 34 +++++++++++++++++++
> >  .../bindings/pci/brcm,stb-pcie.yaml           |  1 +
> >  .../bindings/pci/microchip,pcie-host.yaml     |  1 +
> >  3 files changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > new file mode 100644
> > index 000000000000..5ed6cd46e2e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: BSD-2-Clause
> 
> Noticed that checkpatch complains that the preferred license for new
> binding schemas is (GPL-2.0-only OR BSD-2-Clause) so I'll fix that in
> the next version.

Yes, but the text you copied is default GPL-2.0, so you need the author's 
permission to add BSD license. However, as Mark Rutland wrote all of 
msi.txt for Arm Ltd, I can tell you dual licensing this is fine. Maybe 
it's so little to fall under fair use anyways, but IANAL.

Rob
