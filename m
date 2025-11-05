Return-Path: <linux-pci+bounces-40304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF51AC33E21
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 04:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D07B460E55
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 03:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6AC248896;
	Wed,  5 Nov 2025 03:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix+qGux8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265D207A0B
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314950; cv=none; b=cDOiKKRC2DU/C+4RSmzA3tninwFDHNCv9Hdt16QE1J8xfsTLZvsD6qDRDGVGm+Zc4fZFKu06XjTa+8Ixm2pi+eo+wm7BpZ2fLb+e0+crv6Kt6oqi4gjy41tYLb3TlvVWMWzbUMc3b+lOWMrHz4YyKmSm6n/SzOTDASZBx5Ym5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314950; c=relaxed/simple;
	bh=9bhjtePjRrbj8EC3xZaIGYeGQ11DMmV6Drjl2KxvH8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR9Ht0Ji+Zu8Z8vkK1aazLjWpcdsPTPibfvQu4N0z1umT785LFVpBX7puRWjPlEj5wg02aoiJWbWSwKJdAKW2kCtDKs86V1z+vtSGaHfZTNZaMSKVBq3xJMoRYozed345/cg/ZJZzALHaUjatEOLEgwSfhQ8epAVVPFnlib/MU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix+qGux8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c681a8aecdso3576654a34.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 19:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762314947; x=1762919747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wv7IaACCUzIWH4jmcnmsJlWAx3z3kfU+CsmKqPSjqn0=;
        b=ix+qGux81JQxQFlkFd+tQcVM5QrPtlu3NRhPVaL8TsEX9H783TtkqN3DM9im+MOIEs
         A65CIRn9MOeArx1a7HaH7NJO0CUnnsrePWnaBEoXd20Z4IN5JyIHZiI2R6n+oyOL1cq+
         Slr83BUDuXODjId67kyZWpA34EP5e5koz7mTmA9BGTbcQVuSFZvFx3c8quWIqGmEsuwa
         foAtDPWQmrVHRSQt+rUPWpe/YyrCwh5/tzX1B9NC9gDBUnZkWwkxTTtpacbs4z1299ag
         +algedrMN4IG59JCLo1xLEWXrJg8goKUDAX6DxIDM9OopMvBTUsv6tv9kvUNIs/1fG1z
         9k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762314947; x=1762919747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv7IaACCUzIWH4jmcnmsJlWAx3z3kfU+CsmKqPSjqn0=;
        b=JAKfVjN2mIRgIOv0SSUOc9dOTPjTGuvSPjkkQPDU211UhCFH35z6j8OIqirF8QmDpr
         XP4nadP4ea/L65rOcu2wbPXKNMducafUSZRasQuri0iPQdLZFDDSsp3OL1A1rNFOITGf
         GFLV5K11uaB/uy0BNeyzmV6Tg5KLd/v5BhCB2tJ2J9AEwcr1YIEwRscBPL2kGcN2JQZT
         4zLO7jQvySxbw5RTHbWYu1Ug2K2rouo7CSTYrSPSEz8wk+GnphhnPpq2QjufigT0P694
         YfnOsL9kPuuCgVRo+KjByqHB4/G5gR+L3xuyz6xerQC/A5wMhMuKdOrL78fDa47Kf+Vj
         2gUw==
X-Forwarded-Encrypted: i=1; AJvYcCWvT6tJ0nKNTysV6h7fbSxGe6VQ/6TjNPBaGwIg8nyDLxrbSy3lTx3CukOLYqdfqRKX50WAViUc52U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4mvbcQTopMpIG25nRG3OaCA1xaeabsERaufyvrEBYqGRtv/Y
	QC6n3Qt155gtMAUGioo8Mt3wBdtOqO8Sj+nImKyCVHvRMQ/dWsXX3eFj9qCGpHn/
X-Gm-Gg: ASbGncs9S+vRUwyWWWSudQ4JhUWspt/FMKnNkI38XT0+YQLhirInumLPzC1ZzZn6tam
	hy0Wby4nQ7JZkn/DUEH/YfSCVELqAdtINEcxpbsZ0YSCBVoxm1o5ESph7yLjkUrp2SCzX3PEKSi
	gL4ORAuHcXSW0dpJ5gx35RVB2uSIHu9HNMZqorxEWyY5IC1Hrer//6H9V45rpl8z+DAxdDOevVr
	aSSBo20VFMihlED6l41W/oXMQesGTEVDiItDQj6L0WZoEZpKgY7YANCMOjJLKbkUywEWwv88RQF
	CXhL6Dr4GLtNKPU9b04JBJLYqYZXSoR+ECKWMpmgNkKECg5lrKgXuN9FsqyWjiTnG3VAoPrfscM
	sEHSo0s+qpOKUfMQX4Zdh+mwEPYj+Ai6hbgab1Gh8+C1zrFjm1MCHvelOYT9aTIo=
X-Google-Smtp-Source: AGHT+IGWD1WRog8lycQihpGXGLWzNtQQjp25qDmoblZFd4CJMmxeCSVNZEnsc+5uJPofTa4YPXd5Fg==
X-Received: by 2002:a05:6830:91a:b0:7af:1d61:1055 with SMTP id 46e09a7af769-7c6d13e115amr1105444a34.21.1762314946928;
        Tue, 04 Nov 2025 19:55:46 -0800 (PST)
Received: from geday ([2804:7f2:800b:2c34::dead:c001])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c246fb2fsm1599542a34.13.2025.11.04.19.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 19:55:45 -0800 (PST)
Date: Wed, 5 Nov 2025 00:55:32 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: rockchip-host: drop wait on PERST# toggle
Message-ID: <aQrKtFT0ldc70gKj@geday>
References: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>
 <20251103181038.GA1814635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103181038.GA1814635@bhelgaas>

On Mon, Nov 03, 2025 at 12:10:38PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 03, 2025 at 03:27:25AM -0300, Geraldo Nascimento wrote:
> > With this change PCIe will complete link-training with a known quirky
> > device - Samsung OEM PM981a SSD. This is completely against the PCIe
> > spec and yet it works as long as the power regulator for 3v3 PCIe
> > power is not defined as always-on or boot-on.
> 
> What is against the spec?  In what way is this SSD "known quirky"?  Is
> there a published erratum for it?
> 
> Removing this delay might make this SSD work, but if this delay is
> required per PCIe spec, how can we be confident that other devices
> will still work?
> 
> Reports of devices that still work is not really enough to move this
> from the "hack that makes one device work" column to the "safe and
> effective for all devices" column.
> 
> It's easy to see how *lack* of a delay can break something, but much
> harder to imagine how *removing* a delay can make something work.
> Devices must be able to tolerate pretty much arbitrary delays.

Hi Bjorn!

I did some more testing, intrigued by why would a delay of more than
5 ms after the enablement of the power rails trigger failure in
initial link-training.

Something in my intuition kept telling me this was PERST# related,
and so I followed that rabbit-hole.

It seems the following change will allow the SSD to work with the
Rockchip-IP PCIe core without any other changes. So it is purely
a DT change and we are able to keep the mandatory 100ms delay
after driving PERST# low, as well as the always-on/boot-on
properties of the 3v3 power regulator.

This time everything is within the PCIe spec AFAICT, PERST# indeed
is an Open Drain signal, and indeed it does requires pull-up resistor
to maintain the drive after driving it high.

I'm still testing the overall stability of this, let's hope for the
best!

Thanks,
Geraldo Nascimento

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index aa70776e898a..1c5afc0413bc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -383,13 +383,14 @@ &pcie_phy {
 };
 
 &pcie0 {
-	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	num-lanes = <4>;
-	pinctrl-0 = <&pcie_clkreqnb_cpm>;
+	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
 	pinctrl-names = "default";
 	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
 	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
 	vpcie3v3-supply = <&vcc3v3_pcie>;
+	max-link-speed = <2>;
 	status = "okay";
 };
 
@@ -408,6 +409,10 @@ pcie {
 		pcie_pwr: pcie-pwr {
 			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
+		pcie_perst: pcie-perst {
+			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
 	};
 
 	pmic {

