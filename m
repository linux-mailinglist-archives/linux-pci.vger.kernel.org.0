Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BD330DDFA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhBCPVQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 10:21:16 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33981 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhBCPSp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 10:18:45 -0500
Received: by mail-wr1-f53.google.com with SMTP id g10so24793802wrx.1;
        Wed, 03 Feb 2021 07:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8cy511fPN0zMtLnY1N3mRqUzrgghWD2gteAENtqOr4=;
        b=ddm/WiyFEVCmAw/Tyo/um9mEUCsRL7EaLP3Y38MMf38ykoez1Hco1tTzz0DaGjNtEf
         1U9RQVKNrwpuiunfnY5hn0JHMh2q6hfwT3Ig8BJbhAPV+Z86YT9UsF+67bf8xKAwYTzA
         /kALgCb2wG7G5KuNt60BHyXfghOB6b05ATg7ukPGxZsik0wj0eH2sEQ5+dllLhXTMOXm
         3yN/CMzkIgKKVATG23MpaXxe4LJ5TjBZj38FvSCyjTYGdpsRfoX3QIKFdVB6I0Eb4Vv8
         r0r8V6hTGO+/OuRgxFVQymwSCQBOUmFInWqYHHiayFEpT3iY2bRn4aQDrHscWRwwYm1v
         pNQw==
X-Gm-Message-State: AOAM531apDiVr4M8rbkTn6/ahw7F9aczEPpypU4CSZ0C9RT/+oirs9yI
        ir82I0lgL9d99NdpdD9KXno=
X-Google-Smtp-Source: ABdhPJxHYufoQCzPYGt5wA9ljcUG0KO5NravuBCruERtSdbtgmaOFdPvrIVqBsYfFNUMoI+Pb198iw==
X-Received: by 2002:adf:fb0c:: with SMTP id c12mr4151714wrr.6.1612365483472;
        Wed, 03 Feb 2021 07:18:03 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p18sm3042799wmc.31.2021.02.03.07.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:18:02 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:18:01 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/11] PCI: dwc: pcie-kirin: allow using multiple
 reset GPIOs
Message-ID: <YBq+qaOwJdNOllQ/@rocinante>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
 <4fb97b1fc3fe6df9a2fea8f96bdef433e75463a6.1612335031.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fb97b1fc3fe6df9a2fea8f96bdef433e75463a6.1612335031.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Mauro,

Thank you for working on this!

> @@ -151,8 +152,10 @@ struct kirin_pcie {
>       struct clk      *phy_ref_clk;
>       struct clk      *pcie_aclk;
>       struct clk      *pcie_aux_clk;
> -     int             gpio_id_reset[4];
> +     int             n_gpio_resets;
>       int             gpio_id_clkreq[3];
> +     int             gpio_id_reset[MAX_GPIO_RESETS];
> +     const char      *reset_names[MAX_GPIO_RESETS];
>       u32             eye_param[5];
>  };
[...]

A small nit, so feel free to ignore, of course.

The "n_gpio_resets" variable might be better as "gpio_resets_num" or
"gpio_resets_count" - both are popular name suffixes for that type of
variables.  To add, other variables also start with "gpio_", thus it
would also follow the naming pattern.

[...]
> +     kirin_pcie->n_gpio_resets = of_gpio_named_count(np, "reset-gpios");
[...]

This would then become (for example):

  kirin_pcie->gpio_resets_count = of_gpio_named_count(np, "reset-gpios");

Krzysztof
