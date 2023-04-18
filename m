Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F46E6CE0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjDRTWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 15:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjDRTV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 15:21:59 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598793DD
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 12:21:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 98057100D940D;
        Tue, 18 Apr 2023 21:21:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 782B0155B8F; Tue, 18 Apr 2023 21:21:26 +0200 (CEST)
Date:   Tue, 18 Apr 2023 21:21:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [pci:next] BUILD SUCCESS 1fdef2055d8690d6f29d08d6d506bb7fba708488
Message-ID: <20230418192126.GA27233@wunner.de>
References: <643a3f25.AMbLEWIS+bFzjZ8Y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643a3f25.AMbLEWIS+bFzjZ8Y%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Sat, Apr 15, 2023 at 02:07:33PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> branch HEAD: 1fdef2055d8690d6f29d08d6d506bb7fba708488  Merge branch 'pci/controller/rcar'

Just a heads-up that the pci/hotplug branch has not been merged
into pci/next.

It thus doesn't get linux-next coverage at the moment and won't
make it into v6.4-rc1 if your pull will be based on current
pci/next.

I double-checked all the other branches but pci/hotplug is the
only one missing.

Not sure if that's intentional, but probably not, so thought I'd
let you know. :)

Thanks,

Lukas
