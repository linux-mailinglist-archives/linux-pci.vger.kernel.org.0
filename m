Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E535E995F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 08:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiIZGSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 02:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiIZGSv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 02:18:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AAD1F2E3;
        Sun, 25 Sep 2022 23:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEC79B80934;
        Mon, 26 Sep 2022 06:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B86C433C1;
        Mon, 26 Sep 2022 06:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664173128;
        bh=GD15bIqqX3lg06+lb7uwwgkRLmW7v4DHVqfIHvOWdog=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KlNALZwGaePzeesgbmvNCNlYV20s7J7HWubJjyCvSHNwPhJiUcn0akn+uONHZHy4M
         aVGQO+T/jaFKBqLKiQ4pkK3KCcvB+NMuPtPmFgG1M+NhLVyjUUd182pBDXsGEQTLGN
         iRj52wDoP2IEvku4Ysd8C9A8T8iNq/Akrkn1o6p62meg3RlW+CvhXYoZrBYshjLrsg
         0FPJJ20DogbAULqh9Mqr6MdfOtCqChwgIYQWREAPcbnmPSn0zmLnLKqTFwP06SC/cg
         trtR9C2nBnioQdwAdECsHOJnDWq2Ny2ikAOwZMrr3qtlKHRHHJgnbksWu523f6bqu/
         iRu4mzJfSaKGg==
Message-ID: <d36585af-1706-2499-3ccc-c61a2cd49be4@kernel.org>
Date:   Mon, 26 Sep 2022 08:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 0/2] dt-bindings: PCI: ti,j721e-pci-*: resolve
 unexpected property warnings
To:     Matt Ranostay <mranostay@ti.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, kishon@ti.com,
        vigneshr@ti.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220924223517.123343-1-mranostay@ti.com>
 <b820b84b-609f-6b1a-fb9f-fde05ce88f7f@kernel.org> <YzEXN88AAa7tZvyE@ubuntu>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <YzEXN88AAa7tZvyE@ubuntu>
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

On 26/09/2022 05:06, Matt Ranostay wrote:
> On Sun, Sep 25, 2022 at 11:21:02AM +0200, Krzysztof Kozlowski wrote:
>> On 25/09/2022 00:35, Matt Ranostay wrote:
>>> Resolve unexpected property warnings related to interrupts in both J721E PCI EP and host
>>> yaml files.
>>>
>>
>> Thanks for cc-ing. On what tree do you base your patch? Looks like
>> something old. If so, you need to rebase to some recent kernel.
>>
> 
> It was on linux-next from Sep 23rd. So would seem odd if the rebasing seems
> from an older tree. 
That's good, but then why you did not use scripts/get_maintainers.pl as
I asked...

Best regards,
Krzysztof

