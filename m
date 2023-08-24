Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F359E7869D4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjHXIQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbjHXIPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 04:15:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFB719BB;
        Thu, 24 Aug 2023 01:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D6C8617A3;
        Thu, 24 Aug 2023 08:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7716C433C8;
        Thu, 24 Aug 2023 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692864886;
        bh=1Tn6vKJJFKlBGjG8QtuFgkvRlH6W9nCtGYntwAHYyns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DROKImggRM845E0c2tdxVMg6dQJUjn+LhQAhJJ6H+ovC9cECv7K+wabfNVTnZMcrF
         ykqTm4Iagwnm95y7fivs0qr4lx5z2D6Q8QgQZguyOqttsovsbX+Zcpn096NxV6j09X
         L3miw0LeHd8LR5qQ662RwztEWxVHwegyw/QOS3WWAnvC3D9JYP4NdXS1I0WKPXjMCI
         Zz/kQ9D4wDiKM8/MK+N0jI83eTeToNcPipI6OVPL0HV/xIR93RrR097wkdm1k1tyqx
         vX9EG42PHo3pbBDe4l/1w2lpreaiz860nnpxYySWCJo2AnxJMUooLYn/DomglZvLZy
         M+VOS3t7+uTOA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     frank.li@nxp.com, Frank Li <Frank.Li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, Zhiqiang.Hou@nxp.com,
        bhelgaas@google.com, imx@lists.linux.dev,
        kernel-janitors@vger.kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mani@kernel.org, markus.elfring@web.de, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, robh@kernel.org, roy.zang@nxp.com,
        xiaowei.bao@nxp.com
Subject: Re: [PATCH v4 1/2] PCI: layerscape: Add support for Link down notification
Date:   Thu, 24 Aug 2023 10:14:38 +0200
Message-Id: <169286486358.59705.3375218028619595727.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720135834.1977616-1-Frank.Li@nxp.com>
References: <20230720135834.1977616-1-Frank.Li@nxp.com>
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

On Thu, 20 Jul 2023 09:58:33 -0400, Frank Li wrote:
> Add support to pass Link down notification to Endpoint function driver
> so that the LINK_DOWN event can be processed by the function.
> 
> 

Applied to controller/layerscape, thanks!

[1/2] PCI: layerscape: Add support for Link down notification
      https://git.kernel.org/pci/pci/c/d28c0d84ca40
[2/2] PCI: layerscape: Add the workaround for lost link capabilities during reset.
      https://git.kernel.org/pci/pci/c/17cf8661ee0f

Thanks,
Lorenzo
