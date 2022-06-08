Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820C9543BCC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiFHSy6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiFHSy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 14:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDAC1216E2;
        Wed,  8 Jun 2022 11:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE4261BFD;
        Wed,  8 Jun 2022 18:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE74C34116;
        Wed,  8 Jun 2022 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654714496;
        bh=4DkBSx4PBlnqbuIvbhb4BY8MQw6NCv8/SsM4J3UI200=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nk2FUfxEP+uq3OPC6Dt0OjmJBwVFkRhSYXWUqZCTKRS1QEn7Oj6wz15yH1dfa+Um8
         /QxZ8R3hevC4EyX8LfK/sKFeav+F0Efn0n551rE6G+cqrq1Q4wPtS58Ih15LTaRy89
         FNxo3h2Nby46ARYYtazJVL+UIiR9LprPxwmS7SzyIFwhG9L07Z515sqVoaALr9pc/W
         CGGFIou/eiDJgdZcIvisYj8xTAXySksWdIckimvcK2obq1i6xDi+SqkXnafvtdCmzm
         GfQ2WsLCjxdImBQV4T6cqOXqdvkrXPnQwt6XbUDJXlrYqOX/bLEDfTdlxwWlYxMs3e
         dWBrpCBCWH0PQ==
Date:   Wed, 8 Jun 2022 13:54:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Message-ID: <20220608185453.GA410841@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651801629-30223-6-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 06, 2022 at 09:47:06AM +0800, Richard Zhu wrote:
> The driver should undo any enables it did itself. The regulator disable
> shouldn't be basing decisions on regulator_is_enabled().
> 
> To keep the balance of the regulator usage counter, disable the regulator
> just behind of imx6_pcie_assert_core_reset() in resume and shutdown.

In subject, "Refine" doesn't tell me anything about what's happening
here.
