Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD84C8619
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 09:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiCAIOf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 03:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCAIOf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 03:14:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2345785;
        Tue,  1 Mar 2022 00:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKFMzW+Kv859HQuOCSrtHRjHr81yrDge18ehzpKSGjE=; b=Wc1YJkdbx0+7ppx32Pf7erlmtn
        84YNscLIGC1EB1Aj+TAWGXCyTQh3AtwRW8Ccr3lALMMmjEwZ4+5Ommu6/VVnOhDUoqNMmy4NzhNvG
        oCaWkGg8nz+rpkWbXZvof1bcNrDpSJGcD8ASv+qgYH2wAMXvNWTSXD0Pr2V79k9k3bxznmrjHK5XZ
        REiKcBAw1B5kAlLs5CheLYJUcabGItx20jaPlMW7X0g+BD0Qjzh+uKeiyJpBMEXGym4A1QeyUd8vV
        ADUui96TURRvs42n7iSCddMlzzV5Ml+7ZrQ1iCqkEWItpesEzeAmUYKe+LwJBkV94pGedqAvMPlCy
        Hcq4fT3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOxdf-00FXIk-7i; Tue, 01 Mar 2022 08:13:43 +0000
Date:   Tue, 1 Mar 2022 00:13:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 1/3] PCI/ASPM: Add pci_enable_default_link_state()
Message-ID: <Yh3Vt6/WzoAasPxZ@infradead.org>
References: <20220301041943.2935892-1-david.e.box@linux.intel.com>
 <20220301041943.2935892-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301041943.2935892-2-david.e.box@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 08:19:41PM -0800, David E. Box wrote:
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +	link->aspm_default = 0;
> +	if (state & PCIE_LINK_STATE_L0S)
> +		link->aspm_default |= ASPM_STATE_L0S;
> +	if (state & PCIE_LINK_STATE_L1)
> +		/* L1 PM substates require L1 */
> +		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> +	if (state & PCIE_LINK_STATE_L1_1)
> +		link->aspm_default |= ASPM_STATE_L1_1;
> +	if (state & PCIE_LINK_STATE_L1_2)
> +		link->aspm_default |= ASPM_STATE_L1_2;
> +	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> +		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
> +	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> +		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
> +	pcie_config_aspm_link(link, policy_to_aspm_state(link));

Is there any reason the ASPM_* values aren't passed directly to this
function?
