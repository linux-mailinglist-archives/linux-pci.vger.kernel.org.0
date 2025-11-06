Return-Path: <linux-pci+bounces-40464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D43C3974D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E753B4DFF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AD921D00A;
	Thu,  6 Nov 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx6awSaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C042882D7
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415453; cv=none; b=D7em5V3FNRQgUSDRy+G13nmbOwiyeBZLLoSgW71wLj0eipTGaPLsgLQ5uRO2sAJJ7ejha7JDJANubSWozOK4z1L0L1Pg+1Ne89arBfV3ZomzP5FKh7E95jwICQtvk7zNAjXvBMfEcNiMM7Na9SNmb5dO7F2bfAgCFqI0ffRJ2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415453; c=relaxed/simple;
	bh=p3t1Nu3/jaRiIeOqwFNK5UrO9I5BIOo4m9uqYA+ne9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5LiDiNkwmbhCfisjpr9vKRSpuOdtIJmLY96j0d2OFuf3Sdn4Uz5E0B0h+uzZlEP/doH+VNVttuM9dcE46IdlJqJPDvwU8lXexO7WuYYKuLA1ou0WeOULxD7YpRQI3smshNlZ2OAdRI1YLwn5qrnVfR0fE3z+ElVU0TWwJ0BMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yx6awSaD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso2955606a12.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 23:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762415450; x=1763020250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oSZTMv5D/sOGGLnpJ+IvuCz5xyHo5sq+jQga6CKtnM=;
        b=Yx6awSaD7lS9u7PttF4PUpdeWss2Yn7T4chucVApGLMuE2r1Q9G+1luxSzXa1vAg9M
         MU+heyTc4xfsXpCsUWqU+9oEZArL6hjBqOOGUopCctJTQeP4xhVgmsMdDgNE5bcqrvVA
         YsMMhuLDt5no2Gcn9fFhXvlS9o7PrtuxmSKDw6LwgHeN8iUsvgrCBH0tqdNb4juFJxLr
         tiToJvoUjcHVejsrUWswgtTcQOZ/BZJNS1ZFt/de73t4b9shCmhS8du99ZeuZY8DdmVk
         oi5gHZ6bVcr8/V8pEP7w4XekiVS1NxYpGshEA053EPy3NbRQTfO8le9PNI9ZrSKGNiA3
         lDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415450; x=1763020250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4oSZTMv5D/sOGGLnpJ+IvuCz5xyHo5sq+jQga6CKtnM=;
        b=cunXlidi1WW6SgDVRUMVmga4UbojEr/ZuetpupT0qAS4RBrAYZOub8z+I7QsFLz3X9
         GDZR6KYGkNhgTar2R0zP/W8W9imfGf00pkY3F0UKvmO50pMqmsFTkM8FU8zuByIzZT6P
         T8QmJa84Gki1kt1k8pLiUBFsWfXMUQW6kg17MIXHzscmaiAwZejumqnusv1mXjehebYQ
         W0nlm1ohXfWLx6Ze375CK32QhwQ45pTmb/rPi+rnQNcnR4ht2NByaCE5uGPCvc2TwtzK
         Ze0A6rFc2eYRKP4b/dxobOzLWugXtbd+4cmbx00q+f3gKcytf9qnjRsNgyj/Nf/wVy5U
         kdJg==
X-Forwarded-Encrypted: i=1; AJvYcCWziBnC3fBx5tWSXkZwSrmmSh0LBRlkdCvW+5WYRS/fJzpW0OyIeRlKNVUayVl09jMJFWMIpJrzPtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBbizAnUPNVG3oIBOIgsKd4hgKyCAUjcQHUl0xGw+x3y87cHV
	KzTgWtOyKt6liwUi+w3hIsIXQuaoKs2OloKRqHtcbURo/1WaJ4TxzwEK4X6z7HZytqnoTVss99N
	BlEUcvPsexkvUiCuDotozn12AXboJIrxKZI1b5TWr5g==
X-Gm-Gg: ASbGncsWNhXCG7Ow5O4hET3GZksEm9Ig/zHzDUF9mS9CXmX7DvRuNjaLt845dEVJydq
	d0XmHwCwMTmssAq+eFv6cZuKNI8w9PmGBqB8I8pWCp5ANTWnFOr2b9eUKL7D5o4HdZEhilXIVFv
	KmMNF6W1c1JnsJxTqF5XfLGGrZpcAlP5D+ChBhDfA4aAzzbJqJxvg4F6mJKldx687tnOVFwFZ7S
	wJvIjbemJatCjLqsyMpllRNuK9TqXLi1ftcWQik8TS4OVjGCsWvHnMQmPTe4w==
X-Google-Smtp-Source: AGHT+IGTqwA2P7XvjyYF/Izos2lVy+T5to2mL8X2E6WlWDzOEu9Bmz8GxKORg8EJlnHJ5cxaDH8TQQoU0UmnunUk7JI=
X-Received: by 2002:a17:907:94d2:b0:b72:6d68:6663 with SMTP id
 a640c23a62f3a-b728964dea0mr251219566b.31.1762415449844; Wed, 05 Nov 2025
 23:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>
 <20251106000531.GA1930429@bhelgaas> <vrgjkulv22hzbx65olh3zpyqxq6dr7d5mepngjwgc3gudjoxwo@ll7xc2teya2s>
In-Reply-To: <vrgjkulv22hzbx65olh3zpyqxq6dr7d5mepngjwgc3gudjoxwo@ll7xc2teya2s>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 6 Nov 2025 08:50:37 +0100
X-Gm-Features: AWmQ_bkYpQyZF7OktEjeeIhdfj_KOUOxVV3OYB8DSDbc8qdV2MpPBlN_Lqu--DE
Message-ID: <CAKfTPtB=oMPsfjRFcQrAKM1m97B1LL9RJYVix+ea9Vb0FqDk3A@mail.gmail.com>
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org, Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Minghuan Lian <minghuan.Lian@nxp.com>, 
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Christian Bruel <christian.bruel@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 at 07:24, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Wed, Nov 05, 2025 at 06:05:31PM -0600, Bjorn Helgaas wrote:
> > [+cc imx6, layerscape, stm32 maintainers for possible suspend bug]
> >
> > On Fri, Oct 24, 2025 at 08:50:46AM +0200, Vincent Guittot wrote:
> > > On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > > > On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> > > > > Add initial support of the PCIe controller for S32G Soc family. O=
nly
> > > > > host mode is supported.
> >
> > > > > +static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
> > > > > +{
> > > > > ...
> > > > > +     /*
> > > > > +      * Make sure we use the coherency defaults (just in case th=
e settings
> > > > > +      * have been changed from their reset values)
> > > > > +      */
> > > > > +     s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> > > >
> > > > This seems sketchy and no other driver uses memblock_start_of_DRAM(=
).
> > > > Shouldn't a physical memory address like this come from devicetree
> > > > somehow?
> > >
> > > I was using DT but has been asked to not use it and was proposed to
> > > use memblock_start_of_DRAM() instead
> >
> > Can you point me to that conversation?
> >
> > > > > +     s32g_pp->ctrl_base =3D devm_platform_ioremap_resource_bynam=
e(pdev, "ctrl");
> > > > > +     if (IS_ERR(s32g_pp->ctrl_base))
> > > > > +             return PTR_ERR(s32g_pp->ctrl_base);
> > > >
> > > > This looks like the first DWC driver that uses a "ctrl" resource.  =
Is
> > > > this something unique to s32g, or do other drivers have something
> > > > similar but use a different name?
> > >
> > > AFAICT this seems to be s32g specific in the RM
> >
> > It does look like there's very little consistency in reg-names across
> > drivers, so I guess it's fine.
> >
> > > > > +static int s32g_pcie_suspend_noirq(struct device *dev)
> > > > > +{
> > > > > +     struct s32g_pcie *s32g_pp =3D dev_get_drvdata(dev);
> > > > > +     struct dw_pcie *pci =3D &s32g_pp->pci;
> > > > > +
> > > > > +     if (!dw_pcie_link_up(pci))
> > > > > +             return 0;
> > > >
> > > > Does something bad happen if you omit the link up check and the lin=
k
> > > > is not up when we get here?  The check is racy (the link could go d=
own
> > > > between dw_pcie_link_up() and dw_pcie_suspend_noirq()), so it's not
> > > > completely reliable.
> > > >
> > > > If you have to check, please add a comment about why this driver ne=
eds
> > > > it when no other driver does.
> > >
> > > dw_pcie_suspend_noirq returns an error and the suspend fails
> >
> > The implication is that *every* user of dw_pcie_suspend_noirq() would
> > have to check for the link being up.  There are only three existing
> > callers:
> >
> >   imx_pcie_suspend_noirq()
> >   ls_pcie_suspend_noirq()
> >   stm32_pcie_suspend_noirq()
> >
> > but none of them checks for the link being up.
> >
>
> If no devices are attached to the bus, then there is no need to broadcast
> PME_Turn_Off and wait for L2/L3. I've just sent out a series that fixes i=
t [1].
> Hopefully, this will allow Vincent to use dw_pcie_{suspend/resume}_noirq(=
) APIs.

I'm going to test it

Thanks

>
> - Mani
>
> [1] https://lore.kernel.org/linux-pci/20251106061326.8241-1-manivannan.sa=
dhasivam@oss.qualcomm.com/
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

