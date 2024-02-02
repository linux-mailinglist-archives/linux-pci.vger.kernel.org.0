Return-Path: <linux-pci+bounces-2996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16AD846B6F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 10:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B80B1F2447C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1CF64A92;
	Fri,  2 Feb 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZiS8kvwk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86674299
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864504; cv=none; b=O1Tev//sR+1RoFSnf8nuuDyB5yxlbyF76ABDErNmPaU8YkZCejUSO8kqn+ZzzKHnFAAaHoxTGPIeu1aHfEJCrn28WGWxSpi8ibmJLrNtzV1rq+g0vCDZ5F2qNS/PZ2WarVPXJby3c14FX/++pRCly3/YkOxpXogdEaHCkfIxWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864504; c=relaxed/simple;
	bh=I2zQrzLcgpV7z4j3Ksfthr+Iax2qqYhf5dnO1IkBizM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUNbIeF81d+5LHb2PDQviHKjKyIEaseJ9Vgeny+F9/9gSQx53LFyUUZRjoJRMV7SjUCQ4tLJYWQ7cLol00VCACK1JXcGQ7p+psrFmDlZ7cA4KshvjxbQbqGqBDrCn73F0TNzbY+ndwprZUYx2ZycOxZEdP8OK7jRtF71K60BjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZiS8kvwk; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4bfffed970bso573367e0c.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706864501; x=1707469301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvF2xXBHFPm+BTDgleNyCm2Lv+WJH8Y5ccw3uGZn2Bg=;
        b=ZiS8kvwkUbLdn54vXRerU1iY+/40zfY33XG6Ls437A0SqZ3yHrshFFiHFkiGPy+Eu4
         iOWefC1uxFFg0J+vi95DIj6Y4bP2AV7xh/uQzI6ihuYiH0f6yi7kBEE3ppF2a9burL9L
         WSnEskaxyJ19lualtJT8XjlRgwDVQznDFRvvXInkFkZWq6dTCpeQ8wR1wdidQr4DeuQl
         UP4sKV6NdIZ2ZxibNTYGgwxN50lbZjukXbBYvVQm53QDQofLo1Tatv6qwfiV17a5LJ8O
         C/aGxtO5SPBpsj7DvJ9q9RWVBC3olKx2kfoRfzhekPUfB7b56p35tf77lc9WMRKVunb2
         toVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864501; x=1707469301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvF2xXBHFPm+BTDgleNyCm2Lv+WJH8Y5ccw3uGZn2Bg=;
        b=kq1tGHtbTK7abggxsRF7YNvrzunqDNB5VUEYiBRHkMkunmhnUuaio7hYSQtXjuqf5h
         pC0aCOydGOOzIZDTIN7qYWp65LqlQliJYy8Hbp17NVIrPbBA2bxouV4204TQzmPUrgib
         3/h4N03P4O0DLb1OCy3r9C7Xi5q8yAhWqpDx5jw9ydH7xgcMx6uZ1Xv3U6Bgd+NQqqCj
         BWh213Y4CZdUYle/CiaSDnM1Z11TAi0H+IVNL3A8gNRCMbrXwHIrnDpNz8HbNp6FFUI2
         5YsuDu8rnM9DxBZM2CJ+z7iy64HEjILiQoMkWl3lU0zp+WF9s/ZIAVo0SAXQivGwZGXI
         vp5A==
X-Forwarded-Encrypted: i=0; AJvYcCXHjRo/w79gRkzCjnBj3maY8bQMCJQSbpR/ddxbUPuwZADIbtMKlJqdkgG/4hs9ZsVTpi+GpbhoNGgCJu6Ui4uDxhvWCnavR+qa
X-Gm-Message-State: AOJu0YzE+C4rneCZD+0dh98PfEzbaKNXyf3kGE4mXxJsqTXVlz2pJmF1
	aupF5nM9ITSuYyVee3FP6upr4YkpjXNWaSTYLJY17sKbCPxnN9hRqYCJTFic88JVGMBjvOQPDDl
	CMyb9NvP74NfZ9eQ2Q8ndoPR8CY2EaJgAirewDA==
X-Google-Smtp-Source: AGHT+IHdRDYbTn45U1Gk7PQJ5Nplhs7Q8O/wm2k+RRnc7OXTW/JybdBa+Q6hLwd7fTBfycRkvqLHTJnU8kP4B/0auVo=
X-Received: by 2002:a05:6122:2527:b0:4c0:ca9:9d7d with SMTP id
 cl39-20020a056122252700b004c00ca99d7dmr1578768vkb.11.1706864501127; Fri, 02
 Feb 2024 01:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-5-brgl@bgdev.pl>
 <ys45p7mdiur4liwzlexqm3aji7iz5panpb73ixg34wcio2qbvz@wkjcyazbzb4p> <CAA8EJpo7LwG2Kt0JSPc=MazWUme3YVmKHa9Fr6jc=NrZirEYUg@mail.gmail.com>
In-Reply-To: <CAA8EJpo7LwG2Kt0JSPc=MazWUme3YVmKHa9Fr6jc=NrZirEYUg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Feb 2024 10:01:30 +0100
Message-ID: <CAMRc=Md1xGma+=UzmtO4QLzF36xAe6HcRVF6WmPd6Zys=+j4YQ@mail.gmail.com>
Subject: Re: [RFC 4/9] power: pwrseq: add a driver for the QCA6390 PMU module
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:48=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 2 Feb 2024 at 06:54, Bjorn Andersson <andersson@kernel.org> wrote=
:
> >
> > On Thu, Feb 01, 2024 at 04:55:27PM +0100, Bartosz Golaszewski wrote:
> > > diff --git a/drivers/power/sequencing/pwrseq-qca6390.c b/drivers/powe=
r/sequencing/pwrseq-qca6390.c
> > [..]
> > > +static int pwrseq_qca6390_power_on(struct pwrseq_device *pwrseq)
> > > +{
> > > +     struct pwrseq_qca6390_ctx *ctx =3D pwrseq_device_get_data(pwrse=
q);
> > > +     int ret;
> > > +
> > > +     ret =3D regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs)=
;
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     gpiod_set_value_cansleep(ctx->bt_gpio, 1);
> > > +     gpiod_set_value_cansleep(ctx->wlan_gpio, 1);
> >
> > So it's no longer possible to power these independently?
>
> I'd second this, there must be a way to power them on and off
> separately. In the end, this provides a good way to restart the BT
> core if it gets sick.
>

Makes sense, I'll think about it. I'm thinking about adding a flags
argument for this kind of switching.

> >
> > > +
> > > +     if (ctx->pdata->pwup_delay_msec)
> > > +             msleep(ctx->pdata->pwup_delay_msec);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int pwrseq_qca6390_power_off(struct pwrseq_device *pwrseq)
> > > +{
> > > +     struct pwrseq_qca6390_ctx *ctx =3D pwrseq_device_get_data(pwrse=
q);
> > > +
> > > +     gpiod_set_value_cansleep(ctx->bt_gpio, 0);
> > > +     gpiod_set_value_cansleep(ctx->wlan_gpio, 0);
> > > +
> >
> > The answer that was provided recently was that the WiFi and BT modules
> > absolutely must be modelled together, because there must be a 100ms
> > delay between bt_gpio going low and wlan_gpio going high.
>
> For the reference, it was for the QCA6490 (not QCA6390, next
> revision), which maps to WCN6855.
>

The docs for QCA6390 also mention the 100ms delay but it doesn't seem
to be necessary. But yes, this was done after Dmitry raised concerns
about the QCA6490.

Bart

>
> >
> > If you're not going to address that concern, then I fail to see the
> > reason for adding the power sequence framework - just let the BT and
> > PCI power control (WiFi) do their thing independently.
> >
> > > +     return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs)=
;
> > > +}
> > > +
> > > +static int pwrseq_qca6390_match(struct pwrseq_device *pwrseq,
> > > +                             struct device *dev)
> > > +{
> > > +     struct pwrseq_qca6390_ctx *ctx =3D pwrseq_device_get_data(pwrse=
q);
> > > +     struct device_node *dev_node =3D dev->of_node;
> > > +
> > > +     /*
> > > +      * The PMU supplies power to the Bluetooth and WLAN modules. bo=
th
> > > +      * consume the PMU AON output so check the presence of the
> > > +      * 'vddaon-supply' property and whether it leads us to the righ=
t
> > > +      * device.
> > > +      */
> > > +     if (!of_property_present(dev_node, "vddaon-supply"))
> > > +             return 0;
> > > +
> > > +     struct device_node *reg_node __free(of_node) =3D
> > > +                     of_parse_phandle(dev_node, "vddaon-supply", 0);
> > > +     if (!reg_node)
> > > +             return 0;
> > > +
> > > +     /*
> > > +      * `reg_node` is the PMU AON regulator, its parent is the `regu=
lators`
> > > +      * node and finally its grandparent is the PMU device node that=
 we're
> > > +      * looking for.
> > > +      */
> > > +     if (!reg_node->parent || !reg_node->parent->parent ||
> > > +         reg_node->parent->parent !=3D ctx->of_node)
> > > +             return 0;
> >
> > Your DeviceTree example gives a sense that a set of supplies feeds the
> > PMU, which then supplies power to the BT and WiFi nodes through some
> > entity that can switch power on and off, and adjust the voltage level.
> >
> > Then comes this function, which indicates that the DeviceTree model was
> > just for show.
> >
> > > +
> > > +     return 1;
> > > +}
> > > +
> > > +static int pwrseq_qca6390_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev =3D &pdev->dev;
> > > +     struct pwrseq_qca6390_ctx *ctx;
> > > +     struct pwrseq_config config;
> > > +     int ret, i;
> > > +
> > > +     ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > > +     if (!ctx)
> > > +             return -ENOMEM;
> > > +
> > > +     ctx->of_node =3D dev->of_node;
> > > +
> > > +     ctx->pdata =3D of_device_get_match_data(dev);
> > > +     if (!ctx->pdata)
> > > +             return dev_err_probe(dev, -ENODEV,
> > > +                                  "Failed to obtain platform data\n"=
);
> > > +
> > > +     if (ctx->pdata->vregs) {
> > > +             ctx->regs =3D devm_kcalloc(dev, ctx->pdata->num_vregs,
> > > +                                      sizeof(*ctx->regs), GFP_KERNEL=
);
> > > +             if (!ctx->regs)
> > > +                     return -ENOMEM;
> > > +
> > > +             for (i =3D 0; i < ctx->pdata->num_vregs; i++)
> > > +                     ctx->regs[i].supply =3D ctx->pdata->vregs[i].na=
me;
> > > +
> > > +             ret =3D devm_regulator_bulk_get(dev, ctx->pdata->num_vr=
egs,
> > > +                                           ctx->regs);
> > > +             if (ret < 0)
> > > +                     return dev_err_probe(dev, ret,
> > > +                                          "Failed to get all regulat=
ors\n");
> > > +
> > > +             for (i =3D 0; i < ctx->pdata->num_vregs; i++) {
> > > +                     if (!ctx->pdata->vregs[1].load_uA)
> > > +                             continue;
> > > +
> > > +                     ret =3D regulator_set_load(ctx->regs[i].consume=
r,
> > > +                                              ctx->pdata->vregs[i].l=
oad_uA);
> > > +                     if (ret)
> > > +                             return dev_err_probe(dev, ret,
> > > +                                                  "Failed to set vre=
g load\n");
> > > +             }
> > > +     }
> > > +
> > > +     ctx->bt_gpio =3D devm_gpiod_get_optional(dev, "bt-enable", GPIO=
D_OUT_LOW);
> >
> > Why are these optional? Does it make sense to have a qca6390 without
> > both of these gpios connected?
> >
> > Regards,
> > Bjorn
> >
> > > +     if (IS_ERR(ctx->bt_gpio))
> > > +             return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
> > > +                                  "Failed to get the Bluetooth enabl=
e GPIO\n");
> > > +
> > > +     ctx->wlan_gpio =3D devm_gpiod_get_optional(dev, "wlan-enable",
> > > +                                              GPIOD_OUT_LOW);
> > > +     if (IS_ERR(ctx->wlan_gpio))
> > > +             return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
> > > +                                  "Failed to get the WLAN enable GPI=
O\n");
> > > +
> > > +     memset(&config, 0, sizeof(config));
> > > +
> > > +     config.parent =3D dev;
> > > +     config.owner =3D THIS_MODULE;
> > > +     config.drvdata =3D ctx;
> > > +     config.match =3D pwrseq_qca6390_match;
> > > +     config.power_on =3D pwrseq_qca6390_power_on;
> > > +     config.power_off =3D pwrseq_qca6390_power_off;
> > > +
> > > +     ctx->pwrseq =3D devm_pwrseq_device_register(dev, &config);
> > > +     if (IS_ERR(ctx->pwrseq))
> > > +             return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> > > +                                  "Failed to register the power sequ=
encer\n");
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct of_device_id pwrseq_qca6390_of_match[] =3D {
> > > +     {
> > > +             .compatible =3D "qcom,qca6390-pmu",
> > > +             .data =3D &pwrseq_qca6390_of_data,
> > > +     },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, pwrseq_qca6390_of_match);
> > > +
> > > +static struct platform_driver pwrseq_qca6390_driver =3D {
> > > +     .driver =3D {
> > > +             .name =3D "pwrseq-qca6390",
> > > +             .of_match_table =3D pwrseq_qca6390_of_match,
> > > +     },
> > > +     .probe =3D pwrseq_qca6390_probe,
> > > +};
> > > +module_platform_driver(pwrseq_qca6390_driver);
> > > +
> > > +MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>"=
);
> > > +MODULE_DESCRIPTION("QCA6390 PMU power sequencing driver");
> > > +MODULE_LICENSE("GPL");
> > > --
> > > 2.40.1
> > >
> >
>
>
> --
> With best wishes
> Dmitry

