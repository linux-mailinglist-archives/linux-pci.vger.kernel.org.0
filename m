Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68FF7188FE
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjEaSDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEaSDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 14:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B4128;
        Wed, 31 May 2023 11:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D140632C8;
        Wed, 31 May 2023 18:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB05DC433EF;
        Wed, 31 May 2023 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685556191;
        bh=tIDB628aG1u5LNS+DtepRZCbZZeOMkE5wqOU6ndfFtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M/+/cijXPEcIsDkj0GXChhsDp864Z6rqzEJsIgQLx8m7Knq6GpLoM7r8jRYnwNncq
         uyVaZnLxTGfTLBNWiIDeewnezjTyLIr/u7MyqmzgMm1AuCA9FuNgzw13sjjNs+UAeF
         cqpwR38iwA5fIu5P70TqA8y6y98clPLtXiqsGiQfpscWShj85hRkfpe298cbbQt22D
         2dDhGKlzujhWjRhw6IOLvqLKOc19k5ZnKeILLIcNOhmUqnI4W+C2daEieTpgSV/W/1
         ogLxtimsZZPMnFnKr+vDawqo7JG7MNkJE47qm1a9d2kNgAHMAZyUkNtXzX7CdEfyaS
         jeNlP2k/5eS3A==
Date:   Wed, 31 May 2023 13:03:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <bhutchings@solarflare.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        kernel test robot <lkp@intel.com>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add dummy implement for pci_clear_master()
 function
Message-ID: <ZHeL3WsalhsIMYwa@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c5c3ca-b112-9800-a047-10dab4cdef50@189.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 01, 2023 at 01:44:52AM +0800, Sui Jingfeng wrote:
> Can you receive my email?
> 
> I reply several email to you, but Thunderbird told me that may mail is
> returned.
> 
> Maybe you could read the content at lore.

I do receive your email (at least some; obviously if there are things
I don't receive I wouldn't know).  I read most Linux email via lei [1],
so if it shows up on lore, I should see it.

Bjorn

[1] https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
