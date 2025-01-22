Return-Path: <linux-pci+bounces-20245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB9A1976F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B716292F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF121505C;
	Wed, 22 Jan 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugJhGNWZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538516F8F5
	for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566493; cv=none; b=gnt91CzYeY4fPDxwUNhZsKBl8cQx/iK531AzelKclsk1gTAjJ7uvrNPt5Oxy5KmnCrwiE5eq4ojpgNGme+abM+YFTN28rWe/Io/mTaSeVELreLqIcMs9SpJVuaNeED/qjr0XOy0UeYZKT5LyNP5F9U5RKks2pykcoZ4X9YpgTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566493; c=relaxed/simple;
	bh=YvxTWju5gHhFPFewE6C8FEhCR4psxCplhF1a9R/6gbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCEpJ5fcrdDCiL6SB3BXjUeSP0sy0gqSIMF1DqaYBQVA9VOuqhGCfvkL/5r3kDEr13Atz5Vk3NpZ9pzczGTsBtBX3IOsXnKl5QSP1ajJ3bOYpehS02GesMof2s08YzulaXp8ZEnv5vtejtOznWWkYqfpNAuZsvCdW99QM8slQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugJhGNWZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2156e078563so96165655ad.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737566491; x=1738171291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ae3fiG65q7gFADRkugXEjBLy3kEYsGVZg1VWFTjZpLU=;
        b=ugJhGNWZwSkukJJsXyUJeCgftu1qZYgm/CGMINedz8NoYogh/K6uuJQx4bfNN5+RJW
         28BQMWZsN/ZX9UwRX1LCqbF7UzdHWjDtxQILivqARUgrpmOHxdxPPR17fT1ACoLx2Cq4
         Ccr16skiQHiTfXerHC7BjmtTMShJiRR1cLbLME7ZOn/bhf2a5TmJFuF9vlbva6bd0R3G
         6p5DGr7CDyO5P5ua/nBAgzIV8a7l3kjSsYU12c9GB4E5FM4+8+Wo9u2yoQX5J8n4mBsr
         6BwUVqIiN6VF03mdrer5mD93oRyQgqRPBGaDBE9ahBUCAu/a2ZKfurkaeQU/4pcvHg1Q
         2MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737566491; x=1738171291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ae3fiG65q7gFADRkugXEjBLy3kEYsGVZg1VWFTjZpLU=;
        b=TtK9yV3A6ZDGkmqwLiuZD+nIIH0bajRcOdBw0TIOeI96WvIQYcCeo1UKBJiUeNXk9r
         gAPgGA4VUkDOYPJHOccDjNG9tOFhg0VWWYQ8WJ0mUKLAanuiSJFoGEuom86J0Tutbh2s
         HkNaVTOjvAJuWs9POAkNa8sPoiI2PZsRA2yim9/WmeOPNWfsdzA3NJrLRREYT8Kbiu6G
         yBlRr+P/++xWSEJudLrnFFSc6+AjWFHwb1t+qqFPqx5d5yyVMyBRcOWUCnVAHAWF/HXH
         CJ9l0BOuNIHTk+2enhkEFNLkq1TQRdDtCtLHpMw4E52lkrzhkG3y9aa3fjQVtU7HHSXQ
         ov/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaBuRJ7Bza7dsdsp3fLASkxn2KBGoKHoFPllqytGYrkFrGNvRxYif+sqq+1tD46HNWUsAfR+y5peg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QsJ5u9tyI7XFytZ6bHJ6n20KiNB81vW/kysJ8/ZeoxfyqhoE
	VPIPNspTnhvtfk3zLmrR0iFk428v9ClqETee3HkuERFiWc/WHTp12BZuWO/5XY3egi51T0F8cM0
	=
X-Gm-Gg: ASbGncvkzgIirgDEw1yAngN/wi6UEzvC/YejoyIgwyV3JaFiGbFPfwGvbaj33I2PNks
	8ZcnpPeOYVXmWpVvIl46/GXMeAIhiOmVUTP3Vw4datDF5wQYUEbse5NfGOWG2CEKKslbB3kUdLo
	h3TNJQLIykfHq2Qhpvs7DzE1qTOdUyPZCqqweOHKg2OA1WdfY/XzuwRErld31rBdH4mjTo9yJOz
	ZpQcZyRgqZ/1VHIQcTzqkQzr45TFGH7yaTa/s8zBOu26hFDb8TRLlz228yXWX2tG3F7HbryTAmi
	/5JO
X-Google-Smtp-Source: AGHT+IEkqigOKLMCrs2YjDPNBFNeQyHN25V8kKjRdlQokTEi1k6FX4K8bd/jugJsCnORbh0uNOzVgQ==
X-Received: by 2002:a17:903:32c1:b0:216:59ed:1ab0 with SMTP id d9443c01a7336-21c3555847amr277588575ad.27.1737566490907;
        Wed, 22 Jan 2025 09:21:30 -0800 (PST)
Received: from thinkpad ([36.255.17.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3d6fbbsm97942345ad.168.2025.01.22.09.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:21:30 -0800 (PST)
Date: Wed, 22 Jan 2025 22:51:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
	inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	pbrobinson@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20250122172122.vquwlodeyjpkx6gs@thinkpad>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <5a784afde48c44b5a8f376f02c5f30ccff8a3312.1736923025.git.unicorn_wang@outlook.com>
 <20250119114408.3ma4itsjyxki74h4@thinkpad>
 <BM1PR01MB25450B47C36ADE01F53CAFD1FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BM1PR01MB25450B47C36ADE01F53CAFD1FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Jan 22, 2025 at 08:52:39PM +0800, Chen Wang wrote:
> 
> On 2025/1/19 19:44, Manivannan Sadhasivam wrote:
> > On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
> > > From: Chen Wang <unicorn_wang@outlook.com>
> > > 
> > > Add binding for Sophgo SG2042 PCIe host controller.
> > > 
> > > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > > ---
> > >   .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 147 ++++++++++++++++++
> > >   1 file changed, 147 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> 
> [......]
> 
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    pcie@62000000 {
> > > +      compatible = "sophgo,sg2042-pcie-host";
> > > +      device_type = "pci";
> > > +      reg = <0x62000000  0x00800000>,
> > > +            <0x48000000  0x00001000>;
> > Use single space between address and size.
> ok, thanks.
> > > +      reg-names = "reg", "cfg";
> > > +      #address-cells = <3>;
> > > +      #size-cells = <2>;
> > > +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
> > > +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> > For sure you don't need to set 'relocatable' flag for both regions.
> ok, I will correct this in next version.
> > > +      bus-range = <0x00 0xff>;
> > > +      vendor-id = <0x1f1c>;
> > > +      device-id = <0x2042>;
> > As Bjorn explained in v2, these properties need to be moved to PCI root port
> > node. Your argument of a single root port node for a host bridge doesn't add as
> > we have found that describing the root port properties in host bridge only
> > creates issues.
> 
> Got it. I will try to change this in next version.
> 
> > Btw, we are migrating the existing single RP platforms too to root port node.
> > 
> > > +      cdns,no-bar-match-nbits = <48>;
> > > +      sophgo,link-id = <0>;
> > > +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> > Where is the num-lanes property?
> Is this num-lanes a must-have property? The lane number of each link on the
> SG2042 is hard-coded in the firmware, so it seems meaningless to configure
> it.

It is not a requirement, but most of the controllers define it so that the
drivers can use it to set Max Link Width, Link speed etc.... You can skip it if
you want.

> > > +      msi-parent = <&msi_pcie>;
> > > +      msi_pcie: msi {
> > 'msi' is not a standard node name. 'interrupt-controller' is what usually used
> > to describe the MSI node.
> OK. I will corret this.

There is also 'msi-controller' node name used commonly, but it is not
documented in the devicetree spec. Maybe you can use it instead and I'll add it
to the spec since MSI and interrupt controllers are two distinct controllers.

> > Btw, is the MSI controller a separate IP inside the host bridge? If not, there
> > would no need to add a separate node. Most of the host bridge IPs implementing
> > MSI controller, do not use a separate node.
> 
> Yes, it's a separated IP inside the host bridge.
> 

Ok.

-- 
மணிவண்ணன் சதாசிவம்

