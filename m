Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03079776867
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 21:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjHITSK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHITSE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 15:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2003593;
        Wed,  9 Aug 2023 12:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D6D6456F;
        Wed,  9 Aug 2023 19:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9EAC433C8;
        Wed,  9 Aug 2023 19:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691608674;
        bh=So2PRKw8ZCOEFwW9XupsjdBDzsxar1LooBtXDyBawhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KNIpONfjMOqdOOkOS3VsKo5qshBF9ZShewyumXkNUf6eK9RX2NEriEpSyZJotmH6n
         C38eREiOK8lXUDjdkuEShDcM1A2htSOkpYuuPkOfiBMRZakNvvaPSMsgvECXeDPlcR
         U88WLrtpft7vF/RCQOfr5jjM/hkfER20mNl+DBr5Iao35oGVDFdu9G3CLivN2iDzuJ
         xPzQPnRl3nbjxks9OqS5ASdIi9zbLl37XYKlBfnWnF5tdwGYQZxRd+WN5Spc+9gCia
         fbKBfq6XYhK4W8Hii6OD+voT4R0N0Snjj3D1jJzHW8gzZuoAExWlMk8QHU7b9Cnb4a
         CVOflEAbIa5ww==
Date:   Wed, 9 Aug 2023 14:17:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: switchtec: Add support for PCIe Gen5 devices
Message-ID: <20230809191752.GA405275@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624000003.2315364-1-kelvin.cao@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 05:00:01PM -0700, kelvin.cao@microchip.com wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Hi,
> 
> This patchset adds support for Switchtec PCIe Gen5 devices by adding
> device IDs to the driver and PCI quirks. There's also minor code change
> to accommodate those devices.
> 
> The patchset is based off of v6.4-rc7.
> 
> Thanks,
> Kelvin
> 
> Kelvin Cao (2):
>   PCI: switchtec: Use normal comment style
>   PCI: switchtec: Add support for PCIe Gen5 devices
> 
>  drivers/pci/quirks.c           |  36 ++++++++
>  drivers/pci/switch/switchtec.c | 158 ++++++++++++++++++++-------------
>  include/linux/switchtec.h      |   1 +
>  3 files changed, 134 insertions(+), 61 deletions(-)

Applied with Logan's Reviewed-by for v6.6, thanks!

Bjorn
