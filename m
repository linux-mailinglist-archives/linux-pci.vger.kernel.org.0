Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CCD72E788
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jun 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbjFMPl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jun 2023 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbjFMPlz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2023 11:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A280D1;
        Tue, 13 Jun 2023 08:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D128662D8C;
        Tue, 13 Jun 2023 15:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1BEC433F0;
        Tue, 13 Jun 2023 15:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686670913;
        bh=mxujzVE3U2tcdQh9vnM4CPFAon04l80gvhky/6Ih4W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niFtrS2qRWogHyyBFtIM5+S3tCWyuhiRNLSaRI9kSd+9pOp97lBsHNPV1vbWM1Qz0
         L+rrnPOxmLWht7DrjclX254a+3oMPr/jX+w13eDeCqq85GwMgrWwXIEF//Vl+ixPUb
         K7AeJaO20Un2SpZV6jYJp5ks1gNqIa8a1dTeQGpDD5ntUST77eIq56Wwjur3z+NzdE
         cLdR77ILMJ7fx3lx9r4b9P31UsDExuInmPHzgUkz/qfBTK1BkSwOHg3/dkJYPHuh5z
         dHipdGY1qG5IkFaAeOPvtmNP7NtfiPCYJJnhGh8rYbHQzzImfvkBpcIyoNLUrC1xr5
         DhhBo8KeChVeQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, allenbh@gmail.com,
        bhelgaas@google.com, dave.jiang@intel.com, helgaas@kernel.org,
        imx@lists.linux.dev, jdmason@kudzu.us, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mani@kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: fix typo span in comments
Date:   Tue, 13 Jun 2023 17:41:46 +0200
Message-Id: <168667089297.152634.11398197369856655476.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20221214172254.668282-1-Frank.Li@nxp.com>
References: <20221214172254.668282-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 14 Dec 2022 12:22:54 -0500, Frank Li wrote:
> Replace span with spad.
> 
> 

Applied to controller/endpoint, thanks!

[1/1] PCI: endpoint: pci-epf-vntb: fix typo span in comments
      https://git.kernel.org/pci/pci/c/9e7f4414529b

Thanks,
Lorenzo
