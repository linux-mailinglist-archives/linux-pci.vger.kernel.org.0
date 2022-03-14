Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C154D8B46
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 19:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiCNSFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbiCNSFF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 14:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F877344FA
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 11:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BFB461000
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 18:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C624C340E9;
        Mon, 14 Mar 2022 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647281034;
        bh=0MfUNc5fqc0SSkuiDPG1UogH2lNs5MN9IJRfgotWhkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CsRTjBf0Fnij5SS8iCINMwDe/iV06co+X0mVyyNzv3ROwsBtUBlmHwfxtMwwQoQ0j
         lLZXcArb554tzF9Cbxf6g0hoeScJJUuzosk+cjbZUppCavt6tCWrSvXeBfoxGIh5nZ
         /Mv3ssc2iyYbl+KLbl6lLprNwgZjlmxMXgeMYhx7eo5UwwvPHvTtgXu0yet1UqnKrK
         nJYlBG/uRRbclxQyoQqorPCoxwVKj+871Wq/2qBVogPRmRO138OENtA8b0Oape6xfB
         n6YDdGPaiYC73BV7aAVhkt9+YkQfxm/K9wuezmQhUBxA3Vgv4LCNWQxGbDUBK20hmx
         ThQSb6Q24svHw==
Date:   Mon, 14 Mar 2022 13:03:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Only declare struct pci_filp_private when
 HAVE_PCI_MMAP is set
Message-ID: <20220314180352.GA395778@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210706003145.3054881-1-kw@linux.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 06, 2021 at 12:31:45AM +0000, Krzysztof Wilczyński wrote:
> At the moment, the struct pci_filp_private does not have any other users
> outside of the drivers/pci/proc.c file, and additionally its also only
> ever used (alongside all of its users) when the macro HAVE_PCI_MMAP is
> set.
> 
> Thus, enclose struct pci_filp_private in an preprocessor condition so
> that it's only declared when the HAVE_PCI_MMAP macro is set, which
> otherwise would be unused should the macro hasn't been set.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc for v5.18, thanks!

> ---
>  drivers/pci/proc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 9bab07302bbf..3467a8e019f9 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -187,10 +187,12 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  	return nbytes;
>  }
>  
> +#ifdef HAVE_PCI_MMAP
>  struct pci_filp_private {
>  	enum pci_mmap_state mmap_state;
>  	int write_combine;
>  };
> +#endif /* HAVE_PCI_MMAP */
>  
>  static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
>  			       unsigned long arg)
> -- 
> 2.32.0
> 
