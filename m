Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235C84C3A03
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 01:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiBYADA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 19:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiBYADA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 19:03:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531B718F239;
        Thu, 24 Feb 2022 16:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C689361C5A;
        Fri, 25 Feb 2022 00:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC0FC340E9;
        Fri, 25 Feb 2022 00:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645747348;
        bh=B5C/irAy5Ksddk0oeAfWCNVXMjjzHhykOfXsUHlDfiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FnBk0yBT8P4/HNhq/XNKvxXaoDFhHO5SqZmvwFrWWsqUJQw/kezs9NKd44trxe2ol
         dAD/Lef2N0wukNLou1M1AorFCxCh1Ck+CeuJyDXugG0qE4EMC/GNA98cpRN9PWi2Tu
         xNphdc525yVvjRdNZVda4zNu4ZpZg7osW6myVg1OjCalqiQI3nvgn3ScInTdNp2iJu
         ze0uT9v8Ux3rbKeCrE7WiwNDbuA4Hi5HksoggPw3TYjsU0SM4Pr9dpAMoqJ0VYipVM
         4u/FLsn2RhgLPO8FTk3ZV4fXrwxRMLeoNmv2/V/k969Z8FiCv3TU4U9P/T09VOSZGo
         k6mQtILoRoVnQ==
Date:   Thu, 24 Feb 2022 18:02:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/12] dt-bindings: PCI: mvebu: Add num-lanes property
Message-ID: <20220225000226.GA304258@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222155030.988-5-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 04:50:22PM +0100, Pali Rohár wrote:
> Controller driver needs to correctly configure PCIe link if it contains 1
> or 4 SerDes PCIe lanes. Therefore add a new 'num-lanes' DT property for
> mvebu PCIe controller. Property 'num-lanes' seems to be de-facto standard
> way how number of lanes is specified in other PCIe controllers.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> index 6173af6885f8..24225852bce0 100644
> --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> @@ -77,6 +77,7 @@ and the following optional properties:
>  - marvell,pcie-lane: the physical PCIe lane number, for ports having
>    multiple lanes. If this property is not found, we assume that the
>    value is 0.
> +- num-lanes: number of SerDes PCIe lanes for this link (1 or 4)
>  - reset-gpios: optional GPIO to PERST#
>  - reset-delay-us: delay in us to wait after reset de-assertion, if not
>    specified will default to 100ms, as required by the PCIe specification.
> @@ -141,6 +142,7 @@ pcie-controller {
>  		interrupt-map = <0 0 0 0 &mpic 58>;
>  		marvell,pcie-port = <0>;
>  		marvell,pcie-lane = <0>;
> +		num-lanes = <1>;

Is this patch really necessary?  AFAICS, the related driver change
only sets "port->is_x4 = true" when "num-lanes = <4>", and in all
other cases it defaults to a Max Link Width of 1:

  lnkcap |= (port->is_x4 ? 4 : 1) << 4;

I don't see the point of adding a value that we don't validate or do
anything with.  E.g., I don't see an error message that would catch
"num-lanes = <3>".

Bjorn
