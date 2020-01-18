Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1168B14186D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2020 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgARQgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jan 2020 11:36:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39289 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgARQgb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jan 2020 11:36:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so10573630wmj.4;
        Sat, 18 Jan 2020 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rYU4lKJZz8jrmAECEotQPYwMWUzBimgsvUxqlI2dv1k=;
        b=eMs7U+f0WTVzLTGS3JpZuOspADfN/RH4GPEaLFXau9e7PlwXVGxW/i/z6GcAEc3s/c
         2R1d9PihI4ijay5hnM+xZBEusLA3RmIlIdcxND65O7RzjJYdvlGuIDlyssCC8PoCub1u
         xzJ/yKbpRO1U0jeYkaOCYS7qrskqsb3Q34OtTXVeFsw/LZ/rdqdTR7Ju6Zj66Y0q6XoX
         9sm1jU4C+urIjrvuJQFMAnaywuBm7D7yzdrkUGFs/o9bC8kSzuMmc43EEUqsqlDf28pt
         uNofFHmFp+gDxBHlYoIZ7bYtJZ1QAkAailZFt5nlM05nGQV3T5/qyDlPwPWJF+Jk0xaz
         UL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rYU4lKJZz8jrmAECEotQPYwMWUzBimgsvUxqlI2dv1k=;
        b=EjqcUdRQkzciNmVd2Fm8WJTsGc3jSBNfHJpxd5sJ5sNR8CL4UzoufAVsPfK1xOfOLp
         lLbhrjWcg5BpO2BujDCfhWtuZ8Rm4brsAkeZgdNa7idrmYa20EIkpZh7UeAMAk+HI3g3
         RWQcP1KJKpZxBkSfYHUkp90RsEVEBzGat0YjCFvcVTR+g2Y79Y+JjVaRjfFf3Kb7plhW
         SdgHTETDFip+toknX2i0jZ7sXd+ZIkOun+lWqauOJSvShRM+WlH1PdmtrvXC5YPbQHas
         py/G8vP7HhitUIiDFpk7nTLm3xYAGKf9p7zJxiR76i+wavA8mEAcq4XxulfZkDpj3tWQ
         WpRg==
X-Gm-Message-State: APjAAAWK6s0eGs+s3ll5GHiWsqfGos6cuiCyIlvpeAv8m577QN9uEg75
        xNbLAFKXhI/qOvIB+Ccnnwk=
X-Google-Smtp-Source: APXvYqx7Ck4c3p5eVRuk5D9QilKU9w2oGrZ1Mo95ReXz+vTsLujg+C91uSTkkkCyU6bRQGrd+OnOeA==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr10731975wmj.175.1579365389079;
        Sat, 18 Jan 2020 08:36:29 -0800 (PST)
Received: from [192.168.1.94] (93-41-244-45.ip84.fastwebnet.it. [93.41.244.45])
        by smtp.gmail.com with ESMTPSA id x10sm39099676wrp.58.2020.01.18.08.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jan 2020 08:36:28 -0800 (PST)
Subject: Re: [PATCH 5/6] PCI: rockchip: add DesignWare based PCIe controller
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     devicetree@vger.kernel.org, Simon Xue <xxm@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
 <1578986701-72072-1-git-send-email-shawn.lin@rock-chips.com>
From:   Francesco Lavra <francescolavra.fl@gmail.com>
Message-ID: <0975b4e4-4bee-3f8e-5276-2bc78e6dabc0@gmail.com>
Date:   Sat, 18 Jan 2020 17:36:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1578986701-72072-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/14/20 8:25 AM, Shawn Lin wrote:
> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->pci->dev;
> +	struct property *prop;
> +	const char *name;
> +	int ret, count, i = 0;
> +
> +	count = of_property_count_strings(dev->of_node, "reset-names");
> +	if (count < 1)
> +		return -ENODEV;
> +
> +	rockchip->rsts = devm_kcalloc(dev, count,
> +				     sizeof(struct reset_bulk_data),
> +				     GFP_KERNEL);
> +	if (!rockchip->rsts)
> +		return -ENOMEM;
> +
> +	of_property_for_each_string(dev->of_node, "reset-names",
> +				    prop, name) {
> +		rockchip->rsts[i].id = name;
> +		if (!rockchip->rsts[i].id)
> +			return -ENOMEM;
> +		i++;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		rockchip->rsts[i].rst = devm_reset_control_get_exclusive(dev,
> +						rockchip->rsts[i].id);
> +		if (IS_ERR_OR_NULL(rockchip->rsts[i].rst)) {
> +			dev_err(dev, "failed to get %s\n",
> +				rockchip->clks[i].id);
> +			return -PTR_ERR(rockchip->rsts[i].rst);

IS_ERR_OR_NULL() should be replaced with IS_ERR(), because 
devm_reset_control_get_exclusive() never returns a NULL value.
Also, in case of error you should return the value from PTR_ERR(), 
without the minus sign.
