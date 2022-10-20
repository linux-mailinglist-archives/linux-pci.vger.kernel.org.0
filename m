Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3957606662
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJTQ6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 12:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJTQ6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 12:58:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1880F19ABD1
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 09:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83149B826A9
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 16:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF29DC433D6;
        Thu, 20 Oct 2022 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666285114;
        bh=rPtOiltoyJfynEA4NrlFetR8EwwPDCq16wo8frOCFhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kGw+7gvshzdQw32mD0b9q4wGKccLD3au3iPs8ZmsZ99KH6HYZPR/ZW/tV4TJGkzkf
         7JUueBCzr/7YFM0osiNPO4Uqr2mv1o/kKzHOdblEAK6aEJWsI4Kj+Bq0CBst+4Qflw
         6Sqn7OiTghpOHLXYY8lVPD7vE8TbAAvtaqLPoZgqRIgGl/eiAN5B0yrfooXeiRG0WF
         CX8UUGr91ZLlPJa59i1cgsNIb7J8AOsRnY7+VMFALJm+1hYv0O4f2zZfNP1Mkz+G+N
         xuFFKfRDJO2dXTh3q5yRzYtNqRK6ji5wBn3td7QFybjXZY3dDPgHUdJAxbaV+JDmJm
         98eTPTXvKsRyA==
Date:   Thu, 20 Oct 2022 11:58:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     robh@kernel.org, tjoseph@cadence.com, nm@ti.com, a-verma1@ti.com,
        vigneshr@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: j721e: Add warnings on num-lanes
 misconfiguration
Message-ID: <20221020165832.GA131977@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020012911.305139-4-mranostay@ti.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 06:29:11PM -0700, Matt Ranostay wrote:
> Added dev_warn messages to alert of devicetree misconfigurations
> for incorrect num-lanes setting, or the lack of one being defined.

s/Added/Add/ if you repost for anything else:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.16#n95

> +		dev_warn(dev, "defined num-lanes %u is greater than the "
> +			      "allowed maximum of %u, defaulting to 1\n",
> +			      num_lanes, data->max_lanes);

Don't repost just for this, but I generally prefer to keep printf
strings intact even if they exceed 80 columns, because it makes it
easier for someone to grep for something like
"greater than the allowed".

> +		num_lanes = 1;
> +	}
>  	pcie->num_lanes = num_lanes;
>  
>  	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
> -- 
> 2.38.GIT
> 
