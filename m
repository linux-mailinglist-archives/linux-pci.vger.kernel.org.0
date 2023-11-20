Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6B7F1FCB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 22:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjKTV40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 16:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKTV40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 16:56:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE981CA
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 13:56:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0A4C433C7;
        Mon, 20 Nov 2023 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700517382;
        bh=5V1g66lad4i6DynQyCCaWJvM9X22zgoHzLIoSLTiUaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbvysa2pTpVSsYrPDW7pwS8dhbR6aerdknqJbytBG9dobQ75z4ZMM+X8e00ORefO9
         E1K8SlIkol13bGRpZZkSnI8OgbCeRA6PS8Pc32HM4Ja/iDc6hvSPFWDa9tdao2IlIw
         GVo1+abglamvKwL7bC+HrtpmT2tACxCQXtit23UkyMBXRhSVOrebqjEJM0zYUKYVjZ
         8F6BsvpVni1WBd5Ob6ou3AMPj7lWFs0M3bDZl/ws2DwYze+o4yLEzAVSnq1IiH5cJD
         m+BnAuGzW9byD7iZeyJgrE7Qc30JlubtzjnLOaFkb42h7ep5/dtlfPzjEqcBpmmwnj
         T/wfQfa2TEW0g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Will Deacon <will@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback returning void
Date:   Mon, 20 Nov 2023 15:56:18 -0600
Message-Id: <170051728317.217544.2195167252059868427.b4-ty@google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020092107.2148311-1-u.kleine-koenig@pengutronix.de>
References: <20231020092107.2148311-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>


On Fri, 20 Oct 2023 11:21:07 +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code.  However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> [...]

Applied to "enumeration" for v6.8, thanks!

[1/1] PCI: host-generic: Convert to platform remove callback returning void
      commit: d9dcdb4531fe39ce48919ef8c2c9369ee49f3ad2

Best regards,
-- 
Bjorn Helgaas <bhelgaas@google.com>
