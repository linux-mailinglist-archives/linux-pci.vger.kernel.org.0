Return-Path: <linux-pci+bounces-41296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 305BEC602D7
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FB8D3444C5
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF112749E6;
	Sat, 15 Nov 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2YytE/h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744A27FB28
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200397; cv=none; b=UzcEWGOjmo8B2Ea4K7hBt0/Ra925vmBlp0Rf5mURD1IkW8VyT17Nc149f0mP2aIPJaVy37qYjBXujvxaymEtj11xJZ+XPZhZGAuKuqWJR7bhQWlEtns5QbsmWp2cUIY0I4CzhC9zY8pcZ02tiVP63Qwb9L0gQnNNBvhN7mbVFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200397; c=relaxed/simple;
	bh=NADkc0zeBGzZkHCvKfmiBGL52ZZ8HLGD8XBHm8M0ToU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJcj5Y73UtGbJ5a3WrG943Jo7cmMG3sGvRuBxU3954Sg+eP9dyzLfUARWHEPSkauv5D0AqTnuI8LH73ofxP5FFku61CUF/xlsec6IKqniCp1UiljiMdzBoMyOy9H4G2UBI7Zt35dmfhiEZJDAEMWp1AXUcpvh4/Hqim5TxnZxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2YytE/h; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436cbb723fso2206805a91.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 01:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763200395; x=1763805195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vqb7SuC6LdXp/wdF4JsayTM+a28625NUpBifotjx9o=;
        b=b2YytE/hvXbldAaK2eAcUzcYrVpCKGgqhuAYqghvgdciK5SzOdCxoqxdT+/8AJHK3u
         0jL1fUTiiyaEH0zLq6MyA/Zi4zjBAd62RrMxDARVrbo2zReoj1jzGZkE91t1Cnc9Lp1o
         Mw47C8wXTagRg3/gkJh0dFyIxES1lq4nJ81UDRKUsM9g76PnOwsAQnPLlzczjf44EhzK
         PdKSGbmin2C/YO8UCNhKmAOKxF54G8Uc+3ZNmPrJzt1qrwjKdoKGWO7gYyMYUywmV1bo
         Nc6QjNHhnuGZfjz8DfyNTtp/b6OgISB1Qb9j7x7NNVuf4N+U2+VXZ+Bn5bFayX+WW6g0
         FHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763200395; x=1763805195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Vqb7SuC6LdXp/wdF4JsayTM+a28625NUpBifotjx9o=;
        b=cwVSKQVyIywAANTx/HrXboPUub1I7/GQHA3sOXi8oxFCYYq8x0Jq9C2Vr/8WnvkEh1
         TPYVps+NBA4Y4JyRgq6ja7J4I3pbVrNObtyZtdix9QSSMjELvFyRQWRBqJnGz1YCKsUx
         vOC1KLB859uM4qpr+4Mv+jLg7uS3z03px5YkkI1UNAuYjfgB5HDvY/9NSELj+UN0JD7d
         XBMOUhMsVlJ8gOY9cgfmM61YSHRUUBfCJy99px7Y0yP/7eKdQUBCNTNjLnFQfFwNOMSm
         9ZlODT+gAz6Y/1nTgXYaG9p7wFEWebmxVNFkWf95znreDth2/d7HdfqwjEXDMhQVSQwW
         HVAg==
X-Forwarded-Encrypted: i=1; AJvYcCVTgfZ3+QC8i9YFpVHFUNKvjw9pb/rdUcL3MKZVY8hteEHbm2F41GuHSPEBCbuNLL+/4gZLakO8E/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuKr8X9XPaeAtZ/xhfBvF7xv54HiPymuSq3fK/PPeirBdVQYg
	ISBAtLdEQQ8tQ2c8bk7U4Y4BSZPmFhTlWHjMTEFLOARbH6bv3gjrBkXq
X-Gm-Gg: ASbGncv5WxKmXvOP6Luy3kXSDczE0qI0RxIqusrfRsC1GTRrEidlKFutDev9hzRvEhp
	jYs2mFhUWVzibvA9vPVe811I7qistv+zqcfeGWfpVh2l3O7DFMNV74xdsqqKwdd53YNodnDaAXM
	lYwDlW9Rvz1MS8pM5wsRShhyVXwysSpL8UD+8gN2m7P3DWAp+aC5iNdN72pqPfqX3LvsMa7PVoC
	mhdeMOCcrAaDNTgQmiKGz624FFYmw0Y7zUu6+j6bejQLmU3ZTsaHqeByRJCWxW41LsGiXHNmYdh
	TGkx4QYWYWJV7TSURtguGrXtleIQ0yELnvFptOOgIpvlRFT2ra7CnO7lQIKgdtPtrUk+mVI8EPM
	JJiaouv2EGu7z/sMA6iFFkEVy/0Pb67255Loku1aUkJvgqPLpCP2ooGxMkI4i5fbLiTnt+1m0OA
	==
X-Google-Smtp-Source: AGHT+IEYodkeyJHv+xttwJ6T2c5dA0IZP7idIsWFckZLeRS6DJQ3X3PmhrR/pJfn24PkyDvZSHZZRg==
X-Received: by 2002:a05:7022:5f14:b0:119:e55a:9bff with SMTP id a92af1059eb24-11b4120001bmr1447186c88.27.1763200394907;
        Sat, 15 Nov 2025 01:53:14 -0800 (PST)
Received: from geday ([2804:7f2:800b:a121::dead:c001])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088625sm20242225c88.8.2025.11.15.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 01:53:14 -0800 (PST)
Date: Sat, 15 Nov 2025 06:53:08 -0300
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
Message-ID: <aRhNhKjneo1Ny0O6@geday>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <53332edec449b84d8a962f2b5995667766359772.1763197368.git.geraldogabriel@gmail.com>
 <3f13841d-030b-0202-61be-412c0ab9df6b@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f13841d-030b-0202-61be-412c0ab9df6b@manjaro.org>

On Sat, Nov 15, 2025 at 10:36:17AM +0100, Dragan Simic wrote:
> Hello Geraldo,
> 
> On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > Shawn Lin from Rockchip strongly discourages attempts to use their
> > RK3399 PCIe core at 5.0 GT/s speed, citing concerns about catastrophic
> > failures that may happen. Even if the odds are low, drop from last user
> > of this property for the RK3399 platform, helios64.
> > 
> > Fixes: 755fff528b1b ("arm64: dts: rockchip: add variables for pcie completion to helios64")
> > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > index e7d4a2f9a95e..78a7775c3b22 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > @@ -424,7 +424,6 @@ &pcie_phy {
> >  
> >  &pcie0 {
> >  	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> > -	max-link-speed = <2>;
> >  	num-lanes = <2>;
> >  	pinctrl-names = "default";
> >  	status = "okay";
> 
> Looking good to me, this rounds up the prevention of issues
> coming from buggy PCIe Gen2 on RK3399.
> 
> Please feel free to include
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> Though, could you, please, add patch 4/3 to this series, which
> would remove the redundant parameter "max-link-speed = <1>" from
> rk3399-nanopi-r4s.dtsi?
>

Thanks for catch, will certainly be included in v2 after I get a few
more reviews.

Geraldo Nascimento

