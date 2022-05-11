Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0915237FC
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbiEKQCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbiEKQCr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 12:02:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2BBF188E44;
        Wed, 11 May 2022 09:02:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40A79ED1;
        Wed, 11 May 2022 09:02:45 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69A2B3F73D;
        Wed, 11 May 2022 09:02:42 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>,
        tjoseph@cadence.com, bhelgaas@google.com, robh@kernel.org,
        kishon@ti.com, kw@linux.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, mparab@cadence.com,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: cadence: Clear FLR in device capabilities register
Date:   Wed, 11 May 2022 17:02:35 +0100
Message-Id: <165228494389.11307.11313445181760109588.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1637048356-73662-1-git-send-email-pthombar@cadence.com>
References: <1637048356-73662-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Nov 2021 23:39:16 -0800, Parshuram Raju Thombare wrote:
> From: Parshuram Thombare <pthombar@cadence.com>
> 
> Clear FLR (Function Level Reset) from device capabilities
> registers for all physical functions.
> 
> During FLR, the Margining Lane Status and Margining Lane Control
> registers should not be reset, as per PCIe specification.
> However, the controller incorrectly resets these registers upon FLR.
> This causes PCISIG compliance FLR test to fail. Hence preventing
> all functions from advertising FLR support if flag quirk_disable_flr
> is set.
> 
> [...]

Applied to pci/cadence, thanks!

[1/1] PCI: cadence: Clear FLR in device capabilities register
      https://git.kernel.org/lpieralisi/pci/c/d3dbd4d862

Thanks,
Lorenzo
