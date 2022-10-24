Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE6560BDCF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 00:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJXWuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 18:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJXWt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 18:49:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF16B65C
        for <linux-pci@vger.kernel.org>; Mon, 24 Oct 2022 14:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB5F9CE1626
        for <linux-pci@vger.kernel.org>; Mon, 24 Oct 2022 20:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D3DC433D7;
        Mon, 24 Oct 2022 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666644336;
        bh=QKzuXrExD6Y4a2PJjuLvU/WiHn9m3W/7UuBFYy5WFMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RKudoxf02Y3pKhn8O4gBjRmoyke3gXAIKoFazPyGrUJVYn9PSzcTGcMaMtdsvjwAY
         bfkMEW8bDOXAftt9QRzXByuDPyenr7iJaHeKPMNqBaI3lvepwNfmnmWjzy8xFQtFHh
         1kVJjqDul8CRueHzmylkBbGZBKF/wvv64VhUT878RdB25NTEwYjK/ruLJaX+tfIwvd
         hFPwFCrzW7k6dQwHxCQLDSnxkTtcqAmDpMuyG8JVqczoj+YIybp2IouJVmQbnPaNxn
         TA38JrUeMfp9ts1CnkZWDFbpnBWCMCUsC4lXIR957J2TP0fhpuw7VrnWtmeQZ9S5wH
         xtbnu60xycsxA==
Date:   Mon, 24 Oct 2022 15:45:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     francisco.munoz.ruiz@linux.intel.com
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Fix secondary bus reset for Intel bridges
Message-ID: <20221024204534.GA589134@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923203757.4918-1-francisco.munoz.ruiz@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 01:37:57PM -0700, francisco.munoz.ruiz@linux.intel.com wrote:
> From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> 
> The reset was never applied in the current implementation because Intel
> Bridges owned by VMD are parentless. Internally, the reset API applies
> a reset to the parent of the pci device supplied as argument, but in this
> case it failed because there wasn't a parent. This change feeds a child
> device of an Intel Bridge to the reset API and internally the reset is
> applied to its parent.

What kind of problem does this fix?  I guess some devices below a VMD
need to be reset before we can use them?

As a rule, Linux doesn't reset PCI devices at boot, so I'm just
wondering what's different about these.

If this fixes a problem, it's also nice if we can include a symptom in
the commit log so if people are seeing the problem, they can find the
solution, or distros can tell whether they need to include it.

> Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e06e9f4fc50f..34d6ba675440 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -859,8 +859,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	pci_scan_child_bus(vmd->bus);
>  	vmd_domain_reset(vmd);
> -	list_for_each_entry(child, &vmd->bus->children, node)
> -		pci_reset_bus(child->self);
> +
> +	list_for_each_entry(child, &vmd->bus->children, node) {
> +		if (!list_empty(&child->devices)) {
> +			pci_reset_bus(list_first_entry(&child->devices,
> +						       struct pci_dev,
> +						       bus_list));
> +			break;
> +		}
> +	}
> +
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
>  	/*
> -- 
> 2.25.1
> 
