Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF7053BF4B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiFBUGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiFBUFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 16:05:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BA52CDC8;
        Thu,  2 Jun 2022 13:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89D45B81F37;
        Thu,  2 Jun 2022 20:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA5C385A5;
        Thu,  2 Jun 2022 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654200342;
        bh=EK/YmFBGims7pu+cW/NHOetHKJmI5nJOJouxJwCJQ6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QPYUpg5EzyP3gIkA/yjPJOwR7LVeAk8yg/U7u4lvoPX2tT3SUH+8aU15dJlbpJIXY
         J0YzoblSvMA9uQJ0Mc51or8/Rf/66+eBlKKry4/Wpga5lfD33vqsa3ag0ZNbY489AL
         QWYejVVy2RUTRVM5IRjTRGORtGuDCjUHRyI5nVC2PhpoOX2eDrYnZSl7NoCfdw+Qb2
         54Ss5TClHCcUSz2HSLhfc50YUDsWnv5ceHW6X/cZxMP8aiYg6KbGak1mWviGLIlGLL
         oS/QxODRoQ9c/qdYFc+MM2GnIUwbs3UjPwPkhkxvN+M7E4oy4ubFLSH/xdVfhQSF10
         8DrFSkY/6B3KQ==
Date:   Thu, 2 Jun 2022 15:05:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing
 PCIe linkup
Message-ID: <20220602200540.GA41459@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602191757.pqictbfarmvlf72f@mraw.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 09:17:57PM +0200, Cyril Brulebois wrote:

> ...
> Sorry I didn't manage to get that lined up before Bjorn's pull request.

No rush, if I had been on the ball, I would have done the reverts
earlier so v5.18 didn't release with the regression.
