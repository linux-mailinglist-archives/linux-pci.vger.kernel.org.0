Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5931A3E27
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 04:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJCXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 22:23:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34548 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJCXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 22:23:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so637419lji.1;
        Thu, 09 Apr 2020 19:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7nub2iC7HflOtCQHAAafbgeNv5reSfX1ICVh/feaUg=;
        b=JFVBcnHtGbIdWIzex5YH9WvtY0JYL61bG3IWoWHDvhab8sS7zyKzabEW+N1KhP6CDJ
         o//t4xh1c9ED3fWEGmYjw8T9ATBMJ/HsSaaCo2OzTHaNWXgova2j3RPoUf7Jcb/KRTfd
         thrhVzgcQM1Cdxy4FaObzOCGdPDYBMaTZAh9N14VKmxdNK2cxmxyAuU5S+jBoK6qlwH9
         SdXdmi1R2j4UVjl94PbHzLTiGa8dXQ+8UN2Tj2PggHIHyEcZC9GQblO15j3CWmobYXZQ
         C2ZtS8XrVOnIW0U/pRCtlF/VPDHqKhnaU/byLhjlQEN/YjHPMXbO8ctaE6Hs/jQceDBx
         YdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7nub2iC7HflOtCQHAAafbgeNv5reSfX1ICVh/feaUg=;
        b=n4G6UUqCEOwFvUajwDSbGJJPrEP+oQpcAixfc1+MFZ6dFQ0Iy1V+ldKMxIMiT/j/Qy
         ABqR6kU/NQACLDCqdmIOW3RVRvlYCXSrCPlY7BUWpS/G3xMw6n2UkNbQz0287tNX04Yk
         eLgYJk0PwLyPib5veJK2XhUEWWQz2MsZetd5F8fV2zXB3pBYNfHPhUd5CE91ijlDNwd3
         y8GBGmxz2rZkn5dyfP/PkRLNGrAhl9JPXvzqLXOvsZNlyp2NlpETQPVzeKgvF4Ax+guN
         Gu72Ifpyp1NVrJnUuCmlty01WzEADhaWUfx6wF2SbzrNsng729W34Fc2aLDboFjVs2/u
         ug4g==
X-Gm-Message-State: AGi0PubsqSAgavwT35JvSnmqBgb2eGSDrKcMdj02tlajLkJSWkZyGnl5
        NMwq0wEoXPVvxP9YO2SX3o5TEgA3yrIbxO1MVtQ=
X-Google-Smtp-Source: APiQypLnZGTvqOGESVBjKQo4/Lj3hRB1ay/3mDXASjqrLo7VK00BjILY9FTR5FqYsL8gYvGI1WpmBu69VNNGszWlHjI=
X-Received: by 2002:a2e:974d:: with SMTP id f13mr1694240ljj.178.1586485424861;
 Thu, 09 Apr 2020 19:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200410004738.19668-1-ansuelsmth@gmail.com> <20200410004738.19668-3-ansuelsmth@gmail.com>
In-Reply-To: <20200410004738.19668-3-ansuelsmth@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 9 Apr 2020 23:24:12 -0300
Message-ID: <CAOMZO5AKYO3xLsp4k6_fJCV9qW=rAtRKEGWnxksixU794dOw8A@mail.gmail.com>
Subject: Re: [PATCH 2/4] drivers: pci: dwc: pci-imx6: update binding to
 generic name
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

On Thu, Apr 9, 2020 at 9:47 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Rename specific bindings to generic name.
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index acfbd34032a8..4ac140e007b4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1146,28 +1146,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>         }
>
>         /* Grab PCIe PHY Tx Settings */
> -       if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
> +       if (of_property_read_u32(node, "tx-deemph-gen1",

This breaks compatibility with older dtbs.
