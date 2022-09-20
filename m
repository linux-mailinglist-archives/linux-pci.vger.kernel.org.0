Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A55BEE1F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 22:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiITUAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiITUAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 16:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9563D5B790;
        Tue, 20 Sep 2022 13:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA10C62634;
        Tue, 20 Sep 2022 20:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA42C4314B;
        Tue, 20 Sep 2022 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663704036;
        bh=UDOaZCytdBV8ujUQkRan0TYazujgcqfykNobCPQnFIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T7qc+UXpUAgJKuZ9lSRIM5v7y3K0MMsDtfh9bKKwZMy2QzLBNVna5pNa8HxXJfqI+
         wPc7qJilR/+4ZvQ0cEQM9xuHd8wEeaUFoznWvs61Wsz7ZY2GWV3Zod+XeUHPYWyN6h
         tW3Eyu9Swk9lRjwWXVHGvX0rr+16A17fWF7aQxG4Vzc6v+LCshrln+6lGQwKVcWaYK
         zWmRhEZk5MacPehyNopjsy/EunIP4KOhxpy3xpQgv+8BiZrgZcXoxPmTjVZ+6J99gr
         he9wzZC7vv/CAoIzKpZEeX2SlICPtqQgwApmGIAlRGyxRU/lV9CsT2h83uGvovi9xU
         koesZDzHRfq6g==
Date:   Tue, 20 Sep 2022 15:00:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 04/12] PCI: controller: dwc: Expose dw_pcie_ep_exit()
 to module
Message-ID: <20220920200034.GA1132782@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905071257.1059436-5-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use "git log --oneline" and copy the prefix style.

On Mon, Sep 05, 2022 at 04:12:49PM +0900, Yoshihiro Shimoda wrote:
> Expose dw_pcie_ep_exit() to module.
