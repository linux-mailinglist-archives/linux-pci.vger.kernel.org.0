Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7F6F2A6D
	for <lists+linux-pci@lfdr.de>; Sun, 30 Apr 2023 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjD3TN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Apr 2023 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjD3TN0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Apr 2023 15:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97A01710;
        Sun, 30 Apr 2023 12:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6764D60BCA;
        Sun, 30 Apr 2023 19:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAA4C433EF;
        Sun, 30 Apr 2023 19:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682882004;
        bh=CcWs4ZFiQFleSoY0U1jMTWmqa8QyuxQSPZ++resrXaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UGAO3vkoxLYCxIEk6ayKZPHBLR6hzJA+3Z6Os6wYLCDWs2JuwJjtt/s/UJlAt8j+d
         81aob+39TTL6uKuO1Ndaq4zQ++yN13GrN9d7iccp+r1U8FVxQmq36LlFDb4PxnYEoh
         CgXPAdL5EqjK9Qubt51argcyukDYx9BewJ0J97k6PG/vG/DHQxMw5Ac8guJAc4OWlj
         snRZzZvQ092Uasen7m3FUOO2cUOze4zIL6nDwLLC48TVIAaQhv4NC6kTgXveRu3Fuq
         I8DRCLgzP1ttrno05/S6MWZARvMhPpsfENfn/6A7gJ/8C0a18ym8IAki3eYb1Awjxt
         FQ3tMq8shkQXQ==
Date:   Sun, 30 Apr 2023 14:13:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] PCI: brcmstb: Set PCIe transaction completion
 timeout
Message-ID: <20230430191323.GA388047@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428223500.23337-4-jim2101024@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 28, 2023 at 06:34:57PM -0400, Jim Quinlan wrote:
> Since the STB PCIe HW will cause a CPU abort on a PCIe transaction
> completion timeout abort, we might as well extend the default timeout
> limit.  Further, different devices and systems may requires a larger or
> smaller amount commensurate with their L1SS exit time, so the property
> "brcm,completion-timeout-us" may be used to set a custom timeout value.

s/requires/require/

AFAIK, other platforms do not tweak Configuration Timeout values based
on L1SS exit time.  Why is brcm different?

Bjorn
