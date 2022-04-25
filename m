Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2A50EC1B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 00:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbiDYWcq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 18:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiDYWck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 18:32:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A910F436;
        Mon, 25 Apr 2022 15:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0ADAB81B37;
        Mon, 25 Apr 2022 22:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14699C385A4;
        Mon, 25 Apr 2022 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650925639;
        bh=6hRgImr6llDDd8ADnuWs22ukEUAVyyHPl4S78KYe+8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d2D+EkRFloeWlp5S/yEBFfUdJPU0zW0mMAeDkLRykkmoxanLeDYX0paJqYaxFvMoM
         /S7POGOyIIt3bpGJmUpA4lPGSNqwJALOX9iFyai2QQh7NdVKJ0mO2TwfjL7sspk57f
         RJXbcx9JwuHDhw0iP23k2JNZM8UP/R2JIwkS0F/L5uGc7YJlGXlFP5RneP0TR5VJkO
         +GFjYgs+YhIc/xpTyoJqUiuHvaRM5+6GlUbZgDpb2dQYJH+QSOuU31dsrgCOUZuk3t
         GuElB5Mg3crON18WeC4x7pmo3yzqvlVI1OMHQGaXrQ2H3PgE0Ws/9pY5wxlvIK72b6
         5nwFqiOwDpzwQ==
Date:   Mon, 25 Apr 2022 17:27:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI: dwc: Teach dwc core to parse additional MSI
 interrupts
Message-ID: <20220425222717.GA1663265@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06831174-6c69-6d7f-55da-d7b0b6d67efe@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 26, 2022 at 12:28:39AM +0300, Dmitry Baryshkov wrote:
> On 25/04/2022 04:50, Bjorn Helgaas wrote:
> > On Sat, Apr 23, 2022 at 04:39:36PM +0300, Dmitry Baryshkov wrote:
> > > DWC driver parses a single "msi" interrupt which gets fired when the EP
> > > sends an MSI interrupt, however for some devices (Qualcomm) devies MSI
> > > vectors are handled in groups of 32 vectors. Add support for parsing
> > > "split" MSI interrupts.
> > 
> > devies?  Maybe spurious?
> 
> Devices, of course :D

Well, it's not *quite* that simple.  "devices (Qualcomm) devices"
doesn't make sense either.
