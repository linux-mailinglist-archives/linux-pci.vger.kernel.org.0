Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E175363653D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 17:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiKWQEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 11:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiKWQEV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 11:04:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BC2BC3
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 08:04:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7330961DB2
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 16:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D55C433C1;
        Wed, 23 Nov 2022 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669219459;
        bh=V86+PP9V0ySz9wrBwmfAID0OOheUmF4CFn+63zny2ZU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k/gzJTYnQK22Ha3wI9ri4mrACVzY1eonY7bhFcVnsdPZvPPH9pxtHp0we/fsKgvfS
         b/N9P8igtC6DChUIDNBUJ56O2HwPBB4h0qT/5+Xw5jHay2uYZfnVDGXv0/LWroN3VG
         HTqqLU8dQdOfh0ieN6QcADDYJPO8K6kc+R2T09Ro+J/fd5oYyLGyVE1w9buGyj2vha
         7D3VebtgVqElZpt/JRlm64pt7QFZIuq108bkDGxojP5EJ5yn3VBclERKdZf0yR4BO6
         9B/H8BpLT5SjX7CUEQwkZtcnxS+0ot22Cd6nwt1O+wTsP4F+ad4S7U4D2wslM3mJoH
         DCnm3nKe9bfTg==
Message-ID: <36a9ac00-669d-08ae-558d-c85fd9715cb3@kernel.org>
Date:   Wed, 23 Nov 2022 17:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for
 num-lanes
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, vigneshr@ti.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221115150335.501502-1-mranostay@ti.com>
 <20221115150335.501502-2-mranostay@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221115150335.501502-2-mranostay@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/11/2022 16:03, Matt Ranostay wrote:
> Add num-lanes schema checks based on compatible string on available
> lanes for that platform.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 28 +++++++++++++++++--
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 28 +++++++++++++++++--
>  2 files changed, 50 insertions(+), 6 deletions(-)

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You miss not only people but also lists, meaning this will not be
automatically tested.

So: NAK

Best regards,
Krzysztof

