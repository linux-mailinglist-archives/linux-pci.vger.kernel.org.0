Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5354C4519
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 13:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiBYM6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 07:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiBYM6r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 07:58:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DE714FFFE;
        Fri, 25 Feb 2022 04:58:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D4CAB82F79;
        Fri, 25 Feb 2022 12:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68B6C340E7;
        Fri, 25 Feb 2022 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645793893;
        bh=yXNshXV8iIu7D0QVOExyxryhfq/he3SIhXZTLLv/Cos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLwe9KLo89Nib7HAZFqLVK/37FznuJAkVKorOG+qTB9XTpwuqAFkoQC6K79+86FoE
         2HUAiZcBSIzsMXwfwFf5oye8uSVbL7kMYmpwS9fRuWEnwt0zKPOROcTXO+cBzkuRsO
         IgOkGY0XeJaI8x6fy5tXh7jt5AiMNVJIpm/O8+/itqfk/emur0v7ExOIwBA+zFASst
         VliY0+I2ReoymJUGSaxBS+SCvQuhBQ0XKRKUhCdSWnItMhqrPxIAFhRyzv7fQOW2B1
         nOzdp0l4BNtNMxNx5T7veOmCAihQbiunDw8zJfqZIVkc24wTrEy4UY45QmwMTSx/YO
         IfyqeaWdYlLcA==
Received: by pali.im (Postfix)
        id 62D427EF; Fri, 25 Feb 2022 13:58:10 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:58:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/12] dt-bindings: PCI: mvebu: Add num-lanes property
Message-ID: <20220225125810.7mbo7firer5yodls@pali>
References: <20220222155030.988-5-pali@kernel.org>
 <20220225000226.GA304258@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225000226.GA304258@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 February 2022 18:02:26 Bjorn Helgaas wrote:
> On Tue, Feb 22, 2022 at 04:50:22PM +0100, Pali Rohár wrote:
> > Controller driver needs to correctly configure PCIe link if it contains 1
> > or 4 SerDes PCIe lanes. Therefore add a new 'num-lanes' DT property for
> > mvebu PCIe controller. Property 'num-lanes' seems to be de-facto standard
> > way how number of lanes is specified in other PCIe controllers.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > index 6173af6885f8..24225852bce0 100644
> > --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > @@ -77,6 +77,7 @@ and the following optional properties:
> >  - marvell,pcie-lane: the physical PCIe lane number, for ports having
> >    multiple lanes. If this property is not found, we assume that the
> >    value is 0.
> > +- num-lanes: number of SerDes PCIe lanes for this link (1 or 4)
> >  - reset-gpios: optional GPIO to PERST#
> >  - reset-delay-us: delay in us to wait after reset de-assertion, if not
> >    specified will default to 100ms, as required by the PCIe specification.
> > @@ -141,6 +142,7 @@ pcie-controller {
> >  		interrupt-map = <0 0 0 0 &mpic 58>;
> >  		marvell,pcie-port = <0>;
> >  		marvell,pcie-lane = <0>;
> > +		num-lanes = <1>;
> 
> Is this patch really necessary?

This is just documentation patch. And I think that documentation is
always important.

> AFAICS, the related driver change
> only sets "port->is_x4 = true" when "num-lanes = <4>", and in all
> other cases it defaults to a Max Link Width of 1:
> 
>   lnkcap |= (port->is_x4 ? 4 : 1) << 4;

Yes!

And this registers configures number of lanes in HW.

> I don't see the point of adding a value that we don't validate or do
> anything with.  E.g., I don't see an error message that would catch
> "num-lanes = <3>".
> 
> Bjorn

In past I was told that kernel should not do validation of DT properties
and it is job of some DT schema validation. That is why I did not added
code into kernel which show error message when value different than 1
and 4 is specified in DT.

But issue here is that there is no DT schema for pci-mvebu as above
.txt file was not converted to YAML schema yet. This is something which
should be improved...
