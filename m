Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE7759B87F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 06:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiHVEZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 00:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiHVEZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 00:25:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF519017
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 21:25:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a16so5300833lfs.3
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 21:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=v7F/xEy+yiOuK0I/tTnDMOg8QD+MS/nIrUIMdpEr5ws=;
        b=VIF2TB3gN0v1LgnAX4rTBRiH3pJrJsIT3DVwYn6lMnaabtml4kigUksvHq2LAQoEYG
         g5hK0XTDG4qOvF7SGOKsgMTxrQgv+yN0II8raa0HPXyXXQEmjqnec5dqXv8iuBunHfes
         oeN1pt2asK+1hXJCkgX83bwkOEndCF9KqBZrx4LG47S2FldZc0IREOoFHUZYpJ9lNaW/
         2oM13LvMJvBUC4cjhpsiK8BFXluMHCmBzEKaGUMC200llEjVB5koGlOvPD9hU8bElMU+
         K8O4wi5mp/PcvxvVX/9aCfx+wgZ8k+W+Xp3Lv3fetq1XoNuAXrf5SyLPH7g+G/Fi6eXK
         DrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=v7F/xEy+yiOuK0I/tTnDMOg8QD+MS/nIrUIMdpEr5ws=;
        b=YTuLiEsZPIUXmBD/zCgDGt04Dp9p5y8GIBvqN0kgxHKSzf6YddfamfCtZaxH2kLhS/
         vQkTD8OW3lQE7ceU3bYn2ybtxVEe9NhBWn2xIHLeZHOM10sL1DN8pJSE3yqM1mZIzcLU
         exbZZH9WahcBi0L0Ri3mos0cyyec3IUPCP1l2tHZ4kpOwGfGi8iocG8Out13tSi839Sj
         bbAwReZXLeOqDK1qcJ9PU+xmptZCW0CaUtIZhD86nJ3f/dFRtJHTiRGtCodDvqnXtcQ9
         cpuXqbiJLTo4UVxhC3BfpEPxL0VDy7xp7q7nZZOD6+58L8Xeq8teVLaPf2Bw8vAAAmF8
         aQcw==
X-Gm-Message-State: ACgBeo2zKZaaXKDrPHFx2ab2t74N/fXaKElkAy+Lw1vq0aU8hTtUHvGk
        0HhTVBKN2l4TUwZQSWccDGvD3Svtmq56CPbsnZcjvg==
X-Google-Smtp-Source: AA6agR4E/YuxROQ30wOT3OHyIP7zcJPKSF68f6yHRvtIqmwww5fetwlUDQSDgXt4re+AhiR83ukP6x9+MpPcvwXRpTw=
X-Received: by 2002:a05:6512:3c87:b0:492:d161:c014 with SMTP id
 h7-20020a0565123c8700b00492d161c014mr3818137lfv.490.1661142351182; Sun, 21
 Aug 2022 21:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org> <20220819145018.35732-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20220819145018.35732-4-manivannan.sadhasivam@linaro.org>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Mon, 22 Aug 2022 13:25:34 +0900
Message-ID: <CANXvt5qbMvhRNnQ_hbiCXOjSOj_Ltk=Kt+wBZa4T_RjxN5Ojcg@mail.gmail.com>
Subject: Re: [PATCH 3/5] tools: PCI: Fix parsing the return value of IOCTLs
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2022=E5=B9=B48=E6=9C=8819=E6=97=A5(=E9=87=91) 23:50 Manivannan Sadhasivam <=
manivannan.sadhasivam@linaro.org>:
>
> "pci_endpoint_test" driver now returns 0 for success and negative error
> code for failure. So adapt to the change by reporting FAILURE if the
> return value is < 0, and SUCCESS otherwise.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  tools/pci/pcitest.c | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 441b54234635..a4e5b17cc3b5 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -18,7 +18,6 @@
>
>  #define BILLION 1E9
>
> -static char *result[] =3D { "NOT OKAY", "OKAY" };
>  static char *irq[] =3D { "LEGACY", "MSI", "MSI-X" };
>
>  struct pci_test {
> @@ -54,9 +53,9 @@ static int run_test(struct pci_test *test)
>                 ret =3D ioctl(fd, PCITEST_BAR, test->barnum);
>                 fprintf(stdout, "BAR%d:\t\t", test->barnum);
>                 if (ret < 0)
> -                       fprintf(stdout, "TEST FAILED\n");
> +                       fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         if (test->set_irqtype) {
> @@ -65,16 +64,18 @@ static int run_test(struct pci_test *test)
>                 if (ret < 0)
>                         fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         if (test->get_irqtype) {
>                 ret =3D ioctl(fd, PCITEST_GET_IRQTYPE);
>                 fprintf(stdout, "GET IRQ TYPE:\t\t");
> -               if (ret < 0)
> +               if (ret < 0) {
>                         fprintf(stdout, "FAILED\n");
> -               else
> +               } else {
>                         fprintf(stdout, "%s\n", irq[ret]);
> +                       ret =3D 0;
> +               }
>         }
>
>         if (test->clear_irq) {
> @@ -83,34 +84,34 @@ static int run_test(struct pci_test *test)
>                 if (ret < 0)
>                         fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         if (test->legacyirq) {
>                 ret =3D ioctl(fd, PCITEST_LEGACY_IRQ, 0);
>                 fprintf(stdout, "LEGACY IRQ:\t");
>                 if (ret < 0)
> -                       fprintf(stdout, "TEST FAILED\n");
> +                       fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         if (test->msinum > 0 && test->msinum <=3D 32) {
>                 ret =3D ioctl(fd, PCITEST_MSI, test->msinum);
>                 fprintf(stdout, "MSI%d:\t\t", test->msinum);
>                 if (ret < 0)
> -                       fprintf(stdout, "TEST FAILED\n");
> +                       fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         if (test->msixnum > 0 && test->msixnum <=3D 2048) {
>                 ret =3D ioctl(fd, PCITEST_MSIX, test->msixnum);
>                 fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
>                 if (ret < 0)
> -                       fprintf(stdout, "TEST FAILED\n");
> +                       fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         if (test->write) {
> @@ -120,9 +121,9 @@ static int run_test(struct pci_test *test)
>                 ret =3D ioctl(fd, PCITEST_WRITE, &param);
>                 fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
>                 if (ret < 0)
> -                       fprintf(stdout, "TEST FAILED\n");
> +                       fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         if (test->read) {
> @@ -132,9 +133,9 @@ static int run_test(struct pci_test *test)
>                 ret =3D ioctl(fd, PCITEST_READ, &param);
>                 fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
>                 if (ret < 0)
> -                       fprintf(stdout, "TEST FAILED\n");
> +                       fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         if (test->copy) {
> @@ -144,14 +145,14 @@ static int run_test(struct pci_test *test)
>                 ret =3D ioctl(fd, PCITEST_COPY, &param);
>                 fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
>                 if (ret < 0)
> -                       fprintf(stdout, "TEST FAILED\n");
> +                       fprintf(stdout, "FAILED\n");
>                 else
> -                       fprintf(stdout, "%s\n", result[ret]);
> +                       fprintf(stdout, "SUCCESS\n");
>         }
>
>         fflush(stdout);
>         close(fd);
> -       return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded *=
/
> +       return ret;
>  }
>
>  int main(int argc, char **argv)
> --
> 2.25.1
>

Don't you use the errno of ioctl?

Thanks,
Shunsuke
