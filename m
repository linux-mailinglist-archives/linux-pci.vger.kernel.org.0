Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2417373507C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 11:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjFSJi5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSJiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 05:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518E483;
        Mon, 19 Jun 2023 02:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E128960B28;
        Mon, 19 Jun 2023 09:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28BAC433C8;
        Mon, 19 Jun 2023 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687167533;
        bh=quqElhncVEyv+e0eDCY/ZThqI2GSHt6Rq4mnLald54c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufCwLQ2rxo9NaB33F/CMZ+kUf3aVE4cwXnB+BEjaNSBm/IqaWsG0jRWtGcbBzssqY
         mQ9yUJ45jmactYe2/CZWUvApSoddi1WsQTt5MosfJ6EwoPs8gv/kVdSoYbQq7dfCDe
         7t4bWjsR82arIjIGT90G70hgy6zMwPBcxfcruoxvWBoAz7kaIO8UZ643lwEnL6r1AV
         Y2Tb794pKNTjt6vm/0DlGPFZGALd/Y9Gs77PrifgftjlRbILzaThLnKIozXaj+7R8G
         pR/w+BgOVuq2I+AN+No3UI12ny9Dc3f+o6Pbik2rl701PrUdEOKbhS77QB0hMrGPco
         BBAAkAIRO8ibQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in suspend and resume
Date:   Mon, 19 Jun 2023 11:38:41 +0200
Message-Id: <168716742193.19064.16064178044930090085.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1670479534-22154-1-git-send-email-hongxing.zhu@nxp.com>
References: <1670479534-22154-1-git-send-email-hongxing.zhu@nxp.com>
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

On Thu, 08 Dec 2022 14:05:34 +0800, Richard Zhu wrote:
> The MSI Enable bit controls delivery of MSI interrupts from components
> below the Root Port. This bit might lost during the suspend, should be
> re-stored during resume.
> 
> Save the MSI control during suspend, and restore it in resume.
> 
> 
> [...]

Applied to controller/dwc (commit log rewritten - please check), thanks!

[1/1] PCI: imx6: Save and restore MSI control of RC in suspend and resume
      https://git.kernel.org/pci/pci/c/3bbc3c72c4b8

Thanks,
Lorenzo
