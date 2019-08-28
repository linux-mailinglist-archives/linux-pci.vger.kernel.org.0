Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE29FCB2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 10:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfH1IRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 04:17:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44245 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfH1IRL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 04:17:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so690459wrp.11;
        Wed, 28 Aug 2019 01:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=elcDxralvab5BCLPwy6aNqNRddh9yUrA4hJ16xi48PI=;
        b=KsERq02pyOdSj8DPaDZ0SanJNIq3WnXBJWhH4yeuGICKoNdcG/9JkmJnkyKaf1Bs5E
         wySG6bGoQYTgWbP1BBBPPmK3AKu5ZToZxtlj7LomlVhH+QBpvbXmcflr7LwXDdObalFd
         hSmRWdwk1tYK+9e6k+wmNKw8P1diniRId/9fYsbaongF4Icrao+lOa4pR5iNMV+FOwpF
         y8WVPgwaYs9swp9fsTSOlYtsQ3x2DH6w52xLLsUIa68bBQF0bQZ9lFTaB4gQaRAlOTcZ
         bt7stDAHzHBNx4o7yDZTvAUOBi51FLw1hnC/SQmGIh4o+1QWQr9PMIJ6EmJzWX5c/fZL
         i1Pw==
X-Gm-Message-State: APjAAAW+awAfq6FaYJpF9ifkLDUanahXWBdAMWQLz/BYvXvU5GUH0ppN
        l1W7RG5o7oa1xsl7OGIiyuc=
X-Google-Smtp-Source: APXvYqwmhv7I8k483ahGnEjGNmo4amPeyJahnDXrjCmOd75ub2Hi+25Drc0PFsP+jngUCzaAGvF4IQ==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr2910751wrp.145.1566980229213;
        Wed, 28 Aug 2019 01:17:09 -0700 (PDT)
Received: from 1aq-andre ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id p19sm1406467wmg.31.2019.08.28.01.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 01:17:08 -0700 (PDT)
Message-ID: <bc6247cdd51d7a7b28c52a186d4975ecbeaa602d.camel@andred.net>
Subject: Re: [PATCH 2/2] dt-bindings: imx6q-pcie: add
 "fsl,pcie-phy-refclk-internal" for i.MX7D
From:   =?ISO-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Date:   Wed, 28 Aug 2019 09:17:07 +0100
In-Reply-To: <20190827155626.GA29948@bogus>
References: <20190813103759.38358-1-git@andred.net>
         <20190813103759.38358-2-git@andred.net> <20190827155626.GA29948@bogus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Tue, 2019-08-27 at 10:56 -0500, Rob Herring wrote:
> On Tue, Aug 13, 2019 at 11:37:59AM +0100, André Draszik wrote:
> > The i.MX7D variant of the IP can use either an external
> > crystal oscillator input or an internal clock input as
> > a reference clock input for the PCIe PHY.
> > 
> > Document the optional property 'fsl,pcie-phy-refclk-internal'
> > 
> > Signed-off-by: André Draszik <git@andred.net>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > index a7f5f5afa0e6..985d7083df9f 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > @@ -56,6 +56,11 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
> >  	       - "turnoff"
> >  - fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
> 
> Not sure how this got in, but why is the phy binding not used here?
> 
> >  
> > +Additional optional properties for imx7d-pcie:
> > +- fsl,pcie-phy-refclk-internal: If present then an internal PLL input is used
> > +  as PCIe PHY reference clock source. By default an external ocsillator input
> > +  is used.
> 
> Can't the clock binding and maybe 'assigned-clocks' be used here? 
> 
> Also, this is a property of the PHY, so it belongs in the PHY's node.

Thanks for pointing this out. I'll have a look.

Andre'


