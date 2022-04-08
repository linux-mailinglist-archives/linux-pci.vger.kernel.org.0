Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327404F9438
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 13:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiDHLiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiDHLiS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 07:38:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECDBF1FA5F;
        Fri,  8 Apr 2022 04:36:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73D311FB;
        Fri,  8 Apr 2022 04:36:13 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E00BC3F73B;
        Fri,  8 Apr 2022 04:36:11 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Li Yang <leoyang.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] layerscape-pci binding updates
Date:   Fri,  8 Apr 2022 12:36:11 +0100
Message-Id: <164941775622.8829.451405503326194255.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220311234938.8706-1-leoyang.li@nxp.com>
References: <20220311234938.8706-1-leoyang.li@nxp.com>
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

On Fri, 11 Mar 2022 17:49:34 -0600, Li Yang wrote:
> This series includes two binding changes from Zhiqiang's previous
> submission ("[PATCHv5 0/6] PCI: layerscape: Add power management
> support") and rebased to latest 5.17-rc1:
> 
> They describe the hardware and are not necessarily connected with the PM
> driver changes.  The series also includes two other binding updates to
> better describe the pcie hardware.
> 
> [...]

Applied to pci/layerscape, thanks!

[1/4] dt-bindings: pci: layerscape-pci: Add a optional property big-endian
      https://git.kernel.org/lpieralisi/pci/c/6c389328c9
[2/4] dt-bindings: pci: layerscape-pci: Update the description of SCFG property
      https://git.kernel.org/lpieralisi/pci/c/84f293b204
[3/4] dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for ls1028a
      https://git.kernel.org/lpieralisi/pci/c/cddc1a9ab3
[4/4] dt-bindings: pci: layerscape-pci: define AER/PME interrupts
      https://git.kernel.org/lpieralisi/pci/c/a3b18f5f1d

Thanks,
Lorenzo
