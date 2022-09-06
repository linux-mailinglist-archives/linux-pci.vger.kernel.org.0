Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2758A5AF6B7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIFVZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIFVZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:25:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77388E0FE;
        Tue,  6 Sep 2022 14:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D48A8B819FA;
        Tue,  6 Sep 2022 21:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F050C433C1;
        Tue,  6 Sep 2022 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662499522;
        bh=YlI6nfxlkaW54kfVhIjK8TkWbkEM63wDRrWb6LBTI98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eodMXCsBN8QuwZ7c8Vc2fzSCUrudttAYVeT27F6A9pRo7hrY2xAskyr3nfMJdst+9
         iT81LOeEqw8lamTXCuF+c3YGASWkKOXr6huve6cVVh6G7/BbOpbhWI0oNXsxTqLa3V
         CFK4etufOO4gYxJWMKslEMMpEqTGhBbKopwVWKLzz4VbqZRPvLcwkfTkHBZJnCQjN2
         iEF+r/0IziDYlwoCvvQdGxYzMTI5KJsjdGCpvves7EZXQB5iEMQuPnsocJgKmzwc6T
         c69rowYrjbb0IFsVe+WSDsU+jjM+F39qVszjxdx7m5x0ESO8cqF8sBWL/PmrZRJkaa
         wmRJyX77OgqcA==
Date:   Tue, 6 Sep 2022 16:25:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     cgel.zte@gmail.com
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] PCI: iproc: Remove the unneeded result
 variable
Message-ID: <20220906212520.GA45166@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906071636.336853-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 07:16:36AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value iproc_pcie_setup_ib() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

This patch itself is fine, but was posted by cgel.zte@gmail.com, not by
"ye xingchen <ye.xingchen@zte.com.cn>", so it needs another signoff
and full name so the chain is complete.  For more details see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.18#n363

Bjorn
