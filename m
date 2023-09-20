Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16C7A7427
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjITHb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjITHb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 03:31:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56390D7;
        Wed, 20 Sep 2023 00:31:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C9BC433C8;
        Wed, 20 Sep 2023 07:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195081;
        bh=hU52SYwvUa68CMm7CAUtso5H9LNTlljDIWx6EdheBHs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tnikUu7kNFOKmRNvjZ90VttjaizflA+nEASVJVpEx8xqZPx71pP6PUcmZofaMLw6c
         ax71ixqyjwIed+hOrCy9nz8EtXbcDfX6xY+wPe78N5Z4s+OuyDm2Y0PyJaUaOL3gNP
         ymvcYERFkIvlO33M2je/XLpJPRG1od8nDsI4+/5HIyPsLSJv/FmxHdnFRO4d21+D7n
         e233JegozX8XzLUe+020o/H8XK9+aq71ZUzfCiKw9WM2C0oI23H5BOZN1hFd1zqfM2
         /XseirgYk1+l19aVvfrCLO2c7iHsPrM098w7blYM/CnefWqnMwcZdCxD3OS0CpT0at
         gaLjcjMYeT2FQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
References: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
Subject: Re: (subset) [PATCH v3 0/8] PCI/treewide: PCIe capability access cleanups
Message-Id: <169519507781.1031333.15270013101496091274.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 10:31:17 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 19 Sep 2023 15:56:40 +0300, Ilpo Järvinen wrote:
> Instead of custom code to extract the PCIe capabilities, make the code
> more obvious using FIELD_GET/PREP().
> 
> Also cleanup some duplicated defines in e1000e.
> 
> This is just a step into the right direction, there's plenty of places
> still to cleanup which will have to wait for another patch series.
> 
> [...]

Applied, thanks!

[1/8] RDMA/hfi1: Use FIELD_GET() to extract Link Width
      https://git.kernel.org/rdma/rdma/c/8bf7187d978610

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
