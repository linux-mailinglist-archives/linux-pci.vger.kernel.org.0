Return-Path: <linux-pci+bounces-40383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5FEC37A05
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 21:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551ED3A9630
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 20:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D15D267714;
	Wed,  5 Nov 2025 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKoQGAoa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0BB246BBA
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372951; cv=none; b=cLbEGZHjqEGcpfppQo61Qp+5hvNnjpSzpVJ4Zan0I+22k7zauRDC5W+MaQEOc6evo2foRd6POShOVqzi0UuQusuZCYvNgglElWVX2SS4nMCakYgBDBsGZGlkOPkC4gKrK/YdKXf4WjnmHyclrbi29Z0ec3cXlZSqB8EtTbSyBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372951; c=relaxed/simple;
	bh=I+cyU1YsuCr2HvX/C46SKQfA6kkVDFrXjoT7BMxk52E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF18zmvXKmDNScfciNnxYhQMlSytNKYxloTpPDgbm/dwD9SFOE+xqKbwhBOD+Rt82w9HpxnGi4xCGKXZdIBrZuPULOyDAGKPTx/zNivXc375yEVcdT9SXc4J9H+XKS1EtCpaq29IiQVOWwKBkSl4kwZowEwLbcbfeEetXhqhpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKoQGAoa; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e0e4601faeso140446fac.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372949; x=1762977749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2WgVh/W2QDlWrUEp2DhJYyH+fmgYqOSSyNzgizd879Q=;
        b=LKoQGAoa+0ILCUoKQJsGPVqJRjm89fhu1vhyQ++IJs3+kSQdOcq3BBmwvxWjMYJAGk
         J1IM5PYDgHrjvuTLinxxtGNTVoAfxrH81y8sbWRYpYGABiozK8ueQztmH+ndkTUrKaVT
         zKpUOTIjSz9lKozW16NwnrXeUJ3dGCAgC4rl5kTl5VstpcYvdXdas4E54HVtjxx2Jpfl
         u/CYj+DOwGNUonzsjwzy3Wt1ziZhoQaCsgvlq2E6k8FdZJ1SD1oassd6W58qxxXRO2fJ
         0WKavJBAUiOI3wrIovSp+WCPxzbb9gWQWq5ww5wUKDMQr6NyjEHcJgir24JKOYtJAp6L
         txXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372949; x=1762977749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WgVh/W2QDlWrUEp2DhJYyH+fmgYqOSSyNzgizd879Q=;
        b=MgmjFHVYoxPdpQXY4vNd5JFjr9CMgzMWuUroZpmmVbIdLOncS0p56up3Fq2b68kCEB
         ETz4HVz0SeYfNRGS3/LhCHakKFaAFVbPivzKkzqw0fwUQyYDkkKKaVJRnPEM0f5efF8b
         U/heUYWm13K1Bu2/nYwl4F5CZclGjp6DtYlchvDXIScAoaF6kCBa+GDGOi7mpmeF2XKH
         mhcECIKzvA8XLKo0Hv7D2QmSBp5iwUavlrZeEEt2dSQ7w3LGPlwfDDhBfjsOH6R4q/e6
         HGhFimG28vMPRnsRWWpMcqRYWKfgtg1uk7WiX5ZOl6op9IXUJYF10GOM1p7M5z2W9Gy/
         xlvA==
X-Forwarded-Encrypted: i=1; AJvYcCXS9PzwC3lp/qAOXDKuweSQG73Ks3Pma3H1JCx5LM9FhK4O7UqeEXdCT7gdw2O6luCyZcCPIQ+/tsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGIj+dShRq76+DWzDEzpWf0E7dUXk9sBWVw+aSS3Y3XF2nkKq
	yPhCQf6B3fAp9eDsFsvVr/VksxJN+Zo9lCp7jUBAfwtauB5MMx1jQ262
X-Gm-Gg: ASbGncuwaYLAg6L5Lw6kY4InbhQ/8prZ9suh1Bsdh8mlNbrf9Q3FSLTLEZ1C1vnpl1L
	zJh3mQr+v2Lup6iOo5H2lVOoMHNXO9tFMkVXWlA6SO1ERSTFRXhAdzL3TkUVYXIp4r1BUk9RSS7
	yYPdT0JY/XUE1slyrLqX+2xJmsuGi5FsJl7mjU73CyU22C5Rl7M1V3IQoPwpQA7wwdG5M7DHz2C
	7Nn4VN0G9LsIg6lN83FTiINmzdxI6iuXwmrHYTsNkqvCeI+csqoCXL2i8Al1VT75Ka3cfmkj7p6
	14Cf5Tf3QEaSpHLOsUa5VSHivlSohYTrrMrnwUUh5aTdFY5j8fdimMF6a0TKy5MFvmHLXwey/fC
	hhMMOt/HOKuvSQZSG+8KHybiZAfrMFxSnUhm9JrkB14So2x9P7kTu1owP7/ilS1s=
X-Google-Smtp-Source: AGHT+IGSwk5bgvA4Oe45ToOFpKJoB2+FDTxvWYOBhAfgVYBhwy6jRCcKmE2cTHy1t1Zs4TzsM6oc1g==
X-Received: by 2002:a05:6870:80d2:b0:319:be1e:9dce with SMTP id 586e51a60fabf-3e198e539f7mr2033360fac.5.1762372949003;
        Wed, 05 Nov 2025 12:02:29 -0800 (PST)
Received: from geday ([2804:7f2:800b:2ebb::dead:c001])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e30ab3f772sm53209fac.20.2025.11.05.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:02:28 -0800 (PST)
Date: Wed, 5 Nov 2025 17:02:21 -0300
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
Message-ID: <aQutTbzS8rfW-Esm@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>

On Wed, Nov 05, 2025 at 04:56:36PM +0800, Shawn Lin wrote:
> 在 2025/11/05 星期三 16:18, Geraldo Nascimento 写道:
> > 
> > Hi Shawn, glad to hear from you.
> > 
> > Perhaps the following change is better? It resolves the issue
> > without the added complication of open drain. After you questioned
> > if open drain is actually part of the spec, I remembered that
> > GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
> > so I decided to test with just GPIO_SINGLE_ENDED and it works.
> 
> 
> Does that work for you too?
> 
> &pcie0 {
> 	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
>   	num-lanes = <4>;
> -	pinctrl-0 = <&pcie_clkreqnb_cpm>;
> +	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
>   	pinctrl-names = "default";
>   	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
>   	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
> @@ -408,6 +408,10 @@ pcie {
>   		pcie_pwr: pcie-pwr {
>   			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
> +		pcie_perst: pcie-perst {
> +			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
>   	};

Hi Shawn,

No, that does not work.

I believe the pull-up mux became needed because I was forcing open drain
on PERST#.

Thanks,
Geraldo Nascimento

