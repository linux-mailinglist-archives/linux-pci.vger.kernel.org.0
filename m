Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC66FE80F
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 01:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjEJXVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 19:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbjEJXVf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 19:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155EB5FE5;
        Wed, 10 May 2023 16:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC50640C2;
        Wed, 10 May 2023 23:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF415C4339B;
        Wed, 10 May 2023 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683760893;
        bh=LeOs6hgtiwbt9HgoDi78vGeUEtrWIOZYjoAiOiiiqOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XHKFnoxCLM/Pwk9KUDg8ONzdaGdjKtAG3znRuiAoNCBxE83vDvC/s2nJxf5GyS9cI
         oCp68bYDWs2kWgP5MKhiW9qfwdozPn7sFTYYKMLX1XqP0IQPqandjyDfxhoyxN6Sme
         /OUYg2TIpkwPScZvasZ2JGe7DBar3E9AwckyOcEzRhL5dit+cKdfEEeY2bBJveqZ2w
         3LRwDP0T25u3uFw1mGMJD2r2p0dUrsBWm1IYL7Ajw+XxNjEG58wbYf35blkjysBij7
         KiZgyqSWVwwJ3eXSvpmlMKCYuuYgS6Z3RU3vcur42BAKavUX2uAZ6zgkBK5Z9iGCGU
         X/SNE5wdGTeqg==
Date:   Wed, 10 May 2023 18:21:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] PCI: brcmstb: Don't assume 2711 bootloader leaves
 PERST# asserted
Message-ID: <ZFwm+7pteghO3YPX@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNyAd8V1kqnfef_ektizOME3_ENEKMYaC0Q_EVdOLvBRhA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 06:46:45PM -0400, Jim Quinlan wrote:
> On Wed, May 10, 2023 at 6:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > Re subject, what does the patch actually *do*?
> >
> > It looks like it "asserts PERST# on BCM2711", which I think would be
> > more informative than "don't assume 2711 bootloader leaves PERST#
> > asserted".
> 
> Do you have any other feedback on the other commits?  I can change the
> subject message as you like  and the remove the stale footnote you and
> Cyril noticed, and submit V6.

Nope, and there's really no hurry.  Trivial stuff like this can be easily
done when merging.  I think two postings per week is plenty.  Each new
posting takes work to look at, so it's a win to wait a bit and
accumulate non-trivial updates before reposting.

Bjorn
