Return-Path: <linux-pci+bounces-671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E1280A021
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 11:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC801F210C3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74A125D3;
	Fri,  8 Dec 2023 10:00:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4624210CA
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 02:00:33 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rBXee-0002TW-Ni; Fri, 08 Dec 2023 11:00:20 +0100
Message-ID: <83ca3d88cdaa7bc6e6bd3c4e88518b155a6b0f05.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
From: Lucas Stach <l.stach@pengutronix.de>
To: Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com, 
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 shawnguo@kernel.org,  s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com
Cc: linux-imx@nxp.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 08 Dec 2023 11:00:19 +0100
In-Reply-To: <20231208091355.1417292-3-sherry.sun@nxp.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
	 <20231208091355.1417292-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

Hi Sherry,

Am Freitag, dem 08.12.2023 um 17:13 +0800 schrieb Sherry Sun:
> Add host-wake-gpio property that can be used to wakeup the host
> processor.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/=
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 81bbb8728f0f..944f0f961809 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -72,6 +72,10 @@ properties:
>        L=3Doperation state) (optional required).
>      type: boolean
> =20
> +  host-wake-gpio:

There is only one wake signal in PCIe and it has a defined direction,
so there is no point in specifying that it is a host wakeup. Also GPIO
handles without a traling 's' are deprecated. So this should be

wake-gpios

> +    description: Should specify the GPIO for controlling the PCI bus dev=
ice
> +      wake signal, used to wakeup the host processor. Default to active-=
low.

The description is wrong. For the RC complex case (which is the binding
you are modifying here) the controller does not control the wake
signal, but instead uses it as a input. The description should reflect
that.

The default is also quite useless, as your implementation does not
allow to change it. Please translate the GPIO active flags from the DT
to the proper IRQ flags and drop this default here. The DT should
simply carry the proper polarity.

Regards,
Lucas

> +
>  required:
>    - compatible
>    - reg


