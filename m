Return-Path: <linux-pci+bounces-40319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF2C346DB
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 09:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACB318C0FE5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3526ED55;
	Wed,  5 Nov 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7cjMwe5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB31F8723
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330732; cv=none; b=p9H96vWDo+pds/WPGefSdw6Jud4KxO0N/U8XeoujE229aEIsf1+JfzlBq6vl2tRHH9owIsgZHUxF5UigWkzfkHHTsGf/W0cQCmF8bt5+Yl75UHZaJulxSnp7w+k3F/MXa5eEc7Ay/tTUIW4vQ396GUFQGRLUSKbwyXqVNz0wjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330732; c=relaxed/simple;
	bh=srzN/PhkG7PNR7iXnFZ7dJAql7Ov3F3J4AFGSBOhmYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=insK5NajCZ0JKghVudfE1A8qYIzY4KgI5MvL35rKqH1EZXx2bXJu3c4yPse/HIDv+7Ts+u3puk7yv+wdvROpdaKxehUVnw0li5M3+HULveI6b9xRfJ2HhW+bfIUz1mIRc9E1OuwmISZBDjTHoFwENjbWGPA976rpXofoJJyBxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7cjMwe5; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c2816c0495so4177642a34.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 00:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762330729; x=1762935529; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+akL+KyD042Z4LrBke1JL7l0fksnlBHxMHBzPhw6II=;
        b=j7cjMwe53BD8uEs466oSOHAsyt0ZLu+1lKNvdtxqw439AEimLTIlSMPSsp9N2PEKe0
         iA5PR2e6Qy9WIvsG+RsCu25xiXzS2ZuHQtTOOWk8QQOjJDVqNE4Eli/9U5+n+0sy1xWq
         /9upJkNz5PkP/Di6QsH/pNZMGWme1JiLxlT1Aw05+s4wVUZLddIzAjWuHYuRM0tT4o3K
         1gCSDOxr0fuqCRBxVVvgp9nMOGTfEwd7FU6zohD1W8+YikjRP9a7EDJKqYrjj60Og0iH
         m6Xk/2vfJ+GWKKTkqFed4vqhNY0Ek1df2Cujxg5rdiY2WFQUbHYa72kmO41aMR1vCwe9
         HjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762330729; x=1762935529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+akL+KyD042Z4LrBke1JL7l0fksnlBHxMHBzPhw6II=;
        b=nSERVz+4VjZvV2/k/cvHJgteilDPE1bte/5jzVOhIU+fpERw8mm0dm9vL1aMwzAtCC
         WuejkUMAn9hemAh7OcNfbbDWWT5F5gkOV+iYG89I4Xjcvs7JOcN5OaQ1+A3v9zFqn6f/
         FzlDSktPEC5I9QAKXtJYLjZCrA/7QcNfnXC3oYBe4lUSfmAfAXPif9vVZYVSCtqNIjBN
         iUtdPlca7VGgo8peZ+Fr3xEI12KUcyPLeoEyKZU2rOn0Z/I4Lju1kZkowdZqioumB6zr
         pQswmlYBJEjyVKpQcEzX1MzPjH/oxio8At5zGuZzhrrQ920T7K+B3JqkOOuDA9tW753x
         z1fg==
X-Forwarded-Encrypted: i=1; AJvYcCV0MAb8MSTn3vrhQ5KcFQj79ZDlPTqufR7VRTqkZ+AQyNKvg8npwY3mQcrtCZx0MWwXS3LIsLFU5Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9cknSx/QnOUOg8+SwzsUpiWeaDRAKfsnI4VSG+tU+nmct8wC
	vihini2o959bRiUe0FoAI+pjmpIBBMILQpqTfehCwQtaBBRI8I48tC1nSml97haE
X-Gm-Gg: ASbGnctJ25cmn3984364dHTv/xgwaW1c1P0gx60iix2cZ7wxyWlZt1X477BG0zmQg/j
	W1wvouUcYH3ofbA+qtSWCi4kLTv0oU8zG9k8TE+SXecTFm8yhDXSoRP+fnRh+F0DlbKTF8MFHrd
	0AF1fskwnVWuVxmbtuFRWISIJfgYPcXjKdEs9u1eqvl0HWmJcVZqC9234gLKhDVAXPoAhvPNdgG
	yQQ6yTW/BUJ+yZbbfPcxLu4R0FN5s6cs4KeeLFvKf7qJKVY6f/Bmu5hiMvJS1uktBQYP6JtgjKT
	mJ1BPi6CtN9T4FTpMEIhpbqwyjtESX6vVYrDtuXwKMlzKYyS6e5+yVJ+ke33yw2IX9S5Hrf9rat
	zcAlnlai7Qf+KI0VVBOdIaHjp2h8XHeLUKaeP/oB8BUpP7jGazWbHH754du/Mz8/VZYRpGAr9l6
	rtXpLWxOo/
X-Google-Smtp-Source: AGHT+IFK0yDdBhfOz1NBWCKz0vAwOt4g+DxeXHtu06KoBEwHDsyVZU+NDbMVBjZzuCxM5y2NLKriXQ==
X-Received: by 2002:a05:6830:2650:b0:7c2:7b5e:8cb3 with SMTP id 46e09a7af769-7c6d141da8dmr1565084a34.31.1762330729550;
        Wed, 05 Nov 2025 00:18:49 -0800 (PST)
Received: from geday ([2804:7f2:800b:2ea1::dead:c001])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c2448c76sm1804557a34.2.2025.11.05.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:18:47 -0800 (PST)
Date: Wed, 5 Nov 2025 05:18:37 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aQsIXcQzeYop6a0B@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>

On Wed, Nov 05, 2025 at 02:35:28PM +0800, Shawn Lin wrote:
> Hi Geraldo,
> 
> 在 2025/11/05 星期三 13:55, Geraldo Nascimento 写道:
> > The PERST# side-band signal is defined by PCIe spec as an open-drain
> 
> I couldn't find any clue that says PERST# is an open-drain signal. Could
> you quote it from PCI Express Card Electromechanical Specification?
> 
> > active-low signal that depends on a pull-up resistor to keep the
> > signal high when deasserted. Align bindings to the spec.
> 
> This is not true from my POV. An open-drain PCIe side-band  signal
> is used for both of EP and RC to achieve some special work-flow, like
> CLKREQ# for L1ss, etc. Since both ends could control it. But PERST# is a
> fundamental reset signal driven by RC which should be in sure state,
> high or low, has nothing to do with open-drain.
> 
> > 
> > Note that the relevant driver hacks the active-low signal as
> > active-high and switches the normal polarity of PERST#
> > assertion/deassertion, 1 and 0 in that order, and instead uses
> > 0 to signal low (assertion) and 1 to signal deassertion.
> > 
> > Incidentally, this change makes hardware that refused to work
> > with the Rockchip-IP PCIe core working for me, which was the
> > object of many fool's errands.
> > 
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > index aa70776e898a..8dcb03708145 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > @@ -383,9 +383,9 @@ &pcie_phy {
> >   };
> >   
> >   &pcie0 {
> > -	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> > +	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> 
> So my biggest guess is we don't need this change at all.
> gpio0b4 is used as gpio function, the problem you faced is that it
> didn't set gpio0b4 as pull-up, because the defaut state is pull-down.
> 
> Maybe the drive current of this IO is too weak, making it unable to 
> fully drive high in the pull-down state? If that's the case, can you see 
> a half-level signal on the oscilloscope?
> 
> >   	num-lanes = <4>;
> > -	pinctrl-0 = <&pcie_clkreqnb_cpm>;
> > +	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
> >   	pinctrl-names = "default";
> >   	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
> >   	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
> > @@ -408,6 +408,10 @@ pcie {
> >   		pcie_pwr: pcie-pwr {
> >   			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> >   		};
> > +		pcie_perst: pcie-perst {
> > +			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> > +		};
> > +
> >   	};
> >   
> >   	pmic {
>

Hi Shawn, glad to hear from you.

Perhaps the following change is better? It resolves the issue
without the added complication of open drain. After you questioned
if open drain is actually part of the spec, I remembered that
GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
so I decided to test with just GPIO_SINGLE_ENDED and it works.

Thanks,
Geraldo Nascimento

---

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index aa70776e898a..b3d19dce539f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -383,7 +383,7 @@ &pcie_phy {
 };
 
 &pcie0 {
-	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_SINGLE_ENDED)>;
 	num-lanes = <4>;
 	pinctrl-0 = <&pcie_clkreqnb_cpm>;
 	pinctrl-names = "default";

