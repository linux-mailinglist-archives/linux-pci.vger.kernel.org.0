Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9A576575
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiGOQ4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGOQ4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 12:56:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9479EF7;
        Fri, 15 Jul 2022 09:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E392B82D61;
        Fri, 15 Jul 2022 16:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFD6C34115;
        Fri, 15 Jul 2022 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657904164;
        bh=nElAzVIAv0nLtGkLSpnk4sOMhdMwLfbRx9XjW5h8H4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=raha1B32W4+ZrSGPi+rMQqE1vCSRzVr95GlL6ZOL7TWkdUwO6kNztk8j1xBSrYFxE
         cgxYyveCQu3xsRiD8tVpMOUmfSd7srNQDXDSEkQLJwVCDZArTqjBT4vGKLo9yz/7PS
         XFQJyG89a+DuNaA5QASqdmpGZSP2OcZsGtOMIlhKUTvMQH53nYHQ9SWjPoDOiYJing
         Vd0X03m+WFJ4aTdlD/Z/aAzPvo0MoU9qwA9RjAXLJnJ5Oa06UBkmWxIWQGsuoYUBrM
         9A1al3M41cZ1btJQr+GAAi7PRq7psCN1ZPCKom11veCBksJ1W0XJJpMjwVBXjL9GVs
         8+tbTj6T3oT1Q==
Date:   Fri, 15 Jul 2022 11:56:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Message-ID: <20220715165601.GA1139849@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef036db-2ac8-2723-93de-ac841d94ba51@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 04:05:41PM +0300, Dmitry Baryshkov wrote:
> On 14/07/2022 15:19, Stanimir Varbanov wrote:
> > Please take a look why we made it built-in first [1].
> > 
> > If arguments there are still valid I don't see why to make it a module
> > again.
> > 
> > [1] https://lkml.org/lkml/2016/8/24/694
> 
> It looks like there is a move to make all non-essential drivers buildable as
> modules. For example, the Kirin, dra7xx, Meson PCI controllers are now
> buildable as modules. So I think we can follow that and allow building the
> pcie-qcom as a module.

IIUC the arguments in [1] are that:

  - Kconfig is bool, so it can't be built as a module
  - there's no sensible use case for unbind

Those described the situation at the time, and there's no point in
having .remove() and using module_platform_driver() if Kconfig is
bool.

But they don't seem like arguments for why the driver couldn't be
*made* modular.

I think drivers *should* be modular unless there's a technical reason
they can't be.

Bjorn
