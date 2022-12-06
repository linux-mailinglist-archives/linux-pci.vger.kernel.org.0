Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE8644304
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLFMTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 07:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFMTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 07:19:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4428E06;
        Tue,  6 Dec 2022 04:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57B10B819EB;
        Tue,  6 Dec 2022 12:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598CDC433D6;
        Tue,  6 Dec 2022 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670329176;
        bh=vW4Gpd5nCpDVTZ5xDTwUCirFzEPcdNAVJCKHtQyR0Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWGuZambFTH74Yr6SM508WXkiwDfTLPOAb2xY+ry4wdvA8iYct1ffKwj74q6QI2F/
         /EU+ekkjyUieSlA8k93DPJXWo2rbIHif7vRmrB5aKT2GfgybAoamqD6kr81a9LsJBF
         3zAGQNNZuzLkJpYQtjMe8qZWPucNgzX+IdWrpm0NFHppQMgzG7cqfkgWGp0lyb+dyb
         mZUlEtDFKlKEXf6A+Y98o5oQxsa92USJ0JCxWgmwNgGI6D842qY7N82OH5//hLFBF9
         O92XYG4KDhKIFFCrvClNRYaZo3gYBg18+/fXrSViKnsEqIeA2gqZDTZqoL0ifs1a99
         opx6xjAG2Rc4Q==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'dma-coherent' property
Date:   Tue,  6 Dec 2022 13:19:29 +0100
Message-Id: <167032915187.72267.2258175808608397182.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205094530.12883-1-johan+linaro@kernel.org>
References: <20221205094530.12883-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 5 Dec 2022 10:45:30 +0100, Johan Hovold wrote:
> Devices on some PCIe buses may be cache coherent and must be marked as
> such in the devicetree to avoid data corruption.
> 
> This is specifically needed on recent Qualcomm platforms like SC8280XP.
> 
> 

Applied to pci/qcom, thanks!

[1/1] dt-bindings: PCI: qcom: Allow 'dma-coherent' property
      https://git.kernel.org/lpieralisi/pci/c/74eac50391ce

Thanks,
Lorenzo
