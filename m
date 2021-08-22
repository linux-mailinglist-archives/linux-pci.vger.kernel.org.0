Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4BA3F3F49
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhHVMj3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 08:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhHVMj2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 22 Aug 2021 08:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5A746128A;
        Sun, 22 Aug 2021 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629635927;
        bh=muvvoBs3oUAwLkFvn/dXSRDVyPPnG/XlYO7Kc0FDXI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OeND9lDcBkhjmaB/0jcrN29hGzyDqadcJYo5fYIyc8WoLfMY5k1SIROBaJB1US56E
         GWfQWCYB7Oyt1spE288LCfi9RqBusL0PGXJqpezCmNIXm7X3xLTwH0zDtIt7gsWNJf
         lUM11tmv4m/ah0q4XWJBL4Q1812vLx2OkaaCumbA7MQ9hISqgC1JAq2aZTYBcVTX/n
         tte5AIIXg9hU1ETbEc0wnYVrbizOam14+KG8o/T1Zt38nQ4OFFUWRsmpZgGTJVHsvw
         Dzbd4jPD9bW5fwp57JWr8cHB+4hK7HAskiUFuFIvqeVMS5jDcBUW+ptqW2QaENVHEa
         b2RpTlh/mAkww==
Date:   Sun, 22 Aug 2021 14:38:43 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add 'slot-power-limit' PCIe port
 property
Message-ID: <20210822143843.4f4985a4@thinkpad>
In-Reply-To: <20210820160023.3243-2-pali@kernel.org>
References: <20210820160023.3243-1-pali@kernel.org>
        <20210820160023.3243-2-pali@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 20 Aug 2021 18:00:21 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> This property specifies slot power limit in mW unit. It is form-factor and
> board specific value and must be initialized by hardware.
>=20
> Some PCIe controllers delegates this work to software to allow hardware
> flexibility and therefore this property basically specifies what should
> host bridge programs into PCIe Slot Capabilities registers.
>=20
> Property needs to be specified in mW unit, and not in special format
> defined by Slot Capabilities (which encodes scaling factor or different
> unit). Host drivers should convert value from mW unit to their format.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentatio=
n/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..e67d5db21514 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -32,6 +32,12 @@ driver implementation may support the following proper=
ties:
>     root port to downstream device and host bridge drivers can do program=
ming
>     which depends on CLKREQ signal existence. For example, programming ro=
ot port
>     not to advertise ASPM L1 Sub-States support if there is no CLKREQ sig=
nal.
> +- slot-power-limit:
> +   If present this property specifies slot power limit in mW unit. Host =
drivers
> +   can parse this slot power limit and use it for programming Root Port =
or host
> +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit message
> +   through the Root Port or host bridge when transitioning PCIe link fro=
m a
> +   non-DL_Up Status to a DL_Up Status.
> =20
>  PCI-PCI Bridge properties
>  -------------------------

SFP uses something similar for maximum power, but since the units are
in milliwatt, the name of the property is maximum-power-milliwatt, to
avoid problems. I think it should be done here as well, i.e.
  slot-maximum-power-milliwatt
or maybe even
  maximum-power-milliwatt.

Marek
