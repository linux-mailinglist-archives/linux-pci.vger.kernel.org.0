Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDF722919
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjFEOpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjFEOpX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 10:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C356E9;
        Mon,  5 Jun 2023 07:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6B19625E8;
        Mon,  5 Jun 2023 14:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB61FC433A1;
        Mon,  5 Jun 2023 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685976321;
        bh=+Q6hWNw4cvZkLGpiw1bRBGU1wmtxT/1vdjg4Hg9F6cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihQ7pDOt+nazCAAkqERNtmqAlsRLDw+j0FNRBQXnGk2b6Jutq1Bxj1c6vpQx4PlxE
         8pQ3v8EXIoYQCpgzrSmmBkn9VetDaRv3+vRxZRN+Q5rTHCL5+/N8H4VrnSU2c1jNfs
         lz/6uvlWgv9ptTntVjRU3srs1O3BV6I3NJ/WTPVds+1rysYu6yGN18CFcEREcdx4qj
         /7/t2rSKxNu+ybu3qgJ3jBfg4SXjS+88EoKQGQeFuH6YERFtwaea2HtBc1J0RZOjja
         5w+Rs2UyEdmClN5EVP1+3XjbZ3Fee5ZnyRxWiTVxw2pXYFkAJA5E95htQG9eb+d0Pf
         kdHuKBF/9b/fg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     kw@linux.com, Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org
Subject: Re: [PATCH v6 0/9] Add support for MHI Endpoint function driver
Date:   Mon,  5 Jun 2023 16:45:14 +0200
Message-Id: <168597627549.35299.2498849386988446406.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 02 Jun 2023 17:17:47 +0530, Manivannan Sadhasivam wrote:
> This series adds support for Modem Host Interface (MHI) Endpoint function
> driver and few updates to the PCI endpoint core.
> 
> MHI
> ===
> 
> MHI is the communication protocol used by the host machines to control and
> communicate with the Qualcomm modems/WLAN devices over any high speed physical
> bus like PCIe. In Linux kernel, MHI is modeled as a bus driver [1] and there
> are two instances of MHI used in a typical setup.
> 
> [...]

Applied [with few changes, please check] to controller/endpoint, thanks!

[1/9] PCI: endpoint: Add missing documentation about the MSI/MSI-X range
      https://git.kernel.org/pci/pci/c/4753e6a0fe22
[2/9] PCI: endpoint: Pass EPF device ID to the probe function
      https://git.kernel.org/pci/pci/c/765b0e80681a
[3/9] PCI: endpoint: Return error if EPC is started/stopped multiple times
      https://git.kernel.org/pci/pci/c/0ff3de7a6c87
[4/9] PCI: endpoint: Add linkdown notifier support
      https://git.kernel.org/pci/pci/c/755cb1cc2615
[5/9] PCI: endpoint: Add BME notifier support
      https://git.kernel.org/pci/pci/c/a2bd0e62f6fd
[6/9] PCI: qcom-ep: Add support for Link down notification
      https://git.kernel.org/pci/pci/c/c53dc1547231
[7/9] PCI: qcom-ep: Add support for BME notification
      https://git.kernel.org/pci/pci/c/258dfe82065c
[8/9] PCI: endpoint: Add PCI Endpoint function driver for MHI bus
      https://git.kernel.org/pci/pci/c/fd0fda1ef61a
[9/9] MAINTAINERS: Add PCI MHI endpoint function driver under MHI bus
      https://git.kernel.org/pci/pci/c/71f1861bb90d

Thanks,
Lorenzo
