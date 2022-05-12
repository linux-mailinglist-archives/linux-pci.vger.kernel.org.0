Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16652506D
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 16:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355121AbiELOlm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 10:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355489AbiELOll (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 10:41:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 077FC62105;
        Thu, 12 May 2022 07:41:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC1C0106F;
        Thu, 12 May 2022 07:41:40 -0700 (PDT)
Received: from e123427-lin.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E7E13F73D;
        Thu, 12 May 2022 07:41:39 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kishon@ti.com,
        dominic.rath@ibv-augsburg.net, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v3] PCI: cadence: Allow PTM Responder to be enabled
Date:   Thu, 12 May 2022 15:41:30 +0100
Message-Id: <165236647653.32307.17828206891941657496.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220512055539.1782437-1-christian.gmeiner@gmail.com>
References: <20220512055539.1782437-1-christian.gmeiner@gmail.com>
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

On Thu, 12 May 2022 07:55:38 +0200, Christian Gmeiner wrote:
> This enables the Controller [RP] to automatically respond with
> Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
> and PCI_PTM_CTRL_ENABLE bits are both set.
> 
> 

Applied to pci/cadence, thanks!

[1/1] PCI: cadence: Allow PTM Responder to be enabled
      https://git.kernel.org/lpieralisi/pci/c/0f0cd520aa

Thanks,
Lorenzo
