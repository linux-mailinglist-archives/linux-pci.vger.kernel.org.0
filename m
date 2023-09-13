Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE779E51E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjIMKmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbjIMKmR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 06:42:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E3C19A8;
        Wed, 13 Sep 2023 03:42:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FB6C433C9;
        Wed, 13 Sep 2023 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694601733;
        bh=M5gn560TFCcZ34DR2zUQPAjl6DQ+nk0P94HD77R6XT0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZZLF78a1zYuju5Mi56qZCqivmUedzAIZnvGJPoXh2zDhah0xH3RIfds+14c/v0klG
         CVpCD1LnccNES82wl9YGt6Xs29DLAgCYtYMvgXPN7ejqJHJmbMpD1AnM9Y7IWDwDII
         fw8lahiZIVIe3ecBuyKhuL8/4XXqifgWhlVAxaUCcfh9HCe495Bmhnshi/1kemazMP
         FU6QuYhoI2EyjSpOAd1VWeohzzmpZklEykRcaesPbARuUjOp5DC2z9fMnaxrN9LOcI
         k9IVN9JSeTZm4eZsKKPqqwFcxMSvs1Ysq0HJ/LAy969QX8TLgoult/LXqRuBZiQvAi
         EtXgTC0LfZuIQ==
Message-ID: <815e99da-d66b-993f-3c86-7a88dc6f413c@kernel.org>
Date:   Wed, 13 Sep 2023 12:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 09/30] Documentation/devicetree: Add
 renesas,sh7751-pci binding document.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de, linux-pci@vger.kernel.org
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <701db4418652fc2ed36570ac20d57117ec6941c5.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <701db4418652fc2ed36570ac20d57117ec6941c5.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

You did not resolve several comments from previous version. I don't
understand why, so I just assume this is not ready for review. Just
quick look tells this wasn't tested and has multiple issues. Maybe that
was the intention, but nothing is described in commit log confirming
such intention.

Therefore to be clear: that's a NAK.

Also, standard template:

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


Best regards,
Krzysztof

