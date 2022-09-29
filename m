Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40535EF0CB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 10:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiI2Irm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 04:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiI2Irk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 04:47:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76957133CAB;
        Thu, 29 Sep 2022 01:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18A2DB821F2;
        Thu, 29 Sep 2022 08:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48122C433B5;
        Thu, 29 Sep 2022 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664441255;
        bh=Vv10LeELwgV/jutorQpxnf35fil0pkpxpZIhlnO4P6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chP0iiA73P2n30Eg3s5Epk8D+7V78RiIgMLKS5z7xC1llAunDJLsYl+qLFtcyWYfM
         tPku0dDDbnpD68NEVPcskvQ3Eo9F6uHSIBro6jFlUCGVgXFl35Q703Cdd7Cf3jp4eO
         4Cck7s/CkcujpkKNhbz8phnx1Ift4MTph9E59Crkgv7PJNumQ3kYI9a3sQUSb26ZLf
         kd7XNrnXI1oIILz83P5ZyAZCikl9M14wCl2sGD1wgVCEMgo2FvYOkEL9AjxEzixZxg
         vx3+l5rqJa50Pk7JSLJaDMix65Bm3NJqsk70MG8seq7l9v9pj0oy7zN+3uM+nMsxmV
         OWzL8ALaHzFpw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Date:   Thu, 29 Sep 2022 10:47:30 +0200
Message-Id: <166444123034.167287.381471789619893320.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928121911.14994-1-pali@kernel.org>
References: <20220928121911.14994-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Sep 2022 14:19:11 +0200, Pali Rohár wrote:
> Simplify pci-tegra.c driver code and use new PCI_CONF1_EXT_ADDRESS() macro
> for accessing PCI config space.
> 
> 

Applied to pci/misc, thanks!

[1/1] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
      https://git.kernel.org/lpieralisi/pci/c/8bb7ff12a914

Thanks,
Lorenzo
