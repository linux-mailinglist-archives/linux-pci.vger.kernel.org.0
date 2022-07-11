Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97156FED3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 12:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiGKK0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiGKKZb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 06:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB865F69;
        Mon, 11 Jul 2022 02:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D72626091E;
        Mon, 11 Jul 2022 09:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B151C34115;
        Mon, 11 Jul 2022 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657532309;
        bh=a0ha78P3wXjA5uoUnAW93wgzH8yzlsNaKHmhJbbHDc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4k050iUWOLbbtPhqJa63hJsvwUrW4UfGC6MmyGT+iBvTJJR0QJ5bS5lrR9izvQWc
         jGD/AjfWcZp8a56MfaScFv5gjzJPk07xnkwXXTBcsYQEPiunNRaELhhJ0SHba1P1iP
         Ask33i5XfTAIK6YZeNvAU/YgOhnzjd32+kmVRtGarSDPCjfL25tmh+w+CEwAjeslvY
         D9MphIrh6Me/J4O/c3rhq3xVWuLSLmFZfrl4uQOJeBpi/XZxs7UEwt/g2Mx8A86QlP
         8zTsrPocOe/nijf/4ieHVtLn/6lxMEubtqssreF/xyyAHVS/OTC6Lwsp+OD+QERzzJ
         gtmSnliRhD5uA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oAps5-0006eD-QD; Mon, 11 Jul 2022 11:38:29 +0200
Date:   Mon, 11 Jul 2022 11:38:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: PCI: qcom: Add SA8540P to binding
Message-ID: <Ysvvlb/Wu2Vodane@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-6-johan+linaro@kernel.org>
 <20220709080203.GL5063@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709080203.GL5063@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 09, 2022 at 01:32:03PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 29, 2022 at 04:09:55PM +0200, Johan Hovold wrote:
> > SA8540P is a new platform related to SC8280XP but which uses a single
> > host interrupt for MSI routing.
> > 
> 
> The newer chipsets are supposed to use 8 MSI's. How come this one uses only 1?

No idea, but the people with access to the documentation could not find
more than one interrupt for SA8540P (unlike SC8280XP).

Johan
