Return-Path: <linux-pci+bounces-980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7994E812BD5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7CF1C20F67
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5BD2F862;
	Thu, 14 Dec 2023 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqtjooZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF3B7;
	Thu, 14 Dec 2023 01:40:19 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9f9db9567so90476471fa.3;
        Thu, 14 Dec 2023 01:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702546817; x=1703151617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGhBdQ6R14LrX8jG2wfHRD5uLBGEkB0t8hNQS+qxIZM=;
        b=GqtjooZMIticSqLqBuSMSQb6cktpe6/fRSMMeqRol94DiIVzwCivlvqlWnyw3loWbe
         D68I6Hvb6XXHrEXHDmoT6LUV5k9I0hOvCohTXnM4ugNVvuhcfIA1qxQZpfBj5sZQiv1K
         YvH78NpiJuHTaL2VC/wOXNeAa48Q+iuiQXt/1LC8PvKCD4CwwXZs4e/O9ZNClDydcTu7
         2QEFIN3bASX64s2CcT9nkDffbqkoUSsjgP4jiFLUHbHlLpiVjYoZcz0rQAVfeIPaKDDt
         ZwswKoJp+0Nf5r1B9eX/wZxzFl9f5hj0DD8LCJvGIpRnhH7l2k+dafVa8L+8ZEBPLvNP
         KDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702546817; x=1703151617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGhBdQ6R14LrX8jG2wfHRD5uLBGEkB0t8hNQS+qxIZM=;
        b=hc1mIGi0XjqZ4gnXg9vJQhREYgfIUAGj0rSfcpHsSmQNBy//Pc+GagrWuFr2foPJ9W
         vtbjf3AwJz6uePawQkan+ch5EfpG6Izrq5YUzuDHu2/ONa2NyhOlYn0gCgB6oGz7X7n6
         pgAWvDrOYslep4xviTv93l5z4cZMDoG7TAnIaM+fSm9WR8LLAYsgUdiDSkRj1cYwEEGS
         ige8xXMcxSt00M6ggQF3b7VwrVdHe7NAMF0InlVmnpqlBAWAnkkObuj4/1Ji7OQj4esZ
         sf0n47QRtHJWPy7VWC4NP3fT992QpT1My/xIaBnG46WfOoSLv/2m7mixYvv+qvUKqpRv
         D5QQ==
X-Gm-Message-State: AOJu0Yy5GBh0PuZmlJzmrBvKsbC1R1oh9iG49oRan71XiXgPuR4i4MtY
	0kJjgalB7AaTZOjt/hracxw=
X-Google-Smtp-Source: AGHT+IFnuSUDaGmtBw+49+w1yxTH4aRe1mIcT+VpM3unPg8n8wj5ymVgmCsLA6bFLjjM+Qej9qksGw==
X-Received: by 2002:a05:6512:3f06:b0:50e:338:5e with SMTP id y6-20020a0565123f0600b0050e0338005emr3331274lfa.49.1702546816949;
        Thu, 14 Dec 2023 01:40:16 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512020e00b0050c0bbbe3d0sm1818655lfo.137.2023.12.14.01.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:40:16 -0800 (PST)
Date: Thu, 14 Dec 2023 12:40:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, 
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>, "mani@kernel.org" <mani@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] PCI: controllers: tidy code up
Message-ID: <rrgcf2jagjkiczb5tt56qm2jwvfyaor2mzjdqxrodrhzrn5j65@m7orqtcay3gg>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <TYBPR01MB5341F846948DB6CFECA62187D88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341F846948DB6CFECA62187D88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>

Hi Yoshihiro

On Thu, Dec 14, 2023 at 02:35:56AM +0000, Yoshihiro Shimoda wrote:
> Hello PCIe maintainers,
> 
> > From: Yoshihiro Shimoda, Sent: Tuesday, November 14, 2023 2:55 PM
> > 
> > This patch series tidies the code of PCIe dwc controllers and some
> > controllers up.
> > 
> > Changes from v1:
> > https://lore.kernel.org/linux-pci/20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com/
> >  - Based on the latest pci.git / next branch.
> >  - Add a new patch to drop host prefix of members from dw_pcie_host_ops
> >    in the patch 1/6.
> >  - Add Reviewed-by tag in the patch 3/6.
> >  - Drop unneeded local variable in the patch 4/6.
> >  - Add new patches to resolve issues of clang warnings in the patch [56]/6.
> > 
> > Justin Stitt (1):
> >   PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
> > 
> > Yoshihiro Shimoda (5):
> >   PCI: dwc: Drop host prefix from struct dw_pcie_host_ops
> >   PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
> >   PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
> >   PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
> >   PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning
> 
> According to the patchwork [1], all patches have Reviewed-by tags.
> So, I think the patches are acceptable for upstream, but what do you think?
> I confirmed that the patches can be applied into the latest pci.git / next branch.

What actually matters is to get all Manivannan or Jingoo or Gustavo
acks (the later two maintainers are unlikely to respond though) or any
higher maintainers approval. AFAICS this patch still hasn't got any
maintainers ack:
https://patchwork.kernel.org/project/linux-pci/patch/20231114055456.2231990-5-yoshihiro.shimoda.uh@renesas.com/
https://lore.kernel.org/linux-pci/20231114055456.2231990-5-yoshihiro.shimoda.uh@renesas.com/
I guess it's connected with a request to move the helpers to the
header file.

-Serge(y)

> 
> [1]
> https://patchwork.kernel.org/project/linux-pci/list/?series=800901
> 
> Best regards,
> Yoshihiro Shimoda
> 
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |   4 +-
> >  drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
> >  drivers/pci/controller/dwc/pci-keystone.c     |   8 +-
> >  .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
> >  drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
> >  drivers/pci/controller/dwc/pci-meson.c        |   2 +-
> >  drivers/pci/controller/dwc/pcie-al.c          |   2 +-
> >  drivers/pci/controller/dwc/pcie-armada8k.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
> >  drivers/pci/controller/dwc/pcie-bt1.c         |   4 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 249 ++++++++++--------
> >  .../pci/controller/dwc/pcie-designware-host.c |  30 +--
> >  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
> >  drivers/pci/controller/dwc/pcie-designware.h  |  12 +-
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +-
> >  drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
> >  drivers/pci/controller/dwc/pcie-histb.c       |   2 +-
> >  drivers/pci/controller/dwc/pcie-intel-gw.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
> >  drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
> >  drivers/pci/controller/dwc/pcie-qcom.c        |   6 +-
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  12 +-
> >  drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
> >  drivers/pci/controller/dwc/pcie-uniphier.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-visconti.c    |   2 +-
> >  drivers/pci/controller/pcie-iproc-platform.c  |   2 +-
> >  30 files changed, 203 insertions(+), 177 deletions(-)
> > 
> > --
> > 2.34.1
> 
> 

