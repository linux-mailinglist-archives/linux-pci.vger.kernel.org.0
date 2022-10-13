Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4538A5FDC27
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJMOMf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 10:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJMOMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 10:12:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D52101EB;
        Thu, 13 Oct 2022 07:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5359EB81E62;
        Thu, 13 Oct 2022 14:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04C5C433D6;
        Thu, 13 Oct 2022 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665670347;
        bh=5Lr9MWZLnx0BF0zAIJTTaN2Kclq5SbmFy4FXvIbfDKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EQ2qo9mpD3Swcywula6CfKA3rIu8MsV0cz6xq+Q5yILLEKstheEncAlK32ijcWpys
         j95N820KUbARrx6niFO9XX0CsCihHltgE1UmZW9BDJSOBDtyO/jehLBpOBlOY3r9jm
         83DUfRl8r8e9X8dbEkWCILL1V3mT7n5/dD240UE9llXhRGJAe/kWGdSaUmguW3brr7
         x8WRqERvwZDcNAl2bcjLlyQM0bPBBh40VOho93EjjmisLFN3pfVRw2yYL2ITE7VJZC
         8mEtUFq9m6jroXcNHdoyN+RZimUfV8UaKiOfrr7w+69uBigVtmoMbMKssPxqj8uaBg
         YFZJPP6o9EUYw==
Date:   Thu, 13 Oct 2022 09:12:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
Message-ID: <20221013141225.GA3245514@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011184211.18128-6-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 11, 2022 at 02:42:10PM -0400, Jim Quinlan wrote:
> Set RCB_MPS mode bit so that data for PCIe read requests up to the size of
> the Maximum Payload Size (MPS) are returned in one completion, and data for
> PCIe read requests greater than the MPS are split at the specified Read
> Completion Boundary setting.
> 
> Set RCB_64B so that the Read Compeletion Boundary is 64B.

s/Compeletion/Completion/
