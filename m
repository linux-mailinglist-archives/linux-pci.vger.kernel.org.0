Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C256F1D4987
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 11:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgEOJ2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 05:28:17 -0400
Received: from mx.socionext.com ([202.248.49.38]:29503 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgEOJ2Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 05:28:16 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 May 2020 18:28:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id E2B71180B60;
        Fri, 15 May 2020 18:28:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 15 May 2020 18:28:14 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 580F41A15C4;
        Fri, 15 May 2020 18:28:14 +0900 (JST)
Received: from [10.213.29.28] (unknown [10.213.29.28])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 6BDE612013D;
        Fri, 15 May 2020 18:28:13 +0900 (JST)
Subject: Re: [PATCH 5/5] PCI: uniphier: Add error message when failed to get
 phy
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1589518105-18368-6-git-send-email-hayashi.kunihiko@socionext.com>
 <202005151454.wRtXzaiY%lkp@intel.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <e41c81f6-837a-e07a-458a-d388f373cb41@socionext.com>
Date:   Fri, 15 May 2020 18:28:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202005151454.wRtXzaiY%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/05/15 15:51, kbuild test robot wrote:
> Hi Kunihiko,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on pci/next]
> [also build test WARNING on robh/for-next v5.7-rc5 next-20200514]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Kunihiko-Hayashi/PCI-uniphier-Add-features-for-UniPhier-PCIe-host-controller/20200515-125031
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> In file included from include/linux/device.h:15:0,
> from include/linux/pci.h:37,
> from drivers/pci/controller/dwc/pcie-uniphier.c:18:
> drivers/pci/controller/dwc/pcie-uniphier.c: In function 'uniphier_pcie_probe':
>>> drivers/pci/controller/dwc/pcie-uniphier.c:470:16: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Wformat=]
> dev_err(dev, "Failed to get phy (%d)n", PTR_ERR(priv->phy));
> ^
> include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
> #define dev_fmt(fmt) fmt
> ^~~
>>> drivers/pci/controller/dwc/pcie-uniphier.c:470:3: note: in expansion of macro 'dev_err'
> dev_err(dev, "Failed to get phy (%d)n", PTR_ERR(priv->phy));
> ^~~~~~~

This should be fixed. I'll fix it in v2.

Thanks,

---
Best Regards
Kunihiko Hayashi
