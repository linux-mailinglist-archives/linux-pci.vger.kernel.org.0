Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921954F970A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiDHNlg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiDHNle (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 09:41:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 051F531FFCE;
        Fri,  8 Apr 2022 06:39:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ABFC113E;
        Fri,  8 Apr 2022 06:39:29 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6575F3F5A1;
        Fri,  8 Apr 2022 06:39:27 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tom Joseph <tjoseph@cadence.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: Fix find_first_zero_bit() limit
Date:   Fri,  8 Apr 2022 14:39:26 +0100
Message-Id: <164942515020.27022.3293233465151133190.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220315065829.GA13572@kili>
References: <20220315065829.GA13572@kili>
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

On Tue, 15 Mar 2022 09:58:29 +0300, Dan Carpenter wrote:
> The ep->ob_region_map bitmap is a long and it has BITS_PER_LONG bits.
> 
> 

Applied to pci/cadence, thanks!

[1/1] PCI: cadence: Fix find_first_zero_bit() limit
      https://git.kernel.org/lpieralisi/pci/c/0aa3a0937f

Thanks,
Lorenzo
