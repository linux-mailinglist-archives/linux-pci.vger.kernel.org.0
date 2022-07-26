Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1FD581313
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiGZMVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiGZMVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 08:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E44E089;
        Tue, 26 Jul 2022 05:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 994C7614CD;
        Tue, 26 Jul 2022 12:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EDEC341C0;
        Tue, 26 Jul 2022 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658838063;
        bh=pE5UITYFOJK1aM9zJt47Xv+maxl5YHexBJ/7THKptew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ77mwR+7ZQRz64L1SmKEZUGhwVttDIy7XC5PNZpWiQIHbEp1acQJKRqsTfx9nq0N
         ZwOK6dCKUSU+zFUL2cs2UemJDzA+Fh01o/sDDlkBW7QbGEWLoYvgmNXSWrI7Re2nBb
         HFuG81gBfbThGjyYAHW7YNBgIColnDe4l/iENlTMQ2J2vNvNXW3apasRQQ5LTaktE8
         h/U9sIsS3hfm8UomR6F00rkZc1FG9rzBRS5awO15dM1CrzcMbElLALWNtpcc87ceKy
         bE1GFI1sQzc5gIOEhb5yhsb/+NJ0rX+g8j1x7FdkWL1pez9cm8+ifGxpKfFmSs3YMl
         LWhVjt0q+gS6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oGJYo-0001D3-Tz; Tue, 26 Jul 2022 14:21:14 +0200
Date:   Tue, 26 Jul 2022 14:21:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <Yt/cOnW6R9ONnFyW@hovoldconsulting.com>
References: <20220722154919.1826027-1-helgaas@kernel.org>
 <20220722154919.1826027-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722154919.1826027-2-helgaas@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 22, 2022 at 10:49:18AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pcie-qcom.c uses nothing from <linux/interrupt.h>, so remove the
> unnecessary include of it.

Appears to be unused since commit 7c5925afbc58 ("PCI: dwc: Move MSI IRQs
allocation to IRQ domains hierarchical API") so there may be other
driver that also no longer need it.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
