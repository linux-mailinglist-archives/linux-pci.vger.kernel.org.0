Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60694C2EF4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 16:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiBXPGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiBXPGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 10:06:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3047A194164;
        Thu, 24 Feb 2022 07:05:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E753EED1;
        Thu, 24 Feb 2022 07:05:49 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.39.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 553923F66F;
        Thu, 24 Feb 2022 07:05:46 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        alex@ghiti.fr
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        catalin.marinas@arm.com, Toan Le <toan@os.amperecomputing.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 05/14] sizes.h: Add SZ_1T macro
Date:   Thu, 24 Feb 2022 15:05:39 +0000
Message-Id: <164571512667.19192.1380245684595719481.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <575cb7164cf124c75df7cb9242ea7374733942bf.1642752946.git.christophe.leroy@csgroup.eu>
References: <cover.1642752946.git.christophe.leroy@csgroup.eu> <575cb7164cf124c75df7cb9242ea7374733942bf.1642752946.git.christophe.leroy@csgroup.eu>
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

On Fri, 21 Jan 2022 08:42:21 +0000, Christophe Leroy wrote:
> Today drivers/pci/controller/pci-xgene.c defines SZ_1T
> 
> Move it into linux/sizes.h so that it can be re-used elsewhere.
> 
> 

Applied to pci/misc, thanks!

[05/14] sizes.h: Add SZ_1T macro
        https://git.kernel.org/lpieralisi/pci/c/0cc62aed37

Thanks,
Lorenzo
