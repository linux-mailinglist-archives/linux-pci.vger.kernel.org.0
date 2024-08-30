Return-Path: <linux-pci+bounces-12522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D98966678
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 18:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4DBB21BD0
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02B1B2514;
	Fri, 30 Aug 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozvsHKKN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5B4D8AE
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034000; cv=none; b=GQGb/xiJr8rkUeU67iYtMpbZUqUtpLQNkL29tQEVZ8yrfdaIU3xGVozg2sKY9Buym1awq/6U7ltnPRYsNbogT3oBMz6dOztpivG81aizbEtNejdOO5FkoxslHvPYm/CCSZUIMDB6TrTJgrUP/JactqI2yjoA4SswcWYxAKUF5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034000; c=relaxed/simple;
	bh=x2eRVw7zAUbJktENwSnhnXTQtRoytJ0beFbrqUk/4PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADGPIfDwWXbyyE3v3OYC6VFdpHSWdMX/diQDuoY2CSZx3jyiFVOIZ1gUgtXVFlYOAHP34XgqyOp+5nMfr+/3Zs/OO3H8Lw5xNsWoeNED0QyNOY7poqEFFzi4U7woaMoizK07b0OICwD+I/Y+UvXp23bd42F9QB6lJPcoLVRxldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ozvsHKKN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71433096e89so1707309b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725033998; x=1725638798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JGphCA+jPiPvJub7Pk4t9JSGEtZkdQksxUPkcPLMM2c=;
        b=ozvsHKKNteyF9i7yOPNt+HVAWRFUonVaMWAvtjg5EHIZriHVGolSyoEoBNU/bn3IZd
         IjOUg0r/Bf+MkOPnR2G1dz+6e3NaguKtoVVYzSu0ejQDfjIZZ+5MY82gAAKsGd4a20of
         WqP+48ms1SC75/xDkxLP8pBpyTc1Bx/xHjXoeKPbRIyD5k9FTJWbmV0YwSPY90mPZrif
         JdXtbgfG1+QKjAl/Jh4DfnUpEnchWaQ3Fp0yo5a3vGgx336+xURo2xg5nkBge0ABDmAE
         Q71oL3WHeTrhTzS1fJZ1EShp/utdR+Uy8MHqzPrS5njN8lRAfhkdKj5pDespcR6Ue3K7
         rfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033998; x=1725638798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGphCA+jPiPvJub7Pk4t9JSGEtZkdQksxUPkcPLMM2c=;
        b=TQrJShby3K+1UWza1zcSbC9g+r+6RwmR9xZLvsA0b7JhSMaFy0A6aw18Aa3VD1jCW6
         DFHWRdFyOD7ShKiV1qhMq7ufzeVfEqC6kh2l7WyLvDGOVUnXxRcmBr9Whjjr8YMCJCAd
         bKWgWWkl/iFS1DIFfdG1nbnqWAlhAgp20NGBBICvbeLg1AIQTxXg5LdSmin9c/iTQdjC
         R+H1b9DoEq26eQqfF7J2msqYRiYzRTDTGF9gqhAmuU3Rl0utUbJfH6Eq7sbn9UFnPBv2
         53H71OFLSU4dN/IgwObVV+33wG47s/e3dZM1yzncRVFhjh8/NXdovPFXYFghJXdcjbDq
         mIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2dzfc8kPkoNv3IEdrtNoLNFDaEwyClEvqGajSKR1HbPen+FsqhxMSwKWHJGB9U/2BcduZfakEEUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxea/WoDKTCjb7TtLPvt3+4rDb90s7NFdDb2Dl8Zz7Z73G1oA7y
	/zFXJwRscC3Q1c1yAgAtf+FUJlg7aRZa1ayj0G9lI57LDkOe/8Ow5NJ28FTB7w==
X-Google-Smtp-Source: AGHT+IEbJ/+lGp7z2DAYEX33zt6VzbMvmK3kbuqkocw/ww0u+IINvEONt6XN+npTAa1k0VNO9UCBDg==
X-Received: by 2002:a17:90a:420e:b0:2c9:5c67:dd9e with SMTP id 98e67ed59e1d1-2d8561d803fmr6546388a91.19.1725033998181;
        Fri, 30 Aug 2024 09:06:38 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445d5bb0sm6636733a91.1.2024.08.30.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:06:37 -0700 (PDT)
Date: Fri, 30 Aug 2024 21:36:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <20240830160632.onc2rchuruww7khq@thinkpad>
References: <ZtDrjl3b8yhumk+A@lizhi-Precision-Tower-5810>
 <20240829220005.GA81596@bhelgaas>
 <ZtHqExOsk2/tl69w@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtHqExOsk2/tl69w@lizhi-Precision-Tower-5810>

On Fri, Aug 30, 2024 at 11:49:39AM -0400, Frank Li wrote:
> On Thu, Aug 29, 2024 at 05:00:05PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 29, 2024 at 05:43:42PM -0400, Frank Li wrote:
> > > On Thu, Aug 29, 2024 at 04:22:35PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > > > Greetings,
> > > > >
> > > > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > > > > device and the device is not getting a valid interrupt.
> > > >
> > > > Does pci-imx6.c support INTx at all?
> > >
> > > Yes, dwc controller map INTx message to 4 irq lines, which connect to GIC.
> > > we tested it by add nomsi in kernel command line.
> >
> > Thanks, Frank.  Can you point me to the dwc code where this happens?
> > Maybe I can remember this for next time or add a comment to help
> > people find it.
> 
> I think it needn't special code to handle this. in dts
> 
>  interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>                  <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
>                  <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>                  <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> 
> It map INT(A,B,C,D) to 4 GIC irq.
> 

Yeah, the mapping is handled in pci_host_bridge::map_irq() callback, which has a
default assignment, of_irq_parse_and_map_pci() parsing the 'interrupt-map'
property in DT and resolving the interrupt. So we do not need any special code
to handle INTx for RC.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

