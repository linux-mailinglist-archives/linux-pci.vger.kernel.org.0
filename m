Return-Path: <linux-pci+bounces-41297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CAC602E3
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE1BF346549
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC282820C6;
	Sat, 15 Nov 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmi2y0fU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D02280CF6
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200565; cv=none; b=QSwRgwsiurH3dCwltnI3vHegy8Mmt+rDHND2AqfvmvUeIlzC/qDpMq884bDC+E+YeCagEqu/gACfZRGV8f4V99LEHW2+FryEXTpPQJnr6RUDmGw36PujpTEIi6kxHmmT5xp/dmddoQdCZ6lvtOIdpTXSDNBp+nFOGS9qcSmhLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200565; c=relaxed/simple;
	bh=5vAa/AvCQcXHh91WW/DQKgMQwmnitPwp4p6M47M3aOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUPCItHyXDylEvv3ykVsk7uTNfSvdtF0T75OyxZKOikIK7gX0gZxNsIdGSIIhp4sj+D5qj0JqLt3aOTcciJGIBTKh571Ku7JNzCe02z4B2uEY4NCvDcyyrXG9LMx7qGbfgkn+tzOZZngvij1UH1k33ugURq54DhU9CTfk+SGhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lmi2y0fU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2032103a12.1
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 01:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763200563; x=1763805363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXnS95zIUe4oTXytX7J90dCvdMH5uRG/iOxKBN187eo=;
        b=Lmi2y0fU3knXha93y7gAerUg0Ub9Qbwle8M32LNcHqgfo/Ud1PrwvfTj5hnCt8VjFX
         h6ejmIYL6qt0BPxQ5xDc9JaiVihzCz2HpdyLenC5YhpfZ5cIiaX3uGX8ZouYX2OSAOvx
         ZaojaIpTgPfEDcMxlfgsP6XCosXO+WemiDIEJMiG0TRsL7FwyH3bd44KzPu6yp0ZaRHd
         N7aIqb3lrwRpCmngdBaMENnG39F2dC8PMRpJKNkvL0nLKJVjFUITqWrMV3m7RHZayXsD
         GIuzDo15+u9FiCd1zgMf2N6SckA2zlRsELch6RjybwGHkA5UzsLnXEv8UMAfPG3s+ywd
         6Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763200563; x=1763805363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXnS95zIUe4oTXytX7J90dCvdMH5uRG/iOxKBN187eo=;
        b=paI7gMkWI8aEl/HyD6D3YAV9fvyWfbdXNvjHm/67YG9IbkbJE7aN8aJJI1FJkMrwTx
         Rd27LgTkEEHz0XxOcfTtdG4/JPExLRk4YBvjyV/IOaxrh0BY2Kz7oMnqH7dip88vjj9u
         i7NhOEAXhbBW1b9+ZgyM+okn15E3eztkRexafmmAAacMd8rajjbWvoXSN+ffJgyIegyP
         WgQ+jlzvvrSF3B98ertGE/A/+1rTny40UKJlnhg9DtF/EfBW+CsojWmy7jVRS0eWwm6C
         7D+EyRSCutheytPdEgPFR4GR6IFybErZwdi+RP+JeZTeuY/CFWPMWLlcPTexFcVmrIfE
         Pz0w==
X-Forwarded-Encrypted: i=1; AJvYcCX8EcYZlrvnWXivJwqq/pt99jijwJcnRtHHpbbErTI9cKr0GxhcBbxhgaZ4kWEIu30W6QIUBwHVXI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2eza9tdV9awEBVIyGUcmHRdoQT3uMhVXi2TJU7rpwxROJVHw
	fQOTucisb//X+E4LeLEQ6mZM80Tm1vkpCSczSdSVTsPWHWRLqsczJ10A
X-Gm-Gg: ASbGncuNSS7cX+GPxGU3MMsMCGdM6/izDPgov+uIZ/6nzTp4nGBxl5MALw9rowLp1WH
	3UbSofmD/iuxA7eYJ6iNqbTty3kQhQ2YEgmCyaoSgs7175EYlH0c06jkDKArChGIe2tiFI3VDtt
	8xFYrWUGGGY3FaEldjs5SJZ69eU/BeeKqIatAmsUeD7TE0Dx9fqbL/8as/GVL+mOjoUP9neUWCZ
	kESDJ9pxYAupGRRwBIqZ9vaBSRQCd+KI7+IxT/q2Lb2oEznY1y4uLWxeF3LXLv9fnIZHc40HVqe
	qvc0kDybVtk4vWDG2Ty6nyryh4gw9J7as3FZgYPe/jWqwm7/9Na/hQFYw6S/jZ+RdcoIHUanC0H
	HxN/mIt/QEmPJOu4zntVNag0akR3TuxRPBAV/PN6ZVXdqR7HQZgYacu7nW73XalkdhZWK5tR2fP
	G5HSBggwpwVEzdsd+44pc=
X-Google-Smtp-Source: AGHT+IHUlupuM7szZcYDg9/TlMwVZ71HSLpjpZExx6vY1jp09oOh8FYjiJ3nZkXQKy+o63KI20P1NQ==
X-Received: by 2002:a05:7300:ec89:b0:2a4:3592:cf6d with SMTP id 5a478bee46e88-2a4ab8a9516mr1719763eec.17.1763200563112;
        Sat, 15 Nov 2025 01:56:03 -0800 (PST)
Received: from geday ([2804:7f2:800b:a121::dead:c001])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db102f5sm16240515eec.4.2025.11.15.01.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 01:56:02 -0800 (PST)
Date: Sat, 15 Nov 2025 06:55:55 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
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
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: drop max-link-speed = <2> in
 helios64 PCIe
Message-ID: <aRhOK_aDoJYfgbRJ@geday>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <53332edec449b84d8a962f2b5995667766359772.1763197368.git.geraldogabriel@gmail.com>
 <3f13841d-030b-0202-61be-412c0ab9df6b@manjaro.org>
 <7d300769-9803-9c0c-60bb-4a724619d8e0@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d300769-9803-9c0c-60bb-4a724619d8e0@manjaro.org>

On Sat, Nov 15, 2025 at 10:42:40AM +0100, Dragan Simic wrote:
> On Saturday, November 15, 2025 10:36 CET, "Dragan Simic" <dsimic@manjaro.org> wrote:
> > On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > > Shawn Lin from Rockchip strongly discourages attempts to use their
> > > RK3399 PCIe core at 5.0 GT/s speed, citing concerns about catastrophic
> > > failures that may happen. Even if the odds are low, drop from last user
> > > of this property for the RK3399 platform, helios64.
> > > 
> > > Fixes: 755fff528b1b ("arm64: dts: rockchip: add variables for pcie completion to helios64")
> > > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> > > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > > index e7d4a2f9a95e..78a7775c3b22 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > > @@ -424,7 +424,6 @@ &pcie_phy {
> > >  
> > >  &pcie0 {
> > >  	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> > > -	max-link-speed = <2>;
> > >  	num-lanes = <2>;
> > >  	pinctrl-names = "default";
> > >  	status = "okay";
> > 
> > Looking good to me, this rounds up the prevention of issues
> > coming from buggy PCIe Gen2 on RK3399.
> > 
> > Please feel free to include
> > 
> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > 
> > Though, could you, please, add patch 4/3 to this series, which
> > would remove the redundant parameter "max-link-speed = <1>" from
> > rk3399-nanopi-r4s.dtsi?
> 
> Sorry, I forgot to note that the patch summary would read a bit
> better if it were reworded like this:
> 
>   arm64: dts: rockchip: Remove redundant max-link-speed from helios64 board dts
>

No, I think:

arm64: dts: rockchip: Remove dangerous max-link-speed from helios64 board dts

Is more accurately described. With focus on the dangerous, we're not
liable.

Redudant max-link-speed only for nanopi-r4s include definitions I think!

Thanks,
Geraldo Nascimento

