Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2422E48CC44
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbiALTrb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 14:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbiALTrJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 14:47:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F1C06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 11:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2395161AF0
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 19:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BE1C36AE5;
        Wed, 12 Jan 2022 19:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642016827;
        bh=6k0w+VUu5Asp6lTMzoa2vofLhlMqwPw0Le6iXN50yC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Cf32n+/HWtvOD++Ei/GA10xiSO2cg8jEF4Q3CCcB2X1Apo3jRhdqPu4s7gthIWVIF
         VCQJHjS2lzuUVrIEVW5jksHQyle0XF/VIjtD7W+bwhaURt8uiuXn9/eaXaZ7YXF2EK
         HeCpcfv7BmkgZH8b7MCyyTxwSTu3Z0DdvUb00VWgliXkS5mAhDCmHe1aIXerzSXJI6
         zsb2vYvUAEAX9tmIW7tv6wyf3EzkVC9LOOgtD9BLvHkSXlwWmnbRutxfPpMdI2zFl4
         JMiM2cxKEOak7bpRpP8hWD5sQ3TBhrZ+sQ9bKEqbGp9+yjAOi1kxgJnWAFNX1WEZjd
         Z8aFjIhPxtwgw==
Date:   Wed, 12 Jan 2022 13:47:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        james.quinlan@broadcom.com, linux-pci@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] fixup! PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <20220112194706.GA274996@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112013100.48029-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 11, 2022 at 08:31:00PM -0500, Jim Quinlan wrote:
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, to expedite this since we're in the merge window, I cloned
Lorenzo's branch and squashed this into pci/host/brcmstb for v5.17.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 8a3321314b74..4134f01acd87 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1392,7 +1392,8 @@ static int brcm_pcie_resume(struct device *dev)
>  err_reset:
>  	reset_control_rearm(pcie->rescal);
>  err_regulator:
> -	regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> +	if (pcie->sr)
> +		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
>  err_disable_clk:
>  	clk_disable_unprepare(pcie->clk);
>  	return ret;
> -- 
> 2.17.1
> 
