Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3B5E91D4
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIYJVK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Sep 2022 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYJVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Sep 2022 05:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD30E02C;
        Sun, 25 Sep 2022 02:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 442E760DF4;
        Sun, 25 Sep 2022 09:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF25C433D6;
        Sun, 25 Sep 2022 09:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664097666;
        bh=NFtNgqfKgd6xfEpO9NNnS8Qtb78ksrjogdo7uuKvoG0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=srrnvjSbePwWCZ4u1kpQBTgEOlvOqcJh2xdz5jDN0qY/rz9puLC8hfrZpez3aGrsW
         KkjbxxuO/cidrW2sNpCixqgMsToS3Yyoy22Ot0Opikfu3fCVb4F5yyxaxlYrqDkFZ5
         52/9nZMTQ8rfqCTFL9vUXXbOhtUIIQNfGOxL4cr8JkdKZoy1b56nUGGnNouUMoEOLF
         hH03umvQYb7Uwp/IjaZEerRUSh7QQsybY9q2qoE5jQWfmkfouwydW1ixiTvmR1qfJL
         m2vN97/BG/kXszBHr4jm1budBOkeFgXosr/UKzwbzuRSeEvW1HFVIcP8Njdr1cOZD9
         M22Vj9tyRbPLQ==
Message-ID: <b820b84b-609f-6b1a-fb9f-fde05ce88f7f@kernel.org>
Date:   Sun, 25 Sep 2022 11:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 0/2] dt-bindings: PCI: ti,j721e-pci-*: resolve
 unexpected property warnings
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vigneshr@ti.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220924223517.123343-1-mranostay@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220924223517.123343-1-mranostay@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/09/2022 00:35, Matt Ranostay wrote:
> Resolve unexpected property warnings related to interrupts in both J721E PCI EP and host
> yaml files.
> 

Thanks for cc-ing. On what tree do you base your patch? Looks like
something old. If so, you need to rebase to some recent kernel.

Best regards,
Krzysztof

