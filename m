Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE126787460
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbjHXPhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbjHXPg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 11:36:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11459CEE;
        Thu, 24 Aug 2023 08:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A183B66ADE;
        Thu, 24 Aug 2023 15:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D7DC433C7;
        Thu, 24 Aug 2023 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692891417;
        bh=udpk6Bq8Wx/zflg+ajja1KX//tlMQjqwLZJgeFdW5lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QeC+09CRU2R4oXjg4P5pkAmEtIGMAo6P/+jSP7gz5xXz9HdDYP1MhjvF7Ppz5P/2U
         LG+ZTqoviCFLXc+r1U+B8RUuufLvwWKRbnLNUciJQmHN4tYrDSuKC9I29SHus1E3cl
         CoLEjkuFqSz+Kn+pNdBuxKM4LWgC4lO+S1avKwSLyJP8nx7Ym5RguxvqOaPnbfv0r7
         ewXi3NbDIU3Ecx8kwaZTjqe2P2VDxkXwBZdphfceK5lfQZ+Frg1vfCsE9rJyBo5azf
         UcaZzPkrthi4Uvk8ZXgOJMrfyNG/AOrfOXLk0TvVAQ+TyQ0ow/SAkb7ZNzQn2rDk6M
         tmProyEuMhw5A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v6 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
Date:   Thu, 24 Aug 2023 17:36:48 +0200
Message-Id: <169289132759.77081.8928790286058337767.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623144100.34196-1-james.quinlan@broadcom.com>
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
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

On Fri, 23 Jun 2023 10:40:53 -0400, Jim Quinlan wrote:
> v6 -- No code has been changed.
>    -- Changed commit subject and comment in "#PERST" commit (Bjorn, Cyril)
>    -- Changed sign-off and author email address for all commits.
>       This was due to a change in Broadcom's upstreaming policy.
> 
> v5 -- Remove DT property "brcm,completion-timeout-us" from
>       "DT bindings" commit.  Although this error may be reported
>       as a completion timeout, its cause was traced to an
>       internal bus timeout which may occur even when there is
>       no PCIe access being processed.  We set a timeout of four
>       seconds only if we are operating in "L1SS CLKREQ#" mode.
>    -- Correct CEM 2.0 reference provided by HW engineer,
>       s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
>    -- Add newline to dev_info() string (Stefan)
>    -- Change variable rval to unsigned (Stefan)
>    -- s/implementaion/implementation/ (Bjorn)
>    -- s/superpowersave/powersupersave/ (Bjorn)
>    -- Slightly modify message on "PERST#" commit.
>    -- Rebase to torvalds master
> 
> [...]

Applied to controller/brcmstb, thanks!

[4/5] PCI: brcmstb: Assert PERST# on BCM2711
      https://git.kernel.org/pci/pci/c/8eb8c2735306
[5/5] PCI: brcmstb: Remove stale comment
      https://git.kernel.org/pci/pci/c/6dac1507a654

Thanks,
Lorenzo
