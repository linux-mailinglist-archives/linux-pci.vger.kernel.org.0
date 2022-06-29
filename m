Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836955F2AA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 03:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiF2BLB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 21:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF2BLA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 21:11:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA226138;
        Tue, 28 Jun 2022 18:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0BADB81E0A;
        Wed, 29 Jun 2022 01:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16829C341C8;
        Wed, 29 Jun 2022 01:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656465057;
        bh=K3eCd7hCm8MhP8o3l+4ySC/WrN2F82RoNmx18R2IK8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jZDcZmVZJzRaR8ixnK53OJdcmu7QYO4Os9OVfswG1aysoK+oyMnVt5oGWjynbPRxz
         2WmA7j5tqklZGtXBzuUd0DbrpddJ4vjCJuWnucrycL3GBEe/pFnerKDx6C0zBhO6ne
         ha3SrlL9Q0eK/HK2mxF8D6L0h2JGGVmvSG6nRsZuHTAmSIMmTWrSJu5nM6EllIQXKG
         TXByYp89JmdD8EC92e/4y4Xvg2VmQEFIV5JzC/vDzZ2ojo3lEscSA9aSzMcZSm0HWn
         Dn+ydymXwjCESKyMpzHXbWVQnlBtfxIMXhJ/TO24euy8cVSiiwyNZKpFglHHO1QYlD
         qssHj3AsSEdzQ==
Date:   Tue, 28 Jun 2022 20:10:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH V12 5/9] driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
Message-ID: <20220629011055.GA1890289@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628041527.742333-6-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Mon, Jun 27, 2022 at 09:15:23PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Many binary attributes need to limit access to CAP_SYS_ADMIN only; ie
> many binary attributes specify is_visible with 0400 or 0600.
> 
> Make setting the permissions of such attributes more explicit by
> defining BIN_ATTR_ADMIN_{RO,RW}.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

FWIW, this looks a lot like this previous patch:
  https://lore.kernel.org/all/20210416205856.3234481-7-kw@linux.com/

> ---
> Changes from V11:
> 	New Patch
> ---
>  include/linux/sysfs.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index e3f1e8ac1f85..fd3fe5c8c17f 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -235,6 +235,22 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
>  #define BIN_ATTR_RW(_name, _size)					\
>  struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
>  
> +
> +#define __BIN_ATTR_ADMIN_RO(_name, _size) {					\
> +	.attr	= { .name = __stringify(_name), .mode = 0400 },		\
> +	.read	= _name##_read,						\
> +	.size	= _size,						\
> +}
> +
> +#define __BIN_ATTR_ADMIN_RW(_name, _size)					\
> +	__BIN_ATTR(_name, 0600, _name##_read, _name##_write, _size)
> +
> +#define BIN_ATTR_ADMIN_RO(_name, _size)					\
> +struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RO(_name, _size)
> +
> +#define BIN_ATTR_ADMIN_RW(_name, _size)					\
> +struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RW(_name, _size)
> +
>  struct sysfs_ops {
>  	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
>  	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);
> -- 
> 2.35.3
> 
