Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F9F74B141
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGGMre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 08:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGGMre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 08:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7344124;
        Fri,  7 Jul 2023 05:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 548AE61997;
        Fri,  7 Jul 2023 12:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32AAC433C7;
        Fri,  7 Jul 2023 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688734050;
        bh=aIGBVnL4h550uklj+CUMoa+LNgGz6m/8MWw5loKY/Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U55sAdF24LuBpmMzrBY8PF4P+pcjfEHWJnDCWYRbE9X3jPFEbEmrw9/sTaHxQ4qnR
         zTB8+hGehm2JZgcMQPW3zSkowkH5D6Ay1sslWMka9pHR03d6zYos/DzSv3uZOAQyx/
         K8Bl9btbJeZWHrYpD8jWq1WMRMEXnZkIa6+P+SMvVLpn4u4x+VLYTfgoupbjOIR4E8
         lvrFtJqLr4Ky/qCWFLxYUyJUw6FtFwoA+UnUqdGPGkY/lKl8VsKxTuXPy2rDfKJm9J
         E+6wlHya/uA5YqLio50yZfe7vFB9hPCyQX691xl33ikT6AEbapNZzIM0zKGOxtT+5M
         cH1eFd8j6Mbwg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qHksO-0007lO-21;
        Fri, 07 Jul 2023 14:47:56 +0200
Date:   Fri, 7 Jul 2023 14:47:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706125811.GD4808@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 06, 2023 at 06:28:11PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jul 06, 2023 at 10:26:10AM +0200, Johan Hovold wrote:

> > Finally, note that the intel-gw driver is the only driver currently not
> > providing a start_link callback and instead starts the link in its
> > host_init callback, and which may avoid an additional one-second timeout
> > during probe by making the link-up wait conditional. If anyone cares,
> > that can be done in a follow-up patch with a proper motivation.

> The offending commit is bogus since it makes the intel-gw _special_ w.r.t
> waiting for the link up. Most of the drivers call dw_pcie_host_init() during the
> probe time and they all have to wait for 1 sec if the slot is empty.

Just to clarify, the intel-gw driver starts the link and waits for link
up in its host_init() callback, which is called during probe. That wait
could possibly just be dropped in favour of the one in
dw_pcie_host_init() and/or the driver could be reworked to implement
start_link().

Either way, the call in dw_pcie_host_init() will only add an additional
1 second delay in cases where the link did *not* come up.

> As Johan noted, intel-gw should make use of the async probe to avoid the boot
> delay instead of adding a special case.

Indeed.

Johan
