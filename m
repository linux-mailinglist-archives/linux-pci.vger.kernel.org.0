Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90769AEE8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 16:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBQPDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 10:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjBQPDs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 10:03:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1997570944;
        Fri, 17 Feb 2023 07:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FCE261D58;
        Fri, 17 Feb 2023 15:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60583C433EF;
        Fri, 17 Feb 2023 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676646164;
        bh=j6dcEhmpBZz4rvKq3tdsoEKUS2cdD7vZ0LtoKMJz2Ys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dJx1betl5qK2udc/Bk5Kt7TCsKffHyHDMt7EzRPbIN2lP3ptxZKoD1g2QbnTeDmWL
         fh2eq7Cnskap94xQ1aa4bcXZBV2wsPMAyjr6bIy6w8m6iCT1OC0qPf24Q+tAJiHhaE
         Q/bzRIiljZbKRAeJo3mpcXzoSwiV/W0QBHDB+Gu4MrT4/VIzWXgsisPL4JYoDuItur
         qv8Glq5GPOYPxIztsMTU2Qiqqih4fUhgPNpjZd2Asd4PagPjEGwFML2KT9HSJL6OTn
         mBDAClnmW0J2bnHSXW+cd8GLEGVE7Vn64CgfthGTf2yrMuQPXXNGsVI0Kw6LK7HRNm
         0IN0NHiErLcNA==
Date:   Fri, 17 Feb 2023 09:02:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/24] kbuild, PCI: remove MODULE_LICENSE in non-modules
Message-ID: <20230217150241.GA3400483@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217141059.392471-3-nick.alcock@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 17, 2023 at 02:10:37PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-pci@vger.kernel.org

I squashed this one into my pci/kbuild branch for v6.3, thanks!

> ---
>  drivers/pci/hotplug/acpiphp_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
> index 853e04ad272c..c02257f4b61c 100644
> --- a/drivers/pci/hotplug/acpiphp_core.c
> +++ b/drivers/pci/hotplug/acpiphp_core.c
> @@ -45,7 +45,6 @@ static struct acpiphp_attention_info *attention_info;
>  
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESC);
> -MODULE_LICENSE("GPL");
>  MODULE_PARM_DESC(disable, "disable acpiphp driver");
>  module_param_named(disable, acpiphp_disabled, bool, 0444);
>  
> -- 
> 2.39.1.268.g9de2f9a303
> 
