Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23D84F9814
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiDHOdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 10:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbiDHOcz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 10:32:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9E2D37CD02;
        Fri,  8 Apr 2022 07:30:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF470113E;
        Fri,  8 Apr 2022 07:30:51 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A5843F73B;
        Fri,  8 Apr 2022 07:30:48 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup
Date:   Fri,  8 Apr 2022 15:30:48 +0100
Message-Id: <164942823614.23463.14514504733320823500.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220309091953.5630-1-linmq006@gmail.com>
References: <20220309091953.5630-1-linmq006@gmail.com>
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

On Wed, 9 Mar 2022 09:19:52 +0000, Miaoqian Lin wrote:
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> 

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup
      https://git.kernel.org/lpieralisi/pci/c/214e0d8fe4

Thanks,
Lorenzo
