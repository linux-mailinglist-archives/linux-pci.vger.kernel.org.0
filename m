Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658396EA7CC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjDUKEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 06:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjDUKEW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 06:04:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99CF5FE6;
        Fri, 21 Apr 2023 03:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5167764FB0;
        Fri, 21 Apr 2023 10:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DC5C433D2;
        Fri, 21 Apr 2023 10:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682071460;
        bh=g3WHW+xRgwO3ZHAUrKODgElvqmfjuqfmpZpWonWjEOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOiuR7FV67WxFwGwxkgMPC4g8g/xlpD9SLtIFFTyYg+TQfRsUXNZsWyoew9NrKzQJ
         p/cglKug0my+LAlIQN7ZarZsK9giXZ1PhevEpOs69drgTDBkcVZ1MUEVbo+ZW53XNd
         CEuYUBUc8tcpxIdIEr4m5kNp/U82qONDgNzBrZlKNYZc5u4gMJEyJ9X7fkFq9jk9/m
         Y9j2fZ6rukWvOCfRH+SL7yQ78YcMCM+iAC+IibCWPEz2ftpMtXHZnx3AMk53FZbzp1
         jhIGCm+X/P9aidjfywCs4JnHccIpInQMFZag0rY2jQIb/ksrKLBdp/u+49S//z5/SH
         pwQ+FKxbDiAkA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, kw@linux.com,
        robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/5] Add PCIe EP support for SDX65
Date:   Fri, 21 Apr 2023 12:04:13 +0200
Message-Id: <168207144110.82183.2405271863357510101.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 31 Mar 2023 11:48:17 +0530, Rohit Agarwal wrote:
> Changes in v5:
>  - Addressed some minor comments from Konrad
>  - Rebased on top of 6.3-rc5.
> 
> Changes in v4:
>  - Addressed comment from Dmitry to move the gpios to the board file.
> 
> [...]

Applied to controller/dt, thanks!

[1/5] dt-bindings: PCI: qcom: Add SDX65 SoC
      https://git.kernel.org/pci/pci/c/661a7e9aa551

Thanks,
Lorenzo
