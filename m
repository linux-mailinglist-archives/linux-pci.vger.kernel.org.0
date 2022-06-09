Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC9545796
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiFIWnr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 18:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiFIWnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 18:43:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F14C66CB4;
        Thu,  9 Jun 2022 15:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5DBFCE31E0;
        Thu,  9 Jun 2022 22:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E834C34114;
        Thu,  9 Jun 2022 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654814621;
        bh=NyaLQQnYT7nZ9RjjVON/49kWHNv4278LQ0Oy3ijfNss=;
        h=Date:From:To:Cc:Subject:From;
        b=o24K9g4IJIiSrQeDbrivZasm5uQvW8FU0LQa4eWgCv2c80FhwCUj4VKbmmc9is0Kl
         MB6P9Gvp9zWjy6sl7XwWTZP23p9mGJcGhdQxvw0jgQLwp8RIc/DCZKZBYOyg5OkRK3
         k8l26EIVwz/eeF9dvVZFQskKmIajhbgLKEs+ygYC96RlytunY2Z6BY033OBrdP4t96
         7ZOEHu19Nw9TEERxw5CdQ4b2/JoXNFmd2sOgDaijL7wooNBg53A/MMk41z4yldMHDz
         jNxMYcmDg2RY94nZIk/UeJOtAJAEWU+tBTbaIsJjL0+tf6kaF8Tfgbm4gQrkZFDmhJ
         NBxtdv4vt6uFw==
Date:   Thu, 9 Jun 2022 17:43:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 216109] New: Steam Deck fails to
 boot when E820 entries clipped out of _CRS]
Message-ID: <20220609224339.GA543225@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

New regression in v5.19-rc1.

----- Forwarded message from bugzilla-daemon@kernel.org -----

Subject: [Bug 216109] New: Steam Deck fails to boot when E820 entries clipped
	out of _CRS

https://bugzilla.kernel.org/show_bug.cgi?id=216109

           Summary: Steam Deck fails to boot when E820 entries clipped out
                    of _CRS
    Kernel Version: v5.19

Guilherme G. Piccoli reported that v5.18 boots fine on Steam Deck, but
v5.19-rc1 does not.  He bisected it to 4c5e242d3e93 ("x86/PCI: Clip only host
bridge windows for E820 regions") [1].

A quirk similar to [2] that disables E820 clipping makes v5.19-rc1 work again.

The reason why v5.18 (which always does E820 clipping by default) works, while
v5.19-rc1 (which also does E820 clipping on this platform) does not has not
been explained yet.

[1] https://git.kernel.org/linus/4c5e242d3e93
[2] https://git.kernel.org/linus/d341838d776a

----- End forwarded message -----
