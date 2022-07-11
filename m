Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86693570E25
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 01:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiGKXTW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 19:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGKXTV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 19:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF4B240A6;
        Mon, 11 Jul 2022 16:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8CED61477;
        Mon, 11 Jul 2022 23:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F5FC34115;
        Mon, 11 Jul 2022 23:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657581560;
        bh=zUPdqyzr+PF4vMiCuYWH6pj1SoeuRmQQqD3rPpaVczI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i1DRECHdn0z+/Ve81Ozw2SX7AjnyF1lzWIEyfhLxOvQ0wS46SXH4x3x4bsmw3sYnT
         BRjbInUkIt8c0i2ctrfT7pbvtOUIqn907UXFIsTHjDhtFnBwdBEXMk0+Eo8q6Yb+zu
         wjYNte6Lu8cbNRAUN3JEGn881uOgfFrSRMDT+LZFAoG0omVvVfF+0JnxzB9LI7DT4d
         KrP11Mi0mJYljkeIGJv0Ghyny1fITxx5js9izKKKG+Jh3HTaQkvoVVxrflJAEp9AhZ
         7hSBJDoC36PA+XubBQREW8F1KtTwhFeNzB6vkzbgTlbNhYJfpgkeNgzeCM47Yu3qTu
         fZf2DCoxXLQ3A==
Date:   Mon, 11 Jul 2022 18:19:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/doc: Convert examples to generic power management
Message-ID: <20220711231918.GA707416@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607232946.355987-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jonathan, linux-doc, linux-kernel; sorry I missed you earlier]

On Tue, Jun 07, 2022 at 06:29:46PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCI-specific power management (pci_driver.suspend and pci_driver.resume) is
> deprecated.  Convert sample code to the generic power management framework.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this to pci/pm for v5.20.  Let me know if you object!

> ---
>  Documentation/PCI/pci-iov-howto.rst | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/PCI/pci-iov-howto.rst b/Documentation/PCI/pci-iov-howto.rst
> index b9fd003206f1..27d35933cea2 100644
> --- a/Documentation/PCI/pci-iov-howto.rst
> +++ b/Documentation/PCI/pci-iov-howto.rst
> @@ -125,14 +125,14 @@ Following piece of code illustrates the usage of the SR-IOV API.
>  		...
>  	}
>  
> -	static int dev_suspend(struct pci_dev *dev, pm_message_t state)
> +	static int dev_suspend(struct device *dev)
>  	{
>  		...
>  
>  		return 0;
>  	}
>  
> -	static int dev_resume(struct pci_dev *dev)
> +	static int dev_resume(struct device *dev)
>  	{
>  		...
>  
> @@ -165,8 +165,7 @@ Following piece of code illustrates the usage of the SR-IOV API.
>  		.id_table =	dev_id_table,
>  		.probe =	dev_probe,
>  		.remove =	dev_remove,
> -		.suspend =	dev_suspend,
> -		.resume =	dev_resume,
> +		.driver.pm =	&dev_pm_ops,
>  		.shutdown =	dev_shutdown,
>  		.sriov_configure = dev_sriov_configure,
>  	};
> -- 
> 2.25.1
> 
