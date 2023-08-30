Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3A78DB61
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbjH3SjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243697AbjH3Lbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 07:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045D3132;
        Wed, 30 Aug 2023 04:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3F760BAF;
        Wed, 30 Aug 2023 11:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74045C433C7;
        Wed, 30 Aug 2023 11:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693395104;
        bh=I3QUcjvGQNK/WN89qE62mUZVvbzh+sWhFO8OhwQe9X8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RqVB98BtcFRECsHjf/CiUJ0L+JtoTi59vAb6U8d2YYLwJ231NZIjyA7npgBQJAX+z
         egaJ/xuBPVb5pFWPpdsnbrE6deMEAJFAZnO3hv0rbHqpELBHeDWrCSgLl+mq2shwYp
         cp89hgjpa+AEKmITt/z5pYxu4CtjtGeQmjAeziRaqbpFUVoisXX+zf9nPAJZhawVRs
         LSU7v1ESMqoq6VQ5BRdLt6j6ndZVc5jW82b9o/9bXd3e+uTQpEzwDaav0YSSOvVAt/
         xBdzUgx+j1YjBcGgECYyJ80/0lk513eTmFp2cLf2w1Eq4hyp4MMZNUQTEsslS7ue5m
         rCRv6PRhC+2Kg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [regression v6.5-rc1] PCI: comm "swapper/0" leaking memory
References: <878r9sga1t.fsf@kernel.org>
        <8a737241-f216-169a-8bd3-d0832439b99e@leemhuis.info>
Date:   Wed, 30 Aug 2023 14:31:40 +0300
In-Reply-To: <8a737241-f216-169a-8bd3-d0832439b99e@leemhuis.info> (Linux
        regression tracking's message of "Wed, 30 Aug 2023 11:55:47 +0200")
Message-ID: <874jkgg40z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> Hi, Thorsten here, the Linux kernel's regression tracker. Partially
> top-posting for once, to make this easily accessible to everyone.
>
> Thx for the report. To quote one aspect:
>
>> v6.4 has no leaks.
>
> I pretty sure you mean stock 6.4 here. But FWIW, the culprit was
> backported to 6.4.y and 6.1.y, so they latest versions might be affected
> as well.

Yes, I mean v6.4 release tagged by Linus:

6995e2de6891 Linux 6.4

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
