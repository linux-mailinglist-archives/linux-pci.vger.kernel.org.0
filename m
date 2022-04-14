Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C819501983
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiDNRF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243806AbiDNRFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 13:05:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE0D321;
        Thu, 14 Apr 2022 09:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7D3AB82A63;
        Thu, 14 Apr 2022 16:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B115C385A1;
        Thu, 14 Apr 2022 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649954710;
        bh=EHvHZqQ8PezYz6tH8c5/n0Zz580GmorgdpGMD73yBpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TO5HgoWM2HCijQiMf5Ii/ai+Kas9SijrS4oMSyTpooBg865KZgLZiFnhKSA8ywfy0
         Ko1YN1MrXPWhfLoaF0lldsMksAUOOFy5/Pb/SrlhYoBjJFxh6wFPLDYvj0LyfYBwJc
         nMDfGSXxRatFMyJhltgGTRz5AGhQtFti5l+tsIyXMpjaC1JQb6sNwq91H6vt4+Ucj+
         TZg1+M7Y3PNLHPIDiIIHh7PSnjhvHQIZ/pJ0cMBVUWXhpPbRP2src72ieWbaFJqT1j
         HAaozkfr4cwBHUBSklLd67JwQ6KBzSSifw0SMwkP2SmzgRWcsFEtrntio6fFnbOU+C
         TzwVezm93bULA==
Date:   Thu, 14 Apr 2022 11:45:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh@kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: xilinx-cpm: Remove version
 number in compatible string
Message-ID: <20220414164508.GA753109@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ef84f9-4cac-c0aa-c717-7f1b3bc566fb@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 02:46:25PM +0200, Michal Simek wrote:
> On 4/14/22 11:22, Bharat Kumar Gogada wrote:
> > Removing unnecessary version number in compatible string.
> 
> I am missing reason for this in commit message.

Agreed.  The commit log for the pcie-xilinx-cpm.c change also needs to
explain why removing the version is useful and safe.

> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >   Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > index 32f4641085bc..4ebcc838a1f6 100644
> > --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > @@ -14,7 +14,7 @@ allOf:
> >   properties:
> >     compatible:
> > -    const: xlnx,versal-cpm-host-1.00
> > +    const: xlnx,versal-cpm-host
> 
> And this is likely breaking compatibility for existing DTs.
> 
> M
> 
> >     reg:
> >       items:
> > @@ -70,7 +70,7 @@ examples:
> >                  #address-cells = <2>;
> >                  #size-cells = <2>;
> >                  cpm_pcie: pcie@fca10000 {
> > -                       compatible = "xlnx,versal-cpm-host-1.00";
> > +                       compatible = "xlnx,versal-cpm-host";
> >                          device_type = "pci";
> >                          #address-cells = <3>;
> >                          #interrupt-cells = <1>;
