Return-Path: <linux-pci+bounces-40461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851AFC3970E
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 08:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1C718C588B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B813628751D;
	Thu,  6 Nov 2025 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/q1DzTt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0827A92D
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415205; cv=none; b=Dbue+IWOHXLu383sOt2LQG7DolBzibPELJrqs/2VqkJWGPiZ4VUwpsSLXxfGMUUC5YaHHxvK+pp9GFTbQbZhKpMwGHFXU8HKvzzJ2LaOzy+Iv6dgnRMFmQqU2MNz8y8DH56WTJcbJ++yXXPUeEsOeIlArOxM82hPN3jFL8gGnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415205; c=relaxed/simple;
	bh=wWDCB0EwVxgPHs1EZUnyq5hb+MHfv1itWf5YxF377ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euwyO72Mt0t0gWF2bYbgeZ42BBKjD2HGwaU2ZVLgzucSJoNcuqnd7xu8PLzCXYAbZKRa1Cae8d7Cxxu0mzFVDpjYxW/aELpRYM+C7FEJmx6tW5oWsSNT/IG7F2sRDg3psHIdvyIq+HrHKdDB1MWQ8H/RntDKCeBvXsPoJSI5SPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x/q1DzTt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b996c8db896so583678a12.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 23:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762415203; x=1763020003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0f5wmX+yoZg0wz1UxGaCZPnItqaKdkuDqolTF8KvNuo=;
        b=x/q1DzTtMl7Dy5yQCCbK3r7ePMQbdXthtdlo3GmJbYbNK4r+qwHtweU2tKWEVNKeHH
         8Cb+ZXiR5jWnBJQglxek3Z8coFpXxmzqznzt4Pd8mIKqAnaNcHYoi0VZhR2OsgQQBYQs
         L6DkH8+VdcbjD9/ir/x5SEa/tCpnQjui5Qogkj5Zutk7UmQ8nrWZx26RfRtjtu3cDpem
         1/GmiAUSP66Kd9y5FN0QixtXZl7+Bz/MKE2RZ24iKgNqIOdGctvNRusJu/2lMB1EAn56
         9lJXfNi2kyjxgRFMgFKvymisiWX9M/Hk0y0Yl8VUs3N69T+33XyCBh5HgHdzS2tTMRHm
         cS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415203; x=1763020003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0f5wmX+yoZg0wz1UxGaCZPnItqaKdkuDqolTF8KvNuo=;
        b=JDNaG79WTYN48ygW/JwXNEWGunVFELkGw1AcCcWcbIrycz89cZh5U6lEsyV/aQxiVL
         CtrW0Sv0HXiY2pWmRBkMVIN7zBn+c7tULtxX+pBqnF0yTtyonbL2zxAOVz43lKo3xefq
         1blcxjUEF9+t9jUZNyRQYc6OPKe0/92s/CEe6PdLKX0hE8K4GPoilGlOz2uvFfjqE6aC
         28kSAp8JPcQRQ/an1uOfKNl+IPkrJEyjC+6uSD9kw040ZkGhLRzw2yQcZwnBYRRZqbj7
         cdPd2pvPPsf3jhqYhoV76gR+cjTNZY5hlMmk1HtYJUN4bbY7nZAG+O5BRDqlX3ulZ8e1
         9tiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtCifv7Vnz3/9374DK/mIXvjZbJBp/sbhsocBNEtla/8Mj6R+nbKNab2BWwhIcD8jCcROvaPyaLg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUzc6LTPxhrNKnLkGZvzRNvQxmz+Dse9TXjEt+Wqta0diQQNi
	P2U/wqrqoRlbZRtYgXnFvVyFiq+HaWIDZ8qAIyVtgVYOzLlyu6B/+Lm4z+vldi23yaS+GdHUmay
	UHTgiSPTmGZgD8smvL6GOJKCz9w5U3K0epTK8ygjmgQ==
X-Gm-Gg: ASbGncvbgI+6Wvu8r3O6BxBLcrOvWpsbla1KJ0fIvJ5C9daF2LdEeD1eTyb0Ury40PK
	MhB8lYB1Gi9QtnDMjB3wegPGcAF8BOWqvlhjtObmkuxhBxYmEksmiYePMa3xTFDt0FJTQbPXzrw
	ict+U+iU4J8UkULk1UI9l+IiV+fsgpMj5rBlZgnHRXFkcjtdESHd3KYA2ItPqydTonbg05+nCuY
	g0scNfYf3bLlRqlIw1QmEpkoy5B5K5Qp4VPmQU2bbMpiBO7hkyfzuv+IqZJYA==
X-Google-Smtp-Source: AGHT+IFvj7BYATFPUUfyyTquYUZ+XG2ltlcW863lIimOI+3G3/lJLUOzbLQ43b0xX7YM+rdDM6ZeBwU/rpFRv4aSwps=
X-Received: by 2002:a05:6a20:728f:b0:350:ee00:3c9f with SMTP id
 adf61e73a8af0-350ee004101mr3256044637.48.1762415203454; Wed, 05 Nov 2025
 23:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>
 <20251106000531.GA1930429@bhelgaas>
In-Reply-To: <20251106000531.GA1930429@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 6 Nov 2025 08:46:27 +0100
X-Gm-Features: AWmQ_bmqVCNR3dJpEZPSNIsk4oiASQ7wTNG-cdh5_x2RX44MkoIq9HcAbtR0V5w
Message-ID: <CAKfTPtA+_VgQQB37Y8qCd6cc5U22kqUkagy2PFnB-5biWUhB9w@mail.gmail.com>
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org, Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Minghuan Lian <minghuan.Lian@nxp.com>, 
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Christian Bruel <christian.bruel@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 01:05, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc imx6, layerscape, stm32 maintainers for possible suspend bug]
>
> On Fri, Oct 24, 2025 at 08:50:46AM +0200, Vincent Guittot wrote:
> > On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> > > > Add initial support of the PCIe controller for S32G Soc family. Only
> > > > host mode is supported.
>
> > > > +static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
> > > > +{
> > > > ...
> > > > +     /*
> > > > +      * Make sure we use the coherency defaults (just in case the settings
> > > > +      * have been changed from their reset values)
> > > > +      */
> > > > +     s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> > >
> > > This seems sketchy and no other driver uses memblock_start_of_DRAM().
> > > Shouldn't a physical memory address like this come from devicetree
> > > somehow?
> >
> > I was using DT but has been asked to not use it and was proposed to
> > use memblock_start_of_DRAM() instead
>
> Can you point me to that conversation?

https://lore.kernel.org/all/CAKfTPtDcvrAcgFcyFLnzaKnfuU3iB551qed4fnZH=b7Ntkpxpg@mail.gmail.com/

>
> > > > +     s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> > > > +     if (IS_ERR(s32g_pp->ctrl_base))
> > > > +             return PTR_ERR(s32g_pp->ctrl_base);
> > >
> > > This looks like the first DWC driver that uses a "ctrl" resource.  Is
> > > this something unique to s32g, or do other drivers have something
> > > similar but use a different name?
> >
> > AFAICT this seems to be s32g specific in the RM
>
> It does look like there's very little consistency in reg-names across
> drivers, so I guess it's fine.
>
> > > > +static int s32g_pcie_suspend_noirq(struct device *dev)
> > > > +{
> > > > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > > > +     struct dw_pcie *pci = &s32g_pp->pci;
> > > > +
> > > > +     if (!dw_pcie_link_up(pci))
> > > > +             return 0;
> > >
> > > Does something bad happen if you omit the link up check and the link
> > > is not up when we get here?  The check is racy (the link could go down
> > > between dw_pcie_link_up() and dw_pcie_suspend_noirq()), so it's not
> > > completely reliable.
> > >
> > > If you have to check, please add a comment about why this driver needs
> > > it when no other driver does.
> >
> > dw_pcie_suspend_noirq returns an error and the suspend fails
>
> The implication is that *every* user of dw_pcie_suspend_noirq() would
> have to check for the link being up.  There are only three existing
> callers:
>
>   imx_pcie_suspend_noirq()
>   ls_pcie_suspend_noirq()
>   stm32_pcie_suspend_noirq()
>
> but none of them checks for the link being up.
>
> > I will add a comment
> > /*
> >  * If the link is not up, there is nothing to suspend and resume
>
> Sometimes true, but still racy as I mentioned, and doesn't explain why
> s32g is different from imx, ls, and stm32.
>
> > > > +     return dw_pcie_suspend_noirq(pci);
> > > > +}

