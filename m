Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A43583390
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 21:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiG0T2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 15:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiG0T2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 15:28:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404F13DEB;
        Wed, 27 Jul 2022 12:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FCA7B82267;
        Wed, 27 Jul 2022 19:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AB5C433D7;
        Wed, 27 Jul 2022 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658950093;
        bh=Pkak1xmS/KS/lOCrf6Z7riQBx0qJzhip3ZEO4VloQaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y5mlaEEyBsAzs0vFdiDD9OrkSxt3CnArNYvAYKUZF4wkR1hvLnsSYS09duKikaka/
         +lhWgZUcHVU1AvSXa5kKbce0vWtTzwuLjSTCx93g3cGNwXNiBDWNgQSUZj1YHMLDCu
         CJgJ8oRvBLX8qlkriMtUFsESqfYv8Vf+z9orNQ/eNF+ntpJ9hXwf9cKCXjrmoX2ZgE
         rGyybK5Gag3+rpYXYQNw40ea+sueNbBgUhLQ2L6jTaSqxyAZgF7yEL0q1U0kfBwrr/
         M0JSLnJqA99FC/UplkOVcGDqtZwKVqoaGezAJz98YWdXo2YL25n8yzIqo3n4yZs13r
         X9Z61otK/ipng==
Date:   Wed, 27 Jul 2022 14:28:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Baruch Siach <baruch.siach@siklu.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI: qcom: Drop unnecessary <linux/interrupt.h>
 include
Message-ID: <20220727192811.GA218230@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/cOnW6R9ONnFyW@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 26, 2022 at 02:21:14PM +0200, Johan Hovold wrote:
> On Fri, Jul 22, 2022 at 10:49:18AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > pcie-qcom.c uses nothing from <linux/interrupt.h>, so remove the
> > unnecessary include of it.
> 
> Appears to be unused since commit 7c5925afbc58 ("PCI: dwc: Move MSI IRQs
> allocation to IRQ domains hierarchical API") so there may be other
> driver that also no longer need it.

Thanks for digging that out!  You're right, there's a long list of
drivers that include <linux/interrupt.h> but don't appear to need it.
I'm going to drop this patch and try to do them all at once.

> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
