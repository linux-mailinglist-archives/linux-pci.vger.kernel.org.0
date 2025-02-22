Return-Path: <linux-pci+bounces-22062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7529A4043D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90F6425C5F
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABE3FB1B;
	Sat, 22 Feb 2025 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpS0MyCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875435948;
	Sat, 22 Feb 2025 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184470; cv=none; b=eQFWJoXPhrZDlmgsRazDD9Sdk/PqQYIzj2Z95723rvXa2Eaq24H+Jfeap1U9TPKO0EIX97JWliCNRFwjPT5Nao0Oogdk7bJKGUO9Wui4vT480GqaVkHq2Oqxn5KUOHQFtDdGTeMRLMoJt+bSyquC5/FqeqZdUHThFjspP6iXxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184470; c=relaxed/simple;
	bh=f1vgxh32DbPx0po+Ss3wIsjqVbC9YsEogM1Sg6vonzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbiRR/VsW9G830I8U6kCm0/EXISbhwjHaou3t8B0gqXiOlkLPSH6gWfVlBgeJxAUorCzoRnedRawDi+Py+1/f5xyUKUuYlvLNIqk+XC+1SLsNbF2pN47zWeaXaslMxjXJVsxUTEoudgn6KIj7JeIokROSxGCRY7jh0Opk14NjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpS0MyCr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c04df48a5bso282431385a.2;
        Fri, 21 Feb 2025 16:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740184467; x=1740789267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wStl+6IKZhys/kjLjbrppMxAjOWicsS14gQYbb4jIcI=;
        b=bpS0MyCrrB1IGS7WfgjfJgh7Vo2IK+mRjTRBay3745x9LiBgHSJF1uN2yAlnUvVj77
         hYunKAJSdyDCT0EIVxiCoVoxRJg7G+yKRV73CQXyGB36LHTHFOyFSmYe1NvduHYrt4vZ
         9eheBCmP57Bkjnc+sOAzGLAUllVcIrA/4vUXTDsDL+TbJbkECdzWsI0TuudfUtlZzfOn
         sJkE7FCJSaVswye3nckiYf+RNsy8KU5ZaSBCFQnzLUuN8pae3dbe2RzX3Amqw2jqiYV0
         w51FkwzVoF7qfqFAfixlYLIBMvKQE33BSUbOWm6ezf97lBFlslFtYiGtBOy/HddqRd85
         dfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740184467; x=1740789267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wStl+6IKZhys/kjLjbrppMxAjOWicsS14gQYbb4jIcI=;
        b=q1eTdgK5kFZwbn2PsdG2oMZKGz5V5k80pCiY+uJOpZLRnrPS6ef6h112uAj5kdnfGJ
         IedxldjT0h0n3cvs8BSMSNADFFlKtzOwx0I+p/haTBUPR761/SHyF3yZxTwZaOBfN8FY
         /05uCrE2mQ4CY2fRK/wpl3mV8eOSSPLyc20W16OGInknr8ppiVCvBKTsfQMsoenVj+qm
         +e+nQiJcWN3UF3noLjieEVPc67IotBMLCdcD9aH50U/CrEUCn48I6T6NjdW7NQ6JSLlz
         Rmtje1LWWujEr2g0WYTWcM1BduvPS76+xMYxNt9PJd+5eubVt52aJMqr4N4qyYW8lbW1
         XmSg==
X-Forwarded-Encrypted: i=1; AJvYcCVbehary3H7ORD0XigFbrjo8d4is2E5aBAHSTVOSLFQPPhVh/rdz0MsOHumLH2fgKB6mR8Tta/Sa8Qq@vger.kernel.org, AJvYcCWDKo8F5womTlHrlP1BnHWbMnsZtzULCKW4QqXcix3id1MQt9oUG830h36Js4DL2pi6nxNFHOKs69Sc8oYu@vger.kernel.org, AJvYcCXkEJpSSYaGDagGXWUeW6IBgi0LhOX5xupr+gtB60XZH/P50GbrBYAmgoRhH+1K06F/1F129x4ap+c1@vger.kernel.org
X-Gm-Message-State: AOJu0YxEhgvTvP94B25VzP0SGjiRAi/0ev9k/qkTVcgMnPR5/WrVIzeK
	20okYuvx80eKhp3Gnv/SxMbJ0fGYsGnh586BUqnjMDeoHrSuiQDf
X-Gm-Gg: ASbGncvg9O6CatkW+yyFlec16T7XrdSgEh6z9Znb0e+2KFHM0GZXLRe20LSqKT5ZVG4
	IKyFSPz2u05nf1C3+j4xw0bNxXCS7LnbSW22b19l9s1qHvTiyo7fAGl2TMJj0gYopkh0LM2UJU8
	Df0FBIGgzSFmpYbhSilU6BiqZv5fGd+ibFJEUSTgS0cjt4/+iUmOF2ZVLFIiabNMCCir5yCmt3t
	l8OIh6IzaTv+0VJInnBbCYSrzWRQivbHid7AdcF3CFxglAHvwCfgHcByIgVQRDo0n/8DtFmA8BH
	NQ==
X-Google-Smtp-Source: AGHT+IFHrDz0qc8zD5XdcpfmhF3hdDGMdxF6JouYGWlJZR7lIXsOACUUisCSrhGBpwJguI83XxPhyw==
X-Received: by 2002:a05:620a:1910:b0:7c0:ad3e:84a7 with SMTP id af79cd13be357-7c0cef1255amr657209885a.26.1740184467296;
        Fri, 21 Feb 2025 16:34:27 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c09619fbfesm721817485a.18.2025.02.21.16.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:34:26 -0800 (PST)
Date: Sat, 22 Feb 2025 08:34:10 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Niklas Cassel <cassel@kernel.org>, 
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Message-ID: <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-2-inochiama@gmail.com>
 <20250221-cavalier-cramp-6235d4348013@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-cavalier-cramp-6235d4348013@spud>

On Fri, Feb 21, 2025 at 05:01:41PM +0000, Conor Dooley wrote:
> On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wrote:
> > The pcie controller on the SG2044 is designware based with
> > custom app registers.
> > 
> > Add binding document for SG2044 PCIe host controller.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > new file mode 100644
> > index 000000000000..040dabe905e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@gmail.com>
> > +
> > +description: |+
> > +  SG2044 SoC PCIe Root Complex controller is based on the Synopsys DesignWare
> > +  PCIe IP and thus inherits all the common properties defined in
> > +  snps,dw-pcie.yaml.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,sg2044-pcie
> > +
> > +  reg:
> > +    items:
> > +      - description: Data Bus Interface (DBI) registers
> > +      - description: iATU registers
> > +      - description: Config registers
> > +      - description: Sophgo designed configuration registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: atu
> > +      - const: config
> > +      - const: app
> > +
> > +  clocks:
> > +    items:
> > +      - description: core clk
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +
> > +  dma-coherent: true
> 
> Why's this here? RISC-V is dma-coherent by default, with dma-noncoherent
> used to indicate systems/devices that are not.
> 
> Cheers,
> Conor.
> 

The PCIe is dma coherent, but the SoC itself is marked as
dma-noncoherent. So I add dma-coherent to the binding. I
wonder whether dma-coherent is necessary even in this case?

Regards,
Inochi

