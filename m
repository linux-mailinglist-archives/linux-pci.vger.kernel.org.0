Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987BC636543
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 17:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiKWQE6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 11:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbiKWQEu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 11:04:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1373A5E3EA
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 08:04:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3313B81EF7
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 16:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F811C433D6;
        Wed, 23 Nov 2022 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669219487;
        bh=Wpj6TDVdOFCglaQMb2eKW1+hLHQcXw0irJs7NBPLssM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tAqSN+P5YiRuhpe5OSzpRwFgPZzihHfRsvg7BHY4H8AyGA169PayLyvBYPicEZeLT
         yg1/6He0ypwE6mkdPFM5lW+PLqtT0B92vIeZRD7Wfj2AdOGL+rOTnQ/ewkVPFRgb52
         sNqxP9IIxju77dKCJonMZSp3ZAmapSEUHp/Ew+GLQnVaKM9q1PnT038ceTY6aQihZk
         vepqRX0tpGyME9FwqsDFA/t4nwz87Fl4mOO2ITy68OFMaw+dW2ZqR+O8bOfOp1B1Q1
         lsyYqE+42FTQ0QLAryGy0LtRLY6Gqc1UP7S63DRtDmUUAIMNYKwo1R1N8wed3/K3Zc
         dAdUtC2WyMrDg==
Message-ID: <97fb6d05-d8fa-3772-fea4-66f57933052b@kernel.org>
Date:   Wed, 23 Nov 2022 17:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 4/5] dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-*
 compatible strings
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, vigneshr@ti.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221115150335.501502-1-mranostay@ti.com>
 <20221115150335.501502-5-mranostay@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221115150335.501502-5-mranostay@ti.com>
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
> Add definition for j784s4-pci-ep + j784s4-pci-host devices along with
> schema checks for num-lanes.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   | 12 ++++++++++++
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)

Same problem, no tests, no usage of get_maintainers.pl.

Best regards,
Krzysztof

