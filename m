Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1322A611AB6
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJ1TNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJ1TN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 15:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E52347A7;
        Fri, 28 Oct 2022 12:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C6A62A2D;
        Fri, 28 Oct 2022 19:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9C7C433D6;
        Fri, 28 Oct 2022 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666984390;
        bh=7Hbg6mxqM2uqB/T0MyYeLF6xSwC/ZvQUkAf3AqjEKoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cmauykmgU7NKXbb4JfE6TJZsHaZlmXtXSMjpbyeAaGunufhpEeh48jcpEYhGu3miD
         eK9LDN/mnNn0i6vknMoKqpHsvCc8PRW210RzEWeQegUDS4awDfacm5JcVxUTbHBXni
         VyvTSMG9EleP3aW8apZUOMcwDcI51iiq/qiFZPArTOznCOqD2TMHO6r5c7XEtI4LXM
         4ucFmfasRSYHzwIR00JoQ2rxcqkCz5jYIX9vkziCYqvVpX1OmrEpAKz6YBtEp7S5AS
         ZmXxKcjE+FjeA7xKWEIrjYLKJzk9zG/i0B+b43iC927lX/7YZnLlHXJKy58woB9nVS
         jHv744ho7zF9A==
Date:   Fri, 28 Oct 2022 14:13:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
Message-ID: <20221028191308.GA903098@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025004411.2910026-4-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 24, 2022 at 05:44:10PM -0700, David E. Box wrote:
> Add vmd_device_data to allow adding additional info for driver data.

>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +		(kernel_ulong_t)&(struct vmd_device_data) {
> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> +		},
> +	},

It looks like these devices come in families where several device IDs
share the same features.  I think this would be more readable if you
defined each family outside this table and simply referenced the
family here.  E.g., you could do something like:

  static struct vmd_device_data vmd_v1 = {
    .features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
		VMD_FEAT_HAS_BUS_RESTRICTIONS |
		VMD_FEAT_OFFSET_FIRST_VECTOR,
  };

  {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
    .driver_data = (kernel_ulong_t) &vmd_v1,

Then you can add VMD_FEAT_BIOS_PM_QUIRK and the .ltr value in one place
instead of repeating it a half dozen times.

>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
> -- 
> 2.25.1
> 
