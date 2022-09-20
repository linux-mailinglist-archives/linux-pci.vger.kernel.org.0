Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92A5BEE2F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 22:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiITUDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 16:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiITUDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 16:03:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CE950711;
        Tue, 20 Sep 2022 13:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A37A5CE19D1;
        Tue, 20 Sep 2022 20:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A500CC433D6;
        Tue, 20 Sep 2022 20:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663704220;
        bh=UXIlzFiphXJqLVJMqeyXuFwYoK8kOYg09IXa8PA5tUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vNpTkoySLGRSbw8ugTTmghoGejZqUm9DaSAwAFvb4BVf7QeBKQtwVbEFRFNuXIS3w
         8jAz9zoYxaIKCHrdHvwbRkpR5rkaGOjtOV4zbMW8wIIC5KvxpJR1KA5F7KWOA1UR1+
         /uznmT4iPKw7ta5NmfErcrK8G46ax++01RPgQyBgEcz2s5sJTTG8/KLas0gYSDFYp1
         3YwbA3JuAj3ogZcaiSmhPIYdAFLiklyEKjjy8kkKDACF3WmfGgHhWRQvnmHscWyUab
         mrsssscyw5R1iuDLauN2i36XQEAnt9Tz3uc8tY9WFpyUHgCQRPqKcsjwb2ebb+X9U6
         fzbnbVYmHEEYg==
Date:   Tue, 20 Sep 2022 15:03:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 05/12] PCI: dwc: Add ep_pre_init() callback to
 dw_pcie_ep_ops
Message-ID: <20220920200339.GA1132854@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905071257.1059436-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"PCI: designware-ep" in the prefix, since this is specific to ep.

There are several "PCI: dwc" prefixes, but those are typically things
that affect several dwc-based drivers.

On Mon, Sep 05, 2022 at 04:12:50PM +0900, Yoshihiro Shimoda wrote:
> Some PCIe endpoint controller needs vendor-specific initialization
> before the common code initialization. Add a nwe callback function
> ep_pre_init() for it.

s/Some ... controller needs/Some ... controllers need/
s/nwe/new/
