Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB714F986F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 16:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiDHOqL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbiDHOqK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 10:46:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3F0AFABCF;
        Fri,  8 Apr 2022 07:44:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C17113E;
        Fri,  8 Apr 2022 07:44:06 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541863F73B;
        Fri,  8 Apr 2022 07:44:02 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        robh@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "zhangjianrong (E)" <zhangjianrong5@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>, guhengsheng@hisilicon.com,
        songxiaowei@hisilicon.com, "xuetao (kirin)" <xuetao09@huawei.com>,
        caiyadong <caiyadong@huawei.com>
Subject: Re: [PATCH v2] PCI: dwc: Fix setting error return on MSI DMA mapping failure
Date:   Fri,  8 Apr 2022 15:43:57 +0100
Message-Id: <164942900916.30630.9420081652336404803.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <30170911-0e2f-98ce-9266-70465b9073e5@huawei.com>
References: <CAL_JsqJNMGobo1iaBjqSQJXNy9arXGU+et20dMueCK44seGnQw@mail.gmail.com> <30170911-0e2f-98ce-9266-70465b9073e5@huawei.com>
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

On Wed, 9 Mar 2022 20:01:04 +0800, Jiantao Zhang wrote:
> When dma_mapping_error() returns error because of no enough memory,
> but dw_pcie_host_init() returns success, which will mislead the callers.
> 
> 

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Fix setting error return on MSI DMA mapping failure
      https://git.kernel.org/lpieralisi/pci/c/88557685cd

Thanks,
Lorenzo
