Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA9578167
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiGRL6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 07:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiGRL6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 07:58:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4943E237C7;
        Mon, 18 Jul 2022 04:58:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r14so16709273wrg.1;
        Mon, 18 Jul 2022 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=N3LEH81Z25w75kV+BKHYA+LYSQZAx957Bu+2bYG4ops=;
        b=f2Ylauvh+LZhPDoDV0x7o/4b3NjPF6l+FTWp1u596iItVQHpldDANBkygoG9Vc9z9I
         zGPeLOWMfU1QwfH4BG1fkHWC0ww8chaq198Wj+tTYtdMT8BZU7g65Z4yO9mHJy5j+ZgF
         Z7EYYLtJ+7b/Xab32Id0cpe8Nsgj9BUCr4uC/qluqirfKSSfkKGOKaqUOxwN41a3FQcD
         mBbRTdxtbgXsw9Q+4il1OHhMmijNhLMA6fQDnThQyutB5QBPYa5T6ma99tja+DcbgzJ5
         AM5fp9VW0Qm3mxdkvDC48036GkQ33skupdaYVyCPACrHLdnQAT0eNv8h8To7TBoDMngj
         Nxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=N3LEH81Z25w75kV+BKHYA+LYSQZAx957Bu+2bYG4ops=;
        b=eYuTwmidC4NLyS/PkqNLSRsFw/qIVggSUgaJSsmUnPuLgGTp4XWjUWuFBmKkkGAKEv
         82vBi2wkYj4t95jz7/Zwc+C0yr6pZ9dHB/WYqix4cxu2+c2wOzeESTOPkaZwNRZahD0z
         j/RTxZcilr4IN+2sMG7SviY7Rjtw8I+7wOmTaKJgZw1uVS4kIEFuPgFdUue2bRLR83ak
         33lzPSCdHCNaa4u7Fxd11Dsk2OvVDTBKlfEk3n3vJQkxgmKcJ7r5o0vjuoohTMq/c+mq
         KMqeLXbsexOb8NGnhxrCrj1S69E/dAEOIvar+6q6H4lpZNR+oFLhleoDc0hrwvVBC9uQ
         CIVA==
X-Gm-Message-State: AJIora/HaDNuLrk424ZqeI5LI4U4GbwG48nIHF0opFf6Fr/66ICpfY2S
        5PK9hXWGVjM7VeY2WupZ+nU=
X-Google-Smtp-Source: AGRyM1tbXMbXFgcOTYytep8f60Khh9PMKb8fceNUgo0N+hmSdO6us7eiO9wjKnFwiGLp8fJ3kilKJw==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr2105288wrb.466.1658145487767;
        Mon, 18 Jul 2022 04:58:07 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b003a2fde6ef62sm16198830wmq.7.2022.07.18.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 04:58:07 -0700 (PDT)
Date:   Mon, 18 Jul 2022 12:58:05 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Krzysztof@debian,
        =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220718 due to 'imx6_pcie_host_exit' defined
 but not used
Message-ID: <YtVKzW4vh1nRSqbx@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of alpha, csky, xtensa, riscv, s390 allmodsconfig
have failed to build next-20220718 with the error:


drivers/pci/controller/dwc/pci-imx6.c:973:13: error: 'imx6_pcie_host_exit' defined but not used [-Werror=unused-function]
  973 | static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
      |             ^~~~~~~~~~~~~~~~~~~
drivers/pci/controller/dwc/pci-imx6.c:904:13: error: 'imx6_pcie_stop_link' defined but not used [-Werror=unused-function]
  904 | static void imx6_pcie_stop_link(struct dw_pcie *pci)
      |             ^~~~~~~~~~~~~~~~~~~


--
Regards
Sudip
