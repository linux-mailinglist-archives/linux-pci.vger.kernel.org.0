Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B225BEE16
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 22:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiITT76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 15:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITT76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 15:59:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554572B615;
        Tue, 20 Sep 2022 12:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11374B82CB8;
        Tue, 20 Sep 2022 19:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E8DC433D6;
        Tue, 20 Sep 2022 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663703994;
        bh=q6ZE9asDkmshxBcvLwxNsIFWWWZZN2R2ZEgJ2PWZZG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JsLlBWzfaoecv70JWdQLeiydy95v2wmlEiZEmFf3mIHM+2XGsCtBs4AXfTgG0h1Nn
         B+iBghDWUXAF1JseGrmWXj+8JqOVWHGlrtGd4snSAOVmRwQJsF8cO+H39ypZefAcGZ
         zJ9XMxy8NwAisAySvCkgKtX3wmD04OrUCPQCScPJWb/bimkaOlmriNxGdp6/yFZjbe
         Jc3P74Blfc8wt3DEY+h7PKRsJJfhDUrF/8qHQx8bE9latuC5DT2uvh0A5ZBdx1GLKt
         PiHH/RWg1Yrjkefb9f6Ubh+nV19UFY5l0ehP7T/azfMVHNu1imwvE1UP2vQmwTq3yb
         JDYpzmKjVXcNQ==
Date:   Tue, 20 Sep 2022 14:59:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 08/12] PCI: renesas: Add R-Car Gen4 PCIe Host support
Message-ID: <20220920195952.GA1132446@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905071257.1059436-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"PCI: renesas" is too general for the subject line.  The typical
pattern would be "PCI: rcar-gen4" for the host driver and "PCI:
rcar-gen4-ep" for the endpoint driver.

On Mon, Sep 05, 2022 at 04:12:53PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe.
