Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7266784F16
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 05:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjHWDG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 23:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjHWDGZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 23:06:25 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E7E50
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 20:06:18 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-570e88ee36aso1278940eaf.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692759977; x=1693364777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgAdcTBlf+rIuiyzkn5utTBoPjOIxfw/48rc208BTeI=;
        b=ndAiRnpDXzVUWLLl5T97M9fSBcG9cHpmr5AAPWDa60A3Oj9PfC2I7jmqWlMoSmok6Z
         QUvZXXy3r1/yHCykLBATiTk7v58j6LC2bZT4Sd47aS7dxKDh7XtNFOacINcbUctan+RK
         2pENJdE4/LngNLNKEai9R2WjwFA4IERbNig6SYRqmKcIYdqhc92cFbXtcxlsxSHg2GRJ
         7vKMr4+DQuotpXKa8ycfSIzOtOu2yCthd85zkqp4fulikdkLA/+D+cQG4I5f/GYJfz6Z
         1rLv9xLODMs4NW87KRU/FRcx+CLAI6uXgnqHiKd3XYP/BTABl79vrbjfDKELFsiC0oTe
         eXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692759977; x=1693364777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgAdcTBlf+rIuiyzkn5utTBoPjOIxfw/48rc208BTeI=;
        b=Jga67S3hQ8Tj+QzN66nT0kVZw/IHHNC1zKEnYvUez9tQOkPSTLHFiGsYn76+xXY+zA
         W3RjYCipI1LPMiVS74W8Cr988Jl49zoGkXaoU4QbP7nWRJYYa5sWqldBxyckSQ588Tc1
         CTgw8N6gf6JOcKIKUfwNw0z342GU2Qs10seDwx2Ba81MiBEhpyHjBEg/kfXY+WwzFWvL
         qRIAIlpTFGxGRlb6XcL/+Ifpe7WVJa1RybTvl+5p2QiDHITj/88mHRn7lXrh4d7umQI5
         RZyXNe1/oIDH9RrFQznPbRpnwcY3+gpAqTo0fXsh5A2YVzwNYWskSxtLjrBFkNMt1h2C
         fbNQ==
X-Gm-Message-State: AOJu0YwCZqskP2iIy304Q16/3qNPLpil043/fG72qXmGoadGdLE4cV7c
        CWhVwV8nE4DRTnUKs0cmnjeU88QWUJfexRI5+J4pQy+yKkviO49NTKY=
X-Google-Smtp-Source: AGHT+IEe/IeXdwsKt7uz522E5VBJO2YyNMsBoedoBFarQ4/ay5kmErLM6TAkGrD2r8XFUm0rKC3He7KTqIteQ1tjEk8=
X-Received: by 2002:a05:6820:41:b0:56c:7a55:f6b3 with SMTP id
 v1-20020a056820004100b0056c7a55f6b3mr12126745oob.5.1692759977358; Tue, 22 Aug
 2023 20:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230807055621.2431-1-yongxuan.wang@sifive.com>
In-Reply-To: <20230807055621.2431-1-yongxuan.wang@sifive.com>
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date:   Wed, 23 Aug 2023 11:06:06 +0800
Message-ID: <CAMWQL2jY=pRaYjFq19QBR3X9OtWxHqTThUDJxtyeBmMhOcF+BQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: fu740: Set the number of MSI vectors
To:     linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, p.zabel@pengutronix.de, palmer@dabbelt.com,
        fancer.lancer@gmail.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Kindly ping on this, any comments or suggestions are appreciated.

Regards,
Yong-Xuan


On Mon, Aug 7, 2023 at 1:56=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> The iMSI-RX module of the DW PCIe controller provides multiple sets of
> MSI_CTRL_INT_i_* registers, and each set is capable of handling 32 MSI
> interrupts. However, the fu740 PCIe controller driver only enabled one se=
t
> of MSI_CTRL_INT_i_* registers, as the total number of supported interrupt=
s
> was not specified.
>
> Set the supported number of MSI vectors to enable all the MSI_CTRL_INT_i_=
*
> registers on the fu740 PCIe core, allowing the system to fully utilize th=
e
> available MSI interrupts.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> Changelog
> v3:
> - refined the commit message
> v2:
> - recast the subject and the commit message
> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/contro=
ller/dwc/pcie-fu740.c
> index 0c90583c078b..1e9b44b8bba4 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -299,6 +299,7 @@ static int fu740_pcie_probe(struct platform_device *p=
dev)
>         pci->dev =3D dev;
>         pci->ops =3D &dw_pcie_ops;
>         pci->pp.ops =3D &fu740_pcie_host_ops;
> +       pci->pp.num_vectors =3D MAX_MSI_IRQS;
>
>         /* SiFive specific region: mgmt */
>         afp->mgmt_base =3D devm_platform_ioremap_resource_byname(pdev, "m=
gmt");
> --
> 2.17.1
>
