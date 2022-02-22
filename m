Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F794C000F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 18:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiBVRYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 12:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiBVRYs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 12:24:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B116EAB0;
        Tue, 22 Feb 2022 09:24:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8656130C;
        Tue, 22 Feb 2022 17:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9B0C340E8;
        Tue, 22 Feb 2022 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645550662;
        bh=77eDg1ymyakBS7g9E9M8fgtWWUQbIQOFjGsJ7iYRfC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eb6v0scGF8YCLZtvr8LovkMn3T36GiI55HASQRx0Wg9DuzCAMfI6Qqj/oNus8rujS
         1KZIAtCZ7yPhW2dyZuiv6CkzA4nixExw9bv36ZjGxUL3T82ck2HmCZc7T/X6P4+wZX
         49lwoG3X/xgRKchatyenCSw4XigU3XMSODz4uLT0+v/HpxmR21ibmidPBQuebMpO58
         Y2CRFwa2+rW5A6CBr74Ntn5Zri+7Kz1M9sPUOKIPLen7SuuS7rW6Pm7yt2L4ZB9ca7
         0271OjEul2FSNFjAh7OETUpqQKfqMdV/s8yxrpbulIVoH8lZ5JI/2cjn7Yfok+GyfZ
         o+GoeGRB0wE1Q==
Date:   Tue, 22 Feb 2022 18:24:15 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: Add 'slot-power-limit-milliwatt' PCIe
 port property
Message-ID: <20220222182415.50922b90@thinkpad>
In-Reply-To: <20220222163158.1666-4-pali@kernel.org>
References: <20220222163158.1666-1-pali@kernel.org>
        <20220222163158.1666-4-pali@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 22 Feb 2022 17:31:55 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> This property specifies slot power limit in mW unit. It is a form-factor
> and board specific value and must be initialized by hardware.
>=20
> Some PCIe controllers delegate this work to software to allow hardware
> flexibility and therefore this property basically specifies what should
> host bridge program into PCIe Slot Capabilities registers.
>=20
> The property needs to be specified in mW unit instead of the special form=
at
> defined by Slot Capabilities (which encodes scaling factor or different
> unit). Host drivers should convert the value from mW to needed format.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>

This patch is not needed, the property already is described in
dtschema.

Marek
