Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECCC5F6B36
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJFQHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJFQHA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 12:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8DC2AC0;
        Thu,  6 Oct 2022 09:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08FA1619F3;
        Thu,  6 Oct 2022 16:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5EAC433C1;
        Thu,  6 Oct 2022 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665072418;
        bh=GGru+8sbJMjinEq83pAZv/oY3nAPx/Kxa/Uh35InZ60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K9P4bCWhaT/BOtpZlOMk30/5KsskSUIZ1Lwbfbmc23LQvk7iT03JBUkeaBHpAgnsf
         EWBwyvWTA7HGQRiQCHwjgw5WW+lYOMRIzJjSZDNrNqikFBtedXJztDCEMDNQTZ5b13
         7JVcJ68Jjl0ntZCsOCvuasXXOZTtSoXX10dIpoWT1MJZN7pwS7tPA39PK5mKrfFas1
         fUE82sZiyVgcBVMO22WCku2M6OfDwO+ij3kPIS5kcJTfF2QoOehyO59reKEGargJxp
         YWoVgtsqA4or4QP61YmdspmepAokfSA67Dxu3x2d5YOCbCStbafmQ0gNXLoKDwr7Vq
         5sBXaqdYP454g==
Date:   Thu, 6 Oct 2022 11:06:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>,
        Yuval Shaia <yshaia@marvell.com>
Subject: Re: [PATCH 2/2] PCI: armada8k: Add MSI support for AC5 SoC
Message-ID: <20221006160656.GA2469901@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006111110.8574-3-vadym.kochan@plvision.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 06, 2022 at 02:11:10PM +0300, Vadym Kochan wrote:
> From: Yuval Shaia <yshaia@marvell.com>
> 
> AC5 requieres different handling for MSI as with armada8k.
> Fix it by:
> 1. Enabling the relevant bits in init phase
> 2. Dispatch virtual IRQ handlers when MSI interrupts are received

s/requieres/requires/
