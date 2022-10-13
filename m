Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6CD5FDBDC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 16:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJMOCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJMOCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 10:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F85F98C;
        Thu, 13 Oct 2022 07:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE195617CE;
        Thu, 13 Oct 2022 13:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AB1C433D7;
        Thu, 13 Oct 2022 13:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665669545;
        bh=kR2C/8bejgtcIdVZw5KOgwD8/UohmQ1uLQ5wmD70seI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rE+VvY9edkaV+9BLuT0K5BybpOd6H9IO/WD9uHn+0upu9iFdPwCOVQXjq1MMiIJk8
         w5d4NB3bxksr8SdO8INRe3wzQCMvEI6C6NhxmAKTGKo18n4AL4lu6f/P8PcdY39BuW
         ivHKGZAijuPuj2br3fmPXAT0Zu8sFyEUHbedpopOivTpbWYFHNokpO0Qx8f3fazvoC
         hG2VxODq7LVnY+X0JasNCVsVVlVUpdL/2PJdebo+lYmykqSLvvqdjqCly1bhxPEw7j
         tYOWvTvDx7gWWbHEjFq0L6Whn6q+ZewLiovmK6PN8J+lv6JXx7wGgtIKMlRVLSTWF0
         x6RRGBnPl73Qg==
Date:   Thu, 13 Oct 2022 08:59:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dominic Rath <dominic.rath@ibv-augsburg.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com, bhelgaas@google.com, lpieralisi@kernel.org,
        nm@ti.com, vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: Re: [PATCH 2/3] PCI: cadence: Use DT bindings to set PHY latencies
Message-ID: <20221013135903.GA3243887@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013062649.303184-3-dominic.rath@ibv-augsburg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 08:26:48AM +0200, Dominic Rath wrote:
> From: Alexander Bahle <bahle@ibv-augsburg.de>
> 
> Use optional "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps"
> DeviceTree bindings to set the CDNS_PCIE_LM_PTM_LAT_PARAM(_IDX)
> register(s) during PCIe host and ep setup.
> The properties expect a list of uint32 PHY latencies in picoseconds for
> every supported speed starting at PCIe Gen1, e.g.:

s/ep/endpoint/
s/properties expect a list/properties are lists/

Rewrap into a single paragraph or add a blank line between paragraphs.

>   max-link-speed = <2>;
>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
> 
> There should be a value for every supported speed but it is not enforced or
> necessary. A warning is emitted to let users know that the PTM timestamps
> from this PCIe device may not be precise enough for some applications.

Not sure what "it is not enforced or necessary" means.  Maybe it just
means that if a value is missing, we don't program LAT_PARAM and we
emit a warning?

> +	param_count = of_property_count_u32_elems(np, key);
> +	if (param_count < 0 || param_count < max_link_speed) {
> +		dev_warn(dev,
> +			"no %s set for one or more speeds: %d\n",
> +			key, param_count);
> +	}
> +
> +	/* Don't set param for unsupported speed */
> +	if (param_count > max_link_speed)
> +		param_count = max_link_speed;
> +
> +	for (i = 0; i < param_count; i++) {
> +		if (of_property_read_u32_index(np, key, i,
> +					       &latency) < 0) {
> +			dev_err(dev, "failed to set latency for speed %d. %s\n",
> +				i, key);

Seems like these messages should contain "PTM" somewhere.

If they're truly optional properties, should these be dev_info()
instead of dev_warn/dev_err?

Bjorn
