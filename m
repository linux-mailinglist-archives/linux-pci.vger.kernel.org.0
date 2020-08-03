Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8919D23A322
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHCLKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 07:10:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38511 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCLKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 07:10:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id 140so20233278lfi.5;
        Mon, 03 Aug 2020 04:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVlqnbhGeE/kEX8giPA2WMnSp+K7doLgjgnP7NlrDCA=;
        b=p4+V4X5WwoKdOmcD5vJCA8RELrMbHB9LRjPgOl/WNS7kmHrtwVaxP6CQ6MKguA+KPi
         g5VcTbdZJMiAmx9H8SOZLLUzQKEemAVLj6PyHeEFuAhJdcXz2Jy8O62f7E2Vcs5r/uLL
         J6mYuAS5nWwOvCnkgXNQ5kPP13Zq5N3Cwg3CBsjOzlY3vTgNXDng+1a6DdQojDrJTJma
         mBVlbAPnpBq75rO1o7LrYMD+sCbhEYtB3Cq2iDjAhnBpS2xOY0gA4x73CnEa3bXzgrKQ
         zRhLs732KTRyl0YeaK2XfAVwGdJe0/28jkInhAlzGHftjPh8QacTZmG64Dw/wJkYl6ro
         4dSw==
X-Gm-Message-State: AOAM530L1aM1ZCCjNOAyFZeRrs0PF9z+5NNo1wq5UcGYsbxKzwH1Bijb
        9AzQM/+0jKWIKwmKb1NhXx8=
X-Google-Smtp-Source: ABdhPJwDn1LIRAkaOQfRhdgLpHGi10SbVqsf2QNj2hkXkIp0DxOdq2YHuUrtx962TLKrOo25eXPOGQ==
X-Received: by 2002:ac2:5338:: with SMTP id f24mr8306483lfh.5.1596453041410;
        Mon, 03 Aug 2020 04:10:41 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y19sm4704991lfe.77.2020.08.03.04.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:10:40 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:10:39 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        rfi@lists.rocketboards.org
Subject: Re: [PATCH 00/10] Remove surplus dev_err() when handing an error
 from platform_get_irq()
Message-ID: <20200803111039.GA90692@rocinante>
References: <20200802142601.1635926-1-kw@linux.com>
 <20200803020151.GA291575@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803020151.GA291575@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-08-02 21:01:51, Bjorn Helgaas wrote:

Hi Bjorn,

[...]
>
> I squashed these together and applied them to pci/irq-error for v5.9,
> thanks!

Thank you!

> The cover letter claims there should be 10 patches, but I only got 9.
> Just FYI.

There indeed should be 10 patches.  I sent the missing one (not should
why it didn't go through) this morning making sure it falls under the
thread with the cover letter.

Sorry about that!

The missing patch can be seen here:
  https://patchwork.kernel.org/patch/11697463/

Krzysztof
