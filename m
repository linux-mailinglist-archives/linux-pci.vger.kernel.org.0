Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267F63751E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 10:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKXJ01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 04:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKXJ00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 04:26:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449611605A
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 01:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11571B8272B
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 09:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49B8C433C1;
        Thu, 24 Nov 2022 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669281982;
        bh=G3Nvx4eFIEdvlFlwDl+MkthdYtBQ3D2oxgXQJ3iZjCo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DCOcd2mHzGFyDzDp0ouPzbjTuDyxfagJ3lK3OJrxMiUQ7KSGrfQaN6irWdcSveY23
         9qX7vhKYH9fKAlZFSV4JJzw1qaD8OFudv0qsHPILA0n+686uXsBAjWqXBksVxJkmcW
         0gluAT6veiEZdRmT0r3EEBMSQdbegL6Zg7xaUy0PM9Lo2jRC7Qp2gKSJvzYm0M6Tfe
         oLZ2/Fve+EXmQwQAmX72Mvxsy3pgMLjtTdypqaiGWAtfmv95ZueuQUGTmRmDdfjsUO
         HPGrA5nC9DSjLeGdWhPanScrkw6emCznZc07HxmDFFXXmvWmnIGW+Pb3B7J90GBtal
         AknKcKP25fx2A==
Message-ID: <1eb8a559-8cef-1093-0ff3-bfbfeceff60f@kernel.org>
Date:   Thu, 24 Nov 2022 10:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for
 num-lanes
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>
Cc:     vigneshr@ti.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221115150335.501502-1-mranostay@ti.com>
 <20221115150335.501502-2-mranostay@ti.com>
 <36a9ac00-669d-08ae-558d-c85fd9715cb3@kernel.org> <Y38kJ0nEBf+Mztpe@ubuntu>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Y38kJ0nEBf+Mztpe@ubuntu>
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

On 24/11/2022 08:58, Matt Ranostay wrote:
> On Wed, Nov 23, 2022 at 05:04:15PM +0100, Krzysztof Kozlowski wrote:
>> On 15/11/2022 16:03, Matt Ranostay wrote:
>>> Add num-lanes schema checks based on compatible string on available
>>> lanes for that platform.
>>>
>>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>>> ---
>>>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 28 +++++++++++++++++--
>>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 28 +++++++++++++++++--
>>>  2 files changed, 50 insertions(+), 6 deletions(-)
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> You miss not only people but also lists, meaning this will not be
>> automatically tested.
>>
> 
> Noted. Reran script with --git as well and it picked up a few additional people
> to Cc.

No need for --git. Just run it normally and Cc all folks listed as
reviewer, maintainer/supporter and all the lists. That's one simple
command: scripts/get_maintainer.pl ./*.patch
(which can be easily automated and combined with git send-email / bash
aliases or scripts).

So don't add some unusual or random addresses, just add the *required*
addresses.


Best regards,
Krzysztof

