Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648EE6F33A6
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjEAQw7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 12:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQw6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 12:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2AE73;
        Mon,  1 May 2023 09:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76DBA61898;
        Mon,  1 May 2023 16:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A6EC433D2;
        Mon,  1 May 2023 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682959975;
        bh=IuOYTFg/MA6zMnwWvVURCF5r2TJLNDfHDi/8ec8i6qM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZPxzr7AJT5miKZp6D42X7SuJW7y3cz91RQQkSxn65CMqIi1YUWQZxmuD9fk25P8u5
         SdU8QAwfeYaHOAq+n907/tjyIJTIHc7H2avgSzg9A+95Kj5Jv8ZosjDNfe5FrsHKuk
         vpkLcv67snVZR6k614LZTpLIcG8yXa7l09I7Y5w95T1QpfO/VprW6iZVEQhnEitqOc
         /xIz6hX0GGMs6CFQ4aj5PZ1HPeKPv1dab/11eucl8dxSVxHYWFpgvtPbNj4NC+XkGE
         GhHA8Ck96MpJawAGZod4tEUn6DcBWi5qRlfErGJW8XLXRT68G0Jn8SylMgj0JoowL3
         iZCXNZ6TFkg7Q==
Date:   Mon, 1 May 2023 11:52:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        vidyas@nvidia.com, david.e.box@linux.intel.com,
        kai.heng.feng@canonical.com, michael.a.bottini@linux.intel.com,
        rajatja@google.com, qinzongquan@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: fix UAF by removing cached downstream
Message-ID: <20230501165254.GA589004@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03b45702-d799-f299-1c24-4e5e2e2897d2@sangfor.com.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 01, 2023 at 11:50:50AM +0800, Ding Hui wrote:
> On 2023/5/1 10:10, Bjorn Helgaas wrote:
> > On Sat, Apr 29, 2023 at 09:26:04PM +0800, Ding Hui wrote:
> > > If the function 0 of a multifunction device is removed, an freed
> > > downstream pointer will be left in struct pcie_link_state, and then
> > > when pcie_config_aspm_link() be invoked from any path, we will get a
> > > KASAN use-after-free report.
> > 
> > Thanks for finding this problem, debugging it, and the patch!
> > 
> > In this case we're doing a "software remove" and the other functions
> > are still present, right?  It's kind of annoying that there's only one
> > link, but all the functions of a multifunction device have a Link
> > Control register, and the spec "recommends" that software program the
> > same ASPM control value for all the functions.
> 
> Yes, that is the case.
> 
> > The hardware of course doesn't know anything about this software
> > remove; all the functions are still physically present and powered up.
> > 
> > That makes me think that if software ignores the "removed" function
> > and continues to operate ASPM on the N-1 remaining functions, we're
> > outside the spec recommendations because the ASPM configuration is no
> > longer the same across all the functions.
> > 
> > So my inclination would be disable ASPM completely when any function
> > of a multi-function device is removed.  What are your thoughts on
> > this?
> 
> Agree with you.
> 
> Previously, I thought another fix that was if the function 0 is removed,
> we can free the link state to disable ASPM for this link.
> 
> Now following you suggestion, it can be expanded to any child function.
> 
> How about fixing like this?
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 66d7514ca111..657e0647d19f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1011,12 +1011,11 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	/*
> -	 * All PCIe functions are in one slot, remove one function will remove
> -	 * the whole slot, so just wait until we are the last function left.
> +	 * All PCIe functions are in one slot.
> +	 * The spec "recommends" that software program set the same ASPM control
> +	 * value for all the functions.
> +	 * Disable ASPM when any child function is removed.

Since we're updating the comment anyway, let's clean up the "slot"
language here.  The PCIe spec doesn't use "slot" in the context of the
bus/device/function PCIe topology; it only uses it when referring to a
physical connector where a card might be installed.  What we want here
is "Device," and then we have to consider whether ARI makes any
difference here.

The spec says (referring to ASPM Control):

  For Multi-Function Devices (including ARI Devices), it is
  recommended that software program the same value for this field in
  all Functions. For non-ARI Multi-Function Devices, only capabilities
  enabled in all Functions are enabled for the component as a whole.

  For ARI Devices, ASPM Control is determined solely by the setting in
  Function 0, regardless of Function 0’s D-state. The settings in the
  other Functions always return whatever value software programmed for
  each, but otherwise are ignored by the component.

A spec reference, e.g., "PCIe r6.0, sec 7.5.3.7", would be good here.

Anyway, I think the idea of "software removing" a single function is
kind of a niche situation that we don't need to worry about
optimizing, and I think turning off ASPM completely will avoid a lot
of weird corner cases.

>  	 */
> -	if (!list_empty(&parent->subordinate->devices))
> -		goto out;
> -
>  	link = parent->link_state;
>  	root = link->root;
>  	parent_link = link->parent;
> 
> 
> -- 
> Thanks,
> -dinghui
> 
