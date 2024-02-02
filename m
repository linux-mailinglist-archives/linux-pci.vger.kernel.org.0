Return-Path: <linux-pci+bounces-2983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979AF8469C2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2CF1F2141D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B385D17BAC;
	Fri,  2 Feb 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwAZMPm1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02371775E
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860109; cv=none; b=b2l8sjepXk6yGWpOPXStvB+EapvrbgJXZ3lo6ef5J7jRV0S7GAkdka7oUEnYvZMsQ2LJBFU+fj+z7/V8JnCzBQCo8Ocx1g3oG/0XByRE+V7Iua9rXNOUc+5AVOu9wdhhSfQ7YeXLkrME8wx7gUkjQgs9XTgPyHVxplw9s2hcfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860109; c=relaxed/simple;
	bh=PWfp4xkBJdGUzS52EvSOFxQNL6CO/bBPbQGZzX+mIMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWwVotI/6Z7vFnm4ayTBYa3mfA6zMwh7+o+VIlBoi+8ychFbL8NktSRBAFN2m2lM9IX5TGH8RdCcrJJCfGGOYU1LGlcmXh8pc7xlCgbKuN1fOTHAPqtiC7u/UCBs6YdknWKWduX7rE5gIibxL3oFYKyFalzJdfd4S4BYGbpFeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hwAZMPm1; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60425a9a3d1so9080387b3.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 23:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706860107; x=1707464907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TJQgiKqrOb3r+YKxG9h8sT6Vjw46idLsAfVWVv8gpGs=;
        b=hwAZMPm1li//uTQXfPtksvcSzl3walHxNTZTxD1Uw3KGlJSKB5QIe9XCop18bBYScI
         35xxwdO3yv6D7dd9K2xVMKtQYZgL3brDmVXGwLxD+5MiXZau+oG6jnWwNLukEEOJ0gw4
         mAub88xlD8r/aXlsxS4BIKKkkSC9H8HOuki9GVGRdkP0AKE6n8G3NIxJSlhnldybRpRI
         D3wmrY/vq0c7RX7TWa/nhQ4Hfi07tPwcCmVul9JlmVBPgfYs6Cm6l/TF8LFMMjqkwQkL
         wTtwO4WpNTfWJCacFlL+d29GFjx6DQCvMHsqyXLhiXm/2ijatFl5ydWEUcyA3+MhwxJB
         WP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860107; x=1707464907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJQgiKqrOb3r+YKxG9h8sT6Vjw46idLsAfVWVv8gpGs=;
        b=bXiV0mU3Qthe5Oa+xqLu0Kaaw2UICPYPwqlzY5Yv1tnaod2hzdNY+UfxLkNWUafzI1
         9jyuBg3h5T1sct4UNdx/2Y/yPLyfW3uFSr1vFhF4h1N6uxuFXhA11dDGLR2shwDornwH
         Exgxw7Bu5mdDgajz2Z/0p5aRTN3949Lq3ufwN6t1lwTAFFCsNtNcp6Ci3mguMH2/Wdop
         YXAFsuLq0queiHo7hos2JETDEDuGYGc5fqt/UIwaJiEPrGEIJAafzzDwO5fftzrwJuiP
         BSfeaEXU0qarcD2SmrS8WdsYOXOMZTcD47WwhWXi/5drL9ldCZTUeo1wl18CaEYgsWC9
         wldA==
X-Gm-Message-State: AOJu0YzNjgnGj1zvn+yOaba2qK3HHrlJvypc9QT8YxwuV2ToSt7tgCFr
	zG2zEwD9Zei90Kil3vJDENOv1CECgBSo8GK5xg8nS/7CVjeCY8JY0k75zkOlUH07cpcZsMMZjBf
	DnQov13HZ92B3wxAT0bIjoLkf3CxxPJM7D8/bwA==
X-Google-Smtp-Source: AGHT+IGrHs4qazO/HCg2YmtckOBIA8NBN4PLysf9FGMWXDeQbOEqVv/3wfdQjEIv9Nuq8rCj4i25/qhBTj14wOfgWgc=
X-Received: by 2002:a05:690c:24b:b0:602:b7d3:9314 with SMTP id
 ba11-20020a05690c024b00b00602b7d39314mr6621473ywb.35.1706860106739; Thu, 01
 Feb 2024 23:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-5-brgl@bgdev.pl>
 <ys45p7mdiur4liwzlexqm3aji7iz5panpb73ixg34wcio2qbvz@wkjcyazbzb4p>
In-Reply-To: <ys45p7mdiur4liwzlexqm3aji7iz5panpb73ixg34wcio2qbvz@wkjcyazbzb4p>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 2 Feb 2024 09:48:15 +0200
Message-ID: <CAA8EJpo7LwG2Kt0JSPc=MazWUme3YVmKHa9Fr6jc=NrZirEYUg@mail.gmail.com>
Subject: Re: [RFC 4/9] power: pwrseq: add a driver for the QCA6390 PMU module
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
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

On Fri, 2 Feb 2024 at 06:54, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Thu, Feb 01, 2024 at 04:55:27PM +0100, Bartosz Golaszewski wrote:
> > diff --git a/drivers/power/sequencing/pwrseq-qca6390.c b/drivers/power/sequencing/pwrseq-qca6390.c
> [..]
> > +static int pwrseq_qca6390_power_on(struct pwrseq_device *pwrseq)
> > +{
> > +     struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
> > +     int ret;
> > +
> > +     ret = regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
> > +     if (ret)
> > +             return ret;
> > +
> > +     gpiod_set_value_cansleep(ctx->bt_gpio, 1);
> > +     gpiod_set_value_cansleep(ctx->wlan_gpio, 1);
>
> So it's no longer possible to power these independently?

I'd second this, there must be a way to power them on and off
separately. In the end, this provides a good way to restart the BT
core if it gets sick.

>
> > +
> > +     if (ctx->pdata->pwup_delay_msec)
> > +             msleep(ctx->pdata->pwup_delay_msec);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pwrseq_qca6390_power_off(struct pwrseq_device *pwrseq)
> > +{
> > +     struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
> > +
> > +     gpiod_set_value_cansleep(ctx->bt_gpio, 0);
> > +     gpiod_set_value_cansleep(ctx->wlan_gpio, 0);
> > +
>
> The answer that was provided recently was that the WiFi and BT modules
> absolutely must be modelled together, because there must be a 100ms
> delay between bt_gpio going low and wlan_gpio going high.

For the reference, it was for the QCA6490 (not QCA6390, next
revision), which maps to WCN6855.


>
> If you're not going to address that concern, then I fail to see the
> reason for adding the power sequence framework - just let the BT and
> PCI power control (WiFi) do their thing independently.
>
> > +     return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
> > +}
> > +
> > +static int pwrseq_qca6390_match(struct pwrseq_device *pwrseq,
> > +                             struct device *dev)
> > +{
> > +     struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_data(pwrseq);
> > +     struct device_node *dev_node = dev->of_node;
> > +
> > +     /*
> > +      * The PMU supplies power to the Bluetooth and WLAN modules. both
> > +      * consume the PMU AON output so check the presence of the
> > +      * 'vddaon-supply' property and whether it leads us to the right
> > +      * device.
> > +      */
> > +     if (!of_property_present(dev_node, "vddaon-supply"))
> > +             return 0;
> > +
> > +     struct device_node *reg_node __free(of_node) =
> > +                     of_parse_phandle(dev_node, "vddaon-supply", 0);
> > +     if (!reg_node)
> > +             return 0;
> > +
> > +     /*
> > +      * `reg_node` is the PMU AON regulator, its parent is the `regulators`
> > +      * node and finally its grandparent is the PMU device node that we're
> > +      * looking for.
> > +      */
> > +     if (!reg_node->parent || !reg_node->parent->parent ||
> > +         reg_node->parent->parent != ctx->of_node)
> > +             return 0;
>
> Your DeviceTree example gives a sense that a set of supplies feeds the
> PMU, which then supplies power to the BT and WiFi nodes through some
> entity that can switch power on and off, and adjust the voltage level.
>
> Then comes this function, which indicates that the DeviceTree model was
> just for show.
>
> > +
> > +     return 1;
> > +}
> > +
> > +static int pwrseq_qca6390_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct pwrseq_qca6390_ctx *ctx;
> > +     struct pwrseq_config config;
> > +     int ret, i;
> > +
> > +     ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +     if (!ctx)
> > +             return -ENOMEM;
> > +
> > +     ctx->of_node = dev->of_node;
> > +
> > +     ctx->pdata = of_device_get_match_data(dev);
> > +     if (!ctx->pdata)
> > +             return dev_err_probe(dev, -ENODEV,
> > +                                  "Failed to obtain platform data\n");
> > +
> > +     if (ctx->pdata->vregs) {
> > +             ctx->regs = devm_kcalloc(dev, ctx->pdata->num_vregs,
> > +                                      sizeof(*ctx->regs), GFP_KERNEL);
> > +             if (!ctx->regs)
> > +                     return -ENOMEM;
> > +
> > +             for (i = 0; i < ctx->pdata->num_vregs; i++)
> > +                     ctx->regs[i].supply = ctx->pdata->vregs[i].name;
> > +
> > +             ret = devm_regulator_bulk_get(dev, ctx->pdata->num_vregs,
> > +                                           ctx->regs);
> > +             if (ret < 0)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "Failed to get all regulators\n");
> > +
> > +             for (i = 0; i < ctx->pdata->num_vregs; i++) {
> > +                     if (!ctx->pdata->vregs[1].load_uA)
> > +                             continue;
> > +
> > +                     ret = regulator_set_load(ctx->regs[i].consumer,
> > +                                              ctx->pdata->vregs[i].load_uA);
> > +                     if (ret)
> > +                             return dev_err_probe(dev, ret,
> > +                                                  "Failed to set vreg load\n");
> > +             }
> > +     }
> > +
> > +     ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
>
> Why are these optional? Does it make sense to have a qca6390 without
> both of these gpios connected?
>
> Regards,
> Bjorn
>
> > +     if (IS_ERR(ctx->bt_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
> > +                                  "Failed to get the Bluetooth enable GPIO\n");
> > +
> > +     ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> > +                                              GPIOD_OUT_LOW);
> > +     if (IS_ERR(ctx->wlan_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
> > +                                  "Failed to get the WLAN enable GPIO\n");
> > +
> > +     memset(&config, 0, sizeof(config));
> > +
> > +     config.parent = dev;
> > +     config.owner = THIS_MODULE;
> > +     config.drvdata = ctx;
> > +     config.match = pwrseq_qca6390_match;
> > +     config.power_on = pwrseq_qca6390_power_on;
> > +     config.power_off = pwrseq_qca6390_power_off;
> > +
> > +     ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
> > +     if (IS_ERR(ctx->pwrseq))
> > +             return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> > +                                  "Failed to register the power sequencer\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id pwrseq_qca6390_of_match[] = {
> > +     {
> > +             .compatible = "qcom,qca6390-pmu",
> > +             .data = &pwrseq_qca6390_of_data,
> > +     },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, pwrseq_qca6390_of_match);
> > +
> > +static struct platform_driver pwrseq_qca6390_driver = {
> > +     .driver = {
> > +             .name = "pwrseq-qca6390",
> > +             .of_match_table = pwrseq_qca6390_of_match,
> > +     },
> > +     .probe = pwrseq_qca6390_probe,
> > +};
> > +module_platform_driver(pwrseq_qca6390_driver);
> > +
> > +MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
> > +MODULE_DESCRIPTION("QCA6390 PMU power sequencing driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.40.1
> >
>


--
With best wishes
Dmitry

