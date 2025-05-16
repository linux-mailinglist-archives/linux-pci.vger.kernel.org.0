Return-Path: <linux-pci+bounces-27893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A24ABA326
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E00B18969E0
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120E27E7C0;
	Fri, 16 May 2025 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YfSLBGme"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6782274FF9;
	Fri, 16 May 2025 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421359; cv=none; b=qiZHLvHNu64Z5YtRp2Di5Wa9xZ74GgxP6I/HVw9vkp/KW43sxGdkLU/8/7t1P804taduVadRPXB191M1AozJ0KlhsGaqFGRXGlg4tYrxa+h38HtAEXGfXaep/inOHYNLSEPAnqohx3IR+wZskJEE5HBcdxiGGplrZr7w557KrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421359; c=relaxed/simple;
	bh=L2zfEnGbFxXlzozh3R4xBVOc9dI6O3z7CfzV+z8eaD4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CU+S0F1wrjNI5jzsNzY5+BEeJQfciximkKVOP41gwSfkj1e5SIAvtqB3ZQfHkK0FMTQrLuAqWmDzyuvYs++la8WMMvKG3wSd0mtYnb6MFDMRBMoHtNzasfbJPYWZAN6A0sTJJvHmYpjsWw6ldyVbCl7QA5YA0E3HcvdRBC6hMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YfSLBGme; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1747421348; x=1747680548;
	bh=7yNiiKDF+KREAb3BL5tgjMXVU2VSaNddorcUcOqgweU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YfSLBGme+j8sYt6NOtKuOUslAYSSy5jMhTgXKeh1Te/z8i1Ab3lSiBojNz003mqfi
	 Diz0TWon7Y/W3BD/3c0ViEiGDAxFzRpV1EyJOiyz6PYCfr2N0QjKanbMEfjnsUy/HC
	 256JSo7wEkjVwq/HEK6Hh1IwvUTOE7hT8tEJz/BIzMw7WtBV2s5fj/PjUzTfGHjGJs
	 j56yR09sxYPfbIU/gn/gY4RAF/2PRY9JoHBzkCaC22evAvIooVP3C3nr/Jme/Hr0fb
	 zn3wsw07kH2W73i/q/J6sYWLpcqnZL/G0LBrPa0FaAwp4N6FsgzKcTF4wdMvVg1CmT
	 zxsEcQ9CJf95A==
Date: Fri, 16 May 2025 18:48:59 +0000
To: Niklas Cassel <cassel@kernel.org>
From: Laszlo Fiat <laszlo.fiat@proton.me>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Krishna chaitanya chundru <quic_krichai@quicinc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: dwc: Link Up IRQ fixes
Message-ID: <5l0eAX7zaDMDMp1vJhvB9MVKXSPn3Ra0ZiP5e2q1E4rwmADBB6MlREZO9cuD_zvclAOhhBE0-NFthVbOajeSCfYjchT-83OgLbjclOgx3T4=@proton.me>
In-Reply-To: <aCcMrtTus-QTNNiu@ryzen>
References: <20250506073934.433176-6-cassel@kernel.org> <7zcrjlv5aobb22q5tyexca236gnly6aqhmidx6yri6j7wowteh@mylkqbwehak7> <aCNSBqWM-HM2vX7K@ryzen> <fCMPjWu_crgW5GkH4DJd17WBjnCAsb363N9N_h6ld1i8NqNNGR9PTpQWAO9-kwv4DUL6um48dwP0GJ8GmdL4uQf-WniBepwuxTEhjmbBnug=@proton.me> <aCcMrtTus-QTNNiu@ryzen>
Feedback-ID: 130963441:user:proton
X-Pm-Message-ID: a32a7c4b900ed4f1e27a751ddab136cfa7cdfb9b
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
-------- Original Message --------
On 16/05/2025 12:00, Niklas Cassel <cassel@kernel.org> wrote:

>  On Thu, May 15, 2025 at 05:33:41PM +0000, Laszlo Fiat wrote:
>  > I am the one experiencing the issue with my Orange PI 3B (RK3566, 8 GB=
 RAM) and a PLEXTOR PX-256M8PeGN NVMe SSD.
>  >
>  > I first detected the problem while upgrading from 6.13.8 to 6.14.3, th=
at my system cannot find the NVME SSD which contains the rootfs. After reve=
rting the two patches:
>  >
>  > - ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can de=
tect Link Up")
>  > - 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on dll_li=
nk_up IRQ")
>  >
>  > my system booted fine again.
>  > After that I tested the patches sent by Niklas in this thread, which f=
ixed the issue, so I sent Tested-by.
>  >
>  > I did another test Today with 6.15.0-rc6, which in itself does not fin=
d my SSD. Niklas asked me to test with these
>  >
>  > - revert ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we=
 can detect Link Up")
>  > - revert 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on=
 dll_link_up IRQ")
>  > - apply the following patch:
>  >
>  > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pc=
i/controller/dwc/pcie-designware.c
>  > index b3615d125942..5dee689ecd95 100644
>  > --- a/drivers/pci/controller/dwc/pcie-designware.c
>  > +++ b/drivers/pci/controller/dwc/pcie-designware.c
>  > @@ -692,7 +692,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  >                 if (dw_pcie_link_up(pci))
>  >                         break;
>  >
>  > -               msleep(LINK_WAIT_SLEEP_MS);
>  > +               usleep_range(100, 200);
>  >         }
>  >
>  >         if (retries >=3D LINK_WAIT_MAX_RETRIES) {
>  >
>  >
>  > which restores the original behaviour to wait for link-up, then shorte=
n the time. This resulted again a non booting system, this time with "Phy l=
ink never came up" error message.
> =20
>  That message was unexpected.
> =20
>  What I expected to happen was that the link would come up, but by reduci=
ng
>  delay between "link is up" and device is accessed (from 90 ms -> 100 us)=
,
>  I was that you would see the same problem on "older" kernels as you do w=
ith
>  the "link up IRQ" patches (which originally had no delay, but this serie=
s
>  basically re-added the same delay (PCIE_T_RRS_READY_MS, 100 ms) as we ha=
d
>  before (LINK_WAIT_SLEEP_MS, 90 ms).
> =20
>  But I see the problem with the test code that I asked you to test to ver=
ify
>  that this problem also existed before (if you had a shorter delay).
>  (By reducing the delay, the LINK_WAIT_MAX_RETRIES also need to be bumped=
.)
> =20
>  Could you please test:
>  diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/=
controller/dwc/pcie-designware.c
>  index b3615d125942..5dee689ecd95 100644
>  --- a/drivers/pci/controller/dwc/pcie-designware.c
>  +++ b/drivers/pci/controller/dwc/pcie-designware.c
>  @@ -692,7 +692,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>                  if (dw_pcie_link_up(pci))
>                          break;
> =20
>  -               msleep(LINK_WAIT_SLEEP_MS);
>  +               usleep_range(100, 200);
>          }
> =20
>          if (retries >=3D LINK_WAIT_MAX_RETRIES) {
>  diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/=
controller/dwc/pcie-designware.h
>  index 4dd16aa4b39e..8422661b79d5 100644
>  --- a/drivers/pci/controller/dwc/pcie-designware.h
>  +++ b/drivers/pci/controller/dwc/pcie-designware.h
>  @@ -61,7 +61,7 @@
>          set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> =20
>   /* Parameters for the waiting for link up routine */
>  -#define LINK_WAIT_MAX_RETRIES          10
>  +#define LINK_WAIT_MAX_RETRIES          10000
>   #define LINK_WAIT_SLEEP_MS             90
> =20
>   /* Parameters for the waiting for iATU enabled routine */
> =20
> =20
>  On top of an old kernel instead?
>

I have compiled a vanilla 6.12.28, that booted fine, as expeced. Then compi=
led a  version with the patch directly above.

>  We expect the link to come up, but that you will not be able to mount ro=
otfs.
> =20

That is exactly what happened.=20

>  If that is the case, we are certain that the this patch series is 100% n=
eeded
>  for your device to have the same functional behavior as before.

That is the case.

Bye,

Laszlo Fiat=20
> =20
> =20
>  Kind regards,
>  Niklas
>  

