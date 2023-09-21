Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF77A9930
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 20:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjIUSMJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 14:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjIUSLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 14:11:18 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F1C8AE1F
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 10:41:07 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 60CAC30010D5E;
        Thu, 21 Sep 2023 17:14:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 53B185D6FD8; Thu, 21 Sep 2023 17:14:01 +0200 (CEST)
Date:   Thu, 21 Sep 2023 17:14:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Make Bjorn's life easier (and grease the path of your patch)
Message-ID: <20230921151401.GA25512@wunner.de>
References: <20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Oct 26, 2017 at 05:37:01PM -0500, Bjorn Helgaas wrote:
> This is a list of things I look at when reviewing patches.
[...]
> Write the changelog:
[...]
>   - Order tags as suggested by Ingo [1] (extended):
> 
>       Fixes:
>       Link:
>       Reported-by:
>       Tested-by:
>       Signed-off-by: (author)
>       Signed-off-by: (chain)
>       Reviewed-by:
>       Acked-by:
>       Cc: stable@vger.kernel.org	# 3.4+
>       Cc: (other)

I've used your message from 2017 [1] as a reference on how to order tags
but today discovered that checkpatch.pl has a new rule which is sort of
at odds with your preferred style:

  WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
  #38: 
  Reported-by: Chad Schroeder <CSchroeder@sonifi.com>
  Tested-by: Chad Schroeder <CSchroeder@sonifi.com>

  total: 0 errors, 1 warnings, 15 lines checked

I'm not sure where to insert the Closes tag, checkpatch wants it immediately
after the Reported-by, but since Closes is like Link, I'd assume that you'd
prefer it to precede the Reported-by.

I've pointed other folks to your message so that they know which guidelines
to observe when submitting to linux-pci.  I'd like to encourage you to
update it and (if you like) add it to the tree as a maintainer profile
(see Documentation/maintainer/maintainer-entry-profile.rst) so that it's
even easier to find.

[1] https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

Thanks!

Lukas
