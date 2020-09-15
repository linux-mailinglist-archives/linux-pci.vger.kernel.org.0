Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AECC26A1D1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 11:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgIOJNS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 05:13:18 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41977 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgIOJNB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 05:13:01 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CB43822708;
        Tue, 15 Sep 2020 11:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600161175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2P5NgU0B9AjWYC5q+V3Ti4erlurb01RNNs/ekO5kyz4=;
        b=Gmmwa8SaNq1wBjgmtbx23XQ4Aq+GkGLeJlA4UeC3ZaWzH1qGxK9dFUBOmbF1lddi3yip+W
        4Hv+k+gC8x+sDVQnS5zAzIdZMndJFqFUt7ClVJhvzrUOwTpCo9s/8/hFo9w+Azsq37lK5o
        ArWMyV0/CqU5KBo6YGZcLMw2FgrRGas=
From:   Michael Walle <michael@walle.cc>
To:     robh@kernel.org
Cc:     agross@kernel.org, bhelgaas@google.com, bjorn.andersson@linaro.org,
        eswara.kota@linux.intel.com, festevam@gmail.com,
        gustavo.pimentel@synopsys.com, hayashi.kunihiko@socionext.com,
        hongxing.zhu@nxp.com, jbrunet@baylibre.com,
        jesper.nilsson@axis.com, jingoohan1@gmail.com,
        jonathanh@nvidia.com, jonnyc@amazon.com, kernel@pengutronix.de,
        kgene@kernel.org, khilman@baylibre.com, kishon@ti.com,
        krzk@kernel.org, l.stach@pengutronix.de,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-imx@nxp.com,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        lorenzo.pieralisi@arm.com, m-karicheri2@ti.com,
        martin.blumenstingl@googlemail.com, maz@kernel.org,
        narmstrong@baylibre.com, pratyush.anand@gmail.com,
        s.hauer@pengutronix.de, shawn.guo@linaro.org, shawnguo@kernel.org,
        songxiaowei@hisilicon.com, svarbanov@mm-sol.com,
        thierry.reding@gmail.com, wangbinghui@hisilicon.com,
        yamada.masahiro@socionext.com, yue.wang@Amlogic.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 00/40] PCI: dwc: Driver clean-ups
Date:   Tue, 15 Sep 2020 11:12:18 +0200
Message-Id: <20200915091218.28737-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

> This is a series of clean-ups for the Designware PCI driver. The series
> initially reworks the config space accessors to use the existing pci_ops
> struct. Then there's removal of various private data that's also present
> in the pci_host_bridge struct. There's also some duplicated common (PCI
> and DWC) register defines which I converted to use the common defines.
> Finally, the initialization for speed/gen, number of lanes, and N_FTS
> are all moved to the common DWC code.

> This is compile tested only as I don't have any DWC based h/w, so any
> testing would be helpful. A branch is here[1].

I've noticed that with the latest linux-next, my board doesn't boot
anymore. I've traced it back to this series. There is a similar
board in kernelci [1,2] where you can have a look at the backtrace.

I've bisected this to the following patch:
  PCI: dwc: Use generic config accessors

I'm pretty much lost here. It seems that the kernel tries to read from
an invalid/unmapped memory address.

[1] https://kernelci.org/test/plan/id/5f5f4992d1c53777a0a6092d/
[2] https://storage.kernelci.org/next/master/next-20200914/arm64/defconfig/gcc-8/lab-nxp/baseline-fsl-ls1028a-rdb.txt

-michael
