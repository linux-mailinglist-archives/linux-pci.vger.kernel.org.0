Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F253AE03
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiFAUqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 16:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiFAUpq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 16:45:46 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FBC1D871E;
        Wed,  1 Jun 2022 13:35:03 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id k187so4179628oif.1;
        Wed, 01 Jun 2022 13:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bwfPnZ3Smy9LL/jbVljKmV0XKY9CYztNkeExJVepUaA=;
        b=3I6gO3w9SELxOhnRlP2860Nsq6KnYTMA5mQcsUeJk4NnNMZ6yHkcn+HUTsJxGHWovh
         5SbbUe64l5dzL4ysn0KuezNt7TgRor1kInovY+4VuBXibEujSDXu4wY6Tw6lFMX1N9dS
         E8RvQF5AvDt4TDUhcB3lVzp9BrHLnZv1CazNOpJgb5kM5RJVP2qQa/GKXcEPNuD9/4iR
         JjRUNKztpJq+iF10o8lGgPnVMZiRsV6wqdcXdqmt8jovpRPNnGe+6EGmUP6tRHRwl+Ek
         4JwI0X402eUFzb8PDJWbTtV6WE+NsvsDfwQxWd+V+mv23qea1xTx9uY9eCQUImPIEPsi
         14pw==
X-Gm-Message-State: AOAM530BaWInB5sf9j37qEaFGMqiLNDOMG9YdG3ZIkf9V/d6d5Im+biC
        Nw38VlzqIHZjG8FnEuMHGuPdLrNNbQ==
X-Google-Smtp-Source: ABdhPJw/uffnm4wPyyuhNm4bqIeJjckIMg7/0qFJKa9HRAdKQExEYe5u/fE6cXvP8AI2RkFFte4GYA==
X-Received: by 2002:a05:6870:3308:b0:f1:9e97:5a9d with SMTP id x8-20020a056870330800b000f19e975a9dmr16450047oae.127.1654113229465;
        Wed, 01 Jun 2022 12:53:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 12-20020aca120c000000b00325cda1ffa5sm1279901ois.36.2022.06.01.12.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 12:53:49 -0700 (PDT)
Received: (nullmailer pid 325060 invoked by uid 1000);
        Wed, 01 Jun 2022 19:53:48 -0000
Date:   Wed, 1 Jun 2022 14:53:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property order
Message-ID: <20220601195348.GA320367-robh@kernel.org>
References: <20220516102217.25960-1-bharat.kumar.gogada@xilinx.com>
 <b9c36db0-fb4f-19d2-68af-25b926cd33b0@xilinx.com>
 <BY5PR02MB69472D35FC4774C5B49FC19CA5D69@BY5PR02MB6947.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB69472D35FC4774C5B49FC19CA5D69@BY5PR02MB6947.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 25, 2022 at 11:03:32AM +0000, Bharat Kumar Gogada wrote:
> Hi Rob,
> 
> Can you please check this.

You can look at patchwork[1] and see where your patch is in the queue. 
No need to send me more emails.

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/

> 
> Regards,
> Bharat
> 
> > 
> > On 5/16/22 12:22, Bharat Kumar Gogada wrote:
> > > All existing vendor DTSes are using "cpm_slcr" reg followed by "cfg" reg.
> > >
> > > This order is also suggested by node name which is pcie@fca10000 which
> > > suggests that cpm_slcr register should be the first.
> > >
> > > Driver itself is using devm_platform_ioremap_resource_byname() for
> > > both names that's why there is no functional change even on
> > > description which are using current order.
> > >
> > > But still prefer to change order to cover currently used description.
> > > Fixes: e22fadb1d014 ("PCI: xilinx-cpm: Add YAML schemas for Versal CPM
> > > Root Port")
> > >
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > ---
> > >   .../devicetree/bindings/pci/xilinx-versal-cpm.yaml     | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > > b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > > index 32f4641085bc..cca395317a4c 100644
> > > --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > > @@ -18,13 +18,13 @@ properties:
> > >
> > >     reg:
> > >       items:
> > > -      - description: Configuration space region and bridge registers.
> > >         - description: CPM system level control and status registers.
> > > +      - description: Configuration space region and bridge registers.
> > >
> > >     reg-names:
> > >       items:
> > > -      - const: cfg
> > >         - const: cpm_slcr
> > > +      - const: cfg
> > >
> > >     interrupts:
> > >       maxItems: 1
> > > @@ -86,9 +86,9 @@ examples:
> > >                          ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0
> > 0x10000000>,
> > >                                   <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0
> > 0x80000000>;
> > >                          msi-map = <0x0 &its_gic 0x0 0x10000>;
> > > -                       reg = <0x6 0x00000000 0x0 0x10000000>,
> > > -                             <0x0 0xfca10000 0x0 0x1000>;
> > > -                       reg-names = "cfg", "cpm_slcr";
> > > +                       reg = <0x0 0xfca10000 0x0 0x1000>,
> > > +                             <0x6 0x00000000 0x0 0x10000000>;
> > > +                       reg-names = "cpm_slcr", "cfg";
> > >                          pcie_intc_0: interrupt-controller {
> > >                                  #address-cells = <0>;
> > >                                  #interrupt-cells = <1>;
> > 
> > Reviewed-by: Michal Simek <michal.simek@amd.com>
> > 
> > Thanks,
> > Michal
