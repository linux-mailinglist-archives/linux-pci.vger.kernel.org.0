Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4D62590E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiKKLFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 06:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiKKLFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 06:05:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EA25B589;
        Fri, 11 Nov 2022 03:05:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3BA261F83;
        Fri, 11 Nov 2022 11:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D694C433D6;
        Fri, 11 Nov 2022 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668164729;
        bh=zlBh2VdhyvqElXEAO6Y0TMtsYvd3nZ/sIuAN9KvrMos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rd3ExrQd0KjA6kCWtKmk26yIZRP9rKqsaep/rHAFYdxYl7xygvecg6fuG6RNhiCMj
         j9Aqa2LksMBV2S751HWnYy5HBDh/lLV5RAlqBg7sbzztW72uUL8uzxvrdItfNVm1Zn
         xh0IDAM90GKq5AnwOfPeP794F3x2Q2/BFbYO/2Vai9kDSuwwntL17lGxtfZT7ELaRK
         DU1LzKt4eAym3nOdPwVzy3jA/D3FhTvye8WR6xUdsB5b5FVWLyBvEUIdJoPUUyzF/v
         3HaYU5cQPHigy4d6L+ot8qlC+34i0S+wNIEG+8/so8bkltDmoOjZaFlqQ++Qdl7qBl
         iO+x6d2LLnoLg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     stanimir.k.varbanov@gmail.com,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: qcom: Add basic interconnect support
Date:   Fri, 11 Nov 2022 12:05:21 +0100
Message-Id: <166816471099.204787.7345411669811218298.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102090705.23634-1-johan+linaro@kernel.org>
References: <20221102090705.23634-1-johan+linaro@kernel.org>
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

On Wed, 2 Nov 2022 10:07:03 +0100, Johan Hovold wrote:
> On Qualcomm platforms like SC8280XP and SA8540P interconnect bandwidth
> must be requested before enabling interconnect clocks.
> 
> Add basic support for managing an optional "pcie-mem" interconnect path
> by setting a low constraint before enabling clocks and updating it after
> the link is up.
> 
> [...]

Applied to pci/qcom, thanks!

[1/2] dt-bindings: PCI: qcom: Add SC8280XP/SA8540P interconnects
      https://git.kernel.org/lpieralisi/pci/c/3a936b2a5a58
[2/2] PCI: qcom: Add basic interconnect support
      https://git.kernel.org/lpieralisi/pci/c/c4860af88d0c

Thanks,
Lorenzo
