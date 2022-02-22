Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECB34C0080
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 18:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiBVRx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 12:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiBVRx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 12:53:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16EC7EA5;
        Tue, 22 Feb 2022 09:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AEAFB80AD0;
        Tue, 22 Feb 2022 17:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD9DC340E8;
        Tue, 22 Feb 2022 17:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645552410;
        bh=jFp2EWCacPijmI15Ry/vvjj2pFIm2szOpHGxI87OMqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+uOFAUmn95WXJ+ZiuHrsXy3zqMDKcIael8TPpK1KsRputJYuUt9kWJLREhZaGsH+
         oDvNK6wE9tsgmznsrL+Yp4F//HxVDr/QwoX4u+26EjmzHge/AyQL2ViA2soqpmMMxY
         /qDa8EYn5Hq3CQ8tEJ+O5//4UbGC3tgsgiZXv/HjPZbWjg/gcqbyxhw0qDlcgWX5rD
         bq+6kfco6swzCbGYuhroshBBm7q7xWTWr68sFLRTFtFyjC7LpGBKXsdMtZLhoIABOf
         Q/B4J9ISCQmSN/sj4XvvfLe8pP3uIppa2/s+wAFo0+hb8s/Cf0UXYXmolLNLW0m5hT
         HXG2tS506YrOg==
Received: by pali.im (Postfix)
        id A15AFFDB; Tue, 22 Feb 2022 18:53:28 +0100 (CET)
Date:   Tue, 22 Feb 2022 18:53:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: Add 'slot-power-limit-milliwatt' PCIe
 port property
Message-ID: <20220222175328.cwrls2sziscguixe@pali>
References: <20220222163158.1666-1-pali@kernel.org>
 <20220222163158.1666-4-pali@kernel.org>
 <20220222182415.50922b90@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222182415.50922b90@thinkpad>
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

On Tuesday 22 February 2022 18:24:15 Marek Behún wrote:
> On Tue, 22 Feb 2022 17:31:55 +0100
> Pali Rohár <pali@kernel.org> wrote:
> 
> > This property specifies slot power limit in mW unit. It is a form-factor
> > and board specific value and must be initialized by hardware.
> > 
> > Some PCIe controllers delegate this work to software to allow hardware
> > flexibility and therefore this property basically specifies what should
> > host bridge program into PCIe Slot Capabilities registers.
> > 
> > The property needs to be specified in mW unit instead of the special format
> > defined by Slot Capabilities (which encodes scaling factor or different
> > unit). Host drivers should convert the value from mW to needed format.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> 
> This patch is not needed, the property already is described in
> dtschema.

But dtschema with this property is not included in kernel and this file
is the only in-kernel documentation. So updating it makes sense.
